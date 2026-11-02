Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642965;
	b=wkvgxMnaRcZ/jsFSfniZUXiYXta9m6IqVi8Xr3T/3YJhp94Y3QWtKiHtNiLx6xAR/y4f
	 VCH+O4QKU8cAONDvOXnLmF9wR20BQS4XwmNyZSTOt7Y/kFWXUvNYQSncamaauIksyWIG4
	 kMSHu65QAd1BZisL+CL9BWAcCDqJMCLQzGaoKVvSdqVmYCIk75vdh4A8/+YRzYPtk75QV
	 08qwhqUAwu+AgyNz0SqDTXfwdj7fHjbE/8/62uJtKFy7HVDHs0TA7/ysdA+uV11M4FQqy
	 ueFNm8J5AcF1vQmsD+fwMeyds4mtmZoXvFKpax6uyvGK7ojP8EzilqlPB6JN4KsKQAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MKVCPqhnYwKk/h2o0T6VcDpkskNEzr4X5Liss3m5zDw=;
	b=G/VisgeqyFTXMkxHwLT46+Fz0IY+EhTyxZMUyKns0S6Vl1J+sFS0Dvvs5uZD70SKz2wX
	 NKlhg9LbD/rwDXvtiT1lP1H7DzvJS7aDpChNAiFz2Ydwgty/TLhNdnuX+dstxd2eDQArY
	 NGybr5UG8DGhw/Rgbkiu7vsZkdyt5eufGh3AkzFi2ARNHklqurfnz2r52gJGBb6JcC+Z8
	 g/VlF7qcp2YVKwTS4wyQ2ysGcnQfoObVHlhKck2Jp66Xld8laltJf1iR/U28YL7zyyHkS
	 Q2mU2GeHIZNn5LdpUZd8ujZ7j+yVVBFe4Az8isa6SaXIo+Ir85aGDE+tcIQvHnC5k5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4NpGQ5K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8331606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4NpGQ5K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E451F00A16;
	Mon,  2 Nov 2026 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642964;
	bh=MKVCPqhnYwKk/h2o0T6VcDpkskNEzr4X5Liss3m5zDw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n4NpGQ5K85gJvg3dRJ9NtG3tJaI6/l66xmNNcVwouJx/fLw4O8VlNDf6nYhrv2KbC
	 tD+Bb75amMjSMtdWooejcgM26y+1bYCdBy5+wocPjvL7RIgVvXbHGH7qy36RLC6Iwp
	 zyMgTvOqwZvi02hHogsRlxdiEZ/8O4dCkValQXJ/NOLCPi0yZQSHEynjGI78sOYuBK
	 3omf721pBzue8l+3nCxNjN4ifT18PDllcpJppTXe/JeyN1zpzLxzHWmt/M0gWkXFf7
	 8EJNAFdwmUwF9K2yvsSbwwSxHMe7ZTYqGObqjBRNEkHpFOpNqvmWB6kfesLp8aPS90
	 BWvJNhY2fKuDw==
Message-ID: <sashiko-outbox-193910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/45] KVM: pfncache: Fail to refresh if it contains
 memory protections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-10-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:09:23 +0000
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
- [High] KVM: pfncache: __kvm_gpc_refresh() skips updating gpc->gpa on RW p=
rotection error
--

commit 808264658bd3c3bcb182dcf95cb531c1ff5d0f1b
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: pfncache: Fail to refresh if it contains memory protections

This commit updates __kvm_gpc_refresh() in virt/kvm/pfncache.c to reject
refreshing GPA-based caches when the target GFN has NR or NW memory
protection attributes.

Link: https://patch.msgid.link/20260918135030.171564-24-pbonzini@redhat.com

> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index e82247ca46372..ed8884a6d2404 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -298,7 +298,18 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache=
 *gpc, gpa_t gpa, unsigned l
