Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3DB4A9D54
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998019; cv=none; b=NDWAEBR6dgNSQy27Z5cLCA0x0icHc5zNhbf8yUch2BHn3zwqx5ei6fdG6V7eyWdZZvRvstB+6hTOFwvO/r+9/WgL+Zbsd/znsDbnBvfcj6MQKwYRyJKcKr3llXfL7U5c/UAi/94xnPTOg73ABYS7X9hzUiOYvvJMh5N1rzyHdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998019; c=relaxed/simple;
	bh=/iK5tspmMe5BLiH9VQ8TvVl5j0mL+s0vIMp7F58jSuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmY6/iUfVFVF13psnX0HiiJbzePYOUkZvTJKyw1qLv6lhbrsvlvuN7qeNNBrP7OgM7Vj3bndE5k4bh8ekcKANQtez/0CwNnWU7CU1w1hxxxYHk0+e6ZMbyNysaKIQEVcQUO3l4tjeKqF+nEtboc4i1pLP6nCzSalZFEfwGt1TS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmRSnMid; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmRSnMid"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso5361976a91.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789998016; x=1790602816; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kha/TosCiMrk/VRiX69ZYAyIdODbozYl6Tc1z7Ph1q8=;
        b=LmRSnMidsXeVyWjAzek4Db7V0oNB8u3CsBS5DlBJMT1Bb3ppFCWbXB1k3kfrOB5tHp
         qHM4yElnzRDxipQXdR0RTYmguQmKXO4roj82Wc/kJ4YweVmml5vc7nU49yNC8bX9inoV
         DtO4tU3oRvc1HRUtJ8CEVGGG0ixaBApYGDJ46qlpMm8oNNYnf/v+9NEojNtw9outLNhn
         JK0Z8tG6xXmCwmsSlGnHrg3cRyiBOPZ4fVW8KtI3eUFK5Y9HcP8+jCTa+X/0NwAgJCMk
         r9681P23pdWAOfMpegi1gRfxTlkkbT2LpjfyYqKF1ewbefCU+LtvRoA5+lNC/UcS7YAW
         BhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998016; x=1790602816;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kha/TosCiMrk/VRiX69ZYAyIdODbozYl6Tc1z7Ph1q8=;
        b=DvpDOw2741ob/goEXKMHFEb0qemDA21b2/JfYFXaCEQDDoliuIXtRrD/i7DXmZtC7x
         gdzZcDFFHqsniJ98UpK1dqQ7bgExAXrK3plfVeetIAkETs3/DCIIUJ2GBGnk6UOcJ554
         +rWy2j+OuQBwj43NinyWzJznq8T/7VsMtUn8yDwTYBHrhXuNauN2jxVWTUpPJJng8rxo
         f8uIKZIKTCqPhu5Sdm1bWhH44VBeD6cJHmH3HTOfl8syUYzkWKWNlUon8iBJn1AbqLXa
         Zb6jTuiJQvpj8wmdA6zHJYcGKMdelytAlww/6HJiwRA1B3qcew2eqwTYox/2LjJdCB5m
         0+ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxoM12jRdeqTvZ+dgimiEYXdXwOfWebq/oVXtlCnV5NoQK4pOkJDnHfZPVjjqo499RY4k=@vger.kernel.org
X-Gm-Message-State: AFuF++khhmEJ0cELm3XNIqfPe7FlZuabq8HY8Zma5Nso42WK03/4LaKd
	bE0QrinEgmkeC+dVr3Nd4WQ/4dIqmsSytPVHUCPv/3CU8T/bm6py42kOr0rfQDwYULnX3I4TdXr
	SR/VWeA==
