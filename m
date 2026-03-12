Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BB3D6690
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335285; cv=none; b=fPNf/zfk7Vr3VTm7pZo7D2lZqlRedQj32QhEnEw4U6xKQGP+efsl2hkjZ512f0XelNZVqkMr1zDiJ1JcIkZpJ5NvEQ55P0sHRtpyVl95xRB5/CDxDAYmqKE//WYA69GGjM3nR7WzRrp/Y6gHLEYabDoZ0l4ghcFsrJy+UsN4PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335285; c=relaxed/simple;
	bh=dCihQyjycB7Usr+YxgYmF5WoXPjFADav9IhHXH7cJkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihOzEnIccb+I1dzfRhG8tMhmgH4IiZYQRSvVh+0klZKfaCIVaazBdCgsUzlSR0+ghmPjC8td+riF3V4DTBdYSVoJ/7xd68qbXVvNGbkb5lyXvduERtEBRrScv8l4PuCHSv5b3fZpJOLiKjH0rI2KbJFWlZSz1t4wMMD2jI8pJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xviDv1co; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xviDv1co"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1032515a12.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773335279; x=1773940079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omOiJb4Hh8QtKDy8lo7hxG0GaV4FGO8rNZrLZ4efW5w=;
        b=xviDv1coGUgAKj+gQKnnyHrQW0FpiXzqhoNSS8wneP/IKgdEKPLqTb17g1AIsFLUVT
         +nRdMULRU1dHPmwBHgC9VEjFuLReRSxm51WhKlBxAXjvRHDzZFN5fSh1FWpj5DpeJIkX
         m5+yu9nn0BMgkWBDAvRRQJZkGtXpfVAICuXpOQ8fAXwoOULgWtPMXApKf69BraQEzstd
         UCjgiWeRUTStTC8qyZlt0jsLbZVA4l8yRfxc0hjNL7ZrcF57WniLnJO4uE5Nms0XxiNA
         X+QeNU+uW+0VnGlL/wqdmsPMUi3TZJNgbU9AsBD+M7MPhOvClMvXNKiWdrHHnJ7jFfDN
         9xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335279; x=1773940079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omOiJb4Hh8QtKDy8lo7hxG0GaV4FGO8rNZrLZ4efW5w=;
        b=aa2nnSHw8Q+Rq+Y3eAgS7cxqjeBpC4W7VDu5c+BwSgHVe/dnif9MDEMPx3uaqOrTc2
         RCv19jfadGRlQovjPzPNggCp8c/nvqXCK4EU4Af29sVI80XaSxsja3XxM3oDeRs9gp2w
         m9/SQs2LxQHKCED9ghSg8W6g9Mk0mRU8UawJEBfvhzp5QqXZP3DadnfIYGOOUYG8mqg5
         m2j04mD9o7JQwshdIai1aLBPjrlqa0iCzswYjkRU6W3Vlg85PToEBCfmGZndHSdXH5mT
         FZMwR8ekgXOgGkdbYbIiLzwtpbPfP9oZc7O2vatf1/Tag81t544Kr7vVMmr8r8iy8pVq
         bDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7mzSWq6yLA2zLN0jo88q1++avCpWUnUZgtH265phAEZ6l/EuwgjHoK+OFtfuEpcYCXbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywho9FVBEabmSfDfYfbaIvUyFi2y43ckfBTwLWRiEzAUEajVk9l
	HyRKwWnrpyLdbg86sirkp0or0nvzmPJHtprbt46KTS4dfG8TQJiojtaMevbQh1/20xaTa0+DfsK
	3WIHljw==
