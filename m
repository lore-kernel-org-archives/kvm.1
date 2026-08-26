Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FC3A874B
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769376; cv=none; b=H41sSvPwuLAcIqk7gTawH/0c9C/SOGg7MBOttJJPxewH6kQsx1OWFz9Q899yzix8RK91SONtVu8NKmoMDcMV+HGrNyinPdJ2E0YAFTRbe1EmONHKhZOC5zFYulcvh2DqFHOQZ9Ww5tioQp2dy1gyxu/3qRfb4CBeH48jDtbD+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769376; c=relaxed/simple;
	bh=XmRgFxnssCa/NMxFYU0vyhZ0ZtzDJbIT3aLWUknj6vc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=suXI+MyqiEWjnG6NHzX+80wevpP2It5TNX1bkG084rAFbVa28c4NRyr//MgpnuLQnlaLmfyQw8Oo4ZeONF0vs2J4OHSlQiaN7V6DwLLORSAy7n4o9hmkRUzrDC8ch7cmmY66knJ7M4FalRddslS+RHvkU4HmyDeIBnTAaOQ9wXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAaskQO6; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAaskQO6"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1a439db36so1465501a12.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787769364; x=1788374164; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUsJXArdjHCp7I2TiQoIKYOSCAzkeNjkQvWi8w0K0Xg=;
        b=jAaskQO6DYVOnffwjKZkxiiw7Dw6I42NeChvoLfIHtp4/uuZOrJp0VokxewRO2oO58
         B9+ZxXZlZpwVELMiqJODGnEvtkTDzVZ6MVUn5CX295eaPrjCrz97Bu2y+669xwTPg7Ud
         ZIOJ3SsXhEgiu2OsfdOXlSw+bqiXwvaxJ+AZcCyz+uretnkhrae4nJpQ1ZMOg60Ztaz2
         7kWNbaA/V2h1Bu38eZ+Hq0kYygjalOU01g8v8lMzgQGDlwr0gvWhjmISE+gE8XJRWsP2
         YetJyjqL7cpypxzPPCaqCD90d5NwsegqiUlQG5lKjIHQKwc0PRB25SzvskCXaqTtaeCL
         Wv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787769364; x=1788374164;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUsJXArdjHCp7I2TiQoIKYOSCAzkeNjkQvWi8w0K0Xg=;
        b=d0bXLO7nsAeesKzOxQ7iPNw284uTSZQ/IMHlhYnY99hvzRyTN3uN8gDYukeP5wiAmr
         JpTmtqPYepaNeLztg+mfRfTX0y1wkoVzQzmSva0affGK6cR4kxfiB2LGtl3/qcv17odZ
         llPG5pkoD9s/Xbqe0foLQGMSabelrvl6eW6blTykbPPNOtdck3ZZ+zBpgk4OHAKme1uP
         aNmJ8H7EHIRvIygb0x5i3b9K0F3oYKHyvty7+f1BMEx91Kg65F1VMUKt505cV85202Mn
         /YbGrRB3WC65ToVIHi9BbQh4DWwWAHYwBNiqNX6fyvn31TIj6I4xlhbX99JBzy4w4AQb
         qcQg==
X-Gm-Message-State: AFuF++n86/Z6SznXNgBadyFBTI9JCkvxxTU/84I8OkAVp7Xo+AI4Y9vk
	THThNjK/6I7KZ6Wg9fcWqjSgIy8qcRfX1+zJsdDBElXkMaRLstdmCKcUxLduJJK7k3QTxrbSabh
	iy0blHQ==
