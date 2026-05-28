Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD2305669
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992013; cv=none; b=C7TD+abS4vFIhJGxxZwr6h4jLpEe4Wik1T5uBd73U5V85hQgioJwnR7uGd0Jk+9Pnxpu5dxYz/Xz8JWtggrA08auOmTXdHGj26c30rsQ0Yq1sTwSjaQ131F7IOB/ZUle4mj4zE0OzY5W5Xd9yNxKweNWjWSZeKLswlYTMYxwb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992013; c=relaxed/simple;
	bh=olgS644GXBJ8sN4D9PdM4exux7HJbLCjd7+u5JgazSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsRqRFXrcSAV/lnvmT2BRTHHNB5HGPY0G8v7FZUfB48oQbE3BbjcTIhLkdkez3Kr61J5MuVfbuHcI6wQ5Sk6W0Qpmrkk/5fec4rZn6HrptSj7YPhtIzQWpbW8bfNQeD+erSRfx99cWIshlLNl3Vj5q59OLuuALKQV42wcQzpxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpycXfcU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpycXfcU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2baef9f5ecdso105497775ad.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992011; x=1780596811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpxsk/T+HI611YA3BXnCwNdpS4kyHfnhJj1enlM0vqI=;
        b=EpycXfcUm6voEldLgmN0HiW7hPTdOUp6fx4Zgv2wDzUiEy973E0M0+Y0xxAnDt1p0l
         dIgX78/JUiYLxeLpEFPyYYil6gtohU64dPvZ1Dcl16mX/hKaKVgDLsKp/5KeRbHV8++x
         eQigHHLT5ZT4IVdWGEeMvK7C9HPvYHW88GyBM7qaznqzYe5PsWAuSmC4kx9COKFszGNW
         rG9+qqMO1V+06u2avvy5cfYqUQAOFYiT1eJtUGqBfLDMyvP0b4eQoUs2L8fJaZYGAxAU
         /UKC6H3ZYcPnMJ8xxM5yDXtWfLaMA2PO2ao8DNR5WbYrZwUOq6RaSfhXEc1fGhOZVFFw
         3EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992011; x=1780596811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dpxsk/T+HI611YA3BXnCwNdpS4kyHfnhJj1enlM0vqI=;
        b=pTA/4/f6rK6pRJQSEsjKCrXnLsP/nrfA/NRWmzJWhEWQbp8vmBSEt1fQLZfVjWLm48
         FPQfsu4fIOmF2O/J3DPZk9VG/IVtrOSy2E7H1DYkcb5TCKyFMKOx6T4Ct08z1ARxybzr
         r25QAqst7/TA4FxLBDsRI67qSdJhTr1LCwqcLnu+xYjyrMTiZc6k8mga9rrnsW8QkYRD
         Vlz3fbe1g32bIc/A8uyrxqegXR7o5elEBCvv8CpMCtbgSVrca1tPicWlEdWf8eqt0dA4
         c/DX0DNGebbv6yFc1Y+b00sT52O5SzEmZbFvHrw6zdzo9kuLaR0IPFeCT2BoweUMRLp5
         FxDw==
X-Forwarded-Encrypted: i=1; AFNElJ/YPSwjLWjLFisvZfYMQ2aP5ICJ583uv8P7IABnaBjABW0fUdZipd7HDQvvyI1drANVNt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5my8A3WaJ0aFmymGQXOR4jznpnx1Wq2lqrd62/2Rg9T15fSig
	AXOYTsblWPZqufK7jN/1vZQ2qvditlID2u+ypTVBoU1qI0EF9zF0sn/oeKC57tuu/A==
X-Gm-Gg: Acq92OHlYNq9pUD+0y+EDml0CEWJXIAjdmo6NJrifLqss3G9nykGqNh5XqdCEjcAwN9
	SDqhKRyZN3VvyeUTteeVIqwsVEHIJuu6PJJflr6fPVWzU1GWRoxSPqP4TFtptbT80VlF80ivlK5
	z+8cW+72qxeevXugT1pBAWCpv/sJW/90b2iwqKw8HQasLMiYPehO+fEi1atrA1hwcdtF3ebjJvS
	EPHDMwEoSR0vFy/Q9Ol/JXObto0i45xu+6nMC62zm5IAx9fI42u3lZjQMBOLnnb4WZViaMI4s0b
	9vN7vaKgvj/aCwwxownDUsZBjY3UUP/ztMGcJfYAfV7vXisQTJdeOtWWfGLCoya7xgQgO5vDqxy
	QcbC8ZXsAGj2r038jEpuaX2OxcqbWeuU/BZ6PCV5b4UxNiQI+Xxp+KReiu/liinGVZrdhxZ5xaj
	B4Z1xagn1bSGN/Js7pGuWMaXkY5nbU9I7AI4m1asQD/83IaKqn+RIOCs4YEUwWn4dJwn65KuoU
