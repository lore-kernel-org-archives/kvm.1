Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E73C1088
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370174; cv=pass; b=hSdvI2mm4TY78RdLH05RUTxEPCQ20NGjiEfhYAJlkO5JxSJgVhSnGLbSziP4rW0/mKav9MKeQ/a9IsuLqnhcKSHQghxu7cHXABIWFf6+i31YZO97xhloh+uRXu535IhsfGPpKi7OHLr+cJrrBpS0LkcYdzRrvpk04K3LSVssCkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370174; c=relaxed/simple;
	bh=iBVsJ8b3QQtga9Wh/Fpr8CyO+1tQQB/LUsRxsWFpMQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPpX7hOWYLZb76Ja9JdX2Cmztsy/5xQpo+QYIy0hVteyzbtb1dTxbkFwFhu6at/zvjQczPOO4TonukvYzzHSKXSlRCtlY3nC86TJxGOcP3NvIlL67RR+AbPq8pmNMdow7Y3jo0QLBCrG3tgnmg27z4L28Cu1l4+Ty9BKT+COIUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NoZzxO6q; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NoZzxO6q"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177d1ff061so132471cf.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 23:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782370172; cv=none;
        d=google.com; s=arc-20260327;
        b=skXRz7/6DF9c5a4ETEuTNMMA/P+CrUuUjxb4eIHNssDH3rZ4l7okM6ozOkALiTUVAr
         DvfYdLgcCvxrGsd6HmhxSLp5sYUCcxbs9tmkQASAVJPtX6lOKmd769O+F6yhMPrSFdiS
         QF0kAGAVT5yQxg500dsgXUfA0r9RE+D255PSfnkTxf9L2+eY9x/h4xN0SsGRkHImbVDG
         0FYqOJF/IbKkYeDTJU9dURc964UcIoFRUQoG6c/bOWPckDpWL/aWf8tMg1Iu4N9hpCCN
         oLhD9weNoOE1oZ0rtoYwjllpIWq5M798NLBOYkHcs1kT94aoWZay3yZiQqvypZzr0r5w
         /gZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BW7Opa6Dhh+zjWlX+o6b9MK5iA1TvQIACZyIwKHD0Lc=;
        fh=UiHL6Kr03awyd5zvwmOed09B/9JfyWM4p7WbAY7FcQw=;
        b=VgYb8xJw+j+eXn+m+e9kswgpjUGI5BE/euORxII6hvG4k9E2V8OrOgfESTeBVEWine
         BaxGprd6HAw64sumR6FA//sgzYjGjHtYFF1sgVD4LgpYRr8UYNBkPblaQppWe/KFlHB9
         pujS7BxWoHO65SsqPX0JvoIBTboj8czjCkcXmZ3ulbcZI5MSrYLcYPvAvf7orX1XXtyY
         /SZhDrvimExkvx8Z2wq5m1+A8Pg7TrRutVT5Z0L37eEdIfvU7BoMxMiUEwHJfMaoB3G2
         Kge7oozg5TmCYGz6DXVZG2CRwr0joWHpvga7r1S9KvpCPDj0J2zCiEB5pcVvZa2jIMIW
         bGug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370172; x=1782974972; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BW7Opa6Dhh+zjWlX+o6b9MK5iA1TvQIACZyIwKHD0Lc=;
        b=NoZzxO6qvWFpZE0QFWStWhqZEzOPKKdEs2usYcziRayPrFs/tqRzex6v96qsYc/Na/
         HWTu1N507wzgB1ij60gVi9W7vDMXoKMALb4t/yYb2kyve+OXfpDYc1W21njoeNQW0dkr
         +b26D4mnawMJTwZ1fP2sggXR8HqwiJfFeyXnlz9vpbVYSDlToFAJVBP/sDactdUyfwD+
         hH1tqdMKDY7swPyTBokS4LDks9tPHZPmBuNdrLr5St5VDtU3BNk9slyK9FcPLYa+NP2k
         3HS4a9MEsrMW8rfvtUwejB+0hQEuhADeJzM0MbmW7C+wBnaYv7p6Jvmw7LZIVqV+qbCt
         FzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370172; x=1782974972;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BW7Opa6Dhh+zjWlX+o6b9MK5iA1TvQIACZyIwKHD0Lc=;
        b=FLOrSYIdIjAFwLi/sGw1eIesa4SAw2CSQ/dTQz7bxQkRPS9hE9SFteaY2g4yPjxmdX
         lYZQPa8RMFvrE8nJ10AEw7DSqcYw2sTMK0qi6+rPn1D1tYKzNW8SDFXRZA9SnC/j7s8u
         IXp4wX/1RGz9Els5CWYh3Z20J8e+VWpINnITOlToASdD5OkEixYtQF8B7YoYRdkRmDXD
         Ysq6HSsAgf1GiUvA7hWZK6wCpv/5MaCXxdCzhctaIeRisBOONTHgWbRuObQQ9QPkUwhs
         aJ6FwvbJc3VOgvlhq6KszD5K84XvvOhzK2jQvdQV8U2r9kF9HpuwgTkdD02+r7y21o7J
         nrHA==
