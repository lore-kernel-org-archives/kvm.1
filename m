Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903965;
	b=PTbXygD6ms3zdd45KnzX2ZVcTA5WNT6/06lHHEd2aCUUaJEclX7M/J9i1eHkADutMnpR
	 9l6BKwVugu8Zi4cHLfONQqeluLN0ZP/878n/BeIJqr/dFUIIAh/6wu+0jiAxfI+t0LNLc
	 Tv9SiBYgGP+/bIm4mev49bytfqDUx4CpafH9UCV22+h1ndGK+EG9uPisbE9l900IuNssf
	 Gvgik20uRXUx9s68sfueALpzTARxfBkNm3de9Me3q/Kd+DIGmylBOdICf52YbUXL9gMJC
	 rTyxPVDofABY2DYIAQnLdr2sW2W7L/Z/F2oEi7gi855VeC5W6gIQBdZWZLaNFWZpmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EdX+hrQFFp3Ef43cGYEEIMpLtyOAGxMQqiQQxVrhHxE=;
	b=lhhIm3zBkODcznQQrve9E8M9SFBrOFfQpa/fbve+9TBwS8ktZy8xYkb5HSAe9EiCOXSW
	 xx5XbQBNs2MME+aeFrPMa4KkCtRfbnyptpzoMuERi5sRSiJqUrKCqw+4QI7jf/IwEY/Nj
	 qNU/vSShCkkLtaupyBDSBfWwF4q8QSPFD7dUlZAclPwWAE5SN99x1OarrGv1wyf00mNay
	 jeclS3W0GB4r7hTbhh/LNY+dwMDvODivQjThDxGVQoZuJ1dD2yL508P2SzpgwZU+Tqpnd
	 fiIqq+iYxi8ivhk0wjbO86ZDKGBV42sjXBj5K5jg61J0zfYxUD26tg2VB8eznz37aYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=exG91NSf;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC6606A331
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FC6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=exG91NSf
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso2499815a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 10:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793903964; x=1794508764; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdX+hrQFFp3Ef43cGYEEIMpLtyOAGxMQqiQQxVrhHxE=;
        b=exG91NSfrf7D/lUoUk+qL9Vq6CSbsu3OPVgEe1YZ/7KBxI5ikBuz3lc6cW6ik709uf
         20j/v0Z35zpjOcKx9eq8ANzy/Vyi2rM1ihx0/dQm5i9g/I0lwG5G+1aqbB7oEYIP5uYw
         ixlbA+RN+dNoB0TMC4hfAx1+qm9UyRWMQwl8PqkVWyDyqAu49KgQquiumqya7sEBxiKB
         l5VKmBDP7CQ+eav2ZeSYpaRUEzE8o2kJ8BFZoXAy46omNf2q4ImfOMXFqcO1k1zV6ovP
         wI3wfnZV8C/nKq/SqubQGMQbYhlsyfaighCjFkgaGQ63bejU8dQUr0N3MGCIpi+FAG9B
         T/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793903964; x=1794508764;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdX+hrQFFp3Ef43cGYEEIMpLtyOAGxMQqiQQxVrhHxE=;
        b=gjrQXmSJ650cSZuSWEEZX9+2b90+nIw6rRFNITRTxlCcxFUbtKODwR0GP9QTzQ2MsE
         lJ4cbJT6JVZrCv5Qv9jAy5vwEDNkNVmRSHMUckWyeWomy76rPJALsN3oGH/StH02SIkc
         J6m/HXA4BIZdk0a3mOw25GjcEmS7VcdNcXDv8An4YibKtNPFlKwJCXDsQcRMY9O+TJEu
         quNEXGO+0ASFZQ17CIU7tOm4ku8d6M+3j6mYhCAioDabvA4lkez5YqbbSQO6Qm+da8Uh
         PmOWMXq4pr89KknwklAcsD9SLV4QJ85DHdEPDRY+j7na4E5nwlUNyEeCoKUgVM26Bvkx
         0hig==
