Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A93198A17
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776299269; cv=none; b=K3tAIvtEuZwNOBnbtsJk3ke2SUNNiqkDA6ErFeeNqkrjLbADKpACciDfmztnLfric8D5U+PzD/5+zNxxmj+JHTggdJLJM2a/IdTYrzw1SpI0EbNUAe/e3UN0xXoZ9zENSCdyXeNGPxQtWrVI15+u5ooyt5lRuZMrQw64/N00Iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776299269; c=relaxed/simple;
	bh=91KI0fJU4Wp82t2FkQOv787CBX84KoNvLOEgpOIXuqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avD7fq33HWkO0vc02485QH5C7W0Inm51/Ji1MCwgSxszb2SOwxA2MZdXSX89XA/S6VD2WIR3ftc1Z3InXQlePi2eCg8rGOanu3pOlG7RQWYxc2Ubp0l7YsJAJtvvLbU1PqEZduZiVKVmkSgLmsmLP7PsJWlYTy19nMj3tzodfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlEJmlBn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlEJmlBn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76c2bb3149so88994a12.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776299268; x=1776904068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTqHOZA62OG02ouAmiVm2b8T4YwA2WULJcljq4P/wu8=;
        b=HlEJmlBn8bkl3vcXTbtmQHwf0Rvv5xDM+j5i1xKMYNaKWMDiHwIOqB7mXKYdlPvw1F
         /ixYcTgQE2bo4gyVleEqnSUkIupbqjzMtzQtUSr9gwBQuCaufWWummn/dpU5QvqKdz0b
         FnADTR58MfaM6ZmIJRrAQ9CglwfZ56DAC3SwwkHXIzgSV6eNCA28oSWHUHhDd7dGbh+b
         aunF19em5/y9fD78b/cY6o14d8vdmtBC8Eqnn9kMXDVNeQzih6RKsxxAYf2y8WR0Pul0
         +IXWXZpc9hnidjkbACrf/xQIqJ1X4jzUTUNtu6f0Aujq5mYLcxIKjUH0pGuCn1LUQw7M
         QIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776299268; x=1776904068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTqHOZA62OG02ouAmiVm2b8T4YwA2WULJcljq4P/wu8=;
        b=hyHBtsqMfaNcPko+GodC6FlL8zx4kUGlRth0sefUR44KAyht6v1H082R4x3iA2z2E0
         lSdie3kjb/C83keiYZPGy8wP56rZAfY+pMU+kF/nsghXjlOMurkocPoq3F0AQq6HAC3j
         Hz6V1CF39GDirBgeFkOebP3Vy0q/WGp9WVG2isRj+vGhVZ7AK4j0GOcleFvIxj47eEo7
         pFtCOmFHWNmA4tpEVDxGdGQpzjW8n9qNkMfcwmMPNEkaRzXzMOcgnd9gZRG23gLiiw//
         PiLeIQW8M/QabiKurYbRZF4x/miqQrQ2luZ9xVPf8PaFJfvnkTQKoWUjv82JInkqulLM
         C0JQ==
X-Forwarded-Encrypted: i=1; AFNElJ93fxKbfflwYjoXJ3aEJbNyoqOEvBdb6d1i8as8gnmvEab+0pAyR9V8yFRAz1HD9TR9vhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyim3tDNt9MFd4hr14hhQmAboLaKoeAxbft6zw/aRoyT+rS6fv
	CGsxwqc1fLhtmEg357d21RSBuLWj8TEapkyVmNqGX5hOzjD0ruaWVMllRCBZAuIL2vhkCgheSuR
	5WTigZw==
X-Received: from pfgs24.prod.google.com ([2002:a05:6a00:1798:b0:7fb:ed58:5e4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2191:b0:822:69b2:7ed0
 with SMTP id d2e1a72fcca58-82f764130bcmr1195893b3a.6.1776299267782; Wed, 15
 Apr 2026 17:27:47 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:27:46 -0700
In-Reply-To: <9f4a3dfa2d3fa2a81161652d81585b779a182866.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-5-seanjc@google.com>
 <dea50f27311d88dcb09ea98261ca280853396a42.camel@intel.com>
 <aeAFMwBTUCdeq1JS@google.com> <9f4a3dfa2d3fa2a81161652d81585b779a182866.camel@intel.com>
Message-ID: <aeAtAm0yezpj9EP1@google.com>
Subject: Re: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 15, 2026, Kai Huang wrote:
> On Wed, 2026-04-15 at 14:37 -0700, Sean Christopherson wrote:
> > On Mon, Apr 13, 2026, Kai Huang wrote:
> > But IIRC, that's "just" the architectural behavior.  Hardware implementations may
> > choose to preserve values.
> 
> That seems to be a violation to a "basic" architecture :-)

Not really.  The SDM says they aren't guaranteed to be _preserved_.  It doesn't
say that they will be zeroed.  And so literally any value in bits 63:32 is
architecturally legal.

> > > If vCPU is in 32-bit mode then it should not be able to access 64-bit GPR?
> > 
> > Yes and no.  Mostly no.  Architecturally, they're all off limits.  But, again
> > going from memory that's ~15 years old at this point, IIRC the behavior is that
> > writes in 32-bit modes zero bits 63:32, same as 32-bit writes in 64-bit mode.
> > 
> > Take all of my memory with a huge grain of salt, it's very possible I'm
> > mis-remembering hallway discussions from a long time ago.
> 
> I tend to think it's beyond the point we need to worry about.  It shouldn't
> happen even the guest is buggy or malicious AFAICT, unless KVM somehow
> messes things up itself, in which case a WARN() is more reasonable I
> suppose.

KVM needs to worry about it from the perspective of not consuming garbage.  As
above, KVM cannot assume bits 63:32 are zero, and so needs to be careful to only
consume bits 31:0.

> This also made me look into whether how VMENTER handles GPRs when vCPU is
> not in 64-bit mode.  I see nothing described in the SDM except VMENTRY
> checks "guest's" RIP and RFLAGS.  Maybe KVM should explicitly clear high
> bits of GPRs when going back to compatible mode from 64-bit mode, or maybe
> hardware does it?

Definitely not.  VM-Exit => VM-Enter must be transparent to the guest.  E.g. if
a host IRQ arrives, register state shouldn't magically change from the guest's
perspective.  If hardware clobbers state, so be it.  But I don't want KVM to
actively clobber registers in this case.
