Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2F3C060E
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294173; cv=pass; b=Wk99sXnVbMoilYY7YwKpgu3K3EsoDmih4coxGK0Ulp7MgEmChvIlAPE4xAHVf1dIMI/GatM/MLwhqbpa7IHJ6xElL0I6J3UqsYupDCR5I3Dd2q02ZfmsFm/QmEFubi/UZ6zDHJwkN83lepF9Mv3TBTvzjbfIVWRYgmkUDYx6sVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294173; c=relaxed/simple;
	bh=iiQbiYx7JHsQH7TgWTlg4vZhIljHuH4PY6BnfJU4b3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3psN3w6fvXcD4w1Kkj36n3/1Pu7wBQ5vR5ZzBmfJ5ibYgOTJkd5WHx4tcd2OFfbNakUz7ehF8c2qdPaRBO6YgY3hSP9/PCyw5QiDzq7ODqTHaoZVvJjb01QaXAIf5EX9O03TGofCJQEFbO3vP0+OeJcB7k9XJwdINGbmC3Hk98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJ981YJZ; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJ981YJZ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509062d829dso11161cf.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 12:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294166; cv=none;
        d=google.com; s=arc-20240605;
        b=DjipwVmrnGSsq5rJCcyOV9YYR3i/xZYvAHn+dBcL2bO0WUwuYHxi0RnXa/JDKVLtvo
         6jUxRX0SJnaWLEzlZBvijVDAd3NZw10RgqBohriEWjsTVK0P90NW1DUoIh77Gm1NMzIm
         BUV7FdrkZToXXxodkdDnk72jxRmIHJnQCd9pY+82ncqUe5EoAFA1+qc8e2y3NbRZHZEc
         KHZE8+cREGF0B/YT1ZpxIET01hrEx1aIkoA/ECGxeGMowMtFJu6c088nYGmUSlNWJoNN
         z5cCcZYG9ix0gEPytoipvaiPY6+McLumZkKqGmNUuy60GtEjmKxoT0a24fZebQA8ZV3s
         qj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
        fh=+cS6xno1kGjC3lcoX3LhTfohVMjUj5qPgu53sQCAMuQ=;
        b=dcW/bLE5EEYQi0vJ8uMTuscI6ga1Og9TDORLlBB47SSvl0JvpyF85qW06epf4TXJph
         7l3k/eAau2+0Xpptm0IGOkblg/VjwXwnCY2zeLgRlNrw14RIgis+meskjvGGI6WOunvU
         lBRSyOoJzl4b8BUkA9q9/+/CLGmXpfNF1aKm8AnA+i/EBZBrfOUien7jsAtk6CFvhCWw
         ZSD7oWkKCFV5x1unSDBG3/l4wr9NMK1/BcEq3o/rpF4VxrqJnA10YlYfePydCG7GTrk6
         eiJjqdA8fxUPtXvsKzkPayxdRYqpkIGVtmJY6rLsZNzAc8noxFVkVVPrTlzH9YTgmKp2
         dm1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774294166; x=1774898966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
        b=TJ981YJZcV3aypCMFC8DKXzrGOsHmdmT+KgrWS4E1kX5W67zwkH3IEQa1ZWrcgepyQ
         MaJGRjHKb8tQRBdKFIFnd8feHn/bEf89HNXZQvYQdPDh3wfWm9DTQ6rJbHzN3Mb/7SGY
         UzAgVWKUcR62Y0rppwvdA7qmwURqCOxBDAD/qroPgPG6B9bT+y40ifja3oeqbSHarBjP
         JHYu8i2j4pwrF/xt7r+liKbgD+gJhI5YEPJxuGsbqTfTQLC6BbzeMEHhJlGkfOukPo4f
         hnOHqNnGl2wD8xW3woHRK3DAHiwDdZ8WgaykxSbcAFL+pylJDBsfxf1Z967CNpsbA/Xw
         2IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294166; x=1774898966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
        b=aiDm8zQi7G20UdRa1SBhyJTxX99zMbOjJ0XIeBKrJm9HnQqBF9+SUHDM9DudtC+vEA
         IDbAHUDwNevkXZ7RIwSrrV1xCkw8GLwn5fGhs8vW286ZKp8QxcrPUFG/M9zEAK89v4Lw
         m8Cjc/AhXJqh/eTDTlQrtzw7q7Z2UVeJSJ8TC8YjTFWwhdbBwLu2i7ZoVWMcpa+z+zE2
         zgfAhrX58i1bNly1htLHTEJvF0OIMgi3ChSmrQ2SGpmXEBZuZdaEWn08H9dI5s+fjv2C
         2YMbRd6X2SeNh0884N/bwZvDQIZ/uRXNrwkqAQwg6vpCHAZ3jziVCMxVDloqhW1TEuYR
         SM1g==
X-Forwarded-Encrypted: i=1; AJvYcCX/XTVvWUwGpJO7oB38zBT4y4z9gz6YudKf20Z/U+fRokPMb8oOSjbFDPvjmA3U4voijGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QrCS4tses04JivafXNSI7PQ8vZtLhq6Bw/UJDBQHmzojRaZG
	rDMFsqJTGPvA8NoKh2cQ2aOlwYJg5FTeNecQrnuKuK1kOOtRXXbAAIQ03t3Qpv3bNSMA2nONvY3
	nuzPYczSEiyS+5OaG815v9xzhmEabgUFNPhMSpaS9
