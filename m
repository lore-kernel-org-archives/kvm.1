Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385874;
	b=a837q8Uz361YAyuIU+H6mKXR9Mnk7tyNFjNc3GVhbBLb1tlhnvtLKxfH86M+GVEkE7FG
	 UBTHaw/tw7I204aAmM0O/8RC8UUwN7N89YIa+c0DQSOiJqq0u5ahcIy9fu6Hvm3lX4mgs
	 vlu8f/AugdTw/gBR5k+vZ2hKSWed/WUQOMtp9vTXuf74mSR0dbiF1+MAgbOu3VafSIHsm
	 CIrfp7/KTvLk+LeZHntDG9W8DbKvzAJ6aS13aVxm9ZHsst+d3qhvpq1GMkuqPZz02g96u
	 S+dadXC3sQAoiSPLlF1z/CqkbriNYZCdVn0Ko9IOXqRrN2j26pUfHVpfXuwQGyY4oww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=plQGU0/59tXvVFv7NZ2tZ2O/Wh2AnzL9Gn/KxlsSxWg=;
	b=hQPYu029ZRvgRqKkedWAfDywOVViVacwrh2N2mrJz0zNHptnRxFLpjOCTDnggnrxrfzB
	 9NFhsmPdR4QBsDAlNQAjf5iaO5xDtntQR4JuABHu4pWem2A3QPlO6rRsDmvG0yjC2t8q8
	 bVExEzVlPhU9gHvgre5NqG61mdiB2TkyymC8C16XQjC9F8MQR61vyK7L7CGEmxdspAAvT
	 yeAnM3HQRMdsTwd08okdfoPDZ6fKik/o9tsOgydHip+rKHZ2qhxukO24IVsjnYaEu2+yZ
	 DPfeDUTDjSd46krxX7odSPJjMYdCIxPVQ7QDdkEOY1+KadJjm78B9UUpJPqR7WhVb8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oOP3e5f5;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1146606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1146606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oOP3e5f5
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so905535a91.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793385873; x=1793990673; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plQGU0/59tXvVFv7NZ2tZ2O/Wh2AnzL9Gn/KxlsSxWg=;
        b=oOP3e5f5EwtSeLWUiI3FRElxXMunJCatDCTKvdAt4IJD4dHYMOr+ws8sv5FW/Nu6L0
         0gTkhvEWudnm8hbSamuLgmp+fB59bdwBpmeZ3LkRuv9Cj1NhARFo0jYMDeCQYniwvZfQ
         bq4SSSVRHE5HpZRzcG5dGaBp3qtjdXkmDU2+rv3NFWLHiD6rG0yqWgSZ0LzAOHvtS8Iw
         YTKWl9wpXOa/DsoR89Q4N3FhffNQLC0GcZIWfUIC20FsMpyprKF0B8t5h4Rj6L+/S2G5
         dDqdsEauGbylO/D7AtzlOIvKzQFcmY5Zhcq5vddMcfrOgx+MtLQu8Kjb1bzlfYTylFGx
         fnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385873; x=1793990673;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plQGU0/59tXvVFv7NZ2tZ2O/Wh2AnzL9Gn/KxlsSxWg=;
        b=Hgxt7tj67CA5R9/OLyzkXOhSiDdsvF+RPDtoJjksIuHHKl2wjSy+ITAGy8RCBhJdJq
         Hynp6RnyXtdKrikN+8nGGPayF/qO3YPl4nUO8NKDLiI6dsbNrTiqgTO97gZHb8pb1fvK
         j5yRJDPFTE5xoDxk2vpDqoMIj9hjW4S6RqxpWCsAxtK28D4P9kw6WeYPaFkQv4KCwbrQ
         HcIoigrwoyGxYoqRXBNc7TqYlWk6E1xWYrYuxBjDIlKOY/YWUfBIbAUy05INV2lHAYiz
         Uv2rXyBOVz0y7jpuMv4cYBuAi5tr8WYYTwO8/s9qrPRAhaKsb14/CmTXNVtzltBLYwYA
         l0pQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTaTCgl3PqWhP8lU0arEksGPNAziIJMi23KmWfHYNu5hs2HRi/TjjxBXPdasGoHJsOh7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlaRZ8Z7zzIBCF3o3agVf4/0qqWphSMauFxemPG5UMDtvPs1oI
	ESZcfxsseepwyjhV7iJaOf1feUIJrrXx4WTTNobjuWyITzggQryEeRAIhtGQFZNAagYquC2SNCd
	xia7Y9g==
