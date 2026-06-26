Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B43F8250
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484599; cv=none; b=KHGhqECXCcKC1oovtKJmSIfjHEDN8lR2eAYIqDUvwNlz5Ty8qMkUpL+X233Ssqnu1prBdgf3CpTINXTHPbkU+kcmIffI2oDNqgpp2TWeVxcLVtuLH0EU7z8WQPnlv5jOS8IMI2Z+v5gynNwsXLjL/uH/h9l26y8LL2pKVgzZukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484599; c=relaxed/simple;
	bh=3hWmG+tA03LYJv/XcbbvqJo3zymlC5xeIlxw9AzG4iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vAEAUSelDbMif+aUgI1DpzvBZjJvvQueLGLSrI9KCS1gNXBFieOs9KlM21BWU7LAlXNv+8nbolt0t9B9LochlpAjLO3LvrmiU1Ab4+xdsQYKS4YnPI6JxT/GV4vDWqwmdEn40lgcYxN4+9o49IMzm8JgFqxnBf96CYRKhrsZubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMNCkc5L; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMNCkc5L"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so543229a12.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782484598; x=1783089398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHB0fdKnr8+8chWcl/LA1xZMu3z8MHB7fOVr6aCL3fQ=;
        b=gMNCkc5LzAF6nrsmshPNsPNCQNPEiFCvkUsRYkPxALv7mDxdGIaV9B95Hu50If1uvV
         ELvhzUB3GuVHtPuWfjuB9bPNB2SU9Q0UC3sDZcZwC8g0/5o6dMAQYjxr+xA3eKTawJvu
         VxqHgeyxHzDhAMg9zB9oB29HPWsDGqNUTvDtZRsaOB+1qrvdzl91zO7GwHi4uUzLsiJJ
         6n3JipEtdAeRaC9J/iDRVZLYIP+hHcR+7Bb0vL38gYHXSlogOYTqhXxBo1SDNEKEQYFJ
         KPwVKUDhLum4rDk2otG4niP2Hn4489ORGTYGsecd0mIVgzoeank5418Dau/dgFNh++XX
         sxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484598; x=1783089398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHB0fdKnr8+8chWcl/LA1xZMu3z8MHB7fOVr6aCL3fQ=;
        b=Y3OsLIDVbGA5N+zQRJd8+0WCJCgbUA215FHDrLnGdcN6cgOcl76ai1M+txXv+oIzOB
         /Ydh7JALZw2qWLa0yXaOhBG/g5CDJ1XGJ4I8uoxXKt0521B9WdPOWOgGvodKIvwlNhs0
         o138L0Rssug1Tm+QBtlm9NLojr1N0honMdrUTpM+tVkN3ditZAj45nwWiYiwrm3Bfpnz
         XOfoLNJU/tLYaVsbEFg5EZZCHsM9A6iU1vmyErA6uOQ7P80Gr1AZ4sgiozbSGaAmJZyF
         PqqICkBEiHPoIU8O98juGTb8LyEnodxWM52o4NA74Ckxvx4+uD9d2EvTbLQpBLMQ1v4G
         vGAw==
X-Forwarded-Encrypted: i=1; AFNElJ/bFFMHy72zrBodJemGuzXMZy7aBV/hQIWa/cjYLwBKcOC6mZh4BRRF1L2reMVgjKaOn+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYQn/FQbEQkvvce6nrFBr60iyduQ/kKZOcAqWJSCu8nplH2R2
	PQPxY73Ia2tRASxr1nuW77TGKbDAQigQtprzcRWZ8+nD9O+gdkODt1VWeXlCy1QaW8o7scYY6+c
	pw5MDGg==
X-Received: from pgna29.prod.google.com ([2002:a63:705d:0:b0:c7b:b2bd:6cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4e01:b0:3b5:6b5a:4f28
 with SMTP id adf61e73a8af0-3bd4af047ebmr8411729637.34.1782484597661; Fri, 26
 Jun 2026 07:36:37 -0700 (PDT)
Date: Fri, 26 Jun 2026 07:36:37 -0700
In-Reply-To: <4be83098ac73020458d6ca2f38f4a8fb8de9d4be.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com> <20260625220450.3354415-2-seanjc@google.com>
 <4be83098ac73020458d6ca2f38f4a8fb8de9d4be.camel@intel.com>
Message-ID: <aj6OdedUwa14vikU@google.com>
Subject: Re: [PATCH 1/9] KVM: x86: Move the "APIC attention" macros from
 kvm_host.h => lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 26, 2026, Kai Huang wrote:
> On Thu, 2026-06-25 at 15:04 -0700, Sean Christopherson wrote:
> > ---
> >  arch/x86/include/asm/kvm_host.h | 10 ----------
> >  arch/x86/kvm/lapic.c            | 10 ++++++++++
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index b517257a6315..9ba8aa739f93 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -290,16 +290,6 @@ enum x86_intercept_stage;
> >  #define PFERR_PRIVATE_ACCESS   BIT_ULL(49)
> >  #define PFERR_SYNTHETIC_MASK   (PFERR_IMPLICIT_ACCESS | PFERR_PRIVATE_ACCESS)
> >  
> > -/* apic attention bits */
> > -#define KVM_APIC_CHECK_VAPIC	0
> > -/*
> > - * The following bit is set with PV-EOI, unset on EOI.
> > - * We detect PV-EOI changes by guest by comparing
> > - * this bit with PV-EOI in guest memory.
> > - * See the implementation in apic_update_pv_eoi.
> > - */
> > -#define KVM_APIC_PV_EOI_PENDING	1
> > -
> > 
> 
> Nit:
> 
> 'apic_update_pv_eoi' is a typo.  AFAICT it even didn't exist either when PV_EOI
> was initially added in commit ae7a2a3fb6f8b ("KVM: host side for eoi
> optimization").
> 
> I think it's a typo which was introduced by that commit, and my best guessing is
> the correct one should be apic_sync_pv_eoi_from_guest().
> 
> Btw, the comment isn't easy to understand either IMHO.  Maybe just delete it (in
> another patch perhaps, if it's worth)?

I'll "Opportunistically" update the comment as part of this code movement; the
formatting is also all kinds of funky.
