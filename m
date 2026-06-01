Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3B3B3BEB
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325437; cv=none; b=PHo5OE6nYA47/dfLXuAR0gAZxw6DxdUy38cwLdXFlVfh1SY0wu4PR8NJ/ZToff4jh1gnTV2mq1b5XRUPbAS02N8GkET4SJ7xubbc711XhzIXKJGCSEpDv29aMXvqN8vqaqJM1ou2IWydRXWjvSQZEDexr+vny3frZw2dhaZCfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325437; c=relaxed/simple;
	bh=o8M0Ji7qh5kL5dgcEVWWTPFL3lC7QdHWflir38GtWKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VKIA5TSTK3lqRmmQW4f/DOYzVauhFJO5+tEKAGiVC5zS180jvBpH1NLHMfFgkT4+5FMJrIFmEL7KrMeDuMkaeq656Duf1uNfows/ei0n9QK/obVg3RnjskTaW3F9FAPO9G92HD7kcvL80pJxyRTnnqlX+xlnyGRzVwDj1bdDa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdXSef1K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdXSef1K"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf0b7425bbso77914455ad.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780325435; x=1780930235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8IFpX6i3YgxmwpD0lZOPiAHnglrOZoW5MMfYh+HiPU=;
        b=RdXSef1KFPrYK/p/MKx7TpBp3npJpMykVaBr+6p44bfDM50UzryGFXWmGnGliYVkGi
         d4sJ1em+ojmUHP7W1JS8lMgBJtUKgdR/nRPE0mS58TVnVhjF3+1XSJc7JxfrIXLlDASX
         nPOERoKZa8NR/d2Bis91KKD4fkwcQ5XjzDbbZ4lVCvBFQHB1cfuCAu2N6d+I4NM3Gcpw
         TEhmcSU56BkXZD8sk8JPckBwQLDfIyLALZMIyplr4MQFpNVZjKGk/x01+zou3dMXB0YG
         Q8BqEocotdSBjCkXFan3xu7V0kOwG2gMA1BpoDzpHvjBxxhm1W9GKvgmFwk1WXXGp4nZ
         5t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780325435; x=1780930235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8IFpX6i3YgxmwpD0lZOPiAHnglrOZoW5MMfYh+HiPU=;
        b=IgJDhv9S6fcGxuLotRfidjFNpWeEyYcZD7fOcg8FJiaDWmKeBRtNIjTVw4z3Zfxkh0
         nxBW5S02NuYVrojXsSJDxhTuWJgv/17A2FKzT6kmtWO9obsaAPE5uueQFv6CYxT03uCk
         h0FF3gslHjwLlgZmSf5bkzocoC0GOTscSfinmeEQW1lfouTAT+vAiDmoWRMOSYQDTI8e
         tnneEZCMTDQMSNIaek7bEqEs9YK0MWXMuSx8Ufac98ajujXJpn/K0A/62blPFh+nXpvC
         bXH/fuiqK4ENYbi2EkYOvlq5Er3KaE6iFgrRXM8Snl0LXlFi1diAv/kc5AGuif1X3tAo
         BCPA==
X-Forwarded-Encrypted: i=1; AFNElJ9z4QSaC8H5kvglzhpRx1uM8nRAilXFNe4VB1FGUlxHD7aJH4DikcK4XMI4JjFsdPNnRds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58a7hYyuGw6icBjiDx8d5L+pqnmc1KWz/ZTZNXHVi97hNYOYH
	kE7cUaHAes8RmMHmmyQbpoj+D6m5mddfe93Bq4bEP5m3FYiBKG/5AjU9CAAyNahmGDsPmUNm4qA
	pSM8SuQ==
X-Received: from plbmn13.prod.google.com ([2002:a17:903:a4d:b0:2bd:7e8e:98f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:289:b0:2b2:4029:d781
 with SMTP id d9443c01a7336-2bf368098f7mr126986665ad.20.1780325435437; Mon, 01
 Jun 2026 07:50:35 -0700 (PDT)
Date: Mon, 1 Jun 2026 07:50:34 -0700
In-Reply-To: <aho2Pcc5p-HUUKji@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-31-seanjc@google.com>
 <aho2Pcc5p-HUUKji@google.com>
Message-ID: <ah2cOnXIgjKj1iv8@google.com>
Subject: Re: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:22:13PM -0700, Sean Christopherson wrote:
> > Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
> > x86's kvm_host.h to msrs, to continue trimming down kvm_host.h.
> > 
> > Deliberately leave the funky read_msr() where it is, as it will hopefully
> > be removed entirely as part of a broader kernel-API cleanup.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 26 -------------------------
> >  arch/x86/kvm/msrs.h             | 34 ++++++++++++++++++++++++++++++---
> >  2 files changed, 31 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index a861c0d70be0..1143140592df 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2094,7 +2094,6 @@ struct kvm_arch_async_pf {
> >  	u64 error_code;
> >  };
> >  
> > -extern u32 __read_mostly kvm_nr_uret_msrs;
> >  extern bool __read_mostly allow_smaller_maxphyaddr;
> >  extern bool __read_mostly enable_apicv;
> >  extern bool __read_mostly enable_ipiv;
> > @@ -2278,18 +2277,6 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
> >  void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
> >  void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
> >  
> > -void kvm_enable_efer_bits(u64);
> > -bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
> 
> Patch 15's changelog makes me thing EFER will belong to regs.[hc] not
> msrs.[hc]. Did you change your mind?

Not really, patch 15's changelog was always "bad", even in the previous version,
before msrs.{c,h} was added.  The bulk of EFER handling was left behind in x86.c,
only the {G,S}ET_SREGS accessor/mutator logic gets moved.

I updated patch 07's changelog between v2 and v3 to better reflect reality:

  Move *very* select EFER functionality as well, but leave behind the bulk of
  EFER handling and all other MSR handling.

But I missed patch 15.  For patch 15, how about this?

  Introduce regs.c, and move the vast majority of register specific code out
  of x86.c and into regs.c.  Deliberately leave behind MSR code, as KVM's MSR
  support is complex enough to warrant its own compilation unit, and doesn't
  have much in common with the other register code.

  Note, "struct kvm_sregs" has fields for EFER and MSR_IA32_APICBASE, and so
  the {G,S}ET_REGS flows technically contain a tiny amount of MSR code.  
  MSR_IA32_APICBASE is already managed by lapic.c, and so doesn't require a
  "placement decision".  As for EFER, leave all other EFER handling in x86.c
  (later to be moved to msrs.c), as the primary interface to EFER,
  set_efer(), is very much MSR specific, even though EFER is arguably more
  of a Control Register than an MSR.
  
  No functional change intended.
