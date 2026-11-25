Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636570;
	b=vSFhAfRibtP3czAAzL9ZYqATdvI9bYbCfp9KSZDpX2Y6vvPBu+pX8dzAOgpjvd2vqxFN
	 TxN7QulX6NWJOebfoDddhBUbsg8nkXSiFBHPgN/7w+W7XTDRG6tjhJAAYv+HFDKypBEEp
	 UbjEpmFw8XKeMOhqFBQfcxVKFbqjLzaquFAW7QYk5zLvU30wxZnlQilzY9a9kKnoeZuZu
	 kgsDXQd9gOrX3ZXpdEMXXqyCtwkzYEUXWMeSIuNFhvB7FT4tcGOGMPFMY1VY+4frI9FJ/
	 QX/LaXWLNp3nZ2OPpU4kKVKBLb4IxNlgixCRPyfdGo1aBlZqF/mEZLZGJxpKzehwylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=8L/FhEtu1AibEOTL3+giqF5YaBf2Hqhjfa+0JnWkQw8=;
	b=BiaPICDeWHmTCkEN+6TM4SU3MbQUGPJniFeV83CT16fecepeewaV4xKxlsEzAnRIIrUv
	 8GQBktpR2efr+ZMCOiOXCGMw2WnUczJNXR6HbDJWwfJ8ftQnIf9M07h8hp8ZNZuBATtYZ
	 PplqX6sFVdA4vR8UhVGvXXXcrE84TRmAJ5hp196+d7j+dBI/9jKIYDPii9MIVUWqWqNxi
	 EW29T7/77C4+I9rFQu4MuqG98RMyaa3o4ZChADFbSDShpuHk9mkd2DIoJRspBwET1L+a4
	 J5wTB/oGNqj+0VUZmzOVa+f9mmGVyJio8MVpwTkNuh7ADXLa05qYO2H8Z4qp80D0Dlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inllcyXl;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1B606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F1B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inllcyXl
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8c700d6cc0bso3715058b3a.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795636569; x=1796241369; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L/FhEtu1AibEOTL3+giqF5YaBf2Hqhjfa+0JnWkQw8=;
        b=inllcyXl28y6OSvEWETty6YA1zFXFK7SM1qNH5/VjAs+tvrdn9RtwNWmL6RMO1FMg2
         sD1PX38paSWk0g8AJcdJikOXUsPUBUwVvcYXJ8MoOgIx+k2cZspOVRHXyIOjnmWLpBm/
         uNRZ6PmfTre0bIOEZQjrIwZqlMbD25myWb+KsozHSDorcntYo7PGJ5UWE/41Meb1XHpa
         3+ytCilFnkJ+nCSmEr3Rya4VGoWgfCeASfX8ifzVgK5yFzA8nwLkU/wWminodiAKpwrA
         ebJVimGXj9uqEehzoHeDoE0uDpDxMTfqfIo/V5QRqPPr0ndiV/L4bMPHlmB/cuZpIFJe
         4W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636569; x=1796241369;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L/FhEtu1AibEOTL3+giqF5YaBf2Hqhjfa+0JnWkQw8=;
        b=gYE3Wwt/xBVenRpygl3A5XCKCLt3x1LYy9q+G7HsNvKCBeStiGmvQCWUEM1eIu0Y1I
         WYj28cx91LRYFzWO5AYIatHpua3Bxhs6HPhMX1/q8pjuPUkCbDKxDYbBiPbain+D6JqC
         aGoqmQddmixmXV3QnHjjcq8c7MYg6Vvncb5v0tu9LClWstoMbJk/ysrOMP+qyUdKXSP+
         eKpAzEZKv4PstEynskZfXEBRneuzBoyl/EWMU2q+wZtspBv28I+3q+6xcbJ1QqFFs5xx
         lOTlXqh2Nrk7sRLNQLlzVjWMccN28d1NkzVLWan77nCeaafSVe0QzmBpY8r4TItq/gHw
         A63g==
X-Forwarded-Encrypted: i=1; AL+hErGGujqoif+dLQNYZMTPY3gG5xY/NZXfoTmfx5MQvzL+aXB8XH8A73mrArQaBCzgCanjeik=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tXg+cl4GxK3ccMLYabNaFLO/DtT+ldYvttzpWSCCOxS3yra1J
	odlqRMgZ8y8YC/m0vsTLWV7ejBqU+3k4tccytbbbfZNR5HR8iRAGwjRcSx64lSd9HQ==
