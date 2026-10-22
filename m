Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657899;
	b=N+UUKF9YaV9VaztdkRl72UHZvLzhadEQ+emtofQ4ZPOAjKx6/aYalh39c1HOXXDCeTTq
	 /YC+7SHNrGeuwzY49bgDNtZWxzthbp8/vqOrGkmP606Uktlgodq0nx3PTWp3Ps04TJXMD
	 k0UKCHAzbTYvEFGsdfK9ewDhZCBYols7At8+okjTR670K/p5u4eDSWdB9s49pB2PnrCf7
	 8WpnoEGRho+0VMXJEXG+XyXW/ec6X9hcJI3hhpMg5pbxbmY1gGZtu7BYd19n/KyJCxyJN
	 PpIKcYEHSyaeg3+KSscZc4yIRB4bOvH8a+0hXejQhZXSVL8S7Hm9F4DnS+pWDBfSxqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tNqEOrEbvKEdZLXsSkH26l7aedkHF5+jRM5uZ/OAFio=;
	b=PJ7kzo2F45duYMrnl9e9c4dVHox7yvQkEZE1ShMSAdq8qAN+vyVYR0SUATwXuGm3P7Tq
	 AFu85alTXePTD0fgYYHAlP/hhFMrhnQ1PcGU35qF8P41KMDHSwSLZKUOl/5OK5x4sArDu
	 7ha3/3XtZZ1zLpg/JNc7hv06xiv9LivplsZ0nqHPYFL16SPuQQL4CMP1IzyCUBwlCZ1w2
	 zwU57cRlDmm4uaiwLK3Bp9cPARPLtPgaG6UACtzCll9TbbYmKUOn96o5SLtFOAjQrGxIG
	 bOElCdPd5ztgSx26y7o+F4u7pstBpmzAzv7cI0YYxpIosIhxEv/77zlPhLQKJS6vOvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mg4u7ir0;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDC606A325
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 08:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CDC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mg4u7ir0
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1df146015so12162665e9.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792657898; x=1793262698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tNqEOrEbvKEdZLXsSkH26l7aedkHF5+jRM5uZ/OAFio=;
        b=mg4u7ir0LmPMRyfnxCjmVgra/VWVy0WRW3cdOvZZ/bn9RG0kGrlzNL8+rmud9EbIBE
         cRvPPnZanb9apo99irs69Jqmfe/e2hOoQNPxjJfL0469kCLq9yfiJ5UnVQtdEV6eqo0M
         pIM7eK5OtNCdzdjBmpzB1IBSZmuksSuxXQG2+rQcVZzDQJfQCgXjLflT1bSGIiwmiUHX
         OQm44H/VxqSBi/k0X57a7IEVuiekyKSlSh47QmlbxnpFhTYeul6Amm+jqQl9mT9UGd28
         iOLUUWBxhKZBHK3cqfzw33eyfCmQqog/gtqdTSh3lDkV04QIMYIdzvODgxRVh1WACSDZ
         yPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657898; x=1793262698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNqEOrEbvKEdZLXsSkH26l7aedkHF5+jRM5uZ/OAFio=;
        b=LuEKGQ+tK9OhSdmZr+qSznrBowxCIUeLJIOy03Fiwmdw/HVPrULDLkwgpaxTGQSU2H
         o3fabI3QhBs9rSVcnWy4R2tq4SC7nd5D+GvIskvAccfXY/EebCZGYiPOLUcO0DqAo9JY
         i4RTS7HIKozpDbiQtTdMyw8gwEprSoZFv6EK0FxDcltIyvpGQiJJXcgVVY7eh+3Aeg2x
         A5r0DgGZ9CRVATeXwyA1WfVXrw+rgi0AbyiDb5s+ibdytl/IzoyxolWKyuGJfXtHomH/
         11E0vIB9+vT+jPQfY7z5R9OSlz82efiRz6msyrwhqOLePqqrJWhPY2qbfXL4GEkKsWiQ
         iJRQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0Szn9joiz3b4L/AQUyxsKs0DRn5HYKV8+M7+hbrcCV/mf5oo2qd61HizZiPV1bVnY0Uo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjls3xB6A147JbYhKOyw+sjF5rn/HK3DLMGgwyZJN4Jxjc+dvE
	pzR3znBvVX/JanlPw06gp48IJGEMpwsmetW8ixZZZ72ehRbVYqZ2Rc6+CBCBxvTmjg==
X-Gm-Gg: AYBFou3fp8LKIkVZv3bQr+eWgcpm21PgjG+4fxWR5URykrtzzGF7mO3n49vi/EtGjhr
	ehtRxgJ+3GYPIjbh8NBMwe8TSbcRDlstdJWkACTI2zcwyg3SQeYKXnBSIlXkMxjgnNvPRf7nMOX
	PyELtoDizIn4Myen7gm/DmPjwkzJ9iIgqouzhQQ16VOie/yEfN5EwiIFgNq8hxOK6s0dX6CHFxN
	L3hBQxWERRqEBcff5NON+ZdrJBW2j7YAAOHMJul/0FQp+iiL/c5Jf93+fHYiHlv01LWs3v9cdeu
	Jz1SZyI4ZMaq+K52ltokEu+m6XSrCmFwoyyyvNBT4k4dsxIaaswZkEejUhMalC/E8VZJDaNbF0p
	0/lKOf7PxXTkZc1cHVHKTL70KdS/NdZcJHio3PJ9yPZGQw9OKu0Lu/BeX/qSwmM/KdAQm3EUMCc
	STXw62r+ImFBAWlnErkKQkVUbeZCH4WGY1DNUpln92f3vuFnMSnK4qBW989bBjzIY2Z1r6uuaUl
	7GyzV/W/73k+EtVNbWway/j6N3f3AewEqkvNxF3HfroKmbx2q1rSH0CFopncisYJYRSC2ZUMAa+
	iHFdOvwl2j4o5QCyoq+DVjSb
