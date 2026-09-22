Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B59544D73
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098612; cv=none; b=GPMQHtGoTm6MuEQmn8YI5lUBQ2NhTXwyMUNgHzoZLfovcNEjw1aIbhifcgiokyKruiqqyLLcK76JqbmEEmiNotbNzxzC25wC9iee9/OpEO2+yR1SF31Yh3wxJNZPu6OPgikV+92uHqVg89lXTSLi5vUahcRY+CBTWWA8nf79YJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098612; c=relaxed/simple;
	bh=pqfxOYdbk3G5uQ189p1pwNugqSafNpPZSMqnl+pMNDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DrMCweQi6mxwyz/wsmeYq2FnMMr1DjKe0jHzo7cJ0zt0UZo1Opq7cgfNGysG2u25U+GaW+iY9x+vPxnRj7e73TxB4bbsaZLM5H8R/25BQ1Gab16ShAwpSx6Mj71lgZuGA5wGq6fD1uN8ihdsPv91ZSeb1rZ78K96ncVp2W/K5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oM1ZLTAy; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oM1ZLTAy"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dc92350888so1217705ad.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790098611; x=1790703411; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMBUcj03qoQAyG1GKCyEGFSnmBsF37yewOw9nu3IXkc=;
        b=oM1ZLTAyP/iuDIrEN/1s/ssMc/qjOS4GrxyBzqHMVVERK2b3yj7f1Tyqc9F3udzJ/S
         h7JBV0Z+qXLBd9KMzr0uhXevBPRDNSTDckL9Af+u99518jNLE3RsiuP9HN9twCvckg3y
         /qlNsySx2Cm64UCewyIdM93WDi3UsNzXw0RHuGdgb+kvdzh0d5AtZq55ohB6Rqix/Bb7
         qOf1EPwQNagvNnKVog9RgJrnzuyVJJ88V2vRLsznimq70j6+OHs62jP9kyp+bHiQNFJ/
         PDWwIg3KSqj7aKgpHg2c/DEG9FZnF2wGnq5q5trQjcUc4t8XqEJAtajrmbuGfLkd8cRp
         I/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098611; x=1790703411;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMBUcj03qoQAyG1GKCyEGFSnmBsF37yewOw9nu3IXkc=;
        b=FqJIeR09g/eVyPUEZwqKs0SL/AhQKu9IEHfFpV7jq6SlC8REVGuicPujnOt5RAGsaD
         muXKBNpKbB5QUzNRJN3Z6Q3oL9RZYIPj77IHTH7cJwWfa9Xx06IkXE+Xw6XmU/vpMaII
         24e0OsKA9qXLmigil5Efg6afZwftVGaoPQcIDh5iteecjPtx4HeFVnvFzIcvazkRrba+
         TlPF76s1cuDFdsKko2B7Iesi0Np0FDW+ec49p+qnMy+y1bDIqm68VZvCKOEGBtl1gc60
         gdnUYPQFzHR7KhaDu7BJyJzm0e1aU1qqDD1BsPCb1dxZ6JRD9xculiNiOL6CoGi0wsBV
         nCrA==
X-Forwarded-Encrypted: i=1; AKwUvBx9ob+hVzwOpdzBhEvDnixZam6rssCeXZcKBXXJg+SORrVETRtcqRQL0alojRl7BM7ftuI=@vger.kernel.org
X-Gm-Message-State: AFuF++mDKc6KH+nd87MEu59XKJLfRMXIohA7tRgTyowZIn9jBw4eUWEZ
	RV62w1Mms3+eaBdrkXCLy97/nQYrPuPAFEPhQRJsN3BSxXeZnaEoKm0jtwRn+cs2qyydheD76Y0
	GGpa2ug==
X-Received: from plhz10.prod.google.com ([2002:a17:902:d9ca:b0:2df:4a0d:5ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b27:b0:2dd:c100:a5d9
 with SMTP id d9443c01a7336-2df69df7453mr924125ad.45.1790098610429; Tue, 22
 Sep 2026 10:36:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:36:49 -0700
In-Reply-To: <arK5ynpRi7VbY7Ek@gremlin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org>
 <20260922-kvm-arm-prefault-v3-1-787bd3bc7e3f@kernel.org> <arKxjsxuO1F5ExrY@kernel.org>
 <arK5n9HrbZMCOHOt@google.com> <arK5ynpRi7VbY7Ek@gremlin>
Message-ID: <arK8seJVT9wYgVCP@google.com>
Subject: Re: [PATCH v3 01/14] KVM: Allow architectures to disallow pre-fault
From: Sean Christopherson <seanjc@google.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Lorenzo Stoakes (ARM) wrote:
> On Tue, Sep 22, 2026 at 10:23:43AM -0700, Sean Christopherson wrote:
> > Rather than have kvm_arch_vcpu_allow_pre_fault_memory(), what if we add a more
> > generic kvm_is_vcpu_loadable()?  That way we don't need to worry as much about
> > the return value, the connection to vcpu_load() is obvious, and we don't need to
> > add another pre-check if future (or cleaned-up existing?) ioctls want to do
> > vcpu_load() in common code.
> 
> ...this is exactly what I started out with.
> 
> But then you are in a pickle, because _really_ you need to do that check in
> vcpu_load(). Which is a void function. Which is called by every single
> architecture all over the place.
> 
> So you'd have actually no way of signalling the error back.
> 
> Of course those places are arch code and you could say 'arches should know
> better and if they call it it's fine not to call the arch 'can you load'
> function.

Yes, that's my vote.  It'd be easy enough to clarify that "rule" with a comment
in linux/kvm_host.h.

> But you're still stuck with the problem of where exactly you put this check.
> 
> So then do you put that check in a wrapper around it?
> 
> Instead you can make the predicate 'don't prefault on a not-yet-initialised
> vCPU' which is pretty sensible I think, have a specific place to put it and
> all's well with the world.

But look at it from an x86 perspective.  Pretty much everyone will look at this
and expect:

  bool kvm_arch_vcpu_allow_pre_fault_memory(struct kvm_vcpu *vcpu)
  {
	return vcpu->kvm->arch.pre_fault_allowed;
  }

> > I'd also be tempted to say it can be a macro, not a __weak function.  E.g.
> 
> Yeah it can be many things but why would you want a macro if you could possibly
> avoid it? :)

Because it allows arch code to dererefence "struct kvm_vcpu" in kvm_host.h,
i.e. allows "inlining" the check.
