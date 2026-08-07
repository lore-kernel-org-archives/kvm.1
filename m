Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA89376A1B
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141322; cv=none; b=YxD8+8HPwuZTO2BXRkwPlRAp3i6B5zW7JDIew0vJM0+Lr3SQzjEMMFsgMTS/EglM9ctX73oKkLQHOLVYaESovqyPW/88iitPJ/TctLwsYcz7fqB7LbxscqQ4xXP9tQbQZlJrXMzqzrRh49rhuUild3BEXKf856MZJZZi0WOmHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141322; c=relaxed/simple;
	bh=FmcbweRd3d0dbaBtQcc0mHC7+KptZ6b26xjaw4CUekA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+eqaiuDmi1fvaMP+cIqoMtW5cgBFl1NY+KRiDSY2JMkXvNrYfpICRv2xVfKHmUBnw1fmYYvJiiO2GFP6x+QKO1c+SD3IfRk+BDs8tWeoxEAotlBi1PZU1I/RdUalb6Dfccv7Ae+oi0KAcahmP9FHxar4VSN5MacXxtCYfuBjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcVXruQu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcVXruQu"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2dcede83so19537b3a.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786141320; x=1786746120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LTyGEYgHivZOYUApgJpxjFo9wykmbOGyjWLFFgCWLkI=;
        b=ZcVXruQu2YYt4EttX5HzJ+aUNZeSmKRm7lPjTfdcTns+WQsoqj/qJVEJnhNFiI1I7/
         GR6FR8oRihGEqYXQ/MMZkB9J+X4Y+3DIiCP/7BIrO3YwL5XlfK7yCn0deLdPA360xVCi
         str3BZDfvp0GrSci36p3cuAQEGORiBx+M+1ipom31cV5JmyAz4KNgb94qdmz0uIO3gbv
         ulu50mqUP7grka+YGRsh63NNnuTfdy1kQkhEpNX87cntsHYgUoYVp+eFl6eutTVc/R+8
         sGNRA4oCdcmhjP/DHYVkCvivCFFVOiL/Wt2kIjwYN60HuuxBs/34nPCb6wLCCnVy03L1
         UNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141320; x=1786746120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTyGEYgHivZOYUApgJpxjFo9wykmbOGyjWLFFgCWLkI=;
        b=SFNO5Pn90ThL5QIKLnlddU1RoLd+L0OIZeAstTqdzK5z0JbaTMau4rp/ekNNO77n5E
         XDPYkUiyFodSbgYJUoey4/6b7ay2EQucMbUULP+zlJt/aVA0q+iaGQxguNkKAVEwe09p
         7n7tOZVUOj33B86a4Z3tNsWtKVuRUJ9wcW9QzCFkjFn5YkEZOo2/g1jCF3AmMpyoji+p
         V7X+Cs9wGg8p9ZH3nNKfrrRlvX+ImRxZWqHB/djMQUl6fFFe19LNMOaV7zOG43MYShzC
         fzrOHVWC+jA+XndMMAn9sLK+RPJE2Oo+y6l383TEWI3czZopKXxWwcMws1Fvy4AoHbzx
         936Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Pkpt/bLlSO0OhzYqqMeEWs1zBzEQJ88Y8qAqc5c1XkES2/B3Fm8Qp+ENDIIFbJxC51M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcO+lIIndCWXe8eaxruMSrfnA0i8XQwKpPNHtufX9xli9lZnWA
	Gh0oVN2SBKiCyDQGgvzl03nsxu9q689NHqXIh9xPNZihRt8zUoiudpxebzv8L58zSQ==
