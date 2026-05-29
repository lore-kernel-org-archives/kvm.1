Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12713812CD
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081901; cv=none; b=pdXK2onkx9cdAn+AFtJmjr289RsMpSibunxGYXvSlDyIQb2u78vMYPqudQ9r9PDxofJow1wSY7JpRQWlHFqTlJ6rbfcQubIq8c0isSTQJSedqHG384EjEMeaf4E2waqlYgqRO5hA14dGmxfiXrlfYXKkq1Hidx0cXl0X8QY22Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081901; c=relaxed/simple;
	bh=XCL6pT4c5JkNAYjAORu/J34rp3vl95jPcLX6SPbsxQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WWuv56wV3RYJVxtkkBwdx6DKGKdtuPZEdHr/n5mPD7Owg3bE37tnZ0dtBPr0KWWzbxbWu8IvcwrN2SuypCOn9dvHSS86wjcMZgzn61TlhSnUCvoRFShPI2YY7o024VUCV8F+GS1Chk7QHDgcZfDdsza0ckSAiMZeI6TH/60pAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KK9gRtRF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KK9gRtRF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368ac44b26dso12914440a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780081898; x=1780686698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGf2b0zl7KNF02Ny2sf9L7d/ZekySQCYKyXImr4he1Y=;
        b=KK9gRtRFXnqWsHYCjJjlBXAbIbMNqoHrf4j8JyiGcKfa47NWBpCekq6Hv5lYuMTm0W
         yqYbhTw/KdvTqfrSyqBM4wfpeIc4XK7Q8pR8wtSZbz0M3tzpnztchWrIl4fIftIoqAul
         FFTWdD2B2+RneJj6Sossde2J4gTO3MzczqFldAIZuC7J0RdvVBvJuW8NDnE6onO3e7Kc
         kLOqp/0wXs8hPwhdpwOIMl2idF6r2ynDFJFWdgCJCApw0E3cF/pFRhCvlrrGLjTFBXUK
         IcFPH+p+JwEqDFHNtL6si4RTVsh5r9lBSYK/HTLpWVQ7A9c+V5x5GH9+D+mMSROWIepU
         Jfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780081898; x=1780686698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGf2b0zl7KNF02Ny2sf9L7d/ZekySQCYKyXImr4he1Y=;
        b=rkG8jjA52o2DpMLQZcHcHOQLc0J81Pv6S1wiq9kjdiyaRehw14iQEWx3ugCmIu2VRt
         PA85Yb5xe+6iGGmOuPlRFQdEQw4FbxUmpcfgVKE8k0BXBigalvsvaSLt4G8/VW004XXl
         4nuhWKvYl6vcEyJkrbYsEUASd9egnN/jzMkD3cyHzM247QrgxeYQGqZHr3LiQmCXTuRv
         lr2G8+adeLDVW+weGAndhIr94VPFp1PQBqRUCmKY5GiTybsEA8lllxWoNkg+k6cbtoG6
         cTUUAi4DtvXoBaBkGzwMSr/UAm0Dygu7+syecb6+mzWMHC5EBHXlTzo/eoej6EmJ/4zh
         81PA==
X-Gm-Message-State: AOJu0YydS92vdNoF0IYer/WTA+1+H6mZxccXuIiTa+vJy847p7l0IuRb
	RselZyP10TXGoDRioZBcMVhV5IEo2q6SowZmasoFpgacu2YvbqD8kHNj9KDBOwdMmy28hn3fLY4
	PC1zF7g==
X-Received: from pjpo14.prod.google.com ([2002:a17:90a:9f8e:b0:36b:28fe:916f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c1:b0:36a:aeaf:ab2f
 with SMTP id 98e67ed59e1d1-36c501c6616mr410441a91.17.1780081897950; Fri, 29
 May 2026 12:11:37 -0700 (PDT)
Date: Fri, 29 May 2026 12:11:37 -0700
In-Reply-To: <20260529190158.D597A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-16-seanjc@google.com> <20260529190158.D597A1F00898@smtp.kernel.org>
Message-ID: <ahnk6cBLuuPIAwmA@google.com>
Subject: Re: [PATCH v2 15/20] KVM: x86/xen: Convert kvm_xen_set_evtchn_fast()
 to gpc's CLASS() APIs
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > index 8f822acb11a46..47750316f1322 100644
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> [ ... ]
> > @@ -1810,8 +1809,6 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
> >  		kick_vcpu = false;
> >  	}
> >  
> > -out_unlock:
> > -	read_unlock(&gpc->lock);
> >  out_kick:
> >  	if (kick_vcpu) {
> >  		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
> 
> [Severity: High]
> Does this unintentionally hold the gpc lock across the IPI kick?

No, it intentionally holds the gpc lock across _sending_ the IPI kick.

> By replacing the explicit unlock with a function-scoped CLASS() variable, the
> vcpu_info_map destructor won't run until the end of the function. This means
> the lock is now held while calling kvm_vcpu_kick(), whereas the original
> code explicitly dropped it first.
> 
> [ ... ]
> > @@ -1888,9 +1881,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
> >  		rc = 1; /* Delivered to the bitmap in shared_info. */
> >  	}
> >  
> > -out_unlock:
> > -	read_unlock(&gpc->lock);
> > -
> >  	if (rc == 1)
> >  		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit);
> >  	return rc;
> 
> [Severity: High]
> Does this now hold the VM-wide shinfo_cache lock while calling
> __kvm_xen_set_evtchn_fast() and kicking the vCPU?
> 
> Since shinfo_map is a function-scoped CLASS() variable, its destructor
> won't release the lock until after __kvm_xen_set_evtchn_fast() returns.
> This creates a nested locking dependency and holds locks over expensive
> cross-vCPU operations, potentially serializing event channel deliveries
> across the entire VM on the fast path.

__kvm_vcpu_kick() is neither expensive nor cross-vCPU.  In the wait=false case,
which is the behavior of kvm_vcpu_kick(), it sends IPIs via smp_send_reschedule(),
i.e. it's more or less just __apic_send_IPI(cpu, RESCHEDULE_VECTOR), which is a
single WRMSR on modern harware.

> Would it make sense to constrain the mapping to an explicit scope block
> to match the original release points and maintain the "No functional change
> intended" guarantee?

I'll just drop that claim.
