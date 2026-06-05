Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CD30BBB6
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683277; cv=none; b=Siun6U4xzFcHtMLso9OPcHqJ4Lfx6XFr2ZUf5JeQTI2LC6XGwp39iK3WDLRcp6JCBb/lHxoMCbOSOjqQWjDr3XZ5oMBEDwlbixMxcQcdOoKwiNMktJPKpW+G+kpS3LLYc9qlXkfhXRNbTHk/XKGFbVGIV7k6FRHKrMCbvNwFyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683277; c=relaxed/simple;
	bh=xxvtzaNKnyLrHob8HID9MbR/obHYgCNgsxkSJATtNWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ajpaxLc2G32y43FIbAZ3/LEuMJBnk3Bj9hQ6WA+WXZIqKrfzgYq+M9D9uBA6tR4ro4N3cgw278pBxEeVZdABaWqccJHA0EfR/ns3pNn++lQcDqKynDOY3ggQBXe1Io4Qn36r6VRbnIF1gvQTYwf7NZYmMWKgSWZrQFTu35WKTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOGNHLSA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOGNHLSA"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2c305d0so1310764a12.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780683276; x=1781288076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjJ7de1MemmKpp/4CANs5HHA++5sJk2rNlJjP4akQbk=;
        b=cOGNHLSA5vSQpbTh/0WWb+5O/8Gb9uDVZ2amWEEW3SNxI9nXt4Gyk+JMhXLgC/gPq4
         YU4GCWqW81pSGSShIPkiRYhRGSLsKYipWv+uLplRUTIe36htYY4eBWSUyTvkgQfPqF2P
         KJ3+BaqVfXLVZ+30tcw0vmMS4IuYoVxsK32ShMq0/oeODeGFk3FWUBdwg2wssRi01A8g
         z2QEYd0iJYvd7I8hXXpiOTfKj45CP96qBSCGjj73hPd3dmMZ7p+MqzaU4O2W7Q/uQ7Tl
         Hif2UaHMVzjSPPIbeTMwEXNYhRUKr/dj1jHjZDAwrp3/lZZ17RsZ7X9rQSRh0DQ/CXsA
         42Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780683276; x=1781288076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjJ7de1MemmKpp/4CANs5HHA++5sJk2rNlJjP4akQbk=;
        b=VSvePHaDjnVcz4JT0nOV4nqpQxcR1knMZytyrVNizP0gyV4FcBC1/XiaiI/iqvalGt
         OWhozFtJKAK57UvA04O35IFcy/hlmr1/GQqzHxG3TiWTljE9Dhvs2J9MBBh/8H0SkAmf
         hwn7kJ2A2UMrCGjGCVCb4pQaTw8ji8LVpfPNeo8pqkSHSncDcjjU3xqBfD9PxuVDqs2e
         R+ikK/Pbt2HCwid62jxWwGHHBe3qAYvuVAuOepDnCjP5WV9bRAuWTd+L3lcUznOvkedj
         4pnM/2OsnqBnrnmtwXUo6DfghWF0OnRH73I0ST142eA5Q/WmTZIulvXL6MQ7AlqS+q7e
         NxKw==
X-Gm-Message-State: AOJu0YzE4nws8zBf6oqqwicbNqF/nYaHMjWv4ysSNkQOF95QMJK20301
	Agcayp8aC+QqU/5YbLzVDQPfVYilomE8sMAxo9HIblus5Lp2AywODoZqhrPQZYWd/HAG/CCPoAQ
	Ezq2yig==
X-Received: from pgac28.prod.google.com ([2002:a05:6a02:295c:b0:c85:9a33:baf4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1609:b0:39b:d5f1:4ff
 with SMTP id adf61e73a8af0-3b4ccdc2fafmr6024851637.20.1780683275729; Fri, 05
 Jun 2026 11:14:35 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:14:35 -0700
In-Reply-To: <20260605180617.5B4B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605174611.2222504-3-seanjc@google.com> <20260605180617.5B4B01F00893@smtp.kernel.org>
Message-ID: <aiMSC-EPsCstfZrz@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Expose number of shadow MMU shadow
 pages as a stat
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 3886b536c8a57..be84e4d2405e0 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1701,6 +1701,7 @@ struct kvm_vm_stat {
> >  	u64 mmu_recycled;
> >  	u64 mmu_cache_miss;
> >  	u64 mmu_unsync;
> > +	u64 mmu_shadow_pages;
> >  	union {
> >  		struct {
> >  			atomic64_t pages_4k;
> 
> [Severity: Low]
> Should n_used_mmu_pages be removed from struct kvm_arch in this file?
> 
> Since all usages of kvm->arch.n_used_mmu_pages are replaced by
> kvm->stat.mmu_shadow_pages in this patch, it appears the original
> declaration is left behind as unused dead code:
> 
> arch/x86/include/asm/kvm_host.h:
> struct kvm_arch {
> 	unsigned long n_used_mmu_pages;
> 	...
> }

/facepalm
