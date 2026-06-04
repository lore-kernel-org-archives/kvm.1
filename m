Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F433A9FF;
	Thu,  4 Jun 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590546; cv=none; b=JthqyjTNlovNwRBXyeCcw9He3Ac2o8/M5e/FHEq3xkmm9s8OkG2TkMggZtyBGBtGX0ONBLkCsBBEa+m4/hU7tbvFq3yu+I02YAgMG5Mv0b0V7KOcRa58CD2xTZ9TZix8oM+iD3sQ6dwW0nrRxzuy76x6SLYKjwtwxaUVqdWsU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590546; c=relaxed/simple;
	bh=MDyqratiLi05/uyBtnVhplm4LWe2ncyRf8w2liNJtvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gapgsCUGRXdxUwiX7/tQGSFm9/EvVMycrU1XFch1i+MO1KEJjaE8KTuOmmwQU6vOwoemaadtAfhGIH7txz4Sm6z3yKqnZ7N/FifPiMOzGm8fFzY6G3j94z833+zVZo/48E1xpSwrv4WSjisD6VtB7IdS5DhkRmO0x7C3fxXfPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuseX9g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuseX9g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E31F00893;
	Thu,  4 Jun 2026 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590541;
	bh=s7vqTQyEXNNXtpVsO2TTPhoidp7pJW7kCKN/X/mQRWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HuseX9g3x2esz5tWdSRaffD0vdC5Ld4Dz9yENuKR1qheyFwvr6EkcttK7Lci4Cdpx
	 SuS+4bz3pbrLrAD4vIQyF0JjWW/Jt90QnfbclwemsCLyoXgQxwhBUgxNEzlCXJuLYA
	 0VO38/S5jnHzodKuVrf646Sjod273AFYjwJbIebFsWO/KKwYPo7HP2LpNzESDSVlIA
	 RTphQjJa1E5FLAyEMWR1oHtgO0Zjx7xSfyaSp7jEs0AWN+tHPTeZ0sZiGnYajETvy+
	 DONBiEQ3h5qMYKspX8UNK2/D+i8IRwXNWRD4bsPbSQH/H3YWJnc+0f5XKJYHHgNC2M
	 cq/3zGLswFt/A==
Date: Thu, 4 Jun 2026 17:28:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 08/15] riscv: Add Zic64b to cpufeature and hwprobe
Message-ID: <20260604-activate-antidote-ebb9197b286f@spud>
References: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com>
 <20260602232800.768311F00893@smtp.kernel.org>
 <CA+Ck9FbKRM0wjJMg1fQpdwmow8cf_zTfir7V6+T=CRxU+vomdg@mail.gmail.com>
 <20260604-rice-protegee-3a0b8e4cb609@spud>
 <u52q565xhv5s7gz3wbh4heplhbm4pv732s5kqvf4deiw6ceb4t@n4bnpzu5kabs>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UqEY10bqswxCer84"
Content-Disposition: inline
In-Reply-To: <u52q565xhv5s7gz3wbh4heplhbm4pv732s5kqvf4deiw6ceb4t@n4bnpzu5kabs>


--UqEY10bqswxCer84
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 09:31:36PM -0400, Guodong Xu wrote:
> On 2026-06-04 10:17, Conor Dooley wrote:
> > On Thu, Jun 04, 2026 at 02:42:22PM +0800, Guodong Xu wrote:
> > > On Wed, Jun 3, 2026 at 7:28=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> > > >
> > > > > @@ -154,6 +154,23 @@ static int riscv_ext_zicbop_validate(const s=
truct riscv_isa_ext_data *data,
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_=
data *data,
> > > > > +                                  const unsigned long *isa_bitma=
p)
> > > > > +{
> > > > > +     /*
> > > > > +      * Zic64b mandates 64-byte naturally aligned cache blocks; =
cross-check the
> > > > > +      * cbom/cbop/cboz block-size device-tree properties to avoi=
d inconsistency.
> > > > > +      */
> > > > > +     if (riscv_cbom_block_size !=3D 64 ||
> > > > > +         riscv_cbop_block_size !=3D 64 ||
> > > > > +         riscv_cboz_block_size !=3D 64) {
> > > >
> > > > [Severity: Medium]
> > > > Will this check erroneously disable Zic64b if a platform does not i=
mplement
> > > > all three CBO extensions?
> > >=20
> > > Zic64b is mandatory in RVA22/RVA23, which also mandate Zicbom,
> > > Zicbop and Zicboz, so all three block sizes must be present on any Zi=
c64b
> > > platform.
> >=20
> > Where do you get that conclusion from? That's not how we treat any other
> > extension defined in the profiles spec. My understanding was that even
> > if things are defined in the profiles spec that they're fair game for
> > independent use.
>=20
> Ok, I get your point. Agree, Zic64b/Zicbom/cbop/cboz can be implemented
> on each hart independently (at least spec doesn't say no). With this in
> mind, the validation of Zic64b should be like this:
>=20
>     if ((riscv_cbom_block_size && riscv_cbom_block_size !=3D 64) ||
>        (riscv_cbop_block_size && riscv_cbop_block_size !=3D 64) ||
>        (riscv_cboz_block_size && riscv_cboz_block_size !=3D 64))

Or you could check for the extension instead of the left-hand sides
here, but I think that becomes more complex because you need to start
returning EPROBE_DEFER sometimes etc.

>     return -EINVAL;
>=20
> This will allow :
> 1. A Zic64b hart with 0, 1, 2, or 3 CBO extension and block_size 64
>    passes the validation.

I'm not too worried about the 0 case here, people shouldn't be using
zic64b if they don't have a corresponding extension after all.

> 2. A Zic64b hart with CBO extensions but block_size is not 64
>    fails the validation
>=20
> Thanks for the catch.
>=20
> I will fix that in v4.

btw, can you fix your system time? It's like 12 hours in the future and
that impacts the timestamps on emails you send.

Cheers,
Conor.

--UqEY10bqswxCer84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiGnygAKCRB4tDGHoIJi
0jalAP9FtdZ57Gi9zqLt2uUSAeF6mH9GDBRQVZs/amLehpDPIwD/bbvLTDnhX8Nh
QU4AIz0bQgcQ6NL0WZG49D7VpBxZCQY=
=ctqz
-----END PGP SIGNATURE-----

--UqEY10bqswxCer84--
