Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6E26AF4;
	Thu,  7 May 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117711; cv=none; b=FMgUll9uIyz29dttKqegDMCwUuAWMhPfi/bWcrfwOvRjt8TkgYcEibsBgLHrNEt+ywxbH4ZFEH+spr7Cio7jrjNMPsI5pW4/nbl3fl5a0M1jxuvjSizBlC0r+eyw2fSaHDpgt8zisQ/xwztFxg/O1qDHYlHLUcAyWdFngIY2NUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117711; c=relaxed/simple;
	bh=0O3G2lmMP/Ms3BjmJlMlwXPElBarsrFRXkD/Kf50ycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3y0HehFwKfXRkjO/DYL2i25bk5arXxVSd5Z7l5Gupmpzd+yyOtNSCPgFyNvLtAV7kMETD/sNsjNDkG25O3btqboz2vXsxBBY1z9k356u9tX6JHpMOOBJYgx0Oh3s9wqxLZnlmwPsEWbQ8a3jovpQKktqjfqM2RqTSxgMYOiqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo4lhO+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo4lhO+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D327CC2BCB0;
	Thu,  7 May 2026 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778117711;
	bh=0O3G2lmMP/Ms3BjmJlMlwXPElBarsrFRXkD/Kf50ycA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bo4lhO+RL3OO3IL1WEVSQSJOG6fF9WGBUGDl1kLrgeLAlSdCP3QYVcnE4NuoVGgzx
	 g/7S893cwQQScmZfG31DQxx68sx4bTQFZHRCsTwzCRmi+//kYfehhLjej857kjGKkw
	 NIJh31AF9QUw5NAc+v+Oh5Qzvy4+gxzz9T7eDm6LA5FIarqpaZqxpC27gC1vQmZe/u
	 sJVA6qJ0Zuni9umvr592++g0ZN8dmb+hscUphG+dgFXZGnFVgbS6UsWBGfLSpOSyCO
	 L3bybhVhSm6beqQIsZ76iqr5uLyrA9/G1RZshor/k2LWf4WOOQtysKNisk0+1XT4OR
	 VLUAyE0cS1iNw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id B29CF1AC5890; Thu, 07 May 2026 02:35:07 +0100 (BST)
Date: Thu, 7 May 2026 10:35:07 +0900
From: Mark Brown <broonie@kernel.org>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH] KVM: arm64: Add memslot for ST_GPA_BASE in
 check_steal_time_uapi()
Message-ID: <afvsSxLDBz6HDkCs@sirena.co.uk>
References: <20260501021639.2563219-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v1++ER88l8OUwD5L"
Content-Disposition: inline
In-Reply-To: <20260501021639.2563219-1-xujiakai2025@iscas.ac.cn>
X-Cookie: Truckers welcome.


--v1++ER88l8OUwD5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2026 at 02:16:39AM +0000, Jiakai Xu wrote:
> The refactored check_steal_time_uapi() creates a temporary VM via
> vm_create_with_one_vcpu(), whose default memslot0 only covers GPA
> 0..~2MB.  Setting st_ipa to ST_GPA_BASE (1 << 30) causes
> kvm_arm_pvtime_set_attr() to fail with EINVAL because gfn_to_hva()
> cannot find a valid memslot at the target GFN.

Tested-by: Mark Brown <broonie@kernel.org>

It'd be good to get this merged, this is a mainline regression.

--v1++ER88l8OUwD5L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn77EoACgkQJNaLcl1U
h9AK7Af/XR+d37P6uL0n0Fx8fm4VK+ZmK0hvIRclQwkMsoHT3vhklNUChbZVyi2C
fpSUXPczpk17MkZQSRBLvF1KfEoUlFxTlu8fdPevOv22vaTkveC4dwNF95/M+vEH
B51YF/vUfjcEMtlXtkE77eBJ6+5OPhJuJc0QE1yzY9HbaXXiIUnuOmHKYwFm+V9U
Uinp/GOTEb9FO50Ks3MG1tVSsurpXJgp0Pz39qyDP0PfTTi56bCjQJdI8KnfmL/G
iehiXZB/YJoGhID+U66QMQR3gHlh3QXTzSEZ8xg1g9jIIVA0Su8fIIycvQ/ntjCo
XlB7jVGTFAg63YWfT5CiF+18/brE4w==
=JSA7
-----END PGP SIGNATURE-----

--v1++ER88l8OUwD5L--
