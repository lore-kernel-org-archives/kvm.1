Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2829395AE4;
	Tue, 12 May 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582402; cv=none; b=XZd4WGyjiyqXUHhItmkbV38DIEsABcJKyRTt8fudESy4atR3/vJ3hKkuTxPRr0Wqep7p6ouCzCKqnMG50GWqIvoUgcgHCrW3UtoAnwEyFBz+Ezvg1bFwX3g8iMRRsYgyUcw1dLiJK4pc86NYvqDREghexjd2Wh0Kef0rpSNChV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582402; c=relaxed/simple;
	bh=kYqFLz3U39PZBxZjhz2PLB9qtZR7RBd7ohHmGtjENMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEafJxQRTvYjlpF3l7saR1tbfuqnW2EABmPjI9v7WcAXj8DTbT6JvFyt9kP0IzWvrAJGhgaYkZbqi+8vXAVW4OSYBFAxfeidBYw9Uzb/43AH9724Qv2ICutdpbv1auG+ezabmPUDLbsSTqtjpz435L2ZhIst6r+N9Yv19ICx6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrfVnXuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrfVnXuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F0FC2BCB0;
	Tue, 12 May 2026 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778582402;
	bh=kYqFLz3U39PZBxZjhz2PLB9qtZR7RBd7ohHmGtjENMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrfVnXuQVDZj3BYyQk0wOYHU/YCeUmAQ5GA2TYHN+C08ICqyZBTVBl6KkpyVuSITz
	 jABGh0yXC4nOZ/ZTutUEUpSEP2vXwGJ77MLCYBvXAOCbSMjfNt08oY8yc2r0hzU2ma
	 IcUTcyt94g7BeMaD3e60Ynuy+3uXtsOL1DCvCG0B5MyvMlYSzalHp7HAoJPQu/mMjV
	 b2MzEcVbFv1CQo7RD7J2KlPYbnCGFRd6/V3oGYtDPOD0aIE8efLPTSBEkhrwfpUhMw
	 TRiIrpibMJrOtOcrEUJslf1qKDXZAoatetvr0hxdLSZ79dOoj7vwNbMQj9UlieE1C0
	 HgS0CifgWFAWA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 71B061AC58C2; Tue, 12 May 2026 11:39:56 +0100 (BST)
Date: Tue, 12 May 2026 19:39:56 +0900
From: Mark Brown <broonie@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>,
	kvm-riscv@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] KVM: arm64: Add memslot for ST_GPA_BASE in
 check_steal_time_uapi()
Message-ID: <agMDfLbkYrqzsTXs@sirena.co.uk>
References: <20260501021639.2563219-1-xujiakai2025@iscas.ac.cn>
 <agKJnKOcvbPZ5cgA@sirena.co.uk>
 <fb12c011-27d5-09e2-14fb-ec1728bb6c81@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lFONeCo13eLNI0mm"
Content-Disposition: inline
In-Reply-To: <fb12c011-27d5-09e2-14fb-ec1728bb6c81@huawei.com>
X-Cookie: Truckers welcome.


--lFONeCo13eLNI0mm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 10:49:23AM +0800, Zenghui Yu wrote:
> On 2026/5/12 9:59, Mark Brown wrote:

> > The regression in Linus' tree that is fixed by this patch is still
> > present today.  Adding Marc and Oliver since this bug manifests on
> > arm64, adding Anup and Atish since the patch introducing the regression
> > was merged via RISC-V.

> Does fc240715fc50 [1] fix the selftest regression? It has been included
> in the latest KVM/arm64 pull request [2].

Ah, yes - that looks like it should also do the trick.  Thanks for
making me aware of it!

--lFONeCo13eLNI0mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoDA3sACgkQJNaLcl1U
h9CelAf/exz3ZWCcR/ICMXaL4rse7YblzjpNivBD7PRs5bmSp0BCBB2vga/84WFd
bb0PNM5ScIfQwD4jY9vqgJZdNt/ubQKaYDe7S+wIRkAuZbvb0bEEeMkLEOx7/waE
uiXmcT3jQmzK+1i1K4k/C+aBqGChJH0JAnhvTAw+L/BZybWqQHYaDaM8WU2Fj8D/
CBxbUvJyAxVQj3W80xh+xiwMUxSUjBNGHXAHhH5lWIu8z1POU2Ab+Cfv7Vxml2Gn
WH2PlBTtQENZ7xnHt3Ke3aIN39VQPF6/OfXaTl5faDn5wLyGsmI0g9W2C6ZDEP4n
jQ+L/brPIEtn577EaLq2+2i7Th4INQ==
=OEj5
-----END PGP SIGNATURE-----

--lFONeCo13eLNI0mm--
