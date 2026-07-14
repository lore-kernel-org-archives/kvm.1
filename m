Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C530C366;
	Tue, 14 Jul 2026 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006168; cv=none; b=SVnaw5OfTZw5U0jEZTNgwiz8zu63480pUQMld9IlL+FEHXKrBBSxZlqVelus9Fuw9wbi6opmRCiXx0PVGOJ9azP8kVhWKI2jIeX1eXj2QQCepa4Jg7zaAnN1a+Qer/CuptFq/MRnAMyLgW8miqAJ9kKh4AdWrebTdjjDdIJ8PmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006168; c=relaxed/simple;
	bh=8/aeiul7ytSuPSONOJ3OYEypaAEzsL7B+p5izsk250E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDZXxfUharnLFVbc67pBTQk4m+kAzBEFOjSofESuLAxpd0K3iZFQSc2Om3ttPubHemBYVMq/CfKchU6OshluoWslAN5HsRB5TwYPsm0tRj7JyFRkhyQzSOtpoUWRD8y6kJgryIYVwcvn+0i66OZL5t8aVFAoMIGvGfwlPF5KoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436476|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0066315-0.00233629-0.991032;FP=14769882741064011514|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOCZM_1784005836;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOCZM_1784005836 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:36 +0800
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
Subject: [PATCH v2 3/8] KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes
Date: Tue, 14 Jul 2026 13:09:59 +0800
Message-ID: <e07b2a62d7dedf6bcddc16076cf2892e83db977b.1783999988.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only hardware VM-Exits provide fresh DecodeAssist instruction bytes in
VMCB02.  KVM-synthesized nested VM-Exits must not reuse whatever bytes
were left by an earlier hardware exit.

Track whether VMCB02 contains DecodeAssist instruction bytes from the
hardware VM-Exit currently being reflected to L1, and clear the fields
before each nested run so stale bytes cannot be mistaken for fresh
hardware state.

The flag is consumed by a later change that propagates hardware-provided
DecodeAssist bytes to VMCB12.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 20 +++++++++++++++++---
 arch/x86/kvm/svm/svm.c    |  6 +++---
 arch/x86/kvm/svm/svm.h    |  9 ++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b340dc9991ad..70e2ee3af78b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -33,13 +33,21 @@
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
+static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
+{
+	vmcb->control.insn_len = 0;
+	memset(vmcb->control.insn_bytes, 0,
+	       sizeof(vmcb->control.insn_bytes));
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
+	bool from_hardware = vmcb->control.exit_code == SVM_EXIT_NPF;
 
-	if (vmcb->control.exit_code != SVM_EXIT_NPF) {
+	if (!from_hardware) {
 		/*
 		 * TODO: track the cause of the nested page fault, and
 		 * correctly fill in the high bits of exit_info_1.
@@ -52,6 +60,7 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	vmcb->control.exit_info_1 &= ~0xffffffffULL;
 	vmcb->control.exit_info_1 |= fault->error_code;
 
+	svm->nested.vmcb02_insn_bytes_fresh = from_hardware;
 	nested_svm_vmexit(svm);
 }
 
@@ -838,7 +847,10 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
+	 * Clear stale DecodeAssist data before L2 runs.
 	 */
+	nested_svm_clear_insn_bytes(vmcb02);
+	svm->nested.vmcb02_insn_bytes_fresh = false;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1587,14 +1599,16 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
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
index cc35afb59623..2c04a8d9da29 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2544,7 +2544,7 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 
 	if (cr0 ^ val) {
 		svm->vmcb->control.exit_code = SVM_EXIT_CR0_SEL_WRITE;
-		ret = (nested_svm_exit_handled(svm) == NESTED_EXIT_DONE);
+		ret = (nested_svm_exit_handled(svm, false) == NESTED_EXIT_DONE);
 	}
 
 	return ret;
@@ -3671,7 +3671,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		vmexit = nested_svm_exit_special(svm);
 
 		if (vmexit == NESTED_EXIT_CONTINUE)
-			vmexit = nested_svm_exit_handled(svm);
+			vmexit = nested_svm_exit_handled(svm, true);
 
 		if (vmexit == NESTED_EXIT_DONE)
 			return 1;
@@ -4927,7 +4927,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
 	vmcb->control.exit_code = icpt_info.exit_code;
-	vmexit = nested_svm_exit_handled(svm);
+	vmexit = nested_svm_exit_handled(svm, false);
 
 	ret = (vmexit == NESTED_EXIT_DONE) ? X86EMUL_INTERCEPTED
 					   : X86EMUL_CONTINUE;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5137416be593..fa65f6a1a59b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -238,6 +238,13 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/*
+	 * True if VMCB02's DecodeAssist instruction bytes belong to the hardware
+	 * VM-Exit currently being reflected to L1.  KVM-synthesized exits leave
+	 * it clear.
+	 */
+	bool vmcb02_insn_bytes_fresh;
 };
 
 struct vcpu_sev_es_state {
@@ -864,7 +871,7 @@ static inline void nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 	nested_svm_vmexit(svm);
 }
 
-int nested_svm_exit_handled(struct vcpu_svm *svm);
+int nested_svm_exit_handled(struct vcpu_svm *svm, bool vmcb02_insn_bytes_fresh);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
 int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
-- 
2.43.7

