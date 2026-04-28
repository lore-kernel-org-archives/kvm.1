Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CB2DCC01
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341362; cv=none; b=OKdv3W2DP+T+BnWVjoJQ4+V6ePpJk+sDruhgw7CdjkbmLQN6kld3Ua0/AGL/5qI12GXfeaqDmOcmUGDoRcnM562IgNxs1hFcCAGOIvbovGy9R5vKib8RwT8Mg6migx6dzHdddkjK+k0WhSQ/xo9tHmRnAb+mo5AwfmAjTyqDs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341362; c=relaxed/simple;
	bh=anSOECpq5XPzFNzUTD7jWWaHJ2C8Nwxun2aWo/NzAFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l/Gs7ZBDMxkYZDcpXE9Brb9PrWGWXhoP62MIDCSmDrLMqy3l5AJ7e1X3LfqcQOtAO0a1uQSXBvKlu0LwP8rUyJBx4lcBrHU4PNCeiFzIZzJkncmnkMADyMA8ag2zquXl0fTxSqEYYLGuPqQ7LOgHGsPoKqG0WzkAc89qvC7qm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9K05KIk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9K05KIk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74f0e3c6so7153733b3a.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777341360; x=1777946160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sb1r1UAVTIKvqTTC9ylCprM3NS1BE0PR7/PT9svzr60=;
        b=U9K05KIk0r/OfaEk+HitlahM8f7WSUmzB1X8M/xqVN0wPhOLUftKu2BRuGr6XT57Ab
         8DCMp738VpOA0M1uxkWXPifybhpxRTx1U4q+gWb5QEAovUS0Ihb38PosFnQb756pPIST
         0p1moR+Y8+ghdQmSmgd6vUwsWlOTFflrPGM1hde+Me9mKAwou/Rjk4hUXLYkXdlYgBAy
         58oHWPknIqz1BR6Hkg7p4D7zVEwCdQ+mPKCvYeLhJ0Xt16CnX8+44hqwSdVbILgvqUAq
         uvHxbJaNRj5MH3fCH3836XWObioS2N4KD9cy7SiTEL0bN0q9m/8N17twz0bL5J4i+IG9
         8Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777341360; x=1777946160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sb1r1UAVTIKvqTTC9ylCprM3NS1BE0PR7/PT9svzr60=;
        b=fnM4G+NDys1+COmbXDHyUINd+1EjtI7dGUG0LXDC+g8yr+PVEg9KVbF2SpZBkXgMXo
         +zKtYNfA6RH2mEnNz4XzxZjCcT1juDvcDw716fN5pHeMRs7/nQPGsnDv0fw063d8H3CO
         4UDAcdBgXloW1GhsU0aTXr6YQaaL6HLoKS9z0iL5rZAm4U4vfk3OI4VwuDXOcKt8P1z6
         AiBekQJjFeQG2JkunXhA8kRB2Dj6uYbSuE3jxh7Yce2n8/aCEnfLj8f2VwDxvNuOUp7T
         s8QlIsHHTDJOcBr057FP+K1scBwlBbVYMnpEtz1J8IIuTh39zpFcxpYQsdIc5lFDpZri
         +XNg==
X-Forwarded-Encrypted: i=1; AFNElJ+WirHlqd9cXCmZvYzkR60HD7/MzH3KfoukQphpbcNJcfWbfnRO/O2y7TzK4/bPOzhmJzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKLxkoZ76y92ifXBIr1BCVMc8SWjPt7Rs3uJXBqKIu/ZruW58
	yedk65KQH3CUu7MfgwUqUR5GmA25Zy3ZgEAmjYJ02k41uBewDJEDRtHV6nUiAwayoeINgKY4tWV
	dFPKSdA==
