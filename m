Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8B382286
	for <kvm@vger.kernel.org>; Sun, 19 Jul 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784455013; cv=none; b=KxDiDt62iUUG36y2YJJvBx0N9bKyM6dXmVOoBqGF6GuH3zqBWpfF9t4CjLrwJ9qg3CVc36pHI/NyVTWxyXA879q25Ye0xe8TPzw3i+5wS8Q2aHJD4zAF/hW9S3AUokocD3VgQZzqnNVKPZYTI5O8tZDFm06Rs8lsGq4vfV/AxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784455013; c=relaxed/simple;
	bh=+lutaASO8X6EVj0wDu4kybJN2pEIGDmktBVNREZlPYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHM8mmW+sRCQu7E+YQzHH9/96vlsfBOi+u2AJE84amThPEygZruxdXq0x3AzOMeWzDv6dA+Bf5h+EIJvkaHlJdUnQ8G3tJquDEMkSeVae5qMVnlbPdhyPDp1XwJezdAs+q0mIy7Ieo3zHqKfY4Na1udrrsUSNWDYW4bnXm49Ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWdLspJ0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWdLspJ0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so5513836a91.0
        for <kvm@vger.kernel.org>; Sun, 19 Jul 2026 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784455011; x=1785059811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=US5w7LHZwWkQRqRftDEFbMcTp4/h5zu5divbt3cpgbk=;
        b=dWdLspJ0n2PGSBbjA7bfETsd+4iq9lkO0ZTZLY7i9Kr5RZDGjJBhqEuub0i74qMa0F
         h/ZVBIZsNxG8kN8kV3o9WNL3FX+CW0RzS3Z8QGBMro9wPiggRX64na4IbypGvT+3hShy
         doq3XOOE7/4mxPyfJcZ0u6mdAYXQcMi+7DFFPWdmsbE076PL6NDHolXKIhL411SxH6m7
         ScUhWD0MgHVwiLtksAcMvN3tJhqFU1GqyXUD5bEKdrVAWFRIhcze6hXOaDv/FRiTPIMg
         FUf8wjs5i0bO8U4ZE+pANRbEn4ZR1aRN4w7AzyyTmB9L5hNt7vMv0BEkG1IslFqdHdOv
         CKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784455011; x=1785059811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=US5w7LHZwWkQRqRftDEFbMcTp4/h5zu5divbt3cpgbk=;
        b=Z3FbPtaB7Zrz6SGibxjYTLgzuYb8avmm3xLR4kQj5F1P0OaOC2xF2DwFS+p7w4ECcv
         Weo1LJnFzygoF4oUJS/e92ueZGRBIHYo9fzDdriweRnUcZpQp7nAHTTxqtuU6D1srqRY
         D9L1wwpgw5dBzYfFlUcuvjEbWOM/DEbSnzytqtjUSuxbrZrqJzaSF3OeWiI45SwchP9B
         dogLKAoVicPoAV5i9o/ZGvDy2zapp9q6Ng/XzfD+2SUZDtoKHuS9kyVVyq47vywnUyF9
         0feckOo0mxpdAYO5aYSalWwa/K4zmXjyR82MxC3/lrW6YGVv0Zyfkt3OYzcwoAwpY9tw
         rYxA==
X-Forwarded-Encrypted: i=1; AHgh+RpG+RDlOReL6lz2AGMU17Eo/QNCF8Pt4jHz3GjQRfucXQ3FIgcedIo50cqrRjKdKR21Z/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AWT0U4LnmIZlwTTt3Gn69v8uZIFUUBl6PWN6R3kpHkQoctlr
	BOhI+lwu3TIwEr9WgmJKvQYEx5Pas//WnofI4gT4Q0j52oPYW4kLdL6s+pLyM/Sk
X-Gm-Gg: AfdE7ckE5yfta3VSGWbo7FKulyqMuHR/J0o6Ldq9KK2T1bpQgUjuW8CjC4Ii49GRlR2
	6TzDrlK3rUM+KuZcNxPX9Mk/9Q8u+27ch8Ghrkesi+GSIhCZ2W3zVvLQ9/h6afWVrc71D7OJcP1
	TGIF9O4r49eRnimOVFLyO4J51foOri+yW4t0SXm6TLEifEWmQA0DFcefNkWIB1hJuwxU9HFhyCL
	V34zmZi8MzbIwih88bAliU2n8s6Ua/RbvuA7zvetn2Ttr0MjIBbbQ/gCWlWvhFj6jtB6vus2TxP
	y08itw5lHeVnpKwhYAAJyjj07TIoC6uZ24CxMY93fUUk4v55r9D2C4FMIZMrkiQy6L7EeWaQbUc
	5GXiUzXy8oB4eiW7kgEGvC33XkIlxjmFs5+7qETC8Gzfe+/b/DyLWxZX0yXMGpHcXRWdK+pBFc1
	G5yMQ0BwE=
