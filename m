Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAC3A4F54
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880606; cv=none; b=QVvmzyvbw4lPIC7kvC6MgC5MnJjzN3SCVDpmu2oD/DjOYpVWN+FRHU6Cvl3C1PDNIDdh1hFEcZdnJZOPHr+MvD9EVBT5RbwewQtOfh3i74I465yaxfKgKvoNZxdzObgVjDlZYsJzFlNd6oIiuPsu4Pn1rGJul3i4DePXkFq8FNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880606; c=relaxed/simple;
	bh=2t8eCwKvWcyTG6BLF1k6kvidUmENGblJrAN4O0/8Zp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGzz3qUfsl0vrVrDewIzH4CNb78xpN4e/fHQY/LY3uP7TYYo2RKiSGNeVg4Y6DukTPVPR0tqdmRQ/1q7CeE/NxSJ69oDeU+ojl3qEvnJDi361uFid+No4kzIbq0aiwwFxmNTKLQ1xe4UoEZLl7ptgC2KKT1AX/gjpeLRb+5W+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/kPA1Yw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/kPA1Yw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so3181449f8f.1
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774880604; x=1775485404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM+5dyHe83nqy+4nGn8DT9A5VxOBbDn6eu5qTwyUTxM=;
        b=O/kPA1YwSoqOj4SEgSDjUAHLimLwIOg2iuwrU5mcRofiUQU2AnDATMVdUMbpIkdwae
         RAmhs2zmT5MpWaCP5jx0jGCGDR0B8nU+fA1JNqrncWboW+pjIPThgyNHOv4eHUzRHJ3y
         RpxODaTWyOaNoYMyi7PFf3tcsRf+Qotb8o2kihnc+MCbe1X4KRlZBuwSI2PbyeluuReF
         Jp4GXxdTiz9wJzjFptrNEWwTys1vYSF4awEIDt33+HKvdmcq/TZ8xZbzLQEgJH+FpiBt
         JehbX14foBbn+5+3puqWM7Z01R72lJXTO5gs7U1sJOQpufUtYBAO7wiTRqbgt8mh6z5h
         aQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880604; x=1775485404;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM+5dyHe83nqy+4nGn8DT9A5VxOBbDn6eu5qTwyUTxM=;
        b=ivGGpD68kzWjOkyhqxiRpd8+Tzkw480oh9pFRoNPqLgkYbCbVIYgyLWwnXLzO6HuhV
         S1eXOM0OF4KtOgGPRhgzaO5b/pIepf8DHnlsmm3/fBABs2qZMrCSU2y87hGis2ww+kAU
         Xic08Yll/78SoNBPdJoGdauQG54IiG55qQKdVs3lNr/TxNFR2OAhxGhqk1CV1p8nBV0m
         933m87iVqNr/jC36M1W7qEBX5y96l6NpRTvk4tSFhX9eOUZg2tFiIlx9OZf38tYpH6BQ
         fVsBgUS3MQJS0BC3X1ThTXzel577iotIn8kxXbGwSAAeY+d55BSJK7p2VS6ISqMtvIA6
         lDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyHNCFzfJWjcr7gLuXOtS/kTEUhfIotsniJXkS2057EhKEn+4kvplDjLP0zyTY5AKgML8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJicmiyaaEkxgbHbyEbtXJpt0FkD/wSZZjnt7PCt8QWkgRSQ+3
	zmBxyHykVL4LZZXZZs4HcUsOBr2i7qyZiGIDNsfHRLJITLScTr0yn/C6ySOqPP5D6V0nI6lvkBI
	CbWisIEA=
