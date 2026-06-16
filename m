Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416A43D4E8
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635690; cv=none; b=c+Qi04y78sOF0ShM1U5IOqKFQWcn/YwrXCqycD36DYsdse1Gf40HnBWPpbVJoQO7ku4gdS1TUTHtsL1RP/XSLQKTXPr0XdFQVkr450h3RJvwNi887GF+p7eW6wTY4iG6DYmlf6C+W3d4Fj8KAcsSm7V8noZ+AuGemDdLwmLbCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635690; c=relaxed/simple;
	bh=Xx05wp4cyHtf9W47TC/Dwjp1vIDUaS1Eegfg4Ib+/tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uX9YmveHQlCipJMjBAXRjPnd3cP3X2HJrZn5H3TG+sA4TETA8LbitsDl7Q1cREQJWEgFS8e0Ha2RXuhrzsslnFjm11V57RSSyk9+D3R7Ojx5CxG0jSgqWupisyMZclwBRm+/WihCm1gw8Ku/L4b35Dj86oTYKpKgnNytV4Fu/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Esf9WQYt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Esf9WQYt"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842208d5b0eso3886081b3a.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781635688; x=1782240488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3dgH42zNflWYjVlKpWQxlbi6GFJLYhVFZGxy7D/Xxg=;
        b=Esf9WQYt7SS9xIbABVXiDRjexvP32v+fGndsyuIjrBhBtvevnfJKio+eWQCj2PlVDb
         kFTmm+T2bQiPYwHPyOpEygFHXSphr+IjkZYmpMQbLTe0A7okl7fnFFtb1ZapiPpeApr4
         j/j1PXOxn/aCSxuYnbverME4dAIzioOfaRyHslykQPDqpmLYBeySsAmRHfTO4fJN/pQq
         mbMZXYZgQODQctWmPBd8JcurGeUbehH80X0yL4KUyf1aGHAoQRQjxA+EKAhca3f9JhkP
         4qYVGK1jHRTVQApPRUKoF7J0wpf1b+GQ70psXzQ6rzs8RiI/rAOOwF8IMSLCilkGDKQw
         WlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635688; x=1782240488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3dgH42zNflWYjVlKpWQxlbi6GFJLYhVFZGxy7D/Xxg=;
        b=S6lTwNEiacbxrfJWTlZ92KhOKGbZGw3+C3f0jJEUKanJ5twj0PaxOGJSpsQrjqiH9O
         OQAIC7lr/HIMrVkqrjvvEC64HSCmEmTEKdJq08ESNb9uNPwWfEfK1MFpm4R+PU9YlnEb
         FoEpvymQviwSSlEl9oAfA5zDCZAbsoNe3p+xyWS8qC+V/GWWOX4TvZJUr4+qfpWBi5Cn
         M3cI5ObJ53S0LRIL+OLQoLdmdk+QC8QD5WAvXV7qDOAdfDiNcE8AP2T73qJTrcXbb/+o
         0C5wtUtfwUsmCu2CrtnXOQTNNbrpxG8e4ncOeL80nUtL7ELxX8a1GbPVvVoZviymdEUQ
         YSpw==
X-Forwarded-Encrypted: i=1; AFNElJ8jXx6mfBvc5k/BIB8TctwYeLF+GY/ihX7zqqoXrPo4pjmn1FzNMWwnuOPrQXM6AQDlHGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0mnCZspD4F1g5z6GE34NW7r5m0ZEPWs6qKhaHFJw6JJegQZe
	DKTfwBI9XLN6DHN7lIfg3TfEfVYAAqt2vU+uKe3oEo4+wKpI1yd1s+iLncOZFgVt2sRfr5YeGt6
	K+IpCpQ==
