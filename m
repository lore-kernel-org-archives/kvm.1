Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675531;
	b=fZZBxjJGgzT4AbfTtWrC1PY6+syawnGpI+FqMSGpBdsW2Q5uzt/LTrFp3X0QUzYxUCHk
	 Dm4PLQmmSrcqtasfGAUSB8rcDPF2za7KdJ6OSe6VvQ3cMqYHAIoQy9tdtg6J7BNQo2pZ7
	 2HQGSZTrtsntQedgnjIA8DDhZxPGtAoNw66gaJuTNeniCZs/Q8d/LOwYIZpZsLCBH+3ty
	 ned02m0YtLuB/3OwsQ5Q0yqMx9/oEKfshroaRb/w3xotHdTtczelJQK+XY7/G2vKM/5Ea
	 wRjnrrhHipiZeQEZiUHJRoMJ7D5cuw3L6yinGy7W91xQVch2EGKgDfx1gdVO5Di7LlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=hZOHOOIePIsNvH6UKplfplXR1KT1tHkILWL/yR0j53w=;
	b=AuHSY8umD/4WeGqzA3irdBlO1vT5X6rfx3cMH4JXXmL5XVUbFM6fqNuuu/VOyPv1Yvyk
	 WqX1LWp7p7gl5KDjc6cpu/cJl4XePjAC5CqumvIyx0IyJBj5gftnoAyuyQ0kEe4CNN2j5
	 /ut471Jc3hsscfeXrsHzUqK4hiP55PQRNot6eazwkFQXWxbnZIetsweSweJ/Nzgfs4CCj
	 APd3IwElxAdli4C+mIz0bL5tDr9iCEbnLvPMQ/Alyeh09tsrqRbACQLk4wTMKHIX9SZJ9
	 zSohv+EpWLWgFd5dwMlxR0zUX5HNCSJ89HjNvqJrh36l7+babbOM8WhSp8ukFtU1atQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gk1GhX5Z;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B9606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 354B9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gk1GhX5Z
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so1947272a12.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792675530; x=1793280330; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZOHOOIePIsNvH6UKplfplXR1KT1tHkILWL/yR0j53w=;
        b=Gk1GhX5ZSDd0+yBhurUR6Pv6dvQdiMe4V9FVZNL+dbtFCJQS8rKjBfrPlkQpMgoO3E
         4JSbSguBiaIh4FgX5NvqHFXNkd2EMvc7xuf6koeLcacJvAvxbgS48piPT94z8mhABd7N
         eZODzelYY1pAp9KLpCi11SpDdV4LCVas31IQsysy27iP/5romV5o1JweEcdhB3Ml4hs3
         3Kgv/5Jlbzal7/YAxzE5UOMjh0pI0y6N5g3tVSCj9xuW1T7IbeG3xC+qad18sx99Erw6
         8pWWQko7r+8wYsPBSB36JMeng2a3pv/Mgz08GZ/NKtOqW5rr7Y9DgzUlO6xO4tkgIzd1
         OZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675530; x=1793280330;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZOHOOIePIsNvH6UKplfplXR1KT1tHkILWL/yR0j53w=;
        b=0UfusgJqOp/hRHFxvx+TsVoAYKgx19QAC7Eq3SekGOj4qZ6+NBjgNc4jbo5ss+hWKx
         EWpQjpPiumfBOUO4PukFglu/Z8bOJALxiuWf8kAZE9hgiZ4kYQ2jdwxI+wIss20qQPhP
         ggr8TPPlctxQOU+S0suzryjROzSdKim9WOmya1+kNoHZVJ9mh2eS/X7hdWzI8xXrn1jK
         2BQ0JqlCEEiM8wDqvPMQGTRPu/3gLQ84zvtdLyTJwQCNhqAxxywi+OB//lylFrDeEEhF
         KUSAohkv+O9f4D01UNrjFKHJmWVvW6mx7PYigBKlpQP8QcMqI+GY2M2+D8S7MKUedks+
         TJXw==
