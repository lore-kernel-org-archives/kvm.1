Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A738B7DC
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485342; cv=none; b=QfbtzPrs/fYDsjPC3xpd0uyb8BvZfLRe21pmqvRS+0ejwsiFkILrLm75G1sz2TSTcgG0qSSIaTC+lNetWrNHo6DOC9070mfSVddNJlskctFjYWJN17opaq+Ym63EidfQA/cTVRvOvlgnwOykec0FeO+txCj54KD3YooMksgvLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485342; c=relaxed/simple;
	bh=HIMalM3M9k909PEFiGTDFWIv584eIgyKiHAvgYYFC4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOGp+YrpJkxPwedbvTyW+07yP0QxGL+7JZtgSOyzrqNh4if8CjRUxtuN32T23IoQhRShWKwe4PM0Gy1o/5j4ETxulk5ij58zBfYdgY3+tja47hLeXRMLpWsObVgUUZjvcVatD9TQEIAcV+laUcwiTHrJsf1SsL0S0m6uNHkmFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsGCU81S; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsGCU81S"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso5463505ad.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786485340; x=1787090140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0UPXsrtsXOH6I+iVrK3H/WaCGADQHjCFmCky99010NQ=;
        b=BsGCU81S/WNW50w+y8a9mETMTttwKMv4nYwlHwt8k+8raBkYeZAWffCd8rL+hnU3Rx
         AIiYdfiVIu05ZdNQjba5s8rkXnJlVjp8j+3um3tkeuJGVwiJT3f2E6e7zYLDaALiF3V8
         qT9Gb7kRltorFkrJQKjhHUgLwxYRK/nwYDVy/TCWYggF9rAJgh6IvOMyRHm99lJEoOof
         rdYMvATGok7xaxJmffy0yQpLt3vSq4utLCp/t2QWQbqk5JyFizNeePp/0KxHQHjye+9Z
         p5VACxugaIZviL5dUQmfk7HklppdPCjJxLmB/wWuWSvjWzJiNUqlMX/ypFG4T7+Ic2ha
         Fpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485340; x=1787090140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UPXsrtsXOH6I+iVrK3H/WaCGADQHjCFmCky99010NQ=;
        b=YxO49RX79aBr86Lid7wxklY3xhSg4xlTipwtPv75V49vQvcxZz7N7QJFSv7lxSWzZb
         iPDY2rkleOl1qK+DXRzIXyx9AqXFZbgsGa7jACQ+SwYPgWgVzudSO2bIc3Ab6/X+kkf5
         rbiXNqPZxjqdRCXmHjIX+C0FfcTyl326V74mHPv21EobvW2aZOSSw9ciNn9DQ1+wWcav
         ITSUSFIjOiYQkJQOjmPGZ3Q5vtvhaVXX12x8OPs2M/P5XsmdIR/CkSnowYK69PILOlr3
         5pRI9DrOwxSfIR3XvZ1ZNlnYjOXeCNWk+cOLOEWJqIEnv10n0ftnHkexHiUVtIpK+Kxf
         ntbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYghgL+KxNBLF7w7+MFLBK3+sof08in0Hu5tbYyymg1SZsWELtAJ3T1NPOwfn14HM+UME=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnevrEAOFnlZC/BrboG0TuEMNAhR41mL/Nc/TCUKsfQ76Uk6N
	cKXtrrhmqMPJn2sbYzUCWVCCWEGI+YC7KQkEn6LTbVuNPcN0d/KnW0ndtPaBBSHLt5lgXH6qI1q
	Egh/5Yg==
X-Gm-Gg: AR+sD13WCfwJYCUrp48rFv9gsI6goPMQoPXLJiIqKlhYvIc+IsQwNMZfvYZUzFNnP0g
	yRS9ye6k8FdfCqnqxH1601g2nv3q1z4YPOJvODFDD6Y4qkDlV3mpwHOCJe3QCcnCJRj9NSCHZ14
	3kmW742dKeykCKijw6Xl+xwf1VSNnHvT6d5GaadVVCbdToh5bxzLtkLBT+HTKnMJiLOMQzmPCNq
	rJjLTPofbVTjZhmJNDWVlw3NDbqhu4H2mBVd2nvluoO8s8x4q/bbBr4JQkggSpN2BgfEClLq2Ex
	kGYRO6ZWH530p82mIVxMErOPyION17n6tHoySXz2Ncw7bjE86LbMVwqzeC2JUEf2M8x00KMBRC8
	2kJYCmeE0SAUOdUzmeLg8RNyIHSD6/esGqECB8BF8e0miQU5n04Do7pD4XhCs2FGNx8jeRz1zgq
	l8eacK/cuu5PIj/GoAhM9KtGfZoIDrwtc5oyGOWU7Xf6rg3WN2dkqga+W4JZVL7GrJoMu83CIh0
	nipDt2Kb3CHCwyYzKJ44zUhq159lQ==
