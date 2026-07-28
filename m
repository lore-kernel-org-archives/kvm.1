Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1A3382DA;
	Tue, 28 Jul 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198974; cv=none; b=WgXRXFvV7HweHlYRDk29I2d20fXSZ0seLdYvW6BVR+fY5G8HB7Vnn1hMBXVCS9vgCPy5AKk3awV0aKfb/CTf/mPs4SjIeQpalHAjrq8rIwmNVNtn9fcYRDGL6Ehv/Y/lExjclewAdPjNk2xuvq0NuS0ooU7004A7elCLuwn6nuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198974; c=relaxed/simple;
	bh=UZOTend9FCCYiMeY43IwoOOGOZOiU/u2FC5nOnXP1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY5GJCvGLOkZHD5u59qW0cNDZYeZewJWAhBsZqNg0OOcdTejFu/yyV+qLoca2qZivpboMGvfwnXQi34kBKGY8eFkNyJrGWYnMiPNJpF2FlBxkRbe+oPLu7XGSwno3MvIQJS/VBNtPUDUIV1JDRBI6JoaGIA52gec6zPyscztf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Weaakh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Weaakh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80881F000E9;
	Tue, 28 Jul 2026 00:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198973;
	bh=L6ZN1QdB08aCL0s10Lun9FPM70ISH8CSzat/k/0rMJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9WeaakhaaxVibBsOg6/c4GdAEu0GPMmqNx6DFGd+C/ZFc3ZHDJqhOf7liILFiDJh
	 Xl92t9ZXGrjDEy/WwEMG+HjoLs/nVbDFJk9XXdwAbhcnwr1IAs3CQ2eNgBT/XOEUGv
	 rHZdNFYQ4Ds+vHa2qVCn4DMzmJ4kHC5jPUmm8tdBMqHEqfJCuUnKXvz5yatMvQichq
	 8J95gzxrJks4RrtPbRcTV14G1IbUL5jY7TAe9FQxJ5h3zA34hLDM/FGuX1HOV265iX
	 /ytMlPJkKVoXBnOPYuCB8H5md8UeeN2+j7Sq3zY/YC/zVr0q2/WrB0aFrPsPRaV76P
	 qW81tJBTrO/KQ==
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
Subject: [PATCH v1 19/28] KVM: nSVM: Service local TLB flushes before nested transitions
Date: Tue, 28 Jul 2026 00:35:48 +0000
Message-ID: <20260728003557.1136583-20-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
index 57752ad37c2a2..c932cad1520ea 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1036,6 +1036,20 @@ static void nested_svm_copy_common_state(struct vmcb *from_vmcb, struct vmcb *to
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
@@ -1067,6 +1081,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
+	nested_svm_service_local_tlb_flushes(vcpu);
+
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm);
 	nested_vmcb02_prepare_save(svm);
@@ -1333,6 +1349,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
+	nested_svm_service_local_tlb_flushes(vcpu);
+
 	svm_switch_vmcb(svm, &svm->vmcb01);
 	leave_guest_mode(vcpu);
 	svm_pmu_handle_nested_transition(svm);
@@ -1543,6 +1561,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
+		nested_svm_service_local_tlb_flushes(vcpu);
+
 		svm_switch_vmcb(svm, &svm->vmcb01);
 		leave_guest_mode(vcpu);
 
@@ -2075,6 +2095,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
+	nested_svm_service_local_tlb_flushes(vcpu);
+
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 
 	if (use_separate_l2_pat)
-- 
2.55.0.229.g6434b31f56-goog