X-Forwarded-Encrypted: i=1; AKwUvBxbM/fJcsurecomgrKkkup2RV9NOFwwuXkD2Utup21EE7MKFkS2Sf3G0hcYEB0CA5BAbAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMS1IhSK/WChJpACMPBq8+UyxiPvOhPufDdL0ps6+mT/+OVkNV
	8E4lZcfbGBjtXocJIpbe+tJjKqLgCOEGt2JWfa7/DoIDXmN0/4KV0dQ8FghrPjKmO4soQWZBTMs
	OzqqEAA==
X-Received: from plbmp3.prod.google.com ([2002:a17:902:fd03:b0:2df:8ce6:d461])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecb:b0:2e6:1715:e48d
 with SMTP id d9443c01a7336-2ea43e179eemr44515925ad.35.1792675530321; Thu, 22
 Oct 2026 06:25:30 -0700 (PDT)
Date: Thu, 22 Oct 2026 06:25:29 -0700
In-Reply-To: <kuptsmerymy.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022021227.295495-1-seanjc@google.com> <kuptsmerymy.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Message-ID: <atoOyY2g68N7R9s8@google.com>
Subject: Re: [PATCH] KVM: x86/hyperv: Explicitly reject VP Assist Page reads
 if cache was clobbered
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Don't try to read the VP Assist Page if the shared PV EOI cache has been
> > reconfigured via KVM's actual PV EOI MSR, as trying to read 624 bytes of
> > info when the cache is setup for only 1 byte will trip the sanity check
> > WARN in kvm_read_guest_offset_cached().  Ideally, KVM wouldn't use shared
> > state to track the VP Assist Page, but in practice no sane guest enables
> > both KVM's PV EOI and Hyper-V's Assist Page at different addresses, i.e.
> > not allowing both to co-exist independently is "fine".
> >
> > Fixes: b63cf42fd1d8 ("kvm/x86: implement hv EOI assist")
> > Cc: stable@vger.kernel.org
> > Reported-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> > Closes: https://lore.kernel.org/all/20261017093016.32348-7-amirmohammad.eftekhar@cispa.de
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> (I am, however, thinking it would be better in the long term to either
> separate KVM PV / Hyper-V PV state here or even consider a 'big
> hammer' and make these two (+Xen?) mutually exclusive for all PV
> features.)

I generally agree, the problem is that any changes could break guests.  For
whatever reason, kvm_lapic_set_pv_eoi() very deliberately allows the two features
to overlay.  I.e. while it seems absurd, in theory a guest could rely on being to
use the two features simultaneously.

OMG, it's your fault!  LOL.  (Obviously not actually your fault since you were
just trying to clean up the mess created by the initial implementation).

  Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
  AuthorDate: Tue Oct 16 18:50:06 2018 +0200
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Wed Oct 17 00:30:17 2018 +0200

    x86/kvm/lapic: preserve gfn_to_hva_cache len on cache reinit
    
    vcpu->arch.pv_eoi is accessible through both HV_X64_MSR_VP_ASSIST_PAGE and
    MSR_KVM_PV_EOI_EN so on migration userspace may try to restore them in any
    order. Values match, however, kvm_lapic_enable_pv_eoi() uses different
    length: for Hyper-V case it's the whole struct hv_vp_assist_page, for KVM
    native case it is 8. In case we restore KVM-native MSR last cache will
    be reinitialized with len=8 so trying to access VP assist page beyond
    8 bytes with kvm_read_guest_cached() will fail.
    
    Check if we re-initializing cache for the same address and preserve length
    in case it was greater.
    
    Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

So yeah, it definitely seems like we can separate the two since odds are very good
the only reason they "co-exist" is pbecause KVM tricked userspace into effectively
saving/restoring garbage via MSR_KVM_PV_EOI_EN.
