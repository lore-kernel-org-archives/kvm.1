Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D818FC97
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187494; cv=none; b=Iry0qqk/9g8xCZc/AUCLn2ffn9Ypl/riUnag3ZAM+ShKZ6teXMwwy+qBUk0ySZZsnMIWW0TKzZEiQC+owmCn8kExdrS8XdW5jWrhPRVMuwg43UuqJbjCX7GZQxixqNXCM5dyzS2rB+cHeRmGN4yx17iQlFotKLR7lPP92yE4Yow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187494; c=relaxed/simple;
	bh=9h9RTli2Ir7hQxFonfhF19gqjDpSNNy3PjN+p7u/ing=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pyg5dUG2V0oLFw9StZc40mN9DOv+S7gD+0dU/wcNPVPWfs0UXUfmA0DysdKDr213YiZQKfUAVdrp0a+xVwXwVLXFXKyiRp7+CwSyl/NQPswm/03Lb8yK94fPeUWVEgtOnKlWGFHONY88PG7KY4sGTvVY6spSXXZTAppYQjPCbsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyEsvYoJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyEsvYoJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2d65d9773so13597995ad.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781187493; x=1781792293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdr9a5F2CvMrRGgMPwQG/skPoEmhA7GZ2Aa06RhCe9A=;
        b=fyEsvYoJWYXWgwWq3TgztGxAM6+4W5CgPQWCnPnlrS0rTTGK2Zauq1YapQ0Ohf1v22
         /rI1PpiDR3NgT2qU75VVPUvrnw9H4zOHesK4hUS8azH5Pnq6KjQtZgG5T2g0hBj66cGz
         Um8ieqd+9Z209/hmDSam9cmA/XQvx3UU+6gj5jQphqX1muA6cDUPc+SrIat13x8d2LvO
         FOgfm/1UC6/5yJTnZqHRsoY0j7OtxZqoPMZAlkYKRobynMfPMLtdPX5SQK7PD1pjDLy6
         fsqkZxpVke+RdVvWKxOcGxi/N3+kyPTIISyeQxhZR0d0rOfqW3OyGf6YFO/hIk6IU5gM
         5GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187493; x=1781792293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdr9a5F2CvMrRGgMPwQG/skPoEmhA7GZ2Aa06RhCe9A=;
        b=ZcRZATzsVYi+FF4q7IaNtXAUZC6PREvxjKL3j4g/VfyQ0pOgMaTEwoIQxTYA0B32S6
         BZVVqFvAta+nbEOspWsFy+bckeIiL9Wgi51IFW+aS/X20iVBI9xjKd1gIjO8RvJ2gCUg
         jSqwqN8eIubMphmYIG4nT8OjSNLLwzUBwZfNc7qR3pfCrBfB45rrnUWD59aSDu4QAIA9
         ZLoK/tZ21rpOR9dc9Dd1g010SANIR5Wo1SOc5uZk9ON2caBcW3UCALZHGOEeTbvLI0BK
         6MP7qkjhps8n9tY9Z+1Tf00X3coBmyRvgk2Iv5IILwZqVzrC2nZj64NFWaggJMPF+QbU
         mJFg==
X-Forwarded-Encrypted: i=1; AFNElJ98SmXRiSSCnMbPY19ktediNfZm6xfVh8sAsRCr5FR4gwb5VBH3+TQsMhw86qXpon8bNNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr11eiRW30HFInXZi/W4YvGSD48nJcZaVR6JMMY0gKllVxN2jN
	AKlMrVOJrO8y6g6JOSZFtx3vR/erO0RwuTtC4zxaGew/+ECYcFD16IDjcAQguHHBL5w+ngJFobv
	JFF10MQ==
