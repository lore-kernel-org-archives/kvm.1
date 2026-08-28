Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664C3F1071;
	Fri, 28 Aug 2026 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913941; cv=none; b=B8KC83adfgjIVIqS5pcqpJUbS0QNJ9pOW1bmSiS49FzwccpFmTYgwbKXPcHHGwju49cKNiQlt71PCi6fdwrNM4jUDvpN4IV/NeM1yn/pzHGlyj746e5siicG9w0SMUqfyxANtue3s3kgx+ukJpZR1bfk23wjSrJchWkrh0ay314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913941; c=relaxed/simple;
	bh=VJMjAcjLCCj6iXTcNef1EpFHjqLA58SVNKK4rgZgC9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwPHRU5J42ZYqDC9QZFQHi2E0N45f73HfJy0G78R4zYhK0NRg77bpYoI4asJGNmKO4kZSQsgwoSFq/DeAFRyxJCf2lJEpXfpniHGT+yvRApbacPkuyVQxkSnTJO2I9iSjp+5tsSVNfzWn20+K5cMiMSFmqLbFt5sFSq1izRAX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rNgDJiv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4iIAHIE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rNgDJiv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4iIAHIE"
Date: Fri, 28 Aug 2026 12:45:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787913938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ay4EfetQI0fx+wZA43LYfJrQgfjVdh11a9jTpjQS2S8=;
	b=0rNgDJivfWBpquaHBrqp/RsdNRbApXT43ZHMWqf6ANoNjM1kCYxasRPt49E9HUmDN3ToHQ
	H0hp/xX301aqgDcW5buxII8Q+G1tVsmVH2fZVBc8kPqe7yQ4oFatz/vfd1Lo3WzkZNe5Wb
	0qL02+WAinq3Mq0ImrJ27UXgMPWici0F9N9FsPO7NwhvKNpDQZ1Nj7re61rKKT+BltyMvj
	D9m7nagTZip2nXJGw6SHNXW3IhIvCSxg8IIvp3KJe2vJ5j8nQUw5z1Ycw1+m96NanvJjxJ
	E8cEfFC+uU0CvUD2JigI1vt3QeESDaq87G/9h0UyQkSdw5/gMI0Oap49aqpT4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787913938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ay4EfetQI0fx+wZA43LYfJrQgfjVdh11a9jTpjQS2S8=;
	b=Y4iIAHIEhdbixCyH5M+LlRWyxcs7T7gr2eyydUP2zHTnjidncxqGRLzXdFDrq8mMFt0XL0
	2Pc+tl/eoPlUOPAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	James Houghton <jthoughton@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: KVM: x86/mmu: __kvm_rmap_lock() preemption assert trips on
 PREEMPT_RT
Message-ID: <20260828104537.pXtV2G8D@linutronix.de>
References: <8d47b43e1829ac92703723e6a1a4afc7a2eaacb5.camel@infradead.org>
 <apCwV7xenDh2qmr7@google.com>
 <apC3lYri5r4KUM3T@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apC3lYri5r4KUM3T@google.com>

On 2026-08-27 15:17:57 [-0700], Sean Christopherson wrote:
> > @@ -1745,11 +1754,15 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
> >  	gfn_t gfn;
> >  	int level;
> >  
> > +#ifdef CONFIG_PREEMPT_RT
> > +	guard(read_lock)(&kvm->mmu_lock);
> > +#endif
> 
> And now I remember why I swept this under the rug.  This really should take
> mmu_lock for write, otherwise concurrent aging threads could theoretically get
> stuck competing for KVM_RMAP_LOCKED.  Which is silly, because they don't actually
> need to take a lock of any kind.  I.e. it's not super trivial?
> 
> Wait, duh.  It is trivial if mmu_lock is held, because then KVM can operate on
> rmaps without any KVM_RMAP_LOCKED shenanigans.  I wouldn't test this because it
> might break horribly, but I think this?

So you drop the bit spinlock and rely on kvm->mmu_lock instead? No sure
why it should break horribly but it looks reasonable.

Sebastian
