Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AA2D8793
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977661; cv=none; b=eOglQCOSjJmN9A5QeEWGzPlpjYtoGuypbXHB2NX0j+UB5dsPqSIjLXsw5/ZxrSS5XZ86qjlt4dPdCxpwqcyw1/YyorOePleJPT8bt65yCEb1ryQWQEfovriEk+ni6bnb6FLY82aRQgiVWzfwyfs8VG7E2+kPSygZeAy1m8M+WSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977661; c=relaxed/simple;
	bh=+vF//yfvc2jE2puaMZ9pxB1qo9yBrJvVuzGd5agc4Co=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=futeG18/IoptG39aWKXkIfvhBarxxICs3o7VRjGV9oGOvajyivQJAnl0zX2DXevxMnIgKgTsg928OpuXnAdl7tEsTPLsWH1bMBvSlWhX+U9dh261/O9xRSojSRkVtzJnk9AEkinlhhxn1kzQn+NN4THI+6oud9qau9KOei3bJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq+owBEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq+owBEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF01F00A3A;
	Thu, 28 May 2026 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779977660;
	bh=fxRXPK90l/L5rFP3umt7uzBsEBwYL7UDyUfgjgMA0GE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rq+owBEoHm26o0406I4rAmiqMvAHDPLTeSnqsxRyoEFHDXotlEGgKSOh1jELljbGH
	 AjH0QoDJxA3Qq74bRn0caDOI9J+gr+PWlYFuzGytkcHGlv5iBUqdDG2poD+40gSotD
	 ADeCGB5lF0NoJtMv46JoyZtriwkxvzU4hojgLx23btSBOGXRo8oX2+A611vD0NIaRr
	 32MjUeovZlbRjoBj0U3R9JQ7LNnjndz2qwOjUeM+HGIeBNXCDBI4Dbj4N4ZvjRO7BX
	 vEudz8O3PX76MsLh3asQlnwEjZIrh257LwzWCR6l6sTktAcb6IvTL5bui81M+fn99z
	 HuNyVURtLM3MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] KVM: s390: Fix guest / virtual address confusion
 in _essa_clear_cbrl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528114727.142178-3-imbrenda@linux.ibm.com>
References: <20260528114727.142178-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 14:14:19 +0000
Message-Id: <20260528141420.03CF01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sleeping in Atomic Context / Denial of Service
--

commit 199d1c4ea9004cfaa67184f0dc232aee9284367d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()

This commit fixes a bug where gmap_helper_zap_one_page() was called
with a guest absolute address instead of a host virtual address, causing
pages to not be discarded or the wrong pages to be discarded. It converts
the guest absolute address to a host virtual address before passing it to
the helper.

> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index cc0553da14cbb..447ec7ed423dc 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
[ ... ]
> @@ -1188,6 +1188,7 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu,=
 unsigned long *cbrl, int len
>  	union crste *crstep;
>  	union pgste pgste;
>  	union pte *ptep;
> +	hva_t hva;
>  	int i;
> =20
>  	lockdep_assert_held(&vcpu->kvm->mmu_lock);
> @@ -1199,8 +1200,11 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu=
, unsigned long *cbrl, int len
>  		if (!ptep || ptep->s.pr)
>  			continue;
>  		pgste =3D pgste_get_lock(ptep);
> -		if (pgste.usage =3D=3D PGSTE_GPS_USAGE_UNUSED || pgste.zero)
> -			gmap_helper_zap_one_page(vcpu->kvm->mm, cbrl[i]);
> +		if (pgste.usage =3D=3D PGSTE_GPS_USAGE_UNUSED || pgste.zero) {
> +			hva =3D gpa_to_hva(vcpu->kvm, cbrl[i]);
> +			if (!kvm_is_error_hva(hva))
> +				gmap_helper_zap_one_page(vcpu->kvm->mm, hva);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does fixing the address resolution here unmask a sleeping-in-atomic bug?

Looking at _essa_clear_cbrl(), it executes while holding vcpu->kvm->mmu_lock
and acquires a spinning bitlock via pgste_get_lock(ptep) right before calli=
ng
gmap_helper_zap_one_page().

Inside gmap_helper_zap_one_page(), get_locked_pte() is called:

arch/s390/mm/gmap_helpers.c:gmap_helper_zap_one_page() {
    ...
	ptep =3D get_locked_pte(mm, vmaddr, &ptl);
    ...
}

get_locked_pte() attempts to walk the page table. If intermediate page
tables are missing, it can perform sleepable memory allocations.

Sleeping while holding a spinlock or atomic bitlock causes a scheduling
while atomic panic. Previously, passing a guest physical address instead of
a host virtual address caused vma_lookup() in gmap_helper_zap_one_page() to
return NULL before any sleeping operations occurred. With the address
resolution fixed, can a guest trigger this path and cause a host denial
of service?

I see this is addressed by a later commit in the series (KVM: s390:
Avoid potentially sleeping while atomic when zapping pages).

> +		}
>  		pgste_set_unlock(ptep, pgste);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528114727.1421=
78-1-imbrenda@linux.ibm.com?part=3D2
