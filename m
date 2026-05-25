Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D913A9870;
	Mon, 25 May 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692090; cv=none; b=ctodummPcmp9nnmU/TUAqDqvgfA4XlQk/MVAMjkUE0rAbHNqYxspV3etBxdGz5g7Q4eKxAbx/SnkaCo/s3B/mEHI4SgyYObL4dB5PBwsBbMc5RAYwrFXkILVbLAlwhvbmOXROSUEg5Gc37GsU4voOG0ExKQJRb4XR6iYvnLk9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692090; c=relaxed/simple;
	bh=i+7aB0Q+qh4LNvIzLEWXH32b3cs77zEEctvB4hd0EeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e66C9UuOVLboZLaIo2rWAHkED8Ld6TRAIvHLAZIM4zhiqU7v9G3dnzI55Bxm8kF7yFHxjXdXIykT0Fx7CiXdD4Fx388JXL9tLMFZskDYYPJ2G+VabAw77IyxHlccEHf1J2ATkomRAfl1oa5hG8ja2PiRddF3/u1nLrvadrvArZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5QqXfnh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5QqXfnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779692086; x=1811228086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i+7aB0Q+qh4LNvIzLEWXH32b3cs77zEEctvB4hd0EeU=;
  b=G5QqXfnhKs8d3mUu2dGz97+zlP+xLaV4yrSotb6+cj0SyjgCoKSs1Pyo
   SaVHgWe2mTkVIZXFVmtAwe7A2ci/eU32iusgvoJ4SeqXbC9W9fEN/MPN+
   EWYnkjF19VXcpPK5YxFgao7/Eces6/ZonroM1cb9Ja8+e1X/u21o/UJDB
   LveH7mEDu5iSnLSrdjp/mQrnAi83cJCvcnJ7ye6Ql15F5EDcfuomrF9Io
   LwWdAc+FiYxwezgI6EBSs3qmdCusG8bkX/BpCpCgw5LchIheKoDg8NFji
   XqMXmey6Ntctajq41NAM7wrEr9Xb/Tq60gkSMxqh0Hn5rdlv8tC6ltTla
   Q==;
X-CSE-ConnectionGUID: EVn2KP7ETZmYWrt43sSulg==
X-CSE-MsgGUID: Zt41L3baSeqBfGiKBlktew==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="79542193"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="79542193"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:54:46 -0700
X-CSE-ConnectionGUID: iGYtfYoaRd+IcN/Zs7sV5w==
X-CSE-MsgGUID: 62E3L+AxRLKu2b6rgakv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="238486040"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:54:43 -0700
Message-ID: <956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com>
Date: Mon, 25 May 2026 14:54:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 11:41 AM, Xu Yilun wrote:
...
> +static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> +{
> +	int ret = 0;
> +	u64 val;
> +
> +	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
> +		sysinfo_ext->memory_pool_required_pages = val;
> +	if (!ret && !(ret = read_sys_metadata_field(0x3100000000000001, &val)))
> +		sysinfo_ext->ext_required = val;
> +
> +	return ret;
> +}
> +
>   static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>   {
>   	int ret = 0;
> @@ -116,5 +129,8 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>   	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
>   	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
>   
> +	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
> +		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);

Is it correct to read "memory_pool_required_pages" and "ext_required" so 
early in get_tdx_sys_info()? get_tdx_sys_info() is called before 
config_tdx_module() which calls TDH.SYS.CONFIG.

If I read the TDX module base spec correctly, the amount of memory for 
extensions and EXT_REQUIRED field depends on the enabled features, which 
is determined by TDH.SYS.CONFIG/TDH.SYS.UPDATE ?

>   	return ret;
>   }

