Received: from out198-28.us.a.mail.aliyun.com (out198-28.us.a.mail.aliyun.com [47.90.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68B2F1FDE;
	Tue, 14 Jul 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005862; cv=none; b=UWlPN2wylvkJab2FF3SNy54d5IVzP8WNPnOwvUTsNwhMyQ/xo6cZIGf/Pt7fyMLVNN+aIcbNQfMxPY3XOp975A/e1pi04j3N9/Ro38MGLQQMjRN5UMjyxn0tqSdnQ5jtzBPsxV+2mgUbLIRDY0Ngl45158yxjNtYinE9DDLeZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005862; c=relaxed/simple;
	bh=31ioZjMW5Mxl9hif23064/Z1GgpF2XRJdIgBJY2lNQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5vbMPqOBOMuwMW4aiTpmWGzaySMp0oyf6rkq/NuDu9aGL/FUMme7eSPu1WCtppJDBetylvK/6x31P9VWiakBnks0wzFKVDO1yoxIQRuSavtecHCXWpvIyavn93SwQWf5/b4rW4ta+Qhd7OXaicts9eRU83b31DF5bI9RLgeQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00280468-0.000381889-0.996813;FP=18330615963761446395|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOCbB_1784005837;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOCbB_1784005837 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:38 +0800
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
Subject: [PATCH v2 5/8] KVM: nSVM: Use emulator bytes for synthesized nested #NPF/#PF
Date: Tue, 14 Jul 2026 13:10:01 +0800
Message-ID: <a8b7d7324735c2eff0f3d7f502e422edd47fe634.1783999988.git.zhang_wei@open-hieco.net>
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

SVM DecodeAssists records up to 15 instruction bytes from L2 CS:RIP
for data-access #NPF and intercepted #PF exits.  For nested VM-Exits
reflected directly from hardware, KVM can copy the fresh VMCB02
DecodeAssist bytes into VMCB12.  KVM-synthesized #NPF/#PF exits,
however, do not have fresh hardware DecodeAssist bytes in VMCB02.

When KVM synthesizes a nested #NPF/#PF from emulator context and the
emulator fetch cache still matches L2 RIP, populate a synthesized
instruction-byte buffer from those already-fetched bytes and copy them
into VMCB12 when constructing the nested VM-Exit for L1.

Consume the synthesized buffer exactly once and clear it before each
nested run, so stale emulator bytes cannot leak into unrelated nested
VM-Exits.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 56 +++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h    | 15 ++++++++++-
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9e12eab7eed9..8cee9aeaf4f2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -69,26 +69,72 @@ static bool nested_svm_vmexit_supports_insn_bytes(struct kvm_vcpu *vcpu,
 	return !(vmcb12->control.exit_info_1 & PFERR_FETCH_MASK);
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
+	struct nested_svm_insn_bytes *insn_bytes =
+		&svm->nested.synthesized_insn_bytes;
+	const u8 max_bytes = sizeof(insn_bytes->insn_bytes);
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+
+	nested_svm_clear_synthesized_insn_bytes(svm);
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		return;
+
+	if (!ctxt || ctxt->eip != kvm_rip_read(vcpu) ||
+	    ctxt->fetch.end < ctxt->fetch.data ||
+	    ctxt->fetch.end > ctxt->fetch.data + max_bytes)
+		return;
+
+	insn_bytes->insn_len = ctxt->fetch.end - ctxt->fetch.data;
+	memcpy(insn_bytes->insn_bytes, ctxt->fetch.data,
+	       insn_bytes->insn_len);
+	insn_bytes->prepared = true;
+}
+
 /*
  * Rebuild VMCB12's DecodeAssist bytes for the nested VM-Exit.  Use fresh
- * hardware VMCB02 state when available; otherwise report a zero byte count.
+ * hardware VMCB02 state when available; otherwise use synthesized bytes from
+ * the emulator fetch cache for KVM-generated #NPF/#PF exits.
  */
 static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 						struct vmcb *vmcb12,
 						struct vmcb *vmcb02)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct nested_svm_insn_bytes *insn_bytes =
+		&svm->nested.synthesized_insn_bytes;
+	const u8 max_bytes = sizeof(vmcb12->control.insn_bytes);
 	bool vmcb02_insn_bytes_fresh = svm->nested.vmcb02_insn_bytes_fresh;
+	bool synthesized_prepared = insn_bytes->prepared;
+	u8 synthesized_len = insn_bytes->insn_len;
 
 	svm->nested.vmcb02_insn_bytes_fresh = false;
+	insn_bytes->prepared = false;
 
 	nested_svm_clear_insn_bytes(vmcb12);
 
 	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb12))
 		return;
 
-	if (vmcb02_insn_bytes_fresh)
+	if (vmcb02_insn_bytes_fresh) {
 		nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+		return;
+	}
+
+	if (synthesized_prepared) {
+		vmcb12->control.insn_len = min(synthesized_len, max_bytes);
+		memcpy(vmcb12->control.insn_bytes, insn_bytes->insn_bytes,
+		       vmcb12->control.insn_len);
+		return;
+	}
 }
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
@@ -112,6 +158,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	vmcb->control.exit_info_1 |= fault->error_code;
 
 	svm->nested.vmcb02_insn_bytes_fresh = from_hardware;
+	if (!from_hardware && !(fault->error_code & PFERR_FETCH_MASK))
+		nested_svm_prepare_synthesized_insn_bytes(vcpu);
 	nested_svm_vmexit(svm);
 }
 
@@ -902,6 +950,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 */
 	nested_svm_clear_insn_bytes(vmcb02);
 	svm->nested.vmcb02_insn_bytes_fresh = false;
+	nested_svm_clear_synthesized_insn_bytes(svm);
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1709,6 +1758,9 @@ static void nested_svm_inject_exception_vmexit(struct kvm_vcpu *vcpu)
 			vmcb->control.exit_info_2 = ex->payload;
 		else
 			vmcb->control.exit_info_2 = vcpu->arch.cr2;
+
+		if (!ex->has_error_code || !(ex->error_code & PFERR_FETCH_MASK))
+			nested_svm_prepare_synthesized_insn_bytes(vcpu);
 	} else if (ex->vector == DB_VECTOR) {
 		/* See kvm_check_and_inject_events().  */
 		kvm_deliver_exception_payload(vcpu, ex);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index fa65f6a1a59b..ef7701ddaea0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -205,6 +205,12 @@ struct vmcb_ctrl_area_cached {
 	};
 };
 
+struct nested_svm_insn_bytes {
+	bool prepared;
+	u8 insn_len;
+	u8 insn_bytes[15];
+};
+
 struct svm_nested_state {
 	struct kvm_vmcb_info vmcb02;
 	u64 hsave_msr;
@@ -242,9 +248,16 @@ struct svm_nested_state {
 	/*
 	 * True if VMCB02's DecodeAssist instruction bytes belong to the hardware
 	 * VM-Exit currently being reflected to L1.  KVM-synthesized exits leave
-	 * it clear.
+	 * it clear, in which case the #NPF/#PF instruction bytes are synthesized
+	 * from the emulator fetch cache when possible.
 	 */
 	bool vmcb02_insn_bytes_fresh;
+
+	/*
+	 * DecodeAssist instruction bytes for a KVM-synthesized nested #NPF/#PF.
+	 * Populated from the emulator's fetch cache when possible.
+	 */
+	struct nested_svm_insn_bytes synthesized_insn_bytes;
 };
 
 struct vcpu_sev_es_state {
-- 
2.43.7

