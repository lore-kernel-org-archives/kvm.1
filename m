Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9548094C
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863523; cv=none; b=Y4BXTi6eC86gNDsTQcqQloHj3EGFhchfClPQb2MQj7PDCHF2/its69kq0mb5glV4ruaU9ajiiAdcA8SKgGxDS9D257VjJvWHypy66aGOMpdNhYHYvMr9FAhYiAagF2gG1MRVhR2nNwVfrY3SAQLT8FG2OHwM3OcG0JupwflTV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863523; c=relaxed/simple;
	bh=QRaaW/uP8yznlb6Ke2pdEu0hQVmVqBIYowbYauBVmW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qufZFSirkyFCU9kLV6EPI5G4+BuKRSR1m8cGHsWGuBQjg30mmEsMAxObvWXDqUUtC4PeZWyr10ogiBQTbPIDTOo4qTlLWIzcldHV6d9vib0UUQ7eYh83BSXUvuY/vhXaKPQ9rFuHSuSNDHw997Wz/xD7fsmT/nphrJdMWGqupWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDa5mD/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDa5mD/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD011F00A3A;
	Tue,  4 Aug 2026 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863507;
	bh=imWRW7c7b/JQ8R7tTo5Opod2O0GmOiBo0reZVl91DZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDa5mD/VuTz+Il3JnEQSytMbntF5AFJTS5THPSB2uhY2RLhXvSSDgFbOSPyFQBEhX
	 F2tyUh5YmJLmX9t1PsbtRJmVDuQ/I1huGAZvCjND6yrKLExxNzpehhrvEzDdogoJ0K
	 y6/pdIigeyPe27etMWgqP8Fsej7KtNYwPHkkr6frfhyqOn6j423vFjkM16WiGuxp2f
	 cUdtyZ8rRppQ5lTApKeTXTmlB0gtAvzRat5w0Ntq3Bgrsnjg1PSHx/tBffpxwrQn8w
	 wmgTQ1flwagtip31oghHCazHMsICLE5dYXbYbJoZVRHVxWqSgXQ/uktNSfx125Fnrt
	 VbO28YJ1ezp6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804165748.1060476-5-aaronlewis@google.com>
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-5-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:11:46 +0000
Message-Id: <20260804171147.BDD011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Using wordexp() on argv[0] without quoting causes incorrect argu=
ment splitting, and using wordexp() on test arguments allows unintended she=
ll expansion.
- [Low] The diagnostic print statement for the mapped region size staticall=
y calculates the size in Gigabytes, truncating custom sizes smaller than 1G=
B to 0G.
--

--- Patch [4]: [PATCH v2 4/4] vfio: selftests: Allow a size for vfio_dma_ma=
pping_perf_test ---
commit cff64ba01747807f5a7be83ede29a96ad3859dc3
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Allow a size for vfio_dma_mapping_perf_test

This commit allows the user to specify a custom DMA region size via the
command line for vfio_dma_mapping_perf_test. It also introduces a way to
pass arguments through to the test harness using a new '-a' option.

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/=
tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 5ef85deba4ee0..af2273a0c6f52 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

[ ... ]

> @@ -159,17 +165,17 @@ static void teardown_memfd(int fd, u64 size, void *=
vaddr)
> =20
>  TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  {
> -	const u64 size =3D SZ_1G;
> -	const int flags =3D variant->mmap_flags;
> +	const u64 size =3D test_params.size;
> +	const int mmap_flags =3D variant->mmap_flags;
>  	struct dma_region region;
>  	int fd;
> =20
>  	printf("mmap size =3D %lluG\n", (unsigned long long)(size / SZ_1G));

[Severity: Low]
Does this print statement output "0G" when a size smaller than 1GB is
provided? It looks like the division by SZ_1G truncates custom sizes like
512M to zero.

> -	region.vaddr =3D setup_memfd(&fd, size, variant->mmap_flags, variant->m=
emfd_flags);
> +	region.vaddr =3D setup_memfd(&fd, size, mmap_flags, variant->memfd_flag=
s);
> =20
>  	/* Skip the test if there aren't enough HugeTLB pages available. */

[ ... ]

> @@ -185,8 +191,141 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_un=
map_from_file)

[ ... ]

> +static void populate_harness_args(struct harness_args *args, const char =
*argv_0,
> +				  const char *cmdlne)
> +{
> +	int flags =3D WRDE_NOCMD;
> +
> +	if (!args->argv) {
> +		/*
> +		 * Initialize the argument list with the program name (argv[0]).
> +		 * WRDE_NOCMD disables command substitution for safety.
> +		 */
> +		if (wordexp(argv_0, &args->exp, flags) !=3D 0)

[Severity: Medium]
Will this wordexp() call split the test executable's path into multiple
arguments if the path contains spaces? If a user runs this from a directory
like '/opt/my tests/test', it seems it would corrupt the test harness
argument list and cause test_harness_run() to fail.

> +			VFIO_FAIL("Failed to evaluate test harness argv_0 args!");
> +	}
> +
> +	flags |=3D WRDE_APPEND;
> +
> +	/*
> +	 * Use wordexp() to reliably parse the user-supplied command line string
> +	 * into individual arguments, respecting shell quoting and escaping rul=
es.
> +	 * WRDE_APPEND merges these new arguments with the earlier argv[0].
> +	 */
> +	if (wordexp(cmdlne, &args->exp, flags) !=3D 0)

[Severity: Medium]
Does using wordexp() on the user-provided arguments allow unintended shell
globbing? For instance, if a user passes an argument like '-a "-v test*"',
would wordexp() expand this against local files if a match exists, rather
than passing the literal wildcard to the test harness filter?

> +		VFIO_FAIL("Failed to evaluate test harness cmdlne args!");
> +
> +	args->argc =3D args->exp.we_wordc;
> +	args->argv =3D args->exp.we_wordv;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804165748.1060=
476-1-aaronlewis@google.com?part=3D4