X-Gm-Gg: ATEYQzwa/Wwj5ukWVVlLNyrRZSfp1/RlAzMUNS6a+54E5z1GJnV3QxHxzaE2cz401eP
	BmqbMGE/aBIdvn5DOPDG0byPagazyMR5P2uNcZT5JyivznWhUsIKgf56whIRGTDCL/TVIrrasCo
	QvWrDu31NSrSlzHLCC3ydGCVJdQM9VLWRq9jkwrnw4zt7mxlL5gG5QP+ISUVsXdsHQZeCHMCPfI
	5cYCOobJfPYheDwYqVZOWEm3ILpEpkTZ0pX5JP80hWxze49D6MHBZplsl3lym6sIFnOsb8irnez
	jzTNkDkkDS10Sp/q3w8tAExJS6JcJHWKVRLDP73XH02k8y/NlbsycZGi9T5fSVl3wSP/dXbO2Ql
	socy0sSS3vjGE0G6kQLB/bq3gHrgwEmewKF7E5euhLWFQqA4nBgaxMsvL6oAYEXfZRr3kkMky8e
	FBRO1mZiyiyhUS2w02iMqCNzSuYA==
X-Received: by 2002:a5d:5f85:0:b0:43b:4ec7:f90b with SMTP id ffacd0b85a97d-43b9ea9b2cbmr21194998f8f.27.1774880603519;
        Mon, 30 Mar 2026 07:23:23 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf90424fcsm14278058f8f.32.2026.03.30.07.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:23:22 -0700 (PDT)
Message-ID: <a68bb3d5-0f93-428f-ac8c-f3400d1fc028@suse.com>
Date: Mon, 30 Mar 2026 17:23:21 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX
 Module Extensions/Connect
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-7-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260327160132.2946114-7-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
> Add reading of the global metadata for TDX Module Extensions & TDX
> Connect. Add them in a batch as TDX Connect is currently the only user
> of TDX Module Extensions and no way to initialize TDX Module Extensions
> without firstly enabling TDX Connect.
> 
> TDX Module Extensions & TDX Connect are optional features enumerated by
> TDX_FEATURES0. Check the TDX_FEATURES0 before reading these metadata to
> avoid failing the whole TDX initialization.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/include/asm/tdx.h                  |  2 ++
>   arch/x86/include/asm/tdx_global_metadata.h  | 14 ++++++++
>   arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 36 +++++++++++++++++++++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index d5f1d7b7d1e7..d7605235aa9b 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -129,7 +129,9 @@ int tdx_enable(void);
>   const char *tdx_dump_mce_info(struct mce *m);
>   
>   /* Bit definitions of TDX_FEATURES0 metadata field */
> +#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
>   #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
> +#define TDX_FEATURES0_EXT		BIT_ULL(39)
>   
>   const struct tdx_sys_info *tdx_get_sysinfo(void);
>   
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index 060a2ad744bf..e7948bca671a 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -34,11 +34,25 @@ struct tdx_sys_info_td_conf {
>   	u64 cpuid_config_values[128][2];
>   };
>   
> +struct tdx_sys_info_ext {
> +	u16 memory_pool_required_pages;
> +	u8 ext_required;
> +};
> +
> +struct tdx_sys_info_connect {
> +	u16 ide_mt_page_count;
> +	u16 spdm_mt_page_count;
> +	u16 iommu_mt_page_count;
> +	u16 spdm_max_dev_info_pages;
> +};
> +
>   struct tdx_sys_info {
>   	struct tdx_sys_info_features features;
>   	struct tdx_sys_info_tdmr tdmr;
>   	struct tdx_sys_info_td_ctrl td_ctrl;
>   	struct tdx_sys_info_td_conf td_conf;
> +	struct tdx_sys_info_ext ext;
> +	struct tdx_sys_info_connect connect;
>   };
>   
>   #endif
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index 13ad2663488b..a07f1e7b18e8 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -85,6 +85,36 @@ static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf
>   	return ret;
>   }
>   
> +static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> +{
> +	int ret = 0;
> +	u64 val;
> +
> +	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))

nit: This is likely generated by a script/llm because I see no other 
explanation why !ret is being checked here...

> +		sysinfo_ext->memory_pool_required_pages = val;
> +	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000001, &val)))
> +		sysinfo_ext->ext_required = val;
> +
> +	return ret;
> +}
> +
> +static int get_tdx_sys_info_connect(struct tdx_sys_info_connect *sysinfo_connect)
> +{
> +	int ret = 0;
> +	u64 val;
> +
> +	if (!ret && !(ret = read_sys_metadata_field(0x3000000100000001, &val)))

Ditto
<snip>
