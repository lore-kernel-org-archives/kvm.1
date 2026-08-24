Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com [47.90.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DC4119ED;
	Mon, 24 Aug 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575570; cv=none; b=Rz75SH9BNTC2xsg597KukibDaniroSNxHjxUYb/JEzac2kSMVHYC6RBABAS96BXlzQzcOBAHLCY9LOJGws0zS1DW+5aRNJQbGgM98yeUuArr44FD1Bb0y2luT9A7o4EY95GoyGCB5uz3g3jgPVfLP/tRZfQENz3fXuaEpKkqLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575570; c=relaxed/simple;
	bh=NbUXxaSExkfSwtv9zczV8ia4rzqoGBgHWA5soURC0fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=defVBMhesDdpx1wtj+nF8azdZDXNV3WrsydcByjEuFjhL+ZuYdR0NH2avnrNpCl3LVNcUkU7mcQEgmQ4wc1AoMdxjFvT+VhFdpW9dX8YhU9hJDvfN5bXrYoP2IRwuyAF/OCe3SJwX7eMdBe0OEOzn1COyeT1TRweGYjZuoD4IBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743627|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00334544-0.000799676-0.995855;FP=18368052134460067323|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1gh6p_1787575231;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1gh6p_1787575231 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:32 +0800
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
Subject: [PATCH v5 5/8] KVM: nSVM: Use emulator bytes for synthesized nested #NPF
Date: Mon, 24 Aug 2026 20:39:51 +0800
Message-ID: <20260824123954.315112-6-zhang_wei@open-hieco.net>
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

SVM DecodeAssists provides instruction bytes for data-access #NPF exits.
Hardware-reflected VM-Exits can use fresh VMCB02 bytes, but a
KVM-synthesized #NPF has no hardware byte state to propagate.

Use the emulator fetch cache when the nested #NPF is the current emulator
exception.  Store the bytes in a one-shot buffer that is consumed while
constructing VMCB12 and cleared before the next nested run, preventing an
unrelated nested VM-Exit from reusing stale emulator bytes.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 50 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h    | 12 ++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2db0ec66e8dc..635ff20cc431 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -81,11 +81,45 @@ static void nested_svm_clear_vmcb02_insn_bytes(struct vcpu_svm *svm)
 	svm->nested.vmcb02_insn_bytes_fresh = false;
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
 
@@ -93,11 +127,20 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 	    !nested_svm_vmexit_has_insn_bytes(vmcb02))
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
@@ -106,6 +149,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	bool from_emulation = ctxt && fault == &ctxt->exception;
 	u64 fault_stage;
 
 	/*
@@ -134,6 +179,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	vmcb->control.exit_info_2 = fault->address;
 
 	nested_svm_set_vmcb02_insn_bytes_fresh(svm, from_hardware);
+	if (from_emulation && !(fault->error_code & PFERR_FETCH_MASK))
+		nested_svm_prepare_synthesized_insn_bytes(vcpu);
 	nested_svm_vmexit(svm);
 }
 
@@ -937,6 +984,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * Clear stale DecodeAssist data before L2 runs.
 	 */
 	nested_svm_clear_vmcb02_insn_bytes(svm);
+	nested_svm_clear_synthesized_insn_bytes(svm);
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 610def16f700..9344707e9ffd 100644
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
@@ -245,6 +251,12 @@ struct svm_nested_state {
 
 	/* True if VMCB02 has instruction bytes from the current hardware exit. */
 	bool vmcb02_insn_bytes_fresh;
+
+	/*
+	 * Cached instruction bytes for the current synthesized nested #NPF.
+	 * Valid until the corresponding nested VM-Exit is constructed.
+	 */
+	struct nested_svm_insn_bytes synthesized_insn_bytes;
 };
 
 struct vcpu_sev_es_state {
-- 
2.43.7

