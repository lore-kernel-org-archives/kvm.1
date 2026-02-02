Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37E287276
	for <kvm@vger.kernel.org>; Mon,  2 Feb 2026 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075208; cv=none; b=TH7bOpfrft3nR4vXDvKSPEO5im75nKMyquxlrOEjAkWBtuhIZT2WzrhR4zastuWmHgoBT2EZWi+pahEXE+Odv1CZw8crLyhJq2uHZReLJKuq/s4WqVMPhfMGPU9aMRe1yHVCP/7aSkYbGa8UKWP70oaT9VSbPVXPkcjjeUuEDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075208; c=relaxed/simple;
	bh=1PfIjcCUf0n72gkr/qQ6+v00sY0aohTisHhVNRQacLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia+VjBp3SECWSTZ4PkgIDHJ12vmwVqC/PevkQ9r4dtvFqY7ys8aKPstb9lJBI/VfSVJUcnDvBw/A+DmViA80Ku0hlnjOi/mgaqWLtwpBZvc1+O1yRHC8mPsqv0m6Fht4OshUopq5j+Uz6nns1J2lWOuM+Z+ErR+g4yHLfMlS/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKjgT1ZO; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKjgT1ZO"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81c72659e6bso4375317b3a.0
        for <kvm@vger.kernel.org>; Mon, 02 Feb 2026 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770075206; x=1770680006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANttx+3xqwhzhSSAtBDnWSGrH0OO63SEOI513k0jcTs=;
        b=TKjgT1ZO5liHq6OiXBYYg5X0PrMd127f0GCrsSKlw+Js8ypQq2d4f6ivRSrc4DWaEQ
         tJ7qgYC57TbIkQyGxa/T1tK54XH825jB2r7RwASZ+btFrcbEd+Gl3yLHM0qxnMvK1Bhp
         dTBDFfF7lwUypiJh7sg3ealU6dLVVc2bpgsgPv/7S72PnG2O9UOJG86ieF3q64N2FjFj
         DAnffbabVFcYI93FwgBNlMrAxhCfBTz/TyoU1+DD34k5xnFMydx/phFJFWe/ab6zxRDj
         lCJmYrDjkcGHxjhi/frTmYWPv9qc9/mI4/u+ZzKTWxLtcbbsE5M+dEHT+xRbCR+Xvbj7
         w2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075206; x=1770680006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANttx+3xqwhzhSSAtBDnWSGrH0OO63SEOI513k0jcTs=;
        b=FCw9YAAfSacJ0vuMjtT7MSesXzpyaXUw08P7PbLvWbu3jncdMyOJTB5WBYKtfHENgA
         Q+4vIhAMwUcx+2+6L9tArXnVruiccGqpKZ1Ju8ruzvGecEH3MoAPQmrGgu/RSwVQ98vA
         UMbgkCH1WWnbR/d5+A+fk1x3EXBCJnRxjCUa+H00JIrvUxBMIMMGTblamJgKO+Brv/1S
         ev/YlJKKyI1t3ncTv1HhqhU/F9ZcW4JnkXlB98AJcBrn3OgUj+y3aGOWmaQmfsk/RgOp
         1mUQ8k2Qppl3wMYDvdgV56vZrblUMlRTTl4Mw3vaLhsGTmYWtkv6OvStUQfpr/u9YcJ9
         w2WA==
X-Forwarded-Encrypted: i=1; AJvYcCUNATu/sbf9vt2SfyzoO7WFQ+GxDI6ZNqCbQvEiBbjWjE203D2e6GZR/j3cNVMYjP5MY0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WD+dCJAIlpqrsqeE6I7GLEEXNG6gTKE7wcbuV3Cdb2QZuCJl
	TtrIb3SxeJY9D5xB+bFepD29+St0eppL7o66oFgbqx7IdXPQcLeqdF77qQKi8w+U/g==
