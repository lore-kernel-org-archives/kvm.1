Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2C246782
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904281; cv=none; b=EaiTT/lAjSWWhNwnJsPLgsmyXcCS2i5sc1Xp0R6Tdz0peHp/+21LVEQEGJrDscqcmaYAhL+E8a7m//tFf67YVKD5TGQMbNczDf3ZbE6AjiSxwz+W/TinI5lMNPi9nSo3CwJfbQWCKp4J/yTE5Pu9JoIL85dZHpRCqBGLnQ8SQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904281; c=relaxed/simple;
	bh=Px0mbSVK3f84DUHRwBK4SbylpWFImo5RRjKPyLBbpwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bP7wKORLjNQXFtImzIHFF59eUbq31JNKaxu9K+GKKlD+uajb0SbqksH49agUZZfhk5XQEZ1UNElX3ie3O/qSN0iICVlBhRbnuq27jFVjxup6orhjWi3mW7d+16uuz/m/BD+KgNNb3r66JhdyNmITZbW/DrHuA7OQeonA2SEsGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K11KP101; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K11KP101"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so9185355ad.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784904279; x=1785509079; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dATu33QjRGacKv2Zn7YNnuz8c9qvutY53GJNQjK1x6E=;
        b=K11KP101dvPe6jfMMLY9K0KzBTZO/9K5WF1RcyFkwbrXj+OwhzkxOfc90TxmTHG6Ta
         PMzPumXbmXx9MBIUAaeeo2Vmcn0U3k+nXuPkm3cTZ4Cl4JcXXvYfhRYjQNN4rzMApRdT
         1dNQfJYgR6Lb0ruE5P6Tkb/qlf5rzlvEWStmWrDM9KPRBiXrMeMYN+FBe16Zyt1Y90Xl
         GRXlLco2QF+wdeW7VlLjhhZXOMgsAyT2ULMJifxf+zxaLouu7Eszx5R6EmABRYnZ1tC3
         HkcAWlwJRefH4hseBt9njOpXc0EucY50kKz21sTyhg3BJboe83yGjCpKa87UKzM091CU
         7zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904279; x=1785509079;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dATu33QjRGacKv2Zn7YNnuz8c9qvutY53GJNQjK1x6E=;
        b=GSLjS5f8N5Eysx0QP4YO+JtEg2sAxBS4NAlGDjZreQw9Ymk3cs7goGZA+c5yM6GPPM
         zHqdtBpai8BsqulnQxrTQk9gklLeWMnn/z+TKekRlriv7/lqCvSytdngRW2B+92E7AqI
         gP20wUcIJ0edLXgTui2GTR9uPsk82wR39aj08DCQSnOzjwQuXmx2gBV7wBElBqi+Z1f4
         MqhzQ8XEK57/gUiHYyfALJGSlu9j+YhoVJC8dfx3M2j1hrQA5ERKUkPllszerZB1//O3
         jvHthriTBAXqP/umuvsaEJPPP0lFSgmUTqQiAJAco2TWSkHbSiwHKftWMM7pg3YCdYx4
         BQYw==
X-Forwarded-Encrypted: i=1; AHgh+Rqjpwdaij2Hsv8OZCIbshC0o+dwby/V3nmH5NE8lfWQ2YQIhdHojQPiQg8I2rteVP93o5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67NixuMKdCttg9NtYdyxx8p+E6paY06ax7q4qeS3hpzQeJfPV
	fMMbbKcrV4xxX4JucCz4HrYF3CADpnQJb/yBDCf6RiudHHgvgwSjFH4aaVMXSIzWwKxe+NUPZEa
	ynQ1S1g==
