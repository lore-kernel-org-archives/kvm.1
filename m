Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F712010EE
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248937; cv=none; b=b/MMtFP0pYVGiI4CKeYaLbwktjsLwxLEPol/b7Zq8hD0BKXMDmbbKA8g/R6iqAwGPVmpSacF0sSIZuAwq1HHCYC92th2sTxi2mUyQTpQLEuwCuHJDVFskci/SrU6CNbFUR4CU05pQ/Z9Y1Fh+/VTHz97Bxn+fDD5NAEf0JIzkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248937; c=relaxed/simple;
	bh=n3EU1azuIOaK4Vr2f8khEVFcyxt+8T9+xoTt4ZOzPUc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQI09COy1jkJCgspSmWciSUuLKLbuS7PnAt16JBeHNPMdPPB48nXVrEGSKZPz3FXZv2HmXY586Ku26ONPQKMZMvGdNmduBPr1AeNtqZE7C5iOeWTpjR3nquw/DhSSF7r/nwdgQ+fLIPGRnozsDDhFiNvDXH09/A+oOmZrrFPe3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=buqMDYJG; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="buqMDYJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781248929; bh=eBBQdcpwmqW7JhNyZeKOCKeL/XZl3ad5N/e3MLhuhMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=buqMDYJGEoPDFr5M7L8EDqtNkOp8rukgbB5zMRWP43IKuVkPlDSx2BUaqz2yYnjbE
	 CowY+B+SPsZ6GMbqCLC8rnnuo3NotST6GmNKcg+HTRWIgSUYg73eplRj7kFoA5PThS
	 maHf1do5mgmIOkMvjWQLJ2pHWDlcvUqV2as0xGkE=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 586994F7; Fri, 12 Jun 2026 15:22:06 +0800
X-QQ-mid: xmsmtpt1781248926t7z7h17wc
Message-ID: <tencent_2FF346E60B5BC42CCE680DF06BE113A13D05@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgzMvv90yjS4L9vF1ljMkmfkCQEZzZcI6Vetd4OZO818p22PmOho
	 IgzMcJPf2kJTEovmakMFH8byWLRPlaIl1Kk8jRt3ejbUOZH2crsCu2Aqn5F4uDUpqc/jQN7UwOPi
	 +SkFEx1UUtR/Odvu3PwtXefuYwrM7t6YrxwOZSeJUgMCFv1Fiw+lWaZwheHpa3cuv4mT4rmfdbyJ
	 U9XJ0kPXt39HIbQRX8Le1aK9RqOFJyLrpncLnke34DB/YyzF2BvFxo5GbC04uAg7zH/6XpDyZN+9
	 V3BP7wwPn5I7ekvtZhRT1d6BvadDiy2hv0MOkbX7h/TxpIkL3mIN7icJOylL9E/6/mlBYkxYZr2g
	 c6D38qcIyfIUpjodoB2Mdyd9ZQG+KIAm1zL4DwteHv2hk/l/KTDcMPPIQYMKagIhsc/Rt6ARdc7w
	 Dp/ZfG4QuYYj7aBtOjiL37gOVqmxtS7Wzlds0cfmnI6TuPsskcJQ3PND9RYxahg1LdBf5Kq86Q8G
	 5K4yCUJUpjyyI/Kk+6YClyffTtqjC0uTtgu2WnbrCgPzaQARCNpoSJjSF0o8ZMx+8hlcF56y7AEw
	 Nwvtau65FT4+ebXNQ9IspUM36pSf1MbixZ8UrXEm8IW5dtwoJIUILBr2kIvqkSY5RQP0YT8nhQnQ
	 lNveMAg8DYvTuf60pIP5+mEJiIBESs9+tjvLh6zcGv+Pe+X6xEdcoGe1neHTnReW6v5ATPNscs7Z
	 oIZ1BEiJ3kbh5SNBBCHJFynvbiRh3XyrdA3HRzEhkMoh1z4BKH44yTHtpmgOVMPXpAFUPt1GaYnX
	 2qh4EaAKwEG0hpOppWXBBf0PPinN06XYFzHBQzCANEds+IpTEyFNhn2CzqSqaHaOooI5Bk2HFhCq
	 YeIxxzFPn0uFun1xjm21EdIK0onIKLK04emd8UXLLoi5uJ3WhJFyTB3lW93Xsw6O4BYrdqffQwc/
	 +lb9ex2AEespYGY6vvNFvjpNYtVie/g5F2+X6oF3rhVw2UKhprq2MKrhXc4ihlPnx4nAt/PMjkVa
	 zWbnBZP43Gyrz5eVR+P/XzIlpVN1a3GW7i5jT93w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Date: Fri, 12 Jun 2026 15:22:06 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>,
	Lisa Wang <wyihan@google.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio
