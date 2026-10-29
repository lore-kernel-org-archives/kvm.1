Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793280354;
	b=iVemCaNc69tgaHgwj83auEMsoYdmMBEEuJiJsWH2ygl3wItqqeaPQGNraPid/bKfx+OK
	 S6zicBTp1lWlep0jQmBe4Mtk9xpn6q7g5hub7eEFmrGiX0j2GMwwwKzSdfTpWVUmrd185
	 za8BSZmG/yX+4usqj+8rt+b43imMF2TuaP4QgDIg+C3MP0Tjp4GVuiuF3tlTJy6I+ts22
	 wakTdr09kXrLGs3PrCZOoN7K9fduLNNjVIFbK/B6LVEH3rRNP8IU29+bwgUCttDXwlJIX
	 t/rbIfmJnEY3qj1atgd5RZoqxdsyMgbWjB15Zglr+2jORU8bbKg7+wGIZqZFS7z8HtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=B4Ote2oNGmkpBbwqGPlhb6Bmy2+vfC8nA+hvmMRa0W0=;
	b=xVX/nx9laX5E0D1b2Bdh4gVGgO2XOgsnYWXyFOcLGge4szRYjBUPIEqZnZhbdW83rEnv
	 uG1h+suQ92a/WTX/ME2aBMrYK39eO9Bz3LFwjvC/6pYuGDliQYsy3Fz4SUmcxV8UuYZKz
	 s+e07d1Q0Fkb0ID9KArf1lQ6+pSeuAg8x8dQGgOY5U8haxmQhHaL2E9NhlIcPL1jow1NT
	 Zit/Qivk7a/D9wdIPY3rPRPBGQOMToQGzEqTe3cuGxnkJnKuyWIgfnwA9DdhwEjcdmaxV
	 KYa+TEUZWdFvxG8EzMegZA+7c3XC/R4LV0yeMg4+sIfJvMcr/UawwbGt49DPd7RV6EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BY9RYs/r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7E606A321
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BY9RYs/r
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917aca1aee5so27103096d6.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 06:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793280352; cv=none;
        d=google.com; s=arc-20260327;
        b=jh4I1CmxV3mb2+FHpWaK6T04pVztuToZo+NU7AeB9cz+HVo+oN6uwCX5EVdlOBULnt
         DyVW7d37iRhcr4VEVTWphqy2PjwfMBSZBO1JyTIqUFQLwl0aKPvB3uGhJpqKaFQONIju
         QjpaDuGuQ816R+rRQTpkhXIcdqnszMHMjpSzDBhIISHNq8GvWnRglbfkHZd3XLZmG3Kl
         doFIOW9iXetm0GhPD+2LiBy/52TAvd2AivaoUIKGAGsZvV75vCDh3auSQLtI4ZlFFzVI
         Xf+JNv/nykU2/Xd1FC0xoB5Sq1roIwMbUzDg5/mwUhDJuggxFtwb9BBMm0LdAkPO89M/
         W//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=B4Ote2oNGmkpBbwqGPlhb6Bmy2+vfC8nA+hvmMRa0W0=;
        fh=RL3Ch5Ibp6CrM9a/tN5JtBj0/f5XpPKIyD5sPryJy9s=;
        b=O2jluNYpuHS1lDVrVOqo7hnhcvPsV9wrCUVBEGNqjSqtQiK2eCh2Jd8HNEOFOwNmsU
         e8sQP7thSjDOIW/OzUIRwC2/NF+L86m0zu4sLTnu5aznTqzLvWGruPc7TljvCC3DFIry
         Sk9yaY5/RlsWyQLwyE5Ahax/TxQwz61Q1BpLI6WGpVn9V/uwbqvMjY6ZZbE34Anve90x
         xwyJ3AgcOouR8xQBUlHQeqjOJH172E/BUEYnVJPxBdzGRTWr86JQXL0yBoVzbNDWeuYc
         W7ogi/rlNU/7bcKxbLlQwPuFfbwEMfjwZsGNmzUaLsBQ2Il8ah+pNxtt4uVFqrsbKHfn
         2XuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793280352; x=1793885152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4Ote2oNGmkpBbwqGPlhb6Bmy2+vfC8nA+hvmMRa0W0=;
        b=BY9RYs/rLg+43IGM33p2q5KU6662SoaZTCn+UQ3Y2Ab3RUtFFJcHEUHVOZNtMEhIb1
         nrRdwGOCPX+tbmZsTlYLR2cbmnA5ipDB82sEb+W299biavi+aUZrprtEu6yKN+ONc5Cj
         GbiQRMB4Hje1CNqgHpohSLOEndqm6OJrXDVzA0M6Kj6yimn4ezjybX16rrHgdKy5WPhs
         r7z2QAViePuXK6DQoAs++NnUxNTEADf9+lg5/bSRx4xBRpcMAy1RkdMs/ALiN9TUsKrv
         htT3E9V55PRY03ZBJaZOqf1psdvt3qWc5iD33XM0090V/yx+lkhs1YaMyiX7QK02i5kr
         PWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280352; x=1793885152;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4Ote2oNGmkpBbwqGPlhb6Bmy2+vfC8nA+hvmMRa0W0=;
        b=rt62BX/N5xZXs8yUg/QW1zB53ByHvPVFkOwo3gTq76hktCg40suGi7409lPAL2hnOl
         0n4/DdnAqcd9Y8J2c4vZUIw0yuMAybjoCD623CXSy1xK3kFbvCpMXUBDjVvQZkutv4JU
         qUKmDqBWXuPsnaPugiJqlSibCv8EWtQeB5Y5WGxjZSqjS4oxk5mrLvN7fX+CeBDPgUp5
         IZP6np2WktX5MbTuOTd7Po9qGrCLcgPNluBWn06O1z+yEp0q/NSJcrx574Otb4Chi8/D
         xnw8MvJGzk8csHQLZs7byTXX0t4qI6OHIOibQ6DgtBNXFvFjm1wFFCSDfTOvni4Ej5tZ
         MywA==
