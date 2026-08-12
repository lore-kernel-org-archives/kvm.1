Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78523403F5
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565327; cv=none; b=fYAeDJrg0mH0G8o/fK9pjbAS8nAYv+FVStIJ/ZHResbib1Mn+1G3o8reshLk6hNVAPzfFA8C6tO1aQnC/wFE7Ng+sfaK7PwqE9xS20aWIgx9wlq9gOms5BzQuLaqWVDmkKfhCAWVKmqbYdRrgk6O0FMUPfwXr4UiPjSYpePJRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565327; c=relaxed/simple;
	bh=R4a9X20wgVE3GYY5k7tJ7PMK4SWWCo/b8w6Nu1+bL4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hj/raMyfC4o7e9fO1+Bb3oqw5GJWeAkgpP3XCjj1yM4QiaAYw/XRsIcl/Re7h+trr8MtRIlQGkyPpeCQI8p5zLlihNOVyDC/6HifH3sfvvh8CZvXh132vuSGKYwZLSj64IXQ2iQdp+bPEb/x9PWuuUSYVCggo9DVQnfTy/6hwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9GLC0+y; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9GLC0+y"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e4ef9a74aso2425704b3a.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786565325; x=1787170125; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/e1iLgIlxCuChfXNbN4KEooe5yYz2uaYvUPHL6sMaos=;
        b=D9GLC0+yAU/4v6altYnSo6I+1VTt0RHma/GC8zMu2geUMjzLda3gZKjtqnOIC0iI60
         jJWJxCquapNvmC5hjFZyZ3Wz3SlamzaqCB0bWtS6HuSZnV4Zp6YQAUWcSUR8Z9341vA5
         D5sGXMt2RPaf4D8TZfMIWDwUm+kks+gNkswEdIj3+M6f6AsuowXhvAMavRppHKNnOXKc
         xgROW/6VdHMh+cjVFplaaHMlMGIA44gaCcxFRQCNjTXysXdMNWqzcOuaGTkW6p438jCU
         Zclrr/sR41U9XJdN5yNHOZZ1FLNoXqGS675oe8d4aa3kIilguMCsV2VlubJQ5B7gV2X+
         RpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565325; x=1787170125;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/e1iLgIlxCuChfXNbN4KEooe5yYz2uaYvUPHL6sMaos=;
        b=i2+wEKod0aLkNOCa2ymwW7vNisAjDU+8Jwd/i5m/OJjuGsip+GJrW4iWZonoajPtMj
         Hd6IQ6x0Zv0CIXOqligE45QhTqS6QFgQQmgniPOxoF2om5cqzA2Rj6xr6Mty+M909FHY
         CljHs+6LLEL7Ib8iXVbQtP4AzgPLrM17SXy24wGeyNmHXDUTC+ip91ubppTEAYTa+2ni
         85XfNAc90SEY/8D41Lw44OE00isRvoKT46OclnjVt5WE6a0pVbdPiLufOc+bOBc+87fB
         d+8ZUOmn4r2LjxNL62snawuV3C2Tqk/qXqHrzfTmor/r/WDpiPj5EK1KbB58HEM94ssD
         xwiA==
X-Forwarded-Encrypted: i=1; AHgh+Rp65iJO+YW1QOSbE1ypHLyCNc7U18Zda+M/UX1KrGDrcW6OzLpOkoVq6rWNzrHI92SCoEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBz1PqladrPTexebrhgS65SRjjFMrgteELBZwPWxQID+5QuH0
	0wyqpykRo2omvQ8tn6V9bz7Vbo/UPzAbX4FRQJzgpbjUF2UmhQOs/hiQdYjcwMvmowfRWFXSzV/
	ctmQ8JQ==
X-Received: from pfrg3.prod.google.com ([2002:aa7:9f03:0:b0:84f:a7f2:3113])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4207:b0:848:4faa:480b
 with SMTP id d2e1a72fcca58-84fc6cdd974mr554619b3a.12.1786565325119; Wed, 12
 Aug 2026 13:08:45 -0700 (PDT)
Date: Wed, 12 Aug 2026 13:08:44 -0700
In-Reply-To: <20260810225500.869288-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com> <20260810225500.869288-3-seanjc@google.com>
Message-ID: <anzSzC488HgK76Eu@google.com>
Subject: Re: [PATCH v9 02/21] KVM: x86: Improve accuracy of KVM clock when TSC
 scaling is in force
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Sean Christopherson wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The kvm_guest_time_update() function scales the host TSC frequency to
> the guest's using kvm_scale_tsc() and the v->arch.l1_tsc_scaling_ratio
> scaling ratio previously calculated for that vCPU. Then calculates the
> scaling factors for the KVM clock itself based on that guest TSC
> frequency.
> 
> However, it uses kHz as the unit when scaling, and then multiplies by
> 1000 only at the end.
> 
> With a host TSC frequency of 3000MHz and a guest set to 2500MHz, the
> result of kvm_scale_tsc() will actually come out at 2,499,999kHz. So
> the KVM clock advertised to the guest is based on a frequency of
> 2,499,999,000 Hz.
> 
> By using Hz as the unit from the beginning, the KVM clock would be based
> on a more accurate frequency of 2,499,999,999 Hz in this example.
> 
> Use u64 for the hw_tsc_hz field since an unsigned int would overflow for
> TSC frequencies above 4GHz. Use div_u64() for the Xen CPUID leaf to
> play nice with 32-bit kernels.
> 
> Fixes: 78db6a503796 ("KVM: x86: rewrite handling of scaled TSC for kvmclock")
> Reviewed-by: Paul Durrant <paul@xen.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/cpuid.c            |  1 +
>  arch/x86/kvm/x86.c              | 18 ++++++++++--------
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 283847619ff8..6ddc988576d0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -864,7 +864,7 @@ struct kvm_vcpu_arch {
>  	gpa_t time;
>  	s8  pvclock_tsc_shift;
>  	u32 pvclock_tsc_mul;
> -	unsigned int hw_tsc_khz;
> +	u64 hw_tsc_hz;

From https://sashiko.dev/#/patchset/20260810225500.869288-1-seanjc%40google.com:

 : > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
 : > index b517257a63153..099c3da20547d 100644
 : > --- a/arch/x86/include/asm/kvm_host.h
 : > +++ b/arch/x86/include/asm/kvm_host.h
 : > @@ -1004,7 +1004,7 @@ struct kvm_vcpu_arch {
 : >  	gpa_t time;
 : >  	s8  pvclock_tsc_shift;
 : >  	u32 pvclock_tsc_mul;
 : > -	unsigned int hw_tsc_khz;
 : > +	u64 hw_tsc_hz;
 : >  	struct gfn_to_pfn_cache pv_time;
 : >  	/* set guest stopped flag in pvclock flags field */
 : >  	bool pvclock_set_guest_stopped_request;
 : 
 : The commit message mentions using div_u64() for the Xen CPUID leaf, but is
 : the actual update to kvm_cpuid() missing here?
 : 
 : It appears kvm_cpuid() still references the old field name:
 : 
 : arch/x86/kvm/cpuid.c:kvm_cpuid() {
 :     ...
 :     *eax = vcpu->arch.hw_tsc_khz;
 :     ...
 : }
 : 
 : Since the field was renamed to hw_tsc_hz in struct kvm_vcpu_arch, will this
 : cause a build failure when compiling for x86?

The changelog is stale.  This will be applied on top of commit 7d3bd21e457b
("KVM: x86: Remove runtime Xen TSC frequency CPUID update") that's sitting in
kvm-x86/clocks.  I'll drop the stale sentence from the changelog when applying.