X-Gm-Gg: AZFdTZdI659HzYq3tHPaHjKVI6wt3BlFjfX34sSruvfEhneptcGsuOScNoy9KUXesxN
	H+tFYQ86OpDnABw0V+oAvpJuzF9sSuJ3c6xCTYsOZSsEKpo1YM2b7S2EYqBcfwrP+KpMGULg9QP
	fxco+XDRQYi0jEsFSgKGdBu2r9cHz/dHRrN8LETMWLz5yRnf6sdQcecEJLCfqAWG8xxEYVQ4Hs6
	D16cf9p+PzaIp3L7j4tEwa7KdvOZ79qEcsxhv2+cyFX2G0n3CwZjZvbkqsQ/2S7NmFzWco/ngPq
	l0A/0bKxydu8Nh+3sYxCkPWJ4CXUft3OfWixcJgtRJ1gAZR5NynEbor2o88f+UR+M8QwaESjkR5
	VKG2V6v6+A58FAHRLTShRBV/XWpQ+MMG5SfMSUhrnorytTnSC1uHWokSUo2Sx2YE2qRQZpjnUEs
	XLAZugQFo7EmZ2xDOgL9z19y0fLp3wPEL/gLE9vQUGxg6G6wseWVgZg9GUlaPWqXy5IdFlGO3HY
	xeKTcfOMGBZ/YsMtgTBKjnAvVdtk32D537yCM0fXgkXqlTZRy7cbUGEy75u7zZ550LAPJzJwqpU
	Mr8hN7BDVozks3gojf6+w1Om4Xe7D5eJj3tQYTzv/v/qXNkTPQ6iRYaPh+KlYfxf/5xzrWPNyRq
	zSQ7ljS/H6g==
X-Received: by 2002:a05:6a20:2d24:b0:3fb:2086:9051 with SMTP id adf61e73a8af0-4014ed47929mr12701525637.41.1795636568487;
        Wed, 25 Nov 2026 11:56:08 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cbe173453dsm6295218b3a.25.2026.11.25.11.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 11:56:07 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 11:56:07 -0800
Message-Id: <DN4K1F1Z8M9L.25VB33PVA6VDO@google.com>
Cc: <alex@shazbot.org>, <dmatlack@google.com>, <jgg@nvidia.com>, "Kees Cook"
 <kees@kernel.org>, "Andy Lutomirski" <luto@amacapital.net>, "Will Drewry"
 <wad@chromium.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Sean Christopherson"
 <seanjc@google.com>
Subject: Re: [PATCH v4 5/5] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
From: "David Matlack" <dmatlack@google.com>
To: "Aaron Lewis" <aaronlewis@google.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261114132200.113697-1-aaronlewis@google.com>
 <20261114132200.113697-6-aaronlewis@google.com>
In-Reply-To: <20261114132200.113697-6-aaronlewis@google.com>

On Sat Nov 14, 2026 at 5:22 AM PST, Aaron Lewis wrote:
> +/*
> + * Parses "[0-9]+[kmgt]?".
> + */
> +static u64 parse_size(const char *size)

+Sean

This is a copy of parse_size() from KVM selftests
(tools/testing/selftests/kvm/lib/test_util.c), which points to a broader
problem: VFIO and KVM selftests keep growing duplicate copies of the
same basic helpers. Besides parse_size(), this series adds
timer_get()/timer_elapsed_ns(), which overlap with KVM's
timespec_elapsed()/timespec_to_ns(), and VFIO selftests have their own
VFIO_ASSERT*() macros that serve the same purpose as KVM's
TEST_ASSERT().

This isn't just about the tests themselves, it's also about the
libraries. libvfio uses VFIO_ASSERT*() internally and gets linked into
KVM selftests, so a KVM test that uses libvfio (e.g. irq_test) ends up
with two different assert implementations depending on which library
the failure came from. And libvfio can't use any of KVM's helpers, since
VFIO selftests don't link against libkvm. We need to figure out a common
place for these helpers that both libvfio and libkvm (and probably other
selftests too) can use.

That doesn't need to block this series though.

[...]

>  TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  {
> -	const u64 size =3D SZ_1G;
> +	const u64 page_size =3D variant->page_size ?: getpagesize();
> +	const u64 size =3D test_params.size;
>  	const int flags =3D variant->mmap_flags;
>  	struct dma_region region;
> =20
> -	ksft_print_msg("mmap size =3D %lluG\n", (unsigned long long)(size / SZ_=
1G));
> +	if (!IS_ALIGNED(size, page_size))
> +		SKIP(return, "Size 0x%llx is not aligned to page size 0x%llx",
> +		     (unsigned long long)size, (unsigned long long)page_size);
> +
> +	ksft_print_msg("mmap size =3D %s\n", test_params.size_str);

The page size calculation, alignment check, and ksft_print_msg() are
all duplicated in dma_map_unmap_from_file(). How about:

 - Print the size once in main(), since it's the same for every test.

 - Move the alignment check into a helper and call it at the top of
   both FIXTURE_SETUP()s. Roughly:

	static bool skip_if_size_unaligned(struct __test_metadata *_metadata,
					   u64 page_size)
	{
		page_size =3D page_size ?: getpagesize();
		if (IS_ALIGNED(test_params.size, page_size))
			return false;

		SKIP(return true, "Size 0x%llx is not aligned to page size 0x%llx",
		     (unsigned long long)test_params.size,
		     (unsigned long long)page_size);
	}

	FIXTURE_SETUP(vfio_dma_mapping_perf_test)
	{
		if (skip_if_size_unaligned(_metadata, variant->page_size))
			return;

		...
	}

   The harness won't run the test if setup skips (see
   vfio_dma_mapping_mmio_test.c for an example), and doing the check
   first avoids setting up the IOMMU and device for tests that are going
   to be skipped anyway.

With that,

Reviewed-by: David Matlack <dmatlack@google.com>
