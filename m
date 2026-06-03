Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438C38B7B0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529358; cv=none; b=j9mRV/la+7dZhyOvsy46/Wu8cjBrYvJhcd+4uhEr9iB06PbUeqU2WDfzfgUOL8LKzgpjhgCp0p8HIqmd1HRJX16xbpq4sw+Qsn2wAHi4IGNu4v7S7u2J3h0UXqjh7pt726urUGkAEiZ2M2LLiImWJdMqIyvyDp7UXWiDfJ1Rc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529358; c=relaxed/simple;
	bh=1EwM9K/dFJXLqTPP7s4Oxg+UqsfTRVwjax+NCb2B6mI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8h+0Y++vg0D38ddxu/GMtl4bUHwwiTMkicexV/PTjtFpMR0omaUdqC3rrg75ULBnjXwAhEArGhlpr8KYtdTNdcMSPEqZ7F70LNQzQvlEOSTxHN9YwIqckt4OI0PbeAzqv9GffNmTK46TxIfV2OXl6ma3twa/++9Kt0W10DGqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxN6N5Hr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxN6N5Hr"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1dece2ecso1060055ad.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780529356; x=1781134156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9TAkhtRZEf2sqIn4AaIXqhnULFz6dUCOQHgczry4fc=;
        b=oxN6N5HrsOU9rXTakI+OJ6sFO3BJ6cV5fAAp4Qtw78q7LY+hMJq91gEjjQgBmJBdC7
         8Jjyppyl6A8GmG0UDrYkLzZDnni3nEHgba0C00aiQS4EEgkxIWj1Ki6qW7Oy7FQW5SLD
         gyOo/JeR46Oy3i6TtIBMarOVPMPg/ba2V8ta/MRoj7QngJaOwk2Ug7yP+0h1jqvQhsrG
         yRXV5y7mr5gK4EQMIyYOL/19kr4+KYrdItPtyk52i4DAsSSVFnywaS4xSNlGWVRVthD7
         GIQan4C644fJbqxy2Bmmrz3mPWHX3eOqr6C/eNR2YkrWDn3I5keD5mqQmw8fABxcp7t7
         zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780529356; x=1781134156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9TAkhtRZEf2sqIn4AaIXqhnULFz6dUCOQHgczry4fc=;
        b=ojd/gKB4A0O/kZio+KnHDtXIv8zMthYc4qEZwKRGWIHD2Qw0xjwDjalCw/H6iwEi7B
         CprsSr+PfkrSyC2xYj9N0kGXdT99t9RI/h+9uDMSZHNmry4IS/1fPuGP1PuNBjWpWZPY
         O0fy+RPUu86V6KNA8LuNLtmW2l7jY/cqGVob64jroMyIJXmhDh9G1NseIX2yKJl6DexE
         3GWbFbqCoeJu/gD5zYwJNNG/dmbtBMaPJUkxnFf41lds1ro2pixguMkR0bSlJNDAKwEM
         pmQPCH9H+Pg5sgcVG3wbxr5HoG/+lPnvJoap8Gmkc//LXgvdz7oX+2SRxQw04H1tKwN9
         demg==
X-Forwarded-Encrypted: i=1; AFNElJ+3MXPZR5T/yPm30rIBhZb9M3dBlI/puS8XPRtp6Ee1QluGSh+pRg1GLuTkrXRsUdZnV48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwsQQ0Xouk/r9EucDOJ4nFjD/oS+RZY2sQug/aYCGu0va96C7
	xUwHJcSTo8Yhu7ot9D+1XLsAYQ0/FnQA1ue5iCXAjadebsfVQYuGo7KNyrN68NKAQUf20APUmBf
	0rNzwgA==
X-Received: from pllk1.prod.google.com ([2002:a17:902:7601:b0:2c1:9d1:eeb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d592:b0:2c0:f807:56b2
 with SMTP id d9443c01a7336-2c1644ca2f2mr54951835ad.34.1780529355634; Wed, 03
 Jun 2026 16:29:15 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:29:14 -0700
In-Reply-To: <CAEvNRgGmyd1yqQXsnz5hWRZpBZUs=piEWbEaqP9+cz9ZqEMQ6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113232229.1698886-1-seanjc@google.com> <CAEvNRgGmyd1yqQXsnz5hWRZpBZUs=piEWbEaqP9+cz9ZqEMQ6g@mail.gmail.com>
Message-ID: <aiC4yp5dIpFXi89X@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 03, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Add more context and information to the comment in kvm_gmem_release() that
> > explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> > from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> > from slot->gmem.file")
> >
> >       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
> >          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
> >
> > is especially difficult to fully grok, particularly in light of commit
> > ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
> > gmem is dying"), which addressed a race between unbind() and release().
> >
> > No functional change intended.
> >
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  virt/kvm/guest_memfd.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index fdaea3422c30..2e09d7ec0cfc 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -338,17 +338,25 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
> >  	 * dereferencing the slot for existing bindings needs to be protected
> >  	 * against memslot updates, specifically so that unbind doesn't race
> >  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
> > -	 *
> > -	 * Since .release is called only when the reference count is zero,
> > -	 * after which file_ref_get() and get_file_active() fail,
> > -	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
> > -	 * file_ref_put() provides a full barrier, and get_file_active() the
> > -	 * matching acquire barrier.
> >  	 */
> >  	mutex_lock(&kvm->slots_lock);
> >
> >  	filemap_invalidate_lock(inode->i_mapping);
> >
> > +	/*
> > +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> > +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> > +	 * without the memslot first being deleted.  I.e. this relies on the
> > +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
> 
> Is this kvm_swap_active_memslots() referring not to swapping out of the
> deleted memslot, but swapping in of a new memslot?

No, it's the deletion that matters.  When doing an (S)RCU-protect pointer swap,
readers can see _either_ pointer (the old or the new).  I.e. when creating a new
memslot, synchronize_srcu_expedited() would only guarantee readers would see the
new slot *after* synchronization completes.

But that's not what we care about.  What we care about is that an in-flight
kvm_gmem_get_pfn() _can't_ reach the file for new, re-allocated memslot.  That's
guaranteed because deleting the old memslot waiting for readers to away, i.e.
guarantees that any readers that saw a non-NULL slot->gmem.file saw the one
associated with the old memslot.

> > +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> > +	 * grab a reference to slot->gmem.file even if the struct file object
> > +	 * is reallocated.
> > +	 *
> 
> I think the part that's missing for me is: why is synchronize_srcu()
> required after NULLifying memslot bindings? Normally, synchronize_srcu()
> will be needed after memslot updates to make sure the next user of
> kvm->srcu gets the new state of the memslots?
> 
> The "new state" here could be
> 
> 1. slot->gmem.file == NULL
> 2. slot->gmem.file == some new file, set after the old memslot was
>    replaced

Only because there's a synchronize_srcu().  Without that, it could be:

 1. slot->gmem.file == old  ==
 2. slot->gmem.file == NULL  |==> window for readers
 3. slot->gmem.file == new  ==

versus

 1. slot->gmem.file == old  ==
    synchronize_srcu()       |===> window for readers
 2. slot->gmem.file == NULL ==
    synchronize_srcu()       |===> window #2 for readers
 3. slot->gmem.file == new  ==