X-OQ-MSGID: <20260612072206.GA104600@zh-pc>
References: <tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com>
 <airDo5qNxn-gCsKY@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <airDo5qNxn-gCsKY@google.com>

On Thu, Jun 11, 2026, Sean Christopherson wrote:
> +Lisa, David, and Ackerley
> 
> On Thu, Jun 11, 2026, zhanghao wrote:
> > >From b164e59d4068226dfb33babe49292c7a685cacd9 Mon Sep 17 00:00:00 2001
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > Date: Thu, 11 Jun 2026 15:27:27 +0800
> > 
> > memory_failure() calls ->error_remove_folio() while holding the global
> > mf_mutex and the poisoned folio lock. guest_memfd's implementation takes
> > mapping.invalidate_lock for read before zapping KVM mappings.
> > 
> > That lock ordering can deadlock against guest_memfd punch-hole, which
> > holds mapping.invalidate_lock for write and can then wait on the same
> > folio lock in truncate_inode_pages_range().
> 
> I assume this was found by lockdep?  If so, please provide a lockdep splat so that
> it's easier to understand exactly what all is problematic.
> 
It was reported by syzkaller as a hung-task report, not as a lockdep
"possible circular locking dependency" splat.  The relevant part is:

  Soft offlining pfn 0x29435 at process virtual address 0x200000841000
  Injecting memory failure for pfn 0x678c7 at process virtual address 0x200000ffe000

  INFO: task syz.5.14516:73007 blocked for more than 122 seconds.
  task:syz.5.14516 state:D pid:73007
  Call Trace:
    folio_wait_bit_common+0x339/0x890 mm/filemap.c:1323
    __folio_lock+0x23/0x40 mm/filemap.c:1704
    folio_lock include/linux/pagemap.h:1170 [inline]
    truncate_inode_pages_range+0xae7/0xc40 mm/truncate.c:458
    kvm_gmem_punch_hole virt/kvm/guest_memfd.c:243 [inline]
    kvm_gmem_fallocate+0x4f0/0x8c0 virt/kvm/guest_memfd.c:314
    vfs_fallocate+0x4a1/0xfc0 fs/open.c:340
    madvise_remove mm/madvise.c:1044 [inline]
    madvise_vma_behavior+0x2b2b/0x2d50 mm/madvise.c:1358
    do_madvise+0x162/0x230 mm/madvise.c:2028

  INFO: task syz.5.14516:73023 blocked for more than 123 seconds.
  task:syz.5.14516 state:D pid:73023
  Call Trace:
    rwsem_down_read_slowpath+0x661/0xd30 kernel/locking/rwsem.c:1086
    down_read+0xed/0x4a0 kernel/locking/rwsem.c:1539
    filemap_invalidate_lock_shared include/linux/fs.h:1093 [inline]
    kvm_gmem_error_folio+0x93/0x530 virt/kvm/guest_memfd.c:502
    truncate_error_folio+0x80/0x130 mm/memory-failure.c:941
    me_pagecache_clean+0xf2/0x1f0 mm/memory-failure.c:1063
    me_pagecache_dirty+0x113/0x1e0 mm/memory-failure.c:1094
    identify_page_state+0x167/0x230 mm/memory-failure.c:1661
    memory_failure+0x1612/0x26e0 mm/memory-failure.c:2551
    madvise_inject_error mm/madvise.c:1487 [inline]
    madvise_do_behavior+0x4ae/0x8a0 mm/madvise.c:1925
    do_madvise+0x162/0x230 mm/madvise.c:2028

  INFO: task syz.5.14516:73023 <reader> blocked on an rw-semaphore
  likely owned by task syz.5.14516:73007 <writer>

So the observed dependency is:

  memory_failure()/kvm_gmem_error_folio()
    holds the poisoned folio lock
    waits for mapping->invalidate_lock for read

  MADV_REMOVE/kvm_gmem_punch_hole()
    holds mapping->invalidate_lock for write
    waits for the same folio lock in truncate_inode_pages_range()