X-Forwarded-Encrypted: i=1; AKwUvBzQXE85OnYCJVc37OsLILmpouitdq3lpNHgPYCNyLUXx/b9XnzUqyrrlWhh+5yVYcjTYj0=@vger.kernel.org
X-Gm-Message-State: AFq9FYImWOgUuTYcP+qOU/jrXf+56DhnsZjjgTwGXJs4jGKLW7s15fTW
	rCRbRlzmT2BeVU4Q3DpkALW6QwVsxqs1MF4EH8qvfeQlJ5MvALUk1SqIyvlrslH/ZerIamZi4VH
	oxq+e5127imiLd/BKB9+YADymBKM6JVBsPFJBC4Km
X-Gm-Gg: AYBFou278NbQue5TO72bWvgow5VWJDObMJIQMdVJXU97b1KDQdkLshT/XhHt2imcUKA
	wX0MB3piH7npBLnLvZaBYok9sY2OcBAUxx7srnbt0aajJhNrPWJ5sgb6cdMEdK7Sm3V7j9qthvn
	A70RBeZl4DT4ppzjJuPBaX4zBLW8ow9qirqLWmw/QXDAYCUreBOAiyUwQKF5lY8FAoZNDMKEZiq
	nTKTwZb8jgz0ro7WNGnLKoLxYX8EU7tSPepvm7OXU7YgrD/p10IhE8eanFP4xr2TuNrzk2RrWyk
	VxKn4WF5+xL5t6sODYSgw5fmvsRvoskBI/Vw7W0cGMBaYZp2FftjXRUxUgBYYshqGBf3HZZNFzr
	uq6vQZb1gTzBDKHyhKi/H7cJjCmSDnPaVP3lj10bGLi3zEQmbczB+IarbCY3hJuNfab0J45dMTu
	Kt+Q2hm3c8hwQ=
X-Received: by 2002:a05:6214:19ee:b0:912:488d:33ac with SMTP id
 6a1803df08f44-91c7cf7470emr79151836d6.17.1793280350607; Thu, 29 Oct 2026
 06:25:50 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 06:25:49 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-2-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-2-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 06:25:49 -0700
X-Gm-Features: AclHuK-Bz4CQfeSbgKQ2yKQJOYhFvS_qYgj0QmmyZ6llJw96csH-9wohWKdAPuU
Message-ID: <CAEvNRgGvxtgT=x3sLcasLZzCrtX+qEkHjPgs2yFRY0HRJvodag@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] KVM: guest_memfd: Clamp the order of PFN mode
 blocks to what KVM can map
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> KVM maps guest memory in 4K, 2M or 1G blocks, and uses guest_memfd's
> max_order to choose. A folio of order N is physically aligned and never
> mixes shared and private pages, so the order needs no check. A PFN mode
> provider's frames need not be aligned

I'll need to think about max_order > 0 more for PFNs. I put it out of my
mind because my frame of mind is that only order-0 folios are supported
today. Perhaps with PFNs it's actually a lot easier to support order >
0.

> and the provider does not know
> which pages are private, yet kvm_gmem_get_pfn() passes its order to KVM
> unchanged. KVM can then map a block over the wrong frames, or with one
> attribute over shared and private pages.
>

Yes, makes sense that private/shared contiguity needs to be taken into
account. I didn't consider this because order-0 is always safe to
map. Thank you!

