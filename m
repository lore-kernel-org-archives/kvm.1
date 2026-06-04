Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578C846A
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531863; cv=none; b=kNol8pmMSEpUMfzwP61OOU18ZUc8/rrzjMhxLrMUUTfAnc4otkKnrdscHwRv5v/E6PrwrS+1l4VDzrAyb9IAg7hJXnChv1UiyXYdrGiQSNGX3KejBLnW/3XW1xKLyl73gQmC/D9/xFeQMEl8yiQ7sSekcho5VpZUlY3Rsx4tY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531863; c=relaxed/simple;
	bh=GUgFQ2BsUqHjN1g4nbfGyyyN1hSshdEo/h3zh3agJvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PqVorMuYsr8rKmUNOQrTSY749/+AtJoxWEzuubtAdklXtZMxPGLe1Yf5ruduNjZRm7w3HX3fEj1qGwW1A9I2HSQP7K/QI8mBpyoRuqij9ZZEMrVI5at+Z7atSwIO6iM1x/KoVi+MqbIqbIvYEeeQNe3n3hO4AZHh6cyoNuzaE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEnib/eW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEnib/eW"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso149871a91.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780531860; x=1781136660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/XvkxsxhXeJCUNEO0UQH4uZ86RTFHdFK5vp+kGsFc=;
        b=JEnib/eWQbBvCJ48MwTFmYAy4v1KHSQrb7OAkJxPMzbPZdSXkJf75lCNvnpkdpUuR1
         zFlhgYXf8+iMX1XcIFGOd+AlJB/BpkX9s+MTAgK/3xjKOdokLwWxHfANJortGAgykOXt
         d6WsYShld8QOkNt5Zvq8cNKW5UbegCSvtvA5khEBvWblGVfro4CXzfSJh1JLalOhcp+/
         fmzaPdBT+BcGEL1ablKu7iPx31nanMU0GCEwnACfQaSuP+LqN7Av/HFeeblkMqaYshQv
         AtgWY9xGTPdfyZF06VMd5W806YDkKk5LUJcvzAcdyee/oUQ4I+BWOw9a6cee1UQK36tA
         e9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531860; x=1781136660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/XvkxsxhXeJCUNEO0UQH4uZ86RTFHdFK5vp+kGsFc=;
        b=UQft2sTeJZGqYApHmTjtyRgHwHVLVmJ4t/JIyR5sbdH/DAOdn41PZWiAFrghsToxlU
         ILUxo8bBTd2XqijMsKeIZkA0ZZjLOlErESMY9R6bw4E3IDq8Xx7vCdPInahAWymy/4al
         R1ef0zPiGVf++VDKeaWHjeMuFYncf7+RT/BzW+0pZwOrYcJr2/9EJZql+B9IY7oIz5uF
         9wECMF6dBMSl0rccaGm0Tcrr5MQhTfVEK1g+QQJB/h0b2ul+C5HuQfjQbywlhN2AKNK2
         YRmoTO08pFRd3hMX8n15thMAsyCtbipNpNoAfd92Z9rhTbcfmUJePVG4EkNAjqvb/eEx
         XIuw==
X-Forwarded-Encrypted: i=1; AFNElJ+K5VRW7ijHeDeFf/1vFLK+b9ZZ/qFd9qc/Gf2GR84ZNR9uud+7dLDkXVaJEdhTUpB08Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrkX9QmQtggW2Jy+gRE4Xe32CMXD3GaakmtHcT8uf3peu1bbw
	MKCkjtQSvRGufFL0UfC9/EPriE3a+qmDZYeiWuWo/nEr9HxtsTmflh6l0pzftGUY5h9usNONlyf
	kbab/iw==
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:36b:a352:7fd2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2742:b0:36b:bec8:94cf
 with SMTP id 98e67ed59e1d1-36e2f9a2497mr5301833a91.9.1780531860385; Wed, 03
 Jun 2026 17:11:00 -0700 (PDT)
Date: Wed, 3 Jun 2026 17:10:59 -0700
In-Reply-To: <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113232229.1698886-1-seanjc@google.com> <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
Message-ID: <aiDCkz9V2aS5Qcuf@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 17, 2025, Yan Zhao wrote:
> On Thu, Nov 13, 2025 at 03:22:29PM -0800, Sean Christopherson wrote:
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
> As mentioned in commit ae431059e75d ("KVM: guest_memfd: Remove bindings on
> memslot deletion when gmem is dying"), unbind() and release() are mutually
> exclusive, i.e., both protected by slots_lock, mentioning "race" here is
> confusing. So, that commit addressed the mishandling in unbind() after
> kvm_gmem_get_file() returning NULL?

Yes, that's the race.  Just because two chunks of code are mutually exclusive
doesn't mean there's no race, it just changes the granularity of the race, and/or
how it manifests.

I consider it a race because in the failing case, there's simply no way for
release() and unbind() to run sequentially.  I.e. the only way to encounter the
bug was to run two operations concurrently, *and* for a specific ordering to
occur.

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
> 
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
> Do you mean that as kvm_gmem_get_pfn() can't find a stale slot, it can't grab
> reference to stale slot->gmem.file, even if slot->gmem.file has been set to a
> different value, i.e., after invoking unbind(), bind() ?

I was specifically trying to say this:

 1. slot->gmem.file == old  ==
    synchronize_srcu()       |===> window #1 for readers
 2. slot->gmem.file == NULL ==
    synchronize_srcu()       |===> window #2 for readers
 3. slot->gmem.file == new  ==

kvm_gmem_get_pfn() can run in two "windows".  In the window #1, it can see @old
or NULL.  In window #2, it can see NULL or @new.  The synchronization ensures
it can't grab a reference to @old once window #2 has been opened.

> But I'm not sure why to put the kvm_gmem_get_pfn() relying on
> synchronize_srcu_expedited() in kvm_swap_active_memslots() in the comment of
> release().  Without the guard of kvm_gmem_get_file(), kvm_gmem_get_pfn() may
> need to provide some RCU read-critial section too for release() to wait by
> synchronize_srcu()?

No, what I'm saying is that without synchronize_srcu() to create distinct
window #1 and window #2 above, KVM would need this:

diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index a1cb72e66288..e66e431bdb98 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -347,6 +347,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
        xa_for_each(&f->bindings, index, slot)
                WRITE_ONCE(slot->gmem.file, NULL);
 
+       synchronize_srcu();
+
        /*
         * All in-flight operations are gone and new bindings can be created.
         * Zap all SPTEs pointed at by this file.  Do not free the backing

Otherwise there is no guarantee in-flight readers can't reach the old
slot->gmem.file.
