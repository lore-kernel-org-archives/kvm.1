Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AA3A5435
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720721; cv=none; b=had0Vy51T4iUwklNuPriSRIP5AOT0oVs4hR9ZujHpbp8mbZYTvYYKZLlKTArZSLuafuJ5fGoIp1WBvkpPz85a0x/igUEKiMZS5zLBW3TfZ/OOSoI7GdoG8oOUDZT+rbiXFnR3groryEYZdA7RsN1ktPHP8HyvRJSZGnEEc/enKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720721; c=relaxed/simple;
	bh=WuYu+4TOC8tHdLsXtQyWcCG64zsPRY/FEntInpuiEdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLOYjwsFpXY8/PK/Zf2OUz/710+EZjMibiobvTWztDJfbHdSY7GJQWyX9XhCdvHgXX9rsNuSmvUX6H2bD9v9/yayIeZmXWt8fb8a1gaoGQrkuspfpzc0vSVv+wECTf9Ib0upQ3cQDR2a7TXjr9V6TMJqz1XMC+R4IJZCuiKPOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpuLSvx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpuLSvx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F28C1F000FF;
	Fri, 18 Sep 2026 08:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720719;
	bh=kUFRICPbyyS7WFMn0cB6RyZrz/MPp81zPG/UXjY/aBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpuLSvx0qVvBPWDbqLPBtZ4rglAiq3x9FV4LCmJqQU5/iWlj9OPh1GjWUm86KqGfV
	 dTJQv1ipnCDGqrdo/nYtsbH+NZ10oFPFEaSn2B3fgKTADMKUr8t+jDUOhF7wOG6mjZ
	 AQeC1la6qNlc5HZ+voAf0iH9qvOxjnc9dng0H9RyMAWlURwymxTvV7E6JBjO9whvsw
	 31QM0r3TmVqMk55x2sRGSCXn2/inEP/E/Q39S4kNYX5OBwGiJW5K26eFqg8hbQbU5W
	 pTrNAHj5uo7C+/Xtf+zd0OLGH1Jwc6rbnwLJFAk2kSOB4dHJmVUuir7QSIfStV/K56
	 lr6H9obSVtlQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/28] KVM: Take memory protections into account for
 accesses with cached gfn->hva
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-20-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:38:38 +0000
Message-Id: <20260918083839.4F28C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: loongarch build failure due to unrenamed ghc->generation field
--

commit d698f3639de00de4e2127e86617e1f29da8afef7
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

    KVM: Take memory protections into account for accesses with cached gfn-=
>hva
   =20
    Account for memory attributes when accessing guest memory through
    kvm_get/put_guest().
   =20
    This requires tracking the memory attributes generation as part of
    gfn_to_hva_cache's data, invalidate the cached information if the
    generation changes, and failing to refresh the cache if restrictive
    memory attributes are found within the GPA range.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2d85d7c9e0046..f10b14293e60e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -3560,15 +3560,22 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm=
 *kvm,
>  	 * If the requested region crosses two memslots, we still
>  	 * verify that the entire region is valid here.
>  	 */
> -	for ( ; start_gfn <=3D end_gfn; start_gfn +=3D nr_pages_avail) {
> -		ghc->memslot =3D __gfn_to_memslot(slots, start_gfn);
> -		ghc->hva =3D gfn_to_hva_many(ghc->memslot, start_gfn,
> -					   &nr_pages_avail);
> +	for (gfn_t gfn =3D start_gfn ; gfn <=3D end_gfn; gfn +=3D nr_pages_avai=
l) {
> +		ghc->memslot =3D __gfn_to_memslot(slots, gfn);
> +		ghc->hva =3D gfn_to_hva_many(ghc->memslot, gfn, &nr_pages_avail);
>  		if (kvm_is_error_hva(ghc->hva))
>  			return -EFAULT;
>  	}
> =20
> +	/*
> +	 * RW memory attributes are incompatible with GHC. The RW protection
> +	 * check has to happen after storing the generation number.
> +	 */
>  	ghc->attrs_generation =3D kvm_mem_attributes_generation(kvm);

[Severity: Low]
Does this patchset break the build on LoongArch?

In arch/loongarch/kvm/vcpu.c, kvm_update_stolen_time() and
kvm_vcpu_set_pv_preempted() still reference the removed ghc->generation fie=
ld
and fail to verify memory attribute generations:

arch/loongarch/kvm/vcpu.c:kvm_update_stolen_time() {
    ...
	if (slots->generation !=3D ghc->generation || gpa !=3D ghc->gpa) {
    ...
}

arch/loongarch/kvm/vcpu.c:kvm_vcpu_set_pv_preempted() {
    ...
	if (slots->generation !=3D ghc->generation || gpa !=3D ghc->gpa) {
    ...
}

With the transition to ghc->attrs_generation and ghc->slots_generation acro=
ss
this patchset (specifically since the prior patch "KVM: Introduce a generat=
ion
number for memory attributes"), these manual generation checks will fail to
compile.

Could these be updated to use kvm_check_gen()?

> +	if (kvm_range_has_rw_memory_protections(kvm, start_gfn, end_gfn + 1)) {
> +		ghc->hva =3D KVM_HVA_ERR_BAD;
> +		return -EFAULT;
> +	}
> =20
>  	/* Use the slow path for cross page reads and writes. */
>  	if (nr_pages_needed =3D=3D 1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D19
