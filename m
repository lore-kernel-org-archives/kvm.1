Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C94345CDA
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514969; cv=none; b=oPkmaagDCZUB9/00ydjv4SMwgSSwggo83qyD75F8Cn+Wh3jEVsCvpT/kO3nlLdeV8hD42hZCxrxEHTufwIPn/HTxuDmBHVlq8CUxsj8nOFUdq2S/D+LFmgoozAiSwRbGeAkP/8bJ34apZUcNR7xwDANFT/VyQNN78IbeIzuxing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514969; c=relaxed/simple;
	bh=Ca+lLyvzAgbgN6+M5Ww2CR3TxL12RrTODHxv2Ljs9oE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iKf3fIw7nVYXvVdxB6di07dyGcADpmdFOSDUv0KbaQcUTLR4WG3iZyTkL7hEId6h6VpVE4H42MX0fH58gTZxOUJR8NJoSFuaTKn8kXaPtsiKPEe8Kr2OkiC7kQk0RKDct8D6l/RLRRLx7KPQacGKg6WpIweAmljThFcKZjmQiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq5z91h5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq5z91h5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30451F000E9;
	Sun, 23 Aug 2026 19:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787514966;
	bh=3Hr8tkfJuGpXOTT/WZW+VH10NWaaztRu9fZQA0dusNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kq5z91h5tLi3nI1U/6df0DEyx1/w0vWOIEyPA+VhZaISuOmm3L5YsBccqjO64WtRQ
	 Vb+dK0JtzSOSpuSsKu6InmhJRLFtUlRyKXE1LhUYWfPIeb34+i6F6wV8X+jayhjlFq
	 cVEocbWDNictQ1g7Ep4EvHVHZTQzk8KmQX0vudTkesiNfFl0z/lzbYV8qHa7nRqqrz
	 6bm1eu8gXe4A94kR2rsP9JJnyVSQdhg40X0u5W8ydvWOYCVXKwJI0O86fLY7Vp2ST9
	 sj5wSyN0kJ2LftQ58MBjNe/wp863fPCiMrLOeJLpy8I3jBENJWRjfn88czQi6p+IFs
	 OphZJKQj1n6yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] mm: selftests: Add shmem into memory failure
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-5-d97a5703e45a@google.com>
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
 <20260823-memory-failure-mf-delayed-fix-v5-5-d97a5703e45a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:56:06 +0000
Message-Id: <20260823195606.A30451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Infinite loop in memory-failure test on unexpected SIGBUS
--

--- Patch [5]: [PATCH v5 5/5] mm: selftests: Add shmem into memory failure =
test ---
commit b9a214a17a9d91396ae673c0a673788dd9d73afe
Author: Lisa Wang <wyihan@google.com>

mm: selftests: Add shmem into memory failure test

Add a shmem memory failure selftest to test the shmem memory failure is
correct after modifying shmem return value.

> diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/=
selftests/mm/memory-failure.c
> index 1a5a32e22cce2..5b26f0c446644 100644
> --- a/tools/testing/selftests/mm/memory-failure.c
> +++ b/tools/testing/selftests/mm/memory-failure.c
[ ... ]
> @@ -157,17 +166,22 @@ static void check(struct __test_metadata *_metadata=
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
Will this reordering cause an infinite loop if an unexpected SIGBUS occurs?

Previously, the code checked ASSERT_EQ(setjmp, 0) before calling
check_memory(), allowing the test to fail gracefully.

With this change, check_memory() is called first. If an unexpected SIGBUS
was already received (setjmp =3D=3D 1), check_memory() will access the addr=
ess
again, triggering another SIGBUS. This causes the signal handler to siglong=
jmp
back to the sigsetjmp() site in the caller, which will then re-enter check()
and trigger the same sequence repeatedly.

> +		fallthrough;
> +	case MADV_HARD_CLEAN_SHMEM:
> +	case MADV_SOFT_CLEAN_SHMEM:
> +		/* It is not expected to receive a SIGBUS signal. */
> +		ASSERT_EQ(setjmp, 0);
> =20
>  		/* The backing pfn of addr should have changed. */
>  		ASSERT_NE(pagemap_get_pfn(self->pagemap_fd, vaddr), self->pfn);
[ ... ]
> +TEST_F(memory_failure, dirty_shmem)
> +{
[ ... ]
> +	ret =3D sigsetjmp(signal_jmp_buf, 1);
> +	if (!ret && !self->injection_attempted) {
> +		self->injection_attempted =3D true;
> +		ASSERT_EQ(variant->inject(self, addr), 0);
> +	}
> +
> +	if (variant->type =3D=3D MADV_HARD) {
> +		check(_metadata, self, addr, MADV_HARD_DIRTY_SHMEM, ret);
> +		ret =3D sigsetjmp(signal_jmp_buf, 1);
> +		if (ret =3D=3D 0)
> +			FORCE_READ(*addr);
> +		check(_metadata, self, addr, READ_ERROR, ret);
> +	} else {
> +		check(_metadata, self, addr, MADV_SOFT_DIRTY_SHMEM, ret);

[Severity: Medium]
If the MADV_SOFT injection unexpectedly triggers a SIGBUS, will this else
block cause an infinite loop?

If a SIGBUS is caught during injection, sigsetjmp() returns 1, meaning
ret =3D=3D 1. The else block is executed unconditionally, calling check() w=
hich now
accesses the memory before asserting setjmp =3D=3D 0. This will trigger ano=
ther
SIGBUS and siglongjmp back to the sigsetjmp() above, creating an infinite l=
oop.

> +	}
> +
> +	ASSERT_EQ(munmap(addr, self->page_size), 0);
> +
> +	ASSERT_EQ(close(fd), 0);
> +}
> +
> +TEST_F(memory_failure, clean_shmem)
> +{
[ ... ]
> +	ret =3D sigsetjmp(signal_jmp_buf, 1);
> +	if (!ret && !self->injection_attempted) {
> +		self->injection_attempted =3D true;
> +		ASSERT_EQ(variant->inject(self, addr), 0);
> +	}
> +
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
Similar to the issue in dirty_shmem, if an unexpected SIGBUS occurs during
injection, ret will be 1, but this else block will unconditionally execute
FORCE_READ(*addr).

Since the address may be poisoned, FORCE_READ() will trigger another SIGBUS,
jumping back to the sigsetjmp() and creating an infinite loop. Should this
block check if ret =3D=3D 0 before attempting to read the address?

> +		check(_metadata, self, addr, MADV_SOFT_CLEAN_SHMEM, ret);
> +	}
> +
> +	ASSERT_EQ(munmap(addr, self->page_size), 0);
> +
> +	ASSERT_EQ(close(fd), 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-memory-fai=
lure-mf-delayed-fix-v5-0-d97a5703e45a@google.com?part=3D5
