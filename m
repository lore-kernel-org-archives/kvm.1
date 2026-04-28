Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D781ACED5
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402942; cv=none; b=lBUz7teHMeeNFfJx8L2hqmwN/Ehq4iIMflUiRGaX0qBtU7dJVEtmskp+CaLFq5hycDf7lP7uqukWSq3Gs4mS4SmF/FPozH4Q6UsJ4hkfhZGwEBdKG+Lf77RtqEAZYNnFMm1q/dsE2AW8ZQrLGBH8rSQ2k488O/KxkCl/t1aqpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402942; c=relaxed/simple;
	bh=utj7qAfjlNCCoxisNE8c1eXcslz7rYb9Hqgx+ZHGzoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ0wgvZAD92hIeStLRJWmJYVJHuqJadez29tbVHeq8UJF9x+1NZ8CPuVZ0EJINXL9MfHmyiniFR5U6FW5IJ40wswi93E6SDDojri00k7qDGfM6O44gqsPUNu6d866npWtXcGC3ZrwONBua4Vwi+aD9DrCgV0dm13+IP1QC1SbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfPZn/6B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfPZn/6B"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b45cb89f7eso73753025ad.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777402941; x=1778007741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUzs5gShcjOh9gjGckbIhxPp4FsmMFw+qYY2UNbR7e0=;
        b=pfPZn/6BHKj15/714PmoD6yCkxfcoWhHVpY9gDxKCeV6hgwxjMch3YIGj/c+L7onLd
         1/kE/cd4+2oIMyM9ey1Gton1Q0OykXln0NWlgioF8GeCigmkg6TT/FjeCAHUqcc90nsu
         eu9BFQ+u8cCw9XAg+0XoX582t61T40SR384giKZR918MD81RqzwKFHI1EtJAYPoBigcm
         MjxlbTrPW4YLXoaYvab7DnI1lUaJuzJrqvmQEKAbzqNLSLqUGledF/dVsRrWIU87CKG/
         Yr8scLj96LazgxRR6kP0ankAsilRyx2yMw95JUBj6DUBpuPvLZoiIAZkZKnvgFR4EGF7
         1Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777402941; x=1778007741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUzs5gShcjOh9gjGckbIhxPp4FsmMFw+qYY2UNbR7e0=;
        b=dviPrrD7zMFTC1Ak68qopGljDMHhhbHLeHLB+eDvrLwPWC2H4hoEpo9gepn62VrmOP
         Xzeid8DT2druCOUIybjs4YPk3kfGW40Kj+r0qj94TWfHtt9ICZkBRv/DQvmEnzn53Mk4
         4IJKVzSLRvid0Sea6VXyw+OZam8noO0h4jcl+2Exupz5qy+WhEwhJ7U0Lhx0IeH3vHpy
         MJ4ZU3ATeAAtLWQw3SnBv3MRmTrmgQ4l+OYLdJtd/TFD3o67hMk3rgl5w9D8k0VqsOYu
         m3roiSuom/rmnbpzJW47qRhRlDlISRsUUZYFurDWElCzEi2P30zawIRY9/myDlHNxfSm
         Ln5w==
X-Forwarded-Encrypted: i=1; AFNElJ+fiawyABOCg3YUe8irG+1cCRvyaPEnyOEu7+/LW0N2Ek3pCUUiJmKPKk+9AGHFnDRkAqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrRYDZBJy2+LenxP/LFWKNau50E2eAWDvBafqQHkGKA6OBQB+
	vbcleU9662XGV1Tev9woMy//5knm+dBChkHLHWC57br8Vf7UxbVEkQ1tk/Ysm/hX/w==
X-Gm-Gg: AeBDievUJ+Vh2XDuSgVF0RRzaVhuQQvysottChTOBYIhkDn+B2mTIE7qSrNmnQEPsvW
	rmCxFZdHUcuZkrQpOKoZr0oRCRHXuUg7XhXOVz/Ky64YKcbwpuuGyGXosLLkTMWhCIMgzvleH/O
	xS/8Hc2JVupwjZ/fDNzGUGNBDQ/WWwanLuhN3eBgbax//Q7dSBYTEiX02ZTEPWTr+/bP8E0YMdD
	iaO+LjOU7j2mkK24b3hTULMGtI/2j27pvI3Mnl+p/PNjkutnpnDuQXKOVwXNFLz6mYDH94xROWu
	kx0cVl/tZkQ0dBUiLwc+ZR1RX9vjaaSjctpVbghipn3VyDVY2Mqx/H+IgG+0f222o2g/lDPoxIU
	/vkawNfUAtfmRl7rl3mhXhMaxFJteizG6jwrVmeKO4xKK0sHgNgWOi+FNgL5iDhF8+jR0TEv3T5
	pK15zlp2Wqs1KgJDS6rQVEJjncV/nhIhBJxIXeRRrczu1THMyU/dz/lfeo+p46Ek1Ih8q2x3pFV
	no0Ew==