X-Received: from pghd18.prod.google.com ([2002:a63:fd12:0:b0:c73:8dcd:3d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:497:b0:398:7769:f869
 with SMTP id adf61e73a8af0-398ecab0dc1mr53818637.20.1773335278518; Thu, 12
 Mar 2026 10:07:58 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:07:57 -0700
In-Reply-To: <20260123090304.32286-2-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123090304.32286-1-jiangshanlai@gmail.com> <20260123090304.32286-2-jiangshanlai@gmail.com>
Message-ID: <abLy7cEDz7VlWtWS@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large
 pages are allowed
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 23, 2026, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Use the large-page metadata to avoid pointless attempts to search SP.
> 
> If the target GFN falls within a range where a large page is allowed,
> then there cannot be a shadow page for that GFN; a shadow page in the
> range would itself disallow using a large page. In that case, there
> is nothing to unsync and mmu_try_to_unsync_pages() can return
> immediately.
> 
> This is always true for TDP MMU without nested TDP,

I wouldn't expect this to be a much of a performance optimization for this case
though, as kvm_get_mmu_page_hash() will return an empty list, i.e.
for_each_gfn_valid_sp_with_gptes() won't do meaningful work anyways.

> and holds for a significant fraction of cases with shadow paging even all SPs
> are 4K.
> 
> For shadow paging, this optimization theoretically avoids work for about
> 1/e ~= 37% of GFNs, assuming one guest page table per 2M of memory and
> that each GPT falls randomly into the 2M memory buckets. In a simple
> test setup, it skipped unsync in a much higher percentage of cases,
> mainly because the guest buddy allocator clusters GPTs into fewer
> buckets.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4535d2836004..555075fb63d9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2932,6 +2932,14 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
>  	struct kvm_mmu_page *sp;
>  	bool locked = false;
>  
> +	/*
> +	 * If large page is allowed, there is no shadow page in the GFN range,
> +	 * because the presence of a shadow page in that range would prevent
> +	 * using a large page.
> +	 */
> +	if (!lpage_info_slot(gfn, slot, PG_LEVEL_2M)->disallow_lpage)
> +		return 0;

Hmm, I'd like to move this to after the write-tracking check, even though as
implemented in code today, the two are mutually exclusive.  Specifically, I don't
want to rely on KVM not supporting write-tracking at 2MiB granularity, and also
to avoid confusing readers.  E.g. a shallow read of account_shadowed() would lead
people to believe this code is wrong:

	/* the non-leaf shadow pages are keeping readonly. */
	if (sp->role.level > PG_LEVEL_4K)
		return __kvm_write_track_add_gfn(kvm, slot, gfn);

	kvm_mmu_gfn_disallow_lpage(slot, gfn);

if they didn't follow __kvm_write_track_add_gfn() to see:

	/*
	 * new track stops large page mapping for the
	 * tracked page.
	 */
	kvm_mmu_gfn_disallow_lpage(slot, gfn);

From a performance perspective, kvm_gfn_is_write_tracked() is O(1) time, and
should be very fast for the "pure" TDP MMU case, so I don't think that's a
concern.

This is what I have locally, please holler if you object to landing the code
after the write-tracked check.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 363967a17069..3d0e0c1b5332 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2940,6 +2940,15 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
        if (kvm_gfn_is_write_tracked(kvm, slot, gfn))
                return -EPERM;
 
+       /*
+        * Only 4KiB mappings can become unsync, and KVM disallows hugepages
+        * for unsync gfns.  Upper-level gPTEs (leaf or non-leaf) are always
+        * write-protected (see above), thus if the gfn can be mapped with a
+        * hugepage and isn't write-tracked, it can't be unsync.
+        */
+       if (!lpage_info_slot(gfn, slot, PG_LEVEL_2M)->disallow_lpage)
+               return 0;
+
        /*
         * The page is not write-tracked, mark existing shadow pages unsync
         * unless KVM is synchronizing an unsync SP.  In that case, KVM must


>  	/*
>  	 * Force write-protection if the page is being tracked.  Note, the page
>  	 * track machinery is used to write-protect upper-level shadow pages,
> -- 
> 2.19.1.6.gb485710b
> 
