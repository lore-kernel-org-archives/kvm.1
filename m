Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8923F166C
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164034; cv=none; b=sPl8PcGiHWKYGYj0lhsDKZM3vofiCm4Gw19/7cHBCd/zIT2iaRoxUVeTOegy0HR+saPdgKT9pnRPT0LBaJAAhTbG+NKLfiO1R/UQPe+GnWKLRCpEFY4yTMgFhlgJfvFdW9Uy4OXRAo4DbbjKmlbpr0b6mMj8HRzx8gZnqzBW96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164034; c=relaxed/simple;
	bh=ci8etJPJ/SKkrjI2R9pDKrxKQFfdex0fFldGF/HrBzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jMrUCTXyCQS915WksbWQdVE2qQ7c7uYjX0WySSzLLAW3HAvfK0HSlhlg7zRsno6xT5cIk4P8WysalBhzBvkzKVc9mkbCG10a30g0WQYY5T5R4TPqqRcNK28ZkVyHquWoan1O1i27yr8N7uv8BlQMCUplfLTzvwpuUbGN75K8oZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azkq2zrK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azkq2zrK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba224c3ffdso17785215ad.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778164033; x=1778768833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj82Uzb3ZmW0sa5wefEK60OOe+q9pRxyEiqyx+Qzdqc=;
        b=azkq2zrKPZCcJ6VYlf4ErhOCgOICygKjVJiEFdZ9k9cWiBLqsEFz4sSyRQFlRccDU+
         9cznLEDD2azmSKhyuBfPYHr/K0x+9nl1yKYMQangC446Uz2uZNBvrEEz7xxluLodg5Tq
         RSxwYILZkNzKA9HEShc+bZ27u7MSagFZTLmyKXRvRpceFZBr2ibEyzCzXr65Hot8srzV
         Ta1TYJwdMlNwBcH+SlJK5pM+LTlwd17FIHuxKbc2jl6nqx2wVIXSx5yy/gse0SZjtSYC
         686Q2KziVuojrmpSOxexh509ercNhJgm365CFXpoO3TZtazdgo1fCiodlisRZwQoCaDT
         OaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164033; x=1778768833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj82Uzb3ZmW0sa5wefEK60OOe+q9pRxyEiqyx+Qzdqc=;
        b=GL6xZXz3/be2hej4WMkXTNLaYbalMQjBoOasyeUXXFXSvqxjbWl165ALqxsLVWUOd3
         n1AcO5GRAL8VXboS+tnlPT65SC+yJWRvV46EZ4cdRkTtTrPQig3egTLox12A+BzZmVvi
         kl+X6p088NiLpLGVvDAPjwdumKBjp9a90BiC+BFDsX/vGZxTaQi1FRUCCl+QCfSbhoUP
         cfw34sZ0yPP/P4gPR9gNE0ceE0VunJWaV/1cNJ/5BKOCpVpfzJxi5r0V3ngbXR0GckHF
         oQQMU+txHzKMTmpkGaNFTO8Pgc2uS20TbTgslU2XJM2/x6KFMvdPzJWdjrNsx3Wy6x/t
         Jsww==
X-Forwarded-Encrypted: i=1; AFNElJ/H3JMqMA/EOXjAEgFaRyV5DMmwePKnUma6gnPG3Ou+vxjReDSCNBQtfosGenkQQMcnq38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iGyNuqb2CplfPunhlpb3gVghmNjwsHbOg0aq8TuatDQ6z0em
	asWnMb8Ur3BggOW2H6bONwRIYXy7YctHhdNqj5BVQYwCuHgGRvDVhMonh3Uk3n8eMk9PiHQMnGy
	L8sf3RA==
X-Received: from plbh14.prod.google.com ([2002:a17:902:eece:b0:2ba:5fbf:6eb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74b:b0:2ba:5f24:caf8
 with SMTP id d9443c01a7336-2ba7908c80cmr84772885ad.12.1778164032480; Thu, 07
 May 2026 07:27:12 -0700 (PDT)
Date: Thu, 7 May 2026 07:27:11 -0700
In-Reply-To: <afx7eh2ghy1_Nd34@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com> <20260506184746.2719880-2-seanjc@google.com>
 <afx7eh2ghy1_Nd34@blrnaveerao1>
Message-ID: <afyhP1dx7kzUV-D-@google.com>
Subject: Re: [PATCH v2 1/5] KVM: SVM: Disable x2AVIC RDMSR interception for
 MSRs KVM actually supports
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Naveen N Rao wrote:
> On Wed, May 06, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
> > Fix multiple (classes of) bugs with one stone by using KVM's mask of
> > readable local APIC registers to determine which x2APIC MSRs to pass
> > through (or not) when toggling x2AVIC on/off.  The existing hand-coded
> > list of MSRs is wrong on multiple fronts:
> > 
> >  - ARBPRI isn't supported by x2APIC, but its unaccelerated AVIC intercept
> 								  ^^^^^^^^^ 
> 								  access/exit?

Ya, #VMEXIT is a better description here.

> >    is fault-like; disabling interception is nonsensical and suboptimal as
> >    the access generates a #VMEXIT that requires decoding the instruction.
> 
> As far as I can tell, it looks like ARBPRI is actually "supported" in 
> x2APIC mode on AMD processors. APM lists this in the x2APIC register 
> list (Section 16.11.1 x2APIC Register Address Space Table 16-6. x2APIC 
> Register), as well as in the AVIC chapter (15.29.3.1, table 15-22).

Yeah, agreed.  I missed Table 16-6 (so many things to cross-reference, blech).

> This is probably not relevant though, since it looks like KVM has never 
> supported this.

Definitely worth getting it right in the changelog though.

> >  - DFR and ICR2 aren't supported by x2APIC and so don't need their
> >    intercepts disabled for performance reasons.  While the #GP due to
> >    x2APIC being abled has higher priority than the trap-like #VMEXIT,
> 		  ^^^^^ enabled
> 		  
> >    disabling interception of unsupported MSRs is confusing and 
> >    unnecessary.
> > 
> >  - RRR is completely unsupported.
> 
> Would be good to also call out change to EOI and LVTT handling. 

+1.  I either totally missed or forgot that this also impacts LVTT reads, and
I definitely missed that KVM was allowing EOI reads. 

> LVTT reads will now be allowed and should be returned from the backing page.  
> I'm guessing this is fine and that the hardware won't validate it as 
> LVTT may have TSC Deadline enabled (for emulation).

Ya, confirmed via the KUT test:

diff --git x86/apic.c x86/apic.c
index 0a52e9a4..b91e8500 100644
--- x86/apic.c
+++ x86/apic.c
@@ -569,6 +569,9 @@ static inline void apic_change_mode(unsigned long new_mode)
 
        lvtt = apic_read(APIC_LVTT);
        apic_write(APIC_LVTT, (lvtt & ~APIC_LVT_TIMER_MASK) | new_mode);
+
+       lvtt = apic_read(APIC_LVTT);
+       report((lvtt & APIC_LVT_TIMER_MASK) == new_mode, "LVTT mode switch");
 }
 
 static void test_apic_change_mode(void)

And given that AVIC (!x2APIC mode) says that reads are allowed, I don't see how
hardware could do anything differently.
