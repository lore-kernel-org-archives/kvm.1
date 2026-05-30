Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540E19EED3
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780132175; cv=none; b=bu4Hk+BeTOb8eJ2Slg7JcfVJN12uNcG34SGnJQVgzvCa5yh/q71s/a3Hl7V186wtMM9gEPCK5kSLFgD+FnsursiJvKTZQGYGi0grlsBtGz1j4dBxYn7Qd9/5VHoYFT/fjJJtx6O3wU6UmjUJjW7ngTpohpVG0ui+lD2lnfmzDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780132175; c=relaxed/simple;
	bh=9EBN7mY3l2dg5XIpOHZanqRd+x/KpBo/ujkfL1+OO5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZdNyCzdCQ0xraI2bxDZs8qJxMLhfg1zigt7l9osUgUdUAYQ1U51KVrjs0i9JRAnGHstBexU4xyWafbmER4wIcSvQglaOifeb8Bh6Cu/96oVTmh32MMYx/2BAIec0LvBMx2tS1jYmKjyV0TFCjRHvGEWTUSPpzC0zIzkApj3lT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX3ic1L6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX3ic1L6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532211F00893;
	Sat, 30 May 2026 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780132174;
	bh=fWLOnk+SWvTO+lQDTShf703Sc2xeuXYBRJg+EwG8+mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KX3ic1L6iSV4jXCAHR3GF+g+mMhkj+lV913T3X9A8SgibrCZUhPNRn7IAm2GkZ3d5
	 jdQH/b2DmJ8/WSuVX8AHMPWpGOp0XR3rTKitFiizlkm+sLH0JcYIVnUP7+ZpPWucMA
	 rX+XG0C0oKezZ585dx7WNNaqIEKXaHtojFfKJ/JpoCVlC9qA7XtCYPO+zypOrHFPXi
	 B7v12pbCECGPEPNJPfCn5MoedsFBXVD/yDQEcfpUcdfih2uBVdtYbIyJLcdNpGXqse
	 VSBHcy/W55tqy001WjTXwXvKpGQxItYeHPcoURtigthiICe+HUF+f7p1vzPq16v6l0
	 5xSb7mqUQcvkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/27] KVM: s390: arm64: Implement vCPU IOCTLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-26-seiden@linux.ibm.com>
References: <20260529155050.2902245-26-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 09:09:33 +0000
Message-Id: <20260530090934.532211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Userspace-reachable WARN_ONCE creates a host-side DoS vulnerabilit=
y via hardware validity intercepts.
- [High] Calling `local_irq_enable()` inside an RCU extended quiescent stat=
e breaks context tracking and introduces a race condition.
- [High] The vCPU run loop fails to set `vcpu->mode` to `IN_GUEST_MODE`, le=
ading to silently dropped IPI kicks.
- [High] Crucial KVM requests (such as KVM_REQ_VM_DEAD and KVM_REQ_SLEEP) a=
re ignored, allowing execution in an invalid or fatal state.
- [High] The vCPU run loop checks `need_resched()` and `signal_pending()` w=
ith interrupts enabled, causing a TOCTOU race with host interrupts.
- [Medium] `kvm_arm_vcpu_finalize` unconditionally returns success for unsu=
pported features.
--

commit 9e53079e1aa1b7ab592dcb9275360b129725a075
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: arm64: Implement vCPU IOCTLs

This patch implements the core vCPU ioctls for the s390 arm64 KVM port. It
adds support for initializing and running the guest, as well as handling
registers and handling exceptions through the SAE block.

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
@@ -244,12 +268,12 @@
> +static int check_vcpu_requests(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_request_pending(vcpu)) {
> +		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> +			kvm_reset_vcpu(vcpu);
> +		/*
> +		 * Clear IRQ_PENDING requests that were made to guarantee
> +		 * that a VCPU sees new virtual interrupts.
> +		 */
> +		kvm_check_request(KVM_REQ_IRQ_PENDING, vcpu);
> +	}
> +
> +	return 1;
> +}

