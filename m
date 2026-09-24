Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D013515FC
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277711; cv=none; b=nTGsQR7LMh2+qEjIlnyGRs4o9W6jLbFR8inuyO4Ch0rLyOvJo5km4RQWnGT8Mgu+2W7Dm6B6qZgx9UjP/+1vMmK6iJRGxdYyGiEb4qNVlVAgbwbLB6cbiYDPb8juYePW+Qz2F6EFpRnSjoTcFHs5iAq7gyX1SBSyLlH6Znnx3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277711; c=relaxed/simple;
	bh=PfO8Sq7IXAOz60LVt/tca74TacRB7+0yWjNBDzLLO9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ISLnaO4SRg7w6rCaE+1/GE7zkywbUj5p9fzvfe1TJnrfV+3KYATWEnJKOEmm83CTew7WEDW/iaympYlmv6wy9Plxi/wJPGJUIthCMketNrXYnU67HLkU14VGHiOfb85vDvj7VHVmlHuWWLHll0djFtjMmQ6eX5iVBp/OVOG+Nlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnQaWNDe; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnQaWNDe"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6df0a1e18so968085ad.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790277706; x=1790882506; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxZ5y/LhcF5KpWYDQexjS+jc6SBuDbvkLh6zxVIRYEk=;
        b=XnQaWNDeB5gd0TzNYlMLMSbb5h8GJIWWGclQjH7Dz6j0BcWp/Wh3f2GKOUx4h6u8Kw
         NuJ2cUtgdz25YM4JqxoxPS5kd6bKR0pAz7H440U2u0ndjgBHnZf+h3xJcOBKamkqnWOr
         7w5eea5MWTRgcMZK55DnhzPt7TimlS0q43f0MJ2F6EmmwHsrDuYrBj1k/fUaqXnB/rmT
         rBYGCEYnTw2xQVwSdxutj0ylOAOzfTZuv7xldovChVed7to+CsSIFwfZEA1vVs17XMx/
         INAJkksOZlg/eTqBWsV+0Vwx96AnZmwBxczvhJ728H9ydLxyXHcwOXyFbQerM3ZhzDsn
         J9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277706; x=1790882506;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxZ5y/LhcF5KpWYDQexjS+jc6SBuDbvkLh6zxVIRYEk=;
        b=14P12sXShfrRYraLEzIDkzhOLDHF0poxqu3nYyqQTWNAwBA4lMXSWDvlO0m7Hlww5Q
         AOHBm7O7dwkbQ+jNBeDLl6J0Pbvnw24dyjUtEIHF6og7mGePdtUzUtd5nSC4w6AEfRwL
         x/+waq/lf079++Yrqz6hCdan5SLfxNYjgcdhGGkh7qxAt0dLH5yoYi93XIvhCq6tT4Vk
         VGmCBUYRqYzEPejtrssYWAkGervOIA0ScLbkELq6gg28SU2HoaL03nELsTWigAuXFexi
         vBOHA+D4ruYjI0f40V40n1p0lRlMZSC38u+OJ9zjy089bvm78kZmtHOGcKNTNcEV3QOP
         jM6g==
X-Forwarded-Encrypted: i=1; AKwUvBxi6sl1+9a8Qb1sB6VUVmgRoslL5Af7+lkA+Q8Db93lLFUsTUm0EHnoGVgGbPoo9hxsdLM=@vger.kernel.org
X-Gm-Message-State: AFuF++lckVkCCifeVllDSY/FIgRRJKJPdXO59BU3egCg2aRjlB9MzDUO
	guX+ro6RqdVmXlMlZ9rKFRe2DL2VN2v/tUnkuzL7cgSfZ+n8SRKDK30E0Wd6SJIhALtMA8FviYK
	++HeKTw==
