Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C734EEE3
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184709; cv=none; b=VnibZxpVwBWU0jrE0DuG/Xn9OKXhLy6UG5ff8RmpdCFPFLsdAB7X/bL5AfZs+lktUGhNJOJosc7zENp88faRuFpqE0HAidDcy4wBIlSdu5hfky56PvoJ7LieZXRIxDGbs3jDcRTbQY4egF3TWpMnj/cQleI6z6Wc6Tot5Us2Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184709; c=relaxed/simple;
	bh=z9ZVJ1F3PpnJRs89e1DROl5O0vwpMs1ALIpbBtkCoug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWA5gT4JWAC2Ef8I3qZP2CNaf7bblPsT/tS1ucAI1oJfVHKKlzyw9xqVzam/hnv/ZjwEDYPBo/Am7WnJ/Vz31TzbiglOqaQBufB+9oyTRkAcF/cRu1grEZ2vrXFqFXpV+FV1tzKZWKiQNiF+/2WJtJfKeUGC/455ako/mOP2dQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxWrklgI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxWrklgI"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7977177675so631985a12.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778184707; x=1778789507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDSEo75//X2PyTwVLJoJLq8UvjZIVy2/btfnxlV9Dz8=;
        b=CxWrklgIdwPriu30ED4hEflw2tnen+1NsrnziZFoVKf0cWvHrq8Y9ZS6ZE9FFJvN0a
         kvTnJUkrWE1dVvXkwR8XPXhb1EeCVzm3XPJ4GDOClFH8pw5Ao+Q0spMq1GNuEy9AduG3
         mP2vxVJIbZ1y6WXe/OSC+vjapAwy4X1+u0SGen4w/kkrm8lvROSxNndK3NfcZLgmNAfq
         Pl1d8kZ2x2dH2EZJ2+wkndxjPvdEV2WH+8aIBZnSrT6Le0ZegPUZjNUO2xIttptd53te
         mAXM/6yfd1kdymdwkG3MIFjhREO6pA+nR7CCw1q6QeH0Gf2a86jwRbY5OboyT7fUM2Et
         LtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184707; x=1778789507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDSEo75//X2PyTwVLJoJLq8UvjZIVy2/btfnxlV9Dz8=;
        b=OC2cXIcyProvOwMMYNm5PTgcUXLlunNFN5zCk+vFT2i4cEPsAKKz9QpTUPJbZb0scO
         QDdnFcwZayQZ2i1Kh/EJmXp2tXMhmQSzdvy3K2uDqJc/jgB5G8fznSfBY/MoMsX7VkMX
         eCrF+UJLSLxuhU9rSwPBCs/InttthnQLyeQplIZNznN9fvdB48/LNSsTaHyawjrzvYGF
         DF2tgjCQDrb+Sj6GYGgZ9mRDP2PDrBZ7WGNqqsGUngPxT1nbMpMW8qJJpBoj8JjXSkCR
         P9JZjM9/HUnF+uAlOjKDNRKAtlFd7uRS7Urz5KzjV0OxOURfN2N4WdYuS/jxWrQlYlQP
         JPXg==
X-Forwarded-Encrypted: i=1; AFNElJ8kfJPBTlIfWZg6O5KL0Pr5vNj1LTOcxQZJ1Cqwhsj5QMcDY2fw1pwdhesnX0DoHGdwXms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHEaB/TEv+6kyE940srRhOoWoalBl+zsE/gqWK9Wfjz5U/tYyZ
	5U5MjohgA7axYgw2EMcVshBbzuC+NkgjehOkp2SdJ1Lf6EaRXn9BuERIh9ZbdtiDwuptwj+puVe
	jOhXB0A==
X-Received: from pgar3.prod.google.com ([2002:a05:6a02:2e83:b0:c80:1ab9:b111])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a106:b0:398:787c:d2e4
 with SMTP id adf61e73a8af0-3aa5a8fdfdamr10252140637.17.1778184706829; Thu, 07
 May 2026 13:11:46 -0700 (PDT)
Date: Thu, 7 May 2026 13:11:46 -0700
In-Reply-To: <20260507142402.2175933-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507142402.2175933-1-vannapurve@google.com>
Message-ID: <afzyAorFFnwsh7u_@google.com>
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
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..99a383455d46 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			break;
>  
>  		mutex_lock(&kvm->lock);
> -		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
> +		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu &&
> +		    !kvm->arch.has_protected_pmu) {

An offlist Sashiko review pointed out that this will prevent doing
KVM_PMU_CAP_DISABLE on a TDX VM, which could prove problematic if userspace is
already explicitly disabling vPMU support for TDX.  I was thinking that wouldn't
be a problem since KVM already disallows KVM_PMU_CAP_DISABLE if enable_pmu=false,
but in that case KVM doesn't advertise KVM_CAP_PMU_VALID_MASK:

	r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;

And unless I'm misreading QEMU code, this will indeed be a problem.

Argh.  I was going to suggest something sightly fancier, but we rather stupidly
didn't provide a flag for ENABLE, and so we can't feed has_protected_pmu into the
valid mask.  Lame.

The other super minor detail is that kvm->arch.has_protected_pmu isn't guarded by
kvm->lock, and I really hope we never get to that point (e.g. for SNP).

So instead of disallowing KVM_CAP_PMU_CAPABILITY entirely, this?

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index dc69b8cebe0b..b833a2596430 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -6911,6 +6911,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
                if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MASK))
                        break;
 
+               if (kvm->arch.has_protected_pmu) {
+                       WARN_ON_ONCE(kvm->arch.enable_pmu);
+                       if (cap->args[0] == KVM_PMU_CAP_DISABLE)
+                               r = 0;
+                       break;
+               }
+
                mutex_lock(&kvm->lock);
                if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
                        kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);


>  			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
>  			r = 0;
>  		}
> @@ -13375,7 +13376,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
>  	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info = true;
> -	kvm->arch.enable_pmu = enable_pmu;
> +	if (kvm->arch.has_protected_pmu)
> +		kvm->arch.enable_pmu = false;
> +	else
> +		kvm->arch.enable_pmu = enable_pmu;
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