[Severity: High]
Does this code ignore crucial KVM requests like KVM_REQ_VM_DEAD or
KVM_REQ_SLEEP? It looks like it only processes KVM_REQ_VCPU_RESET and
KVM_REQ_IRQ_PENDING. If a fatal error occurs and KVM_REQ_VM_DEAD is pending,
would returning 1 here cause the vCPU to immediately resume guest execution
and override the KVM failsafe?

[ ... ]
@@ -348,15 +373,15 @@
> +static void arm_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sae_block *sae_block =3D &vcpu->arch.sae_block;
> +
> +	adjust_pc(vcpu);
> +
> +	local_irq_disable();
> +	guest_enter_irqoff();
> +	local_irq_enable();

[Severity: High]
Does calling local_irq_enable() immediately after guest_enter_irqoff() break
context tracking? guest_enter_irqoff() signals to RCU that the CPU is enter=
ing
an extended quiescent state. If a host interrupt fires after local_irq_enab=
le()
but before the actual guest entry, would the interrupt handler execute while
RCU considers the CPU quiescent, leading to lockdep/RCU splats or potential
use-after-free bugs?

> +
> +	sae_block->icptr =3D 0;
> +
> +	sae64a(sae_block);
> +
> +	local_irq_disable();
> +	guest_exit_irqoff();
> +	local_irq_enable();
> +}
[ ... ]
@@ -395,20 +420,20 @@
> +	ret =3D 1;
> +	do {
> +		if (signal_pending(current)) {
> +			kvm_run->exit_reason =3D KVM_EXIT_INTR;
> +			ret =3D -EINTR;
> +			continue;
> +		}
> +
> +		if (need_resched())
> +			schedule();

[Severity: High]
Can this sequence cause a time-of-check to time-of-use race with host
interrupts? The checks for signal_pending() and need_resched() in
kvm_arch_vcpu_ioctl_run() are performed with local interrupts enabled. If a
host interrupt arrives immediately after these checks and sets a reschedule=
 or
signal flag, would the vCPU blindly enter the guest via arm_vcpu_run() and
ignore the pending request for a long time?

> +
> +		if (ret > 0)
> +			ret =3D check_vcpu_requests(vcpu);
> +
> +		vcpu->arch.sae_block.icptr =3D 0;
> +
> +		arm_vcpu_run(vcpu);

[Severity: High]
Are we missing the transition of vcpu->mode to IN_GUEST_MODE before calling
arm_vcpu_run()? KVM's generic kvm_vcpu_kick() mechanism relies on checking =
if
vcpu->mode =3D=3D IN_GUEST_MODE to send an IPI. If the state remains
OUTSIDE_GUEST_MODE, would concurrent kicks for virtual interrupt injections=
 or
halt requests silently drop the IPI and leave the vCPU trapped in guest
execution?

> +
> +		icptr =3D vcpu->arch.sae_block.icptr;
> +		switch (icptr) {
> +		case SAE_ICPTR_SPURIOUS:
> +			break;
> +		case SAE_ICPTR_VALIDITY:
> +			WARN_ONCE(true, "SAE: validity intercept. vir: 0x%04x",
> +				  vcpu->arch.sae_block.vir);
> +			ret =3D -EINVAL;
> +			break;

[Severity: High]
Is it possible for malicious userspace to trigger this WARN_ONCE? If an
unprivileged host userspace provides invalid vCPU register states via
KVM_SET_ONE_REG prior to running the vCPU, it could force a validity interc=
ept.
KVM subsystem guidelines forbid guest- or host-userspace-reachable WARN_ON
assertions since they can crash the host if panic_on_warn is enabled.

> +		case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
> +			ret =3D handle_trap_exceptions(vcpu);
> +			break;
[ ... ]
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
new file mode 100644
--- /dev/null
+++ b/arch/s390/kvm/arm64/reset.c
[ ... ]
@@ -48,10 +48,10 @@
> +
> +int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
> +{
> +	return 0;
> +}

[Severity: Medium]
Should this function validate the requested feature instead of unconditiona=
lly
returning success? By ignoring the feature argument and returning 0, would
userspace incorrectly believe an unsupported feature is successfully
configured, leading to unpredictable failures later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D25
