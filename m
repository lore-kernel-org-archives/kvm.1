Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A322DCF45
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539154; cv=none; b=IN/KHeJ1m6dsHjjWPH81vd3OomPdel6UNjvI2xd6QJw6ubjfIM6mk4xPMGSPNGD/InAoGGmng+W9J8lWXClBFfrfT1Kz6VNfs0+EhqyKZM1SN7Jn6FKDl4E8vLqJFN5lMN3YWz0s55YDkDrWAYYzYc77wZ6ZQnEL/rJxGAPhX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539154; c=relaxed/simple;
	bh=nxMjcB2MPth7z7MxkYgQ3FxGSas5bW5JnFgn7vN5a3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ef7PG1ya9KLQTSS1/LH7UhZdkMDZ+h0mxqMSjktUZ52tLGhRu8xxcWv/hnNeYF44E3DoN1eGYySELFOcnqhdWjWVDUVcjXyJZoC0hBKvm+cx5IcFqTMeNGr/S5fnecoIjTHruKFaW0RJ2b9Y7fqXUzTLuD+4wDAv3bWInuaLWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7jGQPyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7jGQPyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703BC1F00893;
	Thu,  4 Jun 2026 02:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539153;
	bh=mmbxmGYq3GL709N67N5bDhtRXX8VhAiW8AqNB2HsbjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H7jGQPyKbenr07uiSLqSzFvqVKgu58Y4/5NTXMbu8AMAUdXnBCTRtS55NvZHIkgXb
	 7ir13wEu+Udy3zeJNcA2WfV7XWuLDB+sfWPthTXibqXz2J0mAiu5AE40UOdv36CI5h
	 rzP2WjeW2R25MsU5oCsX7nbR0SBAwHtoHjhzlk+DV/u9Y7QlcPbt1+VVbPDpyRl1Fl
	 WYM1B/UnV3xuc417/B2kHCq5irCWzXZiJXiPMoUsFz8MP1hgQI63Z2PEDz1pQlnsRF
	 ZJsZmY0CZziyNIUbmMlPJKxz4OUr1sBUA6kF9lsCpXGKSlLaRHC372slS5fO/pvWS7
	 Dj3wcECVlSxjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/21] KVM: selftests: Add helper to generate random
 u64 in range [min,max]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-5-jrhilke@google.com>
References: <20260604020143.748245-5-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:12:32 +0000
Message-Id: <20260604021233.703BC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm_random_u64_in_range() cannot generate values in the upper ha=
lf of large ranges and introduces severe modulo bias due to underlying PRNG=
 limitations.
--

commit f54822168923546305cbe06e95c821b08928d279
Author: Josh Hilke <jrhilke@google.com>

KVM: selftests: Add helper to generate random u64 in range [min,max]

This commit introduces kvm_random_u64_in_range() to generate a random 64-bit
integer within an inclusive range using a kvm_random_state structure.

> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/=
selftests/kvm/lib/test_util.c
> index e98ca7ef439c4..e208a57f190cf 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c

[ ... ]

> @@ -42,6 +42,24 @@ u32 kvm_random_u32(struct kvm_random_state *state)
>  	return state->seed;
>  }
> =20
> +/* Returns a random u64 in the inclusive range [min, max] */
> +u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
> +			    u64 max)
> +{
> +	u64 value;
> +	u64 range;
> +
> +	TEST_ASSERT(min <=3D max, "PEBKAC, min =3D 0x%lx, max =3D 0x%lx", min, =
max);
> +
> +	value =3D kvm_random_u64(state);
> +
> +	range =3D max - min;
> +	if (range =3D=3D ULLONG_MAX)
> +		return value;
> +
> +	return min + (value % (range + 1));

[Severity: Medium]
Will this return values uniformly across the entire 64-bit range?

Because kvm_random_u32() uses a Lehmer PRNG with a modulus of 2^31 - 1, its
maximum return value is 0x7FFFFFFE. When kvm_random_u64() concatenates two
of these values, the maximum possible output is 0x7FFFFFFE7FFFFFFE, meaning
bits 31 and 63 are never set.

Due to this restricted PRNG space, using the modulo operator here means the
function cannot generate values in the upper half of large ranges (above
0x7FFFFFFE7FFFFFFE). It also introduces significant modulo bias for ranges
that don't evenly divide this artificial maximum, preventing uniform covera=
ge
of the requested [min, max] range.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D4