X-Received: from plmm17.prod.google.com ([2002:a17:902:c451:b0:2ca:f412:48ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bc7:b0:2cf:4c0f:5116
 with SMTP id d9443c01a7336-2cfa6c5e50bmr91832765ad.28.1784904278789; Fri, 24
 Jul 2026 07:44:38 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:44:38 -0700
In-Reply-To: <tencent_7DA064CAC9B463EB9B651801011E2CE4230A@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_7DA064CAC9B463EB9B651801011E2CE4230A@qq.com>
Message-ID: <amN6VptoRxbZJE2y@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Lisa Wang <wyihan@google.com>, 
	David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, zhanghao wrote:
> >From e7f25639c05eac51b4ac8add3dd3e3a76f6f7340 Mon Sep 17 00:00:00 2001
> From: Hao Zhang <zhanghao1@kylinos.cn>
> Date: Thu, 11 Jun 2026 15:27:27 +0800
> 
> memory_failure() calls ->error_remove_folio() while holding the poisoned
> folio lock.  guest_memfd's implementation takes mapping.invalidate_lock for
> read before zapping KVM mappings.
> 
> That lock ordering can deadlock against paths that hold
> mapping.invalidate_lock for write and then try to lock the same folio, e.g.
> guest_memfd punch-hole via truncate_inode_pages_range().
> 
> The invalidate lock is needed for page-cache invalidation, but
> ->error_remove_folio() only needs stable guest_memfd bindings while walking
> them to zap KVM mappings.  Add a guest_memfd-private rwsem to protect
> established gmem file entries and their bindings during invalidation and
> removal, and use it in ->error_remove_folio() instead of
> mapping.invalidate_lock.  Update bind, unbind, and release paths to take
> the new lock when modifying bindings or removing a gmem file entry.
> 
> Keep taking mapping.invalidate_lock before the bindings lock in paths that
> need both locks, so writers cannot queue on the bindings lock while a
> punch-hole operation is blocked on a folio lock.
> 
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> ---
> Changes in v2:
> - add a guest_memfd-private rwsem to protect the
>   gmem_file_list and each gmem_file's bindings
> 
> Link to v1: https://lore.kernel.org/all/tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com/
> 
>  virt/kvm/guest_memfd.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)

Well shoot. I know I suggested this approach, but oof is it uglier than I was
expecting.  I forgot that it's not just the bindings that need to be protected,
the list of files also needs to be protected.

And thinking about this more, I'm not convinced a separate bindings lock is
sufficient, as a concurrent __kvm_gmem_populate() could establish mappings after
kvm_gmem_error_folio() completes, if kvm_gmem_error_folio() runs between
folio_unlock() and post_populate().

So for a stopgap, I'm leaning very strongly towards going with the trylock
approach you proposed in v1.  Longer term (or maybe even as an immediate fix?),
I think the ideal solution would be to rework truncate_error_folio() flows to
allow .error_remove_folio() hooks to unlock the folio.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b2..2ca68d09e2d3 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -6,6 +6,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
> +#include <linux/rwsem.h>
>  #include <linux/pagemap.h>
>  
>  #include "kvm_mm.h"
> @@ -32,6 +33,13 @@ struct gmem_inode {
>  	struct inode vfs_inode;
>  	struct list_head gmem_file_list;
>  
> +	/*
> +	 * Serializes established gmem_file entries and bindings with
> +	 * invalidations that don't hold mapping->invalidate_lock, e.g.
> +	 * ->error_remove_folio().
> +	 */
> +	struct rw_semaphore bindings_lock;
> +
>  	u64 flags;
>  };
>  
> @@ -344,6 +352,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> +	down_write(&GMEM_I(inode)->bindings_lock);
>  	xa_for_each(&f->bindings, index, slot)
>  		WRITE_ONCE(slot->gmem.file, NULL);
>  
> @@ -357,6 +366,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	__kvm_gmem_invalidate_end(f, 0, -1ul);
>  
>  	list_del(&f->entry);
> +	up_write(&GMEM_I(inode)->bindings_lock);
>  
>  	filemap_invalidate_unlock(inode->i_mapping);
>  
> @@ -499,11 +509,10 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  {
>  	pgoff_t start, end;
>  
> -	filemap_invalidate_lock_shared(mapping);
> -
>  	start = folio->index;
>  	end = start + folio_nr_pages(folio);
>  
> +	down_read(&GMEM_I(mapping->host)->bindings_lock);
>  	kvm_gmem_invalidate_begin(mapping->host, start, end);
>  
>  	/*
> @@ -516,8 +525,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  	 */
>  
>  	kvm_gmem_invalidate_end(mapping->host, start, end);
> -
> -	filemap_invalidate_unlock_shared(mapping);
> +	up_read(&GMEM_I(mapping->host)->bindings_lock);
>  
>  	return MF_DELAYED;
>  }
> @@ -673,10 +681,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	start = offset >> PAGE_SHIFT;
>  	end = start + slot->npages;
>  
> +	down_write(&GMEM_I(inode)->bindings_lock);
>  	if (!xa_empty(&f->bindings) &&
>  	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
> -		filemap_invalidate_unlock(inode->i_mapping);
> -		goto err;
> +		r = -EINVAL;
> +		goto err_unlock;
>  	}
>  
>  	/*
> @@ -690,6 +699,10 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
>  
>  	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> +	r = 0;
> +
> +err_unlock:
> +	up_write(&GMEM_I(inode)->bindings_lock);
>  	filemap_invalidate_unlock(inode->i_mapping);
>  
>  	/*
> @@ -697,7 +710,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	 * not the other way 'round.  Active bindings are invalidated if the
>  	 * file is closed before memslots are destroyed.
>  	 */
> -	r = 0;
>  err:
>  	fput(file);
>  	return r;
> @@ -739,12 +751,21 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>  	 * until the caller drops slots_lock.
>  	 */
>  	if (!file) {
> -		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
> +		struct file *slot_file = slot->gmem.file;
> +		struct inode *inode = file_inode(slot_file);
> +
> +		filemap_invalidate_lock(inode->i_mapping);
> +		down_write(&GMEM_I(inode)->bindings_lock);
> +		__kvm_gmem_unbind(slot, slot_file->private_data);
> +		up_write(&GMEM_I(inode)->bindings_lock);
> +		filemap_invalidate_unlock(inode->i_mapping);
>  		return;
>  	}
>  
>  	filemap_invalidate_lock(file->f_mapping);
> +	down_write(&GMEM_I(file_inode(file))->bindings_lock);
>  	__kvm_gmem_unbind(slot, file->private_data);
> +	up_write(&GMEM_I(file_inode(file))->bindings_lock);
>  	filemap_invalidate_unlock(file->f_mapping);
>  }
>  
> @@ -946,6 +967,7 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
>  
>  	gi->flags = 0;
>  	INIT_LIST_HEAD(&gi->gmem_file_list);
> +	init_rwsem(&gi->bindings_lock);
>  	return &gi->vfs_inode;
>  }
>  
> 
> base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
> -- 
> 2.15.0
> 
