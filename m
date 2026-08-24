Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F941D638;
	Mon, 24 Aug 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575261; cv=none; b=aX4jMNj6QxxubdJOT2xKeLx4S0666N9i1cuYz6dU5jorowV9yKiR1gLITwP/xXns8kzeQQ+We0OkjTYjcpFSiuVSfMTPqCywFI+23N/9RBTA2di9qzoODdiuc6DbNPSGkvgNesjzreNm1uqGLR6nqOxPk1RD3CtbzN6OwWbjVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575261; c=relaxed/simple;
	bh=Kw08plDE7St066BGYrJ3qnKS73qdi7HExWNjOvM/iSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khPVCu3Z+lKPzUAYA1xax6OQx7+sd8r3XwlariEjYK29CYzDMjhQ6FEeGDC83fnwMZQermF45HbtqtbM6dquiOW46zS+B4juiOH/JlSk+jDhcPz1CypX4iWih851Ue7jA0H6+wfLMpknJ/CIQVfGjvkbbrvwLiOdtVirLiVVDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436264|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0120011-0.00288252-0.985116;FP=17179378910432399098|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1ggzc_1787575228;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1ggzc_1787575228 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:29 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v5 3/8] KVM: nSVM: Track fresh hardware DecodeAssist bytes
Date: Mon, 24 Aug 2026 20:39:49 +0800
Message-ID: <20260824123954.315112-4-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824123954.315112-1-zhang_wei@open-hieco.net>
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMCB02 instruction bytes are valid only for the hardware VM-Exit that
populated them.  Track whether VMCB02 contains instruction bytes for the
data #PF or #NPF currently being reflected to L1 so that stale bytes are
not copied to VMCB12.

Clear the VMCB02 instruction-byte fields and freshness state before each
nested run.  Mark the bytes as fresh only when a data #PF or #NPF came
from hardware; KVM-synthesized exits and instruction-fetch faults leave
the state clear.

A subsequent change will use this state when propagating hardware
DecodeAssist instruction bytes to VMCB12.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 41 +++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.c    |  6 +++---
 arch/x86/kvm/svm/svm.h    |  5 ++++-
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..6770721d4e4c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -35,6 +35,38 @@
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
+static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
+{
+	vmcb->control.insn_len = 0;
+	memset(vmcb->control.insn_bytes, 0,
+	       sizeof(vmcb->control.insn_bytes));
+}
+
+static bool nested_svm_vmexit_has_insn_bytes(const struct vmcb *vmcb)
+{
+	u64 exit_code = vmcb->control.exit_code;
+
+	if (exit_code != SVM_EXIT_NPF &&
+	    exit_code != SVM_EXIT_EXCP_BASE + PF_VECTOR)
+		return false;
+
+	return !(vmcb->control.exit_info_1 & PFERR_FETCH_MASK);
+}
+
+static void nested_svm_set_vmcb02_insn_bytes_fresh(struct vcpu_svm *svm,
+						   bool from_hardware)
+{
+	svm->nested.vmcb02_insn_bytes_fresh =
+		from_hardware && static_cpu_has(X86_FEATURE_DECODEASSISTS) &&
+		nested_svm_vmexit_has_insn_bytes(svm->vmcb);
+}
+
+static void nested_svm_clear_vmcb02_insn_bytes(struct vcpu_svm *svm)
+{
+	nested_svm_clear_insn_bytes(svm->nested.vmcb02.ptr);
+	svm->nested.vmcb02_insn_bytes_fresh = false;
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
@@ -68,6 +100,7 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
 	vmcb->control.exit_info_2 = fault->address;
 
+	nested_svm_set_vmcb02_insn_bytes_fresh(svm, from_hardware);
 	nested_svm_vmexit(svm);
 }
 
@@ -868,7 +901,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
+	 * Clear stale DecodeAssist data before L2 runs.
 	 */
+	nested_svm_clear_vmcb02_insn_bytes(svm);
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1643,14 +1678,16 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
 	return vmexit;
 }
 
-int nested_svm_exit_handled(struct vcpu_svm *svm)
+int nested_svm_exit_handled(struct vcpu_svm *svm, bool from_hardware)
 {
 	int vmexit;
 
 	vmexit = nested_svm_intercept(svm);
 
-	if (vmexit == NESTED_EXIT_DONE)
+	if (vmexit == NESTED_EXIT_DONE) {
+		nested_svm_set_vmcb02_insn_bytes_fresh(svm, from_hardware);
 		nested_svm_vmexit(svm);
+	}
 
 	return vmexit;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c7c1f1527c3c..5426a9669053 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2571,7 +2571,7 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 
 	if (cr0 ^ val) {
 		svm->vmcb->control.exit_code = SVM_EXIT_CR0_SEL_WRITE;
-		ret = (nested_svm_exit_handled(svm) == NESTED_EXIT_DONE);
+		ret = (nested_svm_exit_handled(svm, false) == NESTED_EXIT_DONE);
 	}
 
 	return ret;
@@ -3723,7 +3723,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		vmexit = nested_svm_exit_special(svm);
 
 		if (vmexit == NESTED_EXIT_CONTINUE)
-			vmexit = nested_svm_exit_handled(svm);
+			vmexit = nested_svm_exit_handled(svm, true);
 
 		if (vmexit == NESTED_EXIT_DONE)
 			return 1;
@@ -4983,7 +4983,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
 	vmcb->control.exit_code = icpt_info.exit_code;
-	vmexit = nested_svm_exit_handled(svm);
+	vmexit = nested_svm_exit_handled(svm, false);
 
 	ret = (vmexit == NESTED_EXIT_DONE) ? X86EMUL_INTERCEPTED
 					   : X86EMUL_CONTINUE;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 66b44b54608e..610def16f700 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -242,6 +242,9 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/* True if VMCB02 has instruction bytes from the current hardware exit. */
+	bool vmcb02_insn_bytes_fresh;
 };
 
 struct vcpu_sev_es_state {
@@ -887,7 +890,7 @@ static inline void nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 	nested_svm_vmexit(svm);
 }
 
-int nested_svm_exit_handled(struct vcpu_svm *svm);
+int nested_svm_exit_handled(struct vcpu_svm *svm, bool from_hardware);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
 int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
-- 
2.43.7