X-Received: from pfbhg24.prod.google.com ([2002:a05:6a00:8618:b0:82f:b53f:40d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:807:b0:82d:24f:2516
 with SMTP id d2e1a72fcca58-834ddb0bb43mr1053701b3a.11.1777341360270; Mon, 27
 Apr 2026 18:56:00 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:55:58 -0700
In-Reply-To: <20260427231217.GA1670652@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com> <20260427231217.GA1670652@nvidia.com>
Message-ID: <afATrrjqt8zj2plL@google.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matt Evans <mattev@meta.com>, Ted Logan <tedlogan@fb.com>, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 27, 2026, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2026 at 01:55:17PM +0000, Matt Evans wrote:
> > Hi Ted,
> > 
> > On 03/02/2026 01:23, Ted Logan wrote:
> > > Only build vfio self-tests on arm64 and x86_64; these are the only
> > > architectures where the vfio self-tests are run. Addresses compiler
> > > warnings for format and conversions on i386.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202601211830.aBEjmEFD-lkp@intel.com/
> > > Signed-off-by: Ted Logan <tedlogan@fb.com>
> > > ---
> > > Do not build vfio self-tests for 32-bit architectures, where they're
> > > untested and unmaintained. Only build these tests for arm64 and x86_64,
> > > where they're regularly tested.
> > > 
> > > Compiler warning fixed by patch:
> > > 
> > >    In file included from tools/testing/selftests/vfio/lib/include/libvfio.h:6:
> > >    tools/testing/selftests/vfio/lib/include/libvfio/iommu.h:49:2: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
> > >       49 |         VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
> > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:32:37: note: expanded from macro 'VFIO_ASSERT_EQ'
> > >       32 | #define VFIO_ASSERT_EQ(_a, _b, ...) VFIO_ASSERT_OP(_a, _b, ==, ##__VA_ARGS__)
> > >          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    tools/testing/selftests/vfio/lib/include/libvfio/assert.h:27:22: note: expanded from macro 'VFIO_ASSERT_OP'
> > >       26 |         fprintf(stderr, "  Observed: %#lx %s %#lx\n",                           \
> > >          |                                              ~~~~
> > >       27 |                         (u64)__lhs, #_op, (u64)__rhs);                          \
> > >          |                                           ^~~~~~~~~~
> > > ---
> > > Changes in v2:
> > > - Add white space around arch checks
> > > - Clean up uname command
> > > - Link to v1: https://lore.kernel.org/r/20260130-vfio-selftest-only-64bit-v1-1-d89ac0944c01@fb.com
> > > ---
> > >  tools/testing/selftests/vfio/Makefile | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > > index ead27892ab65..8e90e409e91d 100644
> > > --- a/tools/testing/selftests/vfio/Makefile
> > > +++ b/tools/testing/selftests/vfio/Makefile
> > > @@ -1,3 +1,10 @@
> > > +ARCH ?= $(shell uname -m)
> > > +
> > > +ifeq (,$(filter $(ARCH),arm64 x86_64))
> > 
> > This fails to build (i.e. elides the build) on my local arm64 machine,
> > because uname -m returns 'aarch64', not 'arm64'.
> 
> I have the same issue on x86! The kernel uses x86 is the ARCH when you
> run it straight from the top level make
> 
> make[4]: Entering directory '/home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio'
> Makefile:1: "Saw ARCH=x86"
> 
> Even though this is a 64 bit build.

Heh, it's much funnier when it's happening to someone else.  :-)

KVM selftests went through these exact pains.  I'm pretty sure these are the
relevant commits (the empty targets one may or may not apply to VFIO).

9af04539d474dda4984ff4909d4568e6123c8cba KVM: selftests: Override ARCH for x86_64 instead of using ARCH_DIR
67730e6c53d70fb31618230f81c4acee9f72eaa3 KVM: selftests: Use canonical $(ARCH) paths for KVM selftests directories
43fbd8cd389faa9760c5152b1c58e893c812953b KVM: selftests: Provide empty 'all' and 'clean' targets for unsupported ARCHs
