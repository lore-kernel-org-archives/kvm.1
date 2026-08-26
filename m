Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86340DB49
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764653; cv=none; b=FmLG9CHPVj9LFUB3hwJEZ0fb94KKznLIImd7ZXWpg8sH+8gDoX5d9ARihMEVbif1Artuxdbn6Xqrj/1mBGDSiQppdcc4NsxptxvIGdjy8zAjiVfwcCl72yyUBP2s5k2VZzmRXpqsRZ70AvqXULgBioD/W+TXc/d6bCnBfHC6pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764653; c=relaxed/simple;
	bh=+PWwCAxLILgjH1BHOxwFwcwG08ux2y9quV8YRSFgmMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRU8jnAV/fHm5QkVs1p/K2fhsTqoOsXxrXHqjRdd9yEO5Wfolz/YS6NXcuj8+N6PAd6TmeVZpoggvAk05J741EVmwC0vzwfyZ9qpWPY/ZAwHW4aUDtiq2JB6qDkmL+7KCbHvwpX7Su+z+WZYZbsoR36RhTw3pKN6vW/a94rMPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/xzQKAv; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/xzQKAv"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso1552607a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764630; x=1788369430; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0ahfTR7945TLMX+OKhlYErwamPWxkVCGwYwu/m0mdI=;
        b=Z/xzQKAvgxXbpVSqLjw9NMh/+8DP8Qf06LDSl9NlEnXl+AJtArt9WQhSV39NmlZYoz
         1CmorZkbryBYvofS9oj/E5zFjcuQNo0OHnq2hEVrZhM4BvvaT2TblaFniRk8xKxYdyeT
         rkaJ40GipNmu+s0Xh48BpsP4R0jJn6CeRZgH73a/T5UDr+GATtQitjk15rxE5aWXWtLp
         aRVW4TDY/tmBpPvctUrmy7FhxqPu8ffkuqEslfUGtSb2JAz10BbnNYYdYZpo/JnVLVwH
         gpNRkI7flOXJYuYpUFH5xmVRaWMNAaL1DCRCr+LQ8kfoCh0r+wcJbL5U/TjOjbheoNrM
         Zr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764630; x=1788369430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0ahfTR7945TLMX+OKhlYErwamPWxkVCGwYwu/m0mdI=;
        b=IN3XBn6CVKr/qjN4t8DPsuB4Hz8JjtqZeNK+RMlp0eghfx2d2h57/cVwQeM0fEmg05
         IRT9JjxADPaC+nAxg344AVgaPXWEopRbIpeiIb88SgHa9VRKx1+eK100Vwxc5uCJv6lm
         lidtY6SKndNdDSiNwuu4J4djn258Cw3NRwKE6wLa30pTWBokI0+XVFitScLNKR3DQD9F
         qeuPMiy2Aj0j4MJyluI2kxeB3N9/8oWrMlfIsUqSTjKLSsQZY4zhw3ebFdi/SJTmd/O/
         ivu4SYPXfTuveciSQjmXvNbCKoirQB8r6qP3KfX/F81LQ+Ws0yxc2VO7rFkP4SFU08c4
         8ojg==
X-Gm-Message-State: AFuF++l3uwEyqRzgQKBc58LcNzsTbjQdg79x83Pu3cJ2GKDLUNXjD3K5
	MKXQyamDzJ4oO5cRGAcOnPh19cOfErxRxhW7mFA43VBvqHtq2MkWNGVIvzx7r088nc0RDplzARA
	8tP9/RA==
X-Received: from pgna15.prod.google.com ([2002:a63:704f:0:b0:cb3:9a4d:501])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bb0e:b0:847:8acd:747c
 with SMTP id d2e1a72fcca58-85374ebe486mr14183739b3a.13.1787764629255; Wed, 26
 Aug 2026 10:17:09 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:17:08 -0700
In-Reply-To: <20260826170506.012231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165154.766699-1-seanjc@google.com> <20260826165154.766699-2-seanjc@google.com>
 <20260826170506.012231F000E9@smtp.kernel.org>
Message-ID: <ao8flASJQeE8iMKz@google.com>
Subject: Re: [PATCH 1/2] KVM: guest_memfd: Gracefully handle xarray errors
 when binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> 
> [ ... ]
> 
> > @@ -654,7 +658,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	if (kvm_gmem_supports_mmap(inode))
> >  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> >  
> > -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> > +	xar = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
> >  	filemap_invalidate_unlock(inode->i_mapping);
> >  
> >  	/*
> > @@ -662,7 +666,12 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	 * not the other way 'round.  Active bindings are invalidated if the
> >  	 * file is closed before memslots are destroyed.
> >  	 */
> > -	r = 0;
> > +	r = xa_is_err(xar) ? xa_err(xar) : 0;
> > +	if (r) {
> > +		slot->gmem.file = NULL;
> > +		slot->gmem.pgoff = 0;
> > +		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
> > +	}
> 
> [Severity: High]
> If xa_store_range() encounters an error halfway through the range (for
> example, -ENOMEM), can it partially succeed and leave some entries pointing
> to the memslot in the f->bindings xarray?

Something tells me this isn't idle curiosity...  Assuming Sashiko is correct,
this as fixup?

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1d2de9a1bc3f..323159c9b5f3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -668,6 +668,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 */
 	r = xa_is_err(xar) ? xa_err(xar) : 0;
 	if (r) {
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
 		slot->gmem.file = NULL;
 		slot->gmem.pgoff = 0;
 		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
