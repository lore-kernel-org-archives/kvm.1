Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826972F361F
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574058; cv=pass; b=aZ5h47zO35TPgOn3Q8baQGl9KzUmDO+mES2DHedbZ8ek56dsFUW22VGSpeaYXjScSYUYGgUTN5icVzvRwJe6l4LqxjxQvhqZGC1LQE/H5MGb6Akgp2j4eaqffyb366WfM1s4phEaEzvs7Ji/pDwIplQZcP7pCPTtdY9vrgficBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574058; c=relaxed/simple;
	bh=uM0FU2kTYfUOhIKuwEI6sXERO8cA7btOSbdxbBskCKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW6+nk9kfcWo/vb9VA/9+ondTGnX50gXM1TMNF1EkF6ibN6issMGWAt9abEVBF/cbRRcMiJ5iz/ZpuCKUnuBu2OpVhUPauAPEi1viL1d5LypOSP8xoALMy2DIKpP0mBM6PYzTnEiW4faXP/ZCyCkNSPpCCvtD1X+Qg8Vjbb833s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQ6uJ8gv; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ6uJ8gv"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso404384566b.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774574055; cv=none;
        d=google.com; s=arc-20240605;
        b=VluK12hJpw9Mt5XpOd/FvlapmN8C10+rwJwFo68BneJsHDzTdhsvUGALI8iMEdIo/8
         HARHYBCnuc11BS/4OBdTo9B30ryrgAMMLhSVGc3ZVmuYbYT4IRcNrB/FjIwojrF1wtUF
         CTAgdkL2vqDoh/V1Jm4vnXTWgnl+T5kXx5spv8o7il4FcrqPjRbk6PqomA2Duu3YM7CK
         pibXD5Tpz6ds81wc3hygjHlXE/ObitVY/p7ePjykCXL58MlaIo59mJKcCeZYi5OhRThe
         BqDlM8PAXdGRFdQDcbh058iGV7fv6wiNJTs2sRSGrH574NqTEZvYiGV6U47yOqwBBm91
         R/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HhxZX2O1RE14J5J20PYHIBXD8rpdMgbUWp57ctYeyoA=;
        fh=hNCy33MuhOJBj8tccBSnwH2uZCiXnCEQ3AZcX5zKKno=;
        b=arARGZiefJObkcbN8n9AKSeH47F34s6o4zYGnWD18jg4Y9WYiAaM/B5XdabagYRCkm
         9rHkQhlARiE9yzlO02cnmRRvN3iPs84O2FtnCK7vtPMFxy+/L+JdgD9ZRB9WDJ27s5Lw
         0C0qxGyD0HzNOhi98ryj644RCGYhlAPQel7zrvLH6JKJc0vSwhjB8btuG7CL8fLIfS+Q
         UN2Khhw22sttTz1OP1u5vIOjLXp+6QbhXj+sjxaXeaeugc18olo5BsMQ1bdRYVFF1H62
         IXmkBk65x1Ksqi+Kfz8gjsOihl2YgC0t7TZtWR659J3C2ugRQJZ8jRImw00DvFTqbzHM
         H11g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774574055; x=1775178855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhxZX2O1RE14J5J20PYHIBXD8rpdMgbUWp57ctYeyoA=;
        b=aQ6uJ8gv3z97tXusFBMzHzAI+pBB85zZmBlg+vlge9JbfBMb6Bmp5GUKGHHj7hIeRW
         Ls+uvlprVsJ7i2/3F5o8CUywEVF8fXvXWTAGpJyFGlNVQ057rBdq5PXC76kPQwBA9Hhc
         PezclSvVacmKvlZwMjpORDYQ5QVLY4y3kSDONxiGG4nakz6gEu8OgL3PMW2Rx+C0PtjD
         QNcmViPCBNpc0HXLzfcyBZ7atUjaHnhWaKJVtpAIQ33oQt7QUbWFrFhN/MJeBT48qm8f
         i+e4uehfQeiGzIaHpFs14BOT3YMI4nfCcDND2OJ7YF28wkmgv5EPPNSXb/wD32X9ulvZ
         GVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774574055; x=1775178855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HhxZX2O1RE14J5J20PYHIBXD8rpdMgbUWp57ctYeyoA=;
        b=M7fg5X5+Gonm9shXgD5zH7VUle8uwa1S0iMmqmBNZP19+c6Z0Z+WVtfHEqgmV8vtA3
         qUqUA8iS7hS9Nifc0exl2CPegw0aJ7+wqWxuWUbCYa/LNYu9nzVKznNdfnGDn/dPdg+r
         eTSeFG6uqFLLPEQkqM6B9Ob1XxhwWa3hzljT3RNWoBdoeO9mxg2FtkzmDb3lITQLHNwX
         i8lTrVcTeik2eqCn20SSD/j3THHiHNixFi3nM71JLwKviiJzIX/SNkps3ohDZqQYVwkS
         jpQP9t+BMOLtATlyCqggU0kXSuopfvzFuoDKFqSGlE0uPw1P1Fu+isLdRr7W15kFlGQ5
         pbcA==