X-Forwarded-Encrypted: i=1; AFNElJ8vzdy50Khp7ZWw70PvQ8bekzg7dRofxSkWMiOpnlnNeK91d4FBNDtOZ9d9arhrS/s6t9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9txG+Usp8EsG6G4PgR8Hc4dv3jQklJXlzNg35Ivf+ZR/rM289
	QJdJB6ib8rfAo6KZZs14Io+esAhXER1m4ZaLAt83p1tUrzH8WyAdrpXGyCCOsiyrvRC7Tlewkbm
	GxNJrXE/SH3UgzMvXNP6SVfpF2LWFzA5+8P0XDAa6
X-Gm-Gg: AfdE7ck9I9LLylL/SSurimxPXx15tcSJwuLusksOXpMxrEXhiouKLHuSjV8oRjCuUjF
	cGr4p2W19AMM9aVpQyYr/7NCrHwqbIfoUHHs7MZZBfFQLtHehttZqrp42cZTRPbJBqaS8tHyUgJ
	YwN75A6WJAeqT6xakhDL2HNBCqnvxupxIcBBaTh+mW8w+KMs7uQZWybjxlQajegzXrvlg6Mop+A
	vdxynas1cL837Suwk2eSRLPMOKhPRscLuR0NeIHXqxFDVf7ypVNpu/MpsqPrwuP1PM3v9juMA==
X-Received: by 2002:a05:622a:590d:b0:516:4f62:85e7 with SMTP id
 d75a77b69052e-51a6eba2d56mr6487551cf.18.1782370171491; Wed, 24 Jun 2026
 23:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-15-9d2959357853@google.com>
 <CA+EHjTx+3U++dnhGEkwh2SO82xMugAvvJ9ee1O__sxZCKL_X5A@mail.gmail.com>
 <ajneQVLriUshjFIO@google.com> <CAEvNRgGX3GkazCWM=6y9YLgn=YemXuG==Oo+L58cac1Fd86_TQ@mail.gmail.com>
