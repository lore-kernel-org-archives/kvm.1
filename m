Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490E53B356;
	Wed, 23 Sep 2026 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172509; cv=none; b=BVkvlG4tzcdn/92KdUsfFX3JUMvJbDUIw19JmNLj14PuLW3eXoFxp1/zn/TMT8KVMO3awX3QSk7n1Hy14vGfj9wyTk103XdRG+R8h7uY1I3eTPuHvuHQUWx/HmA37kyUebLIkDOg6nH7GFunkxHGShlucUZdvwqG4SFNiP1ifpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172509; c=relaxed/simple;
	bh=5O1iNvD5LZz4Frajx2z4XVm4msCGXyHH9y70xf0mB50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGGUiX7ZDnv2uVEvsR9GAZXCyV95U/bm2mR4NrHAvf77YB0m+iSufnEeuaYLZvwlZe9kNYxHL797BlfPCJ7Iz1jimDvFU8gO7ZqLcu0JSd/KHRTqD3mDkP+iCmnvSuOLu1zdHquu0UL8JI5Qw1MdEVVk3KChtRU7WEa4aM3PnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743634|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00315548-0.000215038-0.99663;FP=16636718210716602107|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jL9oygM_1790172174;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jL9oygM_1790172174 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 22:02:54 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/8] KVM: nSVM: Track valid hardware DecodeAssist bytes
Date: Wed, 23 Sep 2026 22:02:28 +0800
Message-ID: <b29804794cc8802017b9e97c8132b46e2a64c572.1790171702.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1790171702.git.zhang_wei@open-hieco.net>
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
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

Invalidate VMCB02's instruction-byte state when preparing VMCB02,
normally in response to an emulated VMRUN.  Mark the bytes as valid only
when the current VMCB02 exit is a data #PF or #NPF.  Opcode exits and
instruction-fetch faults are excluded by inspecting the exit state.

A subsequent change will use this state when propagating hardware
DecodeAssist instruction bytes to VMCB12.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 38 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h    |  3 +++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 82c49a24dd75..a87b88d8eeac 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -35,6 +35,35 @@
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
+static void nested_svm_invalidate_insn_bytes(struct vmcb *vmcb)
+{
+	vmcb->control.insn_len = 0;
+}
+
+static bool nested_svm_vmexit_supports_insn_bytes(const struct vmcb *vmcb)
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
+static void nested_svm_set_vmcb02_insn_bytes_valid(struct vcpu_svm *svm)
+{
+	svm->nested.vmcb02_insn_bytes_valid =
+		cpu_feature_enabled(X86_FEATURE_DECODEASSISTS) &&
+		nested_svm_vmexit_supports_insn_bytes(svm->nested.vmcb02.ptr);
+}
+
+static void nested_svm_invalidate_vmcb02_insn_bytes(struct vcpu_svm *svm)
+{
+	nested_svm_invalidate_insn_bytes(svm->nested.vmcb02.ptr);
+	svm->nested.vmcb02_insn_bytes_valid = false;
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
@@ -68,6 +97,10 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
 	vmcb->control.exit_info_2 = fault->address;
 
+	if (from_hardware)
+		nested_svm_set_vmcb02_insn_bytes_valid(svm);
+	else
+		nested_svm_invalidate_vmcb02_insn_bytes(svm);
 	nested_svm_vmexit(svm);
 }
 
@@ -873,6 +906,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
 	 */
+	nested_svm_invalidate_vmcb02_insn_bytes(svm);
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1653,8 +1687,10 @@ int nested_svm_exit_handled(struct vcpu_svm *svm)
 
 	vmexit = nested_svm_intercept(svm);
 
-	if (vmexit == NESTED_EXIT_DONE)
+	if (vmexit == NESTED_EXIT_DONE) {
+		nested_svm_set_vmcb02_insn_bytes_valid(svm);
 		nested_svm_vmexit(svm);
+	}
 
 	return vmexit;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..1e12ef1105c0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -243,6 +243,9 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/* True if VMCB02 has instruction bytes for the current nested exit. */
+	bool vmcb02_insn_bytes_valid;
 };
 
 struct vcpu_sev_es_state {
-- 
2.43.7