X-Received: from plbkv13.prod.google.com ([2002:a17:903:28cd:b0:2b2:41fc:ea6e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4e:b0:2c1:ef9:450e
 with SMTP id d9443c01a7336-2c2f23a0372mr35427885ad.27.1781187492365; Thu, 11
 Jun 2026 07:18:12 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:18:11 -0700
In-Reply-To: <tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com>
Message-ID: <airDo5qNxn-gCsKY@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Lisa Wang <wyihan@google.com>, 
	David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="us-ascii"

+Lisa, David, and Ackerley

On Thu, Jun 11, 2026, zhanghao wrote:
> >From b164e59d4068226dfb33babe49292c7a685cacd9 Mon Sep 17 00:00:00 2001
> From: Hao Zhang <zhanghao1@kylinos.cn>
> Date: Thu, 11 Jun 2026 15:27:27 +0800
> 
> memory_failure() calls ->error_remove_folio() while holding the global
> mf_mutex and the poisoned folio lock. guest_memfd's implementation takes
> mapping.invalidate_lock for read before zapping KVM mappings.
> 
> That lock ordering can deadlock against guest_memfd punch-hole, which
> holds mapping.invalidate_lock for write and can then wait on the same
> folio lock in truncate_inode_pages_range().

I assume this was found by lockdep?  If so, please provide a lockdep splat so that
it's easier to understand exactly what all is problematic.

> Use a trylock in kvm_gmem_error_folio(). If mapping.invalidate_lock is
> contended, fail recovery instead of blocking in the memory-failure path,
> and instead of reporting MF_DELAYED without actually zapping KVM mappings.
> 
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> ---
>  virt/kvm/guest_memfd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b2..9417be3049cf 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -499,7 +499,16 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  {
>  	pgoff_t start, end;
>  
> -	filemap_invalidate_lock_shared(mapping);
> +	/*
> +	 * memory_failure() holds mf_mutex globally.  

Why does mf_mutex matter? 

> We must not block
> +	 * on filemap_invalidate_lock here, as it can be held exclusive
> +	 * by kvm_gmem_fallocate() (MADV_REMOVE/FALLOC_FL_PUNCH_HOLE
> +	 * path), creating an ABBA deadlock with the poisoned folio lock.

It's not just kvm_gmem_fallocate() that's problematic.  Due to the fairness of
r/w semaphores, waiting writers block future readers, and so any path that takes
a folio lock inside of mapping->invalidate_lock will effectively create the same
scenario.

I really don't like doing a trylock here, it feels like we're hacking around a
poor locking scheme in guest_memfd.  Can't we also fix this by using a dedicated
lock for bindings (and for link_at() in the future)?

E.g. untested, but something like this?

diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index 86690683b2fe..6ff005978ae1 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -32,6 +32,8 @@ struct gmem_inode {
        struct inode vfs_inode;
        struct list_head gmem_file_list;
 
+       struct rw_semaphore bindings_lock;
+
        u64 flags;
 };
 
@@ -500,7 +502,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 {
        pgoff_t start, end;
 
-       filemap_invalidate_lock_shared(mapping);
+       down_read(&GMEM_I(mapping->host)->bindings_lock);
 
        start = folio->index;
        end = start + folio_nr_pages(folio);
@@ -518,7 +520,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 
        kvm_gmem_invalidate_end(mapping->host, start, end);
 
-       filemap_invalidate_unlock_shared(mapping);
+       up_read(&GMEM_I(mapping->host)->bindings_lock);
 
        return MF_DELAYED;
 }
@@ -597,6 +599,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
        WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
 
        GMEM_I(inode)->flags = flags;
+       init_rwsem(&GMEM_I(inode)->bindings_lock);
 
        file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
        if (IS_ERR(file)) {
@@ -691,7 +694,10 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
        if (kvm_gmem_supports_mmap(inode))
                slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
+       down_write(&GMEM_I(inode)->bindings_lock);
        xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+       up_write(&GMEM_I(inode)->bindings_lock);
+
        filemap_invalidate_unlock(inode->i_mapping);
 
        /*
@@ -746,7 +752,9 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
        }
 
        filemap_invalidate_lock(file->f_mapping);
+       down_write(&GMEM_I(file_inode(file))->bindings_lock);
        __kvm_gmem_unbind(slot, file->private_data);
+       up_write(&GMEM_I(file_inode(file))->bindings_lock);
        filemap_invalidate_unlock(file->f_mapping);
 }
