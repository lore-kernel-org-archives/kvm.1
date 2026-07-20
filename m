Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F044331E
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566006; cv=none; b=RBEUfyubUWJafDP2PlLu2IuIsNwL3pt5ZwhNp3SlXMyFzL/qzOKPyc+u437q86stJotkIjvawDbUeJ1Q5GLfrkFTA5um/oAy295ByRMdOnlnodtUQ28hk5QXHgMWQFMlJKqGRahbcYl5gkGNrCKg6ZfGPQFUIH5a5du3KCuRq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566006; c=relaxed/simple;
	bh=XIao6mIlaKS8X9ZP1wVKDebqhjcSXIh5nEXgFPo3CXA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SzdX8TW4kz++7I58gJzlPh8cxlgmpeD1X28KAbawJZNfJV/H3WA3LVTP/7Td/55308ivEnSLCtGdV1/a12nieFSp0VDScWDMrA7XU0xAWeSJs5l9ClmxG8Z0hMmUeMHAQpOXAjzgjJvK/8MmqCaOTymW1D0C3D/KChvera2azFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zz3aiimX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zz3aiimX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4728c12ba97so5188463f8f.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784566000; x=1785170800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMSpywKxqagrBACgJFmPd3iIfkAUv2kJob+ZiosLjg0=;
        b=Zz3aiimXdOmo2nDQFnSZTGpYrpkvLYaCOqhV8wBwqSbYlBYFggbZ1ZqM/3rinXhiud
         oOdVOZgohGfIHZVpmJBPKNgAbsF/5m9YxnIe7G8JAYK3hp05THXNzJnFAxf8ikjMVNp/
         R/lr4GDBfof8gy/ln3GmzgrIrRMJk4Es8qa26MpZxcE0xp/nMULTWmPP6kZHDJndYdlm
         aST8OtabW4KpWo9s1BEVbeWCSMOfYugdPAO8NvzPfIM16auApnUZvWxBgik+QCPVu6F7
         HsDi9sEWgTQQ/P7VmWcQCiwjMmpo1EJFUtErnPU7uafL+GOa5vIfPQGTHDD/UVtBJigv
         Z66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566000; x=1785170800;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMSpywKxqagrBACgJFmPd3iIfkAUv2kJob+ZiosLjg0=;
        b=UHAWFN8LII4rbBV2P4xqH+fBxtUobhCme4+SE49VFnQRgsBWgpe/1Pu2sEZTZqdBpQ
         DyjYxVuZvNo3mMngrY1Mzoo30S3w6ohVuMFqlBAggqvKHdOTjRdTnvpWoqYHcRu5GoIW
         v4hDVNTHL6/p/E/GMa4Xsw2HIi7VuO2lUuIh1DIXuun3MNO4BAIH+O0c+hAuu4C89iNY
         Y2qAwCM5caPSHf3j3B7OTyfyGvE9QL4l8+PZV8mZ1CzWiCEEzPNOEQbRVLimKHQ349NB
         8A8GRfYCGgn18xUwtdw+ch0hXZfHCZUJMz4elVCy+piQVYO2VVYmKNr5XnF1heXtGAxu
         8caQ==
X-Forwarded-Encrypted: i=1; AHgh+RoH7iSmIIknemSJSnbA75+MD61IT7imlpXCn0VF6NQuRf7N+2ggx4o7izTPS1/6NahOJG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwh6SOtFO7XPnBwX+iSeD15gwYQeidGbVEqaoIkdfyMNyXh39
	3L2zluCAsHN+mC4eHwfF5mnkgkyhM+w4tFy6Qdsi/dV1QNUUaEPFdVukuCHFmXF95dE=
X-Gm-Gg: AR+sD11lj7py42uPcAj4+eCbnpDwEoXVqqG/txUtpEUppkgbgPb6zFWeoDk1xzE3D9h
	Iyw+yxadbvinfi/YKI0DIX2FKT39k5nNXLOh6sys18RJ6SBC9J5iBvD1aJAgvLw4ev3HitwVeFo
	hAVJ0VVB5GgOiCJHmoAOJH0FC9T0GSnSQ+KrodKx+8aNJN9CDy7uwwFatEEynZPRI+dqATDQRBp
	iwfPGf3xnbEkR0Qg8EH9MmzkfN2uxTMXzluBzB63UqiSPyA3SDxFSCMJ9FVu2j42uhDdnz4gBth
	dVrLpNEskzmfyiQfG59D/y2o0rIcWi2krwr5k2CsojYpvpbOUD7cNt7su/F4Ca5EhhNLASpJn+Q
	bdJdSRN5hS9DxmhxJbWNkNyIV+XsPuuGNadwkRs3C4Oem7l9v4AQMFtiAAPCIqL3TmvNkn0Ln7R
	DL+CQwOrk=