X-Received: from pgcp24.prod.google.com ([2002:a63:7418:0:b0:cc1:5ec7:8f7b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44ca:b0:84f:77cc:63cd
 with SMTP id d2e1a72fcca58-853757b9231mr17349081b3a.17.1787769363830; Wed, 26
 Aug 2026 11:36:03 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:36:03 -0700
In-Reply-To: <20260826170551.BEF801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165154.766699-1-seanjc@google.com> <20260826165154.766699-3-seanjc@google.com>
 <20260826170551.BEF801F000E9@smtp.kernel.org>
Message-ID: <ao8yE-g5L9IzwwND@google.com>
Subject: Re: [PATCH 2/2] KVM: guest_memfd: Drop superfluous WRITE_ONCE() when
 binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 1ef9e29164237..1d2de9a1bc3f0 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -653,7 +653,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
> >  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
> >  	 */
> 
> [Severity: High]
> This is a pre-existing issue, but is the new memslot actually completely
> invisible here?
> 
> In virt/kvm/kvm_main.c:kvm_set_memory_region(), the new memslot is bound and
> published to guest_memfd before its architecture metadata is prepared:
> 
> 	r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
> 
> When virt/kvm/guest_memfd.c:kvm_gmem_bind() executes, it inserts the partially
> initialized memslot into the bindings xarray and drops the lock:
> 
> 	xar = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> 
> If userspace concurrently issues a FALLOC_FL_PUNCH_HOLE on the guest_memfd with
> an offset greater than the memslot's offset, it can acquire the lock, iterate
> over f->bindings, and find this uninitialized memslot. This triggers an MMU
> invalidation over the uninitialized memslot:
> 
> virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_start() {
>     ...
> 	flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
>     ...
> }
> 
> On x86 with rmaps, gfn_to_rmap() will perform pointer arithmetic on the
> unallocated slot->arch.rmap (which is NULL), yielding an invalid non-NULL
> pointer. This bypasses the NULL check in slot_rmap_walk_okay() and causes
> a kernel panic in kvm_zap_rmap().
> 
> Does this race condition allow a concurrent hole punch to dereference an invalid
> pointer?

Fuuuuudge.  Sashiko is right, the slot is reachable as soon as it's stored in
the binding.  I've fiddled with a few ideas, and they're all awful.  Ok, that's
not entirely true.  Moving the call to kvm_gmem_bind() into kvm_set_memslot() is
very doable, I'm just annoyed that the aesthetically pleasing prototype for
kvm_set_memslot() gets polluted with gmem parameters. :-/

AFAICT, binding after the memslot is prepared is the only sane option.  Because
memslots are protected by SRCU, it's simply not possible to ensure readers can't
see half-baked state if the binding is established before the memslot is fully
prepared.

And if the slot is committed before bindings are established, then PUNCH_HOLE
won't zap SPTEs created between the slot being reachable and the bindings being
established.  That, and KVM has a ton of code that assumes kvm_commit_memory_region()
occurs after the point of no return, i.e. unwinding the commit is a non-starter.

I think this would work?  Compile-tested only.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..19b50be4fe20 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1887,7 +1887,8 @@ static void kvm_update_flags_memslot(struct kvm *kvm,
 static int kvm_set_memslot(struct kvm *kvm,
 			   struct kvm_memory_slot *old,
 			   struct kvm_memory_slot *new,
-			   enum kvm_mr_change change)
+			   enum kvm_mr_change change,
+			   unsigned int gmem_fd, uoff_t gmem_offset)
 {
 	struct kvm_memory_slot *invalid_slot;
 	int r;
@@ -1931,20 +1932,16 @@ static int kvm_set_memslot(struct kvm *kvm,
 	}
 
 	r = kvm_prepare_memory_region(kvm, old, new, change);
-	if (r) {
-		/*
-		 * For DELETE/MOVE, revert the above INVALID change.  No
-		 * modifications required since the original slot was preserved
-		 * in the inactive slots.  Changing the active memslots also
-		 * release slots_arch_lock.
-		 */
-		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-			kvm_activate_memslot(kvm, invalid_slot, old);
-			kfree(invalid_slot);
-		} else {
-			mutex_unlock(&kvm->slots_arch_lock);
-		}
-		return r;
+	if (r)
+		goto err;
+
+	if (new && new->flags & KVM_MEM_GUEST_MEMFD) {
+		if (WARN_ON_ONCE(change != KVM_MR_CREATE))
+			goto err;
+
+		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
+		if (r)
+			goto err;
 	}
 
 	/*
@@ -1977,6 +1974,20 @@ static int kvm_set_memslot(struct kvm *kvm,
 	kvm_commit_memory_region(kvm, old, new, change);
 
 	return 0;
+
+err:
+	/*
+	 * For DELETE/MOVE, revert the above INVALID change.  No modifications
+	 * required since the original slot was preserved in the inactive slots.
+	 * Changing the active memslots also release slots_arch_lock.
+	 */
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
+		kvm_activate_memslot(kvm, invalid_slot, old);
+		kfree(invalid_slot);
+	} else {
+		mutex_unlock(&kvm->slots_arch_lock);
+	}
+	return r;
 }
 
 static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
@@ -2058,7 +2069,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 		if (WARN_ON_ONCE(kvm->nr_memslot_pages < old->npages))
 			return -EIO;
 
-		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE);
+		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE, -1, 0);
 	}
 
 	base_gfn = (mem->guest_phys_addr >> PAGE_SHIFT);
@@ -2105,21 +2116,14 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
-		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
-		if (r)
-			goto out;
-	}
 
-	r = kvm_set_memslot(kvm, old, new, change);
+	r = kvm_set_memslot(kvm, old, new, change,
+			    mem->guest_memfd, mem->guest_memfd_offset);
 	if (r)
-		goto out_unbind;
+		goto out;
 
 	return 0;
 
-out_unbind:
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
-		kvm_gmem_unbind(new);
 out:
 	kfree(new);
 	return r;
