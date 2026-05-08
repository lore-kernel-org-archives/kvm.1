Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA2336EC0;
	Fri,  8 May 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259820; cv=none; b=VVzqtyJSnksWPIHG4/yCI45tho1dJUCVFQl/doG87rBfD5Xj+buHoQyNfuhX72ydRQR1lSgIv9otxdZjf/EOpVT08RirB/2Wa/oqoBkNiviYl6kzUzYxAJKd8yRGx5vF0/EctQxgeNavKghBE+ZwkyP//i8TW/37kq40xgOXpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259820; c=relaxed/simple;
	bh=fhsQnl5gxC/yyIloxdRSyOwQP6yBba3MowPau+9llQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3UfulfdFnbdx4KPgY9ej6a2PBdJqAK5LAX4SN1sY7SzlcNgsDEL+K35c1RqGCbMMWMMXh0HAfBNtJbKRyZ+MLhwlcGvkEpDQsvmWXsZ8lX2yccLRGCm5J3Pgu6uRiTK8mEGTG6ShPnaB0kFQYnb3dEIM5HmEDQdeS2+V2u/1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmjRm9Sg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmjRm9Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B36C2BCB0;
	Fri,  8 May 2026 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778259820;
	bh=fhsQnl5gxC/yyIloxdRSyOwQP6yBba3MowPau+9llQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmjRm9Sgf6rZQn+PLNsF8A/EgWs9ehYYkpsmWL7QXSZ2JrTlIFs3YOwdRo0xbOawA
	 TOfgBpNrC2DkS3OH741kTWTWqIJ+YkGuaotsk1L8qZ1zq7kkkD+XRGYP/85X0wB8mT
	 58ND7doH6ItUvRSyIboBi55vzuNElKzUoICYV8K7ccPoclkyB3b6YR1Ze3mg9csOdF
	 bOTcUvXZXSaiveM2+WXJ1BVJPG2pAtmgAmJgrOdv0NsRRmTnsrPb9ww8gh1/UfzZF+
	 lMlYas55hLJ2vgRAlsyZ8XKFdW04Giu0mE9Tayyb/LlSdr3tNwO3ztYegpCZB/OYSk
	 u2sFzvazediCw==
Date: Fri, 8 May 2026 22:29:22 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: SVM: Only disable x2AVIC WRMSR interception
 for MSRs that are accelerated
Message-ID: <af4SexKS4Z0K2lGE@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506184746.2719880-4-seanjc@google.com>

On Wed, May 06, 2026 at 11:47:44AM -0700, Sean Christopherson wrote:
> When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
> actually accelerated by hardware.  Disabling interception for MSRs that
> aren't accelerated is functionally "fine", and in some cases a weird "win"
> for performance, but only for cases that should never be triggered by a
> well-behaved VM (writes to read-only registers; the #GP will typically
> occur in the guest without taking a #VMEXIT, even for fault-like exits).

Doesn't have to be part of this series, but I think we can now also clean 
up avic_unaccelerated_access_interception() and some of the other 
functions it calls for updating LDR/DFR. With this change, I believe the 
only reason we can ever see AVIC_UNACCELERATED_ACCESS when x2AVIC is 
enabled will be for APIC_EOI writes for level-triggered interrupts.

Probably worth a comment/assert in that function.

> 
> But overall, disabling interception for MSRs that aren't accelerated is at
> best confusing and unintuitive, and at worst introduces avoidable risk, as
> the effective guest-visible behavior depends on the whims of the CPU (the
> behavior of x2APIC MSR writes on at least Zen4 doesn't match the behavior
> documented in the table in "15.29.3.1 Virtual APIC Register Accesses" of
> the APM).

FWIW, I tested the current behavior (with most MSRs passed-through) and 
the new behavior with your changes, and (had AI) put together a table to 
capture all of this. It also serves to document what x2AVIC does (except 
for a few MSRs that were intercepted currently).

It is inline with my expectations, no surprises here:

+--------------+---------------+---------------+---------------+---------------+---------------+
| MSR          | Register      | Current RDMSR | New RDMSR     | Current WRMSR | New WRMSR     |
+--------------+---------------+---------------+---------------+---------------+---------------+
| 0x802        | APIC_ID       | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x803        | APIC_LVR      | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x808        | APIC_TPR      | HW            | HW            | HW            | HW            |
| 0x809        | APIC_ARBPRI   | UAA(f):#GP    | * MSR_INT:#GP | #GP-direct    | * MSR_INT:#GP |
| 0x80A        | APIC_PPR      | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x80B        | APIC_EOI      | #GP-direct    | * MSR_INT:#GP | HW            | HW            |
| 0x80C        | APIC_RRR      | #GP-direct    | * MSR_INT:#GP | #GP-direct    | * MSR_INT:#GP |
| 0x80D        | APIC_LDR      | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x80E        | APIC_DFR      | #GP-direct    | * MSR_INT:#GP | #GP-direct    | * MSR_INT:#GP |
| 0x80F        | APIC_SPIV     | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x810        | APIC_ISR0     | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x811..0x817 | APIC_ISR1..7  | MSR_INT:ok    | * HW          | MSR_INT:#GP   | MSR_INT:#GP   |
| 0x818        | APIC_TMR0     | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x819..0x81F | APIC_TMR1..7  | MSR_INT:ok    | * HW          | MSR_INT:#GP   | MSR_INT:#GP   |
| 0x820        | APIC_IRR0     | HW            | HW            | #GP-direct    | * MSR_INT:#GP |
| 0x821..0x827 | APIC_IRR1..7  | MSR_INT:ok    | * HW          | MSR_INT:#GP   | MSR_INT:#GP   |
| 0x828        | APIC_ESR      | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x830        | APIC_ICR      | HW            | HW            | INC_IPI       | HW / INC_IPI  |
| 0x831        | APIC_ICR2 [1] | #GP-direct    | * MSR_INT:#GP | #GP-direct    | * MSR_INT:#GP |
| 0x832        | APIC_LVTT     | MSR_INT:ok    | * HW          | MSR_INT:ok    | MSR_INT:ok    |
| 0x833        | APIC_LVTTHMR  | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x834        | APIC_LVTPC    | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x835        | APIC_LVT0     | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x836        | APIC_LVT1     | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x837        | APIC_LVTERR   | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x838        | APIC_TMICT    | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x839        | APIC_TMCCT    | UAA(f):0      | * MSR_INT:0   | #GP-direct    | * MSR_INT:#GP |
| 0x83E        | APIC_TDCR     | HW            | HW            | UAA(t)        | * MSR_INT:ok  |
| 0x83F        | APIC_SELF_IPI | MSR_INT:#GP   | MSR_INT:#GP   | MSR_INT:ok    | * HW / INC_IPI|
+--------------+---------------+---------------+---------------+---------------+---------------+

Legend:
HW           HW-accelerated; no #VMEXIT
#GP-direct   CPU delivers #GP from microcode; no #VMEXIT
UAA(f):X     AVIC_UNACCEL_ACCESS exit, fault flavor; KVM emulates, guest sees X
UAA(t)       AVIC_UNACCEL_ACCESS exit, trap flavor; write completed in vAPIC page, KVM post-processes
MSR_INT:X    MSR_INTERCEPT (MSR-bitmap) exit; KVM emulates, guest sees X
INC_IPI      AVIC_INCOMPLETE_IPI exit; KVM emulates IPI delivery
*            cell value differs from corresponding existing-behavior cell


- Naveen