In-Reply-To: <CAEvNRgGX3GkazCWM=6y9YLgn=YemXuG==Oo+L58cac1Fd86_TQ@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 07:48:54 +0100
X-Gm-Features: AVVi8CfreADhCYO8SWIiCTVF-3y6AW4q3NKMJ9GslS4VlV8Wo9lYZb5g5o0n_q8
Message-ID: <CA+EHjTwLRzrq0vY0-OosENJ2Gkknerux53aVBj0zGRQUkRQP=A@mail.gmail.com>
Subject: Re: [PATCH v8 15/46] KVM: guest_memfd: Call arch invalidate hooks on conversion
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 18:46, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Sean Christopherson <seanjc@google.com> writes:
>
> > On Fri, Jun 19, 2026, Fuad Tabba wrote:
> >> On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> >> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >> >
> >> > From: Ackerley Tng <ackerleytng@google.com>
> >> >
> >> > When memory in guest_memfd is converted from private to shared, the
> >> > platform-specific state associated with the guest-private pages must be
> >> > invalidated or cleaned up.
> >> >
> >> > Iterate over the folios in the affected range and call the
> >> > kvm_arch_gmem_invalidate() hook for each PFN range. This allows
> >> > architectures to perform necessary teardown, such as updating hardware
> >> > metadata or encryption states, before the pages are transitioned to the
> >> > shared state.
> >> >
> >> > Invoke this helper after indicating to KVM's mmu code that an invalidation
> >> > is in progress to stop in-flight page faults from succeeding.
> >> >
> >> > Reviewed-by: Fuad Tabba <tabba@google.com>
> >> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >>
> >> Coming back to this after working through the arm64/pKVM side. My
> >> Reviewed-by here is from the previous round and the patch hasn't
> >> changed, but I missed an implication for arm64.
> >>
> >> kvm_arch_gmem_invalidate() is now called from two paths with the same
> >> (start, end) signature: folio teardown (kvm_gmem_free_folio) and
> >> private->shared conversion (here). For SNP/TDX that's fine, conversion is
> >> destructive anyway. For pKVM the two need opposite content semantics:
> >> conversion must preserve the page in place (same physical page, the point
> >> of in-place conversion without encryption), while teardown must scrub it
> >> before returning it to the host.
> >>
> >> The hook gets only a pfn range with no indication of which caller it's
> >> serving, so arm64 can't give the two paths the behaviour they need. It
> >> would help to signal intent on the conversion path: a reason/flag, a
> >> separate hook, or not routing non-destructive conversion through the
> >> teardown hook.
> >>
> >> arm64 isn't here yet, so this isn't urgent, but the hook is gaining a
> >> second caller now, and it's cheaper to leave room for the distinction
> >> than to change a generic contract other arches depend on later.
> >
> > Crud.  It may not be urgent for arm64, but it's urgent for other reasons that
> > I "can't" describe in detail at the moment, and even if that weren't the case, I
> > think we should clean things up now.  More below.
> >
> >> >  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 41 insertions(+)
> >> >
> >> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >> > index 433f79047b9d1..3c94442bc8131 100644
> >> > --- a/virt/kvm/guest_memfd.c
> >> > +++ b/virt/kvm/guest_memfd.c
> >> > @@ -607,6 +607,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> >> >         return safe;
> >> >  }
> >> >
> >> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> >> > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> >
> > Not your fault, but kvm_arch_gmem_invalidate() is badly misnamed.  It's not
> > "invalidating" anything, it's much more of a "free" callback, as SNP uses it to
> > put physical pages back into a shared state when a maybe-private folio is freed.
> >
> > As Fuad points out, (ab)using that hook for the private=>shared conversion case
> > "works", but not broadly.  And it makes the bad name worse, because it's called
> > from code that _is_ doing true invalidations.  For pKVM, it may not even need to
> > do anything invalidation-like.
> >
>
> Thanks, I also didn't like the naming of kvm_gmem_invalidate(),
> especially when conversions also calls
> kvm_gmem_invalidate_{start,end}() and those do different things.
>
> > To avoid a conflict with patches that are going to have priority over this series,
> > to set the stage for arm64 support, and to avoid avoid bleeding vendor details
> > into guest_memfd, as if they are core guest_memfd behavior (only SNP needs the
> > "invalidation" on this specific transition), I think we should add an arch hook
> > to do conversions straightaway.
> >
> > Unless there's a clever option I'm missing, it'll mean adding yet another
> > HAVE_KVM_ARCH_GMEM_XXX flag?  Hmm, especially because IIUC, arm64/pKVM doesn't
> > need a callback for this case, only the free_folio case.
> >
> >> > +{
> >> > +       struct folio_batch fbatch;
> >> > +       pgoff_t next = start;
> >> > +       int i;
> >> > +
> >> > +       folio_batch_init(&fbatch);
> >> > +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> >> > +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> >> > +                       struct folio *folio = fbatch.folios[i];
> >> > +                       pgoff_t start_index, end_index;
> >> > +                       kvm_pfn_t start_pfn, end_pfn;
> >> > +
> >> > +                       start_index = max(start, folio->index);
> >> > +                       end_index = min(end, folio_next_index(folio));
> >> > +                       /*
> >> > +                        * end_index is either in folio or points to
> >> > +                        * the first page of the next folio. Hence,
> >> > +                        * all pages in range [start_index, end_index)
> >> > +                        * are contiguous.
> >> > +                        */
> >> > +                       start_pfn = folio_file_pfn(folio, start_index);
> >> > +                       end_pfn = start_pfn + end_index - start_index;
> >> > +
> >> > +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
> >> > +               }
> >> > +
> >> > +               folio_batch_release(&fbatch);
> >> > +               cond_resched();
> >> > +       }
> >> > +}
> >> > +#else
> >> > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> >> > +#endif
> >> > +
> >> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >> >                                      size_t nr_pages, uint64_t attrs,
> >> >                                      pgoff_t *err_index)
> >> > @@ -647,7 +683,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >> >          */
> >> >
> >> >         kvm_gmem_invalidate_start(inode, start, end);
> >> > +
> >> > +       if (!to_private)
> >> > +               kvm_gmem_invalidate(inode, start, end);
> >
> > E.g. instead make this something like this?
> >
> >       kvm_gmem_set_pfn_attributes(...)
> >
> > Hrm, though that wastes folio lookups in the to_private case.  So maybe just this,
> > assuming pKVM doesn't need to take additional action on conversions?
> >
> >       if (!to_private)
> >               kvm_gmem_make_shared(...)
> >
> > Actually, if we do that, then we don't need a separate arch hook, just a separate
> > config.  It'll still bleed SNP details into guest_memfd, but it'll at least be
> > done in a way that's more explicitly arch specific (and it's no different than
> > what we already do for PREPARE...).
> >
>
> pKVM needs some arch guest_memfd lifecycle functions that
>
> + for conversion, doesn't do anything,
> + for teardown, resets page state (IIUC it'll be reset to
>   PKVM_PAGE_OWNED (by the host))
>
> So I think we need different functions for those two stages in the
> lifecycle of a page with guest_memfd? What if we have