X-Gm-Gg: ATEYQzw09q/tKbcf6K6A34jAS4tRDblqHPrQqJoegsI9OeDfvhrvMOb7DB8TTnD40eJ
	JDHT6gHo8ty/3pR43/REzgadAoGrPXM0wWeGVU4+QkJK8WCtNW/E/WkZeklrG6Z2RjHhJF9U/Zl
	ymUssOT9tvYBHwC9vMKD+lW5sEqkdcWKwgqDF5AFSXwWuDn20LJ8e6pzNk54EEBZwy8LaNOu3RX
	AF9RJ5N6e9vNAb4mFwvV1kmYO9iOHw0UMX7ULnJA5vIgVlIxncNXvPoMeoc0cHfnSAr+KgR/0u9
	+pPR1ip4J+h413M2
X-Received: by 2002:a05:622a:a986:20b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50b6fe1094amr2337331cf.15.1774294165477; Mon, 23 Mar 2026
 12:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-5-surenb@google.com>
 <1c44dd0b-4f5a-4fc1-983f-f728b31c9e4d@lucifer.local>
In-Reply-To: <1c44dd0b-4f5a-4fc1-983f-f728b31c9e4d@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Mar 2026 12:29:14 -0700
X-Gm-Features: AQROBzCQaEF_cPLZfBQCzrdp1WYDK-0_JtC25zQIk1w6f-8rEEzfFfTeX5PuZ2c
Message-ID: <CAJuCfpGk3sTw2_owiRZM=V2e0UGDad5MrDbCsPbY3GUvT4u63A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:04=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:43:08PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable() when
> > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > Adjust its direct and indirect users to check for a possible error
> > and handle it. Ensure users handle EINTR correctly and do not ignore
> > it.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c |  5 ++++-
> >  mm/mempolicy.c     |  1 +
> >  mm/pagewalk.c      | 20 ++++++++++++++------
> >  3 files changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index e091931d7ca1..2fe3d11aad03 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >               struct clear_refs_private cp =3D {
> >                       .type =3D type,
> >               };
> > +             int err;
>
> Maybe better to make it a ssize_t given return type of function?

Ack.

>
> >
> >               if (mmap_write_lock_killable(mm)) {
> >                       count =3D -EINTR;
> > @@ -1824,7 +1825,9 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >                                               0, mm, 0, -1UL);
> >                       mmu_notifier_invalidate_range_start(&range);
> >               }
> > -             walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> > +             err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_ops, =
&cp);
> > +             if (err)
> > +                     count =3D err;
>
> Hmm this is gross, but it's an established pattern here, ugh.
>
> Now we have an err though, could we update:
>
>                 if (mmap_write_lock_killable(mm)) {
> -                       count =3D -EINTR;
> +                       err =3D -EINTR;
>                         goto out_mm;
>                 }
>
> Then we can just do:
>
> +               err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_ops, =
&cp);
>
> And at the end do:
>
>         return err ?: count;
>
> Which possibly _necessitates_ err being a ssize_t.

Sounds doable. Let me try that.

>
> >               if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> >                       mmu_notifier_invalidate_range_end(&range);
> >                       flush_tlb_mm(mm);
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 929e843543cf..bb5b0e83ce0f 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vm=
a_walk_ops =3D {
> >   *      (a hugetlbfs page or a transparent huge page being counted as =
1).
> >   * -EIO - a misplaced page found, when MPOL_MF_STRICT specified withou=
t MOVEs.
> >   * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK uns=
pecified.
> > + * -EINTR - walk got terminated due to pending fatal signal.
>
> Thanks!
>
> >   */
> >  static long
> >  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned =
long end,
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index eda74273c8ec..a42cd6a6d812 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -438,14 +438,13 @@ static inline void process_mm_walk_lock(struct mm=
_struct *mm,
> >               mmap_assert_write_locked(mm);
> >  }
> >
> > -static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> > +static inline int process_vma_walk_lock(struct vm_area_struct *vma,
>
> NIT: Don't need this to be an inline any longer. May as well fix up while=
 we're
> here.

Ack.

>
> >                                        enum page_walk_lock walk_lock)
> >  {
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       switch (walk_lock) {
> >       case PGWALK_WRLOCK:
> > -             vma_start_write(vma);
> > -             break;
> > +             return vma_start_write_killable(vma);
>
> LGTM
>
> >       case PGWALK_WRLOCK_VERIFY:
> >               vma_assert_write_locked(vma);
> >               break;
> > @@ -457,6 +456,7 @@ static inline void process_vma_walk_lock(struct vm_=
area_struct *vma,
> >               break;
> >       }
> >  #endif
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -500,7 +500,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm,=
 unsigned long start,
> >                       if (ops->pte_hole)
> >                               err =3D ops->pte_hole(start, next, -1, &w=
alk);
> >               } else { /* inside vma */
> > -                     process_vma_walk_lock(vma, ops->walk_lock);
> > +                     err =3D process_vma_walk_lock(vma, ops->walk_lock=
);
> > +                     if (err)
> > +                             break;
>
> In every other case we set walk.vma =3D vma or NULL. Is it a problem not =
setting
> it at all in this code path?

IIUC the other cases set walk.vma because they later call
ops->pte_hole(..., walk). In our case we immediately break out of the
loop and exit the function, which pushes "walk" variable out of scope.
So, walk.vma won't be used and setting it would achieve nothing.

>
> >                       walk.vma =3D vma;
> >                       next =3D min(end, vma->vm_end);
> >                       vma =3D find_vma(mm, vma->vm_end);
> > @@ -717,6 +719,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (start >=3D end || !walk.mm)
> >               return -EINVAL;
> > @@ -724,7 +727,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
>
> LGTM
>
> >       return __walk_page_range(start, end, &walk);
> >  }
> >
> > @@ -747,6 +752,7 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (!walk.mm)
> >               return -EINVAL;
> > @@ -754,7 +760,9 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
>
> LGTM
>
> >       return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
> >  }
> >
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
>
> Thanks, Lorenzo
