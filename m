Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5502701B6
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969285; cv=none; b=LsoVFXBPk1Yn47saxVVVsxISBk5M6+ODzH2JFH5Ot4dPDdJWMkESyieJVIeKRy9lHsYMbtSOmVtJYXM+LC1jCJ8yAF1pHsKyvj6gbWFovamnw7PJcqB4j66Tgwwi6E5WrVaosNzwXXUmCeoUc0lvZtzjbjj6aqn/DnubV28nZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969285; c=relaxed/simple;
	bh=evEJ9Cv0ADapdlTZTbGnfQnGbAgrD+WBunpt2jAAuy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nTz94MvTA7u+fThTcWvU2e9bSR7sIyr+XfNJV3bjQpeHWY+uL+6hwQoszMof5iziiToTVP6UmZH0W8+PrQl0qkdnxNwJ3bWiSxJYeZRTYsVlC1AK5VzZ0ZtzOpmDt3qD7ivbKEzszq+InmAUsiuT2OLQNQpNP8FaugTviYeohYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n108n/np; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n108n/np"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so3717740a91.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780969284; x=1781574084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=48v5PxuBrwdarW691tZXx+UR0HGEgyClg2xzzbjeLY0=;
        b=n108n/npvwilrwMXzdF/1abX7rb54QODUrcW5WZBRzPXtwZEVVgZGD1G5XYBEtyP1T
         mwgynNIyZudAcvPrZ3RtiJDqfXjgfmufQsk6PrbCqgQKOWy2v94WQpiIMfk/ZULnopez
         GyMeBI8kX0xgMd9zJ8XbTsZldfx26xVfOkcjNtTZrc9VaR9ENmHcGrKPRcTv03Ah9OYo
         Hsu9Z0eNbWjKea3fIYpIWuR+kgVuWwwQS6V+KjD6bXtrg6KsGC9l9d4fy7nMHe1cIXSt
         DLLcaEwQbxGXCoyjxd+8BdT9Q9NMuVOqMZg0WVpn0z6XqeRo2TkcQJUxwUfEcfT2KgoE
         mzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780969284; x=1781574084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48v5PxuBrwdarW691tZXx+UR0HGEgyClg2xzzbjeLY0=;
        b=AvqLCZvxQxiOhv+oFaJw8OS6EkcQNW07cNkXF07LQhonDF2ZmB5W8Ph+MPKKtwjOUn
         E4pqV75ir5aPDA/+GngSp4j+s5HhBdJwa5vk19uR7BmwphKVkAcQjeD6Z8XYSaylXmwN
         wSbx2zsOeALtbNEC5AToGtt3e2ldpG4Re13gxZ8QquYnKQ2ygX2RSQ2Ok1b1MqBkmZji
         r8KMuNY2HgxY+lsdC2V2j7I66bHTySjiewl/i5PXpM/FbE4xqOrXUr2qiOwOYCVZar9b
         N7Tvplt4v0wJrbwz4EAR0fLg6TfGMjepHO0aYDIN2CaAOCLjAqO62/eN5sRLkd8MBLz5
         lzEA==
X-Forwarded-Encrypted: i=1; AFNElJ8c3p/1cXivZd4TeDaAYQUxhPE7zGAR1jobG1n7lM9e/MpxXvivaJDKXUhUB3OtLbZlMe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4RCfRdAc7tCvDQitODQ0n5QT5GjkMkPIMy25IxauNnz9pDgbM
	PgoA4kACC5HOWTqOisc8KCcd+Dc0ooLGFFnmOFsENuJnEsFKWpmAeBOYPeaIEucjQkOIIVKVIam
	kG8tTCg==
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:36b:8abb:86b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580e:b0:36b:944b:fd81
 with SMTP id 98e67ed59e1d1-370ee82e03amr18072580a91.4.1780969283938; Mon, 08
 Jun 2026 18:41:23 -0700 (PDT)