X-Received: by 2002:a05:600c:34ca:b0:4a1:d10c:7170 with SMTP id 5b1f17b1804b1-4a1fdd34028mr98581465e9.31.1792657897259;
        Thu, 22 Oct 2026 01:31:37 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a0e64esm53407775e9.3.2026.10.22.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:31:36 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:31:33 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	maz@kernel.org, oliver.upton@linux.dev, alexandru.elisei@arm.com,
	andre.przywara@arm.com
Subject: Re: [PATCH kvmtool] arm64: THPs for systems with pages bigger than 4K
Message-ID: <atnJ5RdWkGQ9QZgQ@google.com>
References: <20261019145949.1922019-1-vdonnefort@google.com>
 <16679dd3-c168-4dee-bb9d-da9b0e3416cf@arm.com>
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
In-Reply-To: <16679dd3-c168-4dee-bb9d-da9b0e3416cf@arm.com>

On Tue, Oct 20, 2026 at 03:43:08PM +0100, Suzuki K Poulose wrote:
> On 19/10/2026 15:59, Vincent Donnefort wrote:
> > The THP support imposes an alignment of the memslot userspace address to
> > the size of a THP (PMD_SIZE). To do so, kvmtool overallocates the RAM
> > size and aligns it. However it assumes PMD_SIZE is 2MiB, which is only
> > true on 4KiB page systems.
> > 
> > Use a huge-page size, based on the system page size. This value can be
> > massive for a 64KiB page system, so skip the alignment if we couldn't
> > even install one THP.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arm64/kvm.c b/arm64/kvm.c
> > index 36b3284e4a92..2c01dc32fa9a 100644
> > --- a/arm64/kvm.c
> > +++ b/arm64/kvm.c
> > @@ -18,6 +18,8 @@
> >   #include <asm/image.h>
> > +#define HUGEPAGE_SIZE (PAGE_SIZE * (PAGE_SIZE / 8UL))
> > +
> >   static struct arm64_image_header *kernel_header;
> >   struct kvm_ext kvm_req_ext[] = {
> > @@ -35,20 +37,23 @@ bool kvm__arch_cpu_supports_vm(void)
> >   void kvm__init_ram(struct kvm *kvm)
> >   {
> > -	u64 phys_start, phys_size;
> > +	u64 phys_start, phys_size, ram_alloc_align = SZ_64K;
> >   	void *host_mem;
> >   	int err;
> >   	/*
> > -	 * Allocate guest memory. We must align our buffer to 64K to
> > -	 * correlate with the maximum guest page size for virtio-mmio.
> > -	 * If using THP, then our minimal alignment becomes 2M.
> > -	 * 2M trumps 64K, so let's go with that.
> > +	 * Allocate guest memory. We must align our buffer to 64K to correlate
> > +	 * with the maximum guest page size for virtio-mmio. If using THP, then
> > +	 * our minimal alignment trumps 64K, so let's go with that.
> >   	 */
> >   	kvm->ram_size = kvm->cfg.ram_size;
> >   	kvm->arch.ram_alloc_size = kvm->ram_size;
> > -	if (!kvm->cfg.hugetlbfs_path)
> > -		kvm->arch.ram_alloc_size += SZ_2M;
> > +	if (!kvm->cfg.hugetlbfs_path) {
> > +		if (kvm->ram_size >= HUGEPAGE_SIZE)
> > +			ram_alloc_align = HUGEPAGE_SIZE;
> 
> There is logic in builtin-run.c to detect the host_ram_size(), could we
> use that instead to decide if we should apply this alignment ? Or retry
> the RAM allocation without the alignment on failure ?

As the mmap() sets MAP_NORESERVE, I believe it is only reserving address space,
I don't think a failure is expected because we increase the size of that
reservation or did I miss anything?

> 
> It doesn't look like a good idea to hard code this based just on the
> requested RAM size.

The idea is just if we know the guest doesn't have enough RAM to install at
least one THP, then there is no need over-mmap. But it isn't saving anything
really so perhaps I may as well drop it?

> 
> Cheers
> Suzuki
> 
> 

Thanks for having a look,

-- 
Vincent

> 
> > +
> > +		kvm->arch.ram_alloc_size += ram_alloc_align;
> > +	}
> >   	if (kvm->cfg.arch.guest_memfd)
> >   		kvm->arch.ram_alloc_start = mmap_guest_memfd(kvm,
> > @@ -63,7 +68,7 @@ void kvm__init_ram(struct kvm *kvm)
> >   		    kvm->arch.ram_alloc_size, errno);
> >   	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
> > -					SZ_2M);
> > +					ram_alloc_align);
> >   	if (!kvm->cfg.arch.guest_memfd) {
> >   		madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
> > 
> > base-commit: f67bc0bdae9433a9cfd05e65ea2c1bb6102566d9
> 
