Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903497;
	b=ANcgUNKCr+zuptFxfB/5JjIsb6SFX8vFvywAgerxFULWBWwZFkWbhVKRdweqBWlI0tOE
	 FRQIegsPn5fMKhcXwQr2wT5v9OkmlQQ/k6YPeKzijFt52zxzCsXj7kpxE3i6GObxqJ3TV
	 xIBzLNXlZvRg8HClLBWSvXD+IFVq1g6o3a7C1oVBV2fMGj7Fr0f11yGI9HOoXSU6GfPZz
	 778zvyLBrQ5cF1W5yyzSZVW9ewH8n+Ckxn0aHwNnjDThwnPDl8c9zrRTRuVL5Ef82PRPk
	 bhmYvDwMV72WYZAQOP8TOZ7tseGeqMQ3lyrLcNrfrwFWczAIkccXNEi3CNahqbz2nVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ss8hAj+MuUASuzGCKH0Ow5MHY2M6t206M5ATnexS1lk=;
	b=ymmRcm3uiOsf6Aayeg1JIMENQkio5PLDaM5NSKuS03CWwWShVsQogQla/62682PGvgJ8
	 V42Rzy804lZmxpp9zKwmdGUTeRwpOoWMnNHmDDClACq4o0LJfyVnAYsyEnVkx7sqg9tUH
	 uPcSZZ3w1kmH0HMRKmPZ5ACyz//RnbBtjXJi5Wy2549Gxl8NFToeRVvJ1E/SbtBaY+98t
	 9GDqmyFHOpB4iATuIN+VVPWsQDaA4KaR6O6gJgqWHStJdD0S8TydBpV5GwgychUbsbl8i
	 jVTSgO8pnMZIplhw4saKy/1YE6i8DtNnTr3LH3IM/qOKvrhKUizfnIk/lKwKjWKBtjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpE2zu1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846E606A329
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpE2zu1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5A81F000C1;
	Thu,  5 Nov 2026 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903497;
	bh=ss8hAj+MuUASuzGCKH0Ow5MHY2M6t206M5ATnexS1lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpE2zu1bdGMnw5kyROKsdef/Se7cYZoQUEw6g2RuJrAMuySkXjr8QvWlsldiHXUR6
	 tSOPzmhlO9yLTtjRh8h9UcK4j7Aw1N36DpfoFNXyQVjnCdHnDojdpY4vvAIbS20NY7
	 /FGWG1qMkcGvBOKNuKvrgaL6CdgFgnwwHw+SywHacNJP6SDVuBulUranezTBLZkipF
	 7E0mFKpUJadGug6rRDsGK5w8JvgKc+yYIHzxeGIDuZ9xmbMOE0U8pUwfsHpX5ZUlzF
	 1JpWnfAhmch9o7rojIlWrjqXRMnJ2MDvLEP8DcmUnq5i3/gOVNEsS8HiUkJ5fmepRD
	 vWTVmcWQhb/qQ==
Message-ID: <sashiko-outbox-199772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: VMX: Re-pend KVM_REQ_APIC_PAGE_RELOAD if getting
 backing pfn fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261105181742.3718448-1-seanjc@google.com>
References: <20261105181742.3718448-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:31:36 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] KVM: VMX: stale no-retry comment in vmx_set_apic_access_page_addr()
--

commit 635b83243ce9cf39c9f2bbd0198d7730dbb21505
Author: Sean Christopherson <seanjc@google.com>

KVM: VMX: Re-pend KVM_REQ_APIC_PAGE_RELOAD if getting backing pfn fails

This commit re-pends KVM_REQ_APIC_PAGE_RELOAD in
vmx_set_apic_access_page_addr() when looking up the APIC-access page memslot
or faulting in its backing pfn fails, preventing the vCPU from running with=
 a
stale vmcs.APIC_ACCESS_ADDR. It also adds a WARN_ON_ONCE() if the private
memslot is missing or invalid.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b341af4c6057a..13dcf9c12c83a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6923,8 +6923,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu=
 *vcpu)
>  	 * APICv is enabled, but paranoia won't hurt in this case.
>  	 */
>  	slot =3D id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
> -	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
> +	if (WARN_ON_ONCE(!slot || slot->flags & KVM_MEMSLOT_INVALID)) {
> +		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>  		return;
> +	}
> =20
>  	/*
>  	 * Ensure that the mmu_notifier sequence count is read before KVM
> @@ -6941,8 +6943,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu=
 *vcpu)
>  	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
>  	 */
>  	pfn =3D __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, &writable, &refcounted=
_page);
> -	if (is_error_noslot_pfn(pfn))
> +	if (is_error_noslot_pfn(pfn)) {
> +		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>  		return;
> +	}

[Severity: Low]
This isn't a bug, but in vmx_set_apic_access_page_addr() in
arch/x86/kvm/vmx/vmx.c, the full comment immediately above
__kvm_faultin_pfn() still states:

	/*
	 * No need to retry if the memslot does not exist or is invalid.  KVM
	 * controls the APIC-access page memslot, and only deletes the memslot
	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
	 */

Since both the invalid-memslot check and the is_error_noslot_pfn(pfn) check
now retry by calling kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu), and
VMX does not delete or inhibit the APIC-access page memslot while the VM is
alive, should this comment be updated or removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105181742.3718=
448-1-seanjc@google.com?part=3D1
