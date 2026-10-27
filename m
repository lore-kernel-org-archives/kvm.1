Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109949;
	b=UaEYCrJffMxtGtv5RPWXA781LQg6wteN4BhNEOf3cBdltiasoNM6WZQ21dzfHiDKHWQO
	 ulX2wxRvuyBhPoUAN1NrqpihktKian4i+JP1Gx8MSFBLYJ/s9f1YDftaF3V1rEuR/kQ8h
	 5uejs5FCYMrAuggF/+Ze8IuQqf+ezX93RIyOxzC597lWtDTUR7+J/EmzuHElw8t5I75sx
	 /MNBfTWwx8jX9QEQ5BiXW1Ev1nxadYeueBOa6a0ya0M0mmruz1IPz555MiJVw2rrDkKIy
	 GzYi1RYaxAL1IqF5+hGCQJ/Xlads9b6aFo3rC7HqmS4CvmZOt7zuYJR+W/ZKpti9pow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ScKNcqWNcrrNfUJK36ONgLidCscYb0P1HQayNuGC1DQ=;
	b=u6LFfRKTWoKZ8uDfVAcH5jyUCDfnoEkZL+zylWzbSDoizxqW9UrE3dS8dBhd6mXC666Z
	 vwVQrPOYefP+nEfWK63mOqxfhF8A/Q6gxnINiUE+V2a2lBldIgL5lGrjGMHXPAt+2G5I4
	 4iAGxNG2jomzX9qreaQ7Pr4nVUabwxu6XdbB4lrXyENSxr8g2bZ2e/ws5q6mm32Q0tpZC
	 Tse/FOARThae7wrekL4yKbLrnx1nLqHuMI1edN7AoPZdJ9tTrPryR5oY8sHglUVyWWG/D
	 74LvohkmeJicCD7YL1VtSu0CnAdTOOY1VLqEjmCSqnABm3Rspnmgb+uGtnv5gw9GzUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uXbUuRDy;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6B606A31B
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uXbUuRDy
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67d4bbdffso3192577a12.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793109948; x=1793714748; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScKNcqWNcrrNfUJK36ONgLidCscYb0P1HQayNuGC1DQ=;
        b=uXbUuRDyl16gOXgWVUihpfVQPkghTFvbIh9Pi+wkMzeqmN2MMMrbpVzcU4Pno4oNye
         V3grwk230KSLgDIzQCoaYeuNCF1+hzlit5RyzRQIsREVAI+ftxr/FAk77s21gvyLx9ad
         gCG/HEoNUfv8KSHMBuDFCzgRVyLqsXObRP5h7gRI9PdRieHfsZhYfai9tu7iLknW5kG+
         K3ukDXDq3FeHzsVHG3wt+gNCXllsj18mBxh4mquJonTw/7aP4gT/aynuUep/w56MHo1/
         UfobFuEgxhumii57xnCQbt4kRWhzygBk07QC5AIcs00ekhasbTkfloyiS8/4HRw7eT84
         OqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109948; x=1793714748;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ScKNcqWNcrrNfUJK36ONgLidCscYb0P1HQayNuGC1DQ=;
        b=WTeY9Dtf033kX5s9NO5Caz5RuZnq3r2kFyy5K2VYCGNj+AhgroxsIsuLxQCg9xYi0F
         RxCuMcIQS7gNUjvVRH4u9bLR9OrNw15SGvR4UK7Pb0cxBaYKrerScgRTgAIXwjEfsBZ4
         qSGkoosgBdUWle0O3TNL/jF/ESltD5nBALNyp63+a2MJx2G9Mqog2sKqvJ6WmDfhGdwA
         KLzaPITd0yK3yxb1d+YwFFbOcw2W9Slb9HmRBXkd3ViFXsZQ1AbvMKmim+k4vI7vHlDe
         +Fnc5MGiBdj3KNdzWk8NUKYxRvn1QHwvI7/FKixjKsjuXPOzbbEtmYiE3k03pi8/NfQV
         S5Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxhcZTzGDLEXXupxInaPoSr53y/kl4X9SMH3JWhv6XBhSInrS0YeDtZiTAdrrj1u1fGnJk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3nOqT1lh8UxDc2H2gQhH2rBbZxpYc5/JBYyi/tuOLEkU0JSC/
	DNgdPBeR9K3qzi/+il7dNhS7sn9mn5VedylKrWkqdzjg0piTgVZ9UqWbEZmGOu70CdN2daOuguG
	xISaOWw==
X-Received: from pjbsb7.prod.google.com ([2002:a17:90b:50c7:b0:3ac:6795:2cbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc4:b0:3ab:c80:9370
 with SMTP id 98e67ed59e1d1-3adead57e85mr7634057a91.20.1793109947891; Tue, 27
 Oct 2026 07:05:47 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:05:47 -0700
In-Reply-To: <741bfe7c-5d21-4c6b-98c0-95b01a2a21f3@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210134.612848-1-seanjc@google.com> <20261022210134.612848-3-seanjc@google.com>
 <741bfe7c-5d21-4c6b-98c0-95b01a2a21f3@intel.com>
Message-ID: <auCvuyY7tTg7ISwR@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate
 when filling CPUID entries
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>, 
	Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, Xiaoyao Li wrote:
> On 10/23/2026 5:01 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 271c2f94b8dd..37d088f6f7a8 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/cleanup.h>
> >  #include <linux/cpu.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/cpuid/api.h>
> >  #include <asm/fpu/xcr.h>
> >  #include <linux/misc_cgroup.h>
> >  #include <linux/mmu_context.h>
> > @@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
> >  
> >  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
> >  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
> > +	entry->flags = 0;
> >  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
> >  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
> >  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
> >  	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
> >  
> > -	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
> > +	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
> > +		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
> 
> I think the WARN_ON_ONCE() is very likely to be triggered in the future when
> people run old kernel with new TDX modules.

Then upstream patches to make that not happen.  Intel insists on treating the TDX
Module like hardware.  So, treat new TDX Modules like new hardware.  Upstream
support for the new "hardware" before it ships, cc'd to stable@vger.kernel.org
if necessary.

Because IMO, the WARN is doing exactly what it's intended to do: alerting the
admin that they are running a potentially dangerous setup.

> > +	/*
> > +	 * Explicitly zero the index when it's not significant, even though it
> > +	 * _should_ be meaningless.  Userspace relies on the index being zero
> > +	 * (the ABI was inherited from KVM_GET_SUPPORTED_CPUID).
> > +	 */
> > +	if (cpuid_function_is_indexed(entry->function))
> > +		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > +	else
> >  		entry->index = 0;
> >  
> >  	/*
> 
> 
