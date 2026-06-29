Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5913FDC00
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727304; cv=none; b=G9JP1HbIYQe6ewGCy3LtrwmbkZyI+rTwZmxsVdstlO4eGsJZFWFpvaqubD9lHmgOiWWoyxY4Yrp1fz88MwKmwZIDpefzDNNIqvEhQArcuD6/8HUqc4MWLKaOg3dnZpDdedWYI4KTAoyd8Ew8MpBe8SF9WHMSPvlzJz1nH7LCZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727304; c=relaxed/simple;
	bh=BhvuqdmZgGlLMonxzMz6WGkvhntvo8o92vKjsq07kcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrSgweg8eMIrkr2lzSaQpV60+Oah48JQ3qggtzWgEzdXtlEh5qCX6EFtKxeHy3INVAKKG/Ik6HUXX/8GEv3H0x+ElbMWDPGEcBsrzK5Upvp7e10mQO5VsYta1GLuzDoigdtBH7SXcBBA5qJ+XIWJoT6lBLb7wn6Omb8SRtlcyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=g8w7yWNg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="g8w7yWNg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-474e7ba9fd6so15742f8f.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782727300; x=1783332100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhvuqdmZgGlLMonxzMz6WGkvhntvo8o92vKjsq07kcY=;
        b=g8w7yWNgq0ay4L7K6Eo8OYVXHlNd5+kfoIgkcIu3b2JKPn4KvxT3kbCCj9Lh2dAEns
         2899z1BLAn7IZ/o5iyTwOMRNAmyT+23ei5DVVnMXO677BGVZPwFCcUjeN8Vm52gFSjnf
         A/TsZ50YIqh84zni+CrAqvcR0hf7L4GHJXmDZMSvEeNmzlhDP+S4P9Am0qI/Rz/u4s43
         PXEKptFoD/nigcdYq9BSZtJl52gwsLUcM2PPbXS5pvA7HfXfPqRESeKAjLy888vA8yWJ
         oOFcWoKzB0IjfRknuGwk/haFcBs1Ode1WJXZaLug/tn8hivVBT3nWftrW2VoLIY+UkF2
         lc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727300; x=1783332100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhvuqdmZgGlLMonxzMz6WGkvhntvo8o92vKjsq07kcY=;
        b=DkJQKeIMTGNqmWiD0jH7Mzv7VkxHPY/e9syG43ugcoBBCO2Awv2nCro9qf4zIrxPeG
         /eKEGfxf8kJcjjbE8ilM/kp3xBIKQYajoxVfiC/WpP/d+xAvuQmUPeATnR65sRv4qECR
         8GwE07DIuAHVRWCyjHgiV4y3/IZ5VVoT8l7JYeV2Y+uDSdRT4ynJPczeK7eaWqCNXZCb
         ag7DsA9LQjsKPsyZVR76c/8HhPmJ3L+zW4tB/ZBr1sl2+cJ1Lbpxan6fcPwb/pRUzck8
         cMdaYVIo4Lk65ts5vrhzIERwQkObIPCsWHYpXou3k9eApR+OOqlUNEZ8vVUYn8KS8YnP
         mB4g==
X-Gm-Message-State: AOJu0YyB9+83ZpgP+sQ+0vaG76AC5d5Zy4ELjxBFv7Ml8zpN0JjYRc37
	vYGfineqvmLmg4Fbfrqsk1X3ca9rzwbaj1aUnVbsYk4N5ascldR7ZVkZTUbbqmBNtIL3N/vm0Y8
	8Yvzc
X-Gm-Gg: AfdE7ckwitR/9L25SrObLUOztj/lpyoq4lP/g3bvQje19i2UT7DxVOAOPEZIUpnf+vg
	N1vbZmNYXK4SOxXaf2fv9HR4goEO9RkiRFH3xiFTm6pLaHiPQPLMCUkAkHRATJ6TXh0dky6T4st
	QrPtYrPNOJdApgD1DG0qr3n8rp8IJfRmDTr7f68Ywclis+farPijs3lIUqjeyH8XdNpQsJrmbgf
	d1WUz6BpaE/CAlxukje/BfD1ZEvydFBwKMAXmCvbomybgRsVP1YBgn2SST53mLlwa3ZKbQWc2DO
	W0fz2yA/I+JfVmQklyI+ry0aBdMLO1nHtMpMTDaoilpokjEJeKsRHw7AIhrmp79v5Vw6l0oSMhM
	3r6ZgbJ8NpfoIFztuTdI7Btc8T4ULVuTsY/q57mpLKzQbo60xcWK2EuFjYw3QFi4bqtCIt7bBiU
	5b3YAngQrbmpvuFg0LPQsZ/3hJArwL06XSeJ6nD+uS6bn4tAPJUgK4XEMlhV+JMQmGUsCRy/0tg
	aq/
X-Received: by 2002:a5d:618b:0:b0:46a:1f35:1133 with SMTP id ffacd0b85a97d-46fb87d3aa9mr12390832f8f.25.1782727299837;
        Mon, 29 Jun 2026 03:01:39 -0700 (PDT)
Received: from localhost (p200300f65f47db047d55c3c4f7db55be.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7d55:c3c4:f7db:55be])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee018e8sm54708881f8f.11.2026.06.29.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:38 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:01:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 13/16] LoongArch: KVM: Add include defining struct
 cpu_feature
Message-ID: <akJCE-04_eK-PGwS@monoceros>
References: <cover.1782682124.git.ukleinek@kernel.org>
 <dd99dd31bbdb74884b27ea940e76872913b6dc1e.1782682124.git.ukleinek@kernel.org>
 <20260628221539.4440E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6363enzrownmmoo"
Content-Disposition: inline
In-Reply-To: <20260628221539.4440E1F000E9@smtp.kernel.org>


--x6363enzrownmmoo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 13/16] LoongArch: KVM: Add include defining struct
 cpu_feature
MIME-Version: 1.0

Hello,

On Sun, Jun 28, 2026 at 10:15:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Incomplete error unwinding in LoongArch KVM initialization leads=
 to memory leaks and dangling pointers, risking Use-After-Free crashes.

This is a pre-existing issue that is out-of-scope for this series. So
I'll not address this issue.

Best regards
Uwe

--x6363enzrownmmoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpCQn4ACgkQj4D7WH0S
/k4Vkwf+K81o8OzEov3caLTz+vbPdJOpWHlUreaQWlJFp1oKWQenKpBUrtxEoDT/
oRa1WgfUOz0SZDpXC+d3uRiqkhOV32KJ+PkPaoKIAtTQYB/jVQSz6h3RHwqKEJz5
jiQP8SgbcZVjMbfcSDwqfeLW8NuHxHqOVl6AZR3ijVBuY34sgAfNpXKmUIDBVmkQ
Ce8EuCNUzWV07Uep/ToTV/5/109eG+tqfh/TukWZl4KdlOyOAf91SZLPXYyNWfLD
2axttFi98aM+Z02slFfWZGfqJ9XdvjO+LAj0G1vSAo6tvlmZfbPBagUJQiFE++PN
ze9zsxM5Tqkuy9KTlhcYcO0srPd1lg==
=R2jD
-----END PGP SIGNATURE-----

--x6363enzrownmmoo--