X-Forwarded-Encrypted: i=1; AJvYcCVvuXxQrWilxhMxJaXmxV/fwqTbBSwe6OUAlmIWGIID0davPM5qzVIX3KiaOUL3T8qh8Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzJ1/7rZPTV9uWEP/UqvMdaldCygrUO1MAiLaDoqAW2vzW/4q
	vrTx7eNYy1/gGGyEqldBebzrgTdXRdui+kp2SXlfPSvDNRKmm1rNyQg1L8euhVc0ImJepbGBuMS
	WW+6gb3LBe7Wd2+DPZFkRMcxBapYF5JvSfMfIc1Wq
X-Gm-Gg: ATEYQzwLh3fjD2IhzQd+CAxiV0oSOqaZ/l62cNMVJ9aHCN8fQ08Jfu+oN1o8jMuUWnU
	IUWrAQXiqL887LuGF3ETukFSbi/rlpmFojDkWGzDlN3of8wp5kTDsoEu/M4Qn88yPKUzupJIKLW
	V7Q8jR4bgeKUmmCyBcXTNITN58eW5xjLxQTi2NNPCgQTL8z/3gPl8+HMUDEcNsRWF+tdMOJX4BR
	Gf1xIbKxLe4drxAVwQl/iC91cFWtBJOoGcalGdNMWjTRNU5FhbSr9kcAp7WUihbkYX8lmGj3m//
	8rmdhuZ1dthI7Mc/tptimL9c/OCW6uZXQKZTJ9zkCp5KFDD27iNKLLVcNE7kI8O8QjHVXdWxBCy
	K2o5j
X-Received: by 2002:a17:907:1c1e:b0:b96:f02b:3d5a with SMTP id
 a640c23a62f3a-b9b2e9b5216mr262667266b.16.1774574054212; Thu, 26 Mar 2026
 18:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-1-rppt@kernel.org> <20260306171815.3160826-11-rppt@kernel.org>
