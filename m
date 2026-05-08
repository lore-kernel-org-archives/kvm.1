Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3A41B351
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262589; cv=none; b=EFMuDJthlN/Nv9NNCmkKgh00Qe+b3Fyg+QO3DXRULYQVa4mr9iQzac6hoUNwNS0mrS1uMDkdqsPmsvyJfKvCUV910KEUMRMIxAzYPem1q1LRV6uqbNjKUxvTi6s3xDfNj00ZPl8pvCrt9LbgPufsYFE1krqxFNuotJS4gIz74mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262589; c=relaxed/simple;
	bh=azpszHEt50YWds/eWnwMbcMea95HJ99bgZx7KOtrrco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n34oH/VhsoWKPwIFRylvFQsocIwwfa8Fm5QIzD1TEudbk+4lcduQ0VkTEIARtV6uVpTnm90hv2QPSvVtyLWsl1U6Addmqe1mQAMRs3MuTOLJtRswdygU9eNcq+w3hA8Z753RYOhf9rXp5mT5h3OrXyhERdOpnegX3aR7FR9g8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kB+Lsmpm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB+Lsmpm"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso1586916a91.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778262584; x=1778867384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUBPaySm0/z41K27rJFHQ7ttg0sofOe4TAlb9csR+jw=;
        b=kB+Lsmpm48pmgwqMwRfX6babt8SzgzeKXG9W+D3Tt47+azJmXKXU4Fzu1Kw+3vIcDV
         8/IOpOoAVZcCRI/LmA5WmNVo7iTb9dcZBosA1k/N70xoXBVFkvK9bx0Jijx3C33+MntG
         cKjuaFoXCpGrZlC0Cb8iqlGdIonuMOTVPWzb1naXwEZTmJdFonZ512s6bNdvuJIxuNty
         jEwpdk8IMozvx6yg2sRXUCBmFZg7mCAhywOgk+FMRcsOFs/BEXd4mzBoVluQz1trGaiV
         ZQ/xz/5Qfx1Wkz9eKIJYOi4mdWmF4bC5ZNo1WQnweP8CAi9W8lv1RnEB76WELs715cwy
         Ho7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778262584; x=1778867384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUBPaySm0/z41K27rJFHQ7ttg0sofOe4TAlb9csR+jw=;
        b=ZQ7vv8C3wMiZoJZO217kqI4GJdLjFJ4lBqAE6C8gNWujNb6RxsHXYK6+3rdRyojXwD
         XAgtLfXKXuI4jcU4VhquSsRm1Rsvnahr9LHLFhFSGjCYZh5TCMbFhQv9FuABXJo1Welr
         95Z96LUq05fzV9EPQyRBQa2CBosfB8ywabhloT82JvMhG6VLA94q9Yi9H3vsf+N4YoF1
         6SuW9XrWE8ghfkS57dlvyxapNUHxR1gzklZCevpbl3msw+hs/TRV9urhg/pzh9DQT4m9
         2AqX9G2dPhVwLGWpV5oP+4ZjbW05+ybfHcBx5KBA104LwBvT1pNSx4Yr/HWXXxbAenJ2
         f2tQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rDpBCcsK9pBPZzEGuRYX9oJRHEFg9j/SH5wNZpuygt8u1KA2boJNAxb4eY0CJTUHnHPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36xn0eaUIfxstOU1BS0J+5jpqGrDj4mt0zSVossL89l3oMYVZ
	TLsU++dESCYa5doUR7GfAnR7BQsLVDYSVjxo9tbMqm3/9n4VerUFpnNPm76zasFC97x1pVVGnVo
	tvCJE4A==
X-Received: from pjbeu6.prod.google.com ([2002:a17:90a:f946:b0:364:ff30:7218])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d44:b0:366:3517:1a95
 with SMTP id 98e67ed59e1d1-3664c687d94mr3776905a91.0.1778262583543; Fri, 08
 May 2026 10:49:43 -0700 (PDT)
Date: Fri, 8 May 2026 10:49:42 -0700
In-Reply-To: <af4YUUCJfp_X-bcu@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com> <20260506184746.2719880-5-seanjc@google.com>
 <af4YUUCJfp_X-bcu@blrnaveerao1>
Message-ID: <af4iNmDIW-XCuX-0@google.com>
Subject: Re: [PATCH v2 4/5] *** DO NOT MERGE *** KVM: x86: Hack in a stat to
 track guest-induced exits (for testing)
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Naveen N Rao wrote:
> On Wed, May 06, 2026 at 11:47:45AM -0700, Sean Christopherson wrote:
> > Not-signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  2 +
> >  arch/x86/kvm/svm/svm.c          | 81 +++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/vmx/vmx.c          | 79 ++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/x86.c              |  2 +
> >  4 files changed, 164 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index c470e40a00aa..bff534bd00dc 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1703,6 +1703,8 @@ struct kvm_vcpu_stat {
> >  	u64 invlpg;
> >  
> >  	u64 exits;
> > +	u64 guest_induced_exits;
> > +	u64 msr_exits;
> >  	u64 io_exits;
> >  	u64 mmio_exits;
> >  	u64 signal_exits;
> 
> This looks promising. I'm assuming 'hack' in the title is only meant to 
> indicate the PoC nature of this?

More that I don't think I'll ever propose merging anything like this.

> Taking this forward, introducing a similar bucket for all AVIC/APICv 
> related exits might help with a few tests.

I don't have any plans to take this forward.  guest_induced_exits alone simply
isn't useful enough, even for tests.  Outside of tests, I don't think it has any
usefulness, at all.

For tests and for real-world usage, we really do need per-exit tracking for it
to be useful.  Maybe with some "bundling" allowed for exception vectors?  We can
hack in one-off things like MSR exits, but either we'll have to be super hypocritical
in choosing which use cases are justified and which are not, or we'll have created
a slippery slope by adding a per-exit stat, i.e. we'd just be delaying the inevitable.

For selftests, which is really the only test framework that can utilize stats in
this way, BPF is probably a better answer, at least for the kernel, and probably
for selftests in the long-run as well.  E.g. if we can make it easy-ish to use BPF
in selftests (which is a tall order), then we can write tests that do *very* fancy
validation of KVM behavior, e.g. by peeking at other vCPU state in the context of
each and every exit.
