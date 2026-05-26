Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6C39AD34
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813585; cv=none; b=it3zw6vPcRZjeQu/rCA/rZzztXI4YnFh4qzriGtLf61e1hh0YUcoc4HZcGqk8kg0Fz29oJXGGSTwcKkDfhwzcx6eXR7a0XVqUKEGzomdEi2NWLSDeHRqotZpOa8mGpNnGnrm9Z5eT4UfdmAPVxUB3l9oit3t8h175M+RKm1IlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813585; c=relaxed/simple;
	bh=vdiS8jEUTDZVhvBUoPc9BRMQcliTq3ZdcyymjfOkB6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GGRScMO2ObQduwCc+zv85spuce2f+OsUljOhRD8Vx1VROali/2XtoIExS1DQmQ0E8ru6JAEmOQdoRax3f8YL5KCSAyZr6wbUWtCKjznr7DVmUPsgrJUxk/Q45RWLhWYVIzrpAbxeP6NHm/4ZWwY8YEC0qp5vgOAXkI5tPvNZIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWuQ1+gn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWuQ1+gn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so6722959a91.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779813581; x=1780418381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGCac3ndRY4cFGyojmw/sDEy33dzfMnUmsB2axatg3k=;
        b=MWuQ1+gnVcwNuZkWrR0B5BZn4qfgG8DGjiWBMIpeiHDCr4VHX+nhCBHmy2xi1XKs7S
         lC/dgns3QKEE0p7XY4erG1qXKomMzwd7wTdmlPCUCDhqM6OY1OFYIFGTIRinsQPZwtrb
         v4sPS08swQdX8a4G2qyZxyCV4DV25CJIAINLhl6ltO/9+QWozo8FQAO2RHMdvka0ch1S
         x3/2gM3H2NbYe6+/a3Rp35djW48ybxrOAGqFoFgJkxIcOhrPtO7LUFvl0bb0MCpT55dN
         2eU+x0l2FIrdAZr0f8T5qKsz3zhp6cTnsXSeLK1DDYn1BNUYrZJ4Htgq05YCXBpCP45V
         URnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813581; x=1780418381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGCac3ndRY4cFGyojmw/sDEy33dzfMnUmsB2axatg3k=;
        b=I4BvTo12EWnNElNaqYM1bIpIfEfy45RQMZQMSBiTgMwQkl8VFGX09PYqeGWbbvxT3B
         2i2eQtwXcU3RGYdUBesigxFf62zfN7VwyITS3j5xhm/LQNtAzRzgMgL2Q6m8mZQ4CZb9
         HO8IA41WekhQ9WiTwoJesY0RfUzO+FOFzyKC8bCf116JnsQtfuBdcM1sJ3fA3nx72QlN
         MyUhWS7zzb7PcOSF6uKd9hBpp2S22SYdlrwAU9HZMwNdl2Kc+Gevhtd+dR1DgZv8M3bH
         M6sO/1h4YeT/fYmt8iO7uMPoszW5RI92JogQSzMILgs/lyxA4o4ovDKLtH+wwlrQFSEN
         iGVA==
X-Forwarded-Encrypted: i=1; AFNElJ/yqwvjXhcK/BHN5pOmh0J+EnjmcZxw0TPUAXvobE5T0+MaJ1cfqoUmYVPccLaCOpbg/sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lgOaSvEPFEengeqUlR6Nn3RSCBbdTzmlsl5bJtP29lNKw8o8
	/mKllpQRyOebXcNHywM2PuqiSmseOvNaeaW18MWdwKJ37vz3DqXJ5MinNcwE949cXGYnkbD+hg0
	YqnUhCg==
X-Received: from pghq18.prod.google.com ([2002:a63:e212:0:b0:c6e:6f94:b489])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270e:b0:362:e826:cefe
 with SMTP id 98e67ed59e1d1-36a67697a77mr19184155a91.23.1779813580821; Tue, 26
 May 2026 09:39:40 -0700 (PDT)
Date: Tue, 26 May 2026 09:39:40 -0700
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-3-3f196bfad5a1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com> <20260522-fix-sev-gmem-post-populate-v2-3-3f196bfad5a1@google.com>
Message-ID: <ahXMzPz1cQl6kZge@google.com>
Subject: Re: [PATCH v2 3/5] KVM: guest_memfd: Handle errors from
 xa_store_range() when binding
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, Ackerley Tng wrote:
> Unhandled errors from xa_store_range() means kvm_gmem_bind() might falsely
> reporting success, leading to false assumptions in guest_memfd's lifecycle
> later.
> 
> On error, restore the unbound state and return the error to userspace.
> 
> Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d203135969d13..5b4911ffa208a 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -648,6 +648,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	struct inode *inode;
>  	struct file *file;
>  	int r = -EINVAL;
> +	void *result;

I would rather go with "xr".  "result" is too generic, e.g. begs the question of
"result of what?"

Actually, I don't think we even need an intermediate variable.

>  	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
>  
> @@ -688,7 +689,14 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
>  
> -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> +	result = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> +	if (xa_is_err(result)) {
> +		r = xa_err(result);
> +		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);

I'm not convinced this is necessary.  Sashiko "asked" the question:

 : If xa_store_range() fails midway through storing a large range (for example,
 : returning -ENOMEM), does it leave the already-processed entries in the
 : f->bindings XArray?
 : 
 : When this error is propagated back, the caller __kvm_set_memory_region()
 : will abort the operation and free the memslot without calling
 : kvm_gmem_unbind().
 : 
 : Since the partial XArray updates aren't rolled back here, could this leave
 : dangling pointers to the freed memslot in f->bindings? If so, when the file
 : is eventually closed, kvm_gmem_release() might iterate over these dangling
 : pointers and write to slot->gmem.file, resulting in a use-after-free.

but I think Sashiko is hallicunating.

If @entry is non-NULL, xa_store_range() pre-creates the entire range, before
storing anything into the range:

		if (entry) {
			unsigned int order = BITS_PER_LONG;
			if (last + 1)
				order = __ffs(last + 1);
			xas_set_order(&xas, last, order);
			xas_create(&xas, true);
			if (xas_error(&xas))
				goto unlock;
		}

Yes, the API handles failure on the subsequent xas_store(), but I can't imagine
that failure is actually, barring garbage input from KVM:

		do {
			xas_set_range(&xas, first, last);
			xas_store(&xas, entry);
			if (xas_error(&xas))
				goto unlock;
			first += xas_size(&xas);
		} while (first <= last);

Purely from a design perspective, providing an API that can fail partway through
under normal operation, with no indication of where failure occured (AFAICT),
would be awful.

> +	} else {
> +		r = 0;
> +	}
> +
>  	filemap_invalidate_unlock(inode->i_mapping);
>  
>  	/*
> @@ -696,7 +704,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	 * not the other way 'round.  Active bindings are invalidated if the
>  	 * file is closed before memslots are destroyed.
>  	 */
> -	r = 0;

All in all, unless someone proves with a test that I'm wrong, just this?

diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index 0c923fd603fd..c0f5b9565be2 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -688,7 +688,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
        if (kvm_gmem_supports_mmap(inode))
                slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-       xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+       r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
        filemap_invalidate_unlock(inode->i_mapping);
 
        /*
@@ -696,7 +696,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
         * not the other way 'round.  Active bindings are invalidated if the
         * file is closed before memslots are destroyed.
         */
-       r = 0;
 err:
        fput(file);
        return r;