X-Received: from pjon10.prod.google.com ([2002:a17:90a:928a:b0:3ac:2cdc:a8ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c5:b0:3a7:ef4:164b
 with SMTP id 98e67ed59e1d1-3ae89574cf7mr2533447a91.2.1793385872887; Fri, 30
 Oct 2026 11:44:32 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:44:32 -0700
In-Reply-To: <auTgh5uP5tpL8BlP@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030032937.2813-1-ma.mandourr@gmail.com> <20261030032937.2813-2-ma.mandourr@gmail.com>
 <auTgh5uP5tpL8BlP@google.com>
Message-ID: <auTlkNFh5C7nqzoi@google.com>
Subject: Re: [PATCH v2 1/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits
 owned by L1
From: Sean Christopherson <seanjc@google.com>
To: Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sean Christopherson wrote:
> On Thu, Oct 29, 2026, Mahmoud Abumandour wrote:
> diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
> index 544b7840897c..2d5feeb8a059 100644
> --- arch/x86/kvm/vmx/vmx.c
> +++ arch/x86/kvm/vmx/vmx.c
> @@ -5743,8 +5743,10 @@ static int handle_cr(struct kvm_vcpu *vcpu)
>                 break;
>         case 3: /* lmsw */
>                 val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
> -               trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
> -               kvm_lmsw(vcpu, val);
> +               val |= kvm_read_cr0_bits(vcpu, ~0x0eul);
> +
> +               trace_kvm_cr_write(cr, val);
> +               (void)handle_set_cr0(vcpu, val);
>  
>                 return kvm_skip_emulated_instruction(vcpu);
>         default:
> 
> > +			err = handle_set_cr0(vcpu, (cr0 & ~0x0eul) | val);
> > +			return kvm_complete_insn_gp(vcpu, err);
> 
> This needs to (a) be a separate patch and (b) apply to L1 as well (though I'm not
> even sure if you/AI realize this is a bug fix).   Emulation of LMSW originally
> suppressed the return value, because outside of VMX operation, LMSW can't #GP on
> a bad value.  LMSW can't set reserved bits (for the CPU models KVM supports), and
> it can't toggle any bits that trigger additional checks, e.g. can't try to clear
> CR0.PG while in 64-bit mode.
> 
> But with VMX, must-be-1 and must-be-0 bits become a thing, and so LMSW could #GP
> if it tried to set/clear a bit in violation of those masks.
> 
> Ugh, never mind, screw this.  KVM doesn't support arbitrary MSR_IA32_VMX_CR0_FIXED1
> values, i.e. doesn't let userspace require that arbitrary bits always be '0', and
> instead relies on common CR0 reserved bit checks.  KVM (very, very stupidly) does
> allow userspace to expand the set of must-be-1 (MSR_IA32_VMX_CR0_FIXED0) bits), and
> so *in theory* LMSW could fault when clearing EM, MP, or TS.  Of course, no sane
> VMM sets those as must-be-1 bits.  And to make this a complete trainwreck, KVM
> doesn't update its own guest/host masks, i.e. it's own intercepts, to ensure it
> enforces the must-be-1 bits.
> 
> E.g. if userspace made CR0.TS a must-be-1 bit, then the guest could violate that
> so long as it doesn't toggle any other bits that would trigger a VM-Exit.
> 
> I see absolutely zero reason to try and fix KVM.  Letting userspace make CR0.TS
> a must-be-1 bit is beyond stupid.  KVM already requires CR0 and CR4 must-be-1
> masks to be a superset of KVM's "defaults", so userspace can only make things
> more restrictive.
> 
> So, rather than synthesize #GPs, I think we should prevent nVMX MSRs from inducing
> #GPs in the first place, and then WARN.

Argh, that's not going to work.  Thanks to KVM's massive "attack" surface, a.k.a.
save/restore APIs, it's possible for userspace to shove a value into vcpu->arch.cr0
that's in violation of must-be-1 bits.  I.e. userspace can trigger the WARN.

So as much as I want to WARN, in practice no real world use case will induce a #GP
on LMSW (or hell, even trigger an exit on LMSW), so I'll go with your patch of
synthesizing a #GP (which is better than silently failing).
