Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42223D7F0
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325145; cv=none; b=b0gmol2hkgrqZ9bAQwASCcSNHfBJlEwRnFlssmK8Mk+m5jRN+nmEnnoSjjriaMsbLbBB1RnlaJAwaeBN6j4W4VaOOozN21Tba2uIky3tvD/vTuxYy9qu2zdj94+7VBJLPnXvXFZxH+XTJpiPioLIyelM06Pw1AOVC7SoHq8/Je0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325145; c=relaxed/simple;
	bh=jQVcEz6If3VJhslkkkaqlcEh1bxAzmMcOa3WQaKRwPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeTL0BnHgCuZ/WposkTaBBvM8tprJkuSow8uLNxAaW8faPcfzapx/YCoGL07HcuTJJ7wcu3JA6zTOg9SF6pjlhx0rMCDQXEqXzJ3BamlP4cP1vEMPa5W7i87tIrFNpUwfJh2u78AWGLQsRpFPc+VFHQUUxh61HAVvYiQcB7n+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQ0yIRag; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwG6uT2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQ0yIRag";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwG6uT2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779325143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esITWrykl3jmF+42dffE0BRU5vQF9ekvEW6cQfDO2lo=;
	b=CQ0yIRagg1WxjZ8ngB/XJJU2ESgBugNU1kjoDrR4KOIVtRfCCk+dee+vTmsiX4bbG7pGIJ
	nGYWP123dDjl43pmMqfmyWBrLznQvZV7DbY/u7wO2y8aDQ81IKnzhL5BZiq3qGq8sAl/87
	kVo29n4aZUVqgKSUCrHZKNApsT5Bp7w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-7sTFOKGkP3KsHEZkWsUNoQ-1; Wed, 20 May 2026 20:59:01 -0400
X-MC-Unique: 7sTFOKGkP3KsHEZkWsUNoQ-1
X-Mimecast-MFC-AGG-ID: 7sTFOKGkP3KsHEZkWsUNoQ_1779325140
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2babc42244aso133983945ad.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779325140; x=1779929940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esITWrykl3jmF+42dffE0BRU5vQF9ekvEW6cQfDO2lo=;
        b=DwG6uT2aUYhxyXohBYQKqGJBeBYauIKXQZuoMwBMMYALsrhfxmZAo1IuYlLCP+5uKZ
         24v4IjKRyrTu3wHibWQmsbJxJNS0RZSXi2gVuDzBeUD9/Vn3GsY9KajgNXGwpPqlU8NA
         3n2czWNCgQ45HzAp1C3efWdKJar8JjDO88VwmxSScj5KgVFqAuhYr7n166pVcb73jcZO
         cG7U8cYi4UolQDEfXpew/ojbEOPC+xPKqnwln+46N9dTpppcCealWvjdDfJG4wLfl9mn
         rVBFf+FEmhhJQadAAYO35LwvLqN0FsLLnnybimfxkcTG5IH+/867YaVvQpmr/onP7Uff
         txOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325140; x=1779929940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esITWrykl3jmF+42dffE0BRU5vQF9ekvEW6cQfDO2lo=;
        b=LkLBnC8tkQGPiCIxlXQTBl7kAu010r2MBoI4U4P2LJlsgMESmgfIj3fhSqMTNzDfQu
         0qXKcr+TmWNyP4tJMpRWD5p1lpfuyguEcSDXtpFnKEJyzGoSLKj35OOQostAVAVWaBsw
         vILhTs7uCw0gI3v7dX4ZW9PwCNPm6HgwJCElNe/EfS0+A1qT2+sE31BFseGETtZr1yw7
         SHuUxkSVluCBn6udM30ZvAf3zbi7Sv8kLgYGAecj3WXuTdN/VnimzdKqC1Aycc72Es/D
         YIdlSJ84u7H4B9ktEDYrcLaRpbVeNh+hBXBvYYktA2m5UVO7oEL8Am5snyNglgJBp8Go
         Fsgg==
