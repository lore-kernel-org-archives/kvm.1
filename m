Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207973793DF
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171282; cv=none; b=cV6Hy64yDhv2cLG7jLBNIBp+HvNHbmExgsHNrHf2DOnjxmlnND3PFUG9rPoBl5gl12rGi3Zq0UQiZj2sGIGR9ccdd7xafaNCpC6B7HjOLRcNwf+13EqjthLlM91OishssraYeZYSS8uaYHyR3ENCgwIT6JTCrUFrjW/kIM8KIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171282; c=relaxed/simple;
	bh=2PTm1I4LtYj1YB+Qns32E4oWyIFCWmAEJE74xx20oLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oWXYY90Ao9p7GZ0DU//mbfufjCNBcDHnP+9BTEH+KSz5flBiE0cCQhWK76WiEYAlI7XQ69ZAEcSkzcgbSQdDUEdgzIBK7LJJnkxR7Rljr+zCwJPfDbut1GZXVQnd5+43k19H0Jn3Sm25cQdbz6FoPgcsGRE33CxSC+oWQ9CmdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxp7YJBJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxp7YJBJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da86144daso1184238a91.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775171281; x=1775776081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLa0GVMX6VX9ga114RP9fzeLfvZH9WQjqCx0+9dg7Ds=;
        b=cxp7YJBJJQGWJDxmsK1oAwfQuVwN57Yi+P0j2OTuYfl0lARJDLC5T+Weu+oVevD1Zz
         Kg2fdU4C6mgW/mUmlDj24cLI89Y3yWhgU9xykGIEKOUrcpGCQXXb7pJ+IiPzdxwUBgu7
         L2H/pVeplHtubRmcX9lGV8ybWw1+bvFo+HTlk1VBIQE4w/GYhLEej7vndCHKtTAX1WR8
         h2Kh8X6+bAxA9rfO3bkRXnJJpd6aqThCB8CM+I/ti54etYqmvAigRqcm9Jsdr405dq1g
         Jk9ujsqdfpsHlZubWwUh053e1auUnp4sRaFO4pmWFkIV/V3YzWZz7Ijqg6HSq5n91Mwl
         53tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775171281; x=1775776081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLa0GVMX6VX9ga114RP9fzeLfvZH9WQjqCx0+9dg7Ds=;
        b=lt8uXArNXtqIvV3G/cuFx74TY55khSw8PbFdYwvYgkYUcE964+a4GiohYqXJQVnoMB
         TiqDDvptdz35Qq/zunFX1V27KNvuAStEy9kkLLghf9sEA830ObLRumQFGtwxwbNkI5n4
         eAjcgL4U14boDNBajvc5gJu6NWxKcDPMNQcrF3p7R6igmf0czPVNfkUHMe+cyLuODDdo
         U8tjD7Aque9EiWh/4BLD16hOk3087LLiVr9CHhNTFV+4nhCwqMn+59Tn7oAMcW8ZKBgt
         QYZ4kfrNG1is9CBBRSnOnWAUvs4xWR2ymAkL64lorVFa51NLMl3JhZyp4LAIS6zzGLKH
         iGLw==
X-Forwarded-Encrypted: i=1; AJvYcCXFuxxVJD8+cfEjRxyCaKlgLaNcbx1SLA8aeNlaLYOoIH994J3G33i4Ok8rWe+RHU4m4AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHuAvoxC+3p5OGypPe1WPwq3lyRRIqIMHDQ2RU/QW5C7T/4mV
	g0EEQvNoVnC5xs5hKJ+WObDbcbrE+AlvXx9efZGXqItEFczqdpk2HOU16//UOaxJ7CNpeKZrr4/
	L07aRJQ==
X-Received: from pjuw16.prod.google.com ([2002:a17:90a:d610:b0:35d:a8d7:ccda])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70f:b0:35b:e52a:6fe5
 with SMTP id 98e67ed59e1d1-35de683b19amr592058a91.5.1775171280336; Thu, 02
 Apr 2026 16:08:00 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:07:59 -0700
In-Reply-To: <3051c067-048e-4388-8c22-1e275d8d3b5a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <8853f8d5-57e6-4ea4-b9b5-8a0182d0d012@intel.com> <abL8SW5JS1aV5goa@google.com>
 <3051c067-048e-4388-8c22-1e275d8d3b5a@intel.com>
Message-ID: <ac72z1cfXnpUmkWv@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 25, 2026, Chang S. Bae wrote:
> On 3/12/2026 10:47 AM, Sean Christopherson wrote:
> > On Thu, Mar 12, 2026, Chang S. Bae wrote:
> > > 
> > > However, that is sort of what-if scenarios at best. The host kernel still
> > > manages EGPR context switching through XSAVE. Saving EGPRs into regs[] would
> > > introduce an oddity to synchronize between two buffers: regs[] and
> > > gfpu->fpstate, which looks like unnecessary complexity.
> 
> No, this looks ugly. 

Sorry, you lost me.  What looks ugly?

> If guest EGPR state is saved in vcpu->arch.regs[], the APX area there isn't
> necessary:
> 
> When the KVM API exposes state in XSAVE format, the frontend can handle this
> separately. Alongside uABI <-> guest fpstate copy functions, new copy
> functions may deal with the state between uABI <-> VCPU cache.
> 
> Further, one could think of exclusion as such:
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 76153dfb58c9..5404f9399eea 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -794,9 +794,10 @@ static u64 __init guest_default_mask(void)
> {
> 	/*
> 	 * Exclude dynamic features, which require userspace opt-in even
> -	 * for KVM guests.
> +	 * for KVM guests, and APX as extended general-purpose register
> +	 * states are saved in the KVM cache separately.
> 	 */
> -	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
> +	return ~((u64)XFEATURE_MASK_USER_DYNAMIC | XFEATURE_MASK_APX);
> }
> 
> But this default bitmask feeds into the permission bits:
> 
> 	fpu->guest_perm.__state_perm    = guest_default_cfg.features;
> 	fpu->guest_perm.__state_size    = guest_default_cfg.size;
> 
> This policy looks clear and sensible: permission is granted only if space is
> reserved to save the state. If there is a strong desire to save memory, I
> think it should go through a more thorough review to revisit this policy.

And I'm lost again.
