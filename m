Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346723EAB4
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678331; cv=none; b=fZzJKuVUiUVmh5swlam3hnqjBmzctUe1szadzyKRQlTWrvVMeFTCuFEK7uWSLJMlHSnlp4+iwlDhf9jo8M3c46szBc7q8q0PHHyEB57TA/z8kzuHLe4yzPj6s2zG0OZw99FZkHAYYspk4um6LIlM4AQv/HX5GpLkpWHxg6XEWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678331; c=relaxed/simple;
	bh=bAtj8OPX5bRThF9xZObGPYoEarB1N/Klvdyk01UHUEs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k1KORaukCpKW/8Cqny5DXGZtPJzY6zDTzkIg+3nWUBRj9cnJjLNVnoR4cs8Ipr0xS33qD78Lvymjdze1T6Od4YDozOBOJGC+DgZFH+3uOcxyQ++stsAJKUFmqtUQqF/qD2hVsQB45ef86SLxLGqL77BnvgA4Jge5EqfqamMdai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESDA+Ud7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESDA+Ud7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB5C1F000FF;
	Sun, 11 Oct 2026 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791678329;
	bh=tDGWII3/bOrgvfRHB/sB48RNfD8Iq0nqNsRrMtmRMVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESDA+Ud7wfkIeqdEJTMTtWGURN+hqqwF045n+XR9QZy/tx7B1XEYZBjY/OH7aKQAB
	 xu99aCEBP/E5J5qfllt1TJFCl39ErFc4eYjBHNv5URaYa6zMJpbGt+7gvnLpMjIBsR
	 pNV3ZPtqR9oNB4znJFUMpMFRF2vhgUnTM7tuCYBpLgAsIpe7l8CVikflOX1iaXX2xP
	 el9QPsj1TWMMHYFjycj9whUxOnveIXHy9CHBrR2Z5jEkqDVktkr/W+MHXiZgKJryHF
	 gd7S3HqleXDFyTAOyvKuPvm4cACI63aCkNzU1cSOlAysOHgqm075sVczTygIKap71M
	 rrbKV6nCiAcJg==
Message-ID: <sashiko-outbox-166944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: nVMX: avoid losing the posted notification
 interrupt when exiting L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261011001303.723721-3-mlevitsk@redhat.com>
References: <20261011001303.723721-1-mlevitsk@redhat.com>
 <20261011001303.723721-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 00:25:29 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: nVMX: incorrect memory barriers (smp_wmb/smp_rmb) fail to pre=
vent Store-Load race
- [High] kvm: nVMX: ignored return value in __nested_vmx_vmexit swallows me=
mory failure
--

commit 8287f538318e13160edd8d2bb1ae4a6ae79766ff
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: nVMX: avoid losing the posted notification interrupt when exiting L2

This commit runs vmx_complete_nested_posted_interrupt just before a nested
VM exit to prevent losing nested posted interrupt notifications when the
target vCPU is exiting L2. It also adds memory barriers between
vmx_deliver_nested_posted_interrupt and __nested_vmx_vmexit.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 50548e3483181..92d5ade58dc9c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5103,8 +5103,15 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u3=
2 vm_exit_reason,
>  	if (enable_ept && is_pae_paging(vcpu))
>  		vmx_ept_load_pdptrs(vcpu);
> =20
> +
>  	leave_guest_mode(vcpu);
> =20
> +	/* pairs with barrier in vmx_deliver_nested_posted_interrupt */
> +	smp_wmb();
> +
> +	if (vmx->nested.pi_pending)
> +		vmx_complete_nested_posted_interrupt(vcpu);

[Severity: High]
Does this ignored return value swallow memory failures?

When vmx_complete_nested_posted_interrupt() encounters an error mapping the
virtual APIC page, it calls kvm_handle_memory_failure() to set
vcpu->run->exit_reason to KVM_EXIT_INTERNAL_ERROR and returns -ENXIO to abo=
rt
the current VM run.

Since __nested_vmx_vmexit() returns void and ignores this return value, is =
the
KVM_EXIT_INTERNAL_ERROR silently overwritten by the next VM-exit, preventing
userspace from receiving the memory failure error?

[Severity: High]
Do these memory barriers properly prevent a Store-Load race?

In __nested_vmx_vmexit(), we store to vcpu->arch.hflags (via leave_guest_mo=
de)
and then load vmx->nested.pi_pending.

In vmx_deliver_nested_posted_interrupt(), we load vcpu->arch.hflags (via
is_guest_mode) and then store to vmx->nested.pi_pending.

This is a Store-Load sequence on the receiver and a Load-Store sequence on =
the
sender.

On x86, smp_wmb() acts only as a compiler barrier and does not prevent the =
CPU
store buffer from reordering the load of pi_pending before the store to hfl=
ags
becomes globally visible. As a result, the target vCPU can still read
pi_pending =3D=3D false before its exit from guest mode is visible to the s=
ender.
The sender will then see is_guest_mode =3D=3D true and set pi_pending =3D t=
rue,
leaving the nested posted interrupt lost.

Is a full memory barrier (smp_mb()) required here to prevent Store-Load
reordering?

> +
>  	if (nested_cpu_has_preemption_timer(vmcs12))
>  		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
> =20

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cc75feec05daa..a40791167b10e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4362,10 +4362,15 @@ static int vmx_deliver_nested_posted_interrupt(st=
ruct kvm_vcpu *vcpu,
>  	 */
>  	if (is_guest_mode(vcpu) &&
>  	    vector =3D=3D vmx->nested.posted_intr_nv) {
> +
> +		/* pairs with barrier in __nested_vmx_vmexit */
> +		smp_rmb();

[Severity: High]
Does an smp_rmb() here correctly pair with the barrier in __nested_vmx_vmex=
it?

Since the sequence in vmx_deliver_nested_posted_interrupt() involves a load
(is_guest_mode) followed by a store (pi_pending =3D true), and the sequence=
 in
__nested_vmx_vmexit() is a Store-Load, is a different synchronization primi=
tive
or stronger barrier pairing needed to prevent the race?

> +
>  		/*
>  		 * If a posted intr is not recognized by hardware,
>  		 * we will accomplish it in the next vmentry.
>  		 */
> +
>  		vmx->nested.pi_pending =3D true;
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011001303.7237=
21-1-mlevitsk@redhat.com?part=3D2
