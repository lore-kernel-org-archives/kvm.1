Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92F3EDE67;
	Thu,  4 Jun 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564011; cv=none; b=cr/s9xT0O6uMAn9tVXhO7BTNtO72lmIw91TiPrNHB8dUNAiBLLBvWL1F12h7WXY8OL45rkiH2firQobh1WdppCm10rNKB+izANb5yUPq8hUMFeAxPpFa/QqjWGzDlynwqxLn8/n8iX8YwvNA3Z6tPOJjHhlIBbweya1KruQBSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564011; c=relaxed/simple;
	bh=pzO/hUhIdm2xnYffmhkX+QqsoCzo448WOXd4EYvdDYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5IvGWYTqC6BGa0lHYMfXZt/PIWCQNfaHfykbb1aIKUtxy1XsoD0EeTrHHyKeQ33+RxsZEJ84SBhIAn6X0p/nhY1GNBays5aGpJekm51yG45w6NKreQBeV8UJhk2L8qluRf0sxUvpHOJ3IJe9uqnj6m2oqKXNzFU+tGl4i116pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfpefsoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfpefsoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1601F00898;
	Thu,  4 Jun 2026 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564010;
	bh=pzO/hUhIdm2xnYffmhkX+QqsoCzo448WOXd4EYvdDYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XfpefsoS9YKGQTXxZBIquD7gLbILYHBSCWKXhJL+DC7paRQqrbgdTLFwOnmX+nxN7
	 +I4imkQQTdwTRWqxIn2FBFZQ4GivVuU2gDDQYrVGH9NStkmANhpunQW1LVwSxBPjzb
	 +DZxDUjzZIQuG2cqClV7teLam4ubg4B2azHoK53vaJgEs8ujxElUS/YmptvSaNkarz
	 HLwkxD5UBiBO7HNUV8ywwcvBCtv8g/mZY7gPYSF+/b22f7pORPOALzvI/kCdeOdrDv
	 cae1qINYa68yDuIJbYw7ks/7Nyn/PWlGnks0S/1yKe+C70PWAmP9b1AX39ZbtLQLnL
	 /8iYOGWIxZiIg==
Date: Thu, 4 Jun 2026 10:06:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
	conor+dt@kernel.org, kvm@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 13/15] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Message-ID: <20260604-handwash-junkyard-ed931f40d678@spud>
References: <20260603-rva23u64-hwprobe-v2-v3-13-5529a7b28384@gmail.com>
 <20260602233750.B03631F00893@smtp.kernel.org>
 <CA+Ck9FaHADhss2sV=Z-vX4zr6VL+X=goFX_vznYE9JWBGCjwZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L6Z/nkLzzY0eiXog"
Content-Disposition: inline
In-Reply-To: <CA+Ck9FaHADhss2sV=Z-vX4zr6VL+X=goFX_vznYE9JWBGCjwZQ@mail.gmail.com>


--L6Z/nkLzzY0eiXog
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 02:46:36PM +0800, Guodong Xu wrote:
> Hi,
>=20
> On Wed, Jun 3, 2026 at 7:37=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Detection of the RVA23U64 profile fails on compliant platfor=
ms because it strictly requires the unratified `RISCV_ISA_EXT_B` bundle ins=
tead of the formally ratified bitmanip extensions (`Zba`, `Zbb`, `Zbs`).
>=20
> I disagree. But I would welcome more ideas.
>=20
> My reply is threaded in v2, FYI:
> Link: https://lore.kernel.org/linux-riscv/CAH1PCMa-5W9PsX8cDLUk6-MkcM53HO=
z2QtaxCHd+XOr7DgH5+w@mail.gmail.com/#t
> [1]

The v2 argument you made makes sense to me.

--L6Z/nkLzzY0eiXog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiFAJwAKCRB4tDGHoIJi
0u+3AP9x32Ds6znHleKlkiiRURSzdLvPa17smm81pUNtZKhw5QD/aYzHPjnRJzQq
D5/QLeE6qCpk/BA4NNLFM6goTl5hIg8=
=z8cp
-----END PGP SIGNATURE-----

--L6Z/nkLzzY0eiXog--
