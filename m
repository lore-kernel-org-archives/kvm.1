Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9F3AD503
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936026; cv=none; b=oQGvamilVPwfjeyDSJXEhFuuAiWeyWalEXzN5bpYssKiniLHgxYrP8nQzTPX2sqOtFASylbj4OndGiDCQQsJic5FPJegUwJEaO5avpiWtDI/l1MRmy5Ojfs7zZqVXHEZVTME//d449K8HdXpFqQSWnOMY4lG3JHbTRk5QDwcM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936026; c=relaxed/simple;
	bh=xjhTv/kIUIkXqTjzxhhfg3keGYHyaGpesz7JJG2KoTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoTBDOHNETm6et4g+/rqC8GIkwGkfWggg3UBL9hL5nvuqk+fRwO5Wncm771dQ6hVPsMp187StxGXecbeGa0IUqof2+NW7DH6mri4WebkZyy450JwFxBN3S3ttkQa1Z/swdK3lJb6fAkDytXAU/nXy8FEL+3Cxh4q7jt5fTFrqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnxa3L/J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5G0yRUQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnxa3L/J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5G0yRUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788936023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROX0AzEGKtnku63/O4EIu9e6E88ExwOGJkGzN1mDSfs=;
	b=bnxa3L/J3J87MsJD+QX3dLHuF+Qnt4MHJOZvnxSFpDg7RUsGz1MYJ86fwC2L3XkkhlO486
	b9dy//JdvlCyiZb+QwoWgyrEC9GPrSyzjAUaPAuaY7PoPaq/2pQGm9ofcHqSe6Ra5WZ79l
	7Qe5zURk4/RFPVzbtUtJQkXl1+gDjvU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-oznM8RMZPtS5fcev4y6MEA-1; Wed, 09 Sep 2026 02:40:20 -0400
X-MC-Unique: oznM8RMZPtS5fcev4y6MEA-1
X-Mimecast-MFC-AGG-ID: oznM8RMZPtS5fcev4y6MEA_1788936019
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8627258ef12so4093820b3a.2
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788936019; x=1789540819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROX0AzEGKtnku63/O4EIu9e6E88ExwOGJkGzN1mDSfs=;
        b=E5G0yRUQStfyvffsZ20Z+gpy0cT5ImZR73QXA29XQvwWe4oHZKltABu7i0Soiq2vEG
         0rWipoIwXzwAg7S4VypIECdLo5Z6KZ9DTgHRy115roV198EmOUqVUiiBPuo2flg0sHPW
         AyaYQtHKUFi0WRAO9W3AZP7M4ysofW2h8V39rvO6qnM0ErkhbzqXeuyPnnQ14gzy2tgQ
         PHLPvnasdwZDrI647bIpc7f4YAG5HxJszzYbN1Zh0BoUmQq5oFmXQcLmLqtClEIxLtlN
         CesK43FZTvFqDvJafo/6lrgXZJmYZSBwLCmu8UengZcy0kktKX1PZigMwZjs0mUXhe16
         0T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788936019; x=1789540819;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROX0AzEGKtnku63/O4EIu9e6E88ExwOGJkGzN1mDSfs=;
        b=KMgfAiUfqob4xaCJUzJHVT6E1HbCpuHS60aRQ7qEDPM01oa/9hjPDVf7hMVpb3uN2g
         lgXGiUlFGCV/rw5Bx20Ks9wZoIQACDJV/c8qdBGRj2hJVRO8XmxH4jzmjYL8R7z7m9Cy
         hNyRauOXD4oMSxntDEgsOI1G7dDO1uU6jlblLRsQOSWjS2sxJ+Clr7U5JUXjnVRzogEp
         SqpTHKwnntksXDArWKYIVb82VVgevUYDdvOtToM3/IvWmK9w4MrFIkWxo+LeuCZqyvku
         ene3dLNWFsd6H/6qolT4pP+nrUju72FhZE1VGU4cdz+cp34BiZMw+Ge34ia+8o6vAoag
         fHEw==
X-Forwarded-Encrypted: i=1; AKwUvBz24yCEHVZyQThqj+cmCD/2a6vYCYdZsPrfSyEHCSbCW4PBnf00cn9cOcKFs0XdSz9WfAc=@vger.kernel.org
X-Gm-Message-State: AFuF++kA47tSXt9FlH8MC2wdwCk933dDa+/aLj56Rr77DRZXJZ+Fgijp
	oJA3ZdLDbDysuBtWaHvJfGoHi4aCz/qBxw380tAqS/abLbO2iMioobS3nt0uMdGuhc3XXstNRmM
	lqoYIqxDd6n+bxGXuZEPw0eiOhuT0rUN1wSO4Ig3NYJZVzNKqvMaYqA==
