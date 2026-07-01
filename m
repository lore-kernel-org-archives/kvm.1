Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001933F8CA
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936657; cv=none; b=ARQjmVw16G2hqO/HSvXw53yEgs2Nm+N3Zl1vWjTSTsudLhMzi/aHeLTR+WfLzDwd25NB8gJ+rG3ce+f2enWpfnU7BohuyiokFRSJkkgNtFhCHKa8HH2AILZE4MmZVH/qjVdzjA0dPIqZjCbTv+9l/iAF2kXb4J/AyvUw0DKCjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936657; c=relaxed/simple;
	bh=43WttSzZ/4iTDPskppZ059v5eB4O8aQemipf1MF1YBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fs33Mz4oIIC9XiK4F0Eph3nrt2nbEJRaAfyNGjkNVP/iw8+IkhIwq8VwML1nwtoHP4A5n97iwowhuAgm78nEXehdjz5dQiSKKBoYqWA14BgXG1SILKozGoXjes9qLWnMBdU3cGl7LSnj1URasUYpmzLFCZwzOuPkgiTckgi+1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgC8aXmM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgC8aXmM"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca53c486f2so13279865ad.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936656; x=1783541456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9pJ28VwnY7W5YCQbhrbSfDCIDP0Ys0N8XOcjlnDCvHU=;
        b=dgC8aXmMSpmhBaxZgshQSJ0YRAE7osrdB0SUNll9sA5nqk3gvknISHTyRwsFJaQudx
         hWrmIEe6oC+zjP0MLqRnQ3sIfSd/+Y8x6xZlUPNMm9O+jv4k1Zm55KRBxG8dYSx0ycax
         w4h5mHrvp9EZC4i2StQD/2fumCvKSgVGIp1teo28WwFYiMAqC+q6wMZsZR87nAwOOT/v
         yQfoRm2AfuioZhXg1kNDH54yipCqqsLgHKus1MZkYEszbkmUO58BzqP6Q3/KfWU/yxm3
         yb9EDlCSMzbLpiruvu7D/MBZ7JuI4tzl51u5goklwLsSHQ2ewwE+WP1rGQYK0ZC78Ndk
         XnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936656; x=1783541456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9pJ28VwnY7W5YCQbhrbSfDCIDP0Ys0N8XOcjlnDCvHU=;
        b=Px7jbYUzMUEgPDyx0eWOUNGAFA5JjJ2ywHADaMt4IQZ/k5zxbZijwNeObeBzQxu4R0
         U03uTcVe2relQH67sYvRZMwfwxmwU8IkgghsQRLKqdonUGU6KE4/kV3fq/mswAGoefoU
         tvZRJcxhC3wt1JKuuhI+fWAs1JAZQPgjLGk0Mgf4mI5K3hFdHj2zdI1WvHPyZeNpCD+L
         w8Cc8eGz3IQGgfsLLd/vIrTwOohDYFEE7aM2Q5gKVP79gpEz8fXsBvQrEzdGhqPzaSdy
         oMidyQ2+yJDDUcuBO7HS0bay403b5TOi3IkGK/30hHGI69Uw16LqiT5QsmpC1cXPuyxE
         gKdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmcKz46Srj2uO+nA93jEprZB9OtlnxJt9PGf09EEWnEUgGg3ewgzpj6FIIxjxHD0jddfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1c4F5p8v7NLtq1rIlzELVEz8C0GTOeADLOjpjHqX/90Js6v/1
	hYHbeIxjX3Fu2Zvp7a8Q2sNBQD1MD7Em1PGprTrvv2EwpxyGLPhIfnYMVNWkmK2dCDlcqvsDjuS
	CvZkM2A==
X-Received: from plbkw11.prod.google.com ([2002:a17:902:f90b:b0:2c6:9f4f:f3b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c65:b0:2c9:c083:cd50
 with SMTP id d9443c01a7336-2ca9114e60bmr21403685ad.17.1782936655509; Wed, 01
 Jul 2026 13:10:55 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:10:54 -0700
In-Reply-To: <20260701195245.467DB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-13-seanjc@google.com>
 <20260701195245.467DB1F00A3A@smtp.kernel.org>
Message-ID: <akV0ToNvWYKi8HVm@google.com>
Subject: Re: [PATCH v5 12/51] x86/acrn: Register TSC/CPU frequency callbacks
 iff frequency is actually in CPUID
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> > index ad8f2da8003b3..dc71a6fdd4613 100644
> > --- a/arch/x86/kernel/cpu/acrn.c
> > +++ b/arch/x86/kernel/cpu/acrn.c
> [ ... ]
> > @@ -26,13 +28,19 @@ static u32 __init acrn_detect(void)
> >  
> >  static unsigned int __init acrn_get_tsc_khz(void)
> >  {
> > -	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> > +	return acrn_tsc_khz_cpuid;
> >  }
> >  
> >  static void __init acrn_init_platform(void)
> >  {
> >  	/* Install system interrupt handler for ACRN hypervisor callback */
> >  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> > +
> > +	acrn_tsc_khz_cpuid = cpuid_eax(ACRN_CPUID_TIMING_INFO);
> 
> [Severity: High]
> This is a pre-existing issue, but does hardcoding ACRN_CPUID_TIMING_INFO to
> 0x40000010 without dynamically applying the base offset break nested setups?
> 
> If Linux is booted as an L2 guest with an L0 hypervisor like KVM occupying
> the base 0x40000000 leaf, and L1 ACRN resides at 0x40000100, acrn_detect()
> correctly finds ACRN using cpuid_base_hypervisor() at the 0x40000100 base.
> 
> However, acrn_init_platform() hardcodes the fetch:
> 
> arch/x86/include/asm/acrn.h:
> #define ACRN_CPUID_TIMING_INFO        0x40000010
> 
> Will this bypass the dynamic base detected earlier and read the timing info
> from the wrong hypervisor's CPUID space (e.g., KVM's L0 frequency)?
> 
> If nested under a hypervisor that returns garbage for 0x40000010, could
> acrn_tsc_khz_cpuid be populated with a non-zero bogus value and corrupt
> guest timekeeping?

Yes, but it's not at all clear that ACRN supports advertising itself anywhere
but at 0x40000000.  Regardless, this can and should be addressed separately.
