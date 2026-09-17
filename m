Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468743CD8BF
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678639; cv=none; b=S4sP6KrvRSmXfXlzRVzTMAdcduUEX3emeh+1gwdBc0kmnCXpVf3yoZCUQMNYi6uijyWgErFlrZAa7wnqIZPk+ATkxki4s1LT5w4SwlSwnEzuFAMTMfPQbsbwKpCNJswfbIIrtt940+UcSE4Sv9/ZnbqJxjocFP+U41S0VQimSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678639; c=relaxed/simple;
	bh=Ay9+N5h2yhBGx0AZ55w71ttzREj/jXqbhg96RtotD74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=grpq3+KaftwaR9NsQrUPwzCF3zzkGdrzQ9vKgf055dDhCu059QYFCLMTHYSUSf6Bq22eQhPxgcB69p4/HOTD72lUt9fQyY8+t8F2fs6pNG7gmckvhuNvXx6eWdaKZPPaedBRusBZBEZwWHZwXFBrroc57/jE05EJoMaNl8xqe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElEdmjK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElEdmjK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F541F000FF;
	Thu, 17 Sep 2026 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678638;
	bh=LSNVCu3r0NmeRzabApGd9J2HwuHuUw1azjhWTh4rF+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElEdmjK3jHdqU8xKtEGljF+IAYzA5K0EcPFU6xnd0N25yuaoqsz7m3o/uMpAPc9Wr
	 G49kPd46AXpqanCy7E3tKdbEdfU/dQYwRquDzLmj5fUuhT4kbGJTAaKyT5XH+WfHfE
	 dn28LlYf7myHbrGUFGuqHx55R+vk4/EUeudRvcQOnvaJDdUpU6H86syXERe1WT966k
	 e70Bq8HkEdMb8b1sLTnMF7alxfv8Mn5CuAOJTT6Sisuh/oETZrZd14GzPzjAYJThEm
	 javdQ2lVfm6kDPAFtbTfFWQRcuuKh1qlgVX7+uQRElegYNezp9xI/ksP1TigbvsMg/
	 jb5oxObC/sNJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] mm: selftests: Add shmem into memory failure
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260917-memory-failure-mf-delayed-fix-v6-5-4b00856b5364@google.com>
References: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
 <20260917-memory-failure-mf-delayed-fix-v6-5-4b00856b5364@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:57:17 +0000
Message-Id: <20260917205717.F2F541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/mm: infinite loop on unexpected SIGBUS during memory-f=
ailure test
- [Low] selftests/mm: misspelled FALLTHROUGH comment breaks compiler warnin=
g suppression
--

commit 7c0289ba3b46e8635863454f24b73b9a63de8df1
Author: Lisa Wang <wyihan@google.com>

mm: selftests: Add shmem into memory failure test

This commit adds a shmem memory failure selftest to verify expected behavio=
rs
when combining page dirtiness and failure types. It introduces new tests
for clean and dirty shmem pages to check if SIGBUS is correctly triggered
or suppressed.

> diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/=
selftests/mm/memory-failure.c
> index 1a5a32e22cce2..d5d17a262c000 100644
> --- a/tools/testing/selftests/mm/memory-failure.c
> +++ b/tools/testing/selftests/mm/memory-failure.c

[ ... ]

> @@ -157,17 +162,22 @@ static void check(struct __test_metadata *_metadata=
, FIXTURE_DATA(memory_failure
>  	case MADV_HARD_CLEAN_PAGECACHE:
>  	case MADV_SOFT_CLEAN_PAGECACHE:
>  	case MADV_SOFT_DIRTY_PAGECACHE:
> -		/* It is not expected to receive a SIGBUS signal. */
> -		ASSERT_EQ(setjmp, 0);
> -
> +	case MADV_SOFT_DIRTY_SHMEM:
>  		/* The page content should remain unchanged. */
>  		ASSERT_TRUE(check_memory(vaddr, self->page_size));

[Severity: Medium]
Will this cause an infinite loop if an unexpected SIGBUS is caught? In
check(), check_memory() is now called before ASSERT_EQ(setjmp, 0). If
soft-offlining unexpectedly results in a SIGBUS, the signal handler jumps
back, but check_memory() will then re-trigger the SIGBUS before the setjmp
assertion can catch the error and fail the test.

> +		/* FALLTHORUGH */

[Severity: Low]
Is this a typo? The spelling FALLTHORUGH will fail to match the compiler's
regex for intentional fallthroughs and might generate a
-Wimplicit-fallthrough build warning.

> +	case MADV_HARD_CLEAN_SHMEM:
> +	case MADV_SOFT_CLEAN_SHMEM:
> +		/* It is not expected to receive a SIGBUS signal. */
> +		ASSERT_EQ(setjmp, 0);

[ ... ]

> @@ -355,4 +379,88 @@ TEST_F(memory_failure, dirty_pagecache)

[ ... ]

> +TEST_F(memory_failure, clean_shmem)
> +{

[ ... ]

> +	if (variant->type =3D=3D MADV_HARD) {
> +		check(_metadata, self, addr, MADV_HARD_CLEAN_SHMEM, ret);
> +		ret =3D sigsetjmp(signal_jmp_buf, 1);
> +		if (ret =3D=3D 0)
> +			FORCE_READ(*addr);
> +		check(_metadata, self, addr, READ_ERROR, ret);
> +	} else {
> +		/* Test the address accessability without check_memory(). */
> +		FORCE_READ(*addr);

[Severity: Medium]
Does executing FORCE_READ(*addr) unconditionally before validating the ret
value cause an infinite loop?=20

If the test unexpectedly caught a SIGBUS during injection or a subsequent
access, the sigbus_handler jumps back to sigsetjmp() which sets ret =3D 1.
Executing FORCE_READ(*addr) without checking if ret =3D=3D 0 triggers anoth=
er
SIGBUS endlessly, rather than letting the test report a failure.

> +		check(_metadata, self, addr, MADV_SOFT_CLEAN_SHMEM, ret);
> +	}
> +
> +	ASSERT_EQ(munmap(addr, self->page_size), 0);
> +
> +	ASSERT_EQ(close(fd), 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-memory-fai=
lure-mf-delayed-fix-v6-0-4b00856b5364@google.com?part=3D5