X-Gm-Gg: AYBFou3bITBTPdomfGAVyfuDiRurI+Lyr4/HkJ6d93WMbi+bhYpsJtZoE6xf6E54Hpy
	Zc+XgH9WaG97Vr511CP8gF974/TCC7fueX7fR9JOYvoWUFLeiLgdsVqohl2wQKuu4k0/qmnnTTI
	Dtlazai2R9nDW0TnC83eM4QIh7T+fZqyUxLXAD98vRBeu20LVQWaAb+1tYXgyq/lat4AY6emErP
	2bR6hlLjLgTBGa3u6iXhhDUfWqgPNlBgse61gybxGF5h27fuJ8tQaX/+TivKLUfX06cr9/oyMnM
	ULZvNJuvfVj6deCi18A1gsLNeOs57kJOuDuuWwxXmGAmxpFeW8uM4+DQQ0vjgOX7+r3CL1rhiuL
	4VjXjCT8W94sv4eUUtTo/XzN+fkbyJSOL6+X7KK1DMg==
X-Received: by 2002:a05:6a00:1702:b0:857:726d:270c with SMTP id d2e1a72fcca58-8616dd51063mr47210175b3a.24.1788936018875;
        Tue, 08 Sep 2026 23:40:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:1702:b0:857:726d:270c with SMTP id d2e1a72fcca58-8616dd51063mr47210112b3a.24.1788936018206;
        Tue, 08 Sep 2026 23:40:18 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8633cc0f7e2sm4760580b3a.37.2026.09.08.23.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 23:40:17 -0700 (PDT)
