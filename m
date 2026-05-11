Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AD245031
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511105; cv=none; b=g3hFkSy2C+p8jY95gzSkBOE0ZQ1BglK0zT2lKjDDftCzhvUhuYbVZQrwCW1T7hrR5e1hZLM0hgbrKOXtF2bFJPSfS1HXRYY51rLyurTdX3vL/x5B8b/GcVbtfssh+0E35z+7E/T4gPD4D0wioL/uI8t++gsBh9dHBMyf8ZKfXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511105; c=relaxed/simple;
	bh=vEoj3APMu7MDn8Shs/q38WvFDrdJGND7vnMGa7Htg14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvoNAoqutOiz9iblzYoPAyP07+dbAt/8Pj96RZQC5XYByqPhiDfI9m57fPxJTqHi1gHZ48EYEtP6jGgVn9syZ99ikYkBe3UiV2D+rhilzUWGKqh5FgoVsrEkf+PkZu7k7A2VoiqwEABIx8WxHs6TWGIwT2rhpqC1+Z9qLUJfs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N8HtPhNq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8HtPhNq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso37568865e9.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778511101; x=1779115901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSXkxlGgFou0gT46PffshoEyoK84C9RqKdFNHnfAAII=;
        b=N8HtPhNqZzJXX/SMQMG8s77y99cpuD8+n5w5olC4M0c0WLja94bnoNnQKxqwd8+3wB
         F0MpqaHF4F1le4n8CFskbT8F0dLdy1EFZgHZRNTsOoyv/hEFj0S5OoHkzylHaJiHXwd/
         cVs+JIGDX0P3+BWgWNOakaaBUli21DW5XOUXqVdK8wMUrNJl7RzpAIdUUuhU0C7U0I+m
         tCabISmGZgCM6xS2RyhoUH0ikqpXEA7+iYoPPb9nWzNdvnCW8b6pdWr8OPPUZ/UkKp7t
         EvYAjOprZ5BzubkqBHdsAnzfbfkQt7DeESe4PLrs7Wn+N1bn3IwOOEB2DaCNMzAw0u9S
         EzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511101; x=1779115901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSXkxlGgFou0gT46PffshoEyoK84C9RqKdFNHnfAAII=;
        b=NbebGsvPEQQLweZZKIYfDyAzM2bALlOgLgPhHcgKCIPJpnJDRlHsT+qml0VGKe3V28
         UB+NWAHzp6HiB45hMfEAn1mjmEZ0tSRc6c7YRBiYM0A4jeUFBV8Rp2MkLVlqZb7zK4hn
         jRPLjPcZR03KjgwucG12riESVp7P9U0sCFiEuU6QFuxAZV0GVCuyrXarlJ/qAooPujfp
         70uFrFBr12e67bmBlSzkRdHdNQMfMjJT7d2Kk2nkQLDwSMiiHWw8b8wBOVeM6gVjc+Xl
         v2iiupJmuinBq9SRqW2Il14hcgJ629AAh2OCwWVO1t/f1muLbX4hZyAN5WOopKf/XxOV
         zPQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LzH9BL5kcJSqErP+RmdHmq+Xhjp57mD8Mbzj9feZj/2SEYvy+r+UTzojiUa2wM+uqjmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OdMYy5dy/XAH5S3uP+2zSrwLDIqpBHi1Uqr7wZIL6SjkjJNN
	ou9bBIs5Jw5IBWjgmbLVDbR+bmGL7uz6OqYlNty3NFJxmLOkK/u7oZspgg0wHEvlVlk=
X-Gm-Gg: Acq92OFTHB9wLb6cguUD+itZuQUpD/OCZQfm11JYgTObea3XSDazvKJDzXlIgllvUkl
	EkpD6lA0ImtfsTEYR8y4ctzd6FdCtIVzQiUHFA4mrLnV6Vqy26Z4NSkupIp4eKfw/tQvxKCs+eY
	Ck1AC4PbJuihycYo7Y6BkFAlvFYOHLOQ86pvXL3wdUX5nV6F+HEctg3ve1uGA+erTTyxYniH8tp
	yC15iF1t3gSE3oXmQDGS5QaSmVyO0DZr30daGXlVLnaiV/eBcKIzx7JMZ1FmoeublAYcMhQa0ut
	m2xaLcGdH009QIY9DdOCZGWWkidoc2SlyCfwhVKpobZAu51J2fhEuMiV8O4SSELNgv8oV5XSWXg
	q8v6TCP47ivhUJJtPZ9J8N2z/9eYbh40MsHLJPdJlrd/+qS210nWwjNgPKdFrXWOTR5Frds8xb6
	CHmvgyQXP1TssFizrYJDaqhBXowMuVDwz2Hzp03kQ=
