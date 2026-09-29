Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FF3A2559
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702809; cv=none; b=pWH0BHZT3H07i9t+7hAZ/XSKxF1sNE6KpmVMm2xNWFncRJblWfy+zqudWxlOVLwWCPg5Nnja6PXBIF/aT1GynupGp669M3wTDNAE3AP8YpqrWscYtGGQJ6ycE8HW87I3XeO52H8WwezFXLcf5ApJkqwMTamIynzcI/sdGMNV0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702809; c=relaxed/simple;
	bh=u9XPzUqW79rJKn6aQ5AIYZwHVFkebmqpU+ELj+QTgU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/B7w1RHfrraorQYScSt47Nlbp7amWrGp8bpiB1BJaNCdO6M6hTn5d1NItIQMShaE6/KgCpCodJ4CebiP8alttKF1a5X/1Y1r+ntmoA6MKJ1Tvod9S6KainpiHWvRz4qjWqfUNcvxuA0TQBVztocX/KM9TA7vXEj4uCLrcNq2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xi3+zwKO; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xi3+zwKO"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso33389585e9.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790702805; x=1791307605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i0fkT9jvbr/kwSvFoz/Z+e93i45No9+Z9jUlZdZhhO8=;
        b=Xi3+zwKOoatI/v7TsD1rOIG0uwvMNKz4BYRSgWYzv6OUosug9tGlIpXCEKp6y8GZCS
         eBMlC651ryozPrSV/QV4d+MGYwGW1HsggeCPlkpk9JQkX0pfH3cqWBNKbXT8+cxPZU3Q
         KMSESbfVmx53kVhvP4iaWxgNzlx6dR5D4X8RRgtAi/mDvgcNkh3HUg54susQNeNku3RI
         kDK01RUH1JVLpg1q44pLIqqz+zMklsr8+fhBqh9PW8Y/+idKuophuXgm4wjHjCYAuYOo
         dcJQFd+T1yseB0TXwi7pn9NaQbkR7hOBrWWP6DJLwE374giugEHtFQDzda7UZ7WxdoSh
         KmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702805; x=1791307605;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i0fkT9jvbr/kwSvFoz/Z+e93i45No9+Z9jUlZdZhhO8=;
        b=Xrx2jqmV/vQn0thVRvG8gJV55bOCxAXPoUp4Zg6Mw0iyVWuPzp2Qnz18nhzrlRGPkb
         1W4lvX1kEKX+RS9ZmQIiOvpoO0JaQVdnBBJC9vt/BZoTjDDMtPesgZUd00RgNXNq2L62
         oYP//GtnUZDx6Bts6MPPK6Nx2U7hW6RQjCdoWnPUPKNjjzoSXhccLPB/ILTKDrI5pIIn
         u+tx7IWBL8fnLGRYdrQq8ANvBVF9YVpJKkmUI0nUuZKWwRi1TXRVCroYzNnAWlhj/Ej6
         47Q9Gt8OICYyLAGo663zXP0vSg0MBqF4cV3V6kTMwlR5kah4nxTu3wf3rXtHqj9boQ6e
         B7GA==
X-Forwarded-Encrypted: i=1; AKwUvBwgERjMFLTYMjzMZhHNwcClkD1T669VP62NTLqYj2vpAn+TI50lqPA2+zjnXtOMp6PRulQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mQY5/X9vWnRDMLT7IPZzFTlAaJZu8Fni4jt6Jm/NwCmSNQRxpV
	xfCmPTrZ1NST1vnSSSJJlKM86IwGAQuuOGQUqjyknUgPiJ9hkgt5k1V8jU9/vV3uWQQ=
X-Gm-Gg: AYBFou06EcThffRaEzkbtJFm9Saas9uecNt3IXgInuq9TNga5kHQj0JLS8XbtZgCHA1
	eosp1q1eHnYPLMMv/BBpfHOnNHEJhPFAa4YbX4s88akXXn0IjqE1VDn2jOcmzpyfLknUGmoYuHE
	C1pKSBpCbREtxCUkT3WhrqcOVRMWKwjOUzQs1PGF6b4lNZdm5AtRIdSw/HyXeJKtfrc7rVkY0kI
	0g2hse2l+17C8OwR/7KZuIBGkreE4K61JSJhLqwJ5njbjnzrRrYlylBtL2pQ3JrwZ722ENoMOl7
	YMLoypWHibuco2uq2ZQTwaAShDyyYDF5LwD4XxVuJiTudQ1OK6dwHJT4kR/9Ce0+Wl4pZQc4YQg
	gVViwks7lxO4FlKP3twhzzrEu6W+WdFNRzC4U9p0UFijrHAh5tMwJFjUeTXWhc6xfeGN31XAVkj
	GAPcN8JrDgtrmROdfYgpRQQSU2X4xwJEqq/dfbDOSm3Imr2ExCsKBqNM7CBiVAL64WKpoA6a/wz
	vYR0rLzULadSXOn9+CMlnE=