X-Received: from pjbmm23.prod.google.com ([2002:a17:90b:3597:b0:39e:6e02:bf60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e8:b0:39e:6c69:7774
 with SMTP id 98e67ed59e1d1-39e6c697961mr11605726a91.29.1789998015789; Mon, 21
 Sep 2026 06:40:15 -0700 (PDT)
Date: Mon, 21 Sep 2026 06:40:15 -0700
In-Reply-To: <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165647.769231-1-seanjc@google.com> <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
Message-ID: <arEzv8b2IMHYcHsZ@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Sep 20, 2026, Yan Zhao wrote:
> On Wed, Aug 26, 2026 at 09:56:47AM -0700, Sean Christopherson wrote:
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
> > See the extended on-list discussion[*] for more details about exactly what
> > KVM guards against, and how.
> > 
> > No functional change intended.
> > 
> > Link: https://lore.kernel.org/all/CAEvNRgGmyd1yqQXsnz5hWRZpBZUs%3DpiEWbEaqP9%2Bcz9ZqEMQ6g@mail.gmail.com [*]
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > 
> > v2: Explain how this all works in even gorier detail. [Yan]
> > 
> > v1: https://lore.kernel.org/all/20251113232229.1698886-1-seanjc@google.com
> > 
> >  virt/kvm/guest_memfd.c | 50 +++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 44 insertions(+), 6 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index b596486d184c..7f1c6a0f8039 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -300,17 +300,55 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
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
> > +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> > +	 * grab a reference to slot->gmem.file even if the struct file object
> > +	 * is reallocated.
> 
> Nit:
> 
> Do we need to update the code comment in __kvm_gmem_unbind() from
> 	/*
> 	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
> 	 * cannot see this memslot.
> 	 */
> to
> 	/*
> 	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() ensured
> 	 * that kvm_gmem_get_pfn() cannot see this memslot.
> 	 */
> 
> to align with the above comment.

How about this?  Because the "rule" is that kvm_gmem_unbind() can only be called
on a memslot that is unreachable, either by synchronizing SRCU after uninstalling
the memslot *or* because the memslot was never installed.  Simply stating that
synchronize_srcu_expedited() makes everything safe isn't the whole story, as it's
specifically synchronzing after removing/deleting/deactivating the slot that
makes this safe.

	/*
	 * Note, the caller is responsible for ensuring the slot is unreachable
	 * before unbinding, e.g. by synchronizing SRCU after deleting the slot.
	 */

> > +	 *
> > +	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
> > +	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
> > +	 * __get_file_rcu()) sees refcount==0 or fails the "file reloaded"
> > +	 * check (file != NULL due to nullifying the file pointer here).
> > +	 *
> > +	 * Unlike most other users of get_file_rcu(), where callers don't care
> > +	 * if they race with a write, only that they have a reference to _a_
> > +	 * live file, kvm_gmem_get_pfn() needs to get the exact file that is
> > +	 * associated with the memslot.  Without the aforementioned SRCU
> > +	 * synchronization, the following could happen:
> > +	 *
> > +	 *  CPU0				CPU1
> > +	 *  kvm_gmem_get_pfn()
> > +	 *    f = X (from slot->gmem.file)
> > +	 *					kvm_gmem_release())
> > +	 *					  slot->gmem.file = NULL
> > +	 *
> > +	 *					kvm_set_memory_region()
> > +	 *					  slot deleted
> > +	 *
> > +	 *					kvm_set_memory_region()
> > +	 *					  slot created
> > +	 *					  slot->gmem.file = f (alloc the same object)
> > +	 *
> > +	 *  get_file_active()
> > +	 *    file = f
> > +	 *    file_reloaded = f
> > +	 *
> > +	 * <KVM does weird things with an old memslot+file>
> > +	 *
> > +	 * Obviously KVM would be broken in many places if the synchronization
> > +	 * were omitted, but it's important to note that get_file_active() does
> > +	 * NOT guarantee a reference to the correct file was obtained, only
> > +	 * that the file doesn't point at a reallocated object.
> reallocated -> reloaded?

No, "reallocated" is correct.  From the comment for SLAB_TYPESAFE_BY_RCU:

  * This delays freeing the SLAB page by a grace period, it does _NOT_
  * delay object freeing. This means that if you do kmem_cache_free()
  * that memory location is free to be reused at any time. Thus it may
  * be possible to see another object there in the same RCU grace period.
  *
  * This feature only ensures the memory location backing the object
  * stays valid, the trick to using this is relying on an independent
  * object validation pass. Something like:
  *
  * ::
  *
  *  begin:
  *   rcu_read_lock();
  *   obj = lockless_lookup(key);
  *   if (obj) {
  *     if (!try_get_ref(obj)) // might fail for free objects
  *       rcu_read_unlock();
  *       goto begin;
  *
  *     if (obj->key != key) { // not the object we expected
  *       put_ref(obj);
  *       rcu_read_unlock();
  *       goto begin;
  *     }
  *   }
  *  rcu_read_unlock();

The above pseudocode is what get_file_active() is doing; it verifies the found
file ("obj" above) is the correct file.  Specifically, from __get_file_rcu():

	 * If the pointers don't match the file has been reallocated by
	 * SLAB_TYPESAFE_BY_RCU.
