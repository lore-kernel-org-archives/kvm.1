Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F83E024D;
	Thu,  4 Jun 2026 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563971; cv=none; b=ofOX+cFjI4+HCxgTltgBPiOwfY6rG0L+BfW/H3UVYGHh0zxPQRIjLuCKCM8vhNvGr2buUN6FxhegGAST41YHIC8W5UZQY+ivv3H+Z674rcWoHyF+k/KOG5n/XTKvlN0uQl6LChgV27fi4P/Glx77Joa7/aOyPC6pm/sV38KiXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563971; c=relaxed/simple;
	bh=I2BuAk6w1fvciNoxHKm+FqjPnZEQcb4D7gEkF0i5EJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaJao4PIrBcFmJMVkficvVTeRn597+yG/VMWGKuBCOrPg32QmHaWXWgm/HGXr7DuOgdwbQTUfHx3l1NSEop+aU/1NfUvmN3d2mVUgCmgfKTWReC9VeduvFyflTWtgUsXi/FCXA9H9mplvQQcNDQVZgQeVEzUurkDM3CoRQ7diaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T42jBbJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T42jBbJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000B21F00893;
	Thu,  4 Jun 2026 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780563970;
	bh=I2BuAk6w1fvciNoxHKm+FqjPnZEQcb4D7gEkF0i5EJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T42jBbJV5BU+QB43XV/oRSh3o5QLfBMbtBjajHM4SnRYfxXaXiqEnsGNtrSGVCb30
	 HB+w7wQHCuIP2VacjXflOW8ox/5kzPF9ypRw1/COVE98fxnEh8TxnxvXo4Ax0hlBOt
	 ijG+avW5+9z3wsnGFlyAwhCIt4rGaYQBwAzfYNyLITz0V0i2flJ+525RCHAZhpBtbs
	 c92DjoExM3jUCIKX93H3v6OxFKsivXQFIYgldcDVkeWHbqQS9bfVl8Ox3NAL+JP4ME
	 PKry2yLMJz/pmnaXhhJEgPZfbA4wT/xoTqOgbfXttUN8nPsbxFvruuO5qXlk4NlOGy
	 fpnT1NgDLrJew==
Date: Thu, 4 Jun 2026 10:06:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	kvm@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 07/15] dt-bindings: riscv: Add Zic64b extension
 description
Message-ID: <20260604-mating-multiple-458aafa93791@spud>
References: <20260603-rva23u64-hwprobe-v2-v3-7-5529a7b28384@gmail.com>
 <20260602232859.3494A1F00893@smtp.kernel.org>
 <CA+Ck9FYWCbHO6-BU48KLx_Lov7pJiSbAP8j3Te_uqFFq81rUjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YLEgTo6BKmXMajGs"
Content-Disposition: inline
In-Reply-To: <CA+Ck9FYWCbHO6-BU48KLx_Lov7pJiSbAP8j3Te_uqFFq81rUjg@mail.gmail.com>


--YLEgTo6BKmXMajGs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 01:23:24PM +0800, Guodong Xu wrote:
> Hi Rob, Conor,
>=20
> On Wed, Jun 3, 2026 at 7:29=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > The properties block requires multi-letter extensions to be sorted
> > alphanumerically. Because '6' comes before 'c', would it be more accura=
te to
> > place zic64b before ziccamoa?
>=20
> On a double check, I found here Sashiko is flagging a real ordering issue.
> (Although it exists before my submission.)
>=20
> In current riscv/extensions.yaml, zic* entries are split into two groups:
> one (ziccamoa etc.) sits above the Zk* block, the other (zicbom, zimop,
> etc.) sits below it. This is wrong considering the rule says "# multi-let=
ter
> extensions, sorted alphanumerically".
>=20
> Would you like a standalone patch that re-sorts the zi*/zk* ordering
> properly? It's purely cosmetic.

Please.

>=20
> If there are no objections I can send it as part of my v4.
> Let me know what you think.
>=20
> BR,
> Guodong
>=20
> >
> > Does it make sense to place zic64b in its strictly correct alphanumeric
> > position, rather than continuing the out-of-order grouping of the exist=
ing
> > cache-block extensions like zicbom?
> >
> > [ ... ]
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u=
64-hwprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D7

--YLEgTo6BKmXMajGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiE//gAKCRB4tDGHoIJi
0p5yAQCwPebcWoF5lul1ddE3nY4JN/yATOkQJS4U4ab25sf9IQD5AW/YM/B7ntxb
MFAZ4L+sgWE2Pb/SLhWU7bTrPU3dJg0=
=6i2i
-----END PGP SIGNATURE-----

--YLEgTo6BKmXMajGs--
