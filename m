Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FD26A0A7
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348881; cv=none; b=apTcLjIZWcenLs3UrJyho4jCHpxwucWmnGfX6zqYY+pFhdShOG3reuhnfn9wEi0vZMR4LUohrz8jpu6lLNfOAb8OS9zfkB3RUcHxKLDLTVOGQ5XgeseN9fOK/4g/iPkLyqyVvVQ+D4Hc3w1ypNc3KDE6QhhMdUmKb/ftCLcMiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348881; c=relaxed/simple;
	bh=Jo52MSARa8uRGstHX+nkOGEuELufQdjvMtbOTrNMYwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiRvBBLRUlb/ZzZzuNhSWRe5XfRxn3HLw5ntBIGKeSBO9txAvfhA2cUGMroMVS3e4WhtynmDZuoGfZtLCAnmHRwYvQcm66hgue+yNKaDLnBxVZGH9p0iei/KnkF1GAwhOFyLpJ0FSyqvq7hNscirsZRlnw/hoD2yGGkxvsQOu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpKoTWrJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=chpAJdix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpKoTWrJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="chpAJdix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789348878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB6oGUDhB7NpBPwBSAbY4P+UYTTTI5VBvn+Ldw600iI=;
	b=BpKoTWrJGKSqPnkuKj64SpPdjmHi6vb0fq7ug8gjilpsQHHRRyK2DtBY6909RFVz8hD9ti
	2y/1OzQVl8Qbwc4VXxl7Wmj7izsqH0nbeFQdlYhIK6BgN0vg7V4OGTbxm6I0Ji8JcE4DZX
	zC3L3j36WDVYbmGt5ap455EE2xSCtUo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-TMh9o9dbNNiuQDVOB-Rg5w-1; Sun, 13 Sep 2026 21:21:15 -0400
X-MC-Unique: TMh9o9dbNNiuQDVOB-Rg5w-1
X-Mimecast-MFC-AGG-ID: TMh9o9dbNNiuQDVOB-Rg5w_1789348874
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso4048239a91.0
        for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 18:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789348874; x=1789953674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hB6oGUDhB7NpBPwBSAbY4P+UYTTTI5VBvn+Ldw600iI=;
        b=chpAJdixC4uVrly4nQeYE71H/DbgTHFb/DoLoaynQURaKJMn/7+/ZT9URUcCBNjzsC
         FVz+G7FSNs6PiaA/fjWPBcGfGjyoui/Z7j3wxv9AQ/gjkcyXWiegx8vp/+Iaad3DLAu/
         DxI0b1E8+R7M8HSTZykozNKcNMNjCYIMKVfiK/DCxJNahe8zr7qmKBp/ut85C1rDlQ+l
         Fu0CIDzaaodNzPz7nhj+qkPqjg7SVDEs9xXqznxmWypnEacCtXCOo4RmQj7JQfY3+c7e
         DxDFUVu82U8Tp9fY7xUEiH94fB3hH3Zi+AlF6LGTCSzBmjmR8hjwi5+dmNnCG/b745UA
         yFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348874; x=1789953674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hB6oGUDhB7NpBPwBSAbY4P+UYTTTI5VBvn+Ldw600iI=;
        b=SHTptdbsvOehAEUFKXumVPcRI0I7fzefzu9M7eN23jIdXXCZIywVQcHtJgGS+hssTf
         ZgI5GQAAHIpavc8jfzmpTCDE1P12VuEUV0z3p8wJZM1XR4UKOrsd1bOqZ3bEtYoBjJKF
         6dZBaSRmEQtCrkh6FIzEJMfCFPJKKU4L31AuctewCvtDCM01ceVFf5A7pPWVdQvF0Jz3
         ZUOaIebJRdeVcwRcv4V4/WSWw9x1TvYOg7sHRYH6lEdEw2rMEF7vTQQkyEjxpIJOWJa5
         uyIRFkPXLGZ99V62WlvK94aU0RSUuyzjfGQI5273qSFD15YlwEPPKmb1TQ4LhSlR9oGJ
         EaTw==
