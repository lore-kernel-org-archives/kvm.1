Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE73EFD39
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175825; cv=none; b=VUl6SSNtSS3pE91Cqm1r/9G8fA06vlsmCOPoRSsGDgGJLIlsYtSKYffQcudwfJwnefd8i0DrS3yoVEjJlmK97fGyST2MSFG6jc8TaMWzMqTpCxWlxtmMoByBqDgmRcsYuv8Y0sZbSp0kFHWODlObiFoRwp4V2c2RGxnlxlAWvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175825; c=relaxed/simple;
	bh=MJYNZWMJJN2p+qBy6ySIc5W6A17Kak+Z3aba7HGPpyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LmgJKiRVYpWO6njHkKNK7BiabjzUNTw4NRB2SyIlDGpARdvr8gF8crZPDrJqNaN3sFhZ9tTVa/vpYBYKmuz+PiFHqa3MGhRSG6QckhVDjY/6NTi64/DcZp2cvdyb7i7fOyTTiQ3WCs2uQefdghKSLwMjRW31J625HybSIct9B60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opH7fQI5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opH7fQI5"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8252a49ffcso1322185a12.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778175823; x=1778780623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGcKbXjPRgmY1I05NvixX7RQzgjkDO50x4yX0RFbK4w=;
        b=opH7fQI5TfcRzQ2nzoGuDKL3tiDFwsvj5nXWGB+Rv3ZXpQxXfOwv2yrLRVfL5TZxQC
         A2xWR7iw2J/YqMexnuytcTDexDmOKew3YFeHhSdFluLoFTZ2ITwSnDgU9qxmnPYO7pK3
         ZYz3Ia9+DnYuAGepgXOR2Nr4fLphZX2QhNSqKZCmF3dVOOWF1hLiv8SrKM6kdrE1mMtQ
         vbE2y6cex64mz3v0n7dVYjxcmEeNlaTb/AUj15HS4Z7SndclzYLbLUpL5p1zMgrtP+90
         5cZAG+P1U8XrGblJWtt1IgatbIJoRmihczHw+Rw522uxycG9lKC7M5mNZD7BOopdr8SR
         POkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175823; x=1778780623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGcKbXjPRgmY1I05NvixX7RQzgjkDO50x4yX0RFbK4w=;
        b=CjAxmeICB4E/wGbZk8g+hI7Rh9WRDfUZh0L2cnZkeGma+lHbIj6no5Iayp/upa0pmd
         0X6OgsSdOkcQXNhIng0M/15iJEzp/d7dY3feTG6EFJKHaWgRFe4PI4sPlAPu6ppIoy76
         9rav6PzMSbOEe4v+uErQV/gqFWojfy4V9IlTMGK9s5uypVT2nZHD2hC2BFfVuYHSHcOB
         SPGKyZkMSrw98N+SzNoEYPosnd5DWX/CgaT/2Y1+E2l2X3yK5B4OyWsJlHFoF3KO4Tnm
         Uc1JLuVD/GOEiSKyMTtIatBQ5kxC1KyoOttliByeWPG+lQu/2y63hfUk6OqLPkDXwEwj
         x/8g==
X-Forwarded-Encrypted: i=1; AFNElJ9shaVgsBHuD0bOvDmMQG1GdK0mIsvRi04j8l9u2aZ2EDtdyrKCiN/5Icuh9RGBv/fjEow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDgsD32ymQyirFTzpQeor8Rwp/mvGBAoFjL8ZmdPAQj8Tkx3P
	Ev+4x8fETYlhoWk4V1/pmAMaDgZ7hc2EWS6JSISCkYI6ILK7BmT20RrenSLAdJvJyAyg4qdvT1k
	vlCIMRA==
X-Received: from pfbf4.prod.google.com ([2002:a05:6a00:ad84:b0:82f:96ee:b9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198c:b0:81f:3f03:6846
 with SMTP id d2e1a72fcca58-83a5ea41bb8mr9028890b3a.47.1778175822847; Thu, 07
 May 2026 10:43:42 -0700 (PDT)
Date: Thu, 7 May 2026 10:43:42 -0700
In-Reply-To: <20260507142402.2175933-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507142402.2175933-1-vannapurve@google.com>
Message-ID: <afzPTtjuELBtnOVc@google.com>
Subject: Re: [PATCH v3 1/1] KVM: x86: Introduce has_protected_pmu state for
 TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Vishal Annapurve wrote:
> PMU state for TDX VMs is virtualized by TDX Module [1]. Host has following
> toggles to control the PMU functionality exposed to TDX VMs:
> 1) Configure TD_PARAMS to allow guests to use performance monitoring.
> 2) Restrict the TD to a subset of the PEBS counters if supported.
> 3) Limit the TD to setup a certain perfmon events using basic/enhanced
>    event filtering.
> 
> KVM will need to be enlightened to support these toggles. Introduce
> has_protected_pmu state to track the pmu state for such scenarios
> and explicitly set the has_protected_pmu flag for TDX VMs.
> 
> If pmu state is protected:
> 1) Disable KVM's PMU virtualization framework as additional
> enlightenment is needed within KVM to control/manage the
> visibility of PMU state to such VMs.
> 2) Disallow userspace VMM from toggling PMU virtualization state
> using KVM_CAP_PMU_CAPABILITY.
> 
> [1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> 
> ---
> v2 -> v3:
> - Squashed two patches into a single patch as per feedback from Sean.
> - Dropped the cover letter.

...

> @@ -13375,7 +13376,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
>  	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info = true;
> -	kvm->arch.enable_pmu = enable_pmu;
> +	if (kvm->arch.has_protected_pmu)
> +		kvm->arch.enable_pmu = false;
> +	else
> +		kvm->arch.enable_pmu = enable_pmu;

Once more, with feeling :-)

	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;

No need for a v4, I'll fixup when applying (assuming this is indeed the directin
we take).

>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