X-Received: by 2002:a17:903:2ed0:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b97c4120bdmr44062645ad.8.1777402940096;
        Tue, 28 Apr 2026 12:02:20 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887a4ba0sm2025ad.32.2026.04.28.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:02:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 19:02:15 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>,
	Ted Logan <tedlogan@fb.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
Message-ID: <afEEN_4ufBcQld0q@google.com>
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
 <20260427231217.GA1670652@nvidia.com>
 <afATrrjqt8zj2plL@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afATrrjqt8zj2plL@google.com>

On 2026-04-27 06:55 PM, Sean Christopherson wrote:
> On Mon, Apr 27, 2026, Jason Gunthorpe wrote:
> > On Tue, Mar 17, 2026 at 01:55:17PM +0000, Matt Evans wrote:
> > > Hi Ted,
> > > 
> > > On 03/02/2026 01:23, Ted Logan wrote:
> > > > Only build vfio self-tests on arm64 and x86_64; these are the only
> > > > architectures where the vfio self-tests are run. Addresses compiler
> > > > warnings for format and conversions on i386.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202601211830.aBEjmEFD-lkp@intel.com/
> > > > Signed-off-by: Ted Logan <tedlogan@fb.com>
> > > > ---
> > > > Do not build vfio self-tests for 32-bit architectures, where they're
> > > > untested and unmaintained. Only build these tests for arm64 and x86_64,
> > > > where they're regularly tested.
> > > > 
> > > > Compiler warning fixed by patch:
> > > > 
> > > >    In file included from tools/testing/selftests/vfio/lib/include/libvfio.h:6:
> > > >    tools/testing/selftests/vfio/lib/include/libvfio/iommu.h:49:2: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
> > > >       49 |         VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
> > > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:32:37: note: expanded from macro 'VFIO_ASSERT_EQ'
> > > >       32 | #define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
> > > >          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:27:22: note: expanded from macro 'VFIO_ASSERT_OP'
> > > >       26 |         fprintf(stderr, "  Observed: %#lx %s %#lx\n",                           \
> > > >          |                                              ~~~~
> > > >       27 |                         (u64)__lhs, #_op, (u64)__rhs);                          \
> > > >          |                                           ^~~~~~~~~~
> > > > ---
> > > > Changes in v2:
> > > > - Add white space around arch checks
> > > > - Clean up uname command
> > > > - Link to v1: https://lore.kernel.org/r/20260130-vfio-selftest-only-64bit-v1-1-d89ac0944c01@fb.com
> > > > ---
> > > >  tools/testing/selftests/vfio/Makefile | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > > > index ead27892ab65..8e90e409e91d 100644
> > > > --- a/tools/testing/selftests/vfio/Makefile
> > > > +++ b/tools/testing/selftests/vfio/Makefile
> > > > @@ -1,3 +1,10 @@
> > > > +ARCH ?= $(shell uname -m)
> > > > +
> > > > +ifeq (,$(filter $(ARCH),arm64 x86_64))
> > > 
> > > This fails to build (i.e. elides the build) on my local arm64 machine,
> > > because uname -m returns 'aarch64', not 'arm64'.
> > 
> > I have the same issue on x86! The kernel uses x86 is the ARCH when you
> > run it straight from the top level make
> > 
> > make[4]: Entering directory '/home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio'
> > Makefile:1: "Saw ARCH=x86"
> > 
> > Even though this is a 64 bit build.
> 
> Heh, it's much funnier when it's happening to someone else.  :-)
> 
> KVM selftests went through these exact pains.  I'm pretty sure these are the
> relevant commits (the empty targets one may or may not apply to VFIO).
> 
> 9af04539d474dda4984ff4909d4568e6123c8cba KVM: selftests: Override ARCH for x86_64 instead of using ARCH_DIR
> 67730e6c53d70fb31618230f81c4acee9f72eaa3 KVM: selftests: Use canonical $(ARCH) paths for KVM selftests directories
> 43fbd8cd389faa9760c5152b1c58e893c812953b KVM: selftests: Provide empty 'all' and 'clean' targets for unsupported ARCHs

KVM selftests don't prevent 32-bit x86 builds though, which is part of what
we're trying to do here.

For example running...

  $ make -C tools/testing/selftests/kvm ARCH=x86 CC="gcc -m32"

...produces a lot of -Wformat errors that were also seeing in VFIO selftests
from the kernel test robot.

I think something like this would fix your issue Jason. I haven't tested it on
ARM yet:

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..db71aef6bfb2 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,11 @@
 ARCH ?= $(shell uname -m)

-ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
+# VFIO selftests are currently only supported on 64-bit x86 and ARM.
+ifneq (,$(filter $(ARCH),x86 x86_64 aarch64 arm64))
+SUPPORTED_ARCH := $(shell echo __LP64__ | $(CC) $(CFLAGS) -E -x c - | tail -n 1)
+endif
+
+ifneq ($(SUPPORTED_ARCH),1)
 # Do nothing on unsupported architectures
 include ../lib.mk
 else

