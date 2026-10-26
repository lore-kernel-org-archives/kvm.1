Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022599;
	b=N3tP3meD2UZTiwIKcNmZbhx/1hwkdl+WEcHsiwG4XWD1LH6X4yO24VeSXS+vY+3uzCn3
	 SEhislD2+JedHfGoKuabzjK/BhdRF1r/qFz5JgDllFMo6YAWF4t5J/W7NyUp766fPoly4
	 s1o3ktf4xjrv/bH8xSPWYqvNpEsQCHA0miMDLsWMo+HPRhdDLln+ijXxRX9kwTuM06o3l
	 k4drW20Eq+oGMtOGRcRJxD4QrtUnzwcmGSReNtzd8e0xzICa3NDvUgdmfMN5BBvoM4p0j
	 z95euqIGzUKc7rFpKiFCMy4xhmj/3WxU0qirJgB+eu5sMLTblnoz03ejsNw4gzooLeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=c7my5rSEsn+U+kYhoFnNu7P7PE6jHz+gWSHK/wcS/Mk=;
	b=UD0RKdFlMCcIASemMx8b+RK4gOjPX1CxO9OgytRd56kVc2Sq6Xz1HI76vcJEjE4oaD4l
	 yRl6w3a9lYk1GTmkJj/waQl5s2ad0su5aQ+EcjjfIT4TKSkEVYrWxHWtY8paLzZiDyUmk
	 b3aTN2h0ObuDVho77fM9tg1+hsMHO36At32VQ1gQ0YQmoCgWyRER+H/7niPXQzQnTU9vE
	 81xJW5Hiso191Z4CxpG3hA4dro1pj3+Qvuvy+BnDYvT+AK/hWGpbek8Dvp3lxQzKd0qbc
	 koiOHMef9zi6bb0fnx12BkK51J94foPczzPLWbqWBz4K4qGGZVTuLjXAKRgcx5SQMJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OKDVyKgE;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F5606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 13:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OKDVyKgE
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so3034544a91.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793022598; x=1793627398; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7my5rSEsn+U+kYhoFnNu7P7PE6jHz+gWSHK/wcS/Mk=;
        b=OKDVyKgEF3jYW4Cf647YnddnbotpaIlDw2BqJ3HVXNLwO6uSOa9wIYmZIzbffqqwg9
         dw+vs8m7gm7095GZf13wFXtdHJp8RxdNtfD3LnRku8RQEURhM/DYpm5YF8dcWrnLe4pD
         pr0cLmGeMSLKxHmsB6ux653+RM8S9ix1mRMGF7I32+u7L01vB5iA/IB5kE88YGMTXvjx
         H9iZb4C0r7Pl++1fBVmflIOoQWiqzvXOggy9o/iNguje64DCqRKXtCjhlAKCjhvfM62k
         MTEA2aiKU0/3n0mmzvcBYzOgSR/VXCD7/Htzs9W5G/OngyH4UXCWAI2n4GZsYbqTnJC0
         zNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022598; x=1793627398;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7my5rSEsn+U+kYhoFnNu7P7PE6jHz+gWSHK/wcS/Mk=;
        b=P+Blc3/EvfNf46Hv2JRu/n7HDY4dkDIZxmA0iafbZiy8iaRVA23fyrDU1lWhiVBc51
         gK/eJe1Vd5uP6SoEUs1uiy5UotkB2/g4cpwrocdmGqgKnzr0oLOHbLHGdYJ+QefDI29j
         VU2K+EEg3UgxRtqq9kBg0h4Um5ssvPDbAuSCccNPC9h4LXcLRBauJ/o4AOKMYdlR4sVj
         pVDU3mcdEwkCCDZfd90LTNVGOXP9u5kPI7VcjASv7374jRRfFmivlidFCQFrYvE0gjnh
         /m+At63ijUMSOYGZfJj8HkrpBM+syEO4spkzpiEFOxPNfvchGk09eUkWGzTjYgdhh5BL
         LWVA==
X-Forwarded-Encrypted: i=1; AKwUvByDELhIp13JMJPewExFU3xEM3Z20B76bpEjVN8pmAisngWOKR4RJy1/YTY7gOxgj6E6NzI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwZVFQS8ilM8Kj957nLi4Xl2QIP/ryWFPWLWXWj4Dh77HkUeiz
	yUogXDpab8EaGj9HqkjGGJV/tpUVuXEFh739CLSHglSR1b/JT5gLKJyOwhsm24nA3261yfcOT7B
	wLpjfLQ==
