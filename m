Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C719CCF7
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643413; cv=none; b=ILjwvsarmpvmlcVZUj+yjl2gyiJOSUwJdFsSUfQHH50RNvV7FbVviVwrmQdu+Hy4An0MG9nJ/RtLBOmLLidK5GHMRILm+0IIB63Y5u06SrC5DGoPY1tlHW0m+iSniMc7I+dNziNM0fgmB7UxlaDo/6yVz1RYnFqlJR69qJ4XqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643413; c=relaxed/simple;
	bh=GB4xCP0jtX0S7pBhKQHmaRJbmrIJrMCUGDK/2C/wZKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FveL5VfFe/jU8Kh0NHAv3sv+/+QXbc3LCG6gf7OboXB2wTMOJaYBjgafpyjsV25SXadFh/LU/X4gd2+YQkZK5CP1i9nO5mdZVVVAQz4AgdyIxU+FJIGBU026FbLA+yWg4PIGsEhjoQ6d+5biUNActILX32TGZpqG+i8QxMbpX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d94dnkpb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d94dnkpb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b314193so6111155ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643412; x=1784248212; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bo34D4yllTctFsYLgx2ysys5c0zKcYVwf90OudJRWeA=;
        b=d94dnkpb7Y2MmlqXGvXcaw7spZsQ8g1PGLvkicXDXHgMbjbOW8iPUcKbCMBC+ghbF2
         nYlTFZXllwdsjUCqJ+NuYqTRzYDaDLejo7VwxbnuXHLayq5knVGtZSkSrzQXsgag3+z/
         uGii6FxnGxNjTjmwnBaSHvtjBoU/GOcNgqoQKo7bZQEuNL+9uqhgx1v51BuE3eDtWbdb
         93yESJGwiwSOvMseut7OSCpstI5rgNG+d88CLard6uQ0+qmoBD+28g2reclp6JRf8MB/
         +J4n/4TWdXtQXBz13qBP0Whfrhi3SBzQiZLtradfbivCifSbDQrDOltUf8Eze3jmDtCd
         Iq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643412; x=1784248212;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bo34D4yllTctFsYLgx2ysys5c0zKcYVwf90OudJRWeA=;
        b=HVUqOJUTGyyEClqd8GixhWKrIS3iI5y3PUsfJkBQWqg/4rpqDFgZ04I195ZvnPiuTW
         FhaJ2Z0ljpx96YlzoHhgmWjPwzka7jO3Kn9huQS0/67JzlOvnp/jdDaHB8M7yWPyF7//
         pcVT74yagrqKsnwx9uyzgTNL/E1ncqY/5aEGIdJhUd8jkD5IJ0dg0uVg0Pu6rqe6iWZN
         q8EmHvuoAW9gko3oK6TX1mTK3wBnF6kWILKJhpGffZkd8//jwrG9CqvobVoyOfnim6r0
         LiodiiMY7/Vgf+3tFdn13Dc99UmUWdszQIJ8wPg2XtXt4H9bbySOMEKKdRd+O7YEk8L+
         kL/Q==
X-Gm-Message-State: AOJu0Yy9DPuiBItvveZXCcoods00v2FcU1qp7Pwc8X6QXIzUID2ZmpHN
	FTKZy7akK2Eam1+BLu5ISKbahB3PQ0XurNWzZoKEI8mrPNXSGLBB0oUODmDf8Qoj3VbKP7WvUCk
	FWg87qg==
X-Received: from plbbh2.prod.google.com ([2002:a17:902:a982:b0:2c7:ec09:a994])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c6:b0:2c9:e86e:a9f5
 with SMTP id d9443c01a7336-2ccea3c1330mr97089325ad.18.1783643411713; Thu, 09
 Jul 2026 17:30:11 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:30:11 -0700
In-Reply-To: <20260709210648.B98481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-11-seanjc@google.com>
 <20260709210648.B98481F000E9@smtp.kernel.org>
Message-ID: <alA9E9MIHYe-OpF3@google.com>
Subject: Re: [PATCH v4 10/18] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> [ ... ]
> > @@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
> >  		}
> >  
> >  		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> > +
> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > +		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> > +#endif
> >  	}
> >  
> >  	if (flush)
> 
> [Severity: Critical]
> Does this invalidation path need a way to guarantee a synchronous wait before
> returning?
> 
> Since VMSA pages typically do not have TDP MMU SPTEs,
> kvm_mmu_unmap_gfn_range() will return false, leaving flush as false.
> 
> Because flush remains false, the subsequent kvm_flush_remote_tlbs(kvm) call
> is skipped.
> 
> Meanwhile, sev_gmem_invalidate_range() relies on KVM_REQ_VMSA_PAGE_RELOAD
> and kvm_make_request_and_kick() to send an asynchronous IPI to the vCPU:
> 
> arch/x86/kvm/svm/sev.c:sev_gmem_invalidate_range() {
>     ...
>     kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
>     ...
> }
> 
> Because the IPI is asynchronous and the TLB flush (which would otherwise
> provide a synchronous wait) is skipped, the host could proceed to free the
> VMSA page before the vCPU actually drops it and exits guest mode.

No, KVM_REQ_VMSA_PAGE_RELOAD is declared with KVM_REQUEST_WAIT, i.e. KVM will
ensure the target CPUs have received the IPI before continuing on.  And the
presence of the request will prevent them from re-entering the guest with the
now-defunct VMSA.
