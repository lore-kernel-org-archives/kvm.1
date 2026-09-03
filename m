Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEA3932D3
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418645; cv=none; b=aT9i4pfteL9jjEapRYuuOiyb1sFbkg6GGKJa8bIREnqTWNHNMZHtYwpN4WDV9K/OBH9tTiM1IVIMJpKTfcmZevsv9ftPkUXi/0HlhwCxTxhs5BpXTBlCv5cUfvl0YT2VVry/N3UfUq8spxPZL1PmAFc60PPrMyznUEKmaN3Eizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418645; c=relaxed/simple;
	bh=bSa+nFQj+CPzTmYkc89tYFj5cli0yStxkzwrNmP41bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAUhcTUzJAEgLW2BJVg8XuY6A7rSiiFtLS7qqyeXjgrrOUXxTVpV691FpIyyWQJBnaf9UuofBqCyJaHxEqfFLH6VVqTA01VwHKL/2IBmot+uYiyFnCBUCOl33zIvUGYkvFDmA2BFGFvDZexbb271TEzgRK3v8Yd3297qSAY6lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+l4JRu+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+l4JRu+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84eb992a881so1780172b3a.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788418643; x=1789023443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQAD7rErtH2rkwFTeIdMxJ6XwJ9Xw5f/uWMDPip1wyw=;
        b=c+l4JRu+eIYjvYEZGfsmJIZVdcuMIzbisviyqmvQwD618jB2ktffxRpGC5jfgHbRni
         1EW7I5iVitcq4AuXbOriuRSfAJgP6tPPofzNVGhVH/Oc1w6frVHttmPAev/NqnKXXM8z
         6+sKUXF34J8mH0fuu7zpBsYdF1kVKk5DdPiA3VcVo3MRMopx1XKDvdVCd3KIQ0RVXFh3
         XGifAvwbRpE4Wr5V+lbQ45koN9n4qGimGuYHyIMV1lTUCU/lOf/bSw+ddLTGGAAWuw9Z
         6XNtDAukveSVqbaXjIZ4yGgS/E4fPDBwkSGZe0+xfkhtIku+O5NUhq7pnxDkGSJaEPyY
         QXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418643; x=1789023443;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQAD7rErtH2rkwFTeIdMxJ6XwJ9Xw5f/uWMDPip1wyw=;
        b=H8bQw/BPH/iwARgXfOSZx9izU7lVZNpWXMzgpv2mOusGTBgrXgZ5fsgNCPUgzZRZml
         LW+9EEX+e1wPM/6areTgEty8nIQcUf647GXzZG5hyccI3W+fU4NW5y+EJKJiLQLfnWxI
         4bgszWKsGTR6UN7Dp7Po/w3S0vf/OY/KiXQflrkWIwnKeB5NbCVnQn88jZs5a98nPRKk
         lUtvZx7vZ0ux10X/+JVDPFds72qdhdcDL0PDvniPOhfH6LvN3W9eHLL0rmt6l1dZjC4o
         NCwtkxsKfiQXV4x3N1vefNsqTssstGr3bcJBQauYtUOxZcipFMW1wKc8kErbkfqDbp3f
         +zSQ==
X-Gm-Message-State: AFuF++lZ11X0SMHrMQYcHS9SCxhR0SLX6q+HvvcuRqH+vy1efsNRGyyM
	YNCRt5uA+jiY1oydLEnabGC4JBPWBXoSjDhKGHF06rSJhwU3vdrTlsxs