>
> [...snip...]
>
> -static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
> +static void __kvm_gmem_invalidate_start(struct inode *inode,
> +					struct gmem_file *f, pgoff_t start,
>  					pgoff_t end,
>  					enum kvm_gfn_range_filter attr_filter)
>  {
> +	const gfn_t blk = kvm_gmem_is_pfn_mode(GMEM_I(inode)) ?
> +			  1UL << PUD_ORDER : 1;
>  	bool flush = false, found_memslot = false;
>  	struct kvm_memory_slot *slot;
>  	struct kvm *kvm = f->kvm;
> @@ -355,6 +360,16 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
>
>  		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
>
> +		/*
> +		 * In PFN mode, a fault may map a block of up to PUD_ORDER
> +		 * pages, sized before this invalidation (see
> +		 * kvm_gmem_pfn_map_order()): make faults anywhere in the
> +		 * blocks around the range retry.
> +		 */
> +		kvm_mmu_invalidate_range_add(kvm,
> +					     round_down(gfn_range.start, blk),
> +					     round_up(gfn_range.end, blk));
> +

Yes, we want to make the invalidation range larger, but not the range
being zapped. We can't over-zap for CoCo VMs.

Would it be better to refactor kvm_mmu_unmap_gfn_range() instead of
doing kvm_mmu_invalidate_range_add() twice?

>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
>  #endif
> @@ -374,7 +389,7 @@ static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
>  	struct gmem_file *f;
>
>  	kvm_gmem_for_each_file(f, inode)
> -		__kvm_gmem_invalidate_start(f, start, end, filter);
> +		__kvm_gmem_invalidate_start(inode, f, start, end, filter);
>  }
>
>  static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
> @@ -670,7 +685,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 * Zap all SPTEs pointed at by this file.  Do not free the backing
>  	 * memory, as its lifetime is associated with the inode, not the file.
>  	 */
> -	__kvm_gmem_invalidate_start(f, 0, -1ul,
> +	__kvm_gmem_invalidate_start(inode, f, 0, -1ul,
>  				    kvm_gmem_get_all_gfns_filter(inode));
>  	__kvm_gmem_invalidate_end(f, 0, -1ul);
>
> @@ -1535,6 +1550,44 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  	return folio;
>  }
>
> +/*
> + * The order a PFN mode block can be mapped at: the provider's order, no
> + * larger than the alignment of @gfn and @pfn to @index allows, rounded down to
> + * a page-table size, and never over pages that are not all shared or all
> + * private, since KVM maps a block with a single attribute.  Called with the
> + * invalidate lock held; an invalidation of any page of the block makes the
> + * fault retry (see __kvm_gmem_invalidate_start()).
> + */
> +static int kvm_gmem_pfn_map_order(struct inode *inode, pgoff_t index,
> +				  gfn_t gfn, kvm_pfn_t pfn, int order)
> +{
> +	u64 misalign = (gfn ^ index) | (pfn ^ index);
> +	u64 attrs;
> +
> +	if (WARN_ON_ONCE(order < 0))
> +		return 0;
> +
> +	order = min(order, PUD_ORDER);
> +	if (misalign)
> +		order = min_t(int, order, __ffs64(misalign));
> +
> +	if (order >= PUD_ORDER)
> +		order = PUD_ORDER;
> +	else if (order >= PMD_ORDER)
> +		order = PMD_ORDER;
> +	else
> +		return 0;
> +
> +	attrs = kvm_gmem_get_attributes(inode,
> +					mtree_load(&GMEM_I(inode)->attributes, index));
> +	while (order &&
> +	       !kvm_gmem_range_has_attributes(inode,
> +					      ALIGN_DOWN(index, 1UL << order),
> +					      1UL << order, attrs))
> +		order = order == PUD_ORDER ? PMD_ORDER : 0;
> +	return order;
> +}
> +

I'll review this function more closely again. I think the mapping order
should fit into how KVM does it. After taking guest_memfd's input on
max_order, KVM then lets these parties possibly tune the max order down:

1. lpage_info contains information about highest order due to memslot
   alignment and alignment due to VM-level memory attributes
2. CoCo platform can impose a max order
3. Userspace mappings can impose a max order too.

So I think we should follow the same model:

+ The provider reports the max_order based on it's contiguity
  information, which is the actual contiguity of memory and
  read-only attributes
+ guest_memfd further reduces max_order due to shared/private contiguity
+ After handing it to KVM, KVM further reduces the max order based on
  the above.

I think mappings for all other page tables (userspace and IOMMU) should
also follow this approach.

I guess the kvm_gmem_fault_user_mapping() equivalent of this max_order
tuning is missing from this series. :) I think we should defer order > 0
to a later series though. I think read-only-ness should be part of the
first PFN mode series.

>
> [...snip...]
>
