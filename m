Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A9410D06
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549489; cv=pass; b=sjMXTc28FaoE6AjJfF+rcIsVP76PHHVPeawfZJFMm3vAO90eYOnrPvDUEH+E0v/X7QntLOG7R7nFxZuEIzewkmOc9gMxkPtsX+Ygiqqn8Kj8taxcjEzp2CpTmovqKEI9DlUKZetXiF6LSPXhhuHI7qWNvfpHlv6K1Efiz5jvLtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549489; c=relaxed/simple;
	bh=vV0FfkMOXsfsipj7YfWLpHAGdujKQ79g0MHFT4jDWso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2iKNiwMwMFFjb6/u5zE6TvrU/1c0q2qHLDtSl5rSKnbwetnRMbmSbhpDwVRum5R245NCTJ5BlTQ0P5UznHrYTQvpo5oIfIgX70IQr6todH5CP8dhxqJhY/r48xJooiEWXUngYGKjrk0JA8Na34Bj0FpudxwEHe5pMMFk/bshuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivx61MaE; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivx61MaE"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b6c45781aso88251cf.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549487; cv=none;
        d=google.com; s=arc-20240605;
        b=RRSSGAjs1sG9E0OjKxESW15PqJOXRnA8IylNBZWYqdXt7VAvXLRw9s1aAleGsnA0rt
         49h8CqQnoXWdw5Ipad6JiTJN7km7LXELTH/CXoRtxL97VS153EwWM/hXEvRkRtr/ee/I
         XGPhtIS/bwpm1zQncv55zpSRMlNf3vXU3C5ceoGhTk2BZKsQQDKNHvdD+f25BrQXd+XT
         iIkoF3LBaaZ1ooqN+L8EMpvWJnZeERdZeQv1JpiARuuW0VKmi4ZjBF5mESjyuTcwS002
         m6jFaTdBwM4a6zu7eiCYYODk35uQVVLnCaWgVY6U7m0bQb2zWYsE4r/oouvmhLi6BXxa
         UhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        fh=mhpMAOhJbcQEHYL6dRWBjT9PBc1IJ3wDYScwXfI0K3c=;
        b=e5m3YRnRjDzZsy21g72bF+hmug7u3G4yTWym9AgtHl7NfbhzOGvAxDTkJ5BSKnZgAQ
         UKOAU2ZZncWggx0lEGMBnQNnP6ny74mBesW18lSmDWNq0j0fp6rOZEmo967c1gB4uZHu
         w/YjC0WmvC30RB2k5JzoLxYNSswHLc4v+XDfno7pV4+1yM1VJf8DgP/I+wblyx4DdOVV
         E17XtAqivY5nEOXBGrV5Tsz/Jx7+YcKDhWGCFHzkK5NmHBlIEf86lG1lIIFY227j1Kxh
         IBzs5+GnSKam5nhTYfBScjYRHgl3KpCYJhY+2Q2J8KeC1eJKBQOJegDd1OcVlLeAOBOb
         VuUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774549487; x=1775154287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        b=ivx61MaEp/zQSux3x9+QX1b20Umy0hUiUf9oBIKs6blgAjjNfS9Za2ym9fx8hoS5Ae
         KeSdZEESFQBlIt8r1Rr8gy/L0qE2HX85PT0stEf5aU3wHylzbZxmERJoozV3u8uAXo6X
         +zGsup3KrpP90Q0Ml2ooSVmTpxx+ZlpwNOHSZAy9dzHWMiFzPceOg3xPvL3TsnxTYXGn
         GN7S/SIrKq428BIafT62c5HPqPIcHiOq8jCEbonkmgBtkpSs9yLBKCHMWO3Elq6UBOyy
         1GQFEvnUeVBDyWWTFc2MoseBFMEd8NSklddYv29BWZy59sJNLa0FGsATNEeeCAuQ7BBO
         1CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549487; x=1775154287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        b=fPkaxkGPmuiC4rJMcQh+33EViqxukHFXuz/L8eKbhKOVK3WXLJ99cw0jmRF+rG+RL/
         /HjE66mLEaS1fL45uK/6/LIBai69X3XRgHxEsWeUOP2zb9OsnfHZypdcr6Dzn1YY4e10
         xdaP2x8yT82cAU9Fm0n7LBgjdqtxAkG6kUnT9+JjF8ltTrV8W3TQbh8/G5P/oqtnUdv0
         Zo9zfy2CUIC+RU+r3N9EUy76chKrUgeMX84AyTpPOs+m10TngmCpHUHeQexYU36kxW5t
         5/SQAlwdygRxE1Mc62DkJsK1d76+Ly4wTgDAlwKADgGHSbPiQSnKknd221rfNAQhPE7J
         0iZw==
X-Forwarded-Encrypted: i=1; AJvYcCXIDUpw4OHLFWySfRXuwGWIYdkev+RBBQL3u0p3MxqKLGDcrD7pL3vSPERIoipOrtZbCR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5F3293gGFDdswxmfLtBVzTbxRHzvtZ8OOE7YYa+k4KkrXqge
	ER92OFdGgPU+/zxsxrz02ke/cJUmjk6P9+hLS7n7wBb+XGJ2cq5XTTu3gkCFmbkvGDkl5M5Tnn2
	zt8rshiXNfJSH2qULr/MkwHOTMZPlrRt/H8KakNKn