Message-ID: <5d2aa6a0-61a3-4b0c-8866-58c4a7888de3@redhat.com>
Date: Wed, 9 Sep 2026 16:40:04 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 6/7] firmware: arm_rmm: Ensure the RMM has GPT entries
 for memory
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <20260907095942.1140734-7-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260907095942.1140734-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 7:59 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> The RMM maintains the state of all the granules in the system to make
> sure that the host is abiding by the rules. This state can be maintained
> at different granularity, per page (TRACKING_FINE) or per region
> (TRACKING_COARSE or TRACKING_INTERMEDIATE). The region size depends on the
> underlying "RMI_GRANULE_SIZE". For a "coarse"/"intermediate" region, all pages
> in the region must be of the same state, this implies we need to have "fine"
> tracking for DRAM, so that we can delegate individual pages.
> 
> For now we only support a statically carved out memory for tracking
> granules for the "fine" regions. This can be extended in the future to
> allow modifying the tracking granularity and remove the need for a
> static allocation by the firmware.
> 
> Similarly, the firmware may create L0 GPT entries describing the total
> address space. But if we change the "PAS" (Physical Address Space) of a
> granule, then the firmware may need to create L1 tables to track the PAS
> at a finer granularity. Linux therefore checks if the platform firmware manages
> the PAR region. i.e., the firmware is in charge of managing the L1 GPTs
> (creation and the required memory for the GPT tables - via static carveouts)
> without host intervention. Support for dynamic GPT creation by the host will be
> added later.
> 
> If the firmware requires us to manage the tracking or GPT memory, Deactivate
> the RMM and reclaim any memory donated at RMM activation.
> 
> Apply the same checks when hotplugged memory is brought online.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> [ Switch to RMI_GPT_L1_INFO for checking GPTs and deactivate RMM ]
> Co-Developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   Changes since v16:
>       * Check fine tracking and create L1 GPTs for hotplug-added memory.
>       * Clarify the L1 GPT setup and move the explanatory comment.
>       * Switch to using RMI_GPT_INFO command for checking the GPTs.
>       * Deactivate the RMM and reclaim the memory if we can't proceed.
>   Changes since v15:
>       * Skip firmware-reserved NOMAP memory in rmi_init_metadata()
>       * Handle negative error codes from wrappers.
>   Changes since v14:
>       * Move the implementation into drivers/firmware/arm_rmm.
>   Changes since v13:
>       * Moved out of KVM
> ---
>   drivers/firmware/arm_rmm/rmi.c | 139 +++++++++++++++++++++++++++++++++
>   include/linux/arm-rmi-cmds.h   |  75 ++++++++++++++++++
>   2 files changed, 214 insertions(+)
> 
> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
> index d969c8738efde..34058e34188d3 100644
> --- a/drivers/firmware/arm_rmm/rmi.c
> +++ b/drivers/firmware/arm_rmm/rmi.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/cpufeature.h>
>   #include <linux/memblock.h>
> +#include <linux/memory.h>
>   #include <linux/arm-rmi-cmds.h>
>   #include <linux/processor.h>
>   #include <linux/slab.h>
> @@ -12,6 +13,8 @@
>   #include <asm/memory.h>
>   #include <asm/pgtable-hwdef.h>
>   
> +static bool arm64_rmi_is_available;
> +
>   /* Currently only the first 2 registers are used by Linux */
>   #define RMI_FEAT_REG_COUNT	2
>   static __ro_after_init unsigned long rmi_feat_reg_cache[RMI_FEAT_REG_COUNT];
> @@ -639,6 +642,124 @@ static int rmi_configure(void)
>   	return ret;
>   }
>   
> +/*
> + * Make sure the area is tracked by RMM at FINE granularity.
> + * We do not support changing the tracking yet.
> + */
> +static int rmi_verify_memory_tracking(phys_addr_t start, phys_addr_t end)
> +{
> +	while (start < end) {
> +		unsigned long ret, category, state, next;
> +
> +		ret = rmi_granule_tracking_get(start, end, &category, &state, &next);
> +		if (ret != RMI_SUCCESS)
> +			return -ENOMEM;
> +
> +		if (state != RMI_TRACKING_FINE ||
> +		    category != RMI_MEM_CATEGORY_CONVENTIONAL) {
> +			/* TODO: Set granule tracking in this case */
> +			pr_err("Granule tracking for region isn't fine/conventional: %llx-%lx\n",
> +			       start, next);
> +			return -ENODEV;
> +		}
> +		start = next;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * We do not support creating L1 GPTs yet. So, make sure that
> + * all the regions are managed by the firmware.
> + */
> +static int rmi_verify_gpt_firmware_managed(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long l0gpt_sz;
> +	unsigned long next, par_state;
> +
> +	l0gpt_sz = 1UL << (30 + FIELD_GET(RMI_FEATURE_REGISTER_1_L0GPTSZ,
> +					  rmi_feat_reg(1)));
> +	start = ALIGN_DOWN(start, l0gpt_sz);
> +	end = ALIGN(end, l0gpt_sz);
> +
> +	while (start < end) {
> +		long ret = rmi_gpt_info(start, end, &next, &par_state);
> +
> +		if (ret != RMI_SUCCESS)
> +			return -ENOMEM;
> +
> +		if (par_state != RMI_GPT_PAR_PLAT) {
> +			pr_err("GPT for the region is not managed by firmware %llx-%lx\n",
> +				start, next);
> +			return -ENOMEM;

I guess -ENODEV is more appropriate:

			return -ENODEV

> +		}
> +		start = next;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rmi_prepare_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	int ret;
> +
> +	ret = rmi_verify_memory_tracking(start, end);
> +	if (ret)
> +		return ret;
> +
> +	return rmi_verify_gpt_firmware_managed(start, end);
> +}
> +
> +static int rmi_init_metadata(void)
> +{
> +	phys_addr_t start, end;
> +	struct memblock_region *r;
> +
> +	for_each_mem_region(r) {
> +		int ret;
> +
> +		/* Firmware-reserved NOMAP regions are not usable system RAM */
> +		if (memblock_is_nomap(r))
> +			continue;
> +
> +		start = memblock_region_memory_base_pfn(r) << PAGE_SHIFT;
> +		end = memblock_region_memory_end_pfn(r) << PAGE_SHIFT;
> +
> +		ret = rmi_prepare_memory(start, end);
> +		if (ret)
> +			return ret;

The local variable 'start' and 'end' can be dropped:

		ret = rmi_prepare_memory(PFN_PHYS(memblock_region_memory_base_pfn(r)),
					 PFN_PHYS(memblock_region_memory_end_pfn(r)));
		if (ret)
			return ret;

> +	}
> +
> +	return 0;
> +}
> +
> +static int rmi_memory_notifier(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	struct memory_notify *arg = data;
> +	phys_addr_t start, end;
> +	int ret;
> +
> +	if (action != MEM_GOING_ONLINE)
> +		return NOTIFY_DONE;
> +
> +	start = PFN_PHYS(arg->start_pfn);
> +	end = PFN_PHYS(arg->start_pfn + arg->nr_pages);
> +	ret = rmi_prepare_memory(start, end);
> +
> +	return notifier_from_errno(ret);
> +}
> +
> +static struct notifier_block rmi_memory_nb = {
> +	.notifier_call = rmi_memory_notifier,
> +};
> +
> +bool is_rmi_available(void)
> +{
> +	return arm64_rmi_is_available;
> +}
> +EXPORT_SYMBOL_GPL(is_rmi_available);
> +
>   static int __init arm64_init_rmi(void)
>   {
>   	int ret = 0;
> @@ -666,8 +787,26 @@ static int __init arm64_init_rmi(void)
>   	if (ret) {
>   		pr_err("RMM activate failed\n");
>   		ret = ret < 0 ? ret : -ENXIO;
> +		goto out_free_sro;
>   	}
>   
> +	ret = rmi_init_metadata();
> +	if (ret)
> +		goto out_deactivate;
> +
> +	ret = register_memory_notifier(&rmi_memory_nb);
> +	if (ret)
> +		goto out_deactivate;
> +
> +	arm64_rmi_is_available = true;
> +	pr_info("RMI configured\n");
> +	kfree(sro);
> +
> +	return 0;
> +
> +out_deactivate:
> +	rmi_rmm_deactivate(sro);
> +out_free_sro:
>   	kfree(sro);
>   	return ret;
>   }
> diff --git a/include/linux/arm-rmi-cmds.h b/include/linux/arm-rmi-cmds.h
> index dea7c7004d35f..79e2c1f165112 100644
> --- a/include/linux/arm-rmi-cmds.h
> +++ b/include/linux/arm-rmi-cmds.h
> @@ -35,6 +35,8 @@ static inline int rmi_undelegate_page(phys_addr_t phys)
>   	return rmi_undelegate_range(phys, PAGE_SIZE);
>   }
>   
> +bool is_rmi_available(void);
> +
>   long rmi_sro_memxfer_execute(struct rmi_sro_state *sro, gfp_t gfp);
>   void rmi_sro_free(struct rmi_sro_state *sro);
>   long rmi_sro_execute(struct arm_smccc_1_2_regs *regs);
> @@ -64,6 +66,19 @@ static inline int rmi_rmm_config_set(unsigned long cfg_ptr)
>   	return res.a0;
>   }
>   
> +/**
> + * rmi_rmm_deactivate() - Deactivate the RMM and reclaim any memory donated at
> + * rmi_rmm_activate()
> + *
> + * @sro: Preallocated SRO context to be used
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rmm_deactivate(struct rmi_sro_state *sro)
> +{
> +	return rmi_sro_memxfer_cmd(sro, GFP_KERNEL, SMC_RMI_RMM_DEACTIVATE);
> +}
> +

It seems rmi_rmm_deactivate() is used for once by rmi.c::arm64_init_rmi(). If so,
we needn't to expose this function and just combine the logics to rmi.c::arm64_init_rmi().

>   /**
>    * rmi_rmm_activate() - Activate the RMM
>    * @sro: Preallocated SRO context to be used
> @@ -75,6 +90,66 @@ static inline long rmi_rmm_activate(struct rmi_sro_state *sro)
>   	return rmi_sro_memxfer_cmd(sro, GFP_KERNEL, SMC_RMI_RMM_ACTIVATE);
>   }
>   
> +/**
> + * rmi_granule_tracking_get() - Get configuration of a Granule tracking region
> + * @start: Base PA of the tracking region
> + * @end: End of the PA region
> + * @out_category: Memory category
> + * @out_state: Tracking region state
> + * @out_top: Top of the memory region
> + *
> + * Return: RMI return code
> + */
> +static inline int rmi_granule_tracking_get(unsigned long start,
> +					   unsigned long end,
> +					   unsigned long *out_category,
> +					   unsigned long *out_state,
> +					   unsigned long *out_top)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_GRANULE_TRACKING_GET, start, end, &res);
> +
> +	if (res.a0 == RMI_SUCCESS) {
> +		if (out_category)
> +			*out_category = res.a1;
> +		if (out_state)
> +			*out_state = res.a2;
> +		if (out_top)
> +			*out_top = res.a3;
> +	}
> +
> +	return res.a0;
> +}
> +

