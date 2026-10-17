Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEB3CF026
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230060; cv=none; b=I7Q/tJ5+oxEQtoXY+BaHlFBlWG9tmoKvk87xiw6GVXAa65BRnKp23Z53aomKsgaAEhnzZCjRJuL4hNhHlMK/XKE22eneetBVpzOTBJNaIKaDrRtVi0M4k3Og2g839PhAluPCOfXtTETpYtTfynWLN4EutxeNAOW2QFey2esnDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230060; c=relaxed/simple;
	bh=dT4Mjcqv3C6ya0C3ujbIBBzKxYQnve4ctt390KO09gQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PV7/9mJiFFzCsPLgFzitNCCgCHy0UTsS57vcZNUK1jLOFYP1VZMvZNu1WlSdDHFqPiCCDDGgzZMfGyQjrk30jbSw319Fr0pLUUrCefBCb0Tb40QN94zWMgZsFWkwgh7vOCE6JX2KD93o4RbBYbjUgZZPw11A39VY6WaG6nRGoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwhwbiU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwhwbiU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A5F1F000C4;
	Sat, 17 Oct 2026 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792230058;
	bh=VhA/4WPQHC3wEyuWKyaryyrpCkums9XoIcJSU1YApOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwhwbiU/A46W0H1yS0200B3YcFFdrEJyCUfeGBsqDf9TkrEbdcfGnB4YQGJ0YtP2a
	 R7ThGg3Z0fMQ0vvTNaAG7JAWsVqxUG8IMilCpxAJijHijUAGWR4MW2Bp3cSnb2Tk2J
	 rt7iajh33QLKWWBJJAXGNIQpbJmXMFrUfzdAN5e2M8RxwGRuekWuO7hfOOIqwv30Xp
	 TEOh7umge2xbCx71xSV47lUWaLkEL/eqUlqehtxysBRjlrwQ0lRxgwLNMgvi0TkOEl
	 ahuyKFY1UT5CDJ4F/K2Gs5M5zOY8wVt2op3emYVim0z30aLHS74LTqPbgf+rcfFrBf
	 y1O4/Jq6w6ePQ==
Message-ID: <sashiko-outbox-175447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the
 active VMCS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amirmohammad Eftekhar" <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261017093016.32348-2-amirmohammad.eftekhar@cispa.de>
References: <20261017093016.32348-2-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 09:40:58 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: VMX: vmx_load_eoi_exitmap() comment mismatch and deferred L=
2 update
--

commit b2b472dc800418ff9ed851c85722ed6e99a11a91
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the active VMCS

This commit adds guard(vmx_vmcs01) to vmx_load_eoi_exitmap() so that updates
to EOI_EXIT_BITMAP0..3 target vmcs01 rather than whichever VMCS happens to =
be
loaded on the CPU.

>     KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the active VMCS
>    =20
>     vmx_load_eoi_exitmap() writes EOI_EXIT_BITMAP0..3 directly with
>     vmcs_write64() and, unlike its siblings vmx_hwapic_isr_update() and
>     vmx_sync_pir_to_irr(),
>     does not take guard(vmx_vmcs01).  The EOI-exit bitmap belongs to L1's=
 APIC,
>     but with nested virtual-interrupt-delivery an L2 can be active when K=
VM
>     refreshes it (e.g. via kvm_vcpu_reload_apic_access_page() /
>     vcpu_scan_ioapic()), so the writes land in vmcs02 instead of vmcs01: =
L2's
>     EOI-exit bitmap is corrupted and vmcs01's is left stale until the nex=
t L1
>     refresh.
>    =20
>     Add guard(vmx_vmcs01), matching the sibling APICv callbacks.
>    =20
>     Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 612ab07d4100f..ec2ea3e1d14d8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7139,6 +7139,13 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u=
64 *eoi_exit_bitmap)
>  	if (!kvm_vcpu_apicv_active(vcpu))
>  		return;
> =20
> +	/*
> +	 * The EOI-exit bitmap tracks L1's APIC, so it must land in vmcs01, not
> +	 * whichever VMCS is currently loaded; a nested VID L2 can be active
> +	 * here.  Mirror vmx_hwapic_isr_update()/vmx_sync_pir_to_irr().
> +	 */
> +	guard(vmx_vmcs01)(vcpu);
> +
>  	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
>  	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
>  	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);

[Severity: Medium]
Can vcpu_scan_ioapic() or kvm_vcpu_reload_apic_access_page() actually trigg=
er
vmx_load_eoi_exitmap() while L2 is active, as described in the commit messa=
ge
and comment?

Looking at arch/x86/kvm/x86.c, kvm_vcpu_reload_apic_access_page() only calls
set_apic_access_page_addr:

static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
{
	if (!lapic_in_kernel(vcpu))
		return;

	kvm_x86_call(set_apic_access_page_addr)(vcpu);
}

Meanwhile, vcpu_scan_ioapic() in arch/x86/kvm/x86.c explicitly defers
KVM_REQ_LOAD_EOI_EXITMAP when the vCPU is in guest mode:

	if (is_guest_mode(vcpu))
		vcpu->arch.load_eoi_exitmap_pending =3D true;
	else
		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);

And leave_guest_mode() in arch/x86/kvm/regs.h only raises
KVM_REQ_LOAD_EOI_EXITMAP when leaving L2:

	if (vcpu->arch.load_eoi_exitmap_pending) {
		vcpu->arch.load_eoi_exitmap_pending =3D false;
		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
	}

With load_eoi_exitmap_pending still in place, vcpu_scan_ioapic() will not
invoke vmx_load_eoi_exitmap() while L2 is active (it seems
vmx_load_eoi_exitmap() is only reached with is_guest_mode(vcpu) true if
leave_guest_mode() raises KVM_REQ_LOAD_EOI_EXITMAP and guest mode is
re-entered before vcpu_enter_guest() processes requests, such as via
vmx_set_nested_state()). Now that vmx_load_eoi_exitmap() uses
guard(vmx_vmcs01), should the load_eoi_exitmap_pending deferral in
vcpu_scan_ioapic() and leave_guest_mode() be removed so that
KVM_REQ_LOAD_EOI_EXITMAP is raised immediately while L2 is active, or should
the commit message and comment be updated to reflect the actual call path?

Also, both the commit message and the new comment state that this mirrors
vmx_sync_pir_to_irr() taking guard(vmx_vmcs01), but vmx_sync_pir_to_irr() in
arch/x86/kvm/vmx/vmx.c checks !is_guest_mode(vcpu) instead of using
guard(vmx_vmcs01):

	if (!is_guest_mode(vcpu) && kvm_vcpu_apicv_active(vcpu))
		vmx_set_rvi(max_irr);
	else if (max_irr_is_from_pir)
		kvm_make_request(KVM_REQ_EVENT, vcpu);

Should the reference to vmx_sync_pir_to_irr() in the comment and commit
message be adjusted as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017093016.3234=
8-2-amirmohammad.eftekhar@cispa.de?part=3D1