X-Received: by 2002:a17:902:e809:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d34508bd87mr7701655ad.0.1786485339867;
        Tue, 11 Aug 2026 14:55:39 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d316240c28sm12669675ad.81.2026.08.11.14.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:55:39 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:55:36 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Subject: Re: [kvm-x86:selftests2] [KVM]  a262fc49e0: kselftests.kvm.make.fail
Message-ID: <anuaWC4c49JK4poE@google.com>
References: <202608071656.86e9fd06-lkp@intel.com>
 <anYlguXMOPZD-cfj@google.com>
 <anZag-tsavs8YNUl@google.com>
 <anuXCiFnJEugZb0m@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anuXCiFnJEugZb0m@google.com>

On 2026-08-11 09:41 PM, David Matlack wrote:
> On 2026-08-07 10:21 PM, David Matlack wrote:
> > On 2026-08-07 11:35 AM, Sean Christopherson wrote:
> > > On Fri, Aug 07, 2026, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "kselftests.kvm.make.fail" on:
> > > > 
> > > > commit: a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
> > > > https://github.com/kvm-x86/linux selftests2
> > > > 
> > > > [test failed on linux-next/master 78bc8af4affb9a732504eb22eeac7d1e50883853]
> > > > 
> > > > in testcase: kselftests
> > > > version: kselftests-x86_64-848acc8ffe1b-1_20260804
> > > > with following parameters:
> > > > 
> > > > 	group: kvm
> > > > 
> > > > 
> > > > config: x86_64-rhel-9.4-kselftests
> > > > compiler: gcc-14
> > > > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> > > > 
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > 
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202608071656.86e9fd06-lkp@intel.com
> > > > 
> > > > 
> > > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c:12:10: fatal error: hw.h: No such file or directory
> > > >    12 | #include "hw.h"
> > > >       |          ^~~~~~
> > > > compilation terminated.
> > > > make[1]: *** [../vfio/lib/libvfio.mk:32:
> > > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/ioat/ioat.o]
> > > > Error 1 make[1]: *** Waiting for unfinished jobs....
> > > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10:
> > > > fatal error: registers.h: No such file or directory
> > > >    14 | #include "registers.h"
> > > >       |          ^~~~~~~~~~~~~
> > > > compilation terminated.
> > > > make[1]: *** [../vfio/lib/libvfio.mk:32:
> > > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o]
> > > > Error 1 make[1]: Leaving directory
> > > > '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm'
> > > > make: *** [Makefile:218: all] Error 2
> > > 
> > > Any chance the file is literally just not there?  Makefile.kvm's -I$(<D) expands
> > > to:
> > > 
> > >  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa
> > > 
> > > which matches the directory of the input file:
> > > 
> > >  -c/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> > > 
> > > so AFAICT the makefile is working as intended?
> > 
> > I think this is a problem in how the kernel test robot builds selftests.
> > 
> > hw.h and registers.h are symlinks to headers in the kernel source tree.
> > The selftests build works fine for me when I check out the entire kernel
> > tree at commit a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 and build the
> > KVM selftests.
> > 
> > But if I delete one of the symlink destinations, I see the same error.
> > 
> > $ ls -l tools/testing/selftests/vfio/lib/drivers/dsa/registers.h
> > [...] tools/testing/selftests/vfio/lib/drivers/dsa/registers.h -> ../../../../../../../drivers/dma/idxd/registers.h
> > 
> > $ rm drivers/dma/idxd/registers.h
> > 
> > $ make -C tools/testing/selftests/kvm -s
> > /usr/local/google/home/dmatlack/kernel/trees/kvm/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10: fatal error: registers.h: No such file or directory
> >    14 | #include "registers.h"
> >       |          ^~~~~~~~~~~~~
> > compilation terminated.
> > make: *** [../vfio/lib/libvfio.mk:32: /usr/local/google/home/dmatlack/kernel/trees/kvm/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o] Error 1
> > 
> > Maybe the kernel test robot doesn't download the entire kernel tree when
> > building selftests?
> 
> Yeah this seems to be the cause of the build failure. The lkp project
> only grabs a subset of the kernel directories when packaging up the
> kernel to build selftests, so it will not have access to the symlink
> targets used by VFIO selftests:
> 
>   https://github.com/intel/lkp-tests/blob/bbbc29c495d9617f28dbc8b799cf0dac9a1ca54e/lib/tests/pkgbuild.sh#L484
> 
> I'll get the ball rolling on fixing this in lkp.

Here's my proposed fix, in case anyone wants to follow along:

  https://github.com/intel/lkp-tests/pull/567
