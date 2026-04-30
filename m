Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A833630B1
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584839; cv=none; b=SzQ5XR+ewujPhzujjYyG9JL0YC+CKoCR7qnzUxlYj8zBTujqFoobVn7MutRRDqGkYyaobL/IFS+D7+noH7aRdjq4fqgg3GkYchVTfxeQ+jTMgjhdtGAJuQewp2S+OrcCFXHSATaLeXH0kPoZVKLJzvjUCuBvaCgLTeUTP75W/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584839; c=relaxed/simple;
	bh=JcVexfd46A8wLB97O3kRQFpwuB1yF8WZFEadUCwfhGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W0VXLdCruXl/XFz2grnemeMNncy5W1I+Pz1SXnYzHeO3f/JdlGHapDdiGJ+aCm8CtNdoc0FH7PvSQmMrdz+nudKnm24Gl8rRg9qCdJG6zfooKz/EQklQkDCe2CfjFetPxdpfkKHA0C6mAtwMoH2QTHcPhgc6IYot9eWOzaz115Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVUtdbJ7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVUtdbJ7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24611696eso9830405ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777584836; x=1778189636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHm0sEioh+jDjKJxztWR2+g8WGq2mOpd+TCLZdSB6w8=;
        b=UVUtdbJ7kzema/0crMnIlvfqYPkAcp2x3AVo7BX9g7szc0xEVUjaVGT4j1CnTYky3J
         AzRbpVSiK+K345yrHRMp5RJJU6SLcNrTLbrRvdkuJNwUSfTIgrkUiXKq1+TIA1z+V5Qf
         Bju9Aa9PkpohIQ3KEF8frRoHwN7ysvKF2W9ZxC+w3Y4OKFbmm42E+txpPYyb6dHhdKzq
         V7RkSBQUswsGpdTc8HuuhSsiOiPJZxhOdFQ/5JDGdqch6k75G8z/ZJ3I+Ww00EffBxmV
         0BwS3eiU01lCRHRWL7Gd08w3bWOLJgaHjUOBcjFdc2fPOuWh+4tOpotdMsyrqxY3OeuG
         uzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584836; x=1778189636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHm0sEioh+jDjKJxztWR2+g8WGq2mOpd+TCLZdSB6w8=;
        b=Umk6OJ6RtOSV4ZCsjIsjwQPfpEt18PQT6LrwHBVBrtqlGf5vO05Qkz30gcaoiBXnLZ
         quvrx54iwr2rpdhJd4TBsRbdiWRvjUA408LDv8XAkPxx5ezLzsvetyBXS8iuo5znCDdW
         cgh+8ezB7TlWm2J+0x4kUKlc11iMMhm8VFtUp9xZ5cCXfg3yRzaN/FCmMNjo98222sxW
         w29S9QUdV68LHZ2v/fPRcHsUnqlGoI3zWnfgVL+pyCgPG45ydEgYX6LwWC8+EuNDYrrP
         eLEGxkS4bZLBiHyLyv/TC93hFh/aoofbrtkfjphIbHZA7arC/IcrGYd3XUO+Xe1b2C/w
         CX2w==
X-Forwarded-Encrypted: i=1; AFNElJ/BdPtaYYFRF7IEcydCVJ5YpOOnCGhqr8iwKFxo+UtWFRcApwPJWg/yflES2S8STkTxK38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjyHCCSP/wcKszp72m9nitTCFF6iRcHNxQHwb05dI3Na/f+2j
	cQ3R+ck1hwUJ29VUE9HVhV3XLmByLCfk3qgpAT/aV/T0NKw4WnSLpu+IMvzOhi2ajNWnDidUUYl
	8uduLLw==
X-Received: from plpj6.prod.google.com ([2002:a17:903:3d86:b0:2b2:4d17:25c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ac7:b0:2b9:4eaa:7153
 with SMTP id d9443c01a7336-2b9a24b4fdbmr46434185ad.19.1777584836425; Thu, 30
 Apr 2026 14:33:56 -0700 (PDT)
Date: Thu, 30 Apr 2026 14:33:54 -0700
In-Reply-To: <CAEvNRgEL32Jc_FfKGqYvYJ3WZGz=PnGwwmxviCOHWaDXm6KX-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com> <20260428171541.1342335-4-seanjc@google.com>
 <CAEvNRgEL32Jc_FfKGqYvYJ3WZGz=PnGwwmxviCOHWaDXm6KX-A@mail.gmail.com>
Message-ID: <afPKwv1OLXL8gYZp@google.com>
Subject: Re: [RFC PATCH 3/5] MAINTAINERS: Add an entry for KVM's guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > To better reflect how guest_memfd has been maintained for the last few
> > years, and to prepare for significant upcoming growth and expansion, add a
> > dedicated MAINTAINERS entry for KVM's guest_memfd, with Paolo and myself
> > (Sean) as co-maintainers.
> >
> > List both the KVM and KVM x86 git trees as authoritative repositories, as
> > any given guest_memfd change has a equal odds of hitting KVM x86 or not.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 89b470db22de..9eceeb6f699d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14396,6 +14396,15 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> >  F:	drivers/video/backlight/ktz8866.c
> >
> > +KVM GUEST_MEMFD
> > +M:	Sean Christopherson <seanjc@google.com>
> > +M:	Paolo Bonzini <pbonzini@redhat.com>
> > +L:	kvm@vger.kernel.org
> > +S:	Supported
> > +T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> > +T:	git https://github.com/kvm-x86/linux.git
> > +F:	virt/kvm/guest_memfd.*
> 
> Should selftests for guest_memfd be added here too?

Hmm, no?  I don't think I want to go to that level of granularity for selftests,
at least not at this time.  Maybe if we end up with a large collection of
guest_memfd specific, arch-agnostic tests, then we could extend the entry?  But
even then, I don't think I want to go that route.

Much of the guest_memfd functionality and testing is in common files and/or
arch-specific code, e.g. a lot of the truly core functionality is in lib/kvm_util.c,
and set_memory_region_test.c and x86/private_mem_conversions_test.c have about as
much guest_memfd testing as guest_memfd_test.c.  I worry that adding a selftests
clause to KVM GUEST_MEMFD would do more harm than good, e.g. create expectations
that guest_memfd testing should be isolated and/or be reviewed differently or
something, without actually making it easier to maintain the tests.