X-Received: from plmg19.prod.google.com ([2002:a17:903:3cd3:b0:2df:5f56:47fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d582:b0:2dd:c100:7cbe
 with SMTP id d9443c01a7336-2df7dc5b18fmr27549835ad.58.1790277706233; Thu, 24
 Sep 2026 12:21:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:21:45 -0700
In-Reply-To: <CAEvNRgH6w_a9+2rOr6r+47JqWc+-8cHq=c7r76nYG2i5deOxSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com> <20260922001332.1121266-5-seanjc@google.com>
 <CAEvNRgH6w_a9+2rOr6r+47JqWc+-8cHq=c7r76nYG2i5deOxSg@mail.gmail.com>
Message-ID: <arV4SS8FHwd6Qjs1@google.com>
Subject: Re: [PATCH v5 4/6] KVM: guest_memfd: Split bind() into
 prepare()+commit() phases
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>, 
	Dennis Tighe <dtighe@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 24, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> The gifting seems a bit asymmetric to me. For gmem bindings, always getting a
> ref on the file and always dropping would be more symmetric.

It's definitely asymmetric, but lack of symmetry isn't inherently bad.  I do
agree that the code isn't the prettiest, but for me the asymmetry itself doesn't
really bother me.
 
> Now that there is a commit stage, explicitly not taking a ref
> on the file in the committing stage is clearer imo.
> 
> If you'd like to stack the above refactoring as a patch after [5/6],
> here's my suggestion:

...

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 90461880ff854..e783d0ee4cf9d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2019,6 +2019,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  	struct kvm_memslots *slots;
>  	enum kvm_mr_change change;
>  	unsigned long npages;
> +	struct file *file = NULL;
>  	gfn_t base_gfn;
>  	int as_id, id;
>  	int r;
> @@ -2126,7 +2127,13 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  	new->flags = mem->flags;
>  	new->userspace_addr = mem->userspace_addr;
>  	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
> -		r = kvm_gmem_prepare_memory_region(kvm, new, mem->guest_memfd,
> +		file = fget(mem->guest_memfd);
> +		if (!file) {
> +			r = -EBADF;
> +			goto out;
> +		}
> +
> +		r = kvm_gmem_prepare_memory_region(kvm, new, file,
>  						   mem->guest_memfd_offset);

I agree with pretty much all of your points, and I actually like many aspects of
this, but I don't love passing in the file pointer.  I don't hate it either, it
just feels too much like the responsibilities of preparing the gmem aspects of
the memslot are being split between core KVM and guest_memfd.

E.g. if kvm_set_memory_region() grabs the file pointer, then it's weird not having
it also set slot->gmem.file.  But then if we set slot->gmem.file, not setting
slot->gmem.pgoff feels weird.  I also don't like that it becomes difficult to see
that the file pointer is getting stashed in the memslot, e.g. begs the question of
"what are we doing with this file?".

Huh.  Ok.  I *was* going to say that my vote would be to make the "gift" more
explicit, by returning the file, to avoid splitting responsibilities while making
the code more obvious and less ugly, e.g.:

	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
		gmem_file = kvm_gmem_prepare_memory_region(kvm, new, change,
							   mem->guest_memfd,
							   mem->guest_memfd_offset);
		if (IS_ERR(gmem_file)) {
			r = PTR_ERR(gmem_file);
			goto out;
		}
	} else {
		gmem_file = NULL;
	}

	r = kvm_set_memslot(kvm, old, new, change);

	/*
	 * Drop the reference to the gmem file, even on success.  The file pins
	 * KVM, not the other way 'round.  Active bindings are invalidated if
	 * the file is closed before memslots are destroyed.
	 */
	if (gmem_file)
		fput(gmem_file);

But after fiddling with this for an hour or so, I realized that if we fully commit
to configuring new.gmem in kvm_set_memory_region(), then we can move the prepare()
call into kvm_prepare_memory_region() without needing to plumb extra parameters,
and make the gmem stuff look a lot more like the rest of the memslot code.  E.g.

	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
#ifdef CONFIG_KVM_GUEST_MEMFD
		new->gmem.file = fget(mem->guest_memfd);
		if (!new->gmem.file) {
			r = -EBADF;
			goto out;
		}

		new->gmem.pgoff = mem->guest_memfd_offset >> PAGE_SHIFT;
#endif
	}

	r = kvm_set_memslot(kvm, old, new, change);

	/*
	 * Drop the reference to the gmem file, even on success.  The file pins
	 * KVM, not the other way 'round.  Active bindings are invalidated if
	 * the file is closed before memslots are destroyed.
	 */
#ifdef CONFIG_KVM_GUEST_MEMFD
	if (new->gmem.file)
		fput(new->gmem.file);
#endif

Not being able to get rid of the #ifdefs is a shame, but from a control flow
perspective, this feels more right than anything else.  Full diff (not fully
tested, and would need to be split into 3+ patches):

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index a13445c26d9d..d1e502d3246b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1003,73 +1003,61 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
-int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
-				   unsigned int fd, uoff_t offset)
+int kvm_gmem_prepare_memory_region(struct kvm *kvm,
+				   const struct kvm_memory_slot *old,
+				   struct kvm_memory_slot *new,
+				   enum kvm_mr_change change)
 {
-	uoff_t size = slot->npages << PAGE_SHIFT;
 	struct gmem_file *f;
 	struct inode *inode;
-	struct file *file;
 
+	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(new->gmem.pgoff));
 
-	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
-	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
-
-	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
+	if (WARN_ON_ONCE(change != KVM_MR_CREATE))
 		return -EINVAL;
 
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
+	if (WARN_ON_ONCE(new->flags & KVM_MEMSLOT_GMEM_ONLY))
+		return -EINVAL;
 
-	if (file->f_op != &kvm_gmem_fops)
-		goto err;
+	if (new->gmem.file->f_op != &kvm_gmem_fops)
+		return -EINVAL;
 
-	f = file->private_data;
+	f = new->gmem.file->private_data;
 	if (f->kvm != kvm)
-		goto err;
+		return -EINVAL;
 
-	inode = file_inode(file);
+	inode = file_inode(new->gmem.file);
 
