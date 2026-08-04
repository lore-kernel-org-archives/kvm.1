Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F848B373
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863757; cv=none; b=BTtoy1NrVIbOSm79bVdOrkgzNEX1V1x514vYKzJKZUyFPtTXM2UvROPWfwBpe5nupt5kXfnq+Mkhzjb9IkN8JG9R7XMre4q1iCeaH8TZV85lqo35GplT2h4MAA254fECmLQ3WCwFAAP9wWOOH0UnBiuRCMfmcvNKMK9Se5/fzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863757; c=relaxed/simple;
	bh=awDpPZF7BBQfwzzvu/RK345LkXjSNpv6yLkI1Ha/hFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ghns2U6Dws4cZJCz6XVBIuq6ErCz88tZAA/FE91IuST/l9ZL9tFkcO86chRWdhCNuwOSA/uCZ1IYGV4zA4ROLm1Ln7BzOhdd7fMAmtTZp311eoWO7rupyqXgAphP5nAusY3K/UPVq3pJ6UWw9cpkRzjoJ1ouR+Mv+1YLr2FFZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp4L0n+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp4L0n+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09C11F00A3E;
	Tue,  4 Aug 2026 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863741;
	bh=kWFuFhul7zhnI4zZENNtCpG/zUMQX5WxGTghKcmAJsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lp4L0n+gi7elYkH7wjALehOAgC2afgu5qZjM+mKuMBMVgRd5a2v8RRZjHN1xDCmm3
	 mm650y8Rw4ccpTW+PNBJrvCtNq6QrYRXSmTwitwpepmbo5lGouA760NKkGY/y3d7IF
	 8cWKNVCFu3ugMX3gGrgSEC0H0sYm1kvFgE7UnvHMrMdwQISYn0xMOk18qPtcLK3VcD
	 dffzhweI4aWU35kw2UfkeHIHXANxbzEocvTIjxT3oiny+keBosGX9TKEnSI54g0kd5
	 yIHXiQsrYuC/U0cATMT5CmJag/k/wpgfn0fEMKFXMWv5AUsHemC/Kibocm4bAZyhFQ
	 hTFSCKEX/frTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] vfio: selftests: Introduce
 vfio_dma_mapping_perf_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804165748.1060476-3-aaronlewis@google.com>
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-3-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:15:40 +0000
Message-Id: <20260804171540.F09C11F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `TIME` macro can clobber `errno` before the caller evaluates=
 it.
- [Low] Diagnostic output uses `printf` instead of `TH_LOG` or `ksft_print_=
msg`, violating the Test Anything Protocol (TAP) format.
--

--- Patch [2]: [PATCH v2 2/4] vfio: selftests: Introduce vfio_dma_mapping_p=
erf_test ---
commit 3d215ae55639b2f45faac3bfc752e16beff09489
Author: Aaron Lewis <aaronlewis@google.com>

vfio: selftests: Introduce vfio_dma_mapping_perf_test
   =20
Introduce vfio_dma_mapping_perf_test to aid in latency testing. Rather
than a traditional pass/fail test, which tends to be flaky when
enforcing latency bounds, this test directly reports the latency of
various stages in the mapping and unmapping process.

> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/t=
esting/selftests/vfio/lib/include/libvfio.h
> index 07862b470777b..cf322b499cfba 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h

[ ... ]

> @@ -9,6 +9,34 @@
>  #include <libvfio/vfio_pci_device.h>
>  #include <libvfio/vfio_pci_driver.h>
> =20
> +#include <stdint.h>
> +#include <time.h>
> +#include <linux/time64.h>

[ ... ]

> +static inline uint64_t timer_elapsed_ns(struct timespec start)
> +{
> +	struct timespec end;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &end);
> +
> +	return (uint64_t)(end.tv_sec - start.tv_sec) * NSEC_PER_SEC +
> +	       (uint64_t)(end.tv_nsec - start.tv_nsec);
> +}
> +
> +#define TIME(_name, _expression) do {				   \
> +	struct timespec __start;				   \
> +								   \
> +	timer_start(&__start);					   \
> +	_expression;						   \
> +	printf(_name " =3D %.2lfms\n",				   \

[Severity: Medium]
Can this TIME macro clobber errno before the caller evaluates it?

If the target _expression (like mmap) fails and sets errno, the macro then
calls clock_gettime() inside timer_elapsed_ns() and printf(). These libc
functions can modify errno, causing the caller to read an incorrect errno
value.

For example, this happens in dma_map_unmap(), where the SKIP() check reads
errno after mmap() is executed through this macro:

tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c:dma_map_unmap() {
    ...
    TIME("mmap",
         region.vaddr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -=
1, 0));

    /* Skip the test if there aren't enough HugeTLB pages available. */
    if (flags & MAP_HUGETLB && region.vaddr =3D=3D MAP_FAILED)
        SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
    ...
}


[Severity: Low]
Does this output violate the Test Anything Protocol (TAP) format?

Since it outputs directly to stdout without the TAP diagnostic prefix
("# "), it might confuse TAP parsers. Would it be better to use TH_LOG() or
ksft_print_msg() here?

> +	       (double)timer_elapsed_ns(__start) / NSEC_PER_MSEC); \
> +} while (0)
> +

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/=
tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> new file mode 100644
> index 0000000000000..26c04cabef616
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

[ ... ]

> +TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
> +{
> +	const u64 size =3D SZ_1G;
> +	const int flags =3D variant->mmap_flags;
> +	struct dma_region region;
> +
> +	printf("mmap size =3D %lluG\n", (unsigned long long)(size / SZ_1G));

[Severity: Low]
Similar to the TIME macro above, does this directly output to stdout without
the TAP diagnostic prefix?

Using ksft_print_msg() or TH_LOG() instead would ensure the diagnostic outp=
ut
complies with the TAP specification.

> +
> +	TIME("mmap",
> +	     region.vaddr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -=
1, 0));
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804165748.1060=
476-1-aaronlewis@google.com?part=3D2
