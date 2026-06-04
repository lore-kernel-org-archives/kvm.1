Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209071BD9C9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559598; cv=none; b=hsl6S+E7FwpVw8Mb0H0zW4QJISRhxeConIX+DDEuqiD6R9RLOl9L8dehVYQunbVN8LqdKVOr2Cxps8u9D48LxihCAbKjWNMdYQisnrcRtCOKhyYv6TOj8MMdoxX3subh9P1l2QtMmrGb6bmWydRQYL/EvH7giwy8Mk/jxpplkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559598; c=relaxed/simple;
	bh=31VrJerjYA7ej2yswOdHnob11vtUb2WMPqeUzEM6S1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urp+uTi9wBbfH9Tzq0Yn8GQSVWyjuKOYFA8j7fnSVXrkcgk15p/kbVde+P1+mw9l8ByvkhbDyqwuk/fpXGuA8qxRY+8y5V7Hwp7FX9xJnqJxHYtJdIJPl9QilVNso12PyjfG+aYdDf53uKOQxNuzzLAzTPM1rinTiseGeeV9Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9dsOCo5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNYLeSLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9dsOCo5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNYLeSLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780559595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAYTNOKtmgWbEWkc3IB5qxW7LGlwo108ofpVCkavs9M=;
	b=g9dsOCo5unnxlIf9BiS+yBbu8SBREWXwDBJitRymoO5m3I1bra2kutcU8bkKtWsxxisb6n
	6V4S55DTpEuPrh9bhURKyeLOT9Axq5NgGdj8RbdwEd9BCz6zFWy7jK2IYHkXjrutBT5rH3
	f0DX2ceP3wJqdGt6MHweONXI3aPuIDQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-J4xBAeDUNc-_fxLSciQOew-1; Thu, 04 Jun 2026 03:53:14 -0400
X-MC-Unique: J4xBAeDUNc-_fxLSciQOew-1
X-Mimecast-MFC-AGG-ID: J4xBAeDUNc-_fxLSciQOew_1780559593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so2556185e9.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780559593; x=1781164393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAYTNOKtmgWbEWkc3IB5qxW7LGlwo108ofpVCkavs9M=;
        b=cNYLeSLBWsG14jF1Si7CBNIJzBuztrpQ+FrXJ8QxpJEdEz8d0u8Y0/s+Y8IQSnJ/nB
         fxW+0f1A5BvhoupWZRKzh21aj6/kKCdNc22NUTteDiy/Ar8uxYAyCOYCYRnI5LcmOoMK
         C/mD/hJqv+ABb8LshOHo1gE6cLjQ7LvctahplyZnxs8TpDhc2cc1IRjmbUAbzeC/Zx47
         Lkm/DEZTpkowLro+dFh6SSFKGMCDAiYMYMYfxIYLjotdRkXeWZaDsxjyiS/wAg4MnEKc
         VSBTaZ7jHqcRZM9t7X4JAOEo2MlG4ULNECYb+ohJ7cdjxh01nd3d64/wbgB9yzkPYSKj
         QOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559593; x=1781164393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAYTNOKtmgWbEWkc3IB5qxW7LGlwo108ofpVCkavs9M=;
        b=ZZD9i1JO3Xl2WbL4qgHyBTD+xtsm1z3RbIrrA+JybqLEW7AIDdV1UD6c2EoZgMJRXh
         vQ4Ds47QW10S4SZWKC0tjUHyce2t4J1JXlMDnvKg7w9OMWJVO5DwWKRQVPXb+Q5l0n5Y
         9g3Sr5iq303AYmdtZD0Hk9/nEPPjH0cH5woLwVXZN9xZeBz+ozeh+gRngGCqT/2tKMo8
         o5kin+nWoQHOlIjJcelgSRFR08Qwu2hjjVyJ4ktgRhvx7WfC5s9SqKT1m7hHtA0GWXyB
         HCQjsOGJKJoKFscEtWNqU9bYu5W5omiIWZiQveLrOxDfc0xTz593F+j+GjI6n8GovwRd
         wUcQ==
X-Gm-Message-State: AOJu0Yy2PX4U6ya+ghjmBfcw0p/3IQu0Xg8khkJI1vNkqJrWpN08bd5C
	ldssc3qt31ndmRvI0kxbh1TI5JLcsOJxnbvyT+ffc+h0tGxvoWzQ3Shf/sYaPBLtp4okFIc8xTR
	+tV6D2Wv8JSdR2FrWtQjGC3eEHqjNaj36bQivuzmA8AUmaLetjQcAoQ==