X-Gm-Gg: AYBFou2UANrxx8uqIigfXihrz5Aiaa4JQzvq2pA91kgsq48lNyLUD/oavcUk1+c6YZA
	k28PKH37zAV69HZB5lcyXoV1Lmp6U2qenX0OHSfijgnfqJ7wa8u/dzRdSaNkdXMNp6BFupVQwDk
	mLtuIp6wutBUtyqn2i0+UC3N95MRV6e44ukkmJPSb/RM5HI+4sinFKLUAqmrLibNtPChlYcCwRD
	xqjeA3YhqvIvd9ho1kzuLtKRR7XUoyZjmjgOoGiZJcxNBjvSbnSts8LvYGbpeXf/jUv5VWnpany
	3/1uOa21l9bgt+BJPuExfK3lAJUVjkop98upT1T7cCzXz2CwFu3ovJj13AR51MKqmXME1rnkUG0
	TU8pHJdIdD6zVgLCB5rlCCJGzx4n+9PhKvWBjN2P9+ceP4KY99MQeVmom7nhwMbTvcmlDILbtVU
	j8fy9YBzFY2dn+wokmAuoWMjhw/K1lxHTZag6xN2l1So1aizuvtOIXmMsvgRJNyXmvN1LnW0wm7
	R6MkmbYxiw3dr2PMQ==
X-Received: by 2002:a05:6a00:997:b0:84e:f90e:492f with SMTP id d2e1a72fcca58-85ed25e06efmr13508418b3a.7.1788418643314;
        Wed, 02 Sep 2026 23:57:23 -0700 (PDT)
Received: from [10.26.143.60] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2ae0308sm2330992b3a.21.2026.09.02.23.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 23:57:22 -0700 (PDT)
Message-ID: <054d5694-c4db-416e-8595-8a47a8d5f8eb@gmail.com>
Date: Thu, 3 Sep 2026 14:57:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/pmu: Move Intel PMU global MSRs to
 intel_is_valid_msr()
To: Jim Mattson <jmattson@google.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, likexu@tencent.com, sandipan.das@amd.com,
 yosry@kernel.org, pbonzini@redhat.com
References: <20260902184711.138538-1-jmattson@google.com>
Content-Language: en-US
From: Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <20260902184711.138538-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 2:47 AM, Jim Mattson wrote:
> Commit c85cdc1cc1ea ("KVM: x86/pmu: Move handling PERF_GLOBAL_CTRL and
> friends to common x86") moved the existence check for the following Intel
> PMU MSRs to kvm_pmu_is_valid_msr():
>   - MSR_CORE_PERF_GLOBAL_STATUS
>   - MSR_CORE_PERF_GLOBAL_CTRL
>   - MSR_CORE_PERF_GLOBAL_OVF_CTRL
> 
> That commit deemed these MSRs valid whenever pmu->version > 1. It intended
> to share the check with AMD PerfMonV2 because both vendor implementations
> require version 2 or greater for global PMU controls.  However, as noted in
> the commit message, AMD uses different MSR indices for its global PMU
> registers.
> 
> Commit 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> subsequently added AMD PerfMonV2 support and set pmu->version = 2.  Because
> kvm_pmu_is_valid_msr() validated the Intel MSRs whenever pmu->version > 1,
> KVM incorrectly permitted AMD guests with PerfMonV2 to access these Intel
> MSRs without a #GP.
> 
> Move the validation of these Intel MSRs to intel_is_valid_msr() and remove
> the common switch statement from kvm_pmu_is_valid_msr(). AMD already
> validates its own global PMU MSRs in amd_is_valid_msr().
> 
> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Like Xu <likexu@tencent.com>

> ---
>   arch/x86/kvm/pmu.c           | 8 --------
>   arch/x86/kvm/vmx/pmu_intel.c | 3 +++
>   2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a7d60c8785cd..d2fd47ee5ec8 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -823,14 +823,6 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
>   
>   bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>   {
> -	switch (msr) {
> -	case MSR_CORE_PERF_GLOBAL_STATUS:
> -	case MSR_CORE_PERF_GLOBAL_CTRL:
> -	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> -		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
> -	default:
> -		break;
> -	}
>   	return kvm_pmu_call(msr_idx_to_pmc)(vcpu, msr) ||
>   	       kvm_pmu_call(is_valid_msr)(vcpu, msr);
>   }
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index bfa8612fb450..70a8c4816135 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -187,6 +187,9 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>   	int ret;
>   
>   	switch (msr) {
> +	case MSR_CORE_PERF_GLOBAL_STATUS:
> +	case MSR_CORE_PERF_GLOBAL_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>   	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>   		return kvm_pmu_has_perf_global_ctrl(pmu);
>   	case MSR_IA32_PEBS_ENABLE:

