Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637527;
	b=BoVK2bj4VyndorOLaOuhpjQskbRls/ewUcgB9y538DCBCF36uG+0s5Sv5XtIG2vOfB1b
	 nMgWdkOixoWH2SFWwzfjromysfeM6Z7kXA+x9DDf6dolsSTv/JAYR8tFu4/G8rxUVUPS1
	 UjzYELAu5n9VExTM8RXFRREYwy1LS1jyXBUbkMtF+4dWW8P8iaOQyZvYPkcihg8cGNN+i
	 pfxsdn/Gd+pIyNFJMNCvDBcVy5OAZY9jACNNo62dt21uorxDaQ4MONVPHRZolMp5y49ww
	 7T5tCH8+ZfM24Ys4vDEdx0WZyeYd0J0jfoi3A4f6Jx2y6tbT0hUdQmo997W7pHwwENQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637527;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h1hesz8Dq/WdkUfYyeZQJF1WiFexhLEBTyIl9jjnwA4=;
	b=SiNnB7GFYqB4qEgsCE8XjTleMbl7ye8Xd3zzy570QqqVDAujBlMqp/zHpyremUYhYxIA
	 DjAPOg3KRDf+sieR40EOJu1XVAn+3slm9NtqY3c15Ee29JqCuOYTUK+oUDKn4GjmhP/tn
	 QnMyjMuupI4Syh8NcUDkisAxjt1s9oFJ+8VmzoYX4fkFsEoWrk+fpopZd9s2WBvbj10ng
	 /1Hw0HAQr55OkVH92nKwON0UloAOPYmdtXII+etWJcjlp6KWXMM/8epVmLPHzzF9q9KA7
	 j1XvOmgx+adPRwsRtXdKhC9l91sk0+VaNaguSK95DG0AVk9fgPoy5KI8Dk1mb6O9Mrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ph9SNXCS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB49606A323
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ph9SNXCS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A91F000C3;
	Thu, 22 Oct 2026 02:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792637527;
	bh=h1hesz8Dq/WdkUfYyeZQJF1WiFexhLEBTyIl9jjnwA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ph9SNXCSgame0qqq8FiTnR3LZDi37pDYAcFCetUKFBENH3LUU+6EV6R2szSV+ljPa
	 H8b/9tcYSZQVX0clN7xEApuUQgmlaFFlYQ1W/9yEDEIkkaVNnQlC23yseOZ2USxiEH
	 B31Q7KCLU8kMdQkSPQVVTO8YCA9bLZUvCoCPoYr7pJlWYI+WevskC9FH/VikCycxdV
	 S4G9lBspXhcepvmk7NC6hAK0J5qXi55m+5FNtdU2jYnYPmHs9e/hWPZ9pIUpAUjsXV
	 i9KeN+w+s4GxPyfnjtdHhdzQ3K7m9nKBKg5HD6iSTwpHVZeZuwdQD4uc+0fgBawL8Q
	 SxPnH8RnDf2AQ==
Message-ID: <sashiko-outbox-180887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: x86: Switch to vmcs01 to update EOI exiting
 bitmap on-demand if L2 is active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022022813.303978-2-seanjc@google.com>
References: <20261022022813.303978-1-seanjc@google.com>
 <20261022022813.303978-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:52:06 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: x86: stale vmcs01 EOI exitmap when APICv is uninhibited in L2
- [Low] KVM: x86: unused load_eoi_exitmap_pending field in struct kvm_vcpu_=
arch
--

commit aa3ef15390c0560005f0f971f44e1775dbb6d55f
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Switch to vmcs01 to update EOI exiting bitmap on-demand if L2 is =
active

This commit updates vmx_load_eoi_exitmap() to temporarily switch to vmcs01
using guard(vmx_vmcs01) so the EOI exit bitmap can be updated immediately
while L2 is active. It also removes KVM_REQ_LOAD_EOI_EXITMAP and the
deferred request handling in vcpu_scan_ioapic() and leave_guest_mode().

Closes: https://lore.kernel.org/all/20261017093016.32348-2-amirmohammad.eft=
ekhar@cispa.de

> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 447f0ec3e63e4..411eaf445d436 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -464,12 +464,6 @@ static inline void enter_guest_mode(struct kvm_vcpu =
*vcpu)
>  static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
>  {
>  	vcpu->arch.hflags &=3D ~HF_GUEST_MASK;
> -
> -	if (vcpu->arch.load_eoi_exitmap_pending) {
> -		vcpu->arch.load_eoi_exitmap_pending =3D false;
> -		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
> -	}
> -
>  	vcpu->stat.guest_mode =3D 0;
>  }
> =20

[Severity: Low]
With the removal of the only reader of vcpu->arch.load_eoi_exitmap_pending =
in
leave_guest_mode() (in arch/x86/kvm/regs.h) and its only writer in
vcpu_scan_ioapic() (in arch/x86/kvm/x86.c), load_eoi_exitmap_pending in
struct kvm_vcpu_arch has no remaining references in the tree (both at this
commit and at the end of the series):

arch/x86/include/asm/kvm_host.h:
struct kvm_vcpu_arch {
	...
	u64 apic_base;
	struct kvm_lapic *apic;    /* kernel irqchip context */
	bool load_eoi_exitmap_pending;
	DECLARE_BITMAP(ioapic_handled_vectors, 256);

Should load_eoi_exitmap_pending be removed from struct kvm_vcpu_arch as wel=
l?

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 612ab07d4100f..5e765409398d3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7139,6 +7139,8 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u6=
4 *eoi_exit_bitmap)
>  	if (!kvm_vcpu_apicv_active(vcpu))
>  		return;
> =20
> +	guard(vmx_vmcs01)(vcpu);
> +
>  	vmcs_write64(EOI_EXIT_BITMAP0, eoi_exit_bitmap[0]);
>  	vmcs_write64(EOI_EXIT_BITMAP1, eoi_exit_bitmap[1]);
>  	vmcs_write64(EOI_EXIT_BITMAP2, eoi_exit_bitmap[2]);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index aad065d035fbb..082d027ade583 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8003,17 +8003,6 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
>  		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
>  #endif
> =20
> -	if (is_guest_mode(vcpu))
> -		vcpu->arch.load_eoi_exitmap_pending =3D true;
> -	else
> -		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
> -}
> -
> -static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
> -{
> -	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
> -		return;
> -
>  #ifdef CONFIG_KVM_HYPERV
>  	if (to_hv_vcpu(vcpu)) {
>  		u64 eoi_exit_bitmap[4];
> @@ -8167,8 +8156,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		}
>  		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
>  			vcpu_scan_ioapic(vcpu);
> -		if (kvm_check_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu))
> -			vcpu_load_eoi_exitmap(vcpu);
>  		if (kvm_check_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu))
>  			kvm_vcpu_reload_apic_access_page(vcpu);
>  #ifdef CONFIG_KVM_HYPERV

[Severity: High]
Can calling load_eoi_exitmap() directly from vcpu_scan_ioapic() while L2 is
active leave stale EOI_EXIT_BITMAP0..3 values in vmcs01 when APICv
transitions from inhibited to uninhibited in L2?

When APICv becomes inhibited on a vCPU (for example, when L1 or L2 modifies
the xAPIC APIC_ID via kvm_lapic_reg_write() -> kvm_recalculate_apic_map(),
disables the APIC via kvm_apic_set_base(), or enables Hyper-V SynIC AutoEOI=
),
KVM queues both KVM_REQ_APICV_UPDATE and KVM_REQ_SCAN_IOAPIC.

In vcpu_enter_guest() in arch/x86/kvm/x86.c, KVM_REQ_SCAN_IOAPIC is serviced
before KVM_REQ_APICV_UPDATE:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
	...
		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
			vcpu_scan_ioapic(vcpu);
	...
		if (kvm_check_request(KVM_REQ_APICV_UPDATE, vcpu))
			kvm_vcpu_update_apicv(vcpu);
}

During the inhibit transition, apic->apicv_active is still true when
vcpu_scan_ioapic() runs, so vmx_load_eoi_exitmap() writes the zeroed
ioapic_handled_vectors bitmap into vmcs01's EOI_EXIT_BITMAP0..3 before
KVM_REQ_APICV_UPDATE sets apic->apicv_active to false. Similarly, any IOAPIC
routes configured while APICv is inhibited are not written to vmcs01 because
apic->apicv_active is false.

When the guest later transitions out of the inhibited state while L2 is
active (is_guest_mode(vcpu) is true) -- for example, when L2 enables x2APIC
via MSR_IA32_APICBASE or restores the xAPIC ID -- kvm_apic_set_base() or
kvm_recalculate_apic_map() clears the APICv inhibit (queuing
KVM_REQ_APICV_UPDATE) and calls kvm_make_scan_ioapic_request() (queuing
KVM_REQ_SCAN_IOAPIC).

Previously, because is_guest_mode(vcpu) was true, vcpu_scan_ioapic() set
vcpu->arch.load_eoi_exitmap_pending =3D true and deferred
KVM_REQ_LOAD_EOI_EXITMAP until leave_guest_mode() on nested VM-Exit, after
KVM_REQ_APICV_UPDATE had already set apic->apicv_active =3D true.

With this change (and still at the end of the series after commit "KVM: x86:
Consolidate invocations of kvm_x86_ops.load_eoi_exitmap()"),
vcpu_scan_ioapic() immediately invokes kvm_x86_call(load_eoi_exitmap)() ->
vmx_load_eoi_exitmap() while servicing KVM_REQ_SCAN_IOAPIC before
KVM_REQ_APICV_UPDATE has run. At that point kvm_vcpu_apicv_active(vcpu) is
still false, so vmx_load_eoi_exitmap() returns early without writing
EOI_EXIT_BITMAP0..3 to vmcs01:

arch/x86/kvm/vmx/vmx.c:vmx_load_eoi_exitmap() {
	if (!kvm_vcpu_apicv_active(vcpu))
		return;

	guard(vmx_vmcs01)(vcpu);
	...
}

KVM_REQ_APICV_UPDATE then calls kvm_vcpu_update_apicv(), which sets
apic->apicv_active =3D true and enables SECONDARY_EXEC_VIRTUAL_INTR_DELIVER=
Y in
vmcs01 via vmx_refresh_apicv_exec_ctrl() without reloading the EOI exit
bitmap, leaving vmcs01 with stale EOI_EXIT_BITMAP0..3 values and breaking
level-triggered IOAPIC or Hyper-V SynIC EOI exits.

Should KVM_REQ_APICV_UPDATE be processed before KVM_REQ_SCAN_IOAPIC in
vcpu_enter_guest(), or should kvm_vcpu_update_apicv() reload the EOI exit
bitmap when re-activating APICv?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022022813.3039=
78-2-seanjc@google.com?part=3D1
