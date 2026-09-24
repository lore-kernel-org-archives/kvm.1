Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A74CC261
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281090; cv=pass; b=IcED1ZTVWdAzJeI52/+/AMmThZaeHQwUtpGorf9MCmeOGUJyer/mAdF8EcwQRyFllgIXuoX3Eh4ywGDMpmdxVjmpSza2Nzxll3AiXVGqbnHn/H3bC15e2wGdSTaZL9HBzqSLdz8fNVBaoUpW0khOkiaecJ1nsa1QXWARdlWlDVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281090; c=relaxed/simple;
	bh=WCw2gn45vII84Ocx/eT6cFc0z1dFWIpvLNO16qTGocA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1wecAE+02ANvs6I5GVFCPEXrLR8uHXMyWp3koT9/q2vJSm8O13M1gY3LrAhV5kT5FxV3ocWrpSmoE9MAD5+WRxoxOVQnVPSMkrGJFRAgNsiZGhEZpksjGF5T5FjNE05qRwUYW3lg3LZ3Hgp8i2vGsNv+cGVGBUf6ncgVS+2/Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wDivcwHP; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDivcwHP"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so2002531cf.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 13:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790281085; cv=none;
        d=google.com; s=arc-20260327;
        b=alsBAXt6eiv7vXsVw59XljUDzUdswjyvY+YHbxFt7UWyowzFTqMmeVhw3q+C8aH+e6
         bAYjlZ1juBW7r3IiZuMdB8EVAw0NipkrlmCb3Kmgc3P8Nimp5iw00L5WvarbjxvuB4tI
         e6vp3VGQ5VnmgMwNH0GzkAjEsv8h7jrvo4ilkj8jhnTHiQ7nlTdH4AKX3Yw24BU7a8m/
         TxCy4qkovsigIlDr8z0Be0XCZDuUpccRcmBLzb2z3wYg8rvBAwMhP0RspZBV/PoAKQCm
         pzqxGnUe5T235LbMPsyb/j00lN2EVxIdwZYJG2pLX0uMlVrw+7+3dM0875aPjsy9g/l1
         7zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QBGVgj+tythBrBi/PqergSuSJVxrTXUmcS2GUJvv1eI=;
        fh=OhqIabOBJlujU/6tUMFlfNiJ1i7n01CcSuZP7zbZq0U=;
        b=KH2xwlERN5aALskktahGscdVz1BHa4h5Lvju9cBE21fX0cTySFv5MZ7CuxiIGBg8sD
         2/7xR/T13ksWz7uCj81e7JF0SxOr4JyVnCY1labaO08qANTR+NSOORK5rNaxVTHiSd4C
         sa68/5pKITY/m6yN+9p6UimOtbyTjE+No+yUlST0YSYc/Blt0oM6Z1hZY1EmdqTKlJ6g
         Sx1FIxqN6OyLgwcnyxXXfKRSJtt0EC+L09JJxmpFVHVUbBciNTSrFrw7defCH1FGl1ia
         6M5yQufWIgI/BalToNZVrh+URL6r1jeEbM2XUB3LNcsNXVd/mdJ5kBrBRtHAYtjXZ44T
         Txxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790281085; x=1790885885; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBGVgj+tythBrBi/PqergSuSJVxrTXUmcS2GUJvv1eI=;
        b=wDivcwHPGPOlde58g2OSXn4TN2lo24ZZMq0FUqlvYmE5qUKx4Iu1ecDl1uhHAtpqcx
         qhzIuyLp+FSAGRU6QeFvOcPNp6ya5HEO1hm2ntfNk7Bkh8DVk/4ZapA29UDOAuKk3Bip
         n1L8UYrf8X21RhIZktqoedu1ItF1NE+6y4fts4mcao7HWO8oG/HcboQssa5imUSuYZwn
         hxanAa4x4vElMoQCclcz+bx5epPaQJAiABFvjCXTF0oGAFSV1Nog7vATz86Z4vs3jjY8
         fch3WOBSHY7lR2NDqxjiHhXrjjrjtIHxKQfOSeASpdS1Hc+0JJipQegnUF6hQm8LMnWH
         z1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281085; x=1790885885;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBGVgj+tythBrBi/PqergSuSJVxrTXUmcS2GUJvv1eI=;
        b=Dxc5X+37rybqmKAD8zEj0pAQwBonQzgpj8dSCRovv1Z31n1kkMYbxrS31nt9dEpKz5
         Y9gYa+DzNiAfDRO3K6Kwy9V7G9STDlnTIHD05KG54MWkKQxhG1uHlXcxdQ0IjogiYIFh
         IsM64IL0wuoLaunbIYaM8DZEwO+O269GLgi0tqy7qkos3luLql4Lcf6GlEpyc/I0ivCy
         fkBdUvkiViarqj5NqsZpqt+MPp7pClU1ku+iD3cTr5rWJCpMA2rSfZozgNz7VnMGMqsB
         +RsV68/a+oQXxjQ28ZgTWkZG+DrfIIRd8QN8EsHHr71kC/5WQzcooiLK5L1CAWqZ/ppw
         K5VQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQr5U4o0fvpaOfASNoEIuRb49HE/mfU4Mj9c28H6qPhBxlOQTPnHGseVUxCDMiGfgPu9g=@vger.kernel.org
