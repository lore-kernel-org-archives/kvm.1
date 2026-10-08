Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75075296BD2;
	Thu,  8 Oct 2026 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418490; cv=none; b=QZGdJPT97jaWZVcylCbUQXndZWusdL11orZgTIPMqoxqQ6b5/n/PkAyZ9d3226pYU/n7CGIat83HDgvfIGPrejDOPG38HcZ9NUe9H+VYh3rj+ScLw9Bjl3aK91tDbOOuXjZq0c0fXjACDrTZXR+/vtKetj7YfdVwsHT2upzmsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418490; c=relaxed/simple;
	bh=hMXRvzZrh2GnYZxVZwEEegBkN8YT+yojlDeWRXyzfMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaHk22rPkPUZWNQXtRkpArqcdFCJj6fH+pACKXt6Fe+kRUjuvTPTRg9D6IVMJ95x+4ZpcX9lGOhZbOv8nq3jH54LTy22Sk0PBv6DOEj2pjEWGP89hKjB78aQCb6/bGi1wM/L0MW7hV/02B1WtfbaRtw4eUEcyVZfmFlERuFFXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR5H/G5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR5H/G5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7C91F00893;
	Thu,  8 Oct 2026 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418488;
	bh=ZFHC23Nd1zkw+iyebIi9XYMBYXw7z6f9G4dRZnaR+kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR5H/G5u00qcPb7cXf5eJUGOsCVfdX/Q6B7IdgoLb6xP4xCLpS+vs/V341rNdyY1U
	 41itOEuKTcvdK1xzGEkw5wp8G2xBrI8ijtacN/0hiIB32ZIGVI48T+tA2EDMOs1RQ6
	 b2w7lQKT5eK0/TW6XcSlUFDRYGMB6N3QgjeUcKe12gOFZcvZa5hB71he1BnAkbYEra
	 AfjmehbyTTBNSbSkwRSSwciC22ndsnnODnupYp9JG1zuApbIYLTcQWzd+FU+Ehm/Hj
	 ugiRYubYTPl1II+7CHd3jYAdCSV2ZRgCWngbKE3IjmywEIFCgJVRhT4D53qyhHeCpY
	 tdrPNNz06OTxQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 19/29] KVM: nSVM: Service local TLB flushes before nested transitions
Date: Thu,  8 Oct 2026 00:14:15 +0000
Message-ID: <20261008001425.2458927-20-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Service pending TLB flushes for a specific context (L1 vs. L2) before
entering/leaving guest mode, as KVM does not track TLB flush requests
for L1 vs. L2. This is not currently required as KVM always flushes the
TLB on nested transitions, but it is a requirement to drop the
unconditional flushes.

TLB flushes are performed through the VMCB's TLB_CONTROL field, so
service the flushes before every VMCB switch (except the precautionary
switch in svm_free_nested()). Servicing flushes may end up purging the
relevant HV TLB flush FIFO, which is based on guest_mode, so make sure
local TLB flushes are handled before calling {enter/leave}_guest_mode().

This is conceptually similar to how nVMX calls
kvm_service_local_tlb_flush_requests(), except that the VMX calls only
have ordering requirements on {enter/leave}_guest_mode(), and not
switching the VMCS, because VPID used for TLB flushes depends on
guest_mode, and flushes are not VMCS-based.

Note that nested_svm_{entry/exit}_tlb_flush() must be called after
kvm_service_local_tlb_flush_requests(), otherwise the TLB flushes will
be immediately applied on the outgoing VMCB rather than the incoming
one.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index efe7a39b53656..e216818f68372 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1044,6 +1044,20 @@ static void nested_svm_copy_common_state(struct vmcb *from_vmcb, struct vmcb *to
 	to_vmcb->save.spec_ctrl = from_vmcb->save.spec_ctrl;
 }
 
+static void nested_svm_service_local_tlb_flushes(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * TLB flushes are applied to the VMCB, so apply any pending TLB flushes
+	 * on the outgoing VMCB before switching to a new one. A TLB flush could
+	 * purge the relevant HV TLB flush FIFO depending on guest_mode, so make
+	 * sure the VMCB and guest_mode context is consistent.
+	 */
+	WARN_ON_ONCE(is_guest_mode(vcpu) != (svm->vmcb == svm->nested.vmcb02.ptr));
+	kvm_service_local_tlb_flush_requests(vcpu);
+}
+
 int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1075,6 +1089,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
+	nested_svm_service_local_tlb_flushes(vcpu);
+
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm);
 	nested_vmcb02_prepare_save(svm);
@@ -1337,6 +1353,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
+	nested_svm_service_local_tlb_flushes(vcpu);
+
 	svm_switch_vmcb(svm, &svm->vmcb01);
 	leave_guest_mode(vcpu);
 	svm_pmu_handle_nested_transition(svm);
@@ -1549,6 +1567,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
+		nested_svm_service_local_tlb_flushes(vcpu);
+
 		svm_switch_vmcb(svm, &svm->vmcb01);
 		leave_guest_mode(vcpu);
 
@@ -2089,6 +2109,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
+	nested_svm_service_local_tlb_flushes(vcpu);
+
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 
 	if (use_separate_l2_pat)
-- 
2.56.0.360.g66cac248cb-goog