In-Reply-To: <20260306171815.3160826-11-rppt@kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Thu, 26 Mar 2026 18:13:37 -0700
X-Gm-Features: AQROBzBQyge7wu5M6M8_oSuF4nnH7MkTzeWL7KSgT2vc7Vxrdz4Z0F92-JPqKdQ
Message-ID: <CADrL8HXajnfE=WusxL=DeF7VcvrsX9z5XDC4mPt1JfMOd7J5DA@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] shmem, userfaultfd: implement shmem uffd
 operations using vm_uffd_ops
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Add filemap_add() and filemap_remove() methods to vm_uffd_ops and use
> them in __mfill_atomic_pte() to add shmem folios to page cache and
> remove them in case of error.
>
> Implement these methods in shmem along with vm_uffd_ops->alloc_folio()
> and drop shmem_mfill_atomic_pte().
>
> Since userfaultfd now does not reference any functions from shmem, drop
> include if linux/shmem_fs.h from mm/userfaultfd.c
>
> mfill_atomic_install_pte() is not used anywhere outside of
> mm/userfaultfd, make it static.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/shmem_fs.h      |  14 ----
>  include/linux/userfaultfd_k.h |  21 +++--
>  mm/shmem.c                    | 148 ++++++++++++----------------------
>  mm/userfaultfd.c              |  79 +++++++++---------
>  4 files changed, 106 insertions(+), 156 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a8273b32e041..1a345142af7d 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -221,20 +221,6 @@ static inline pgoff_t shmem_fallocend(struct inode *=
inode, pgoff_t eof)
>
>  extern bool shmem_charge(struct inode *inode, long pages);
>
> -#ifdef CONFIG_USERFAULTFD
> -#ifdef CONFIG_SHMEM
> -extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
> -                                 struct vm_area_struct *dst_vma,
> -                                 unsigned long dst_addr,
> -                                 unsigned long src_addr,
> -                                 uffd_flags_t flags,
> -                                 struct folio **foliop);
> -#else /* !CONFIG_SHMEM */
> -#define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
> -                              src_addr, flags, foliop) ({ BUG(); 0; })
> -#endif /* CONFIG_SHMEM */
> -#endif /* CONFIG_USERFAULTFD */
> -
>  /*
>   * Used space is stored as unsigned 64-bit value in bytes but
>   * quota core supports only signed 64-bit values so use that
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.=
h
> index 4d8b879eed91..bf4e595ac914 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -93,10 +93,24 @@ struct vm_uffd_ops {
>         struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t p=
goff);
>         /*
>          * Called during resolution of UFFDIO_COPY request.
> -        * Should return allocate a and return folio or NULL if allocatio=
n fails.
> +        * Should allocate and return a folio or NULL if allocation
> +        * fails.
>          */
>         struct folio *(*alloc_folio)(struct vm_area_struct *vma,
>                                      unsigned long addr);
> +       /*
> +        * Called during resolution of UFFDIO_COPY request.
> +        * Should lock the folio and add it to VMA's page cache.

I don't think "should lock the folio" is accurate. That sounds like
"it will call folio_lock()" but it actually calls
__folio_set_locked(). Maybe this is better:

"Should only be called with a folio returned by alloc_folio() above.
The folio will set to locked."

> +        * Returns 0 on success, error code on failure.
> +        */
> +       int (*filemap_add)(struct folio *folio, struct vm_area_struct *vm=
a,
> +                        unsigned long addr);
> +       /*
> +        * Called during resolution of UFFDIO_COPY request on the error
> +        * handling path.
> +        * Should revert the operation of ->filemap_add().
> +        */
> +       void (*filemap_remove)(struct folio *folio, struct vm_area_struct=
 *vma);
