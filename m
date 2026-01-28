Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053993191C9
	for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639962; cv=none; b=FvESZWAm83nMhbBVhXiqJTm19XYP/zsj9g36Kx8y0ITicdc/RcvKbEX/oD/eA29eAHdofpXjWY6HtamigfdQQoerhzRTAi9NDsQ9zHF33kio/0vOMglxYfvXLcJcnfY4luT9jHJgcHPDrCQk8IdX5qjX0MiU9d0mzJkfFBt2OLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639962; c=relaxed/simple;
	bh=/WcHDV96gAUdxWDj37CCX3xYrWRwLhOOZUN+MLIniIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VCten5jLsJs5WMVyo6ssrYSZYvz+rIbbOxF2SARN9LkGVwx5pcfg3yfBKATTnJtOQhYRdwmF6cYzFre4VE8FCSJXhpfZKngQmcGO+ZyLwyXTCAinmU4iCpOcjyAaf22RaP8d7iFajB4EXOmrM92Wn8SkD19DcLw6QxlMJcCZAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJEGgnto; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJEGgnto"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c636238ec57so186522a12.1
        for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769639960; x=1770244760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRroWslCM37n1Gz0sjshiNZoUbtsP6MdxQ52BX0rrk4=;
        b=pJEGgnto9W0Mwa7yv8S9QY1CYFA9oRBAkyVM+yiyhLTlZUf0ANRHWRBX9ZwhxktKCF
         ZiMOa5pcpaDY/tuUZyWAg/BAqpetpDs0a1p5JKJHMFbDvEf/H+9ahOVa193S9uwI5e8S
         vtGrShCO3imBHakMwZODwYtvPZE21Z+oM41E8ySHTlVMIYlKH92ui01pqmRrBNGVhxDi
         aisgnqjG11yebFqc0tzx+2OW0wkp2F9cjqezWQIZys9CYtgf64kup+QPOvL/M5PmMBUP
         3fyKB0ern4221QwX85qNU4PHCsg6d5ffxJp7aZlbZe3WadARYuk1TZew+Kdp5izdlKUi
         Cwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639960; x=1770244760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRroWslCM37n1Gz0sjshiNZoUbtsP6MdxQ52BX0rrk4=;
        b=f4+8s/xqOcipf8ZoBGLpyW+tyRd/qebD5cLP6EdLyKwMR51ewwpyTmaCNqK+x7tZR9
         2gazD4EbZ8jbIZoN//bO3Kbju3NrlbCttkmRVwSZNFH3q7Noqqo2Dzr/9OOibBK/xPT0
         PtrMJFH9MRhOFJvy2H/bglPZT5SZaVXRtwfNB2d/j3LUTAHiw7CDcj2lwMXGxTkcuXq2
         4I+BaZQC/JcSA1V81ElGqg2B0J5uVTNTRoXPPmeTFS4302vp9E/zCIN+Onq9y0sP4HAc
         XWmjktRVt3UEZzvoXkJrXnZBBxyfmyGIWO3ZOuCaJZ1GVLfH4emFEMFgBGs9whNL83GQ
         LBXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIKNiUuzDvSUga7FRxjn7oeOk9PaY8nxyV2CElmfYMl0MOEiRLX2ncGHgkObhUqfhD/l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKnymY9t6/Wo+ui6DS+hBq4Vhnms1+zHTWU96yFJ2PZ2t0AEXS
	keBmcBzjHgUOE4lkTcF5gk6hC4gnzODlyi8S/6ZLmavLQXYdG9qffVlw1QPymPvdSBpKRhJLk74
	VBn9/uA==
