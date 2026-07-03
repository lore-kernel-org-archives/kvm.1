Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D61A6834
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089408; cv=none; b=jAeTLD6tr97RPzis73Ii2cVCkhD07KcvdsvXcsqBNyIbWJWYaXf5bPqFDs62F2pe68U91sF3u9LKmWTByqD5mrRdEr/Ld4gxUy28U9sUbJuWpV8XnU3QmnDRb+KujssHmnPkn/jhzSpD3k5/FDXAn5jlngMZ4Ch3xdmUTGcZqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089408; c=relaxed/simple;
	bh=0N66Mc5K86IHGV8DkSeltbyW+1DMXiz6pX+dX8j4dWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUfQJYmZ3/QmHeexyPlOFTKKadKtH91RdM35SxI6mrJYJ047qPP6Xu3HvbZEz5iG2O9IsjejMAFUqR0GYqukWbfMYmmN5RfgWwdpNDpZJsqWKF6oayhYCYgmJELPqnGsUyP5+E9IpQvLaXmWWjs3LbCFdcrPo/smQdjOfCiWT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onQ0QGdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onQ0QGdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335221F00A3A;
	Fri,  3 Jul 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783089406;
	bh=I8Rn22CdbWtfPByZgPoPzYKQMWwyuNqMxRwg3nRFcmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onQ0QGdxvnkC6VicoXvisg3qZ4e/KBWInIcgOUuaxpjSi1vh4gVCs/U411p/h33G1
	 4vtPPdktgnboE6078FO+nmQZUvVhLT/Z4Xq5TOgDQKmysfk7UC8T3/nJA3cYnK6poL
	 MIi/PhfA0a80sj+0BQNYsNbgq4fr8881gYwFK/TUkXGbj7VxkQaq84Zwe2gXxbG8jL
	 gLRGWWKVrdGz2bVMyR8Oj4x4VOZkqsQ1ugaq3i+laB4ve6Jh/rlQhdlLTsAwVuB2R5
	 ZV0dkMdeOAvCOn8LrhbXcZDCQy3+79sMBbcDeiCP3sZBWX9rrk3+LoL3V6DRA6Qqqu
	 RBmtn7S/FFBpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/15] selftests/mm: add userfaultfd RWP tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-15-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-15-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:36:45 +0000
Message-Id: <20260703143646.335221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `uffd_rwp_fork_pin_test` will falsely pass if `copy_present_=
page()` drops both the `PAGE_NONE` protection and the `uffd-wp` marker duri=
ng fork.
--

commit e0500399155340fb34ee7e3769e6b868bb0068f6
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

selftests/mm: add userfaultfd RWP tests

This commit introduces several selftests for UFFDIO_REGISTER_MODE_RWP and
UFFDIO_RWPROTECT modes. It includes tests for async/sync modes, pagemap
scanning, mprotect, fork behavior, and swap out/in interactions across
different memory types.

> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index a6c14109e8188..bd3b9f41ee354 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
[ ... ]
> @@ -602,6 +617,784 @@ void uffd_minor_collapse_test(uffd_global_test_opts=
_t *gopts, uffd_test_args_t *
[ ... ]
> +static void uffd_rwp_fork_pin_test(uffd_global_test_opts_t *gopts,
> +				   uffd_test_args_t *args)
> +{
[ ... ]
> +	child =3D fork();
> +	if (child < 0)
> +		err("fork");
> +	if (child =3D=3D 0) {
> +		volatile char c;
> +		int cfd;
> +
> +		/*
> +		 * Read the pinned page. Only reaches the fault path if the
> +		 * child PTE is protnone + uffd; async mode auto-resolves and
> +		 * clears the uffd bit. If copy_present_page() dropped
> +		 * PAGE_NONE, the read would silently succeed and the bit
> +		 * would still be set.
> +		 */
> +		c =3D *(volatile char *)gopts->area_dst;
> +		(void)c;
> +
> +		cfd =3D pagemap_open();
> +		value =3D pagemap_get_entry(cfd, gopts->area_dst);
> +		close(cfd);
> +		_exit((value & PM_UFFD_WP) ? 1 : 0);
> +	}

[Severity: Medium]
Will this test falsely pass if copy_present_page() drops both PAGE_NONE and
the uffd-wp marker during fork()?

If both the protection and the marker are erroneously dropped, the child's =
read
will succeed silently without a fault, and the subsequent pagemap check will
find the uffd-wp bit cleared (since it was never inherited). The child would
then exit with 0, falsely reporting a PASS.

Should there be a precondition check to assert that the PM_UFFD_WP marker
actually exists in the child's pagemap before performing the read?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D14
