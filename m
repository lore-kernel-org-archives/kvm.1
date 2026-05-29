Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429793F0ABD
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079093; cv=none; b=es+nk8w1aujj7voqtUvjeJpCSggp/KGRqmUCEqoVy0rYT7Dm0D617qayDx2u7FYVcWvfPM/mpETpojI8LgmCzy/azHnpRjY2AMHBXLvTKxgYX/bffMDbSQ/FNsG/gDFRhQTArY4byIj7QW13jeBrGIAj8TxVOO0ABTA39GxgnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079093; c=relaxed/simple;
	bh=UeHE8FngsFzOqtRt38sTx5XiaHaRF+B7JZgy2Sp2ZT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkoXE+jLVchdxDqxGHL32UsE44xPh+V2dkBB+V6TyTWFIr57d6IaB/vqY3lgKAGvPvX/EL2gleWHYJhFgvCO/xFbubyEps3vJVL3vtOzIjFAXVYTf7WFE9sik3i5WTL/Icdu5fH8CM31R62IciHFMvhCNq5wCsj8Rl2eUSG2nUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5KfO4tR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5KfO4tR"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8581f7723aso170768a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780079091; x=1780683891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KC7JwfT5evfbnVHlmq0f2yFu9P+G1LslL1SBdd7A1I=;
        b=v5KfO4tRWWgX+5juf+yF6I+RRd0W6GeOAlLS5sZciCbpVWxlQEOho0r1iBU906bBxe
         Ej60RkHpjNwBJz15nHFvtYN6ehK5vuM2ePlOV1Ka1VtXxB21QfkG+MkBdkfiaPTfLqM7
         TZRQFAYlVt0C61osKiTuD202AguBbBF9P0zrqMRLuA7bQn2jjhk/6pudNmCOWhopbcum
         y1+NajxnPvAUHJpKTPdpVS2UHYPs+ZnP4YBAfbIXDnJMc8NmkaokgWenSeytyn3J4C5h
         +TfYQK1mhQqBrv6xp8tPDnzoVhHA7+DIwX2V9ZtMRuBgSd7h25/hjpAgQwfY/1Ekj0zu
         ZJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079091; x=1780683891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KC7JwfT5evfbnVHlmq0f2yFu9P+G1LslL1SBdd7A1I=;
        b=VO9yKKEDVMMARMG1Mgllejl+sSjekHOgvJ77CNXv+lYWMMJX6rSz0W93bhBGTkl4iJ
         3S59zDFH7QXAvyqi5sPTOLRLlj2kLA/ZR8SMDzYH3J7W4zvc5Hx5pSolVIOcdTRVupfu
         CQOlKxoF1BBTMC0lp8k8nquHS2It7oAD6OTBntEN940K/4sD180dts68JVb3NOx0tXkr
         LkPA3r2edNME8Cipn6CZJCUvzTySgS8WxrVtZYSjge9oG1moPpXaGthqkiqFzY/XDgE5
         FiHKViLyZ0zxihkziqtrWKM4Hj2/opkgPWn/9npnhF0i0hvVTLxWoKGFyVZSkzepxXaH
         1RRw==
X-Forwarded-Encrypted: i=1; AFNElJ9+/78K45tRatkD+G7BkFgdLT7A35liHlr502SIYnd9icBBzJWjrEz+0I3XmmluZ0uKIVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+4Y2ILrVWyqc2nYi0kO6Ao8RDBXU7xAOgfMUcY7+3nYvlong
	fF/7ZT4d7K0vzB7iR1v+Uvu7c1TI7DyQVEsH3hKk3nV8//92hmH54POI8k+FxT0DqgEyI6P9ZD3
	90kRKWg==
X-Received: from pgnb26.prod.google.com ([2002:a63:715a:0:b0:c85:71af:a857])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:189:b0:3a2:c683:fa84
 with SMTP id adf61e73a8af0-3b427f6d141mr406494637.27.1780079091312; Fri, 29
 May 2026 11:24:51 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:50 -0700
In-Reply-To: <20260529181207.5E7D81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-19-seanjc@google.com> <20260529181207.5E7D81F00898@smtp.kernel.org>
Message-ID: <ahnZ8tuHFVFTeofW@google.com>
Subject: Re: [PATCH v4 18/47] x86/kvm: Get local APIC bus frequency from PV
 CPUID Timing Info
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 4fe9c69bf40b3..c1139182121d5 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> 
> [ ... ]
> 
> > @@ -1039,6 +1040,13 @@ static void __init kvm_init_platform(void)
> >  			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
> >  			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
> >  		}
> > +
> > +#ifdef CONFIG_X86_LOCAL_APIC
> > +		/* The leaf also includes the local APIC bus/timer frequency.*/
> > +		apic_khz = cpuid_ebx(timing_info_leaf);
> > +		if (apic_khz)
> > +	               lapic_timer_period = apic_khz * 1000 / HZ;
> 
> [Severity: High]
> Could the intermediate multiplication of apic_khz * 1000 overflow here?
> 
> Since apic_khz is a u32, the multiplication is evaluated in 32-bit unsigned
> arithmetic. If the hypervisor reports an APIC timer frequency greater than
> ~4.29 GHz (apic_khz > 4294967), this calculation will silently overflow.

Hmm, easy enough to use mul_u64_u32_div() (I think that's the write helper for
this?).

But this problem pre-exits in almost every other path that sets lapic_timer_period.
So while I tried to avoid doing yet more tangentially related cleanup, it seems
like adding a helper to set lapic_timer_period is the way to go.  That would also
allow making lapic_timer_period local to arch/x86/kernel/apic/apic.c.

*sigh*
