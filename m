Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094964052AF
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769611; cv=none; b=oMsjEuJsiC7dQ41BJtcHdO4oyZFHHodpaDFJgIyzLFdk38F8kxNh40fBy+GB6oA7aMX9/F0J3yaV4pPCiM26BIAuLLFkx/V2rHT9RolS40NG1lQnX1MOQqiAM4f22y+2DOmcFw8noYZox3PYlfrmwuhxdlTt7KLlW85cxjcoULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769611; c=relaxed/simple;
	bh=X4dCGd6bkEA2cJ06CQNeFxBd0mqF1n9gi4l2ifHtpuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9fOXbjVhqx4K4WRc+nQkAMeeBS4+DQ8jPHHUrwLJ99ug2AnzctG35eagI3tNQ2sPLXgGASUUKqjYWhkwaaHkttos6AHh1Zdzc9+RPRVTiWbczw6pwviM4i2M2Lw4xvsQYTK4U/eJzCZ0DoI756URcReJPbhln6aernw5vVSlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqlhxgSG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqlhxgSG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f80c76e6so18537005ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787769578; x=1788374378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svW7REwf0C0yKBjSVBykLwlE0W36sIYmzgsGuY78Nos=;
        b=IqlhxgSGc4JVkHdl3/z0iNr440Xx+lcnFWhZ5E0kiJ8rGZrGOCovFVSWY5IWofbgX7
         OjVo37lylAFUapks+3FbD/okj+m6Z4nr0bzM/BTmCrKRrN3VA4n5xnwK+5uX56Jw/K+V
         HTCkSrfRPPOIhBsnmyYwgVPDqT9Lj7jytwJi7Hd/OXD2Vp5OGvB7SzOllW0Mq0u9qdm4
         BHgjHYUK0RVKP5/0HDIM8aXpnmnn75Re8+3myewWe6KyfBJQfGMF56efG0hEOyn1TbZv
         mu6oUIw0C0CCDC2gPgzQIq8ncQ1vTYUQKZUBt94lCTBC5jWLeq5864gKKu2TZGlXbXTT
         gRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787769578; x=1788374378;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svW7REwf0C0yKBjSVBykLwlE0W36sIYmzgsGuY78Nos=;
        b=AmI6+vR5VY8RJwpnrcWoZDPKYZ/GFzEJREU0gTDz7TQNmQK2uPNgZjZ0xhq7H6Lw5B
         mOmYuu1nn1SeU4vqy+LVLjRyb1LFlw8da3inin5jIMH1QB6kyyfiffIcJRjC8g+I9STW
         xuKK1DhxRt4CLmGC2J/n8ZJ/5xOMC3JIaY2iY70uBqSSX62ZxWJvsTmHTjNetxqApli8
         TyD9lZLwThXoyIdptWC4qAiVg6+Xo2dYLRHdNbGeorALN30W1s5hiL1QLmfCBUObpDbh
         d6Fw0Ja3JphJzLD38uHny5zZmzUrBUsylYnCxZW78s+Ol3pAnHFGNPciz1XGAqXzVsnG
         YqYA==
X-Gm-Message-State: AFuF++n5m04WIGio2KDKdPK5zDX1HYSARKA2zULNBZIlr8oQOdp9jqjs
	SUtvi6KwRZ6UEzOMF0pGjdHhCJ0GdJzPUueEPtbsowN0ub05WvNlPZeYSIaw5df9uxUo8LD5/Sf
	IJNdELw==
X-Received: from plbks11.prod.google.com ([2002:a17:903:84b:b0:2cb:3f5b:b116])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2392:b0:2d0:cc92:f7a3
 with SMTP id d9443c01a7336-2d707a53a0fmr177647795ad.2.1787769577699; Wed, 26
 Aug 2026 11:39:37 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:39:37 -0700
In-Reply-To: <20260826171151.959AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826165647.769231-1-seanjc@google.com> <20260826171151.959AC1F000E9@smtp.kernel.org>
Message-ID: <ao8y6d5gMN1wG_C0@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index b596486d184ca..7f1c6a0f8039d 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> [ ... ]
> > @@ -300,17 +300,55 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
> >  	 * dereferencing the slot for existing bindings needs to be protected
> >  	 * against memslot updates, specifically so that unbind doesn't race
> >  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
> >  	 */
> >  	mutex_lock(&kvm->slots_lock);
> >  
> >  	filemap_invalidate_lock(inode->i_mapping);
> >  
> > +	/*
> > +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> [ ... ]
> > +	 * Obviously KVM would be broken in many places if the synchronization
> > +	 * were omitted, but it's important to note that get_file_active() does
> > +	 * NOT guarantee a reference to the correct file was obtained, only
> > +	 * that the file doesn't point at a reallocated object.
> > +	 */
> >  	xa_for_each(&f->bindings, index, slot)
> >  		WRITE_ONCE(slot->gmem.file, NULL);
> >  
> 
> [Severity: Critical]
> This is a pre-existing issue, but could bypassing filemap_invalidate_lock in
> kvm_gmem_unbind() when the file is dying allow concurrent xarray modifications
> that result in a use-after-free?

Yep, already reported by Sashiko and being fixed:
https://lore.kernel.org/all/20260823-shivank-gmem-fix-split-v1-1-512a29fb8e86@amd.com