-	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
-		goto err;
+	if (new->gmem.pgoff + new->npages  > i_size_read(inode) >> PAGE_SHIFT)
+		return -EINVAL;
 
 	/*
 	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
 	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
 	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
-	slot->gmem.file = file;
-	slot->gmem.pgoff = offset >> PAGE_SHIFT;
 	if (gmem_in_place_conversion || kvm_gmem_supports_mmap(inode))
-		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
+		new->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	/*
-	 * Gift the caller a reference to the file.  The reference will be
-	 * dropped after bindings are established, or if installing the new
-	 * memslot ultimately fails.
-	 */
 	return 0;
-
-err:
-	fput(file);
-	return -EINVAL;
 }
 
-int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot)
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
+				  struct kvm_memory_slot *new,
+				  enum kvm_mr_change change)
 {
-	struct gmem_file *f = slot->gmem.file->private_data;
-	struct inode *inode = file_inode(slot->gmem.file);
+	struct gmem_file *f = new->gmem.file->private_data;
+	struct inode *inode = file_inode(new->gmem.file);
 	unsigned long start, end;
 	int r;
 
-	if (WARN_ON_ONCE(slot->gmem.file->f_op != &kvm_gmem_fops))
+	if (WARN_ON_ONCE(new->gmem.file->f_op != &kvm_gmem_fops))
 		return -EIO;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	start = slot->gmem.pgoff;
-	end = start + slot->npages;
+	start = new->gmem.pgoff;
+	end = start + new->npages;
 
 	if (!xa_empty(&f->bindings) &&
 	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
@@ -1077,7 +1065,7 @@ int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot)
 		return -EEXIST;
 	}
 
-	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
+	r = xa_err(xa_store_range(&f->bindings, start, end - 1, new, GFP_KERNEL));
 	if (r)
 		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
 
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index 01bd359d27e3..63723ffee0a5 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -8,9 +8,13 @@
 int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
-int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
-				   unsigned int fd, uoff_t offset);
-int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot);
+int kvm_gmem_prepare_memory_region(struct kvm *kvm,
+				   const struct kvm_memory_slot *old,
+				   struct kvm_memory_slot *new,
+				   enum kvm_mr_change change);
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
+				  struct kvm_memory_slot *new,
+				  enum kvm_mr_change change);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -20,15 +24,18 @@ static inline int kvm_gmem_init(struct module *module)
 static inline void kvm_gmem_exit(void) {};
 
 static inline int kvm_gmem_prepare_memory_region(struct kvm *kvm,
-						 struct kvm_memory_slot *slot,
-						 unsigned int fd, uoff_t offset)
+						 const struct kvm_memory_slot *old,
+						 struct kvm_memory_slot *new,
+						 enum kvm_mr_change change)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;
 }
 
 static inline int kvm_gmem_commit_memory_region(struct kvm *kvm,
-						struct kvm_memory_slot *slot)
+						struct kvm_memory_slot *old,
+						struct kvm_memory_slot *new,
+						enum kvm_mr_change change)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9fff2f4bf2f1..70d70042a9ce 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1681,6 +1681,12 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 {
 	int r;
 
+	if (new && (new->flags & KVM_MEM_GUEST_MEMFD)) {
+		r = kvm_gmem_prepare_memory_region(kvm, old, new, change);
+		if (r)
+			return r;
+	}
+
 	/*
 	 * If dirty logging is disabled, nullify the bitmap; the old bitmap
 	 * will be freed on "commit".  If logging is enabled in both old and
@@ -1952,8 +1958,8 @@ static int kvm_set_memslot(struct kvm *kvm,
 	if (r)
 		goto err;
 
-	if (change == KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
-		r = kvm_gmem_commit_memory_region(kvm, new);
+	if (new && (new->flags & KVM_MEM_GUEST_MEMFD)) {
+		r = kvm_gmem_commit_memory_region(kvm, old, new, change);
 		if (r) {
 			kvm_arch_free_memslot(kvm, new);
 			kvm_destroy_dirty_bitmap(new);
@@ -2133,11 +2139,16 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
-		r = kvm_gmem_prepare_memory_region(kvm, new, mem->guest_memfd,
-						   mem->guest_memfd_offset);
-		if (r)
+	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
+#ifdef CONFIG_KVM_GUEST_MEMFD
+		new->gmem.file = fget(mem->guest_memfd);
+		if (!new->gmem.file) {
+			r = -EBADF;
 			goto out;
+		}
+
+		new->gmem.pgoff = mem->guest_memfd_offset >> PAGE_SHIFT;
+#endif
 	}
 
 	r = kvm_set_memslot(kvm, old, new, change);
@@ -2148,7 +2159,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	 * the file is closed before memslots are destroyed.
 	 */
 #ifdef CONFIG_KVM_GUEST_MEMFD
-	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
+	if (new->gmem.file)
 		fput(new->gmem.file);
 #endif
