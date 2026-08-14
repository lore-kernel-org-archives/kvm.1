Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1933B6CC
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739531; cv=none; b=kGSUkdLNWaFhNzEnvcDq/YqseuLIOcgi6u9NWYNqagDqSELt5Z2l7q4wfpF2IBHcUggyNgLc8+pYdNn/Ikwo/4nK9pwkGrItuQka2dY6hL579g4Saaaj6NUxu/hxM4OWiHlOLg+m6iuMref8o68CPaiR/w/y2IJDOWrwny1LZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739531; c=relaxed/simple;
	bh=MK/2wvBExvaRorwp7Kd0NgP5LRlZ05gKnlm2NTq2DwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPgoA84EKf7g9IEEtEx60aL/nJ6mkjvWyOMqbLgHjapwRnP1cLoFkZiDFguYSPm7fgOnNtD4ylOdcz1tmZdgv41JG3WlmL3HoVE7ijv985KuLjHKdGjpkA/9NIe8uTUcUcxvuZzjU4R/H9c9umE+R+mhM4uCKch/AjqIqqdisZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEykB5xF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEykB5xF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1489116b3a.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786739529; x=1787344329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gHMgqR5xaH+LzeveXaQjYX4+JDNDzjOWZYfupv8kpk=;
        b=DEykB5xF53/mTmDEb+d48GVev88sWC5177omiUh6gvmLwGz5Cl2O8I60MI+wF8e4mf
         HyEatXtmUnnJcOxCsjrgFK8OV5ZmWt86audKcj4loYzFnwDLqZUTk39qruSZZxJyYOPe
         KAzX175lRu1XGMgtsu4ipDeUp9aAch4MKW+Vn5mDOmNJfHn/lyxGoS0D8IKN0VrObrf1
         lhvq7LC1FPVY1wADBZR6dv3M/ih4xunmDNyXICs/UHwwbcVU8T4KXku7uCbVEAqLtJHv
         sHwVbXs95GPQlDTchzG3W2sapPnOsqpYpPmdVS03gHvVnWKdfq6Kdu61JBfGYUyb2bIH
         z8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786739529; x=1787344329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3gHMgqR5xaH+LzeveXaQjYX4+JDNDzjOWZYfupv8kpk=;
        b=hx+oVT7yE8XLiLbXqLaAiIH/Dvs8RLdjlQTjigiCmfQbBcBe1YFBc/opiS/pirCSrH
         5DWKAW6CrGM0p13XOqyhgHE9Hubo/jRhaZWQVYm/b0ONv9Frr5agNG8RMXyXz+A4JTM9
         OBoYm9cR8Ic45CdfkFnW3duJ+a/VrECkMlAiuNxycX8fzvgkkDBF68+olATD+zOQsTGm
         pAlGbDaxhlK+ARoCTT03I+OFFz2gVgqR8b+XW0uaGzThwr3NBKpy6v9/GqB2xxgwfFop
         dB2SvTJ0tgivcCHRbGIbWI9ewPZZHRWKDc2Rgsy9ErifRuzz90KwyDA7coJVtht1gzrY
         oZNw==
X-Forwarded-Encrypted: i=1; AHgh+RrO9Qme+3qQJTwO9R8+DqufW4dgKi/kB7DxQ25b5dpiEqU3+Qv9sYDjOXbPJI3GwSApDso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTcxCA0Pn9HF+PXPflhkX9Ei8LHqVPcCs6lfbUCWNXiVXs5LH
	Qt6xr9MOy9y06KTit8WWuTeBzFoMG19cDrGExYR+S+Xg9QMoE6Ro8tTGz0BM8t1uXEWD+WxJNeU
	yyS/2zg==
X-Gm-Gg: AR+sD12MDfoj3I/puCX8mZrBVNJkcjwfu1d3099F18BeHv3/HWAcBHscmIT4O4gAlfK
	nAD7x2MCdQWwB/2d+v3ppIO28e8wiEYRA3vkmyfoh+vNhx0nijn5mdaH+gTksz5fX/luzgQLXfW
	641jPnMBPeM/MXNE9KveUPXVfy8kkiERydie8lM5XKdFcQae/wFlvxZUKwEKKVJpvifffmLc3Mq
	AlDdeWK6BfM1mW9yGWLIdeMS1xzB1ZpWb7+VtlwWHWYDgvaBgz/1xWSPBIgggtRVlZj7ftVQaRN
	C8hZFRx6RswyOQW6VphxzMdltewbLxImKEJmjlh3J1UG7iozVlg2eWsmP4+NT0DEwavB18XeY3Y
	tEwric208EmSBuCTvX4GY2Z0aSCUxnv814PQV1bJj9NGcf4MWQPaGR4fJ1RpZyPYaRXnJ5GIRI6
	sWEVAemHOPyZ0T8boFOf5VT49cViXAaLGpybZTIad7IH1RtYZlbkRUsJQ0bIYlTuBerzguKpAO5
	3+kwRdIBh4E55pF6Y8e//O5xPprXJdrHd0L+czPaA==
