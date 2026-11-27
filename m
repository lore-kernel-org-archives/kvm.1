Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780839;
	b=avnAZ0NkD8MpAMT72M/L/88MNjtara6tDwK8LEHFH560S8IiJ/Me1OYHaJTiRIM6eLrc
	 m1rx1+2BC+EJT9jz578sWEWFruSC7hEFv1tvUtlyr83VzXrJBytCV/RQEETEy2NJtGK3x
	 1HoA6s5gLCQ2M3OPtYoIecSiWFBIVNEe5y5WuMmnDNRheA98rNwnK5wuwjZtpr0LTgH9A
	 Y8aIWZeIbRn57EPnzWQvnyElwEQ6K10cOAehmX4H3eH3U9YxTW/oFZkT3tWjsFDFfTAgD
	 txTpfz8y4qOl7hZkniUr5LVd5GXkY/p+4gD4Niznmzy8SQy8BLWGONuLeK314KpUMqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780839;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TlhY3LWTCNeCX3vByIasNBFHpYPe8r8PcYYum4C6s54=;
	b=0gvtNiBX+tzd/88aqkp3LIkYj9qCl5B7BkfJymHi92dCHmWsNy+GfTyfYg8zJjiGlzDZ
	 WnVBh9xppIOJVSkwJoH/fcwyDeIffrCh1HUuIdl0ClYb/l/+CtZ/F6KwSZb1QSX1dnWNG
	 +8zRnbv4MRbr+AQBe6X0ReO5+wa85LAHeC5ebaXBNXmJxLjSnWj9JH3EuEjvdy+Qkg4KK
	 NilgGKMsIUQvUmP3JA/Gjc5nCGh2qgQSrnMzCbXTWVXaCSz9WGsVPOgare2y6J8RboVd5
	 3TWjLqh2T6WcoV8bqjkHR1jI4i5pNi198y6ytFuOaHTPbpRmwaAO3kh11R2p3RiVMbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WU3OQRp5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E7606A326
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B57E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WU3OQRp5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 392321756;
	Fri, 27 Nov 2026 04:00:35 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D9463F632;
	Fri, 27 Nov 2026 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795780838; bh=qWuFSR6AhqsMh0YTtk5jqyb/TZAVijdWRBW5IF4S4UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WU3OQRp5IQ4eaLX6zUe7IVUwBwXXlhR8lpA994dhLs1FpGXmkkKZUqAUKp/8vBZqj
	 FuDLpVJKPlFR6dPTN8TRc+Nd2TNnaseo37bZ0Bl6sohLfj51jTXi4HZ1VAPHXM8TxK
	 Jj1JCPQHzqNljU/A+va2irjD6wa0fMziNAYaHZXY=
Date: Fri, 27 Nov 2026 12:00:34 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Will Deacon <will@kernel.org>, kvm@vger.kernel.org,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH kvmtool] Makefile: Make the clean target independent of
 the build configuration
Message-ID: <awlw4q7gkutwSJEr@raptor>
References: <20261126195438.3313169-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126195438.3313169-1-fuad.tabba@linux.dev>

Hi Fuad,

On Thu, Nov 26, 2026 at 07:54:38PM +0000, Fuad Tabba wrote:
> 'make clean' only removes the objects and dependency files of the
> configuration it's run with ($(ARCH) and the optional libraries the
> Makefile detects), so after a cross build a plain 'make clean' doesn't
> remove the objects and dependency files specific to the target
> architecture.
> 
> Remove every object and dependency file in the directories the Makefile
> builds in, along with guest/init and guest/pre_init, which depend on
> the configuration in the same way. List the directories by name so that
> objects elsewhere in the tree, such as those of a dtc clone used for
> LIBFDT_DIR, aren't removed.

Thanks for this, make clean not cleaning all the compilation artifacts was very
annoying.

I tested this on my x86 machine:

make
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- clean
# I keep precompiled versions of libfdt in libfdt-<arch> directories
find . -type f \( -name '*\.o' -o -name '*.d' \)|grep -v 'libfdt-*'|wc -l
# Output: 0
ls -a guest
# Output: .gitignore and init.c
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
make clean
find . -type f \( -name '*\.o' -o -name '*.d' \)|grep -v 'libfdt-*'|wc -l
# Output: 0
ls -a guest
# Output: .gitignore and init.c

And again with static linking.

Same on my arm64 machine, with CROSS_COMPILE and ARCH set for x86_64.

Also checked with git status that no files tracked by git were deleted:

Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks a lot!

Alex

> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 84b8baa..6698cdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -557,12 +557,12 @@ clean:
>  	$(E) "  CLEAN"
>  	$(Q) rm -f x86/bios/*.bin
>  	$(Q) rm -f x86/bios/*.elf
> -	$(Q) rm -f x86/bios/*.o
>  	$(Q) rm -f x86/bios/bios-rom.h
>  	$(Q) rm -f tests/boot/boot_test.iso
>  	$(Q) rm -rf tests/boot/rootfs/
>  	$(Q) rm -f $(DEPS) $(STATIC_DEPS) $(OBJS) $(OTHEROBJS) $(OBJS_DYNOPT) $(STATIC_OBJS) $(PROGRAM) $(PROGRAM_ALIAS) $(PROGRAM)-static $(GUEST_INIT) $(GUEST_PRE_INIT) $(GUEST_OBJS)
> -	$(Q) rm -f guest/guest_init.c guest/guest_pre_init.c
> +	$(Q) rm -f $(foreach d,. arm64 disk guest hw mips net/uip powerpc riscv ui util vfio virtio x86 x86/bios,$(d)/*.o $(d)/.*.d)
> +	$(Q) rm -f guest/guest_init.c guest/guest_pre_init.c guest/init guest/pre_init
>  	$(Q) rm -f cscope.*
>  	$(Q) rm -f tags
>  	$(Q) rm -f TAGS
> 
> base-commit: 2f3abe56dcd2658dc6dae3eeeb4996dc4b518bcf
> -- 
> 2.47.3
> 