X-Received: by 2002:a17:90b:58a4:b0:38e:69ae:7148 with SMTP id 98e67ed59e1d1-38e69ae720cmr2801838a91.24.1784455011332;
        Sun, 19 Jul 2026 02:56:51 -0700 (PDT)
Received: from Default ([2409:40f4:10f0:2d86:32c2:433f:5e09:aed6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm21765254c88.1.2026.07.19.02.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 02:56:50 -0700 (PDT)
From: Jeffin820 <jeffinphilip14@gmail.com>
To: seanjc@google.com
Cc: alexandru.elisei@arm.com,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	oupton@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [RFC PATCH] KVM: Ignore MMU notifiers for guest_memfd-only memslots
Date: Sun, 19 Jul 2026 15:25:54 +0530
Message-ID: <20260719095554.10767-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ajA_0TQCQLSz7qcU@google.com>
References: <ajA_0TQCQLSz7qcU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 15, 2026, Sean Christopherson wrote:
> On Mon, Jun 15, 2026, Sean Christopherson wrote:
> > On Mon, Jun 15, 2026, sashiko-bot@kernel.org wrote:
> > > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > > --- a/virt/kvm/kvm_main.c
> > > > +++ b/virt/kvm/kvm_main.c
> > > [ ... ]
> > > > @@ -592,6 +592,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
> > > >  			unsigned long hva_start, hva_end;
> > > >  
> > > >  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> > > > +
> > > > +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> > > > +				continue;
> > > > +
> > > 
> > > [Severity: Critical]
> > > Does this change inadvertently introduce a regression in the pfncache retry
> > > protocol?
> > > 
> > > Looking at the pfncache framework, it maps guest memory into kernel space and
> > > explicitly drops the page reference after mapping it:
> > > 
> > > virt/kvm/pfncache.c:hva_to_pfn_retry() {
> > >     ...
> > >     kvm_release_page_clean(page);
> > >     ...
> > > }
> > > 
> > > It appears to rely entirely on KVM's MMU notifiers (kvm->mmu_invalidate_seq)
> > > to invalidate the cache when the page is unmapped by the host.
> > > 
> > > If a VMM defines a guest_memfd-backed memslot with KVM_MEMSLOT_GMEM_ONLY
> > > but still provides a valid anonymous user mapping as its userspace_addr,
> > > could this regression lead to a use-after-free?
> > 
> > Sadly, yes.  To land this, we would need to first teach the gfn_to_pfn_cache code
> > to be able to pull directly from guest_memfd.  I forget if anyone is working on
> > that.
> 
> Actually, we just need to ensure the invalidation tracking is updated, the MMU
> itself can be left as-is.
> 
> Compile tested only, but this?
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 27498e990dff..690ab707816b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -260,6 +260,7 @@ union kvm_mmu_notifier_arg {
>  enum kvm_gfn_range_filter {
>         KVM_FILTER_SHARED               = BIT(0),
>         KVM_FILTER_PRIVATE              = BIT(1),
> +       KVM_FILTER_USERSPACE_MAPPINGS   = BIT(2),
>  };
>  
>  struct kvm_gfn_range {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e44c20c04961..84b693de7e35 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -608,7 +608,8 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>                          * HVA-based notifications aren't relevant to private
>                          * mappings as they don't have a userspace mapping.
>                          */
> -                       gfn_range.attr_filter = KVM_FILTER_SHARED;
> +                       gfn_range.attr_filter = KVM_FILTER_SHARED |
> +                                               KVM_FILTER_USERSPACE_MAPPINGS;
>  
>                         /*
>                          * {gfn(page) | page intersects with [hva_start, hva_end)} =
> @@ -715,6 +716,21 @@ void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
>  bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>         kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> +
> +       /*
> +        * When reacting to changes in userspace mappings, don't unmap memslots
> +        * that are guest_memfd-only, in which case KVM's MMU mappings are
> +        * pulled directly from guest_memfd, i.e. don't depend on the userspace
> +        * mappings.
> +        *
> +        * TODO: Skip gmem-only memslots on mmu_notifier events entirely, once
> +        * gfn_to_pfn_cache is also wired up to directly pull from guest_memfd.
> +        */
> +       if (range->attr_filter & KVM_FILTER_USERSPACE_MAPPINGS &&
> +           kvm_slot_has_gmem(range->slot) &&
> +           kvm_memslot_is_gmem_only(range->slot))
> +               return false;
> +
>         return kvm_unmap_gfn_range(kvm, range);
>  }

I tested the proposed patch against the reproducer provided by 'XIAO WU', vanilla syzbot 
reproducer and a custom-made reproducer. All reproducers were tested on unpatched kernels and 
triggered the UAF, but didn't do so on applying the patch.

Thanks,
Jeffin