X-Received: by 2002:a05:6000:4310:b0:47d:ecaa:3f97 with SMTP id ffacd0b85a97d-47f6233db68mr17307845f8f.45.1784566000150;
        Mon, 20 Jul 2026 09:46:40 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496afsm32530307f8f.1.2026.07.20.09.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 09:46:39 -0700 (PDT)
Message-ID: <3fc867c3-67a0-4fdd-b871-f2ba4d642f1f@linaro.org>
Date: Mon, 20 Jul 2026 17:46:37 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 11/21] KVM: arm64: Context swap Partitioned PMU guest
 registers
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260612192909.1153907-1-coltonlewis@google.com>
 <20260612192909.1153907-12-coltonlewis@google.com>
Content-Language: en-US
In-Reply-To: <20260612192909.1153907-12-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2026 20:28, Colton Lewis wrote:
> Save and restore newly untrapped registers that can be directly
> accessed by the guest when the PMU is partitioned.
> 
> * PMEVCNTRn_EL0
> * PMCCNTR_EL0
> * PMSELR_EL0
> * PMCR_EL0
> * PMCNTEN_EL0
> * PMINTEN_EL1
> 
> If we know we are not partitioned (that is, using the emulated vPMU),
> then return immediately. A later patch will make this lazy so the
> context swaps don't happen unless the guest has accessed the PMU.
> 
> PMEVTYPER is handled in a following patch since we must apply the KVM
> event filter before writing values to hardware.
> 
> PMOVS guest counters are cleared to avoid the possibility of
> generating spurious interrupts when PMINTEN is written. This is fine
> because the virtual register for PMOVS is always the canonical value.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h |   4 +
>   arch/arm64/kvm/arm.c             |   2 +
>   arch/arm64/kvm/pmu-direct.c      | 183 +++++++++++++++++++++++++++++++
>   include/kvm/arm_pmu.h            |  16 +++
>   4 files changed, 205 insertions(+)
> 

[...]

> +
> +/**
> + * kvm_pmu_put() - Put untrapped PMU registers
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Put all untrapped PMU registers from the VCPU into the PCPU. Mask
> + * to only bits belonging to guest-reserved counters and leave
> + * host-reserved counters alone in bitmask registers.
> + */
> +void kvm_pmu_put(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu;
> +	unsigned long guest_counters;
> +	unsigned long flags;
> +	u64 mask;
> +	u8 i;
> +	u64 val;
> +
> +	/*
> +	 * If we aren't guest-owned then we know the guest is not
> +	 * accessing the PMU anyway, so no need to bother with the
> +	 * swap.
> +	 */
> +	if (!kvm_pmu_is_partitioned(vcpu->kvm))
> +		return;
> +
> +	preempt_disable();
> +
> +	pmu = vcpu->kvm->arch.arm_pmu;
> +	guest_counters = kvm_pmu_guest_counter_mask(pmu);
> +
> +	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
> +		if (i == ARMV8_PMU_CYCLE_IDX)
> +			val = read_pmccntr();
> +		else
> +			val = read_pmevcntrn(i);
> +
> +		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
> +	}
> +
> +	val = read_sysreg(pmselr_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
> +
> +	val = read_sysreg(pmcr_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);
> +
> +	/* Mask these to only save the guest relevant bits. */
> +	mask = kvm_pmu_guest_counter_mask(pmu);
> +
> +	val = read_sysreg(pmcntenset_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
> +
> +	val = read_sysreg(pmintenset_el1);
> +	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
> +
> +	/* Save pending guest hardware overflows. */
> +	local_irq_save(flags);
> +	val = read_sysreg(pmovsset_el0);
> +	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val & mask);
> +	write_sysreg(val & mask, pmovsclr_el0);
> +	local_irq_restore(flags);
> +
> +	/* Stop guest counters and disable interrupts in hardware. */
> +	write_sysreg(mask, pmcntenclr_el0);
> +	write_sysreg(mask, pmintenclr_el1);
> +
> +	kvm_pmu_set_guest_counters(pmu, 0);

Hi Colton,

This function doesn't get added until "KVM: arm64: Apply dynamic guest 
counter reservations" a few commits later.

kvm_pmu_guest_counter_mask() is also used in a commit before it's added.

