Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD547C0E6
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054905; cv=none; b=i/0w30J8h/7wt/W2IYMqdeUYw9IEBkKoPrhF+ruNg+GDGw3Ko/Y7rHNfd7KCdPEaJpjhs1ZdHwlSBy+tkEfBSk+NipghuuJhX0q6gPiZfIuXcwVNtNj3B6LPcNORIbJCqwPv1szmwwOIMKjKvwmne8Vg1lYciFm3oQi2vmI4SFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054905; c=relaxed/simple;
	bh=pO0ZpcVmEYOquzToHyoxyCHx56wgXJZlF+U7vpkPaaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NqR/FSuE6YOn0+D8UOATZP2oxDkcdiAr6FbjM7/I0UiMKpKdkyexMoGbKTQbVbTSXtOodrHJxHIhPvE0FO9tDThazD2KdmdvsKAJsXEe1o16Ub86hamp4o/b5hmmx8qqfrN14NhyWvhy0fzsoI1pzrHQws69CDM4XzriCSot27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO4CjKHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO4CjKHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEC41F00898;
	Thu, 10 Sep 2026 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054904;
	bh=z6QFCBodAhoNQRQvvVTVJaxZ8j17tnVgTWOIGBPJDCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PO4CjKHj0LxB7Eig7h8WDlt5hFNpxSWwxJZnKYv9InUkHylfjHN5pbSirzIA9Z/vI
	 BiHvyGnKa011cYmOyFH4JHDYcTfzfidLBSe8u/CYz9r97mmVzvmajXZktciZ3WGI8O
	 IRrhqDk2KHBIfEFxjKs7ai/WyvlcEkGo2ZP8MpUsCFamhHv8AaFomX4S0yldk4vAYR
	 XKLLMpW4JjvGt3F7R7eiMyd2elj5XwmXY/6Lcca6PFBm/MCa8wwx2pplszcCc++KsT
	 FmR4cXe/zlt3D1pudBXBp/vlZLmRAYPnRaNlFEiO0Rzk5nxBJiZa2wvctccq3KoKEa
	 ewFz8bLvGuUzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910153326.3085937-5-aaronlewis@google.com>
References: <20260910153326.3085937-1-aaronlewis@google.com>
 <20260910153326.3085937-5-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 15:41:43 +0000
Message-Id: <20260910154144.1FEC41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent failure on invalid or unrecognized command-line options d=
ue to missing usage print.
--

commit 6144d66da4643ccf9bc4b7ab3160a7d8485045d3
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Allow a size for vfio_dma_mapping_perf_test

This commit introduces a mechanism in the selftest harness to parse custom
command-line options. It uses this new functionality to add a '-b' option=20
to vfio_dma_mapping_perf_test for specifying the DMA region size.

> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/=
selftests/kselftest_harness.h
> index 29a19bc870846..5065eb7144bce 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
[ ... ]
> @@ -1118,7 +1156,6 @@ static int test_harness_argv_check(int argc, char *=
*argv)
>  			ksft_debug_enabled =3D true;
>  			break;
>  		case 'h':
> -		default:
>  			fprintf(stderr,
>  				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n"
>  				"\t-h       print help\n"
> @@ -1139,7 +1176,14 @@ static int test_harness_argv_check(int argc, char =
**argv)
>  				"include all tests from variant 'bla'\n"
>  				"but not test 'foo' specify '-T foo -v bla'.\n"
>  				"", argv[0]);
> -			return opt =3D=3D 'h' ? KSFT_SKIP : KSFT_FAIL;
> +			if (opts && opts->help)
> +				opts->help();
> +			return KSFT_SKIP;
> +		default:
> +			if (opts && opts->handler &&
> +			    opts->handler(opt, optarg) =3D=3D KSFT_PASS)
> +				break;
> +			return KSFT_FAIL;

[Severity: Medium]
Is it intended to silently fail here in test_harness_argv_check() without=20
printing the usage string?

Previously, unrecognized options would fall through to the 'h' case and pri=
nt
the help text before returning KSFT_FAIL. By removing the default fallthrou=
gh
to the 'h' case, passing an invalid option to the test binary now exits
silently, which might make it harder for users to realize they've provided =
an
invalid flag.

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910153326.3085=
937-1-aaronlewis@google.com?part=3D4