X-Received: from pfbih9.prod.google.com ([2002:a05:6a00:8c09:b0:835:3fa4:894a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d25:b0:842:6f13:1461
 with SMTP id d2e1a72fcca58-84524476bcdmr384546b3a.11.1781635687806; Tue, 16
 Jun 2026 11:48:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:48:07 -0700
In-Reply-To: <CAEvNRgH7Lk=z9NqcY4OZXv=y5SeCZHnDNcB0=kHfarjCA4ZPTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com> <CAEvNRgH7Lk=z9NqcY4OZXv=y5SeCZHnDNcB0=kHfarjCA4ZPTw@mail.gmail.com>
Message-ID: <ajGaZyAcDv5j3nFc@google.com>
Subject: Re: [PATCH v13 00/22] TDX KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Ackerley Tng wrote:
> Lisa Wang <wyihan@google.com> writes:
> 
> > This patch series focuses on setting up a TDX VM and adding all code
> > necessary to run a basic lifecycle test.
> >
> > Unlike standard KVM selftests can set up the VM through guest registers,
> > TDX module protects TDs' register state from the host. This feature of
> > TDX causes problems on VM boot state initialization and the ucall
> > implementation.
> >
> > In standard KVM selftests, the host directly initializes the guest state
> > by manipulating Special Registers (SREGs) and General Purpose Registers
> > (GPRs) via IOCTLs (KVM_SET_SREGS, etc.) before the first KVM_RUN.
> >
> > To bypass direct register initialization by the host, we utilize the
> > standard x86 reset vector as the default entry point.
> >
> > The mechanism works as follows:
> > 1. The host places register values into a specific memory region and
> >    inserts boot code at the VM's default starting point.
> > 2. When the VM starts, it executes this boot code to "pull" values from
> >    memory and manually set up its own SREGs and GPRs.
> > 3. Once the environment is ready, the boot code jumps to the guest code.
> >
> > The standard x86 ucall() implementation uses PIO, but it does not
> > actually transmit data through the 4-byte PIO data. Instead, it relies
> > on the host reading the ucall address directly from the guest's RDI
> > register.
> >
> > TDX selftests cannot utilize the standard x86 ucall implementation,
> > because the host is unable to access the guest's RDI register. Based on
> > this restriction, we considered these potential solutions for the TDX
> > ucall implementation.
> >
> > 1. TDCALL PIO with RCX-bits Passthrough
> > We first considered passing the RDI value through RCX bits to bypass the
> > hardware's register protection, which could be the closest approach to
> > the non-TDX implementation as per Sean's suggestion[1]. However, this
> > approach is blocked by the software-side implementation: KVM_GET_REGS
> > currently does not support TDX VMs and returns -EINVAL. To make this
> > work, the KVM ioctl would need a test-only hack.
> >
> > 2. TDCALL PIO with buffer indexing
> > To keep a PIO-based approach and unify the get_ucall implementation for
> > both TDX and non-TDX VMs, we considered TDCALL PIO with buffer indexing.
> > Since the ucall buffer is initialized prior to execution, the VM could
> > just pass a buffer index rather than an 8-byte ucall address to fit
> > within the 4-byte PIO data limit. The host, already knowing the ucall
> > buffer's base address, could then resolve the ucall content via this
> > index. We abandoned this solution because it would require changes to
> > the common ucall structure and impact other non-x86 architectures.
> >
> > 3. TDCALL MMIO (Selected solution)
> > We ultimately selected TDCALL with an 8-byte MMIO data. This method only
> > requires initializing an MMIO GPA and adding TDCALL MMIO implementation
> > for TDX under the original x86 ucall path. While this diverges from the
> > non-TDX PIO, it provides the cleanest implementation with minimal
> > disruption to the overall ucall architecture.
> >
> 
> Sean, Lisa evaluated your suggestion [1] (summarized as 1. above) but we
> think TDCALL MMIO is better, what do you think?

I think y'all should have responded to that thread with "that doesn't work
because host userspace can't access the registers".  Reviews are multi-way
discussions, not one-way streams of "do this".  And the expectation is that
either review feedback is addressed in the next version, or the dicussion is
closed/resolved *before* posting the next version.

Remaining silent and then writing a thesis in the cover letter of a future version
of the series is very inefficient for everyone involved.  I obviously don't read
cover letters all that closely at v13 and I gotta imagine a *lot* of effort went
into the above (which I greatly appreciate!).  The paper trail also becomes
impossible to follow, because anyone reading my response would probably make the
same assumption as me: it was a viable idea and that's what we implemented.

I'm a-ok with using MMIO, because yeah, there doesn't seem to be a better option.
