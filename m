Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790328F949
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938666; cv=none; b=N6eUCWrceNIO2IL+dpSel+8E0Z+qTOUOzcfGDyZGVwIwJNKPjAJju0H/9BhpyIf4Jpucy0l8oNy6fI46ttERqfR32EyfgGtUQbuF/QFBngH/XUjEvUckhKmKhLyjjfPrTYLE54oxqB712PZgaLfdFarg1/ngBNK4MA00S7wQS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938666; c=relaxed/simple;
	bh=3msw62n8ypJQDGRgR8XoGuRQ5+784qSn8IHgVJVrkps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cO8E86/D4xQZTQwMoN+vuhno/6tRveUIIP2nnpqvkE90LTPVDmHTUSmCK/TNS6E0vP7+MmxDXPA8P5XdboTFxqw8CRB9SjlGAnkm9blc3gN6zXKkDIoQHxHctU9JId/zIFg8RBM4gedKF4OwTZ08BoJQU79kmQf2ALFisx5h32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE/RItVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE/RItVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDF11F000E9;
	Wed,  1 Jul 2026 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938665;
	bh=i5NccwoD5NyRVeoWqdnOCqRsUQLU1S7K++re9+gdQdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nE/RItVvp6TerasGK9LFgoP9XVRyVWUIIqXT0tZ7hY0+qo7ssCW12xcCwdwZBTbw+
	 pZzdyO91QeCUnh39TGvjlYz0/eub8SAfdx+GAzQO0Yuefbw0PkH/nbBa6bqhMCxXXu
	 mthdbZX+yGyIW7N3iWIedtnYe1H15uYzn3zAVXDGEhUyljP7QYMEhDVMKQV7x0lzvy
	 +ZGo5lVve1JiBAsosG9HA/U3xI3/anepFYKnio4kINB9gJmx3tm8nHilN8D97LWSPm
	 ciaRqwcPJdds+hEyq/k20LRKm9gg4KYM3oIfo948jd6D3f0sJlYJ6tsf650wFdqFmp
	 ruvpZr+azaTtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701203311.326798-4-aaronlewis@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-4-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:44:24 +0000
Message-Id: <20260701204424.CDDF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The -h option and invalid arguments fail to exit the program, ca=
using unintended execution of all tests.
- [Medium] Multiple usages of the '-a' flag overwrite the wordexp structure=
 without WRDE_REUSE, causing memory leaks and dropping previous arguments.
- [Medium] Using size_t for math and return type in parse_size() causes und=
efined behavior and silent truncation on 32-bit architectures.
--

commit d938d0d26cc3c95a10e15ae011fce57f55a320c9
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
   =20
Allow the user to specify a DMA region size via the command line for
vfio_dma_mapping_perf_test.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/=
tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 4639bda7ebaa3..2d8fc3e8e0787 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
[ ... ]
> +size_t parse_size(const char *size)
> +{
> +	size_t base;
> +	char *scale;
> +	int shift =3D 0;
[ ... ]
> +	switch (tolower(*scale)) {
> +	case 't':
> +		shift =3D 40;
> +		break;
[ ... ]
> +	VFIO_ASSERT_TRUE((base << shift) >> shift =3D=3D base,
> +			 "Overflow scaling size!");
> +
> +	return base << shift;
> +}

[Severity: Medium]
On 32-bit architectures where size_t is 32-bit, will shifting a 32-bit inte=
ger=20
by 40 when parsing terabytes cause undefined behavior?

Because compilers can mask over-sized shift counts, the overflow check here
might evaluate as true and silently pass while returning a drastically
truncated size. Should this function use u64 internally and as its return
type to match test_params.size?

[ ... ]
> +static void populate_harness_args(struct harness_args *args, const char =
*argv_0,
> +				  const char *cmdlne)
> +{
> +	if (wordexp(argv_0, &args->exp, WRDE_NOCMD) =3D=3D 0 &&
> +	    wordexp(cmdlne, &args->exp, WRDE_APPEND | WRDE_NOCMD) =3D=3D 0) {

[Severity: Medium]
If a user passes multiple '-a' flags, does the first wordexp() call without
WRDE_REUSE or WRDE_APPEND leak the previously allocated memory in args->exp?

This also looks like it would discard any arguments appended by earlier '-a'
flags, and potentially leave args->argv pointing to leaked allocations if t=
he
second wordexp() fails.

> +		args->argc =3D args->exp.we_wordc;
> +		args->argv =3D args->exp.we_wordv;
> +	}
> +}
> +
> +static void setup_test(struct harness_args *args, int argc, char *argv[])
> +{
> +	int opt;
> +
> +	test_params =3D (struct test_params) {
> +		.size =3D SZ_1G,
> +	};
> +
> +	while ((opt =3D getopt(argc, argv, "a:b:h")) !=3D -1) {
> +		switch (opt) {
[ ... ]
> +		case 'h':
> +		default:
> +			help(argv[0]);
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	// Reset getopt() state to allow the test harness to use it.
> +	optind =3D 1;
> +}

[Severity: Medium]
When the '-h' option or an invalid argument is provided, does jumping to 'o=
ut'=20
unintentionally allow the program to continue executing?

Because setup_test() returns normally to main() in this path, main() will
subsequently execute test_harness_run(), which runs the full test suite
immediately after printing the help message instead of terminating.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701203311.3267=
98-1-aaronlewis@google.com?part=3D3
