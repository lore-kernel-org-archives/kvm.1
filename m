Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CE277C9D
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417356; cv=none; b=UUhId9vs5gYtrTamqUEmE6N4poDxypbY309erDbzSTrGk0VJxtG55NYYO5MPm4xSvQowG4/TrtgwDdlXKRNyY3eZmMLFlDY/OP9KP1QejgMMfBTEqqOVNN8XyuMofKzvnQQGY4V5Mo7Kb0K9RWtNff9HXQPkJd6MXYleIclJGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417356; c=relaxed/simple;
	bh=1+mXgVo7dAnt/giXtEwqqUppC06EJq5mpBzjemrc370=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD/bvCoy675xN7lqKZYUgr3VYJZn9GpJDOt1UWRJZ4uisuJ0VaRmiEMT/emXPh5qSKi4raUGeSwk4xfu1waDThiPEi1EoqniIG1DAA+P1GBwUYjJNdbvt3cEP1w2d+W8tBF1thNeyxkSpbOCVxAcu+pQHjbwEl68bc5UOCVJws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MB6i6/8G; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MB6i6/8G"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fbca04006so6000946a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777417354; x=1778022154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6i0zRvpsTAv5H6O7m9/7Y3z4KnMgLavq86NudH21Hs=;
        b=MB6i6/8GLbYTZQIkKMHVmqprT5El4klyoelMuCc1kWYgvt400FA/RDsOuf8sfaTi/X
         hMakOw+avpsdr3I0T/PJhfXAvPlveWY43Xw3Xf0eIuxx1r7DYkeN6O9+NtlG4f2Qpygb
         Xcb9fMx4PJgKSo8ofz+D/vNgudhYRuhe9Ci1JiKlLBbiMj3pfqRcWRSr3tZL6Tifv+lU
         cfaf/PgbugNExhffmkyogr0sz5vM8IvjEu2dkgn4Yh8yIxszdMZps6Wqa5CN3EUIIfzE
         r36y72q0llXO9Hxm2+HIZCRm7Az3cTucOVTfj2FLOBrQ9iqwaWPtp88dySsQvrlx37Vt
         OPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777417354; x=1778022154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6i0zRvpsTAv5H6O7m9/7Y3z4KnMgLavq86NudH21Hs=;
        b=BkOYY/J0EdTSBSBpPRzZWDz01Bm/y00S3tnCyXzMwasw3RUWFGrrycn8jUT+PaTC1E
         M53eoJMaq7rZValusLst5bGoqL3y/hsNKAvLAZi6h7mf6UYZxvfHzZPgFTZBjCLB0AVk
         hVPQrovj5e+Ka6YTEkmh7yDN0FhM1vBhWPQcBl0GcVXJpbAibGskpTpn9Sj3TlxVIbMx
         Fh/8JrO4GrTUdlP6JMX5JTLaTc3G4hm4SJHpt1xajCu+x/SnFzf9Sv2vA0Ryy8ZvgZKs
         lquaPwPuHTdtIkkmDnuW2WrM78z2SmJjdSQlQqXYrG9wEHCNeT2aB+UFkyQlhvomSWCp
         wAMA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZolZrHcaDFOxZ1b0UL+3nR7x4dEamDrgseZaimPvzNLOGlXi497IDePp3RetL9iFgXmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/lCVDNUekuINyc5DjCxPJZ2O/8YBh7wrYza9n6g4kCS5NK9N
	8ryQhviF+Vxo3+7z50b5yu/H/NA0m67cjoZz1Fe69sA9QqbQqXXx7nGE6qe3UsPnig==
X-Gm-Gg: AeBDies5Zf+Tr1zGEAC12kFymHFoKZ8BxcAsvpL+DHk4+nuBmOMpxNgJ1q+KyLP5jKb
	0WReVxXHcM0zMRQDn2EohpROWG3qPknOItLMlWsTbyT/62v4V00jlfgUnWx8jHCWX2n2TJQZfRF
	1mlInpTneYPubCS2h5fjox+CphMoBjlN6IL4+tfSZUiYkLBSWcoliORfXZIxcKID1E0hDLPuO05
	/lXUV+VcEKmEiCoYtHFG7z0TwlohuXlspgVt05xSsO9jROP/Mguzt8YBG3E+DP5TQckXbxSDgsH
	vlGm8n4BIa6OdZPWOmKEZZRmAW5U+mjN5jsiu9mjidfc/tgfCrBRbJHo6rJjdBPAMlxN7RQtcZl
	k+MUGpTI7xIgicc6fyLNFviie2QL7kr51LwNcIxUzJT7akIWz3XYRyTuyoVAj5Dx+auOFrDib+m
	ts9F0FiKfNYBU0sR32BIAnUFOlYMsFo6yM4V4zfB4VHBN0E/QEIZsprXv2qGFaxZL6ttuvRruP0
	xIWOQ==
X-Received: by 2002:a17:903:4b27:b0:2b2:cf51:718a with SMTP id d9443c01a7336-2b97c404a41mr54844865ad.9.1777417354069;
        Tue, 28 Apr 2026 16:02:34 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893fbbbsm2704415ad.41.2026.04.28.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:02:33 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:02:29 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Sean Christopherson <seanjc@google.com>, Matt Evans <mattev@meta.com>,
	Ted Logan <tedlogan@fb.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
Message-ID: <afE8hX3s-O-8yROu@google.com>
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
 <20260427231217.GA1670652@nvidia.com>
 <afATrrjqt8zj2plL@google.com>
 <afEEN_4ufBcQld0q@google.com>
 <afEQDT_nv0kdlaBU@google.com>
 <CALzav=ecmNh6bE88oCHdmjSKK_Zpd96b84HbtmkaiDNRcotYfw@mail.gmail.com>
 <afEusUxXDpFtZvV0@google.com>
 <CALzav=e08+Kh60daAM=A7rAwRU-SFs8m7k2JqSb6v+=T9RZGSQ@mail.gmail.com>
 <20260428225528.GA3225388@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428225528.GA3225388@nvidia.com>

On 2026-04-28 07:55 PM, Jason Gunthorpe wrote:
> On Tue, Apr 28, 2026 at 03:53:01PM -0700, David Matlack wrote:
> > > > If it is then we don't even need the __LP64__ stuff I posted.
> > > >
> > > > But when I look at the top-level Makefile and imagine running make
> > > > without setting ARCH on the command line on a 32-bit x86 host, ARCH
> > > > will be set to SUBARCH, which will be x86.
> > >
> > > Yep.  So the big question is, why doesn't anyone complain about KVM selftests not
> > > building on 32-bit?  Because they most definitely don't build.
> > 
> > I guess no one's building on 32-bit hosts anymore? :)
> 
> Well, if that's the case and kvm is broken too, then just ignore it
> and turn on vfio for x86 like kvm does?
> 
> No sense in just fixing it for VFIO..

That's fair... So something like this?

From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Apr 2026 22:57:48 +0000
Subject: [PATCH] vfio: selftests: Allow builds when ARCH=x86

Allow builds when ARCH=x86 since the top-level Makefile can set ARCH=x86
even for 64-bit x86 builds. ARCH=x86 can also be set if the host is
32-bit x86, but based on the fact that KVM selftests allow ARCH=x86 but
also don't build for 32-bit x86, this isn't an issue in practice.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: David Matlack <dmatlack@google.com>

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..40165d087a0b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)

-ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else
/usr/local/google/home/dmatlack/kernel/trees/vfio