X-Gm-Gg: AZuq6aL5vME19e1OI+5EO89V7pWT46P6YoRRz0FKVQijfMphGq0AQkB3cQQ7EdCl/Gh
	OmBGN8U5MuZq5zTZ+epvDtK1J3FxRWXJQgJJdhX8wduACidKxKyB/gbTE3a3cUfKlTrdpTFLRJF
	lNYzTDv4vBk1W46hQlfkAXBJv2BIzt3fHRibnIfJsYDeIT+wlMt4vGkMKdJnUOThb7vSYhSO1H9
	S/6VBhFBRPBaEjWkBujDKypx186Kj07tbgBY+ms0dlAAs4c2kW4JKF1gkxh2XhS+ghl/2AZc3Jy
	HAMZeNMPHXpwqj1zqy38bEfQZnVjsoYkBjsLIJ7Zddx6BYsWX3F0FwXCCcXI/Bp3t9rnLIpaURE
	NeEuqPCwQhQDDnHIFSFrunR31AkUPqQN9ScOf2VavIwzcqBCgoBxXKDWi3txUTvMCuf4IDtjLmi
	at7VomOYBpoKKVoyNTOevj+eVqqh/YpWkxkHrsaSh7G3VjFe0MWg==
X-Received: by 2002:a05:6a00:9089:b0:81f:517a:56e7 with SMTP id d2e1a72fcca58-823ab6963c7mr12552960b3a.30.1770075205957;
        Mon, 02 Feb 2026 15:33:25 -0800 (PST)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b49fecsm16438559b3a.15.2026.02.02.15.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:33:25 -0800 (PST)
Date: Mon, 2 Feb 2026 23:33:21 +0000
From: David Matlack <dmatlack@google.com>
To: Ted Logan <tedlogan@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vfio: selftests: only build tests on arm64 and x86_64
Message-ID: <aYE0QUnXYq6OYvq9@google.com>
References: <20260130-vfio-selftest-only-64bit-v1-1-d89ac0944c01@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130-vfio-selftest-only-64bit-v1-1-d89ac0944c01@fb.com>

On 2026-01-30 04:02 PM, Ted Logan wrote:
> Only build vfio self-tests on arm64 and x86_64; these are the only
> architectures where the vfio self-tests are run. Addresses compiler
> warnings for format and conversions on i386.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601211830.aBEjmEFD-lkp@intel.com/
> Signed-off-by: Ted Logan <tedlogan@fb.com>
> ---
> Do not build vfio self-tests for 32-bit architectures, where they're
> untested and unmaintained. Only build these tests for arm64 and x86_64,
> where they're regularly tested.
> 
> Compiler warning fixed by patch:
> 
>    In file included from tools/testing/selftests/vfio/lib/include/libvfio.h:6:
>    tools/testing/selftests/vfio/lib/include/libvfio/iommu.h:49:2: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
>       49 |         VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:32:37: note: expanded from macro 'VFIO_ASSERT_EQ'
>       32 | #define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:27:22: note: expanded from macro 'VFIO_ASSERT_OP'
>       26 |         fprintf(stderr, "  Observed: %#lx %s %#lx\n",                           \
>          |                                              ~~~~
>       27 |                         (u64)__lhs, #_op, (u64)__rhs);                          \
>          |                                           ^~~~~~~~~~
> ---
>  tools/testing/selftests/vfio/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index ead27892ab65..eeb63ea2b4da 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,3 +1,10 @@
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)

What's the reason for the stderr redirection and "echo not"?

> +
> +ifeq (,$(filter $(ARCH),arm64 x86_64))
> +nothing:
> +.PHONY: all clean run_tests install
> +.SILENT:

I think you can just add the following line so that this is a valid
empty selftest Makefile on unsupported architectures, without having to
define all those targets:

  include ../lib.mk

Also I would recommend spacing things out a little so that the
unsupported architecture handling is more "off to the side".

e.g.

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ead27892ab65..9386f75b590d 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,3 +1,10 @@
+ARCH ?= $(shell uname -m)
+
+ifeq (,$(filter $(ARCH),arm64 x86_64))
+# Do nothing on unsupported architectures.
+include ../lib.mk
+else
+
 CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
@@ -28,3 +35,5 @@ TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
 -include $(TEST_DEP_FILES)

 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+
+endif


> +else
>  CFLAGS = $(KHDR_INCLUDES)
>  TEST_GEN_PROGS += vfio_dma_mapping_test
>  TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
> @@ -28,3 +35,4 @@ TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
>  -include $(TEST_DEP_FILES)
>  
>  EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
> +endif
> 
> ---
> base-commit: c3cbc276c2a33b04fc78a86cdb2ddce094cb3614
> change-id: 20260130-vfio-selftest-only-64bit-422518bdeba7
> 
> Best regards,
> -- 
> Ted Logan <tedlogan@fb.com>
> 