X-Gm-Gg: Acq92OFC0ivZ5uKECpixcZvlkNUTjn+Lm8+dv39DUa4AotgRwG6UVlgO6a0fHIlf51F
	/5t6tdXhtjNNwneh+sbfI5aPZtoUJ62nIFWHZH6RZrXOWjk+lsx10sDKeRB8yAQSR1SpKjFtZOf
	8jJu6lw85LR3j8/1TUNipbt1e6yUiy3+3sMeeJIJ/DPE8Moez5ZPHCrkJQnjVC9M9Tn4/1KgC9U
	LoZmMeXYOM+FhcjFN7R102x0pGa0s+ZTfrbFLE0mxMBPhbY0ZMqSDXJWzYoGkP2tiQmYWW5VFF+
	UOw4QhE3VcqcoIocOUrLrtDKe4r2cl8wyYjLptvhEz20SfCNKk2Y+enSjoF0PKwQp/KbIgeBPb4
	ucDNl4RwUSA2FCAOk2e0+qaOsm02jbOnVxAKjYYOpgfb0EQStgxpGOg==
X-Received: by 2002:a05:600c:34ca:b0:490:bb45:79f0 with SMTP id 5b1f17b1804b1-490bb457abdmr61057255e9.3.1780559593302;
        Thu, 04 Jun 2026 00:53:13 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:490:bb45:79f0 with SMTP id 5b1f17b1804b1-490bb457abdmr61056505e9.3.1780559592722;
        Thu, 04 Jun 2026 00:53:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm55238155e9.5.2026.06.04.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:53:12 -0700 (PDT)
Date: Thu, 4 Jun 2026 03:53:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
Message-ID: <20260604034539-mutt-send-email-mst@kernel.org>
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <20260603161525.D9E241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603161525.D9E241F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 04:15:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] guest_memfd memory allocation ignores page offset for NUMA interleaving, falling back to the task's global interleave counter.
> --
> 
> commit ce4f65d7ee89d8194749cc615f30619f101248db
> Author: Michael S. Tsirkin <mst@redhat.com>
> 
> KVM: guest_memfd: fix NUMA interleave index double-counting
> 
> This commit fixes a bug where the NUMA interleave index was being
> double-counted by setting *ilx to the inode number instead of the full page
> offset in kvm_gmem_get_policy(). This allows get_vma_policy() to correctly
> add the page offset without duplicating it.
> 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index bf9659a7b0f6d..65daef23c8390 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
> >  }
> >  
> >  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > -					     unsigned long addr, pgoff_t *pgoff)
> > +					     unsigned long addr, pgoff_t *ilx)
> >  {
> >  	struct inode *inode = file_inode(vma->vm_file);
> > +	pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> >  
> > -	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > +	*ilx = inode->i_ino;
> >  
> >  	/*
> >  	 * Return the memory policy for this index, or NULL if none is set.
> > @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> >  	 * can then replace NULL with the default memory policy instead of the
> >  	 * current task's memory policy.
> >  	 */
> > -	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
> > +	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does guest_memfd memory
> allocation ignore the page offset for NUMA interleaving and fall back to
> the task's global interleave counter instead?
> 
> While this patch fixes the index calculation for the policy lookup, it seems
> the index is completely dropped later during the actual memory allocation.
> 
> In virt/kvm/guest_memfd.c kvm_gmem_get_folio(), KVM calls into the generic
> filemap allocator:
> 
> folio = __filemap_get_folio_mpol(inode->i_mapping, index,
>                                  FGP_LOCK | FGP_CREAT,
>                                  mapping_gfp_mask(inode->i_mapping), policy);
> 
> But the generic allocator hardcodes NO_INTERLEAVE_INDEX in mm/filemap.c
> filemap_alloc_folio_noprof():
> 
> if (policy)
>     return folio_alloc_mpol_noprof(gfp, order, policy,
>                                    NO_INTERLEAVE_INDEX, numa_node_id());
> 
> For policies like MPOL_INTERLEAVE, using NO_INTERLEAVE_INDEX causes the
> allocation to use the faulting task's global il_prev counter rather than the
> file index-based deterministic interleaving.
> 
> Doesn't this defeat the purpose of the shared policy, causing interleaving
> to be randomized by the chronological order of vCPU page faults rather than
> deterministically spread based on the guest physical address?

Does not seem to be caused by this patch.
And I've no idea whether changing this will break anything
users rely on - might be prudent to have userspace opt-in,
if we are changing this?

At least kvm is the only user passing a non NULL policy, so
fixing filemap_alloc_folio_noprof should not break anyone else.
Anyway, I'll leave this one to the kvm maintainers.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com?part=1