>  		    gpc->gpa !=3D gpa || kvm_is_error_hva(gpc->uhva)) {
>  			gfn_t gfn =3D gpa_to_gfn(gpa);
> =20
> +			/*
> +			 * RW memory attributes are incompatible with GPC. The
> +			 * RW protection check has to happen after storing the
> +			 * generation number.
> +			 */
>  			gpc->attrs_generation =3D kvm_mem_attributes_generation(kvm);
> +			if (kvm_range_has_rw_memory_protections(kvm, gfn, gfn + 1)) {
> +				gpc->uhva =3D KVM_HVA_ERR_BAD;
> +				ret =3D -EFAULT;
> +				goto out;
> +			}
> +
>  			gpc->gpa =3D gpa;
>  			gpc->slots_generation =3D slots->generation;
>  			gpc->memslot =3D __gfn_to_memslot(slots, gfn);

[Severity: High]
Because this error path jumps to out before setting gpc->gpa =3D gpa, what
happens when kvm_gpc_activate() is called on a GPA backed by NR or NW memory
protections?

In virt/kvm/pfncache.c, __kvm_gpc_activate() marks the cache active before
calling __kvm_gpc_refresh():

virt/kvm/pfncache.c:__kvm_gpc_activate() {
	if (!gpc->active) {
		...
		write_lock_irq(&gpc->lock);
		gpc->active =3D true;
		write_unlock_irq(&gpc->lock);
	}
	return __kvm_gpc_refresh(gpc, gpa, uhva);
}

Unlike the existing gfn_to_hva_memslot() failure path immediately below,
jumping to out on kvm_range_has_rw_memory_protections() leaves gpc->gpa
unchanged while setting gpc->uhva =3D KVM_HVA_ERR_BAD:

1. If the cache was freshly initialized or previously HVA-active (so
gpc->gpa =3D=3D INVALID_GPA), it is left with gpc->active =3D=3D true,
gpc->gpa =3D=3D INVALID_GPA, and gpc->uhva =3D=3D KVM_HVA_ERR_BAD. On a sub=
sequent
kvm_gpc_refresh() call, kvm_is_error_gpa(gpc->gpa) is true, so
kvm_gpc_refresh() passes both gpa =3D=3D INVALID_GPA and uhva =3D=3D KVM_HV=
A_ERR_BAD
into __kvm_gpc_refresh():

virt/kvm/pfncache.c:kvm_gpc_refresh() {
	...
	uhva =3D kvm_is_error_gpa(gpc->gpa) ? gpc->uhva : KVM_HVA_ERR_BAD;

	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
}

virt/kvm/pfncache.c:__kvm_gpc_refresh() {
	/* Either gpa or uhva must be valid, but not both */
	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) =3D=3D kvm_is_error_hva(uhva)))
		return -EINVAL;
}

This allows a guest (for example, by writing MSR_KVM_SYSTEM_TIME_NEW with a
protected GPA) to trigger the host WARN_ON_ONCE(), and prevents
kvm_gpc_refresh() from ever recovering even if userspace later clears the
memory protections.

2. In that same state (gpc->active =3D=3D true and gpc->gpa =3D=3D INVALID_=
GPA),
kvm_gpc_is_hva_active() evaluates to true, which causes
kvm_xen_hvm_get_attr() and kvm_xen_vcpu_get_attr() in arch/x86/kvm/xen.c to
copy gpc->uhva (KVM_HVA_ERR_BAD, i.e. PAGE_OFFSET) to userspace:

arch/x86/kvm/xen.c:kvm_xen_vcpu_get_attr() {
	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA:
		if (kvm_gpc_is_hva_active(&vcpu->arch.xen.vcpu_info_cache))
			data->u.hva =3D vcpu->arch.xen.vcpu_info_cache.uhva;
}

3. If the cache was already active at a valid writable GPA and is
re-activated via kvm_gpc_activate() with a new GPA that has NR or NW memory
protections, gpc->valid is cleared and gpc->uhva is set to KVM_HVA_ERR_BAD,
but gpc->gpa remains set to the old GPA. The next kvm_gpc_refresh() call wi=
ll
then re-translate the stale gpc->gpa and silently resume writing to the old
guest physical address.

Should gpc->gpa (along with gpc->slots_generation and gpc->memslot) be
updated before checking kvm_range_has_rw_memory_protections(), matching the
gfn_to_hva_memslot() error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D26