X-Gm-Message-State: APuU4Z8uOg1ogIACkYIoP3EJM5FblxWQUsANYlh7iL76FtKc0fQkUTej
	e+h2u7xBXZRoEzgDu3kNHQ+v6chNxaUNOWmC8n9dQ/J1O33xS1W1Uc8jy8qdH1k8QBtZMcXf9ut
	ilmJojg==
X-Received: from pghl2.prod.google.com ([2002:a63:f302:0:b0:cc7:8e37:71bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9e95:b0:3e9:290d:9774
 with SMTP id adf61e73a8af0-3ebb2a7e5dfmr373500637.44.1793903963836; Thu, 05
 Nov 2026 10:39:23 -0800 (PST)
Date: Thu, 5 Nov 2026 10:39:23 -0800
In-Reply-To: <sashiko-outbox-199772@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105181742.3718448-1-seanjc@google.com> <sashiko-outbox-199772@kernel.org>
Message-ID: <auzNWz75JLF3VmV1@google.com>
Subject: Re: [PATCH] KVM: VMX: Re-pend KVM_REQ_APIC_PAGE_RELOAD if getting
 backing pfn fails
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] KVM: VMX: stale no-retry comment in vmx_set_apic_access_page_addr()
> --
> 
> commit 635b83243ce9cf39c9f2bbd0198d7730dbb21505
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: VMX: Re-pend KVM_REQ_APIC_PAGE_RELOAD if getting backing pfn fails
> 
> This commit re-pends KVM_REQ_APIC_PAGE_RELOAD in
> vmx_set_apic_access_page_addr() when looking up the APIC-access page memslot
> or faulting in its backing pfn fails, preventing the vCPU from running with a
> stale vmcs.APIC_ACCESS_ADDR. It also adds a WARN_ON_ONCE() if the private
> memslot is missing or invalid.
> 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index b341af4c6057a..13dcf9c12c83a 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6923,8 +6923,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
> >  	 * APICv is enabled, but paranoia won't hurt in this case.
> >  	 */
> >  	slot = id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
> > -	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
> > +	if (WARN_ON_ONCE(!slot || slot->flags & KVM_MEMSLOT_INVALID)) {
> > +		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
> >  		return;
> > +	}
> >  
> >  	/*
> >  	 * Ensure that the mmu_notifier sequence count is read before KVM
> > @@ -6941,8 +6943,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
> >  	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
> >  	 */
> >  	pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, &writable, &refcounted_page);
> > -	if (is_error_noslot_pfn(pfn))
> > +	if (is_error_noslot_pfn(pfn)) {
> > +		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
> >  		return;
> > +	}
> 
> [Severity: Low]
> This isn't a bug, but in vmx_set_apic_access_page_addr() in
> arch/x86/kvm/vmx/vmx.c, the full comment immediately above
> __kvm_faultin_pfn() still states:
> 
> 	/*
> 	 * No need to retry if the memslot does not exist or is invalid.  KVM
> 	 * controls the APIC-access page memslot, and only deletes the memslot
> 	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
> 	 */
> 
> Since both the invalid-memslot check and the is_error_noslot_pfn(pfn) check
> now retry by calling kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu), and
> VMX does not delete or inhibit the APIC-access page memslot while the VM is
> alive, should this comment be updated or removed?

Gah, yeah, I'll fixup to this when applying:


	/*
	 * Retry if faulting in the page fails (or the memslot is unexpectedly
	 * invalid) even though KVM controls the APIC-access page memslot, and
	 * never deletes memslot for a live VM when running on VMX.  Userspace
	 * can modify the underlying VMA, and while doing so is beyond crazy,
	 * the cost of supporting that behavior is to simply retry the reload,
	 * which KVM should do anyways to avoid carrying a stale pfn pointer.
	 */