X-Forwarded-Encrypted: i=1; AFNElJ/DPm+lQydVe9H44pp6VkQLjaDkqWyz1hN8R1+AcRpYMcx6wQay4fB0le3XuEHHdKKCMMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhfd2iFLMyHdo+JjBDH0cqL7nUKgqLSMMuX2oyOrDNc/3YfCL
	B+EonZYNpw1JyTAkGil2C3wq7RxuQw4bqKbtVG9DdD9HiEXN/fqeUK9M3R0a6KT/IyT5sgcJRxJ
	LatVqKhquwDlsQ9WVXXIgjV6zcLMXb9Zr2QTC7GruF98N8P29QCEEGQ==
X-Gm-Gg: Acq92OGKp8ZZDDrYsNb62mWm1ihckYlgq48do0fD4FEdLldX/+cUX6O/PRy3XBAe7B7
	NcIr5lfrq4I0MeOcl4ObRmvh250ghwymCVxyEDA5LrZLWWJ2Rdf8GfVe53/01+R7xu1pns+VrE6
	Q5MIizVHri18MGSwYhYSk/4ypvy94lAzyO+OVpJXiHhKxaEbt9lO+P4uIQ6UwYMbiR7RHBuC5FQ
	iTLEpNDm7m38/yt2sB78aq5hVKDHzkgJZYc21J2aa9jIoDilZOD4zQpU8+Pq+0YDY9kRJZ8EW1a
	MrzMV2tWcloPr0BWls+gJSmfgupPhk+60wOtQHZ/DnseZCNejz6bVplgIjW7Yf9oaP5mTj1e1X9
	t+I8xMdmlEnKeVAQ09nM0Zij5Y4LgxWd05GVUfM2lWcuE55xEzcd7vW1Y0lptfoW4
X-Received: by 2002:a05:6a20:2446:b0:3b2:846d:f388 with SMTP id adf61e73a8af0-3b308856ee0mr683733637.45.1779325140355;
        Wed, 20 May 2026 17:59:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:2446:b0:3b2:846d:f388 with SMTP id adf61e73a8af0-3b308856ee0mr683702637.45.1779325139846;
        Wed, 20 May 2026 17:58:59 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121ccasm20453467a12.29.2026.05.20.17.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 17:58:59 -0700 (PDT)
Message-ID: <2ad282da-88fd-49ab-8145-964ff298ca83@redhat.com>
Date: Thu, 21 May 2026 10:58:48 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/44] arm64: RMI: Ensure that the RMM has GPT entries
 for memory
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-9-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-9-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 5/13/26 11:17 PM, Steven Price wrote:
> The RMM maintains the state of all the granules in the system to make
> sure that the host is abiding by the rules. This state can be maintained
> at different granularity, per page (TRACKING_FINE) or per region
> (TRACKING_COARSE). The region size depends on the underlying
> "RMI_GRANULE_SIZE". For a "coarse" region all pages in the region must
> be of the same state, this implies we need to have "fine" tracking for
> DRAM, so that we can delegated individual pages.
> 
> For now we only support a statically carved out memory for tracking
> granules for the "fine" regions. This can be extended in the future to
> allow modifying the tracking granularity and remove the need for a
> static allocation.
> 
> Similarly, the firmware may create L0 GPT entries describing the total
> address space. But if we change the "PAS" (Physical Address Space) of a
> granule then the firmware may need to create L1 tables to track the PAS
> at a finer granularity.
> 
> Note: support is currently missing for SROs which means that if the RMM
> needs memory donating this will fail (and render CCA unusable in Linux).
> This effectively means that the L1 GPT tables must be created before
> Linux starts.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v13:
>   * Moved out of KVM
> ---
>   arch/arm64/include/asm/rmi_cmds.h |   2 +
>   arch/arm64/kernel/rmi.c           | 103 ++++++++++++++++++++++++++++++
>   2 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
> index 9179934925c5..9078a2920a7c 100644
> --- a/arch/arm64/include/asm/rmi_cmds.h
> +++ b/arch/arm64/include/asm/rmi_cmds.h
> @@ -33,6 +33,8 @@ struct rmi_sro_state {
>   } while (RMI_RETURN_STATUS(res.a0) == RMI_BUSY ||			\
>   	 RMI_RETURN_STATUS(res.a0) == RMI_BLOCKED)
>   
> +bool rmi_is_available(void);
> +
>   unsigned long rmi_sro_execute(struct rmi_sro_state *sro, gfp_t gfp);
>   void rmi_sro_free(struct rmi_sro_state *sro);
>   
> diff --git a/arch/arm64/kernel/rmi.c b/arch/arm64/kernel/rmi.c
> index a14ead5dedda..52a415e99500 100644
> --- a/arch/arm64/kernel/rmi.c
> +++ b/arch/arm64/kernel/rmi.c
> @@ -7,6 +7,8 @@
>   
>   #include <asm/rmi_cmds.h>
>   
> +static bool arm64_rmi_is_available;
> +
>   unsigned long rmm_feat_reg0;
>   unsigned long rmm_feat_reg1;
>   
> @@ -88,6 +90,102 @@ static int rmi_configure(void)
>   	return 0;
>   }
>   
> +/*
> + * For now we set the tracking_region_size to 0 for RMI_RMM_CONFIG_SET().
> + * TODO: Support other tracking sizes (via Kconfig option).
> + */
> +#ifdef CONFIG_PAGE_SIZE_4KB
> +#define RMM_GRANULE_TRACKING_SIZE	SZ_1G
> +#elif defined(CONFIG_PAGE_SIZE_16KB)
> +#define RMM_GRANULE_TRACKING_SIZE	SZ_32M
> +#elif defined(CONFIG_PAGE_SIZE_64KB)
> +#define RMM_GRANULE_TRACKING_SIZE	SZ_512M
> +#endif
> +

