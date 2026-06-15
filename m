Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAF3F7A9A
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533418; cv=none; b=ok1M8BwB4ckWzSHt4nHTxYysGugukbpLWzHTcGfdPTWjHSTb4cwHFQ627iQ64FtYmhObWE0IoHJ2EWx6yDjWwmEYxRBjhR/bXWYV0wetT+gF7lY9UAozh5c74XEm8emnNrZzgR/WwZyxhXW3957bwuQxJQLTTKzkc4EtHrV/89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533418; c=relaxed/simple;
	bh=SuA5k84F8CzYepc5vVcea7PB7aL1vv5XuJ+9UGt3UqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhgFNzVNkk18FmXfNY88olp8yCrHRkPOJUd4LlXcfiI+oFvyX9i/4dYGwIrtJ1DtCFsovTmD/WMjfHKK11WeyZ3MBuCIEY12OlDCKytPWv2JkMvKljsnD9C4arP5LZzvnRxzFlidf5Ef1Wu9zEOqJCbWO7L829WEPRNiPT7zUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jarWPLTa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jarWPLTa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso4353362a91.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781533416; x=1782138216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHXtQahPuqoo0NJyk6bARw0tNhBOnPrj2MIbG+a6220=;
        b=jarWPLTaeFhjUzvFCUM/zc77KIymb7SlIXLB8dd3LSrYUEyiFVJYDTAUW9fWjCa4l5
         s61TppxQNPHVjGIEzgQ/DQrxygayEBdtsCq1pJrEnzn8xwntWzZSL1JGaf+2TzWlkKU7
         PHDC+lnnTYPYo1rDJ57yw8azu8AIpAGkqKKfnjjm40RH9Exvrd4ODbXBmALBNpxXfhfs
         VdcbUO9uvMLt7wAKlWYkf4SQpSKYQfdiizULubZxjjZ08q6UQpUU+IkE7Krf8jTnfqw0
         UP570By/HE5ufVg2jDuqB+KnFhcRnbhLaX77sN/zeGfFLZWha9Nxztb65XsFGHQ0l4Zn
         aL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533416; x=1782138216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHXtQahPuqoo0NJyk6bARw0tNhBOnPrj2MIbG+a6220=;
        b=JO5FFyYDd9Kux61zkMJIP7BcBQbGsBVr4/r8OCvaWGVbyDb4i+ggQtt864kXOFb00Y
         zOl7t/qrY9aWs7g9XuBPmKrpMCXlXPcDXRSUuvp5tTtDzrvNzPFmqRXl+w+6vk7o+wK+
         o1gaWszYAdM5w2BjTNMp9tY72vvw7K8N3C8wIayoHiB1XOIgJLP4hV33sVT5ZNZj/6UW
         XvfqGBm1ObOPj5K4gc4KrDnglahlPPpIvbVcU/zeLZ48cV4aZR8y2/8CD47/ICVw882B
         Eo65HPo7QpAiNjWNLxEoN6B8oKBQJbXwvvncljEEd2hX12e3J/FPFRMYcpHHbmgOdBug
         Nexg==
X-Forwarded-Encrypted: i=1; AFNElJ8YLTuZsHI3Zl4d7/C1ccYhH3KeUk2qQkJgrrQgvzDYcg/lmsu+05akc9IJh/5Cqt09O+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanHLDMadU06+/Xb0dgC2ST7B8RINMBi2OqN+tBAnMnTTyD+8a
	vW1ytKZ+1sunzQIeEI2ehTUoOHI0+DsL0630tpAw7qZt6AEQBVil8ezg9kUxZzI0ID5zWEfIiOc
	+aOCxDg==
X-Received: from pjbmj16.prod.google.com ([2002:a17:90b:3690:b0:373:40c6:a8c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57ee:b0:36a:d51d:42ef
 with SMTP id 98e67ed59e1d1-37c2bd033b4mr11299785a91.13.1781533415878; Mon, 15
 Jun 2026 07:23:35 -0700 (PDT)
Date: Mon, 15 Jun 2026 07:23:35 -0700
In-Reply-To: <477ed5cf76f73379886c01bdf1a0f47c984f2de9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-31-seanjc@google.com>
 <477ed5cf76f73379886c01bdf1a0f47c984f2de9.camel@intel.com>
Message-ID: <ajAK57S0tyPCO0yB@google.com>
Subject: Re: [PATCH v4 30/30] KVM: x86: Move a pile of stuff from kvm_host.h
 => x86.h
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Kai Huang wrote:
> On Fri, 2026-06-12 at 17:03 -0700, Sean Christopherson wrote:
> > Move the majority of remaining KVM-internal declarations and defines in
> > kvm_host.h to x86.h, so that kvm_host.h only holds structure and function
> > definitions that need to be visible to arch-neutral KVM.
> > 
> > Land the emulator interfaces in x86.h, even though kvm_emulate.h *seems*
> > like a good home, as the interfaces and defines being moved are provided by
> > x86.c.  I.e. keep kvm_emulate.h as an interface to the emulator proper.
> > 
> > Note, any "misses" are likely unintentional.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> [...]
> 
> > -
> >  #define TSS_IOPB_BASE_OFFSET 0x66
> >  #define TSS_BASE_SIZE 0x68
> >  #define TSS_IOPB_SIZE (65536 / 8)
> 
> Nit:  Seems sashiko was right about TSS_IOPB_BASE and the related macros can be
> moved out of asm/kvm_host.h (ditto for the enum of TASK_SWITCH_*)?

Hmm, agreed.  arch/x86/kvm/tss.h seems like the perfect fit.  It would be easy
to slot in a patch to move these ahead of the bulk move to x86.h.

> https://lore.kernel.org/kvm/20260530075928.888B61F00893@smtp.kernel.org/
> 
> But you said "majority" in the changelog, so we can always do more cleanup
> later. :-)
> 
> [...]
> 
> > +void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
> > +				      enum kvm_apicv_inhibit reason, bool set);
> > +void kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
> > +				    enum kvm_apicv_inhibit reason, bool set);
> > +
> > +static inline void kvm_set_apicv_inhibit(struct kvm *kvm,
> > +					 enum kvm_apicv_inhibit reason)
> > +{
> > +	kvm_set_or_clear_apicv_inhibit(kvm, reason, true);
> > +}
> > +
> > +static inline void kvm_clear_apicv_inhibit(struct kvm *kvm,
> > +					   enum kvm_apicv_inhibit reason)
> > +{
> > +	kvm_set_or_clear_apicv_inhibit(kvm, reason, false);
> > +}
> > +
> 
> The definition of 'enum kvm_apicv_inhibit' remains in asm/kvm_host.h.  Is it
> because "trace.h" still uses APICV_INHIBIT_REASONS?

No, pretty sure I just overlooked the enum.  I'll do another pass of kvm_host.h
to see what #defines and enums can be moved.
