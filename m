Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D7364941;
	Wed, 19 Aug 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118719; cv=none; b=fXt6wLt4vPhcDT0OtWYA+tyH5P8YyIYhA6VfbjC6MA+HH2Ru/gvUwVCI9kbW8lWHDi8WPAl0C6iblr5mKFwvkKk3T9GC5qBk8wBCRFiL/XLQFkXbZifZrpL++QfpbomNuG0DsO3VFk5wEbvsuIrrVXnFzxsymVoyW0SQYYK2G+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118719; c=relaxed/simple;
	bh=jPoOyYRYUUQrR3sq/fQmpgtGkjVyRalRiCFS884j56c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S30FPezXPB84XvLczlEk+YvLL1H6lDfmoKhlSVGwmIixRatFMxspvPRjTFWmys+kquC9IOfBz/GdZSDHvIvFQS9epjyrZtjDuTMU7qeDUe0OYeNrsSt1adWgDtGHiW/hSoVbJskL/mr3RJN45Rs+oUYWeqmDnGHUzyHmWMRiXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00161099-0.000309786-0.998079;FP=18366363251442912506|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ir-3Hh2_1787118711;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ir-3Hh2_1787118711 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 13:51:51 +0800
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
Subject: [PATCH v4 6/9] KVM: nSVM: Use emulator bytes for synthesized nested #NPF/#PF
Date: Wed, 19 Aug 2026 13:51:21 +0800
Message-ID: <4fbed004f51c074acea2df6e3e97c254106928f5.1787116250.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SVM DecodeAssists provides instruction bytes for data-access #NPF and
intercepted #PF exits. Hardware-reflected VM-Exits can use fresh VMCB02
bytes, but KVM-synthesized exits have no hardware byte state to propagate.

For a synthesized nested #NPF, use the emulator fetch cache only when the
fault is the current emulator exception. For a synthesized intercepted #PF,
require the queued exception VM-Exit to carry the same emulator provenance.

Store the bytes in a one-shot buffer that is consumed while constructing
VMCB12 and cleared before the next nested run. This prevents unrelated
nested VM-Exits from reusing stale emulator bytes.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 54 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h    | 12 +++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d34370b84d5b..a38f99404943 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -71,22 +71,65 @@ static bool nested_svm_vmexit_supports_insn_bytes(struct kvm_vcpu *vcpu,
 	return !(vmcb02->control.exit_info_1 & PFERR_FETCH_MASK);
 }
 
+static void nested_svm_clear_synthesized_insn_bytes(struct vcpu_svm *svm)
+{
+	svm->nested.synthesized_insn_bytes.prepared = false;
+	svm->nested.synthesized_insn_bytes.insn_len = 0;
+}
+
+static void nested_svm_prepare_synthesized_insn_bytes(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct nested_svm_insn_bytes *synthesized =
+		&svm->nested.synthesized_insn_bytes;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+
+	static_assert(sizeof(synthesized->insn_bytes) >=
+		      sizeof(ctxt->fetch.data));
+
+	nested_svm_clear_synthesized_insn_bytes(svm);
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		return;
+
+	if (!ctxt || ctxt->eip != kvm_rip_read(vcpu) ||
+	    ctxt->fetch.end < ctxt->fetch.data ||
+	    ctxt->fetch.end > ctxt->fetch.data + sizeof(ctxt->fetch.data))
+		return;
+
+	synthesized->insn_len = ctxt->fetch.end - ctxt->fetch.data;
+	memcpy(synthesized->insn_bytes, ctxt->fetch.data,
+	       synthesized->insn_len);
+	synthesized->prepared = true;
+}
+
 static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 						struct vmcb *vmcb12,
 						const struct vmcb *vmcb02)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct nested_svm_insn_bytes *synthesized =
+		&svm->nested.synthesized_insn_bytes;
 
 	nested_svm_clear_insn_bytes(vmcb12);
 
 	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb02))
 		goto out;
 
-	if (svm->nested.vmcb02_insn_bytes_fresh)
+	if (svm->nested.vmcb02_insn_bytes_fresh) {
 		nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+		goto out;
+	}
+
+	if (synthesized->prepared) {
+		vmcb12->control.insn_len = synthesized->insn_len;
+		memcpy(vmcb12->control.insn_bytes, synthesized->insn_bytes,
+		       vmcb12->control.insn_len);
+	}
 
 out:
 	svm->nested.vmcb02_insn_bytes_fresh = false;
+	nested_svm_clear_synthesized_insn_bytes(svm);
 }
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
@@ -95,6 +138,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	bool from_emulation = ctxt && fault == &ctxt->exception;
 	u64 fault_stage;
 
 	/*
@@ -123,6 +168,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	vmcb->control.exit_info_2 = fault->address;
 
 	svm->nested.vmcb02_insn_bytes_fresh = from_hardware;
+	if (from_emulation && !(fault->error_code & PFERR_FETCH_MASK))
+		nested_svm_prepare_synthesized_insn_bytes(vcpu);
 	nested_svm_vmexit(svm);
 }
 
@@ -927,6 +974,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 */
 	nested_svm_clear_insn_bytes(vmcb02);
 	svm->nested.vmcb02_insn_bytes_fresh = false;
+	nested_svm_clear_synthesized_insn_bytes(svm);
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1760,6 +1808,10 @@ static void nested_svm_inject_exception_vmexit(struct kvm_vcpu *vcpu)
 			vmcb->control.exit_info_2 = ex->payload;
 		else
 			vmcb->control.exit_info_2 = vcpu->arch.cr2;
+
+		if (ex->has_emulator_context &&
+		    (!ex->has_error_code || !(ex->error_code & PFERR_FETCH_MASK)))
+			nested_svm_prepare_synthesized_insn_bytes(vcpu);
 	} else if (ex->vector == DB_VECTOR) {
 		/* See kvm_check_and_inject_events().  */
 		kvm_deliver_exception_payload(vcpu, ex);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b201bac227ad..51dc60b9c1d4 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -209,6 +209,12 @@ struct vmcb_ctrl_area_cached {
 	};
 };
 
+struct nested_svm_insn_bytes {
+	bool prepared;
+	u8 insn_len;
+	u8 insn_bytes[X86_MAX_INSTRUCTION_LENGTH];
+};
+
 struct svm_nested_state {
 	struct kvm_vmcb_info vmcb02;
 	u64 hsave_msr;
@@ -248,6 +254,12 @@ struct svm_nested_state {
 	 * hardware VM-Exit currently being reflected to L1.
 	 */
 	bool vmcb02_insn_bytes_fresh;
+
+	/*
+	 * Emulator fetch bytes captured for a synthesized nested #NPF/#PF.  The
+	 * buffer is consumed and cleared when constructing VMCB12.
+	 */
+	struct nested_svm_insn_bytes synthesized_insn_bytes;
 };
 
 struct vcpu_sev_es_state {
-- 
2.43.7