>  };
>
>  /* A combined operation mode + behavior flags. */
> @@ -130,11 +144,6 @@ static inline uffd_flags_t uffd_flags_set_mode(uffd_=
flags_t flags, enum mfill_at
>  /* Flags controlling behavior. These behavior changes are mode-independe=
nt. */
>  #define MFILL_ATOMIC_WP MFILL_ATOMIC_FLAG(0)
>
> -extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
> -                                   struct vm_area_struct *dst_vma,
> -                                   unsigned long dst_addr, struct page *=
page,
> -                                   bool newly_allocated, uffd_flags_t fl=
ags);
> -
>  extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned l=
ong dst_start,
>                                  unsigned long src_start, unsigned long l=
en,
>                                  uffd_flags_t flags);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7bd887b64f62..68620caaf75f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3181,118 +3181,73 @@ static struct inode *shmem_get_inode(struct mnt_=
idmap *idmap,
>  #endif /* CONFIG_TMPFS_QUOTA */
>
>  #ifdef CONFIG_USERFAULTFD
> -int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
> -                          struct vm_area_struct *dst_vma,
> -                          unsigned long dst_addr,
> -                          unsigned long src_addr,
> -                          uffd_flags_t flags,
> -                          struct folio **foliop)
> -{
> -       struct inode *inode =3D file_inode(dst_vma->vm_file);
> -       struct shmem_inode_info *info =3D SHMEM_I(inode);
> +static struct folio *shmem_mfill_folio_alloc(struct vm_area_struct *vma,
> +                                            unsigned long addr)
> +{
> +       struct inode *inode =3D file_inode(vma->vm_file);
>         struct address_space *mapping =3D inode->i_mapping;
> +       struct shmem_inode_info *info =3D SHMEM_I(inode);
> +       pgoff_t pgoff =3D linear_page_index(vma, addr);
>         gfp_t gfp =3D mapping_gfp_mask(mapping);
> -       pgoff_t pgoff =3D linear_page_index(dst_vma, dst_addr);
> -       void *page_kaddr;
>         struct folio *folio;
> -       int ret;
> -       pgoff_t max_off;
> -
> -       if (shmem_inode_acct_blocks(inode, 1)) {
> -               /*
> -                * We may have got a page, returned -ENOENT triggering a =
retry,
> -                * and now we find ourselves with -ENOMEM. Release the pa=
ge, to
> -                * avoid a BUG_ON in our caller.
> -                */
> -               if (unlikely(*foliop)) {
> -                       folio_put(*foliop);
> -                       *foliop =3D NULL;
> -               }
> -               return -ENOMEM;
> -       }
>
> -       if (!*foliop) {
> -               ret =3D -ENOMEM;
> -               folio =3D shmem_alloc_folio(gfp, 0, info, pgoff);
> -               if (!folio)
> -                       goto out_unacct_blocks;
> +       if (unlikely(pgoff >=3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZ=
E)))
> +               return NULL;
>
> -               if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY)) {
> -                       page_kaddr =3D kmap_local_folio(folio, 0);
> -                       /*
> -                        * The read mmap_lock is held here.  Despite the
> -                        * mmap_lock being read recursive a deadlock is s=
till
> -                        * possible if a writer has taken a lock.  For ex=
ample:
> -                        *
> -                        * process A thread 1 takes read lock on own mmap=
_lock
> -                        * process A thread 2 calls mmap, blocks taking w=
rite lock
> -                        * process B thread 1 takes page fault, read lock=
 on own mmap lock
> -                        * process B thread 2 calls mmap, blocks taking w=
rite lock
> -                        * process A thread 1 blocks taking read lock on =
process B
> -                        * process B thread 1 blocks taking read lock on =
process A
> -                        *
> -                        * Disable page faults to prevent potential deadl=
ock
> -                        * and retry the copy outside the mmap_lock.
> -                        */
> -                       pagefault_disable();
> -                       ret =3D copy_from_user(page_kaddr,
> -                                            (const void __user *)src_add=
r,
> -                                            PAGE_SIZE);
> -                       pagefault_enable();
> -                       kunmap_local(page_kaddr);
> -
> -                       /* fallback to copy_from_user outside mmap_lock *=
/
> -                       if (unlikely(ret)) {
> -                               *foliop =3D folio;
> -                               ret =3D -ENOENT;
> -                               /* don't free the page */
> -                               goto out_unacct_blocks;
> -                       }
> +       folio =3D shmem_alloc_folio(gfp, 0, info, pgoff);
> +       if (!folio)
> +               return NULL;
>
> -                       flush_dcache_folio(folio);
> -               } else {                /* ZEROPAGE */
> -                       clear_user_highpage(&folio->page, dst_addr);
> -               }
> -       } else {
> -               folio =3D *foliop;
> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -               *foliop =3D NULL;
> +       if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL)) {
> +               folio_put(folio);
> +               return NULL;
>         }
>
> -       VM_BUG_ON(folio_test_locked(folio));
> -       VM_BUG_ON(folio_test_swapbacked(folio));
> +       return folio;
> +}
> +
> +static int shmem_mfill_filemap_add(struct folio *folio,
> +                                  struct vm_area_struct *vma,
> +                                  unsigned long addr)
> +{
> +       struct inode *inode =3D file_inode(vma->vm_file);
> +       struct address_space *mapping =3D inode->i_mapping;
> +       pgoff_t pgoff =3D linear_page_index(vma, addr);
> +       gfp_t gfp =3D mapping_gfp_mask(mapping);
> +       int err;
> +
>         __folio_set_locked(folio);
>         __folio_set_swapbacked(folio);
> -       __folio_mark_uptodate(folio);
> -
> -       ret =3D -EFAULT;
> -       max_off =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -       if (unlikely(pgoff >=3D max_off))
> -               goto out_release;
>
> -       ret =3D mem_cgroup_charge(folio, dst_vma->vm_mm, gfp);
> -       if (ret)
> -               goto out_release;
> -       ret =3D shmem_add_to_page_cache(folio, mapping, pgoff, NULL, gfp)=
;
> -       if (ret)
> -               goto out_release;
> +       err =3D shmem_add_to_page_cache(folio, mapping, pgoff, NULL, gfp)=
;
> +       if (err)
> +               goto err_unlock;
>
> -       ret =3D mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
> -                                      &folio->page, true, flags);
> -       if (ret)
> -               goto out_delete_from_cache;
> +       if (shmem_inode_acct_blocks(inode, 1)) {
> +               err =3D -ENOMEM;
> +               goto err_delete_from_cache;
> +       }
>
> +       folio_add_lru(folio);
>         shmem_recalc_inode(inode, 1, 0);
> -       folio_unlock(folio);
> +
>         return 0;
> -out_delete_from_cache:
> +
> +err_delete_from_cache:
>         filemap_remove_folio(folio);
> -out_release:
> +err_unlock:
> +       folio_unlock(folio);
> +       return err;
> +}
> +
> +static void shmem_mfill_filemap_remove(struct folio *folio,
> +                                      struct vm_area_struct *vma)
> +{
> +       struct inode *inode =3D file_inode(vma->vm_file);
> +
> +       filemap_remove_folio(folio);
> +       shmem_recalc_inode(inode, 0, 0);
>         folio_unlock(folio);
> -       folio_put(folio);
> -out_unacct_blocks:
> -       shmem_inode_unacct_blocks(inode, 1);
> -       return ret;
>  }
>
>  static struct folio *shmem_get_folio_noalloc(struct inode *inode, pgoff_=
t pgoff)
> @@ -3315,6 +3270,9 @@ static bool shmem_can_userfault(struct vm_area_stru=
ct *vma, vm_flags_t vm_flags)
>  static const struct vm_uffd_ops shmem_uffd_ops =3D {
>         .can_userfault          =3D shmem_can_userfault,
>         .get_folio_noalloc      =3D shmem_get_folio_noalloc,
> +       .alloc_folio            =3D shmem_mfill_folio_alloc,
> +       .filemap_add            =3D shmem_mfill_filemap_add,
> +       .filemap_remove         =3D shmem_mfill_filemap_remove,
>  };
>  #endif /* CONFIG_USERFAULTFD */
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 31f3ab6a73e2..a0f8e67006d6 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -14,7 +14,6 @@
>  #include <linux/userfaultfd_k.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/hugetlb.h>
> -#include <linux/shmem_fs.h>
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -340,10 +339,10 @@ static bool mfill_file_over_size(struct vm_area_str=
uct *dst_vma,
>   * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both=
 shmem
>   * and anon, and for both shared and private VMAs.
>   */
> -int mfill_atomic_install_pte(pmd_t *dst_pmd,
> -                            struct vm_area_struct *dst_vma,
> -                            unsigned long dst_addr, struct page *page,
> -                            bool newly_allocated, uffd_flags_t flags)
> +static int mfill_atomic_install_pte(pmd_t *dst_pmd,
> +                                   struct vm_area_struct *dst_vma,
> +                                   unsigned long dst_addr, struct page *=
page,
> +                                   uffd_flags_t flags)
>  {
>         int ret;
>         struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> @@ -387,9 +386,6 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
>                 goto out_unlock;
>
>         if (page_in_cache) {
> -               /* Usually, cache pages are already added to LRU */
> -               if (newly_allocated)
> -                       folio_add_lru(folio);
>                 folio_add_file_rmap_pte(folio, page, dst_vma);
>         } else {
>                 folio_add_new_anon_rmap(folio, dst_vma, dst_addr, RMAP_EX=
CLUSIVE);
> @@ -404,6 +400,9 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
>
>         set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
>
> +       if (page_in_cache)
> +               folio_unlock(folio);

I don't really like doing the folio_unlock() *here*, I think it's
clearer if the callers (mfill_atomic_pte_continue() and
__mfill_atomic_pte()) unlocked the folio themselves. But that's just
my opinion.

> +
>         /* No need to invalidate - it was non-present before */
>         update_mmu_cache(dst_vma, dst_addr, dst_pte);
>         ret =3D 0;
> @@ -516,13 +515,22 @@ static int __mfill_atomic_pte(struct mfill_state *s=
tate,
>          */
>         __folio_mark_uptodate(folio);
>
> +       if (ops->filemap_add) {
> +               ret =3D ops->filemap_add(folio, state->vma, state->dst_ad=
dr);
> +               if (ret)
> +                       goto err_folio_put;
> +       }
> +
>         ret =3D mfill_atomic_install_pte(state->pmd, state->vma, dst_addr=
,
> -                                      &folio->page, true, flags);
> +                                      &folio->page, flags);
>         if (ret)
> -               goto err_folio_put;
> +               goto err_filemap_remove;
>
>         return 0;
>
> +err_filemap_remove:
> +       if (ops->filemap_remove)
> +               ops->filemap_remove(folio, state->vma);
>  err_folio_put:
>         folio_put(folio);
>         /* Don't return -ENOENT so that our caller won't retry */
> @@ -535,6 +543,18 @@ static int mfill_atomic_pte_copy(struct mfill_state =
*state)
>  {
>         const struct vm_uffd_ops *ops =3D vma_uffd_ops(state->vma);
>
> +       /*
> +        * The normal page fault path for a MAP_PRIVATE mapping in a
> +        * file-backed VMA will invoke the fault, fill the hole in the fi=
le and
> +        * COW it right away. The result generates plain anonymous memory=
.
> +        * So when we are asked to fill a hole in a MAP_PRIVATE mapping, =
we'll
> +        * generate anonymous memory directly without actually filling th=
e
> +        * hole. For the MAP_PRIVATE case the robustness check only happe=
ns in
> +        * the pagetable (to verify it's still none) and not in the page =
cache.
> +        */
> +       if (!(state->vma->vm_flags & VM_SHARED))
> +               ops =3D &anon_uffd_ops;
> +
>         return __mfill_atomic_pte(state, ops);
>  }
>
> @@ -554,7 +574,8 @@ static int mfill_atomic_pte_zeropage(struct mfill_sta=
te *state)
>         spinlock_t *ptl;
>         int ret;
>
> -       if (mm_forbids_zeropage(dst_vma->vm_mm))
> +       if (mm_forbids_zeropage(dst_vma->vm_mm) ||
> +           (dst_vma->vm_flags & VM_SHARED))
>                 return mfill_atomic_pte_zeroed_folio(state);
>
>         _dst_pte =3D pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
> @@ -609,11 +630,10 @@ static int mfill_atomic_pte_continue(struct mfill_s=
tate *state)
>         }
>
>         ret =3D mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
> -                                      page, false, flags);
> +                                      page, flags);
>         if (ret)
>                 goto out_release;
>
> -       folio_unlock(folio);
>         return 0;
>
>  out_release:
> @@ -836,41 +856,18 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaul=
tfd_ctx *ctx,
>
>  static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *stat=
e)
>  {
> -       struct vm_area_struct *dst_vma =3D state->vma;
> -       unsigned long src_addr =3D state->src_addr;
> -       unsigned long dst_addr =3D state->dst_addr;
> -       struct folio **foliop =3D &state->folio;
>         uffd_flags_t flags =3D state->flags;
> -       pmd_t *dst_pmd =3D state->pmd;
> -       ssize_t err;
>
>         if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
>                 return mfill_atomic_pte_continue(state);
>         if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
>                 return mfill_atomic_pte_poison(state);
> +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
> +               return mfill_atomic_pte_copy(state);
> +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
> +               return mfill_atomic_pte_zeropage(state);

Thanks for this cleanup. :)

>
> -       /*
> -        * The normal page fault path for a shmem will invoke the
> -        * fault, fill the hole in the file and COW it right away. The
> -        * result generates plain anonymous memory. So when we are
> -        * asked to fill an hole in a MAP_PRIVATE shmem mapping, we'll
> -        * generate anonymous memory directly without actually filling
> -        * the hole. For the MAP_PRIVATE case the robustness check
> -        * only happens in the pagetable (to verify it's still none)
> -        * and not in the radix tree.
> -        */
> -       if (!(dst_vma->vm_flags & VM_SHARED)) {
> -               if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
> -                       err =3D mfill_atomic_pte_copy(state);
> -               else
> -                       err =3D mfill_atomic_pte_zeropage(state);
> -       } else {
> -               err =3D shmem_mfill_atomic_pte(dst_pmd, dst_vma,
> -                                            dst_addr, src_addr,
> -                                            flags, foliop);
> -       }
> -
> -       return err;
> +       return -EOPNOTSUPP;

WARN_ONCE() here I think.

Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>
