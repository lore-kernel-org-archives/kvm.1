Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B3283CBF
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679200; cv=none; b=Yd+2J5xwx6TF4V+drEIPcwIjYe32tpzFubTW6O+f/gpUqNNK6PkgxTDlSbJC4DETW55SW2gxF7C3pLOCabAVWZ8EcQv/ppXBG9F7Cc1PyigylNtSHsJP1RGZr2aAVFM+wjdAUQaNvrhXmeB2xM6/V9d9Lk/PSTY3/ks1IVROgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679200; c=relaxed/simple;
	bh=TNbklHeYHcpqpM9UTyBxSWqw/9dvHcS5U+9nJcmR+yg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3uSTx7GqKUj37hjRlpyx4oQ1n5JZoNMc+cgv/4AYRM6lZtO4YgW8iPZUCOekp+6Jq/mj7Y+6VIqeeLYBMj/ZrW92/CU0vkGkA/21uZJ4aAZlHd01z/VYiaHLq36uZ0+ZAQi5pnLZwSh2So8evjTMrtsgQ4zCdX8/aw2woa8DWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7FNfWUW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7FNfWUW"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d0d71c61so4078966b3a.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778679199; x=1779283999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIyPcCLpUhQKPDYg23GAR6dNEQkbBJgAxHGqsbaciNg=;
        b=O7FNfWUWjD8YplnzDRHqlb87Y10xmFSZTwiK3clzmt3m+msJG+nKIAb2YwMIkkVP/7
         BebLulBjOdLSX7mNE7Z8Mpi1Pr4lx9qZfct7lkYPCGNetqZ67ZT4k0H/wJrUzmq5H3nA
         B/c4xo6Oh5wj3d1aqUHnO5h4BWhYSrByp8RVH9LdepOhnyt2MGNZ6iPMOhYGGhGQJnxb
         aaI5FJZGJCYFE4znACArjcCgkP9SSuf0peMvhilIB2S7tmtKHm6C21ws/GUtAg/9oaZo
         XLluxsRSYvoq0+KSG0dBoT3hgbJ8M3B25drE9kbShsDmNjq/GzpZeHEV2shJ1L8LWReJ
         MUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778679199; x=1779283999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIyPcCLpUhQKPDYg23GAR6dNEQkbBJgAxHGqsbaciNg=;
        b=UI76wL9UcFEyfRyocZwJZJbtwOz0lsPAT0MptPOI9j8ZUC56BPu/ODBNX0DwK1gXZf
         NjnXvAfSSm0zgEBh60mxtYmeCcyzvmxypz1cyUQbQvobUp72BFg2Z3pHY/st8SupRBKZ
         k4uV+8EVHsFU4tBKDwdazcpY6hDtnu/Spz7doII7xLDmTEIOBYN1UAbgpvP2YyVx/1E5
         KojDQDhVB98EOTj0o/mL5pObfN4cWx/nzY4YiyB+5fyfqagjCHOXDSlc9cDZOTXYEVOR
         WTFtKg9NcFevlw3NUjOX3M42JjadF4I0E6ezR2f4FvwbKNGtFOl5sDviN+372GaSzaHx
         B+Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8gTXiS0rrZs9mxv0kE7aAwd+a6AeCarBWgWqqQ4yVrHI1IonsV38ZpWMQsjr4LViVaGBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5exmP6d1JcC+RmryBIAH8rse/Hjxb6Hpb5M+l3LjT7SENbv/
	GmyWaA2sye5MpXPWvPLDGk3FTN4/l/5LZ8VwsSjDKvW4i8DYBVXkZ67Ue9tMGVMj3U2h2pGERUV
	I8YijLg==
X-Received: from pfhx22.prod.google.com ([2002:a05:6a00:1896:b0:82f:5a4:a02c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a93:b0:82f:3436:42d7
 with SMTP id d2e1a72fcca58-83f03e921c4mr3567187b3a.2.1778679198379; Wed, 13
 May 2026 06:33:18 -0700 (PDT)
Date: Wed, 13 May 2026 06:33:17 -0700
In-Reply-To: <agQKffJ5Mp-5ussq@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com> <20260506184746.2719880-4-seanjc@google.com>
 <agQKffJ5Mp-5ussq@blrnaveerao1>
Message-ID: <agR9nc21EQ3gp-D0@google.com>
Subject: Re: [PATCH v2 3/5] KVM: SVM: Only disable x2AVIC WRMSR interception
 for MSRs that are accelerated
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 13, 2026, Naveen N Rao wrote:
> On Wed, May 06, 2026 at 11:47:44AM -0700, Sean Christopherson wrote:
> > When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
> > actually accelerated by hardware.  Disabling interception for MSRs that
> > aren't accelerated is functionally "fine", and in some cases a weird "win"
> > for performance, but only for cases that should never be triggered by a
> > well-behaved VM (writes to read-only registers; the #GP will typically
> > occur in the guest without taking a #VMEXIT, even for fault-like exits).
> > 
> > But overall, disabling interception for MSRs that aren't accelerated is at
> > best confusing and unintuitive, and at worst introduces avoidable risk, as
> > the effective guest-visible behavior depends on the whims of the CPU (the
> > behavior of x2APIC MSR writes on at least Zen4 doesn't match the behavior
> > documented in the table in "15.29.3.1 Virtual APIC Register Accesses" of
> > the APM).
> 
> Revisiting this:
> - As far as I can tell, the guest-visible behavior looks to be the same 
>   with/without MSR interception?

Ya, except for a quirks or two, AFAIK the guest-visible behavior is consistent.

>   Did you see different behavior for specific APIC MSRs or across Zen
>   processor families?

AVIC has at least one quirk that is guest visible:

  commit 5a7c7d148e488f43cf9c8e64fa5e1bd715ae0485

    KVM: selftests: Play nice with AMD's AVIC errata
    
    When AVIC, and thus IPI virtualization on AMD, is enabled, the CPU will
    virtualize ICR writes.  Unfortunately, the CPU doesn't do a very good job,
    as it fails to clear the BUSY bit and also allows writing ICR2[23:0],
    despite them being "RESERVED MBZ".  Account for the quirky behavior in
    the xapic_state test to avoid failures in a configuration that likely has
    no hope of ever being enabled in production.

And then there's KVM_X86_QUIRK_LAPIC_MMIO_HOLE, where the guest might see different
values on reads from the vAPIC via MMIO when x2APIC is enabled (I forget exactly
what happens on what platforms; the "hole" (lolz) thing is a mess.  But that's
obviously not related to the MSR intercepts.

And in practice, no real world guest cares for either case.

> - The main difference with x2AVIC looks to be about invalid APIC MSR 
>   accesses generating #GP directly in the guest (but that wouldn't be 
>   guest-visible). I was pointed to this statement in the APM Section 
>   15.29.10 x2AVIC:
> 	x2APIC MSR intercept checks and access checks have higher 
> 	priority than AVIC access permission checks.
> 
> Note the "access checks" qualifier, which covers the #GP seen for 
> invalid MSR accesses.

Yeah, the behavior makes sense, and I'm not surprised it's documented *somehwere*
in the APM, but "Table 15-22. Guest vAPIC Register Access Behavior" really needs
to be updated because it's flat out wrong for x2AVIC.  E.g. either add a separate
column for x2AVIC, or tag/qualify AVIC vs. x2AVIC behavior when they differ.