X-Received: from pjbbu22.prod.google.com ([2002:a17:90a:ee56:b0:3ac:c43b:e322])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:564d:b0:3ac:7f4c:a690
 with SMTP id 98e67ed59e1d1-3adeafb0449mr5178332a91.35.1793022598376; Mon, 26
 Oct 2026 06:49:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 06:49:56 -0700
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
Message-ID: <at9ahKiYsVtH8kpU@google.com>
Subject: Re: [PATCH v2 0/6] mm, drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Christian Koenig <christian.koenig@amd.com>, 
	David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
	Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> This "v2" combines three series that I have previously posted separately to gather
> reviews and tests:
> 
> - kvm: apply VM_READ/VM_WRITE checks to all VMA types
>   https://lore.kernel.org/kvm/20260731175834.1121005-1-pbonzini@redhat.com/
> 
> - mm: pull writability check to follow_pfnmap_start()
>   https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/T/#u
> 
> - mm, drm: ensure .fault() does not have to be followed by .pfn_mkwrite() for write faults
>   https://lore.kernel.org/kvm/20260731164341.1109827-1-pbonzini@redhat.com/
> 
> All three, together, make it possible to write drivers that use .fault()
> and .pfn_mkwrite() callbacks for VM_IO|VM_PFNMAP regions, and that also
> interact correctly with users of fixup_user_fault().
> 
> The problem is that if you define .pfn_mkwrite(), vma_set_page_prot()
> clears the writable PTE bit in vma->vm_page_prot, at which point
> the .fault() callback has no way to create a writable PTE.  Users of
> fixup_user_fault() will then see a read-only PTE and have no clue that
> the page needs a *second* fault to reach its final status.
> 
> fixup_user_fault() itself does not have a good way to notice this, because
> vma->vm_page_prot is an opaque pgprot_t, so the fix needs to be somewhere
> else.  Other preexisting functions, namely vmf_insert_page_mkwrite()
> as well as vmf_insert_pfn_pmd(), suggest that this has to be the driver.
> In fact, of the five vm_ops that use .pfn_mkwrite() together with .fault(),
> three are in file systems and are not buggy: all of them ultimately end
> up in dax_fault_iter(), which uses vmf_insert_page_mkwrite() to correctly
> insert the PTE.
> 
> The two problematic implementations instead are both in drm code.  One, in
> drm_gem_shmem_helper, was reported as a KVM regression; the other, in
> vmwgfx, was found by inspection of .pfn_mkwrite() implementors.
> Both of these use pfn-mapped regions, but there is nothing like a
> vmf_insert_pfn_mkwrite() function that they could use; the first part of
> this series thus adjusts mm.h to provide two new functions for this
> usecase---vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite()---and
> then teaches drm's two users of .pfn_mkwrite() to call them.
> 
> This however leaves another case buggy where fixup_user_fault() is preceded
> by follow_pfnmap_start().  Most callers of follow_pfnmap_start(), seeing
> it return 0 for a PFN that is mapped read-only, would not attempt to
> call fixup_user_fault() on it, and thus the PTE would not be upgraded
> to writable.
> 
> This is arguably a bug in... almost all the callers of follow_pfnmap_start(),
> but fixing it is much better achieved with a small improvement to the API;
> if follow_pfnmap_start() is told by the caller that it needs the memory
> for a write, most callers are simplified because they were doing such a check
> anyway and now just see -EFAULT.  They then proceed to call fixup_user_fault()
> and everyone is happy.  This is done in patch 5.
> 
> To sum up:
> 
> - patches 1-3 introduce the new MM API, and use it in the DRM .fault()
>   callbacks to install writable PTEs in response to write faults
> 
> - patch 4 is a preparatory fix in KVM, eliminating inconsistencies in the
>   handling of !VM_READ and !VM_WRITE VMAs; these would return different
>   error codes for a !VM_WRITE VMA depending on whether the PTE happens
>   to be mapped (but with wrong permissions).  This needs to be here
>   because the next patch would introduce even more inconsistencies.
>   
> - patch 5 moves the check for writable PTEs from follow_pfnmap_start()'s
>   callers to the function itself
> 
> - finally, patch 6 is a KVM addendum that will have to wait until
>   the next merge window; it removes yet another inconsistency in
>   KVM's handling of !VM_WRITE but is technically userspace-visible,
>   and therefore it shouldn't be included in stable kernel releases
>   unlike the rest.

What happened to this series?  It seemed liked something semi-urgent, but AFAICT
it got silently dropped?