X-Received: by 2002:a17:902:c94a:b0:2bd:9728:5e42 with SMTP id d9443c01a7336-2beb074b967mr322151685ad.31.1779992011034;
        Thu, 28 May 2026 11:13:31 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e38a934sm174895ad.0.2026.05.28.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:13:30 -0700 (PDT)
Date: Thu, 28 May 2026 18:13:26 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match kernel
Message-ID: <ahiFxtmspbETiqWw@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> The tools/include readl/writel MMIO accessors on arm64 use
> inner-shareable barriers (dmb ish) while the kernel uses
> outer-shareable (dmb osh).  Fix them to match.
> 
> Add __io_bw() and __io_ar() definitions matching the kernel's
> arch/arm64/include/asm/io.h, including the dummy control dependency
> in __io_ar() that orders MMIO reads against all subsequent
> instructions.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  tools/arch/arm64/include/asm/barrier.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
> index abdc64fc3c70f0..3f7fcb2a27541e 100644
> --- a/tools/arch/arm64/include/asm/barrier.h
> +++ b/tools/arch/arm64/include/asm/barrier.h
> @@ -28,6 +28,20 @@
>  #define dma_rmb()	asm volatile("dmb oshld" ::: "memory")
>  #define dma_wmb()	asm volatile("dmb oshst" ::: "memory")
>  
> +/* Match arch/arm64/include/asm/io.h: use osh barriers for device MMIO */
> +#define __io_bw()	dma_wmb()
> +#define __io_ar(v)							\
> +({									\
> +	unsigned long tmp;						\
> +									\
> +	dma_rmb();							\
> +									\
> +	asm volatile("eor	%0, %1, %1\n"				\
> +		     "cbnz	%0, ."					\
> +		     : "=r" (tmp) : "r" ((unsigned long)(v))		\
> +		     : "memory");					\
> +})
> +

Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
headers are more aligned with the kernel headers, and so that the arm64
io.h overrides are done in the same way as the x86 overrides in
tools/arch/x86/include/asm/io.h.

Something like this (untested):

diff --git a/tools/arch/arm64/include/asm/io.h b/tools/arch/arm64/include/asm/io.h
new file mode 100644
index 000000000000..8a5de4fe2afd
--- /dev/null
+++ b/tools/arch/arm64/include/asm/io.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_ARM64_IO_H
+#define _TOOLS_ASM_ARM64_IO_H
+
+#include <asm/barrier.h>
+
+#define __io_bw()      dma_wmb()
+#define __io_ar(v)                                                     \
+({                                                                     \
+       unsigned long tmp;                                              \
+                                                                       \
+       dma_rmb();                                                      \
+                                                                       \
+       asm volatile("eor       %0, %1, %1\n"                           \
+                    "cbnz      %0, ."                                  \
+                    : "=r" (tmp) : "r" ((unsigned long)(v))            \
+                    : "memory");                                       \
+})
+
+#include <asm-generic/io.h>
+
+#endif /* _TOOLS_ASM_ARM64_IO_H */
diff --git a/tools/include/asm/io.h b/tools/include/asm/io.h
index eed5066f25c4..1090a2c387f4 100644
--- a/tools/include/asm/io.h
+++ b/tools/include/asm/io.h
@@ -4,6 +4,8 @@

 #if defined(__i386__) || defined(__x86_64__)
 #include "../../arch/x86/include/asm/io.h"
+#elif defined(__aarch64__)
+#include "../../arch/arm64/include/asm/io.h"
 #else
 #include <asm-generic/io.h>
 #endif


>  #define smp_store_release(p, v)						\
>  do {									\
>  	union { typeof(*p) __val; char __c[1]; } __u =			\
> -- 
> 2.43.0
> 