Date: Mon, 8 Jun 2026 18:41:23 -0700
In-Reply-To: <aiKJt5j6vIqfh7S9@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113232229.1698886-1-seanjc@google.com> <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <aiDCkz9V2aS5Qcuf@google.com> <aiKJt5j6vIqfh7S9@yzhao56-desk.sh.intel.com>
Message-ID: <aidvQyD6BqbE2_A5@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Yan Zhao wrote:
> On Wed, Jun 03, 2026 at 05:10:59PM -0700, Sean Christopherson wrote:
> > > > +	/*
> > > > +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> > > > +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> > > > +	 * without the memslot first being deleted.  I.e. this relies on the
> > > > +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
> > > > +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> > > > +	 * grab a reference to slot->gmem.file even if the struct file object
> > > > +	 * is reallocated.
> > > Do you mean that as kvm_gmem_get_pfn() can't find a stale slot, it can't grab
> > > reference to stale slot->gmem.file, even if slot->gmem.file has been set to a
> > > different value, i.e., after invoking unbind(), bind() ?
> > 
> > I was specifically trying to say this:
> > 
> >  1. slot->gmem.file == old  ==
> >     synchronize_srcu()       |===> window #1 for readers
> >  2. slot->gmem.file == NULL ==
> >     synchronize_srcu()       |===> window #2 for readers
> >  3. slot->gmem.file == new  ==
> > 
> > kvm_gmem_get_pfn() can run in two "windows".  In the window #1, it can see @old
> > or NULL.  In window #2, it can see NULL or @new.  The synchronization ensures
> > it can't grab a reference to @old once window #2 has been opened.
> Thanks for the clarification.
> 
> > > But I'm not sure why to put the kvm_gmem_get_pfn() relying on
> > > synchronize_srcu_expedited() in kvm_swap_active_memslots() in the comment of
> > > release().  Without the guard of kvm_gmem_get_file(), kvm_gmem_get_pfn() may
> > > need to provide some RCU read-critial section too for release() to wait by
> > > synchronize_srcu()?
> > 
> > No, what I'm saying is that without synchronize_srcu() to create distinct
> > window #1 and window #2 above, KVM would need this:
> > 
> > diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> > index a1cb72e66288..e66e431bdb98 100644
> > --- virt/kvm/guest_memfd.c
> > +++ virt/kvm/guest_memfd.c
> > @@ -347,6 +347,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
> >         xa_for_each(&f->bindings, index, slot)
> >                 WRITE_ONCE(slot->gmem.file, NULL);
> >  
> > +       synchronize_srcu();
> > +
> >         /*
> >          * All in-flight operations are gone and new bindings can be created.
> >          * Zap all SPTEs pointed at by this file.  Do not free the backing
> > 
> > Otherwise there is no guarantee in-flight readers can't reach the old
> > slot->gmem.file.
> Hmm, however, if the reader (kvm_gmem_get_pfn()) has grabbed a reference to @old,
> kvm_gmem_release() can't come; if kvm_gmem_release() comes, kvm_gmem_get_pfn()
> should not have been able to successfully invoke get_file_active() on @old.
> After kvm_gmem_release() returns, any subsequent calls to get_file_active() on
> @old should fail and return NULL.
> 
> So, even if the reader can see @old, we're still fine without synchronize_srcu(),
> as get_file_active() and SLAB_TYPESAFE_BY_RCU should have provide the safety.
> 
> Am I missing something? 

In kvm_gmem_get_pfn(), because slots_lock isn't held, this could happen if
kvm_set_memory_region() didn't synchronize_srcu().
 
  CPU0                                    CPU1
  kvm_gmem_get_pfn()                     
    f = X (from slot->gmem.file)

                                          kvm_gmem_release())
                                            slot->gmem.file = NULL

                                          kvm_set_memory_region()
                                            slot deleted

                                          kvm_set_memory_region()
                                            slot created
                                            slot->gmem.file = f (alloc the same object)

  get_file_active()
    file = f
    file_reloaded = f

  <KVM does weird things with an old memslot+file> 

Obviously KVM would be wildly broken for other reasons, but just saying
get_file_active() takes care of everything is misleading because it only handles
reallocation of the object, it doesn't guarantee a reference to the correct file
was obtained.

E.g. AFAICT, users of get_mm_exe_file() don't care if they race with
replace_mm_exe_file(), they only care that they have a reference to a live file.

KVM on the other hand cares that kvm_gmem_get_pfn() gets the exact file that is
associated with its memslot point.