RMM_GRANULE_TRACKING_SIZE is never used in this series.

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
> +		if (ret != RMI_SUCCESS ||
> +		    state != RMI_TRACKING_FINE ||
> +		    category != RMI_MEM_CATEGORY_CONVENTIONAL) {
> +			/* TODO: Set granule tracking in this case */
> +			pr_err("Granule tracking for region isn't fine/conventional: %llx",
> +			       start);
> +			return -ENODEV;
> +		}
> +		start = next;
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned long rmi_l0gpt_size(void)
> +{
> +	return 1UL << (30 + FIELD_GET(RMI_FEATURE_REGISTER_1_L0GPTSZ,
> +				      rmm_feat_reg1));
> +}
> +

rmi_l0gpt_size() is only used by rmi_create_gpts(), its logic can be
combined to that function.

> +static int rmi_create_gpts(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long l0gpt_sz = rmi_l0gpt_size();
> +
> +	start = ALIGN_DOWN(start, l0gpt_sz);
> +	end = ALIGN(end, l0gpt_sz);
> +
> +	while (start < end) {
> +		int ret = rmi_gpt_l1_create(start);
> +
> +		/*
> +		 * Make sure the L1 GPT tables are created for the region.
> +		 * RMI_ERROR_GPT indicates the L1 table already exists.
> +		 */
> +		if (ret && ret != RMI_ERROR_GPT) {
> +			/*
> +			 * FIXME: Handle SRO so that memory can be donated for
> +			 * the tables.
> +			 */
> +			pr_err("GPT Level1 table missing for %llx\n", start);
> +			return -ENOMEM;
> +		}
> +		start += l0gpt_sz;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rmi_init_metadata(void)
> +{
> +	phys_addr_t start, end;
> +	const struct memblock_region *r;
> +
> +	for_each_mem_region(r) {
> +		int ret;
> +
> +		start = memblock_region_memory_base_pfn(r) << PAGE_SHIFT;
> +		end = memblock_region_memory_end_pfn(r) << PAGE_SHIFT;
> +		ret = rmi_verify_memory_tracking(start, end);
> +		if (ret)
> +			return ret;
> +		ret = rmi_create_gpts(start, end);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +bool rmi_is_available(void)
> +{
> +	return arm64_rmi_is_available;
> +}
> +
>   static int __init arm64_init_rmi(void)
>   {
>   	/* Continue without realm support if we can't agree on a version */
> @@ -101,6 +199,11 @@ static int __init arm64_init_rmi(void)
>   
>   	if (rmi_configure())
>   		return 0;
> +	if (rmi_init_metadata())
> +		return 0;
> +
> +	arm64_rmi_is_available = true;
> +	pr_info("RMI configured");
>   
>   	return 0;
>   }

Thanks,
Gavin