X-Gm-Gg: AR+sD13azaVxJ2S3V2Yue/k2vfniuErVlnc1wRUHRW5grAM1rWdFvFsjhurTCfoO2EW
	OYP6UGos2dsp0pxWZOipOK5lL/04liaZzVZLjb5VHVo3QpS+6ckDynPCLSijIcoRURVNGRCaHex
	ELaZQ2jLenVPABUBp9yiPvJ2SK86v49crKebRG689DxbMSFOkuDkFgq9viAAMiwo7VJkNy2hwFJ
	uWs4Gmw/qbGEf1eXJEskImpcRlQEeiWipMbGj0Am6wqX5v57S3BSIAceOm0FpVkfY3d2/rDf8OM
	DMJVuE0WvQshva8y62X3rgVsjrCyut3uEKSH7h8h3O3VNTC2pTHyJzBnjzpmTTfXBO3Rw7aiWBW
	gXHvt0L+1g+VhcWYXtgF+cAmIKBTIaARbIaZnDJgvgDu2fc9F+e6ouzZ2jkXs4K3U7sm6m+JY/V
	ITgA13XqQDtJSGtDSOWx792JM9B9Zbd5WpSW9shfA3flWjnIfhS/+USeEi8KWUS9m8OufrJvitI
	YDU+Ed08pknOjBivHfxHCMC4Nc3Zw==
X-Received: by 2002:a05:6a00:4b56:b0:847:8650:69cd with SMTP id d2e1a72fcca58-84f5e0d2cbdmr7741131b3a.33.1786141319766;
        Fri, 07 Aug 2026 15:21:59 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a0f8dsm1617296b3a.12.2026.08.07.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:21:58 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:21:55 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Subject: Re: [kvm-x86:selftests2] [KVM]  a262fc49e0: kselftests.kvm.make.fail
Message-ID: <anZag-tsavs8YNUl@google.com>
References: <202608071656.86e9fd06-lkp@intel.com>
 <anYlguXMOPZD-cfj@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anYlguXMOPZD-cfj@google.com>

On 2026-08-07 11:35 AM, Sean Christopherson wrote:
> On Fri, Aug 07, 2026, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kselftests.kvm.make.fail" on:
> > 
> > commit: a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
> > https://github.com/kvm-x86/linux selftests2
> > 
> > [test failed on linux-next/master 78bc8af4affb9a732504eb22eeac7d1e50883853]
> > 
> > in testcase: kselftests
> > version: kselftests-x86_64-848acc8ffe1b-1_20260804
> > with following parameters:
> > 
> > 	group: kvm
> > 
> > 
> > config: x86_64-rhel-9.4-kselftests
> > compiler: gcc-14
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202608071656.86e9fd06-lkp@intel.com
> > 
> > 
> > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c:12:10: fatal error: hw.h: No such file or directory
> >    12 | #include "hw.h"
> >       |          ^~~~~~
> > compilation terminated.
> > make[1]: *** [../vfio/lib/libvfio.mk:32:
> > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/ioat/ioat.o]
> > Error 1 make[1]: *** Waiting for unfinished jobs....
> > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10:
> > fatal error: registers.h: No such file or directory
> >    14 | #include "registers.h"
> >       |          ^~~~~~~~~~~~~
> > compilation terminated.
> > make[1]: *** [../vfio/lib/libvfio.mk:32:
> > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o]
> > Error 1 make[1]: Leaving directory
> > '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm'
> > make: *** [Makefile:218: all] Error 2
> 
> Any chance the file is literally just not there?  Makefile.kvm's -I$(<D) expands
> to:
> 
>  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa
> 
> which matches the directory of the input file:
> 
>  -c/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> 
> so AFAICT the makefile is working as intended?

I think this is a problem in how the kernel test robot builds selftests.

hw.h and registers.h are symlinks to headers in the kernel source tree.
The selftests build works fine for me when I check out the entire kernel
tree at commit a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 and build the
KVM selftests.

But if I delete one of the symlink destinations, I see the same error.

$ ls -l tools/testing/selftests/vfio/lib/drivers/dsa/registers.h
[...] tools/testing/selftests/vfio/lib/drivers/dsa/registers.h -> ../../../../../../../drivers/dma/idxd/registers.h

$ rm drivers/dma/idxd/registers.h

$ make -C tools/testing/selftests/kvm -s
/usr/local/google/home/dmatlack/kernel/trees/kvm/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10: fatal error: registers.h: No such file or directory
   14 | #include "registers.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make: *** [../vfio/lib/libvfio.mk:32: /usr/local/google/home/dmatlack/kernel/trees/kvm/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o] Error 1

Maybe the kernel test robot doesn't download the entire kernel tree when
building selftests?
