Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E21714AA
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430294; cv=none; b=cQAoMSqZCUcbXU1Gfq0gKCG6pvxElc8ZAw583jQaOnRibkXm133JvYCJTW2QueTTbECF+kWcjOI1yUGt1nyB61G/ZH/2DwZwudUXHy8wVZ+a2jD2mP09ANULlCCJzaegeCs2fDHeYSmzTV6Ozh32mkceeP0t8FqWHV4reTu6nWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430294; c=relaxed/simple;
	bh=iDj3peP1xyM5+cXPeaLlyU4dBm3+6xBn7CrvHRWwU08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZW5T/B7ToyZaovw3ytJqME39M6DR6kAHHBOfspnnCPfzyziT7dwUGwoEvoo4tVprSkkmjlPdajxDq7paPbVMspiKqaYiAnp8fDlnSLI/Kf7x1mV5CmBpeX+md7dRC06AbRJl0/7QYB7jAUWDQ54mkpV7no/ooAbLmzzi2J3Y9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwb8dX8i; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwb8dX8i"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7f259d20aso4938315ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430292; x=1783035092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UO4O1YNoI8Tg0yuseab1pxGK1UBWC9yNVHQIRrwqok=;
        b=fwb8dX8iT9SPTqfdUT7ngwgkvL5tb3I5hdl93jt5o1CpJ+SyhM79jdPA2zGbqXZJZn
         o6U9yw/4cGrvviZZEx2CoYVPwpSaN4woRG4pGLu2O1uEcxV4kErXvVpqoG8RlWTeETp4
         uX46MFu+FCF7kI12LUzSrkPLMmWkkBlRb9HGCPtjGJ3zsRxD9LfITD094Bz1qxlXs9zH
         K5F2Sb179Ad8zz+iG8v4fywsPSCdTwHkc+XX9PrFtVb/4iI6LLjmuEHZVZbDfK1ZpH96
         pGBrQCcS4p328U/BiNEiSUeDrWUwwh6JsUfZXNl5iDpKF/fxiwk30F+SIMkx6vMGrkkh
         DGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430292; x=1783035092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UO4O1YNoI8Tg0yuseab1pxGK1UBWC9yNVHQIRrwqok=;
        b=RiLLg51NiB4xElnxiPov+cg2QoOlrn7nmJYHL1hz8Xh4UQL3HOlRZwYXPnW63Uamxk
         3I68xHUBm2jOOBFc/T9SFjM9SP+GHFOzlhU1EQ/SMaDvOPnY4Dg+QD8xdPiXDQcnZLPy
         D8tZNFW4E426IfjwFYWVY/ZGdSUWDOWG4mwOC/hzkH+5gYdYPYO2OqPDv45FoepplZnQ
         id3wjwCzK++OPms4gg5UtyHPDbgzCP/n+SAUq6bwGrJVkjMbKmxd67hDsvOuylM9kXEd
         chc2nf5cCwXCu2FLiKqPBMJsdnri5r0ux98UPHiEXvjJnC/NnVA5x3NVWMaE5QfzXJZt
         s4/Q==
X-Gm-Message-State: AOJu0Yy/RmWbM1Q7NUaOLJ6Nkgx+hQ37A3e6PeEr7s94kfk3iIE0sTVS
	DPdbBxyC2L1IOd7+qWvz9xq2pBQDct8ZH6cmZn+XzcwC/MvOIE8bS6gQ5he8IXqyHzq5vZytvRC
	3tqJpCg==
X-Received: from plmx3.prod.google.com ([2002:a17:902:fe83:b0:2c7:f3da:de3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a24:b0:2c6:b3dc:b831
 with SMTP id d9443c01a7336-2c7fcb7fc5cmr50400365ad.27.1782430292000; Thu, 25
 Jun 2026 16:31:32 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:31:31 -0700
In-Reply-To: <20260625225715.5102D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com> <20260625223623.3376478-7-seanjc@google.com>
 <20260625225715.5102D1F000E9@smtp.kernel.org>
Message-ID: <aj26U17iLJbEuFkW@google.com>
Subject: Re: [PATCH v3 06/10] KVM: Initialize a vCPU's index to '-1' while
 it's being created
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index e44c20c049610..98da4c889ffc6 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> [ ... ]
> > @@ -4216,11 +4218,18 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >  		goto unlock_vcpu_destroy;
> >  	}
> >  
> > +	/*
> > +	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
> > +	 * Unwind the index back to -1 on failure so that KVM can use the index
> > +	 * to detect that the vCPU is unreachable, e.g. for lockdep asserts.
> > +	 */
> >  	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
> >  	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
> >  	WARN_ON_ONCE(r == -EBUSY);
> > -	if (r)
> > +	if (r) {
> > +		vcpu->vcpu_idx = -1;
> >  		goto unlock_vcpu_destroy;
> > +	}
> >  
> >  	/*
> >  	 * Now it's all set up, let userspace reach it.  Grab the vCPU's mutex
> 
> [Severity: Medium]
> Should the vCPU index also be unwound back to -1 on the create_vcpu_fd()
> error path?

What the?  Oh, ugh.  I thought we had eliminated erasing a vCPU from the xarray,
but what we eliminated was unwinding online_vcpus.  
