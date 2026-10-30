Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386632;
	b=R5E68pSKs2k11isRSZr2O8Qx4ckxmjrtENJZ3t84FBN6/rzpvCVuSuvRGq+T8y6PLZCb
	 gSb9L6gpWfzMbaqc6E+6sKL5wdeQG1dD2feaVIwTjs3itGvM5P/+sgQ64aM35Mmb/plBW
	 p3wjNiawS25sRaWpZpjQ3TlN+TGtmMv2i1rSI6e8KoY4KEDW1hNiWM3yLVKFcKnoZLAjx
	 NlV8LPID+w0ZxJ6Kf8maALcuGgLCuKy28tnWvmRNEjfPBUOza3urzwknmOvMMQbPZWh7D
	 YGGsQDmzRSdAwAtF3JwzWTCtACQ5XwQo3AZby7QdP9jfNfKqg2LZAvnhT5Zqx+Yj2qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=AqsM43MOtFOSSZV0EEwrjw089w0rw12SYsGwf7bUH9w=;
	b=KfUtq5Sa8JAhb8hoEycugBn5p85lw0A1vxRfOzEBndoNFxfaRBaZ2gSmz5K7QjZcoQK3
	 uI90xk0HCZxcbtV/sQESFO7Rjs1PXL/vgYnCDmeFTcoA1L5FlO/lJdHAM+isPjxPP9zvD
	 9xLHy6JficNNAryaqjfLxjDJmJ0/1u7zLg6bACiEcdfx7yfphh4E0hoi4kULXDj9nXGjn
	 QRj1dbVPWTnLNob8rwJbdMTXm2YkS9IJ5EQT37wJKzu+NexmsMHc81+cu6ng+7kuk9Pb1
	 I9lTyPkHC6LM6OXQ12+h55k4eTuCrZgflVuzz2XtOLpm6abaTtJdtzp2LfkvMyGZvRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KGbcCTq3;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDB606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KGbcCTq3
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so1661899a91.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793386631; x=1793991431; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqsM43MOtFOSSZV0EEwrjw089w0rw12SYsGwf7bUH9w=;
        b=KGbcCTq3/YKhRrX1UNf7Ho4eL476BVmg9txOYH/svCVz6IiaE6aABPJBZY9TV0MDLu
         EwdjM1CqURyrxWWE78SIO2SAfw2XROkXNMSZRFaie+TolrQaGOTn/IwGs8CJAAPvx3uq
         rSZiRDbKarXCKtUcTuqWMLxiXg+dIyeCbXVT3Gabdju8Tnjv7MEULhI52uT+ME/T5Xfv
         Umq3zMQlrqUao1CzOqyNXt8QEBzDhGZvoKu0F2Ormzv+fJIw++NhRjV5ofr6tGNoKwPj
         pOSmkuylFhQSblVQVtsohxGsX6qghDIcik3c9VsBAuJ/RdE2WznezUukCTqrOmLnOBWq
         WzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386631; x=1793991431;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AqsM43MOtFOSSZV0EEwrjw089w0rw12SYsGwf7bUH9w=;
        b=gikJs39EPKgK4DLDBpAkV5ZovB/ZbcCGWgPIt2p6CDm8bTNj2cDJiKbmwkhZyqIsYG
         VsdmPyb9PrMmBj8dRYB13hVZVOsbJ0KkkpDdC+kXdDB+UFekKLzNLyMVYLLjYeAIu+B3
         x37SjaP0K2GYQDSWORxJqtCKzUCgOFPn2Y8qTP6Q8qDmXK9U9hKYT6wGfpoGDWrvYaTe
         4ySPzDhfk83A02galnLhXY26Yn7kGktfntHVhN5SuNYXXxH+RPxLU3oWALbSM/YY3O3N
         DJ7dhj9dXlsOR86aTM2UF4sya1SNbzE1lMwqekzAnWyzPkj67Zer0mv2H6LuCqiDmoxi
         lydw==
X-Forwarded-Encrypted: i=1; AKwUvBzsCXnYTg8JTAjkgYgBU/TM0Fz5KtYrKGEFFNxGa0uMIMX4NgC41yeI67Nk76j6cgtHUcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXEBail91C3umt0xdJ7J76lHfoHhWRbXR/TTJ3sS6/zpDIxY0J
	s/1GI0SBjtEIFgfLjUUMQX7ISCNQwh3c0BdjL9BUiVdnESAfmM6qyNNSsiEIRK4O5qna3enQUPT
	7KEuaLw==
X-Received: from pjbbo5.prod.google.com ([2002:a17:90b:905:b0:3ac:24b3:3484])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2c6:b0:3ac:b3c7:de04
 with SMTP id 98e67ed59e1d1-3ae897aa752mr1800362a91.34.1793386630946; Fri, 30
 Oct 2026 11:57:10 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:57:10 -0700
In-Reply-To: <auStM0rbFol79h5o@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com> <20261028190259.1819571-4-seanjc@google.com>
 <auStM0rbFol79h5o@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
Message-ID: <auTohixp3V5-vNsB@google.com>
Subject: Re: [PATCH 3/7] KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Gautam Menghani wrote:
> On Wed, Oct 28, 2026 at 12:02:55PM -0700, Sean Christopherson wrote:
> > Explicitly force an IPI when invoking kvm_vcpu_kick() directly instead of
> > relying on kvm_arch_vcpu_should_kick() to unconditionally return 1/true.
> > This will allow dropping kvm_arch_vcpu_should_kick() in favor of
> > kvm_request_needs_ipi().
> > 
> > No functional change intended (1 || 1 == true).
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h | 13 ++++++++++++-
> >  arch/powerpc/kvm/book3s.c          |  4 ++--
> >  arch/powerpc/kvm/book3s_pr.c       |  2 +-
> >  arch/powerpc/kvm/booke.c           |  6 +++---
> >  arch/powerpc/kvm/e500_emulate.c    |  2 +-
> >  arch/powerpc/kvm/powerpc.c         |  2 +-
> >  6 files changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 169ea6a7fbad..bbe7378ad0ef 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -30,6 +30,17 @@
> >  #endif
> >  #include <asm/inst.h>
> >  
> > +/*
> > + * TODO: For unknown reasons, KVM PPC has historically ignored vcpu->mode when
> > + *       determining if kicking a vCPU needs an IPI.  Either document why that
> > + *       behavior is necessary, or drop this helper and the @force param from
> > + *       __kvm_vcpu_kick().
> > + */
> > +static inline void kvmppc_vcpu_kick(struct kvm_vcpu *vcpu)
> > +{
> > +	__kvm_vcpu_kick(vcpu, false, true);
> > +}
> > +
> 
> AFAICS, there is no reason for PPC to always return 1. I was looking at
> the old patches on mailing list and found this - https://lore.kernel.org/kvm/0FEE585F-5E21-47F2-A3F0-AD0DE05EBB43@suse.de
> 
> ```
> How about we return 1 for kvm_arch_vcpu_in_guest_mode() on !x86 always, just
> like it's done today basically? Then we can worry about needless IPIs later
> and don't regress from the respective current kick implementations.
> ```

FWIW, I found that as well, but there are a metric ton of kvm_vcpu_kick() calls
that have been added since then, and they scared me.

> However, I'll do some testing and get back by mid next week to make sure
> there are no suprises.

Thanks!  If we can drop the PPC behavior, that would be wonderful!  Though if
we do that, it should be for 7.5 in a follow-up (this series really should go
into 7.4 due to the SNP issue).
