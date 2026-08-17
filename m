Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C93AAF51
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959834; cv=none; b=F7jxy/Q4Zqm6mUK5qsa08xXAaYxpoHcORfYIc0wsgs0QL7MONh3CuTHqeAocc8DHmjFrYiUQOCikDM16+hwdsF38Xk9V3izs2VPFLBGYvom0wfUCxwnWKkhZil4aqCWFYjAG7BnjeUAU6SgpwZdtFpstbIU1V2XTxYMD6XBHx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959834; c=relaxed/simple;
	bh=dMimUFpfxkyb3N6PRDGE04AOuGqpBw3tA+PRUVVmY98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuvPxwf5N2TNTmCsKVK+aWjBLj080r2/i255wuFYmIOiSxVZSUev3+FxFMI77zzeGVku4Yfbo+qjEIVtWATzHGMqhC6IRlHYUeOmHjppEzGyHj9ujyFst7RmlwuLJzLC6Ti3EVdBzmp2GxVoj/Zf2NJjvWL8tJOV8qzjxl5HMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SU7oIxrl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SU7oIxrl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4B171655;
	Mon, 17 Aug 2026 02:43:37 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02883F673;
	Mon, 17 Aug 2026 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786959821; bh=dMimUFpfxkyb3N6PRDGE04AOuGqpBw3tA+PRUVVmY98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SU7oIxrl7LzkYHtX/cphgWqIv8NGqrg3I2JHDgMJkcdBfdmkk6GdzgTV8/wX2qLAg
	 NfX3DoiRMgWXPjgWn6Lhxc4eA5bQsrtibiUK4yb4i7yTplJ5sbEElC05hCAGmot7MG
	 EfESHZTCN1Q3WeuKvnSoPaARBurQrbyuiCphhgz0=
Date: Mon, 17 Aug 2026 10:43:37 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: kvm@vger.kernel.org, julien.thierry.kdev@gmail.com, will@kernel.org,
	yaoyuan0329os@gmail.com
Subject: Re: [PATCH kvmtool 0/1] Don't empty CFLAGS in Makefile for static
 building
Message-ID: <aoLXycEYCnJTjQ-D@raptor>
References: <20260817084534.92780-1-yaoyuan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817084534.92780-1-yaoyuan@linux.alibaba.com>

Hi,

On Mon, Aug 17, 2026 at 04:45:33PM +0800, Yao Yuan wrote:
> Don't set the CFLAGS to empty in Makefile for passing more
> CFLAGS options from environment variable, e.g -static for
> native static building.

I think the lkvm-static makefile target might be your friend in this case :)

$ make -j$(getconf _NPROCESSORS_ONLN) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- lkvm-static

(have a look at the $(PROGRAM)-static target if you want to double check that it
fits your needs)

Thanks,
Alex

> 
> One use case of static buidling is using kvmtool for
> pre-silicon validation on emulation system, such system has
> limited or even no IO part and run w/ small solo ramdisk as
> linux userspace instead of full Linux distribution, and run
> in slow speed. Thus the self-contained kvmtool static
> building is good choice in performance and size for testing
> on such system.
> 
> The static building is verified on arm64 host:
> 
> CFLAGS=-static make -j32
> ...
> LINK     lkvm
> LN       vm
> 
> $ldd ./lkvm
>         not a dynamic executable
> 
> The funciton is verified w/ below command, boot arm64 guest
> to serial successfully:
> 
> cmdline=(
> 	ignore_loglevel
> 	earlycon=uart8250,mmio,0x1000000,115200n8
> 	console=uart8250,mmio,0x1000000,115200n8
> 	nokaslr
> 	selinux=0
> 	audit=0
> 	root=/dev/vda3
> )
> 
> ./lkvm run \
> 	   --name test_kvmtool \
> 	   -c 4 -m 1G \
> 	   --nodefaults \
> 	   --irqchip gicv3-its \
> 	   --console serial \
> 	   --virtio-transport pci \
> 	   --disk /path/to/the/disk/image
> 	   --kernel /path/to/the/arm64/boot/image
> 	   --param "${cmdline[*]}"
> 
> 
> Yao Yuan (1):
>   Makefile: Don't set -CFLAGS := in Makefile
> 
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> --
> 2.43.5
> 
