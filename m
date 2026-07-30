Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37E4052C3;
	Thu, 30 Jul 2026 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413331; cv=none; b=aCIEqVjdCb/MJvzBv/pq7QU5DND+PY3dzS6x+CJLK3nMGEP/wT4scmB1H20WnFDv+Eio6nH9v0tizYR8BFBkGi3h3mCcKVuYgFwvDLuBmWr1//Yq+c6D2IWCKLmrg1ew/RXZzxpFP2WH64HFJH0u/fb8yyBusoqZIlH2wN84yLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413331; c=relaxed/simple;
	bh=TCbqQmFP8Ff26yFZXEYhcEkaarU/geUgrlW/hMyZuHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jx1s/CddrKx6q1pWJ34e83YDUHsY2KYIY1fLPI98wM7RC/Kja9NSRwLaj+QqFt+Cm2c4POyjk21fRWuvfJ0zQI2mJFQrUp9iVoLwd4Nr+AtmW5B8CfDmJocdupq0AbfcwXnAmmNoUrdXWJPz9A0RilcTDCTsWBLZ9nCtRlDFqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00606102-0.00215644-0.991783;FP=14905061098614631614|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrsa_1785413318;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrsa_1785413318 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 20:08:38 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 3/9] KVM: nSVM: Track hardware-provided instruction bytes
Date: Thu, 30 Jul 2026 20:08:06 +0800
Message-ID: <0d1e1110881aada32e474c74105f3d4cc5ba991e.1785411877.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DecodeAssists provides instruction bytes for nested page faults and
intercepted page faults caused by data accesses.  When reflecting such an
exit to L1, KVM needs to distinguish bytes produced by the current hardware
VM-Exit from stale VMCB02 state.

Clear the VMCB02 instruction-byte fields before each nested run and track
whether the nested VM-Exit being reflected originated from hardware.
Preserve that state when a hardware #PF is processed by KVM and then
reflected to L1.

A subsequent change will use this state to propagate hardware-provided
instruction bytes to VMCB12.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 17 +++++++++++++++--
 arch/x86/kvm/svm/svm.c    | 22 ++++++++++++++--------
 arch/x86/kvm/svm/svm.h    |  8 +++++++-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5e3e280cd483..ce059d3a1322 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -35,6 +35,13 @@
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
+static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
+{
+	vmcb->control.insn_len = 0;
+	memset(vmcb->control.insn_bytes, 0,
+	       sizeof(vmcb->control.insn_bytes));
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
@@ -68,6 +75,7 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
 	vmcb->control.exit_info_2 = fault->address;
 
+	svm->nested.vmcb02_insn_bytes_fresh = from_hardware;
 	nested_svm_vmexit(svm);
 }
 
@@ -868,7 +876,10 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
+	 * Clear stale DecodeAssist data before L2 runs.
 	 */
+	nested_svm_clear_insn_bytes(vmcb02);
+	svm->nested.vmcb02_insn_bytes_fresh = false;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1647,14 +1658,16 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
 	return vmexit;
 }
 
-int nested_svm_exit_handled(struct vcpu_svm *svm)
+int nested_svm_exit_handled(struct vcpu_svm *svm, bool vmcb02_insn_bytes_fresh)
 {
 	int vmexit;
 
 	vmexit = nested_svm_intercept(svm);
 
-	if (vmexit == NESTED_EXIT_DONE)
+	if (vmexit == NESTED_EXIT_DONE) {
+		svm->nested.vmcb02_insn_bytes_fresh = vmcb02_insn_bytes_fresh;
 		nested_svm_vmexit(svm);
+	}
 
 	return vmexit;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b63234a2feb8..6e2ceb700567 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1953,14 +1953,20 @@ static void svm_set_dr7(struct kvm_vcpu *vcpu, unsigned long value)
 static int pf_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-
 	u64 fault_address = svm->vmcb->control.exit_info_2;
 	u64 error_code = svm->vmcb->control.exit_info_1;
+	int r;
+
+	r = kvm_handle_page_fault(vcpu, error_code, fault_address,
+				  static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
+				  svm->vmcb->control.insn_bytes : NULL,
+				  svm->vmcb->control.insn_len);
 
-	return kvm_handle_page_fault(vcpu, error_code, fault_address,
-			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
-			svm->vmcb->control.insn_bytes : NULL,
-			svm->vmcb->control.insn_len);
+	if (is_guest_mode(vcpu) && vcpu->arch.exception_vmexit.pending &&
+	    vcpu->arch.exception_vmexit.vector == PF_VECTOR)
+		svm->nested.vmcb02_insn_bytes_fresh = true;
+
+	return r;
 }
 
 static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
@@ -2573,7 +2579,7 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 
 	if (cr0 ^ val) {
 		svm->vmcb->control.exit_code = SVM_EXIT_CR0_SEL_WRITE;
-		ret = (nested_svm_exit_handled(svm) == NESTED_EXIT_DONE);
+		ret = (nested_svm_exit_handled(svm, false) == NESTED_EXIT_DONE);
 	}
 
 	return ret;
@@ -3725,7 +3731,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		vmexit = nested_svm_exit_special(svm);
 
 		if (vmexit == NESTED_EXIT_CONTINUE)
-			vmexit = nested_svm_exit_handled(svm);
+			vmexit = nested_svm_exit_handled(svm, true);
 
 		if (vmexit == NESTED_EXIT_DONE)
 			return 1;
@@ -4995,7 +5001,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
 	vmcb->control.exit_code = icpt_info.exit_code;
-	vmexit = nested_svm_exit_handled(svm);
+	vmexit = nested_svm_exit_handled(svm, false);
 
 	ret = (vmexit == NESTED_EXIT_DONE) ? X86EMUL_INTERCEPTED
 					   : X86EMUL_CONTINUE;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a327bf751ecd..96d2471a03c8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -242,6 +242,12 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/*
+	 * True if VMCB02 contains DecodeAssist instruction bytes from the
+	 * hardware VM-Exit currently being reflected to L1.
+	 */
+	bool vmcb02_insn_bytes_fresh;
 };
 
 struct vcpu_sev_es_state {
@@ -887,7 +893,7 @@ static inline void nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 	nested_svm_vmexit(svm);
 }
 
-int nested_svm_exit_handled(struct vcpu_svm *svm);
+int nested_svm_exit_handled(struct vcpu_svm *svm, bool vmcb02_insn_bytes_fresh);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
 int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
-- 
2.43.7