X-Forwarded-Encrypted: i=1; AKwUvBxAmY3fxAW1Ecv7UuMJB8sTwgLxn9MfoRASYhGJF9CCC/cK/u2/jayrSJaJ8s15BGeDi1A=@vger.kernel.org
X-Gm-Message-State: AFuF++mCTA11js2zHDacflkruOKtPIqPCjcb8Gtgdy+SOt6Sl8/R2f5v
	cXVbfEM2Gs6i+yXsPemO9AMgKPpgYw8/GKruBZJytSOUPSgteTbprL7Rxwsdv0wFYZQWuvKvn80
	IUZDdDJa4wU5NIOsqqDs1nERgyTg39/kuu+uPaT+II5g0O5CB952KCA==
X-Gm-Gg: AYBFou2iPXDAS6+6Dsx86oRsL7lt93YyhsNewSt3UN5XP8bGLBUmlmvs5rAxQR4Pg9V
	I3K81WQcv3rYEVXCxvmzWiGghYX+gdp+P0tgBnkBm1ZIM9jrF8QUHU0YVGM+NUCAF0iV658JlKB
	R/HDUeYRNLq9Cq21odNmpmYAynE5ElpPLQXIXRYj69G2qTP++1cj8MM9kD6TEuk/jEyU916pRhR
	pjGSfa45W9c617WkCNh+MtSpNz0GjB15jgw+P3RJ4lkblXPHK2nvGBjw++BCS66eKfP1jjPKKwi
	p0AxUbEQpQp+OzxPWnq6OWChyPgokDZgo8lYFr2uTFED2k25IHLRPY7hOA/P+eB/Y3RGvFvGm9/
	cWx+E+xfoDbz1i4um1jj6c/Z8oLOTX4NXTwHaz3O5NQ==
X-Received: by 2002:a17:90a:1041:b0:39d:edfc:26a0 with SMTP id 98e67ed59e1d1-39dedfc3adamr55109a91.1.1789348873769;
        Sun, 13 Sep 2026 18:21:13 -0700 (PDT)
X-Received: by 2002:a17:90a:1041:b0:39d:edfc:26a0 with SMTP id 98e67ed59e1d1-39dedfc3adamr55067a91.1.1789348873263;
        Sun, 13 Sep 2026 18:21:13 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39db090dfa5sm4045013a91.4.2026.09.13.18.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 18:21:12 -0700 (PDT)
Message-ID: <6d204c05-1338-4ee5-9ac9-5d9447e329ee@redhat.com>
Date: Mon, 14 Sep 2026 11:21:01 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/7] firmware: arm_rmm: Configure the RMM with the
 host's page size
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
 <20260912083611.2513845-4-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260912083611.2513845-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 6:36 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> RMM v2.0 brings the ability to set the RMM's granule size. Check the
> feature registers and configure the RMM so that it matches the host's
> page size. This means that operations can be done with a granularity
> equal to PAGE_SIZE.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   Changes since v17:
>    * Move rmi_config_set() out of the header file.
>    * Print the error message for rmi_config_set if it fails
>   Changes since v15:
>    * Actually check the feature register for the host's page-size support.
>   Changes since v14:
>    * Move the implementation into drivers/firmware/arm_rmm.
>   Changes since v13:
>    * Moved out of KVM.
> ---
>   drivers/firmware/arm_rmm/rmi.c | 79 ++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
> index 2fd538c937dca..5b0e342ce3d58 100644
> --- a/drivers/firmware/arm_rmm/rmi.c
> +++ b/drivers/firmware/arm_rmm/rmi.c
> @@ -35,6 +35,25 @@ static int rmi_features(unsigned long index, unsigned long *out)
>   	return args.a0;
>   }
>   
> +/**
> + * rmi_rmm_config_set() - Configure the RMM
> + * @cfg_ptr: PA of a struct rmm_config
> + *
> + * Sets configuration options on the RMM.
> + *
> + * Return: RMI return code
> + */
> +static int rmi_rmm_config_set(unsigned long cfg_ptr)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RMM_CONFIG_SET, cfg_ptr,
> +	};
> +
> +	rmi_smccc_invoke(&regs);
> +
> +	return regs.a0;
> +}
> +