rmi_granule_tracking_get() is used for once by rmi.c::rmi_verify_memory_tracking(). We needn't
expose rmi_granule_tracking_get() and combine its logic into rmi.c::rmi_verify_memory_tracking().

> +/*
> + * rmi_gpt_info - Query the GPT info for the given PAR.
> + * @base: Base of the physical address region
> + * @top: Top of the physical address region
> + * @out_top: Top of the phyiscal address region for which
> + *		the GPT @out_gpt_par_state is valid
> + * @out_gpt_par_state: State of the GPT covered by [base, out_top)
> + */
> +static inline long rmi_gpt_info(unsigned long base, unsigned long end,
> +			       unsigned long *out_top,
> +			       unsigned long *out_gpt_par_state)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_GPT_INFO, base, end,
> +	};
> +
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS) {
> +		if (out_top)
> +			*out_top = regs.a1;
> +		if (out_gpt_par_state)
> +			*out_gpt_par_state = regs.a2;
> +	}
> +
> +	return ret;
> +}
> +

Similarly, rmi_gpt_info() is used for once by rmi.c::rmi_verify_gpt_firmware_managed(). We
needn't expose this function and can combine the logic to rmi.c::rmi_verify_gpt_firmware_managed().

>   /**
>    * rmi_features() - Read feature register
>    * @index: Feature register index

Thanks,
Gavin