X-Gm-Message-State: AFuF++kzj1oPBFZ4M/FtgEOf7WdUe1HTD/axGZK2VrP6u2q5g6dYBDH5
	dcWSRP2b19f+dkon96stf+n6DRqJxpRD6af8dGToSezOUh+HeNyeNK2vsXPEPfplMQY3jFrB84z
	xoktm1aKA2ogVNbDMOiar3kvPDdp2FRRflmMsQwd2
X-Gm-Gg: AYBFou3dyGLTXpo6BKi3dQvglJ61Kgv+ag0MtAKsL7OE5ocaHuL7+hbQPe1LkWPw2pv
	DLAbgK3H0VYmmDGtp7msr2tlxvVBTqJ+CGZxFYZdONcwfJkaH3CwZGwYC1Ph7wFOvCeKK2CXU6n
	+NGoxyEPJgkfj3AldNZJyf+xcNDAYLdQymr/bawDlOCIzxXUMeBEQP5WZ/1gJ4ns+OPOdh0ciay
	93Wiw35NGLjH5Za8jgr0FC+Ubkb0nyGykdnjupIFYv12Y6fYNL5Dh9chiUnWnf/dDN2POanBh8Z
	5W/uby2FIY36qoxp27+CWp4DYyzMQhGFd3jMNeFsUCcxYM2yUHjslN1sCFY4B5NIoab4wTLVw7m
	ALm1rVTVmcyaxOAbGHkyTSR6QeYcmlQlYCDNaWVbS
X-Received: by 2002:a05:622a:1929:b0:530:39f3:6c97 with SMTP id
 d75a77b69052e-5330b5d9cabmr8005731cf.23.1790281084603; Thu, 24 Sep 2026
 13:18:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 13:18:03 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 13:18:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <arV4SS8FHwd6Qjs1@google.com>
References: <20260922001332.1121266-1-seanjc@google.com> <20260922001332.1121266-5-seanjc@google.com>
 <CAEvNRgH6w_a9+2rOr6r+47JqWc+-8cHq=c7r76nYG2i5deOxSg@mail.gmail.com> <arV4SS8FHwd6Qjs1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 13:18:03 -0700
X-Gm-Features: AclHuK8uuzVx5nBkZDbrNNnKgfjVlHqa2a8lnAuZN2pbSVnhV_1XJvg71mB7VzU
Message-ID: <CAEvNRgGvCha=jc0TW9RcTN79xhM61kW-tjrGsy+MxUv1sE7cKQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] KVM: guest_memfd: Split bind() into
 prepare()+commit() phases
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>, 
	Dennis Tighe <dtighe@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index a13445c26d9d..d1e502d3246b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1003,73 +1003,61 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  	return __kvm_gmem_create(kvm, size, flags);
>  }
>
> -int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
> -				   unsigned int fd, uoff_t offset)
> +int kvm_gmem_prepare_memory_region(struct kvm *kvm,
> +				   const struct kvm_memory_slot *old,
> +				   struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change)
>  {
> -	uoff_t size = slot->npages << PAGE_SHIFT;
>  	struct gmem_file *f;
>  	struct inode *inode;
> -	struct file *file;
>
> +	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(new->gmem.pgoff));
>
> -	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
> -	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
> -
> -	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
> +	if (WARN_ON_ONCE(change != KVM_MR_CREATE))
>  		return -EINVAL;
>
> -	file = fget(fd);
> -	if (!file)
> -		return -EBADF;
> +	if (WARN_ON_ONCE(new->flags & KVM_MEMSLOT_GMEM_ONLY))
> +		return -EINVAL;
>
> -	if (file->f_op != &kvm_gmem_fops)
> -		goto err;
> +	if (new->gmem.file->f_op != &kvm_gmem_fops)
> +		return -EINVAL;
>
> -	f = file->private_data;
> +	f = new->gmem.file->private_data;
>  	if (f->kvm != kvm)
> -		goto err;
> +		return -EINVAL;
>
> -	inode = file_inode(file);
> +	inode = file_inode(new->gmem.file);
>
> -	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
> -		goto err;
> +	if (new->gmem.pgoff + new->npages  > i_size_read(inode) >> PAGE_SHIFT)
> +		return -EINVAL;
>
>  	/*
>  	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
>  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot

Just noticed, this comment needs to be updated for the new function name.

>  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
>  	 */
> -	slot->gmem.file = file;
> -	slot->gmem.pgoff = offset >> PAGE_SHIFT;
>  	if (gmem_in_place_conversion || kvm_gmem_supports_mmap(inode))
> -		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> +		new->flags |= KVM_MEMSLOT_GMEM_ONLY;
>
> -	/*
> -	 * Gift the caller a reference to the file.  The reference will be
> -	 * dropped after bindings are established, or if installing the new
> -	 * memslot ultimately fails.
> -	 */
>  	return 0;
> -
> -err:
> -	fput(file);
> -	return -EINVAL;
>  }
>

