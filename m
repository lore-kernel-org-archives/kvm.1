Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50A3FD95C
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022808; cv=none; b=abO1OBcTDRo3kFgsoso6CNX4xPvFkdfeFbSAM/a501OC/gujP8uzQKJistxp9fVaorjzQUwIHggA3EqxYk05Cu+yndGOnnZWqD8CrHgDj0A9rGILWGsEpRDyHPaVkelCTkXl4TTW3Qi1UtN2Kt/WnIJ672YbG1h6783/F6lc0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022808; c=relaxed/simple;
	bh=VfH9LGZUMTYegd/Bzv8UU3wNweKq2zzgov3XFILWfYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WNuPRCYbNq9XtAUA8Opl6GsHJLLcCN2yj8IYcvCj1MeVLPYLijhsJ17XWJbGDEWmTRWBJbOWLZL69aR9XTUG2u0JoOPqdh2ByIn+4L5SPq5eE/ZN+4adNUsC0KfH3iakwLJY32E2h4jdMOYAc7UZyr4qmMZ5NIArnd8ZqvLmqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOWFqMaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOWFqMaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CD31F00893;
	Tue,  9 Jun 2026 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781022807;
	bh=g894BgMtN/gVQ87leMONI6+j9eHxQUA5SXiC+yVEYmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOWFqMaOKHB7wUkl+L3GItyTEWarE/9j3Gnk7CwU6h62WBfffbu/Ymh18Hi48V1LV
	 DBTVF/v2jsWxIygGQQDsaQjJ4BQkeQwTE1m+d/AYBOSPDZJ5W4l72kbbHzhH+P6lKb
	 o+VhOiBS+8Mt8JU41gl4bJ+vNGtdtkwxFtu1qDe8/HFZyQ9+tbnEdwbFzGq8OWsFsx
	 DhCYhOdZLR/+PUqDZ9d/lWyM7L7Bt1ZqBbB43R/5bP8gRjtVUur3kzlwZHy2/+DMH/
	 jW40McCST0Hp2Ua5a4ZIfflW8V4Q1oN/6J+DjK6pwG3Bad9Hno3lLAZHh4eY2cZGpn
	 Mttwtxjaz/uAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] KVM: s390: vsie: Use mmu cache to allocate rmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260609161646.695361-4-imbrenda@linux.ibm.com>
References: <20260609161646.695361-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:33:27 +0000
Message-Id: <20260609163327.73CD31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Slab out-of-bounds write due to undersized MMU cache allocations

Pre-existing issues:
- [High] Incomplete forward progress guarantee leaves preexisting livelock =
unresolved
--

commit d137e1b91e093869ffa253ca4d6339ea68a1d49a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Use mmu cache to allocate rmap

Use kvm_s390_mmu_cache_alloc_rmap() to allocate the rmap in
gmap_insert_rmap(), instead of a normal kzalloc_obj() with GFP_ATOMIC.

> This guarantees forward progress.

[Severity: High]
This is a pre-existing issue, but does this actually guarantee
forward progress?

Immediately after allocating the rmap, gmap_insert_rmap() calls
radix_tree_insert(&sg->host_to_rmap, p_gfn, rmap).

Because the radix tree is initialized with GFP_ATOMIC, node allocations
can still fail under memory pressure and return -ENOMEM. The fault loop in
_gaccess_shadow_fault() catches this, drops the lock, calls
kvm_s390_mmu_cache_topup(), and retries:

again:
	rc =3D kvm_s390_mmu_cache_topup(vcpu->arch.mc);
	...
		rc =3D _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
	...
	if (rc =3D=3D -ENOMEM)
		goto again;

Since kvm_s390_mmu_cache_topup() does not call radix_tree_preload(), the
retry attempts another atomic allocation, potentially leading to an infinite
livelock when atomic memory is exhausted.

> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> CC: stable@vger.kernel.org # 7.1

[ ... ]

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 52d55ddea8d4f..1d289f8fa3b20 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1000,7 +1000,8 @@ int gmap_pv_destroy_range(struct gmap *gmap, gfn_t =
start, gfn_t end, bool interr
>  	return 0;
>  }
> =20
> -int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int leve=
l)
> +int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn=
_t p_gfn,
> +		     gfn_t r_gfn, int level)
>  {
>  	struct vsie_rmap *rmap __free(kvfree) =3D NULL;
>  	struct vsie_rmap *temp;
> @@ -1010,7 +1011,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, =
gfn_t r_gfn, int level)
>  	KVM_BUG_ON(!is_shadow(sg), sg->kvm);
>  	lockdep_assert_held(&sg->host_to_rmap_lock);
> =20
> -	rmap =3D kzalloc_obj(*rmap, GFP_ATOMIC);
> +	rmap =3D kvm_s390_mmu_cache_alloc_rmap(mc);

[Severity: High]
Does this result in a 1-byte allocation for the rmap?

Since mc->rmaps is an array of void pointers, when kvm_s390_mmu_cache_topup=
()
populates the cache in arch/s390/kvm/dat.c:

	o =3D kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);

it evaluates sizeof(void), which is 1 byte. When gmap_insert_rmap()
fetches this 1-byte object from the cache and writes to rmap->r_gfn
(at offset 8):

	rmap->r_gfn =3D r_gfn;

can this cause a slab out-of-bounds write and memory corruption?

>  	if (!rmap)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609161646.6953=
61-1-imbrenda@linux.ibm.com?part=3D3
