Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96726290
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774570070; cv=pass; b=ZBGzBJca2kZFC4Tju5BTkzkESnY/ZqDKbw+S+fe8+wc18575acIjKvalaUiYG1tK2RiHZa6InddlKBco4q24ss/sqsfdcONl4DstZGcxsv81FTSa2HTENVZDl+9HHls7ajOilks4jl8SMgieNHwskquB+UQHxzQcR9F3Fo5uW6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774570070; c=relaxed/simple;
	bh=FgSHeD7wYVhfNs7LKSuGcvVjUut1LetO1k8SBQQEkrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmjddrri70fIufak7+5EHs/+jlKqZVoidpo0XXpxA2MOBbBaC1cfEAtfs0CtlFnqAedzNbzENOthuz06shfh12QQJ4VCfuEhPIeIAVCutD7W3mI3Y/NQ3BNHuPKjzSQBPmvDf+AXUsei5vC5htxrn/32KzJlLYK3oRvC2R76B/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bhtaijhj; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bhtaijhj"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b93698bb57aso275381166b.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774570066; cv=none;
        d=google.com; s=arc-20240605;
        b=SmRjIak4K1jb6RDjmLgQ9Yf62jPkA0Y7zzSArHaoyUdXqBU/LBQ1C+OWaEkoVGq+BD
         2nMxz0WfAArZblazY441akbIzpQQlhmniShoL3jR7fPJhGuY/wNOyFiGqtnxFTgMsNAf
         LeksxuCM4jMiwnBcsyGx488YWQ7/GgbYGQwFGvwAB1AfiQaHFFmOImO/By96tA7v1G6z
         mxJ2eZUz1cwSYhTrk+J0ZRpX2uAEb37SzL7qOxpaoV2T0MyVMUK/9cU7/C/KNgJaJyRQ
         xPHgjI21Fnp+whcDUb1+aXfCIXm+uIxOzcYvzATE8jRFoeUuaVBkYZtxozN8wWU7QP5+
         tHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6bohw50RBT0u5gW1o6sQ8ESS0bizoR3I3eC4aqE/wA=;
        fh=9YR7cZmrIEoXTM1uKVl/a0+0SEr9wHec+1Ko8LRJYjA=;
        b=GvheW/+XchIX51NCUdrSfD0ksJcFkeL07LKNVG8Jp00nUlTuR2wTNQ3dr8KregB5ae
         EQc0uoLKtcHAGdAIz2vwfJX6DPWznTzZ6U+ZCsZhGqS2GVSXVxmfr7fmj+tL6SdCd6TT
         HcZljuAvVDtmtLfErZUWjWI/yhZdQhcayqVhZsyfUeJLl4BqmA/AHWIomJBLVr7abVFy
         7J384e2iFkUJbQ+RvlsqVqNmjVc1aQvxUoK06MGv2xZiUJhhme/DQsIo4JTGHlBKhyaC
         YsFaHIgBTLefYyj/SQmbL89cB/pwqsXIS7CbsikCM52RCA7CFlOhqz/uYjCyw3Sl1nzQ
         gaaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774570066; x=1775174866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6bohw50RBT0u5gW1o6sQ8ESS0bizoR3I3eC4aqE/wA=;
        b=BhtaijhjxqzdmzdzOSvBrg9pKaD3KcRtwHwkeDs3VGAo9HLlkCQHsJ/Xs2MFsoX9G9
         YS0rLTD+MmChs6WvHbFdgvaBSv/d2ek6caPeFNGjeaihw96aKwDfPEXivta/d/uidxUW
         O6M0pztauWA1Sr5CPVgVaujYO9umKik7z3SNCsFZAhtjCgdZwVcyGCFcSUL5Ux5ACRa6
         bMoJW9mRs//UDKXsJUhbdCMIxTx1eLzMDCjdKsk/zuZTsGyjMCdR7K3l/rweRuSinWoq
         NQOdDlftaqWZmzgL0PvLXrA4Z7QnHvUXDHDvMMhTXxLdE94pGdYiDJ7KtwRYnuIza+HT
         lcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774570066; x=1775174866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6bohw50RBT0u5gW1o6sQ8ESS0bizoR3I3eC4aqE/wA=;
        b=lrbVwF8FlTyfFmKvyow8KdORIb823vjZ+kDme1cM7EBaUryjg3dUvIyNTvh3VKb4is
         QKE/aLk+UF0snhZ8obmUyYLdYdC5vXiC0coAHHX8uyE0h0VbcOt1w7TU5Cr9m6TUdGjr
         h+v40bSpEOrOLpUrGeCe0NIEfnnY4WT6+0ZHIBmmLvCJa/ReB4dNiGI+gIA/wT3lZ9Ht
         8ufmnSQwVI8aNNj5NDCI4/5+hr0/3GQcpNQ2ARzLUR2gpNbmOyu/hGbsQll8EYrAgo/L
         zn8txGnPsRhCbUDwagvueRwoUUL541GZbdVgm7NOt34OWGnogub6aShzpATEv7+t1kbc
         9g/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWniS6odIweuFn+Fat8RTaaidIyziTHSkk989/w78Ra+RxxJ/QpjrhJeCyVIrc1PTOzTwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6+ARUdgKeZij44w9eGv3lUGD6rxjlUEUYYY5lDsc0JrTJJFK
	wS4cPhddJqtq1wGGBnX1zlV39GE4FI1lsS4K6vyDYH1YC6KRyEh410P9oP8T8Gqym2v3bI/ib02
	QUqk8mzsx//M/auGjId5AnmUlykNoDw8BiAz51JT9