The comments for rmi_rmm_config_set() can be dropped since its logic is simply enough and
the code is self-explainning. Besides, I would move this right before its only caller
rmi_configure().

I would suggest drop this function by combining its logics into the only caller
rmi_configure(), seeing below for more details.

>   unsigned long rmi_feat_reg(unsigned long index)
>   {
>   	if (WARN_ON(index >= RMI_FEAT_REG_COUNT))
> @@ -98,6 +117,62 @@ static int rmi_read_features(void)
>   	return 0;
>   }
>   
> +static int rmi_configure(void)
> +{
> +	unsigned long granule_feature;
> +	unsigned long granule_size;
> +	int ret = 0;
> +	struct rmm_config *config;
> +
> +	switch (PAGE_SIZE) {
> +	case SZ_4K:
> +		granule_size = RMI_GRANULE_SIZE_4KB;
> +		granule_feature = RMI_FEATURE_REGISTER_1_RMI_GRAN_SZ_4KB;
> +		break;
> +	case SZ_16K:
> +		granule_size = RMI_GRANULE_SIZE_16KB;
> +		granule_feature = RMI_FEATURE_REGISTER_1_RMI_GRAN_SZ_16KB;
> +		break;
> +	case SZ_64K:
> +		granule_size = RMI_GRANULE_SIZE_64KB;
> +		granule_feature = RMI_FEATURE_REGISTER_1_RMI_GRAN_SZ_64KB;
> +		break;
> +	default:
> +		BUILD_BUG();
> +	}
> +
> +	if (!(rmi_feat_reg(1) & granule_feature)) {
> +		pr_err("RMM does not support %luKB granules\n",
> +		       PAGE_SIZE >> 10);
> +		return -ENXIO;
> +	}
> +
> +	config = (struct rmm_config *)get_zeroed_page(GFP_KERNEL);
> +	if (!config) {
> +		pr_err("Unable to allocate memory for RMM config\n");
> +		return -ENOMEM;
> +	}
> +
> +	config->rmi_granule_size = granule_size;
> +
> +	/*
> +	 * For now we set the tracking_region_size to 0 which is the only option
> +	 * for 4KB PAGE_SIZE (1GB for 4KB PAGE_SIZE, 32MB/512MB for 16KB/64KB).
> +	 * TODO: Support other tracking sizes via Kconfig option for other
> +	 * PAGE_SIZES
> +	 */
> +	config->tracking_region_size = 0;
> +
> +	ret = rmi_rmm_config_set(virt_to_phys(config));
> +	if (ret) {
> +		pr_err("RMM config set failed (%d)\n", ret);
> +		ret = -EINVAL;
> +	}
> +

I would suggest to drop rmi_rmm_config_set() by combining its logic to rmi_configure().

	struct arm_smccc_1_2_regs args = { SMC_RMI_RMM_CONFIG_SET };

	args.a1 = virt_to_phys(config);
	rmi_smccc_invoke(&args);
	if (args.a0 != RMI_SUCCESS) {
		pr_err("RMM config set failed (%ld)\n", args.a0);
		ret = -EINVAL;
	}
	

> +	free_page((unsigned long)config);
> +	return ret;
> +}
> +
>   static int __init arm64_init_rmi(void)
>   {
>   	int ret;
> @@ -111,6 +186,10 @@ static int __init arm64_init_rmi(void)
>   	if (ret)
>   		return ret;
>   
> +	ret = rmi_configure();
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>   

Thanks,
Gavin