X-Received: by 2002:a05:600c:1c2a:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a00c2a48cdmr77569005e9.33.1790702805403;
        Tue, 29 Sep 2026 10:26:45 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01491d4dbsm1981735e9.3.2026.09.29.10.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:26:45 -0700 (PDT)
Message-ID: <b88401eb-ebd8-41dd-8260-af3890886ca3@suse.com>
Date: Tue, 29 Sep 2026 20:26:43 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com,
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com,
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-4-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260915102658.713079-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.09.26 г. 13:26 ч., Xu Yilun wrote:
> Some add-on features require TDX module extensions. The TDX module
> provides a metadata field "ext_required" to indicate this requirement.
> 
> Add the first step of TDX module extensions initialization by detecting
> if the extensions are required:
> 
>    1. Check if the extensions are supported via TDX_FEATURES0_EXT. If
>       not, ext_required is not readable.
>    2. Check if any TDX feature needs the extensions via ext_required.
> 
> Skip the extensions initialization when it is not required.
> 
> Currently all metadata fields are read at the very beginning of TDX
> module initialization. However, ext_required is only valid after the
> add-on feature configuration, so it cannot use the existing metadata
> reading method.
> 
> Add a dedicated metadata reading interface for the extensions, call it
> after add-on feature configuration.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> ---
> v1:
>   - Include struct tdx_sys_info_ext in struct tdx_sys_info.
> ---
>   arch/x86/include/asm/tdx.h                  |  1 +
>   arch/x86/include/asm/tdx_global_metadata.h  |  5 ++++
>   arch/x86/virt/vmx/tdx/tdx.c                 | 28 +++++++++++++++++++++
>   arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 14 +++++++++++
>   4 files changed, 48 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 89e97d5761d8..6657f2db0330 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -36,6 +36,7 @@
>   /* Bit definitions of TDX_FEATURES0 metadata field */
>   #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
>   #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
> +#define TDX_FEATURES0_EXT		BIT_ULL(39)
>   
>   #ifndef __ASSEMBLER__
>   
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index 41150d546589..fe3fe91de71f 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -44,12 +44,17 @@ struct tdx_sys_info_handoff {
>   	u16 module_hv;
>   };
>   
> +struct tdx_sys_info_ext {
> +	bool ext_required;
> +};
> +
>   struct tdx_sys_info {
>   	struct tdx_sys_info_version version;
>   	struct tdx_sys_info_features features;
>   	struct tdx_sys_info_tdmr tdmr;
>   	struct tdx_sys_info_td_ctrl td_ctrl;
>   	struct tdx_sys_info_td_conf td_conf;
> +	struct tdx_sys_info_ext ext;
>   };
>   
>   #endif
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 763c2d1b25d0..916a8906da10 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1181,6 +1181,30 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> +static __init int init_tdx_module_extensions(void)
> +{
> +	int ret;
> +
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> +		return 0;
> +
> +	ret = get_tdx_sys_info_ext(&tdx_sysinfo.ext);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * ext_required indicates if any add-on features requiring TDX module
> +	 * extensions are configured via TDH.SYS.CONFIG. If none, skip the
> +	 * initialization.
> +	 */
> +	if (!tdx_sysinfo.ext.ext_required)
> +		return 0;

I'm slightly confused by the parlance introduced here. TDX_FEATURES0_EXT 
indicates whether this tdx module supports extensions. And ext_required 
aka 0x3100000000000001 is, as per td_scope_metadata.json: "Extended 
Features Available Mask:  indicates the extended user and system 
features which are available for  the TD." So aren't by definition all 
add-on features extensions. How do you distinguish add-on which are 
extensions and those which aren't? I think it's best if ext_required is 
referred to as "ext_mask" or some such and not ext_required. That value 
is not about what is required but rather what is available, no ?

<snip>