> > Use a trylock in kvm_gmem_error_folio(). If mapping.invalidate_lock is
> > contended, fail recovery instead of blocking in the memory-failure path,
> > and instead of reporting MF_DELAYED without actually zapping KVM mappings.
> > 
> > Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> > Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> > ---
> >  virt/kvm/guest_memfd.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 69c9d6d546b2..9417be3049cf 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -499,7 +499,16 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
> >  {
> >  	pgoff_t start, end;
> >  
> > -	filemap_invalidate_lock_shared(mapping);
> > +	/*
> > +	 * memory_failure() holds mf_mutex globally.  
> 
> Why does mf_mutex matter? 
>
It doesn't matter for the actual deadlock.  The relevant dependency is between
the poisoned folio lock and mapping->invalidate_lock.  I mentioned mf_mutex only
because memory_failure() serializes recovery globally, but it is not needed to
explain the ABBA deadlock.

> > We must not block
> > +	 * on filemap_invalidate_lock here, as it can be held exclusive
> > +	 * by kvm_gmem_fallocate() (MADV_REMOVE/FALLOC_FL_PUNCH_HOLE
> > +	 * path), creating an ABBA deadlock with the poisoned folio lock.
> 
> It's not just kvm_gmem_fallocate() that's problematic.  Due to the fairness of
> r/w semaphores, waiting writers block future readers, and so any path that takes
> a folio lock inside of mapping->invalidate_lock will effectively create the same
> scenario.
>
Agreed.  The issue is not specific to kvm_gmem_fallocate(), it is any path that
holds mapping->invalidate_lock for write and then waits on the poisoned folio
lock.

> I really don't like doing a trylock here, it feels like we're hacking around a
> poor locking scheme in guest_memfd.  Can't we also fix this by using a dedicated
> lock for bindings (and for link_at() in the future)?
>
Yes, that looks better.  ->error_remove_folio() doesn't need to synchronize
against page-cache invalidation itself, it only needs stable guest_memfd
bindings while walking them to zap KVM mappings.

I will send a v2 that adds a guest_memfd-private rwsem to protect the
gmem_file_list and each gmem_file's bindings, and switches
kvm_gmem_error_folio() to take that lock instead of mapping->invalidate_lock.

For paths that need both locks, I plan to keep the order as:

  mapping->invalidate_lock
  bindings_lock

so that a writer on the bindings lock cannot queue ahead of
kvm_gmem_error_folio() while a punch-hole/truncate path is blocked on the
poisoned folio lock.

> E.g. untested, but something like this?
> 
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index 86690683b2fe..6ff005978ae1 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -32,6 +32,8 @@ struct gmem_inode {
>         struct inode vfs_inode;
>         struct list_head gmem_file_list;
>  
> +       struct rw_semaphore bindings_lock;
> +
>         u64 flags;
>  };
>  
> @@ -500,7 +502,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  {
>         pgoff_t start, end;
>  
> -       filemap_invalidate_lock_shared(mapping);
> +       down_read(&GMEM_I(mapping->host)->bindings_lock);
>  
>         start = folio->index;
>         end = start + folio_nr_pages(folio);
> @@ -518,7 +520,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  
>         kvm_gmem_invalidate_end(mapping->host, start, end);
>  
> -       filemap_invalidate_unlock_shared(mapping);
> +       up_read(&GMEM_I(mapping->host)->bindings_lock);
>  
>         return MF_DELAYED;
>  }
> @@ -597,6 +599,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>         WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>  
>         GMEM_I(inode)->flags = flags;
> +       init_rwsem(&GMEM_I(inode)->bindings_lock);
>  
>         file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>         if (IS_ERR(file)) {
> @@ -691,7 +694,10 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>         if (kvm_gmem_supports_mmap(inode))
>                 slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
>  
> +       down_write(&GMEM_I(inode)->bindings_lock);
>         xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> +       up_write(&GMEM_I(inode)->bindings_lock);
> +
>         filemap_invalidate_unlock(inode->i_mapping);
>  
>         /*
> @@ -746,7 +752,9 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>         }
>  
>         filemap_invalidate_lock(file->f_mapping);
> +       down_write(&GMEM_I(file_inode(file))->bindings_lock);
>         __kvm_gmem_unbind(slot, file->private_data);
> +       up_write(&GMEM_I(file_inode(file))->bindings_lock);
>         filemap_invalidate_unlock(file->f_mapping);
>  }

