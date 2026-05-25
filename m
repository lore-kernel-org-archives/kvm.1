Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B7384229
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712745; cv=none; b=ooBNFeiOqXRUVafHefGf2Q4UUgBi4znKpROriqGBcdpmnQEB06+X8K3f30fcRxYmY91YAk9mQUWb3kEvOfNbd9Jx8BhYi1OqHvnV7Kjgdqul5XIlZN6PRPW27ctPYvwyuK8k/5ZghLGBLU0b4woIva/VGHnJx1+iqT9YQEUTx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712745; c=relaxed/simple;
	bh=iThrTyXlPtbp9s4r8JGtzaYkt2R12gFuwIOu5YMlHpQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PciDx0i2Grrupg9A+Z2uIi8gr6dHNfdyM/wZ0BSwI46drDTu2YLUX0Gc5Zo/lJRIeIPrIKXXhjt4j8LSyYnB7+cYZhEew4uyZYqxvHpYTsKYjKPmE228d/3YQrW8GU14cpxhRfkV1wotNVpCCYXdgqnKaxP86rj3pelLs1gGtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAynKFAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAynKFAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A31F1F00A3A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712744;
	bh=I9lCoHG3kQBzorrevEoQ86mZLpeSG/BMdchhIUpji3E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JAynKFAWNzcxDwm782iwmwmcuK5D8V8y+vy69hzzPGRvryIBfrNhGrFjrX731qEGa
	 FwxVrfLoUyXdjGF2BXxpv6V9p1mxJAwdP0gvBAdvjEMIlfCE4sWyA9wl51JbcSxsJz
	 IUmvEawGSPX5AuuqkHuSYiH2daSqpWWpiLbN0lZ/0E6Hev8M2CMEvdhmNoVdEvugdW
	 iNs8E9LbiH80VTg/I35pPYgIXo5G4kT54M+oH1uRsOTlhdye5FtlHkIIjHQSsWzNBQ
	 fkWsnqPYem4YOnQLju3pEZP6HrR9O0TDCSUV2Q1BhebBFHOkCUDgARzDsDWepY5DXr
	 Ij51VjeoEBPVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] selftests/mm: add userfaultfd RWP tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-14-kas@kernel.org>
References: <20260525113737.1942478-14-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:39:03 +0000
Message-Id: <20260525123904.0A31F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoding _UFFDIO_SET_MODE in the unconditionally checked expec=
ted_ioctls breaks the userfaultfd selftests on older kernels.
--

commit 2e7d7c5845ff822166d0f5b0dd880bef4b890a15
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
selftests/mm: add userfaultfd RWP tests

This commit adds coverage for UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT.
It introduces multiple test cases for sync and async modes, mprotect
interactions, GUP paths, and fork behaviors.

> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index a6c14109e8188..bd6f35ddaa4d0 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -109,6 +111,11 @@ static void uffd_test_skip(const char *message)
> =20
>  static void test_uffd_api(bool use_dev)
>  {
> +	const uint64_t expected_ioctls =3D
> +		BIT_ULL(_UFFDIO_REGISTER) |
> +		BIT_ULL(_UFFDIO_UNREGISTER) |
> +		BIT_ULL(_UFFDIO_API) |
> +		BIT_ULL(_UFFDIO_SET_MODE);
>  	struct uffdio_api uffdio_api;
>  	int uffd;

[ ... ]

> @@ -148,6 +155,15 @@ static void test_uffd_api(bool use_dev)
>  		goto out;
>  	}
> =20
> +	/* Verify returned fd-level ioctls bitmask */
> +	if ((uffdio_api.ioctls & expected_ioctls) !=3D expected_ioctls) {
> +		uffd_test_fail("UFFDIO_API missing expected ioctls: "

[Severity: Medium]
Will this unconditional check cause the baseline test_uffd_api to fail on
older kernels that do not support UFFDIO_SET_MODE? Since the selftests are
usually expected to gracefully skip unsupported tests, it seems hardcoding
this bit into expected_ioctls might break backward compatibility for the
test suite.

> +			       "got=3D0x%"PRIx64", expected=3D0x%"PRIx64,
> +			       (uint64_t)uffdio_api.ioctls,
> +			       expected_ioctls);
> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D13
