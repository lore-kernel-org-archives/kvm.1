Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91EE1F3BA2
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013348; cv=none; b=O8WiXelwNIpx2bdvhLm3hyrkBMu+0FB0JfXdlWpfKXDfnFcmIkize1kT62gkPBIAwltS4kZStexHz6rZpS/SHeVCJjkGiYpI8tiqEIA3bk3vO0VNfqOabcD8+s6568CUb65pJn8+QBQ/A9vZEN9XyowAY1rGPflKi/r9O3/rOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013348; c=relaxed/simple;
	bh=PRKMKNqDiqU7XvUJ25dwB1nGSTHc3Cg1IYrrAOM9CA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUEbSQPw0dUICe0PSYPnJR4tiUk+ZXCu23o31Rp0gaAHdNOBHMtUGOCEZBzJzF8eNVbIlcdsDclnXSGEc5FTOCRPOvjI19XODCsFF29ZCG+OVwl7UheyNsu7kUctJ67rkNXMqT8QyrRp91EFvN30gp0UEZBWzgOUEV9Wyn5EHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rm/wTJC7; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rm/wTJC7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787013343; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=dRIrdJE7elS2L1KDtGdgFM5woE2e5kU/jo/OSTBtFgw=;
	b=rm/wTJC7W6N13GeXQHM4WHMs7+z4HEmrluTHoxEvZfB4vQ5NbPzz3NSM9nBNz0LgRm70Jwo3t5uoEqAbuTnT6QRVq5wwBG55DYCzTFHGSpj/7Awjfk2St+JBrrn498sFOtXHEAe/1wjfSXmopG0ZCUbnIsuJiCP2SDnDy77Y/uQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X9BJu9y_1787013342;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X9BJu9y_1787013342 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 08:35:42 +0800
Date: Tue, 18 Aug 2026 08:35:41 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: kvm@vger.kernel.org, julien.thierry.kdev@gmail.com, will@kernel.org, 
	yaoyuan0329os@gmail.com
Subject: Re: [PATCH kvmtool 0/1] Don't empty CFLAGS in Makefile for static
 building
Message-ID: <l3jrmqj2jtkgygxrxhh4jolti4pggr7wwbvmdv775ibnbv3hpz@zcvq5pkphpni>
References: <20260817084534.92780-1-yaoyuan@linux.alibaba.com>
 <aoLXycEYCnJTjQ-D@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoLXycEYCnJTjQ-D@raptor>

On Mon, Aug 17, 2026 at 10:43:37AM +0800, Alexandru Elisei wrote:
> Hi,
>
> On Mon, Aug 17, 2026 at 04:45:33PM +0800, Yao Yuan wrote:
> > Don't set the CFLAGS to empty in Makefile for passing more
> > CFLAGS options from environment variable, e.g -static for
> > native static building.
>
> I think the lkvm-static makefile target might be your friend in this case :)
>
> $ make -j$(getconf _NPROCESSORS_ONLN) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- lkvm-static
>
> (have a look at the $(PROGRAM)-static target if you want to double check that it
> fits your needs)

Hi Alex,

Thanks for such nice suggestion!

Yes, it fits my requirement and it works in native building yet.

So I think this can be dropped unless it helps in other purposes.

>
> Thanks,
> Alex
>
> >
> > One use case of static buidling is using kvmtool for
> > pre-silicon validation on emulation system, such system has
> > limited or even no IO part and run w/ small solo ramdisk as
> > linux userspace instead of full Linux distribution, and run
> > in slow speed. Thus the self-contained kvmtool static
> > building is good choice in performance and size for testing
> > on such system.
> >
> > The static building is verified on arm64 host:
> >
> > CFLAGS=-static make -j32
> > ...
> > LINK     lkvm
> > LN       vm
> >
> > $ldd ./lkvm
> >         not a dynamic executable
> >
> > The funciton is verified w/ below command, boot arm64 guest
> > to serial successfully:
> >
> > cmdline=(
> > 	ignore_loglevel
> > 	earlycon=uart8250,mmio,0x1000000,115200n8
> > 	console=uart8250,mmio,0x1000000,115200n8
> > 	nokaslr
> > 	selinux=0
> > 	audit=0
> > 	root=/dev/vda3
> > )
> >
> > ./lkvm run \
> > 	   --name test_kvmtool \
> > 	   -c 4 -m 1G \
> > 	   --nodefaults \
> > 	   --irqchip gicv3-its \
> > 	   --console serial \
> > 	   --virtio-transport pci \
> > 	   --disk /path/to/the/disk/image
> > 	   --kernel /path/to/the/arm64/boot/image
> > 	   --param "${cmdline[*]}"
> >
> >
> > Yao Yuan (1):
> >   Makefile: Don't set -CFLAGS := in Makefile
> >
> >  Makefile | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > --
> > 2.43.5
> >