X-Received: by 2002:a05:6a00:14cd:b0:84e:1a9d:d879 with SMTP id d2e1a72fcca58-84fde32a11emr9358821b3a.28.1786739528814;
        Fri, 14 Aug 2026 13:32:08 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d046638sm970844b3a.27.2026.08.14.13.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:32:08 -0700 (PDT)
Date: Fri, 14 Aug 2026 20:32:05 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Aaron Lewis <aaronlewis@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] vfio: selftests: Introduce
 vfio_dma_mapping_perf_test
Message-ID: <an97Ra3XXqqgnWJu@google.com>
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-3-aaronlewis@google.com>
 <20260804171540.F09C11F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804171540.F09C11F00A3E@smtp.kernel.org>

On 2026-08-04 05:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `TIME` macro can clobber `errno` before the caller evaluates it.
> - [Low] Diagnostic output uses `printf` instead of `TH_LOG` or `ksft_print_msg`, violating the Test Anything Protocol (TAP) format.
> --
> 
> --- Patch [2]: [PATCH v2 2/4] vfio: selftests: Introduce vfio_dma_mapping_perf_test ---
> commit 3d215ae55639b2f45faac3bfc752e16beff09489
> Author: Aaron Lewis <aaronlewis@google.com>
> 
> vfio: selftests: Introduce vfio_dma_mapping_perf_test
>     
> Introduce vfio_dma_mapping_perf_test to aid in latency testing. Rather
> than a traditional pass/fail test, which tends to be flaky when
> enforcing latency bounds, this test directly reports the latency of
> various stages in the mapping and unmapping process.
> 
> > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> > index 07862b470777b..cf322b499cfba 100644
> > --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> > +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> 
> [ ... ]
> 
> > @@ -9,6 +9,34 @@
> >  #include <libvfio/vfio_pci_device.h>
> >  #include <libvfio/vfio_pci_driver.h>
> >  
> > +#include <stdint.h>
> > +#include <time.h>
> > +#include <linux/time64.h>
> 
> [ ... ]
> 
> > +static inline uint64_t timer_elapsed_ns(struct timespec start)
> > +{
> > +	struct timespec end;
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &end);
> > +
> > +	return (uint64_t)(end.tv_sec - start.tv_sec) * NSEC_PER_SEC +
> > +	       (uint64_t)(end.tv_nsec - start.tv_nsec);
> > +}
> > +
> > +#define TIME(_name, _expression) do {				   \
> > +	struct timespec __start;				   \
> > +								   \
> > +	timer_start(&__start);					   \
> > +	_expression;						   \
> > +	printf(_name " = %.2lfms\n",				   \
> 
> [Severity: Medium]
> Can this TIME macro clobber errno before the caller evaluates it?
> 
> If the target _expression (like mmap) fails and sets errno, the macro then
> calls clock_gettime() inside timer_elapsed_ns() and printf(). These libc
> functions can modify errno, causing the caller to read an incorrect errno
> value.
> 
> For example, this happens in dma_map_unmap(), where the SKIP() check reads
> errno after mmap() is executed through this macro:
> 
> tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c:dma_map_unmap() {
>     ...
>     TIME("mmap",
>          region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0));
> 
>     /* Skip the test if there aren't enough HugeTLB pages available. */
>     if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
>         SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
>     ...
> }

Please fix this. Something like this?

#define TIME(_name, _expression) do {				   \
	struct timespec __start;				   \
	int __errno;						   \
								   \
	timer_start(&__start);					   \
	_expression;						   \
	__errno = errno;					   \
	printf(_name " = %.2lfms\n",				   \
	       (double)timer_elapsed_ns(__start) / NSEC_PER_MSEC); \
	errno = __errno;					   \
} while (0)

> [Severity: Low]
> Does this output violate the Test Anything Protocol (TAP) format?
> 
> Since it outputs directly to stdout without the TAP diagnostic prefix
> ("# "), it might confuse TAP parsers. Would it be better to use TH_LOG() or
> ksft_print_msg() here?

TH_LOG() requires defining TH_LOG_ENABLED to get the logs. I don't think
we need that kind of on/off switch for the timing logs; they should
always be on. ksft_print_msg() looks like it would work for getting
these results printed without breaking TAP parsers.

> 
> > +	       (double)timer_elapsed_ns(__start) / NSEC_PER_MSEC); \
> > +} while (0)
> > +
> 
> > diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> > new file mode 100644
> > index 0000000000000..26c04cabef616
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> 
> [ ... ]
> 
> > +TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
> > +{
> > +	const u64 size = SZ_1G;
> > +	const int flags = variant->mmap_flags;
> > +	struct dma_region region;
> > +
> > +	printf("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
> 
> [Severity: Low]
> Similar to the TIME macro above, does this directly output to stdout without
> the TAP diagnostic prefix?
> 
> Using ksft_print_msg() or TH_LOG() instead would ensure the diagnostic output
> complies with the TAP specification.

Let's use ksft_print_msg().

> > +
> > +	TIME("mmap",
> > +	     region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0));
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804165748.1060476-1-aaronlewis@google.com?part=2
> 