Yes, the split is what I was after. One PFN-range hook for both
teardown and private->shared conversion can't tell them apart, and for
pKVM the two want opposite content semantics.

Two configs rather than one is right, since the needs are independent.
pKVM wants teardown but not conversion.

>
> CONFIG_HAVE_KVM_ARCH_GMEM_SET_PFN_ATTRIBUTES, which gates
>
> + kvm_gmem_should_set_pfn_attributes(attributes) and
>   .gmem_should_set_pfn_attributes
> + kvm_gmem_set_pfn_attributes(start_pfn, end_pfn, attributes) and
>   .gmem_set_pfn_attributes
>
> CONFIG_HAVE_KVM_ARCH_GMEM_TEARDOWN, which gates
>
> + kvm_gmem_teardown() and .gmem_teardown
>
> SNP:
>
> + .gmem_should_set_pfn_attributes = sev_gmem_should_set_pfn_attributes,
>   and sev_gmem_should_set_pfn_attributes returns !is_private
> + Rename .gmem_invalidate and sev_gmem_invalidate to *set_pfn_attributes
> + .gmem_teardown = sev_gmem_set_pfn_attributes
>
> TDX:
>
> + Disable CONFIG_HAVE_KVM_ARCH_GMEM_SET_PFN_ATTRIBUTES
> + Disable CONFIG_HAVE_KVM_ARCH_GMEM_TEARDOWN
>
> pKVM:
>
> + Disable CONFIG_HAVE_KVM_ARCH_GMEM_SET_PFN_ATTRIBUTES
> + .gmem_teardown = pkvm_gmem_set_pfn_attributes

Right for pKVM:

- teardown is not a no-op: it scrubs the page and resets the host
  state to PKVM_PAGE_OWNED before the page returns to the host. Your
  "reset to PKVM_PAGE_OWNED" reading is correct.

- the arch conversion hook is a no-op, so disabling SET_PFN_ATTRIBUTES
  is correct. Conversions in pKVM are guest-initiated: the
  share/unshare hypercall does the stage-2 and page-state transition
  at EL2. The host still runs the generic conversion path (safety
  check, attribute update) and accepts the conversion, but EL2 has
  already done the transition, so there is nothing arch-specific left
  for a hook to do. The page is preserved in place (no scrub).

  If pKVM does turn out to need a step on conversion, it stays
  non-destructive either way, and it can opt in later without touching
  a contract others depend on.


Folding the direction check behind .gmem_should_set_pfn_attributes is
a good cleanup, it keeps the !to_private check out of generic gmem.

On naming: gmem_teardown is better. gmem_set_pfn_attributes reads a
bit close to KVM_SET_MEMORY_ATTRIBUTES, but naming is hard. :)

>
> Suzuki, does this work for ARM CCA?
>
> This way,
>
> + The if (is_private) check doesn't leak SNP details into guest_memfd
> + .gmem_make_shared doesn't stick out without a .gmem_make_private
> + .gmem_set_pfn_attributes, .gmem_prepare and .gmem_teardown are aligned
>   conceptually as lifecycle hooks
>
> + I think the private/shared check for prepare can also be folded into
>   preparation.
>     + Preparation perhaps doesn't need a should_prepare equivalent since
>       there's no iteration and getting the gfn is just doing some math?
>     + In another patch series?

Agreed, separate series.

Thank you Ackerley!


/fuad

>
> > E.g. this?  There will still be a looming rename conflict, but that's easy enough
> > to handle.
> >
> > diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> > index 9ce5be7843f2..8aead0abd788 100644
> > --- virt/kvm/guest_memfd.c
> > +++ virt/kvm/guest_memfd.c
> > @@ -648,8 +648,8 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> >         return safe;
> >  }
> >
> > -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > -static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> > +#ifdef CONFIG_KVM_ARCH_GMEM_FREE_ON_SHARED_CONVERSION
> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
> >  {
> >         struct folio_batch fbatch;
> >         pgoff_t next = start;
> > @@ -681,7 +681,7 @@ static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> >         }
> >  }
> >  #else
> > -static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) { }
> >  #endif
> >
> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > @@ -729,7 +729,7 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >         kvm_gmem_invalidate_start(inode, start, end);
> >
> >         if (!to_private)
> > -               kvm_gmem_invalidate(inode, start, end);
> > +               kvm_gmem_make_shared(inode, start, end);
> >
> >         mas_store_prealloc(&mas, xa_mk_value(attrs));
