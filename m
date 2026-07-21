Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281D22B8DF
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660136; cv=none; b=Z9lRYukY61j0cZz4/9MsDXpGgMlUaGGMbpoNR1eBzbgIkcE4BD2So9vCyPY4S3VTiv6HxBzD+vgjbVbFqxMdzgUM+WhmCeM+8rs4tMp3Yapk0CeLDh+pyCnmfpjQhJtZQXJ1ums/OJZ7TypFxCPtlFv1Wx94TTRli1QFzG3N4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660136; c=relaxed/simple;
	bh=tUhC96BFnwLQmo/0DBZEar2awuINLoGSmfdQ70wpFEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UGnX/1VRXoo6SfnZ8GRBhi900oRF8PWXND2XUWpKmnqdCdmLpSYPWycwly1J4G3bpm+BC/OztL50fDcLWMRjh1Q6+GKt1Wnn7ukNpbgWCs1DC+V9BmXHJdDNQ7nOdrlgM0W8vE6wfNE/3CI+/M3Mar55ZHq5NmHOt9Fc2JSJogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zb7YAPxQ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zb7YAPxQ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8482b95574dso15029497b3a.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784660135; x=1785264935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sh6amH3RhL1WJsitDE/xgJZ/YM0Of6GEW8psxmjx5y8=;
        b=Zb7YAPxQaPEaxG4TM5g63Ei7j7EIBQHbhAMX1T+9Y9r+pbriG92Rw4JBA36aFlkZM+
         V3BB7Fyv4sTzx8kLb6TFP6CXhOstzy9ifoLX6XcxcxGt3LJElftQV8IhGx+6N97ukcUL
         tapL35AQtUcTkt7ZYAhbn6iCCYrek8fQtg5EH+D6luUQhEhtqYcjWLHvQgaxUDMNTzpv
         WOGucbd6NxIdQKyhoigHGB4E2AOBBdhew8lk/6jyqARtPCozMyv1owQ0TfAq/hJON126
         Mi4IkZZhLpd2KaEIfVGg3T5iKmSR5uroUQNO8YMDrbhYfVpvO6ZfMAUjuGTZv0e2yFg4
         /jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660135; x=1785264935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sh6amH3RhL1WJsitDE/xgJZ/YM0Of6GEW8psxmjx5y8=;
        b=g22VUrm8V8vj5T7qNZcnLXrr0NrRB+Zow7Bs6DDMk80sVK2m2Qyfb7YOmbNUuwJ9w/
         dRIbjeCsKIDr6eeROYSMKczaNfMaFuxkmZAMWIUDgrJy2wvg2e7WL30vKHEPh1mcqba4
         rrh6PyfedM22Oay50YFZ/pbpxGUxdIPwHms+BtKuGn3HRMCt5tDBapgrvvERMT/5ipKI
         RlG90Vuz/ibDOfuWF+VrLytlv4PxvtfSu/vxbZfcGfeFXAZzaBVj7nFvocalG2Ha4ley
         PQ3dnTLmV77ICPoJyNYBWKfCI7pEAtgpnCqPbkYqVTUgxq/gJD5nWtD4xgXNt8bA7A3u
         URew==
X-Forwarded-Encrypted: i=1; AHgh+RpxI+1s3wNye8iMdobsQ+hCElT2es8KC4Q9rJOnZOi0rViFlkuv7YFgMMEDBxsk6HbEKgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFOgwkp//qm1UpICXrSeLws1+ibqKEpX5QMcB/GkMQfmDeK1V
	ZGsBPPj0IIRik+atuVlmWVRpa5q8ACYpJP3k27gx/kS3vnvzZHCYifmFoxfFQNLcCBd2MgoBEHc
	4ilWjcQ==
X-Received: from pfgv11.prod.google.com ([2002:a05:6a00:c4cb:b0:84b:62d1:9fe3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:430a:b0:848:7ea6:4b03
 with SMTP id d2e1a72fcca58-84c295839dcmr19212884b3a.75.1784660134557; Tue, 21
 Jul 2026 11:55:34 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:55:33 -0700
In-Reply-To: <CAEvNRgHjLmQcUSDKKp6jpsEiCyn+Cxnr-m5jweb=ZLAT8eh2kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
 <CAEvNRgFFEfHZTZOi_anSJDhqPvncuRiXxJt9hcRnAW9FPdFY+Q@mail.gmail.com>
 <al-aDRTbDOPT1UbM@google.com> <CAEvNRgHjLmQcUSDKKp6jpsEiCyn+Cxnr-m5jweb=ZLAT8eh2kg@mail.gmail.com>
Message-ID: <al_Apf37f7z8wgT3@google.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> I like Option B below better, which should also resolve my issue.

Roger that.  The more I stare at this, the more I like Option B, too.  I'll go
with that.

> > I'd be a-ok with providing
> > separate kvm_arch_gmem_make_{private,shared}() under GMEM_CONVERT.
> >
> > I guess at that point I don't have a strong preference betwee having a single
> > kvm_x86_ops hook versus also having kvm_x86_ops.gmem_make_{private,shared}().
> >
> > I.e. Option A:
> >
> > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > 				kvm_pfn_t nr_pages, int max_order)
> > 	{
> > 		return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
> > 	}
> > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> > 				bool to_private)
> > 	{
> > 		return kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false);
> > 	}
> > 	#endif
> >
> > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> > 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> > 	{
> > 		WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
> > 	}
> > 	#endif
> >
> >
> > Or Option B:
> >
> > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > 				kvm_pfn_t nr_pages, int max_order)
> > 	{
> > 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> > 	}
> > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> > 				bool to_private)
> > 	{
> > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > 		return 0;
> > 	}
> > 	#endif
> >
> > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> > 	void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> > 	{
> > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > 	}
> > 	#endif
