Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DA313267
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495850; cv=none; b=SiRJPPtpKVVplniTZyd5aMi1nSoExXLTADLsn5UbPiUl8xlMQP9ZcomjNkUyvYth/K9lMPNKHgtYy8GNV5+mqMIU5xC6BIO/ZheLis4dKdVgZAOxOHCjF8EnEhTVNEvSmVOqmH5KXS6OQ+W2Q5Mwkxr2vVs9K5iKhLocyuJbH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495850; c=relaxed/simple;
	bh=dZH83dnWqFQZBH4TCneOWEI1FdJ/Xc+aREK9p21HaGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GcPHs/kJafinEIWmvQ0DVDasqbOI59pdSQp1uZWa3DE0/nhO/vcyAsyyiMd4C4zPIocV81MlJZzwU8W7J6/8MuzGqlKWXuDiHoPYzk1HdiYpnCnL3O3bIXlaW0+CQxHFOt1yjk9e4R/fQOR/KqFdcdyxf009gMnXUSq/qG08oEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZEX9djp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZEX9djp"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso709889a12.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782495849; x=1783100649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dr+cAQjlxK9J0anKzSl02P88CUSXvI+FBAmvBxzT1Qw=;
        b=GZEX9djpEWr2xySmaCiYJ3/k/x3aWxthJK3U6hs8P+SwPO2DCH5LrTy75wH62i7vjv
         N2ZiBtMovsKtwSL+G+VXcyhGD5P9g48NRphDPbzqfdhGFhH/vr9E0OYZY5LjwO7lAIq4
         IVGJMQO1pmWPqdJVLE2q6eGJrRbN4XI9BiMk+44jGcebz9bKUzxQvC09lmLcQDG516UH
         5Ks3I+u0qwmzO+3Vx9t9QGFN7loY+8V/CEWtkM0FRhJbY1qzQvGAgMU4YwHotX8n0b64
         72oaiOvCmMErWO6pAlhGiDN80F9w4N2GZ/gkw4gP/pZvqHweQCHKuWCn0N6S1sjqcADj
         WhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495849; x=1783100649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dr+cAQjlxK9J0anKzSl02P88CUSXvI+FBAmvBxzT1Qw=;
        b=F4KNUU3mTG50DkpjdYA2UfIJ64r54O+bC3Ug9adbciuiyrN1fzdQnSOD8Q0T1OG8MY
         4MqsK/U7j08XEyjNfcw9P25nwvRBRuPXfrpI8IRYJv3g1F0L0GHB9jAsBiCjJ+/KZdGD
         4TC2sRE04isHEo6Nckpj4OOGB1O+gmsXBjYgVl0sZJejgwFE1UwCGFddrc+FP9SsP/Nn
         It09VsCjWp2anYVi4whnpqb8G72SsbCaPBtZTqcJGdCnoJJutCp05/FechzPE64fDwvU
         62WkFDVGQ6Ry/kj5GtQsseYpe15UEqNzeiug2ULORprmsoxF41+AEEWw7wD4ceG5UgVI
         3T5A==
X-Gm-Message-State: AOJu0Yw+60bIjHV2nDuoN0RPuqrpnhfOW09fxAAaZQg6nQcI/+dV/IzC
	Ricn1jQBCh3qy0R/Kw6gsTDznxOAoqpsvXwriHcubhI3vfKfr4O5Fmzqr2SSFw7lOmPcdjeLiLR
	PRuR7+g==
X-Received: from pgac16.prod.google.com ([2002:a05:6a02:2950:b0:c79:87d6:650a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:330e:b0:3b4:895f:6ac8
 with SMTP id adf61e73a8af0-3bd4abed610mr8770284637.3.1782495848588; Fri, 26
 Jun 2026 10:44:08 -0700 (PDT)
Date: Fri, 26 Jun 2026 10:44:07 -0700
In-Reply-To: <20320c7b5e6e9a01f2607761c934bf47ec8e2f64.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624220516.3033391-1-seanjc@google.com> <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
 <aj1KP2h49GzfNHFz@google.com> <20320c7b5e6e9a01f2607761c934bf47ec8e2f64.camel@intel.com>
Message-ID: <aj66ZyxVdLjF_0dc@google.com>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, Kai Huang wrote:
> On Thu, 2026-06-25 at 08:33 -0700, Sean Christopherson wrote:
> > On Thu, Jun 25, 2026, Kai Huang wrote:
> > > On Wed, 2026-06-24 at 15:05 -0700, Sean Christopherson wrote:
> I was kinda thinking whether it's possible that there are two IRQs when
> vCPU.pv_eoi is active (e.g., one in IRR and one in ISR, with different vector),
> but from the code right it's not possible:
> 
>         if (!pv_eoi_enabled(vcpu) ||                                           
>             /* IRR set or many bits in ISR: could be nested. */
>             apic->irr_pending ||
> 	    ...)) {
> 		return;
> 	}
> 	pv_eoi_set_pending(apic->vcpu);
> 
> The reason behind this still eludes me :-(

The PV EOI stuff is all about eliding the EOIs in the guest in order to avoid
relatively useless VM-Exits (this pre-dates hardware virtualization of EOIs).

Instead of having the guest explicitly do EOI, KVM sets two flags: one to note
to itself that there is/was a pending PV EOI, and another that's shared with the
vCPU to track whether or not the guest ack'd the pending PV EOI.  On the next
VM-Exit, KVM checks its internal pending PV EOI flag, and then does an actual
EOI on behalf of the guest if the shared bit was cleared, i.e. if the PV EOI was
ack'd by the guest.

The irr_pending check above effectively disables PV EOI, because PV EOI only has
a single bit, i.e. can only track a single IRQ, and because KVM needs to know
precisely when the pending IRQ is unblocked, i.e. can't lazily wait until the
next VM-Exit.

> The CPU cannot execute another vector in ISR until the highest one is EOI-ed,
> right?

Nope.  The rules for delivery, i.e. for moving an IRQ from IRR => ISR, are that
the IRQ's priority must be higher than PPR, the exact IRQ isn't in-progress (i.e.
its ISR bit isn't set), and that IRQs aren't generally blocked by the core/CPU.

From "12.8.4 Interrupt Acceptance for Fixed Interrupts"

  If the local APIC receives an interrupt with an interrupt-priority class higher
  than that of the interrupt currently in service, and interrupts are enabled in
  the processor core, the local APIC dispatches the higher priority interrupt to
  the processor immediately (without waiting for a write to the EOI register).
