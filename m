Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB5487BE
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423323; cv=none; b=kYQpO4beT5VB+0sY0xU3uJgD66Fzow/a3YhRBT/09j8M3nTHAB3FHIZnhbEKN8yRxU7u0vYZ8imYe9tqX6K31xWGu4w666cR8p4M/RSz8n+yBc12CsuMqmlzxZzumUNW15SbK9hezl8rAcGeacF+KiJ3PhnwWpPBE1tLY5mMJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423323; c=relaxed/simple;
	bh=JVONB/pflNKzW94+Ry0ieuvQaTTOs5+2toIOIJ8ZCaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sUsFh/ndgLpFbEzO6x8I4FOGTLOJTYcaRjlBc8XaRBzp/4eT1OfYakBwzUE3ERFJBPHAgjoVJCktryemI2XnVbzySDu33Rj9LPX6ez/IiDO7SKBC71lelEnukEXtCy6bdFjJlrBzsocyvdAU5tu1U3B+7MXQ/VPvE+Kct4z5EFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwC6rJ9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwC6rJ9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66AE1F00893;
	Tue,  2 Jun 2026 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423322;
	bh=LoAMcLHQhKFhhlo4s11WsvrSs6Yl/50WPnRBggMZlQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwC6rJ9X0BAcYYuxMueSffC84h3BXtNgfmA2tBKx9a8KNmfGrSe/Diagj1QSVghRy
	 jmrdvRGvMdHjmuC5Efn+tvpDeycoDnNLi16tyBVxCaMudBkdRxP4PfXZWpYACpR6KQ
	 bfj0SC4wiqSGhprH5qLKnyP4pvHID2ikHzVMkKflb9wu4AB4MpenWW+Ypp+/QP5vlw
	 zmBuqJuSAJvyAj9I3CxQ6+mbvcUR6k23S0JYU2BGygBncS7T46uCHg3icOJ5NGgJ1z
	 aqbuifDOd0H22yWNLu72LARFxvkwCEe9X+WzlajGlCEYjQ+htn7IUgM4x2LtyR/GEA
	 IMDs5XXHwjeBQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 02/10] KVM: s390: Fix _gmap_crstep_xchg_atomic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602174819.255785-3-imbrenda@linux.ibm.com>
References: <20260602174819.255785-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 18:02:01 +0000
Message-Id: <20260602180201.D66AE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `__must_check` return value of `dat_crstep_xchg_atomic` is igno=
red.
--

commit 1706c8ed134b28e76629105e32d1e86819b9628e
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix _gmap_crstep_xchg_atomic()

This commit updates _gmap_crstep_xchg_atomic() to handle unshadow events by
clearing the vsie_notif bit from the existing crste and returning false. Th=
is
prevents the installation of shadow crstes without the vsie_notif bit and
avoids infinite loops for callers not checking the invalidated flag.

> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
> index 742e42a317445..5374f21aaf8df 100644
> --- a/arch/s390/kvm/gmap.h
> +++ b/arch/s390/kvm/gmap.h
[ ... ]
> @@ -273,11 +273,14 @@ static inline bool __must_check _gmap_crstep_xchg_a=
tomic(struct gmap *gmap, unio
>  		gmap_unmap_prefix(gmap, gfn, gfn + align);
>  	}
>  	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
> +		newcrste =3D oldcrste;
>  		newcrste.s.fc1.vsie_notif =3D 0;
>  		if (needs_lock)
>  			gmap_handle_vsie_unshadow_event(gmap, gfn);
>  		else
>  			_gmap_handle_vsie_unshadow_event(gmap, gfn);
> +		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);

[Severity: Low]
Does ignoring the return value of dat_crstep_xchg_atomic() here trigger a
compiler warning?

Looking at its definition in arch/s390/kvm/dat.c, dat_crstep_xchg_atomic() =
is
declared with the __must_check attribute:

bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste o=
ld,=20
                                         union crste new, gfn_t gfn,=20
                                         union asce asce)

If the kernel is built with warnings treated as errors, could this unhandled
return value cause a build failure?

> +		return false;
>  	}
>  	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
>  		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602174819.2557=
85-1-imbrenda@linux.ibm.com?part=3D2
