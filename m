Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4D485508
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452927; cv=none; b=g+7QKJetqgdKNkyBkFr7G/JrmUE3pLtMB09bj1aX4EtwJbLvatqKRPsdfMTJEghIkW645FHi8WTTjWhxM+gk5YD/6lCpCVvMzvqef5uJqbvUuhwPRiWcI2WwZHz+NjuQV/k01i1xwS/qhktt2iu7MD9F26JtXhkQQ8QKD5qd6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452927; c=relaxed/simple;
	bh=qzsoWEcv+PXfhsMggom9GAOibr5hL2WXHlq3Gl0uj+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyjZBU/1ItJGtcr3IjRimjfqHJHTftcJ36OFLO3fXkodAatxvV7uuZ1uZiDqRaAO2734z3CRBVLhSgBR5NNDMe5mbjesVRZuIv25PH9zDl8RVIzLCHLPKS8DkJlIMIbZnyOyOA7JUehgfYRqB0jYS6hXl/uSwYnbY18Y1bbWlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnG1ISQV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnG1ISQV"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc758830601so3308542a12.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791452926; x=1792057726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8e2DeERYi/yIrYb8RsJE6PMRPzHosVXiLo+p290Ezb0=;
        b=wnG1ISQVjLoMHVPgRrfST4qgDZm9lidRxqXXh6SCALPFA0NNkHDwT8tiHRxbQcB70B
         u0Am398urM0OJ63VyLI+zrtUKIDUk8+wnwHeMfhh5tueSfU9Apkwc1+BtvFKtv9mtwMP
         cp0kgp0vNp65bKuvP1EwdwedQHSX5qu1VCoUyJyiubweaBpLKvq9H4KNptRwvyGEPr+X
         d6fP9I09E/ii8rIa6hNxIe3660ih3PbGtz49VrUYgFc+cvAkjC5xlGxQQnDeN0X5LjnG
         vbnB2FVViuHiO7j4GfOKIsMUJ8orjpTGBtIQxwh2W2dumMdJc93g8HAWRZqVgl05aqqK
         pbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452926; x=1792057726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e2DeERYi/yIrYb8RsJE6PMRPzHosVXiLo+p290Ezb0=;
        b=L5vZvjLDAF2fFhuezdfBcvPH+6IDH31ufdQs0p3M+91Q2ZuHb33jhbETGYBxHXJ1IQ
         ppmz4xhkqOb5TXEEAEiRGR4kusheBSMzL/eMwqgX24NiNn7ajODa8xM4eCjpmNvvv3do
         NAgTlpLY2YA5rkN5lhCJdoFXcZ6AXhy5UfaglVid8a9ry/slZHvS3IkX8MyUc/acX4H3
         QizN0Cl0utbUaIR3z6LZl2/OEOqUqBiyxkZBiDXBDb+b7fdGsPh9cKMmzmeNEesFOlj+
         Wked8qkftR7X6s7eZVxg7c3QmT7nwdxJnudGud6c385Pswz7OW5AhFr3n3OUsZzn+FrZ
         TOAQ==
X-Gm-Message-State: AFq9FYJ8WGtRvk5vXczhXG/4R/Li9id1/VELNL/w9pxca+eqZ9DVT8hx
	bZPfw9SzyHiaXWGXft92DLYPD8FnwgWfaAPZ5my8OCW3HMn+lE73xJYNYJMeBS2/c9rvLzFdBY5
	e9PgONE/370c=
X-Gm-Gg: AYBFou0OvNmBvXSDwsSXxImYi8KcVf+rw/7PwvPhHjhUV7s+RSjdqEMmX9fXyyph8fn
	A5/K4dvq41xhBv4z+RPeSCamo4VYfCE9kfAw84vXQqU1vMPTIugZCHdcuyV4s08qhWQWtwg95pL
	EANqF5lMEH6RQXtQP2vQDzK6I1WrWeU4oaPLzs/AuYo04xhptiH5DzEkjKh53foxU6kE0uLQ4Cn
	esZT10eGGHpofqnKDrMZ6pDgV1mkqu6wC3LUWyVaxAz2nkX+Xd+4Ew6dQWL6Kf3T96pqHvms54o
	UlJKnafjl+ybVyODGbgP+eiwjdpaKj/OmsA7oefLMA5ymhD4coOLyXKEo6tWQvuCktUeecFeQeI
	kW4VTzRHxfYUoilVWVPYWjPQH5FH/HKHA7JFPt3yNRRFdinWr9CZKhIisBTWKj43M+Pa+ZPaR1o
	WKevp23eYdnhnPrM/k1ByIdIjzdF7BO3jZ35drclFkiY0o7FlICncJqPkokD146bkvrqk+PVzs7
	pJZ32bXIJDr+JX/IPYscO+v2uShJppP3yJ8
X-Received: by 2002:a17:90b:5887:b0:3a7:cd7b:134 with SMTP id 98e67ed59e1d1-3a8a1974f13mr4463448a91.24.1791452925131;
        Thu, 08 Oct 2026 02:48:45 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89dbc9297sm4406143a91.1.2026.10.08.02.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:48:44 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:48:40 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v3 2/4] vfio: selftests: Introduce
 vfio_dma_mapping_perf_test
Message-ID: <asdm-NDNja-LxQem@google.com>
References: <20260910153326.3085937-1-aaronlewis@google.com>
 <20260910153326.3085937-3-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910153326.3085937-3-aaronlewis@google.com>

On 2026-09-10 03:33 PM, Aaron Lewis wrote:
> Introduce vfio_dma_mapping_perf_test to aid in latency testing. Rather
> than a traditional pass/fail test, which tends to be flaky when
> enforcing latency bounds, this test directly reports the latency of
> various stages in the mapping and unmapping process.
> 
> Start with a basic test that performs a simple DMA map/unmap and tracks
> the duration of each operation. The test reports the following metrics:
> 
> 1. Time taken by mmap().
> 2. Time taken to map a DMA region.
> 3. Time taken to unmap a DMA region.
> 4. Time taken by munmap().
> 
> Subsequent commits in this series will introduce more features to allow
> for a wider variety of testing.
> 
> To ensure consistent DMA mapping times, the test uses MAP_POPULATE when
> calling mmap(). This forces page faults to be handled upfront, isolating
> the DMA mapping times from them.
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>

Aside from the nit,

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  tools/testing/selftests/vfio/Makefile         |  1 +
>  .../selftests/vfio/lib/include/libvfio.h      | 31 +++++++
>  .../vfio/vfio_dma_mapping_perf_test.c         | 90 +++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 2c32c48db509..ed5856af5f9a 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -8,6 +8,7 @@ else
>  CFLAGS = $(KHDR_INCLUDES)
>  TEST_GEN_PROGS += vfio_dma_mapping_test
>  TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
> +TEST_GEN_PROGS += vfio_dma_mapping_perf_test
>  TEST_GEN_PROGS += vfio_iommufd_setup_test
>  TEST_GEN_PROGS += vfio_pci_device_test
>  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> index 07862b470777..8496b8b4da3c 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> @@ -9,6 +9,37 @@
>  #include <libvfio/vfio_pci_device.h>
>  #include <libvfio/vfio_pci_driver.h>
>  
> +#include <stdint.h>
> +#include <time.h>
> +#include <linux/time64.h>
> +
> +static inline void timer_start(struct timespec *start)
> +{
> +	clock_gettime(CLOCK_MONOTONIC, start);
> +}
> +
> +static inline uint64_t timer_elapsed_ns(struct timespec start)
> +{
> +	struct timespec end;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &end);

Maybe rename timer_start() to timer_get() and re-use it here.
