Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125C5695
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579812; cv=none; b=VvDtqKtpoTgQJVUHTUaaHEE1/Pg1osQ65cvdLOUWf1ZJRx4dkW1TJWUqlYYh1Uc3F7n5s176mFJ4OdskmAiqidfxOCeqAl4cSxNoxoXIaSs5IL23Q3/P60uTz7XxNLL6a++ri5xn5gI9MdEJdoCG7nb+EE5XDGk5LOUpA4XBBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579812; c=relaxed/simple;
	bh=qJXBsKrutvSNPiaodmSuaIe+AJ+rO4bG8dQHceecCzY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Hki8BWPoAoJH7WcbSUbykcwKcuSl33Wh0dsMG/HYwQIJF4/difP9+yc4KNLNUuuAUY4bDhf2JLIwNTNwcPhJTZ8tKJ3TikqUHTQeZRxasCeJuSFiw5ZuvqoUiDMvAO5FscXgzmeiiWQ9T9bwAPTSQ9+BHKBw0sldYSKW2LMPdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnUwf3Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnUwf3Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC8E1F000FF;
	Fri,  9 Oct 2026 21:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791579810;
	bh=j7ext2fmNQH2BsubIWAIvXlTvsvh6w3wgZAqlIx2VSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnUwf3QgNkhtUlDXOBVk6IbiS2iFn7kzw45VMv67OeHVgk97tz+LOFkU6qgDvuV/L
	 IKRgVXK0XdUndSwYaeKAy0lNO6fli3i5K5OKtFS+bIgHrCgTterbZ7YLh9jYZnaYV/
	 94oKO+BSeidrfKga15/f+z4geE2+5r6gSxOwO4aZ/jvpnC8wgkkD49P6dYIn27CB4T
	 X3gfxFsZOWaN700Py6UtPdQGS009DqEqvkavUAVDfmaxyq1vSwWEyPV3V/88ffiKe2
	 MGmB1iXufemtiis7s13/0fXGngL7vAZ+Rwszv3tomsQmOxC4tqa+5cqeCwKmtRh0IN
	 nHZEwThq7w/VA==
Message-ID: <sashiko-outbox-166067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: nVMX: avoid losing the posted notification
 interrupt when exiting L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261009205036.672523-3-mlevitsk@redhat.com>
References: <20261009205036.672523-1-mlevitsk@redhat.com>
 <20261009205036.672523-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:03:30 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kvm: x86: out-of-bounds write in kvm_lapic_set_irr due to u16 =
promotion bypass
- [High] kvm: x86: guest-triggerable WARN_ON_ONCE and pi_pending state leak
--

commit 00e061d66b6985b4612f371acc0c5f41a6c597b6
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: nVMX: avoid losing the posted notification interrupt when exiting L2

This commit detects if a posted notification interrupt is pending during
a nested VM exit. If the target vCPU is about to exit to L1, the
interrupt is injected into L1's APIC to avoid losing it.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 11362aad2bc8a..66c4cf7f6e00f 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2445,7 +2445,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *v=
mx, struct loaded_vmcs *vmcs0
>  			 ~PIN_BASED_VMX_PREEMPTION_TIMER);
> =20
>  	/* Posted interrupts setting is only taken from vmcs12.  */
> -	vmx->nested.pi_pending =3D false;
> +	WARN_ON_ONCE(vmx->nested.pi_pending);

[Severity: High]
Is it possible for an L1 guest to maliciously trigger this warning and crash
the host if panic_on_warn is set?

Since the patch no longer clears pi_pending, could this state leak occur if=
 a
nested VM-entry fails early after enter_guest_mode() is called? For example,
in nested_vmx_enter_non_root_mode(), the failure path
vmentry_fail_vmexit_guest_mode calls leave_guest_mode() and returns to L1
without executing __nested_vmx_vmexit(). This would leave pi_pending
uncleared.

Additionally, could there be a store-load race here? During normal VM exit,
leave_guest_mode() clears HF_GUEST_MASK, but there is no memory barrier
enforcing visibility before pi_pending is checked further down in
__nested_vmx_vmexit(). A concurrent posted interrupt delivery might read
guest_mode =3D=3D true and set pi_pending =3D true, while the exit path rea=
ds
pi_pending =3D=3D false.

In both cases, pi_pending remains true when returning to L1, triggering this
warning on the next nested VM-entry.

[ ... ]

> @@ -5151,6 +5151,14 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u3=
2 vm_exit_reason,
>  	kvm_clear_exception_queue(vcpu);
>  	kvm_clear_interrupt_queue(vcpu);
> =20
> +	if (lapic_in_kernel(vcpu) && vmx->nested.pi_pending) {
> +		vmx->nested.pi_pending =3D 0;
> +		if (!WARN_ON_ONCE(vmx->nested.posted_intr_nv =3D=3D -1)) {
> +			kvm_lapic_set_irr(vmx->nested.posted_intr_nv, vcpu->arch.apic);

[Severity: Critical]
Does this guard actually protect against injecting an invalid vector?

Looking at struct nested_vmx in arch/x86/kvm/vmx/vmx.h, posted_intr_nv is
defined as a u16. When it is assigned -1 in prepare_vmcs02_early(), it
truncates to 65535.

Due to C integer promotion rules, the expression
vmx->nested.posted_intr_nv =3D=3D -1 compares the u16 value 65535 to the int
literal -1, which evaluates to false. This bypasses the safety guard because
!WARN_ON_ONCE(false) is true.

If pi_pending was leaked as described above and PI is subsequently disabled=
 by
L1, wouldn't kvm_lapic_set_irr() be called with vector 65535? Inside
kvm_lapic_set_irr(), calculating the bit offset for 65535 falls far outside
the 4KB APIC register page, which could result in a severe out-of-bounds wr=
ite
into adjacent host memory.

> +			kvm_make_request(KVM_REQ_EVENT, vcpu);
> +		}
> +	}
> +
>  	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> =20
>  	kvm_nested_vmexit_handle_ibrs(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009205036.6725=
23-2-mlevitsk@redhat.com?part=3D2