X-Gm-Gg: ATEYQzxG4dJalrMIO4iq8J9H0fkFVU14LorllgkcvcB9cY1Bw8OMSnLIQsmnCkhBqQ1
	JjYsGi44k7KlOBdFP0b8tXgdAvJi07YKFCMZZdn+sOa0GUk3sFclRDoR751IfXCduN3Ymu3I5l6
	HvM3vFjb7O1kkTtteoSjDiAOu/UW/lH5IX2LL8RtZN5yD8GdPIHHvUY6cCOP5xbDUoGCeM9q3Wi
	mW+UK7KchH5N+t+jC0ljytnTtReZMc2CRWeMBP3uU4nsc0ayEdXZtl0EM/n46sbuVFH6NDMfVv3
	TayT40za3OXufAYMQcfRvdyONXm1kyI60Q==
X-Received: by 2002:a05:622a:93:b0:50b:71e4:878c with SMTP id
 d75a77b69052e-50ba1e41c39mr1037271cf.15.1774549486349; Thu, 26 Mar 2026
 11:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
In-Reply-To: <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Mar 2026 11:24:35 -0700
X-Gm-Features: AQROBzDeN__PRe-Y7mIO9LZxPL3s1KNrdWWWOsbo7He0DKFlde5Dab9lnrvUpiU
Message-ID: <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
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

On Thu, Mar 26, 2026 at 2:18=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> -cc old email
>
> (Gentle reminder to please send all new stuff to ljs@kernel.org - at some
> point I'm going to set a rule to ignore kernel mail sent to the old addre=
ss
> so, if you need a response you should send to the new :)

Ack, sorry about that and thanks for all the reviews, Lorenzo!

I noticed Sashiko's concerns at [1] and a number of them are false
positives but I see at least one new claim which might be legit. I'll
check if it holds water.

[1] https://sashiko.dev/#/patchset/20260326080836.695207-1-surenb%40google.=
com

>
>
> On Thu, Mar 26, 2026 at 01:08:30AM -0700, Suren Baghdasaryan wrote:
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
> >
> > There are several places which are left untouched by this patchset:
> >
> > 1. free_pgtables() because function should free page tables even if a
> > fatal signal is pending.
> >
> > 2. userfaultd code, where some paths calling vma_start_write() can
> > handle EINTR and some can't without a deeper code refactoring.
> >
> > 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> > and operates on a remote mm. Incomplete operations here would result
> > in an inconsistent cgroup state.
> >
> > 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> > vma_start_write() out of these functions and replacing it with
> > vma_assert_write_locked(), then callers of these functions should
> > lock the vma themselves using vma_start_write_killable() whenever
> > possible.
> >
> > Changes since v4 [1]:
> > - added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the c=
ode
> > stayed the same)
> > - split patch 2 into 3 parts, per Lorenzo Stoakes
> > - converted vma_start_write() in mseal_apply(), per Sashiko
> > - changed vma_start_write_killable() error handling in
> > set_mempolicy_home_node(), per Lorenzo Stoakes
> > - added comment why mm->locked_vm is fine even when we exit early,
> > per Sashiko
> > - moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
> > and Lorenzo Stoakes
> > - set give_up_on_oom on error in vma_merge_existing_range() to propagat=
e
> > the error, per Lorenzo Stoakes
> > - moved validate_mm() out of the error path in expand_upwards(),
> > per Lorenzo Stoakes
> > - dropped the patch changing S390 error handling, per Sashiko and
> > Lorenzo Stoakes
> > - reworked error handling in clear_refs_write(), per Lorenzo Stoakes
> > - uninlined process_vma_walk_lock() while changing its return type,
> > per Lorenzo Stoakes
> >
> > [1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.c=
om/
> >
> > Suren Baghdasaryan (6):
> >   mm/vma: cleanup error handling path in vma_expand()
> >   mm: use vma_start_write_killable() in mm syscalls
> >   mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
> >   mm/vma: use vma_start_write_killable() in vma operations
> >   mm: use vma_start_write_killable() in process_vma_walk_lock()
> >   KVM: PPC: use vma_start_write_killable() in
> >     kvmppc_memslot_page_merge()
> >
> >  arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
> >  fs/proc/task_mmu.c                 |  12 +--
> >  mm/khugepaged.c                    |   5 +-
> >  mm/madvise.c                       |   4 +-
> >  mm/memory.c                        |   2 +
> >  mm/mempolicy.c                     |  12 ++-
> >  mm/mlock.c                         |  28 ++++--
> >  mm/mprotect.c                      |   5 +-
> >  mm/mremap.c                        |   8 +-
> >  mm/mseal.c                         |   5 +-
> >  mm/pagewalk.c                      |  22 +++--
> >  mm/vma.c                           | 146 +++++++++++++++++++++--------
> >  mm/vma_exec.c                      |   6 +-
> >  13 files changed, 190 insertions(+), 70 deletions(-)
> >
> >
> > base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