X-Received: by 2002:a05:600c:64c5:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-48e51f4584fmr390331245e9.26.1778511100739;
        Mon, 11 May 2026 07:51:40 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e70410310sm201985155e9.12.2026.05.11.07.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 07:51:40 -0700 (PDT)
Message-ID: <485b8846-13d7-4d31-abf1-686d2516f772@linaro.org>
Date: Mon, 11 May 2026 15:51:39 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/20] perf: arm_pmuv3: Add method to partition the PMU
To: Colton Lewis <coltonlewis@google.com>
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
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org
References: <20260504211813.1804997-1-coltonlewis@google.com>
 <20260504211813.1804997-7-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260504211813.1804997-7-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/05/2026 10:17 pm, Colton Lewis wrote:
> For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
> counters into two ranges where counters 0..HPMN-1 are accessible by
> EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
> EL2.
> 
> Create a module parameter reserved_host_counters to reserve a number
> of counters for the host. Counters not reserved for the host may be
> used by a guest VM when the PMU is partitioned.
> 
> Add the function armv8pmu_partition() to check the validity of the
> reservation and record a partition has happened and the maximum
> allowable value for HPMN.
> 
> Due to the difficulty this feature would create for the driver running
> in nVHE mode, partitioning is only allowed in VHE mode. In order to
> support a partitioning on nVHE we'd need to explicitly disable guest
> counters on every exit and reset HPMN to place all counters in the
> first range.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h   |  4 ++
>   arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>   arch/arm64/kvm/Makefile            |  2 +-
>   arch/arm64/kvm/pmu-direct.c        | 22 +++++++++
>   drivers/perf/arm_pmuv3.c           | 77 ++++++++++++++++++++++++++++--
>   include/kvm/arm_pmu.h              |  8 ++++
>   include/linux/perf/arm_pmu.h       |  2 +
>   7 files changed, 115 insertions(+), 5 deletions(-)
>   create mode 100644 arch/arm64/kvm/pmu-direct.c
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 2ec0e5e83fc98..154503f054886 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -221,6 +221,10 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
>   	return false;
>   }
>   
> +static inline bool has_host_pmu_partition_support(void)
> +{
> +	return false;
> +}
>   static inline bool kvm_set_pmuserenr(u64 val)
>   {
>   	return false;
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index cf2b2212e00a2..27c4d6d47da31 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -171,6 +171,11 @@ static inline bool pmuv3_implemented(int pmuver)
>   		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
>   }
>   
> +static inline bool is_pmuv3p1(int pmuver)
> +{
> +	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P1;
> +}
> +
>   static inline bool is_pmuv3p4(int pmuver)
>   {
>   	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 3ebc0570345cc..baf0f296c0e53 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -26,7 +26,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>   	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
>   	 vgic/vgic-v5.o
>   
> -kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-direct.o pmu.o
>   kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
>   kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
>   
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> new file mode 100644
> index 0000000000000..74e40e4915416
> --- /dev/null
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Google LLC
> + * Author: Colton Lewis <coltonlewis@google.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/arm_pmuv3.h>
> +
> +/**
> + * has_host_pmu_partition_support() - Determine if partitioning is possible
> + *
> + * Partitioning is only supported in VHE mode with PMUv3
> + *
> + * Return: True if partitioning is possible, false otherwise
> + */
> +bool has_host_pmu_partition_support(void)
> +{
> +	return has_vhe() &&
> +		system_supports_pmuv3();
> +}
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 7ff3139dda893..6e447227d801f 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -42,6 +42,13 @@
>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
>   
> +static int reserved_host_counters __read_mostly = -1;
> +bool armv8pmu_is_partitioned;
> +
> +module_param(reserved_host_counters, int, 0);
> +MODULE_PARM_DESC(reserved_host_counters,
> +		 "PMU Partition: -1 = No partition; +N = Reserve N counters for the host");
> +
>   /*
>    * ARMv8 Architectural defined events, not all of these may
>    * be supported on any given implementation. Unsupported events will
> @@ -532,6 +539,11 @@ static void armv8pmu_pmcr_write(u64 val)
>   	write_pmcr(val);
>   }
>   
> +static u64 armv8pmu_pmcr_n_read(void)
> +{
> +	return FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
> +}
> +
>   static int armv8pmu_has_overflowed(u64 pmovsr)
>   {
>   	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
> @@ -1312,6 +1324,54 @@ struct armv8pmu_probe_info {
>   	bool present;
>   };
>   
> +/**
> + * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
> + * @host_counters: Number of host counters to reserve
> + *
> + * Determine if the number of host counters in the argument is an
> + * allowed reservation, 0 to NR_COUNTERS inclusive.
> + *
> + * Return: True if reservation allowed, false otherwise
> + */
> +static bool armv8pmu_reservation_is_valid(int host_counters)
> +{
> +	return host_counters >= 0 &&
> +		host_counters <= armv8pmu_pmcr_n_read();
> +}
> +
> +/**
> + * armv8pmu_partition() - Partition the PMU
> + * @pmu: Pointer to pmu being partitioned
> + * @host_counters: Number of host counters to reserve
> + *
> + * Partition the given PMU by taking a number of host counters to
> + * reserve and, if it is a valid reservation, recording the
> + * corresponding HPMN value in the max_guest_counters field of the PMU and
> + * clearing the guest-reserved counters from the counter mask.
> + *
> + * Return: 0 on success, -ERROR otherwise
> + */
> +static int armv8pmu_partition(struct arm_pmu *pmu, int host_counters)
> +{
> +	u8 nr_counters;
> +	u8 hpmn;
> +
> +	if (!armv8pmu_reservation_is_valid(host_counters)) {
> +		pr_err("PMU partition reservation of %d host counters is not valid", host_counters);
> +		return -EINVAL;
> +	}
> +
> +	nr_counters = armv8pmu_pmcr_n_read();
> +	hpmn = nr_counters - host_counters;
> +
> +	pmu->max_guest_counters = hpmn;
> +	armv8pmu_is_partitioned = true;
> +
> +	pr_info("Partitioned PMU with %d host counters -> %u guest counters", host_counters, hpmn);
> +
> +	return 0;
> +}
> +
>   static void __armv8pmu_probe_pmu(void *info)
>   {
>   	struct armv8pmu_probe_info *probe = info;
> @@ -1326,17 +1386,26 @@ static void __armv8pmu_probe_pmu(void *info)
>   
>   	cpu_pmu->pmuver = pmuver;
>   	probe->present = true;
> +	cpu_pmu->max_guest_counters = -1;
>   
>   	/* Read the nb of CNTx counters supported from PMNC */
> -	bitmap_set(cpu_pmu->cntr_mask,
> -		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
> +	bitmap_set(cpu_pmu->hw_cntr_mask, 0, armv8pmu_pmcr_n_read());
>   
>   	/* Add the CPU cycles counter */
> -	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
> +	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->hw_cntr_mask);
>   
>   	/* Add the CPU instructions counter */
>   	if (pmuv3_has_icntr())
> -		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
> +		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->hw_cntr_mask);
> +
> +	bitmap_copy(cpu_pmu->cntr_mask, cpu_pmu->hw_cntr_mask, ARMPMU_MAX_HWEVENTS);
> +
> +	if (reserved_host_counters >= 0) {
> +		if (has_host_pmu_partition_support())
> +			armv8pmu_partition(cpu_pmu, reserved_host_counters);
> +		else
> +			pr_err("PMU partition is not supported");
> +	}
>   
>   	pmceid[0] = pmceid_raw[0] = read_pmceid0();
>   	pmceid[1] = pmceid_raw[1] = read_pmceid1();
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 24a471cf59d56..95f404cdcb2df 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -47,7 +47,10 @@ struct arm_pmu_entry {
>   	struct arm_pmu *arm_pmu;
>   };
>   
> +extern bool armv8pmu_is_partitioned;
> +
>   bool kvm_supports_guest_pmuv3(void);
> +bool has_host_pmu_partition_support(void);
>   #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
>   u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
>   void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
> @@ -117,6 +120,11 @@ static inline bool kvm_supports_guest_pmuv3(void)
>   	return false;
>   }
>   
> +static inline bool has_host_pmu_partition_support(void)
> +{
> +	return false;
> +}
> +
>   #define kvm_arm_pmu_irq_initialized(v)	(false)
>   static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
>   					    u64 select_idx)
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 52b37f7bdbf9e..f7b000bb3eca8 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -109,6 +109,7 @@ struct arm_pmu {
>   	 */
>   	int		(*map_pmuv3_event)(unsigned int eventsel);
>   	DECLARE_BITMAP(cntr_mask, ARMPMU_MAX_HWEVENTS);
> +	DECLARE_BITMAP(hw_cntr_mask, ARMPMU_MAX_HWEVENTS);

I think this needs a comment or a clearer name. Both cntr_mask and 
hw_cntr_mask are used in KVM and the PMU driver and it's not immediately 
obvious what the difference is.



