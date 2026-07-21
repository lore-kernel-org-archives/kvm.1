Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052F2248B3;
	Tue, 21 Jul 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634365; cv=none; b=RrZi2Lgoy4cwjsquXZOp/JHoV6UxuK9RPSUMMYfp2n6RiKMLNVqMHW7JSeXPO4dwbJm+M6Kmg4j4NTbNDbzs4frnY/DnZ4ayLqmig+VcYPnru1iB9g23CEZ/CVpaoY5zxaCQg4oyj/a1+XbTCQyDfEcqO43SaH0VrwUJL6LSoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634365; c=relaxed/simple;
	bh=kk50cYQMGHuZuokC69SeuiVqoxNAG9nTUtnxJcrBT9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rI+FhWz32vEM2FbfTa/20oXOczAYqdKyKnOSXBi96ePVcDP9+OQPSs2YTZzeM0vXE3s/THIw6/XECHJ68sFeostGEJcRNN6qx3Db2Rmt3WVBSnqEF+amgmFmWqp4xL19mzzvaot1y9PRkmi1mMbVc2X9A+IU4NU7pH/uf8YbpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxwTNXqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxwTNXqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58FC1F000E9;
	Tue, 21 Jul 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634363;
	bh=O6mBwqOwFtIEb9qVMfY1j8PTUc+zdIeCyy/gQ7tKJ+8=;
	h=Date:From:To:Cc:Subject;
	b=BxwTNXqcgLGfiLAqSKQpUdRlGt1f+0Hu/EgYIyG+qZ74q0G6UL63Hh04sx1A7r2Jh
	 X/c7djasY/MiPNreQDoQ8an8GwIkLjN/gQRXLGpwyWPEel0R3kN3yyEjHOCioXQvqT
	 Gdd1yOLMm01ygZfmml6KQJhwc/Hf8mwV2Bh6XCV/ryIoP8EPELPv8GyKCi3BtsBoyG
	 eqGlMTT3T9k5s8Lk+38PwV46udTfT++ILUwMi4aDCKOYR2Dtktsa5beCjRuRPZ3odd
	 gFMsdzICV3KmnwLIHoSdP88j8nbbW3PGo07XgARpCN/Oe6IPF/eq1oMNSfKJpJ2rJs
	 kN2y4ldTntI8Q==
Date: Tue, 21 Jul 2026 12:46:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the kvm-fixes tree
Message-ID: <al9b-DMWxL1_OHEr@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pn5Kv96b5aQuqzak"
Content-Disposition: inline


--Pn5Kv96b5aQuqzak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  e800decd9c0ac ("KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN")

Fixes tag

  Fixes: ae95f566b3d2 ("KVM: X86: TSCDEADLINE MSR emulation fastpath", 2020-05-15)

has these problem(s):

  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--Pn5Kv96b5aQuqzak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpfW/cACgkQJNaLcl1U
h9CXewf/Tw7YqqAGuCl6H9A5UZg0T8Ue/tWXpMEW8yulAkbvAuaOMAQCxBimBKxh
7/59lS4+8TD+oavDp2OKurntbXknXkq48aDmprfAzsdKlwKEncnP60ZWFwJybVeO
j+ozEPoUU5ZOfy3DyDKcJL6XrG42VT1Z42Q52dv9JZ8ZwLdTjkfyN0Wior68xuEG
1hgKR+NZuyVHFAzENS6ptChlEGkEER9tTzXJK9Dg3qYKzPNrtEyTB67ZAHPp72yw
xuZDfiXteOM65FEAd1ZNJDSsDN86dY4eOx5twJxgajxMvDaROozqJ55AiIk1hcD1
eZflF/jUDkogvJto9IUxNdcDTfo9fg==
=bjdL
-----END PGP SIGNATURE-----

--Pn5Kv96b5aQuqzak--