X-Received: from pjup23.prod.google.com ([2002:a17:90a:d317:b0:34a:b8e4:f1b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7741:b0:390:ca32:da20
 with SMTP id adf61e73a8af0-390ca32f236mr3066283637.10.1769639960313; Wed, 28
 Jan 2026 14:39:20 -0800 (PST)
Date: Wed, 28 Jan 2026 14:39:18 -0800
In-Reply-To: <20260106102250.25194-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260106101646.24809-1-yan.y.zhao@intel.com> <20260106102250.25194-1-yan.y.zhao@intel.com>
Message-ID: <aXqQFo9S-UVMYfn-@google.com>
Subject: Re: [PATCH v3 16/24] KVM: guest_memfd: Split for punch hole and
 private-to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, rick.p.edgecombe@intel.com, dave.hansen@intel.com, 
	kas@kernel.org, tabba@google.com, ackerleytng@google.com, 
	michael.roth@amd.com, david@kernel.org, vannapurve@google.com, 
	sagis@google.com, vbabka@suse.cz, thomas.lendacky@amd.com, 
	nik.borisov@suse.com, pgonda@google.com, fan.du@intel.com, jun.miao@intel.com, 
	francescolavra.fl@gmail.com, jgross@suse.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, kai.huang@intel.com, 
	binbin.wu@linux.intel.com, chao.p.peng@intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 06, 2026, Yan Zhao wrote:
>  virt/kvm/guest_memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 03613b791728..8e7fbed57a20 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -486,6 +486,55 @@ static int merge_truncate_range(struct inode *inode, pgoff_t start,
>  	return ret;
>  }
>  
> +static int __kvm_gmem_split_private(struct gmem_file *f, pgoff_t start, pgoff_t end)
> +{
> +	enum kvm_gfn_range_filter attr_filter = KVM_FILTER_PRIVATE;
> +
> +	bool locked = false;
> +	struct kvm_memory_slot *slot;
> +	struct kvm *kvm = f->kvm;
> +	unsigned long index;
> +	int ret = 0;
> +
> +	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
> +		pgoff_t pgoff = slot->gmem.pgoff;
> +		struct kvm_gfn_range gfn_range = {
> +			.start = slot->base_gfn + max(pgoff, start) - pgoff,
> +			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
> +			.slot = slot,
> +			.may_block = true,
> +			.attr_filter = attr_filter,
> +		};
> +
> +		if (!locked) {
> +			KVM_MMU_LOCK(kvm);
> +			locked = true;
> +		}
> +
> +		ret = kvm_split_cross_boundary_leafs(kvm, &gfn_range, false);

This bleeds TDX details all over guest_memfd.  Presumably SNP needs a similar
callback to update the RMP, but SNP most definitely doesn't _need_ to split
hugepages that now have mixed attributes.  In fact, SNP can probably do literally
nothing here and let kvm_gmem_zap() do the heavy lifting.

Sadly, an arch hook is "necessary", because otherwise we'll end up in dependency
hell.  E.g. I _want_ to just let the TDP MMU do the splits during kvm_gmem_zap(),
but then an -ENOMEM when splitting would result in a partial conversion if more
than one KVM instance was bound to the gmem instance (ignoring that it's actually
"fine" for the TDX case, because only one S-EPT tree can have a valid mapping).

Even if we're willing to live with that assumption baked into the TDP MMU, we'd
still need to allow kvm_gmem_zap() to fail, e.g. because -ENOMEM isn't strictly
fatal.  And I really, really don't want to set the precedence that "zap" operations
are allow to fail.

But those details absolutely do not belong in guest_memfd.c.  Provide an arch
hook to give x86 the opportunity to pre-split hugepages, but keep the details
in arch code.

static int __kvm_gmem_convert(struct gmem_file *f, pgoff_t start, pgoff_t end,
			      bool to_private)
{
	struct kvm_memory_slot *slot;
	unsigned long index;
	int r;

	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
		r = kvm_arch_gmem_convert(f->kvm,
					  kvm_gmem_get_start_gfn(slot, start),
					  kvm_gmem_get_end_gfn(slot, end),
					  to_private);
		if (r)
			return r;
	}
	return 0;
}

static int kvm_gmem_convert(struct inode *inode, pgoff_t start, pgoff_t end,
			    bool to_private)
{
	struct gmem_file *f;
	int r;

	kvm_gmem_for_each_file(f, inode->i_mapping) {
		r = __kvm_gmem_convert(f, start, end, to_private);
		if (r)
			return r;
	}
	return 0;
}

