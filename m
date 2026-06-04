Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B1291864;
	Thu,  4 Jun 2026 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564663; cv=none; b=Dp9le0IYK7dMPuSk/8nuGJsIIQl1SXoAPi7Q0zhyXlzh5VyGTKuW41rmCwusIuioFysyBCKDBXa5+9VCCkcxyLQmuQFNhmGBMxunVTOf87Vxy+qL6/tfZrwWON3M7C+SYkFdJxEU5Wt3Y2q/YV0NYiAGeJ6cvOtCdtceJV3dpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564663; c=relaxed/simple;
	bh=NJUoEtNi3D7lA5WLckwmNcKH3HbonR5bX6LZ3nms/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYWZTRM9eMPiRt22Fs4m0d9VbCArTKwY+s+cCbFpb7F3cWw9UCJLO23AvvsNvWyYgmnJ7jCcPps0oE7N4jhEzPuplJdZSmDGHWn8k8V0tsnyIUDlrqXjCmYG0sNjCMAPzQxtTzZMT0V8PYAmk4zhUU+HPRRJSLSezC7VZd+U8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUJZ4dNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUJZ4dNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DAE1F00893;
	Thu,  4 Jun 2026 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564661;
	bh=zolsh5QoPwd6yCMBjYRicZ1UJXjop4dkz0xGC8IJn0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DUJZ4dNfV8aid8qnhiJU39jQ5Q97yif+b0Gm+uyeJ8dV1wHUzShoFsVtM/376TA6O
	 dka3xc6xs0h+tlbdTTh77ABePCZe7fk65mcuBkFsif/okAwS2+nTVxxuNqSmKgP7bM
	 wg8z0Xk/CVJN6U0FYaW7hLmIZV3uuqYYIDdH8dgO5ZSURUeXg5d7CUVfIbjp52SqWR
	 3e5Xm21BUya+LG5qp6kkTMrJ5zC5KYz7lm3qc0uPQO3vgFoCrx/Nw11bCVXQILOT4g
	 IbStECiQsfXpXwJPRXL5TNUwOnWJYve82tyoPss3KDXrMtzkmnHwCp1qOxEJS0WrAc
	 As6m8Mgy2QpEg==
Date: Thu, 4 Jun 2026 10:17:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 08/15] riscv: Add Zic64b to cpufeature and hwprobe
Message-ID: <20260604-rice-protegee-3a0b8e4cb609@spud>
References: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com>
 <20260602232800.768311F00893@smtp.kernel.org>
 <CA+Ck9FbKRM0wjJMg1fQpdwmow8cf_zTfir7V6+T=CRxU+vomdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s29g3JLG5h39yneL"
Content-Disposition: inline
In-Reply-To: <CA+Ck9FbKRM0wjJMg1fQpdwmow8cf_zTfir7V6+T=CRxU+vomdg@mail.gmail.com>


--s29g3JLG5h39yneL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 02:42:22PM +0800, Guodong Xu wrote:
> On Wed, Jun 3, 2026 at 7:28=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > > @@ -154,6 +154,23 @@ static int riscv_ext_zicbop_validate(const struc=
t riscv_isa_ext_data *data,
> > >       return 0;
> > >  }
> > >
> > > +static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_data=
 *data,
> > > +                                  const unsigned long *isa_bitmap)
> > > +{
> > > +     /*
> > > +      * Zic64b mandates 64-byte naturally aligned cache blocks; cros=
s-check the
> > > +      * cbom/cbop/cboz block-size device-tree properties to avoid in=
consistency.
> > > +      */
> > > +     if (riscv_cbom_block_size !=3D 64 ||
> > > +         riscv_cbop_block_size !=3D 64 ||
> > > +         riscv_cboz_block_size !=3D 64) {
> >
> > [Severity: Medium]
> > Will this check erroneously disable Zic64b if a platform does not imple=
ment
> > all three CBO extensions?
>=20
> Zic64b is mandatory in RVA22/RVA23, which also mandate Zicbom,
> Zicbop and Zicboz, so all three block sizes must be present on any Zic64b
> platform.

Where do you get that conclusion from? That's not how we treat any other
extension defined in the profiles spec. My understanding was that even
if things are defined in the profiles spec that they're fair game for
independent use.

>=20
> And architecturally, all the block sizes are one quantity: under Zic64b
> that value is 64, so the three must all read 64.
>=20
> Anything else is a misconfigured DT, and the kernel should not trust
> the zic64b it claims.
>=20
> BR,
> Guodong
>=20
> >
> > If a hardware platform implements Zic64b but omits an optional extension
> > like Zicbop, the riscv,cbop-block-size property might be absent from the
> > device tree, leaving riscv_cbop_block_size initialized at 0.
> >
> > This unconditional check evaluates 0 !=3D 64 as true, which would spuri=
ously
> > trigger this error path and disable the valid Zic64b extension.
> >
> > Should this validation only enforce the 64-byte size if the correspondi=
ng
> > block size variable is non-zero, indicating the extension is actually p=
resent?
> >
> > > +             pr_err("Zic64b detected in ISA string, disabling as the=
 cache block size is not 64 bytes\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u=
64-hwprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D8

--s29g3JLG5h39yneL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiFCsgAKCRB4tDGHoIJi
0kmpAQCdqwBkWDI7x445r/zA0rfGQPELCLTO1H1yGuoLhCaP6QEA+bZsJdd/i+Rl
u55GwFferDMjlBq4aKLrk94fXduzuAI=
=zFrC
-----END PGP SIGNATURE-----

--s29g3JLG5h39yneL--
