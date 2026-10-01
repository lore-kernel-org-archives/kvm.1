Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE14779BC
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891801; cv=none; b=hb3YP1aYcH9AVw4VNiXGTygMsAIoahIxG6gpiRwkIC+kKSrR4FiWfxjv1xxjzF1SXI4tPE8wd+EkWQ5L/nP7k5kK/F0xV/H9U0B/dVrgaR4MVC3sXI857vW0tIAd6xzm6/W6ssF3RXyyVEhKD6W/oIyjAjbQKfAFNBN3fGMTkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891801; c=relaxed/simple;
	bh=PJkhgsHiHUBvEvna17aTIkDs3O8oEYUtQ4paJax81FY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xi9uKHhItsadYfHua8bgg0QLrKbHJZxutv+7eZCs9ll9mgP97hvYJXoF1j7mxhh3vxFD2yejhzxKt2eDAC+HXJ53NJdVlsrEE5kcV6nm7z+UdOBFpOVj7RYDqPal+b3dbr2hfx8lEGB0r2TEBdfM73Q8SntxFwdJCXHQ47HuBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3V8XTwm; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3V8XTwm"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so11012742a91.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790891800; x=1791496600; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahstotXE2MD3z7KL/66fsytb53m57t/MSgEl40ciijM=;
        b=G3V8XTwmGPy6RggkXwfdjzg0CCbRKnLMfCedvQQe9GoVGVBHsa5PRpDnvW+FFC2FZh
         C5zpULRLxbRUfzVi1vPO2Igdq0xjktfg0+tPzJX9enNTbOdbAiwAEGYvSGwuy2BxKQMu
         KKrbdOLLx7mT0XGUWpUcGPDTr3uRC7YoQlkrJUb5QzVacgzMwc/GKGiz1JhEH5LOqcxi
         zeplo3sXYm7q1gkMZ4oaWO26MjpleY/UzVGH4hdfsvWhY+l7xLcnXYIutlIwVDmhsq76
         432xLSI6v0GluTW2i/Y5ECqsHhAf6KCnizC+NEcNqFE7Vspobt/Ll9zrB6vWkDw2Dh3c
         kjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790891800; x=1791496600;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahstotXE2MD3z7KL/66fsytb53m57t/MSgEl40ciijM=;
        b=qO+1X5nRG0/B6ZQFgrTW6LXSPExgoiKCUCRY8R/4QSdt9mLhzXQMTuxrw3M5TL3Kwr
         3gf2sa6RbG6w09b7qtqpCsJNV1dM8+NWTWlNACM4l13c+NP5MDSdVxbQzo8PQaxS2Odh
         agNrtJgSl0mzXvB4NoXjMbGkqnP//NO7tJH6zSxFrBLmMnPOIKGxIivAucx7S1NN57u/
         WG+T5Ex3i7BNfyJZM/DHo/vzKlqJe2Ezl0M9xs4rl2OQ/BkF4vLqffGXv5tPScZXM0qu
         46N2keKQzX/9YI4CKzo5MDbVuQTFyMbOFSsghh8UEFqijufA5ciPRHhcD9/jhIirrF84
         GQFA==
X-Forwarded-Encrypted: i=1; AKwUvBy4Ax2E7MUSSDDlMf9TCBSoUVvco9Yr89TwqLbbHoHPYiO4OzbepGmWDbTl6x3cNCqchF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl8WYK4nIRi1qp+aJoPojFNKLqSbgDteTmHItzkhIxx5y//Q2o
	oDYNIKDY2mPIhcLoyAibtxIheLYjnIaU5qaOK9DRcUxYxIX3FccQkmVNvY1K6J/5Ws/hko+/MMP
	bbo0HMw==
X-Received: from plad17.prod.google.com ([2002:a17:902:e151:b0:2e2:f199:a1a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:3a4:9f46:83c3
 with SMTP id 98e67ed59e1d1-3a6cec4fc8fmr743920a91.45.1790891799435; Thu, 01
 Oct 2026 14:56:39 -0700 (PDT)
Date: Thu, 1 Oct 2026 14:56:38 -0700
In-Reply-To: <ar6SHjnMYNqiEpVa@LeoBrasDK>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-3-leo.bras@arm.com>
 <ar1xne00AHnJ-p_d@google.com> <ar5yW30S75THCfdV@LeoBrasDK> <ar6SHjnMYNqiEpVa@LeoBrasDK>
Message-ID: <ar7XFr51N_oK7hN-@google.com>
Subject: Re: [PATCH v1 2/3] KVM: selftests: Check dirty-ring size before enabling
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leo.bras@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Marc Zyngier <maz@kernel.org>, Josh Hilke <jrhilke@google.com>, Oliver Upton <oupton@kernel.org>, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Steffen Eiden <seiden@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 01, 2026, Leonardo Bras wrote:
> On Thu, Oct 01, 2026 at 03:46:51PM +0100, Leonardo Bras wrote:
> > On Wed, Sep 30, 2026 at 01:31:25PM -0700, Sean Christopherson wrote:
> > > On Tue, Sep 29, 2026, Leonardo Bras wrote:
> > > >  void vm_enable_dirty_ring(struct kvm_vm *vm, u32 ring_size)
> > > >  {
> > > > -	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
> > > > -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL, ring_size);
> > > > -	else
> > > > -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING, ring_size);
> > > > +	long cap = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
> > > > +	int max_size = vm_check_cap(vm, cap);
> > > > +
> > > > +	if (!max_size) {
> > > > +		cap = KVM_CAP_DIRTY_LOG_RING;
> > > > +		max_size = vm_check_cap(vm, cap);
> > > > +	}
> > > > +
> > > > +	TEST_ASSERT(max_size > 0,
> > > 
> > > Rather than open code this, which is kinda sorta going to show up in multiple
> > > places, what if we do this as a prep patch?  Then vm_enable_dirty_ring() can use
> > > kvm_get_dirty_ring_cap() (completely untested).
> > 
> > Sure, if you think it's useful :)
> 
> Oh, vm_check_cap() is different than kvm_has_cap()/kvm_check_cap():
> IIUC, the vm* version will check if the extension is enabled in the current 
> VM,

No, the VM-scoped version checks if the VM *can* support the capability in its
current configuration, e.g. some capabilities are fundamentally incompatible with
certain VM types.

> while the kvm* version will open a new /dev/kvm fd and check the 
> extension there, probably meaning the CAP is available in the system.
> 
> So, maybe we would need a slightly different approach?
> I.E. have the kvm_get_dirty_ring_cap() to use the VM version, and 
> have dirty_ring_supported() to start the new /dev/kvm fd and free it later?
> 
> What do you think?

It's not necessary in this case.  All KVM_CHECK_EXTENSION calls feed into
kvm_vm_ioctl_check_extension_generic(), the only difference is that the @kvm
pointer will be NULL when called on /dev/kvm.  While some capabilities do behave
differently if @kvm is valid, the majority do not, including the dirty ring ones:

	case KVM_CAP_DIRTY_LOG_RING:
#ifdef CONFIG_HAVE_KVM_DIRTY_RING_TSO
		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
#else
		return 0;
#endif
	case KVM_CAP_DIRTY_LOG_RING_ACQ_REL:
#ifdef CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL
		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
#else
		return 0;
#endif

I.e. the VM version and /dev/kvm version will always yield the same result.  Very
theoretically that could change, but it's unlikely.  And we can always update
KVM selftests in the unlikely case a specific VM type comes along that doesn't
support the dirty ring even when the broader architectures does.
