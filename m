Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1D41930E
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562372; cv=none; b=NkoOEtZaBzZiZiORHuLkeJGOTmWqnPgs+GlMZRCcisnmwSBoiSUTow4wns3qP6qDdfKGBeJzKZfQMkcQFfMx0Sl9BhYO6z8JAZ0kWN8FbaiStptIlTcvLde4g0I+KyG5/2UZ4Ps2B1BwYA73A8scYMSXf8Bu+Kwl89IicODJLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562372; c=relaxed/simple;
	bh=mysqL6+eCjNN4mNyfwg428lBDctaTeDZpDM0kmGaMi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYJ61H+FSNAVnc909bWf7Yk003+43D6K/CwH09MTMDeW4+aaxoOJNkfIpgy5/crtZiZG1WEYT9iO6PwZoR7NFh312rAT7hwyWxpIx/PTB01snSyYwsAXDWLhvMQcoXsZfYb0kAPvX9tLtrWPFWb4+YrRYYAe+NA8GuMYNhQzCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSG/9Fn6; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSG/9Fn6"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc88e22f92so221012215ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784562370; x=1785167170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdZ7BeoIHlBjqID5zacq6MvDALSaxCcCoW3uAv/+L5M=;
        b=rSG/9Fn6lx545Zhat9Dvu+whzayzJAgMuoU0enel0UdwyJg3VrkBkR2LTtstsqSlJ0
         294kgb1yNMpZNENkTBd+Sc2TTTZ0Frh3kuMKdMUNvZ1hcs+KS4OVEZUJyo0wchBWqLCA
         oq6YcaA2j8RYNctr4/+E8n9FMxixv0lhDBlyiop5haCL8lJVwVT2v1e6rPYYVI5iC35T
         FFVjf376dwGUbzQ02VigUhkusqOqemlqBAVsuFf5lRRoBslikZLuKqb6wZ2s6/5szYvJ
         7lnzTsxIPyRdEA9p88vvFJwORaGEdTek2GpNuQQ7ZpyQ+B8tQ50q8QYCt1uHC9JmCZnA
         38VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562370; x=1785167170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdZ7BeoIHlBjqID5zacq6MvDALSaxCcCoW3uAv/+L5M=;
        b=kl45Vl6pTwFT03xpMu7WRceMFMaExHUkm4bp+LOUMK8Fn8eBSJrAw4/rW1zfmI5+Pj
         YLNcK0hv1B/O0PD0a4syS4omN1qEnngD8JwoClgF+djL9MJBUcACaNFsy6+Zofs8FjxO
         eLMl1+kXfH2itq1Nm3gHbikfu1g0L9/HilEPJVKb+01Be20fzYz8DDIWu4Qe5T9m4qVR
         88qHSAIjm7YUJY6EnpadDWW19Nv+E42/S4QGNC4nQW0zTxK222jAfwfK6pD+ofds0WHY
         oQj9Lx88vdinCr7FxaB86vvFbAIpnhBU99pnw+0ekricCl+rYNPGyoVKg0fh2kHIfLOF
         8Vww==
X-Forwarded-Encrypted: i=1; AHgh+RoaZH4B2LCREuCxdwXhWDLooNOAqH3UviMoF6hmqV2xro96MXB6SG+x1VMmNhE55mtT1fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvlNRFugJlQUndYdIem4R6NgudkjtpZsNg7F+ESYmyF1l+ldi
	xkpUGcTPAe+WJWnDrlbAmzlg/vr3NgoxnvMVM7yWSsu6nwTWFmxKdmK67TmbeCEA+kJlnwqHyVK
	x6MWuDw==
X-Received: from plbkq12.prod.google.com ([2002:a17:903:284c:b0:2ca:ddbd:a19c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1248:b0:2c9:cf5d:d9bc
 with SMTP id d9443c01a7336-2cf349c979dmr157079325ad.35.1784562369848; Mon, 20
 Jul 2026 08:46:09 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:46:09 -0700
In-Reply-To: <20260717230542.3555587-4-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com> <20260717230542.3555587-4-jmattson@google.com>
Message-ID: <al5CwRqMC48cdQSP@google.com>
Subject: Re: [PATCH v2 3/3] KVM: x86: Flush guest TLB on MTRR MSR writes
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Jim Mattson wrote:
> Per both the AMD APM and the Intel SDM, writing to an MTRR with WRMSR is an
> implicit TLB invalidation that invalidates all TLB entries (including
> global entries). [The APM uses the word, "update," which could be construed
> to mean "modify," but it is unclear.]

Yeesh, the SDM isn't very helpful.  Under the description of WRMSR, it very clearly
says:

  When the WRMSR instruction is used to write to an MTRR, the TLBs are invalidated.

But then in the recommended pseudocode, the SDM says software should flush TLBs:

  pre_mtrr_change()
    BEGIN
      disable interrupts;
      Save current value of CR4;
      disable and flush caches;
      flush TLBs;
      disable MTRRs;
      IF multiprocessing
        THEN maintain consistency through IPIs;
      FI;
    END
  
  post_mtrr_change()
    BEGIN
      flush caches and TLBs;
      enable MTRRs;
      enable caches;
      restore value of CR4;
      enable interrupts;
    END

> Previously, kvm_mtrr_set_msr() stored the updated MTRR state without
> requesting a TLB flush. This broke x86 architectural compliance by leaving
> existing TLB entries in hardware. Additionally, on AMD CPUs supporting
> ERAPS, omitting the TLB flush request meant VCPU_REG_ERAPS was never
> dirtied on MTRR writes, leaving the Return Address Predictor (RAP/RSB)
> uncleared.

Heh, Andy Cooper even pointed out the implicit flushes on MTRR writes[1], and no
one noticed KVM was missing that specific flush.  I mention that mostly because
the context of that thread was asking AMD to drop the statement that the RAP is
cleared on writes to "other model specific MSRs, see NDA docs", so that hypervisors
wouldn't have to clear the RAP on every WRMSR.

AMD updated their documentation[2] to say that clears on MSR writes are considered
microarchitectural, but this patch and the above blurb are still accurate because
MTRR writes are covered by the "implicit TLB flush" clause, not the generic WRMSR
clause.

[1] https://lore.kernel.org/all/1c76cb00-1fe1-4fd0-b7b9-86ddca6115ba@citrix.com
[2] https://lore.kernel.org/all/08826b5879e2d9c354424279763d3ce5556f44cc.camel@amd.com

> Issue a KVM_REQ_TLB_FLUSH_GUEST request on every MTRR MSR write to match
> x86 architectural semantics.
> 
> Fixes: 9ba075a664df ("KVM: MTRR support")
> Assisted-by: Gemini:Gemini-Next
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/mtrr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
> index 6f74e2b27c1e..ca5e5c7f7022 100644
> --- a/arch/x86/kvm/mtrr.c
> +++ b/arch/x86/kvm/mtrr.c
> @@ -105,6 +105,7 @@ int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
>  		return 1;
>  
>  	*mtrr = data;
> +	kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>  	return 0;
>  }
>  
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