Looks like const struct kvm_memory_slot *old is unused, though you
already told yourself that. :)

> -int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot)
> +int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
> +				  struct kvm_memory_slot *new,
> +				  enum kvm_mr_change change)
>  {
> -	struct gmem_file *f = slot->gmem.file->private_data;
> -	struct inode *inode = file_inode(slot->gmem.file);
> +	struct gmem_file *f = new->gmem.file->private_data;
> +	struct inode *inode = file_inode(new->gmem.file);
>  	unsigned long start, end;
>  	int r;
>
> -	if (WARN_ON_ONCE(slot->gmem.file->f_op != &kvm_gmem_fops))
> +	if (WARN_ON_ONCE(new->gmem.file->f_op != &kvm_gmem_fops))
>  		return -EIO;
>
>  	filemap_invalidate_lock(inode->i_mapping);
>
> -	start = slot->gmem.pgoff;
> -	end = start + slot->npages;
> +	start = new->gmem.pgoff;
> +	end = start + new->npages;
>
>  	if (!xa_empty(&f->bindings) &&
>  	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
> @@ -1077,7 +1065,7 @@ int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot)
>  		return -EEXIST;
>  	}
>
> -	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
> +	r = xa_err(xa_store_range(&f->bindings, start, end - 1, new, GFP_KERNEL));
>  	if (r)
>  		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
>
> diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
> index 01bd359d27e3..63723ffee0a5 100644
> --- a/virt/kvm/guest_memfd.h
> +++ b/virt/kvm/guest_memfd.h
> @@ -8,9 +8,13 @@
>  int kvm_gmem_init(struct module *module);
>  void kvm_gmem_exit(void);
>  int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
> -int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
> -				   unsigned int fd, uoff_t offset);
> -int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot);
> +int kvm_gmem_prepare_memory_region(struct kvm *kvm,
> +				   const struct kvm_memory_slot *old,
> +				   struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change);
> +int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
> +				  struct kvm_memory_slot *new,
> +				  enum kvm_mr_change change);
>  void kvm_gmem_unbind(struct kvm_memory_slot *slot);
>  #else
>  static inline int kvm_gmem_init(struct module *module)
> @@ -20,15 +24,18 @@ static inline int kvm_gmem_init(struct module *module)
>  static inline void kvm_gmem_exit(void) {};
>
>  static inline int kvm_gmem_prepare_memory_region(struct kvm *kvm,
> -						 struct kvm_memory_slot *slot,
> -						 unsigned int fd, uoff_t offset)
> +						 const struct kvm_memory_slot *old,
> +						 struct kvm_memory_slot *new,
> +						 enum kvm_mr_change change)
>  {
>  	WARN_ON_ONCE(1);
>  	return -EIO;
>  }
>
>  static inline int kvm_gmem_commit_memory_region(struct kvm *kvm,
> -						struct kvm_memory_slot *slot)
> +						struct kvm_memory_slot *old,
> +						struct kvm_memory_slot *new,
> +						enum kvm_mr_change change)
>  {
>  	WARN_ON_ONCE(1);
>  	return -EIO;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9fff2f4bf2f1..70d70042a9ce 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1681,6 +1681,12 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>  {
>  	int r;
>
> +	if (new && (new->flags & KVM_MEM_GUEST_MEMFD)) {
> +		r = kvm_gmem_prepare_memory_region(kvm, old, new, change);
> +		if (r)
> +			return r;
> +	}
> +
>  	/*
>  	 * If dirty logging is disabled, nullify the bitmap; the old bitmap
>  	 * will be freed on "commit".  If logging is enabled in both old and
> @@ -1952,8 +1958,8 @@ static int kvm_set_memslot(struct kvm *kvm,
>  	if (r)
>  		goto err;
>
> -	if (change == KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
> -		r = kvm_gmem_commit_memory_region(kvm, new);
> +	if (new && (new->flags & KVM_MEM_GUEST_MEMFD)) {
> +		r = kvm_gmem_commit_memory_region(kvm, old, new, change);
>  		if (r) {
>  			kvm_arch_free_memslot(kvm, new);
>  			kvm_destroy_dirty_bitmap(new);
> @@ -2133,11 +2139,16 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  	new->npages = npages;
>  	new->flags = mem->flags;
>  	new->userspace_addr = mem->userspace_addr;
> -	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
> -		r = kvm_gmem_prepare_memory_region(kvm, new, mem->guest_memfd,
> -						   mem->guest_memfd_offset);
> -		if (r)
> +	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +		new->gmem.file = fget(mem->guest_memfd);
> +		if (!new->gmem.file) {
> +			r = -EBADF;
>  			goto out;
> +		}
> +
> +		new->gmem.pgoff = mem->guest_memfd_offset >> PAGE_SHIFT;
> +#endif
>  	}
>
>  	r = kvm_set_memslot(kvm, old, new, change);
> @@ -2148,7 +2159,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  	 * the file is closed before memslots are destroyed.
>  	 */
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> -	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
> +	if (new->gmem.file)
>  		fput(new->gmem.file);
>  #endif

And this LGTM too. Thanks!