X-Gm-Gg: ATEYQzyh1xMlC6sDJcvFIbiQuiY40dFnayuAywNoyuDtWD7DJQXjFn9HSR7ivp/bk5P
	FREjwm/33uXW+WRbqkJ/vcmIVwV+V6noUrynosIt0C+jS+0hcANmyJoXaSW8gcbhBAXonnuZQlx
	YQrcT1xChMyzcPaGloMizU7u/dLFjG4Qwsz4YipGB5XMtVNV9835K9FD7m/a6Y+5woYFMkFbHCm
	JS7BgJhwdH8PqhXGMtWHmRGOpGO9vJU+K6rC8vOxPuZSCoQlmiYWGZsH4vjsHzRtDb2EaxbDXox
	hodMtcWfqybBmWgPTo1t728wz/Xu6HHFcWTFswBDOT9jznWvbY9cXKv7aPNMdSYcbGnwdg==
X-Received: by 2002:a17:907:7b9f:b0:b97:b0ee:34ed with SMTP id
 a640c23a62f3a-b9b5226a311mr13471466b.22.1774570065298; Thu, 26 Mar 2026
 17:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-1-rppt@kernel.org> <20260306171815.3160826-10-rppt@kernel.org>
In-Reply-To: <20260306171815.3160826-10-rppt@kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Thu, 26 Mar 2026 17:07:08 -0700
X-Gm-Features: AQROBzAFCjzaDdbadwVNMyg-TBL1aRLjN2g4Sfb-4vpKogbGWYvxURBEW8LNmxM
Message-ID: <CADrL8HUE1iBSPPDQZ3e-1gxN0Ts9kHAzb4o5X_XqSmQy2y9dRA@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] userfaultfd: introduce vm_uffd_ops->alloc_folio()
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
> and use it to refactor mfill_atomic_pte_zeroed_folio() and
> mfill_atomic_pte_copy().
>
> mfill_atomic_pte_zeroed_folio() and mfill_atomic_pte_copy() perform
> almost identical actions:
> * allocate a folio
> * update folio contents (either copy from userspace of fill with zeros)
> * update page tables with the new folio
>
> Split a __mfill_atomic_pte() helper that handles both cases and uses
> newly introduced vm_uffd_ops->alloc_folio() to allocate the folio.
>
> Pass the ops structure from the callers to __mfill_atomic_pte() to later
> allow using anon_uffd_ops for MAP_PRIVATE mappings of file-backed VMAs.
>
> Note, that the new ops method is called alloc_folio() rather than
> folio_alloc() to avoid clash with alloc_tag macro folio_alloc().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  include/linux/userfaultfd_k.h |  6 +++
>  mm/userfaultfd.c              | 92 ++++++++++++++++++-----------------
>  2 files changed, 54 insertions(+), 44 deletions(-)
>
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.=
h
> index 66dfc3c164e6..4d8b879eed91 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -91,6 +91,12 @@ struct vm_uffd_ops {
>          * The returned folio is locked and with reference held.
>          */
>         struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t p=
goff);
> +       /*
> +        * Called during resolution of UFFDIO_COPY request.
> +        * Should return allocate a and return folio or NULL if allocatio=
n fails.

"Should allocate and return a folio or NULL if allocation fails."

I see this mistake is fixed in the next patch. :)

> +        */
> +       struct folio *(*alloc_folio)(struct vm_area_struct *vma,
> +                                    unsigned long addr);
>  };
>
>  /* A combined operation mode + behavior flags. */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 98ade14eaa5b..31f3ab6a73e2 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -42,8 +42,26 @@ static bool anon_can_userfault(struct vm_area_struct *=
vma, vm_flags_t vm_flags)
>         return true;
>  }
>
> +static struct folio *anon_alloc_folio(struct vm_area_struct *vma,
> +                                     unsigned long addr)
> +{
> +       struct folio *folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, =
vma,
> +                                             addr);
> +
> +       if (!folio)
> +               return NULL;
> +
> +       if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL)) {
> +               folio_put(folio);
> +               return NULL;
> +       }
> +
> +       return folio;
> +}
> +
>  static const struct vm_uffd_ops anon_uffd_ops =3D {
>         .can_userfault  =3D anon_can_userfault,
> +       .alloc_folio    =3D anon_alloc_folio,
>  };
>
>  static const struct vm_uffd_ops *vma_uffd_ops(struct vm_area_struct *vma=
)
> @@ -458,7 +476,8 @@ static int mfill_copy_folio_retry(struct mfill_state =
*state, struct folio *folio
>         return 0;
>  }
>
> -static int mfill_atomic_pte_copy(struct mfill_state *state)
> +static int __mfill_atomic_pte(struct mfill_state *state,
> +                             const struct vm_uffd_ops *ops)
>  {
>         unsigned long dst_addr =3D state->dst_addr;
>         unsigned long src_addr =3D state->src_addr;
> @@ -466,16 +485,12 @@ static int mfill_atomic_pte_copy(struct mfill_state=
 *state)
>         struct folio *folio;
>         int ret;
>
> -       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, state->vma, ds=
t_addr);
> +       folio =3D ops->alloc_folio(state->vma, state->dst_addr);
>         if (!folio)
>                 return -ENOMEM;
>
> -       ret =3D -ENOMEM;
> -       if (mem_cgroup_charge(folio, state->vma->vm_mm, GFP_KERNEL))
> -               goto out_release;
> -
> -       ret =3D mfill_copy_folio_locked(folio, src_addr);
> -       if (unlikely(ret)) {
> +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY)) {
> +               ret =3D mfill_copy_folio_locked(folio, src_addr);
>                 /*
>                  * Fallback to copy_from_user outside mmap_lock.
>                  * If retry is successful, mfill_copy_folio_locked() retu=
rns
> @@ -483,9 +498,15 @@ static int mfill_atomic_pte_copy(struct mfill_state =
*state)
>                  * If there was an error, we must mfill_put_vma() anyway =
and it
>                  * will take care of unlocking if needed.
>                  */
> -               ret =3D mfill_copy_folio_retry(state, folio);
> -               if (ret)
> -                       goto out_release;
> +               if (unlikely(ret)) {
> +                       ret =3D mfill_copy_folio_retry(state, folio);
> +                       if (ret)
> +                               goto err_folio_put;
> +               }
> +       } else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> +               clear_user_highpage(&folio->page, state->dst_addr);
> +       } else {
> +               VM_WARN_ONCE(1, "unknown UFFDIO operation");

"Unknown UFFDIO operation. flags=3D%x", flags

seems a little better to me.

>         }
>
>         /*
> @@ -498,47 +519,30 @@ static int mfill_atomic_pte_copy(struct mfill_state=
 *state)
>         ret =3D mfill_atomic_install_pte(state->pmd, state->vma, dst_addr=
,
>                                        &folio->page, true, flags);
>         if (ret)
> -               goto out_release;
> -out:
> -       return ret;
> -out_release:
> +               goto err_folio_put;
> +
> +       return 0;
> +
> +err_folio_put:
> +       folio_put(folio);
>         /* Don't return -ENOENT so that our caller won't retry */
>         if (ret =3D=3D -ENOENT)
>                 ret =3D -EFAULT;
> -       folio_put(folio);
> -       goto out;
> +       return ret;
>  }
>
> -static int mfill_atomic_pte_zeroed_folio(pmd_t *dst_pmd,
> -                                        struct vm_area_struct *dst_vma,
> -                                        unsigned long dst_addr)
> +static int mfill_atomic_pte_copy(struct mfill_state *state)
>  {
> -       struct folio *folio;
> -       int ret =3D -ENOMEM;
> -
> -       folio =3D vma_alloc_zeroed_movable_folio(dst_vma, dst_addr);
> -       if (!folio)
> -               return ret;
> -
> -       if (mem_cgroup_charge(folio, dst_vma->vm_mm, GFP_KERNEL))
> -               goto out_put;
> +       const struct vm_uffd_ops *ops =3D vma_uffd_ops(state->vma);
>
> -       /*
> -        * The memory barrier inside __folio_mark_uptodate makes sure tha=
t
> -        * zeroing out the folio become visible before mapping the page
> -        * using set_pte_at(). See do_anonymous_page().
> -        */
> -       __folio_mark_uptodate(folio);
> +       return __mfill_atomic_pte(state, ops);
> +}
>
> -       ret =3D mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
> -                                      &folio->page, true, 0);
> -       if (ret)
> -               goto out_put;
> +static int mfill_atomic_pte_zeroed_folio(struct mfill_state *state)
> +{
> +       const struct vm_uffd_ops *ops =3D vma_uffd_ops(state->vma);
>
> -       return 0;
> -out_put:
> -       folio_put(folio);
> -       return ret;
> +       return __mfill_atomic_pte(state, ops);
>  }
>
>  static int mfill_atomic_pte_zeropage(struct mfill_state *state)
> @@ -551,7 +555,7 @@ static int mfill_atomic_pte_zeropage(struct mfill_sta=
te *state)
>         int ret;
>
>         if (mm_forbids_zeropage(dst_vma->vm_mm))
> -               return mfill_atomic_pte_zeroed_folio(dst_pmd, dst_vma, ds=
t_addr);
> +               return mfill_atomic_pte_zeroed_folio(state);
>
>         _dst_pte =3D pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
>                                          dst_vma->vm_page_prot));
> --
> 2.51.0
>
