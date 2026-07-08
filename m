Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337B3D75D7;
	Wed,  8 Jul 2026 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492476; cv=none; b=GHbviBFRtug6fpbn5dC2oQ8hGJ+kKNDgcv+GFRRnXgatx73i+FyE/hmjZxiifpUuXT7XKb6nXWqbc5k5slVFkhfK6XCTsFm2WDKr5RnmYqj9xhQAW//gBEojkd5W4jlhPRXNNW+bGW47uDN7/K+jF7gVwjSGbn+eFT5tzW36Uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492476; c=relaxed/simple;
	bh=8lZd4CCjUjvNYDsP9sMWAJCW0RinFibyttTCLb2Y+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPm1jD6RE1fC+wUzIa5416G26hKHhQATNufBfGXe+NcV+EvKlXMus4vHXBM5WbxK4AFETfjHHrg0Ztd2inTWua9Q6zXptnOpqbeIL9ACpVmg1VZTcHMfROH1lKgPs21cXikmzo3E4A38xyvle4KYhebtl497MRC7Otg8Y/SeqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ABlD0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ABlD0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4171F000E9;
	Wed,  8 Jul 2026 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492474;
	bh=qvQrbid4hmTHwS3V3MaqWK7oFvcsTSypVDeJSn8+SMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6ABlD0T0MOXMJb+hm/xxTgB2PgMJ29kackMYZESXAaDb+6LDO2GAiQNAXJvMR0J7
	 a41zhRTvUFCwZsDGIWRVhFv+Hj7sL3FfqDChacHVcPQZxQtXbigPFPy3RMjimuWHjT
	 oLWgkDLKuD+jvFKqJME0KfpIx7aEu8SVyDONVbUFjen1nX2486V3toCqC+rNuLld1X
	 f9sk4gFNWOhE1eATzdA7EToiA6rxdQCG0/Za7LDX19ok3imUAqgQ80MGgvVvwMD+rh
	 ldmY1odzUJLKoqN16kOCht7zuC5MMD+jW//INOjOi9i4udGa5/BwxiVoh5ix4MuaKw
	 EQDg9PSFl5VYA==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 18/27] KVM: x86: Add a new kvm_x86_op protected_apic_has_injectable_intr()
Date: Wed,  8 Jul 2026 12:02:16 +0530
Message-ID: <bf3be4319f6f7a5d47d011367f88004c2fdeeb93.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secure AVIC does not support posted interrupts (unlike TDX) but requires
interrupts to be injected through the VMCB. To address this, introduce a
new kvm_x86_op protected_apic_has_injectable_intr() and update
kvm_cpu_has_injectable_intr() to use this if the guest APIC is
protected.

Finally, update kvm_check_and_inject_events() to ignore
kvm_cpu_get_interrupt() for a protected APIC guest. For such guests (and
at least in the case of Secure AVIC), KVM has no visibility into IRQ
windows and all pending vectors can be injected at once.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/include/asm/kvm-x86-ops.h | 1 +
 arch/x86/include/asm/kvm_host.h    | 1 +
 arch/x86/kvm/irq.c                 | 3 +++
 arch/x86/kvm/x86.c                 | 6 +++++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b..f042af63229b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -116,6 +116,7 @@ KVM_X86_OP_OPTIONAL(apicv_pre_state_restore)
 KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
 KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
 KVM_X86_OP_OPTIONAL(protected_apic_has_interrupt)
+KVM_X86_OP_OPTIONAL_RET0(protected_apic_has_injectable_intr)
 KVM_X86_OP_OPTIONAL(set_hv_timer)
 KVM_X86_OP_OPTIONAL(cancel_hv_timer)
 KVM_X86_OP(setup_mce)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cabb368b7908..31d1fc699e7e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1861,6 +1861,7 @@ struct kvm_x86_ops {
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
 	bool (*dy_apicv_has_pending_interrupt)(struct kvm_vcpu *vcpu);
 	bool (*protected_apic_has_interrupt)(struct kvm_vcpu *vcpu);
+	bool (*protected_apic_has_injectable_intr)(struct kvm_vcpu *vcpu);
 
 	int (*set_hv_timer)(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 			    bool *expired);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index dd776449731f..3f8c4bf834f0 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -98,6 +98,9 @@ int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v)
 	if (kvm_cpu_has_extint(v))
 		return 1;
 
+	if (lapic_in_kernel(v) && v->arch.apic->guest_apic_protected)
+		return kvm_x86_call(protected_apic_has_injectable_intr)(v);
+
 	if (!is_guest_mode(v) && kvm_vcpu_apicv_active(v))
 		return 0;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ed94aa8ebc0d..2609a2972526 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7686,7 +7686,11 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 		if (r) {
 			int irq = kvm_cpu_get_interrupt(vcpu);
 
-			if (!WARN_ON_ONCE(irq == -1)) {
+			/*
+			 * Ignore kvm_cpu_get_interrupt() for a protected APIC guest. We know
+			 * there are injectable interrupts due to the check above.
+			 */
+			if (vcpu->arch.apic->guest_apic_protected || !WARN_ON_ONCE(irq == -1)) {
 				kvm_queue_interrupt(vcpu, irq, false);
 				kvm_x86_call(inject_irq)(vcpu, false);
 				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
-- 
2.54.0

