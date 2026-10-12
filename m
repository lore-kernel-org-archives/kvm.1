Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DB3EDE78;
	Mon, 12 Oct 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848217; cv=none; b=lLPawChtS1U7y13H/LTqPWnmyy6k3vCQTrF8rpI+Dnze9m8lJ15rvVdMOOGPLZeYgACWMnQvzw8z5ZAzm+V4jynSFTiB6hbAE9/ZjmocA9VWVVlkCvh8kuRZMRuuGk15QkQanT+p28pYpJcdsZImgGVxCv3vjeFYXa8zx/J9ANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848217; c=relaxed/simple;
	bh=2OoorrjzwdKX/wpptUPJ4j5RFbee5efl17EUsp/jHb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZpsFYCleYg+C2Y7gyf6YMrRYaKGNa2vu6kEwwMyljYdJMmyhbGHD27M6432yyHrb5RoxN8tu1yOOzVX0m7ExpFvfsbqgu02mCnRRlS4YuATFp2gIBzJeoo6CH8Exua2aCbQ5D9PZKn4/YUmNm4pL6zfV3AZQ5bC5r5xGwv3YJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ3JR0Dg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ3JR0Dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471751F008A4;
	Mon, 12 Oct 2026 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848215;
	bh=4xUcXsk8IG7llTl1qXrzu/IpXn3zBoFWpqvkRB7LlEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQ3JR0Dg1ACuB3g2X7fkISqayzM6iiSr9qbM0nUIDdASzacl4GzeXJpLBju9LvsvR
	 fa7hiuUM0tIVwtVVczzMAjpnFWBV0d577JWpgKhYFGHGlTztIlc4lFQ1xZ09fIuZHN
	 G+19T6ABgI3bO6q3bkpetBb4dBAX/ZqBqf7f4w6M73n0RaFz5EyacRKLU7y5jFH5l8
	 pw+YNSXZg8NrLgHHhjTEfvQ0OtVYTeDlNcZs8GVVUP42T1lh8rya2KLquFTrua34cI
	 NByqenQ4vHmE7Hu1Pbq+MitgbkdN2M80QPOkZTv3jfryRmNZBf64VRipYW5EbmudEx
	 dzoXUzhGbhu8g==
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
Subject: [PATCH v3 19/27] KVM: nSVM: Service local TLB flushes before nested transitions
Date: Mon, 12 Oct 2026 23:36:30 +0000
Message-ID: <20261012233638.2546339-20-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

