Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2F448B81
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764342; cv=none; b=Fo9VIV70KXzxg5D2F3BOUHnHMu/3/n8PQ9T4wn9IgODeOUuuR13Vx5T50uv8gchWXHyoJ8HMDipNRwmralstJvQ3mVOp1Pb/Y/g205Zl/0kzDKmqlWEvoSxjdrsjx1Q9YNzr+ndlw12SAhcxwgPDkyc7QudUuwj8cOzaxpD6faE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764342; c=relaxed/simple;
	bh=8zPDmfzhVMae7pJP08ggzhkhghbY5IVEYtqvZcyDpcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9DGQnYq2QXCJijptNKYM29C3qkJHNw5XztYovzlZiVC+2PfyaWNtjBAlUZW89kgr6jviRXtOeNFYi6nBwgCEDUJ5BA3f82eN+peoUmGea2ChIM3lj74Axipg8fynDDNrzp38wAEum7sQpmfhoIrSfIxLapKwC4BW5s9iNO4KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjpPwuta; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjpPwuta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789764338; x=1821300338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8zPDmfzhVMae7pJP08ggzhkhghbY5IVEYtqvZcyDpcQ=;
  b=jjpPwutaKFF3S4VUDpK1E3P6djQrXENimp/FVPgK2SiLBdG+u2sgbLWx
   9CrgwjFZAaMwI5LnrtHjQaBHPc9y96ldOUDSAhig92ufdtJrdvfxjP0HQ
   BXA2w5syTjMseFmazHwZVThFTkNHB82qztTOU61wsjKcTpWs7K9kQfNSC
   G6Vgop0qGJu+48/VNSiW33bOEiMnSek/IyE9FsMm02NQjlH8mXqGq0dAa
   kn4muww/MHA4BbBJW4C7+k4n4IzDuOii0WpvmiMDr+LTmy+XAM2AXcM4a
   M39mSaxk6ug+636nGFKyzAcKohqVb3Gcb83MqdxgJ7LThyJ+ko2wYzqN9
   Q==;
X-CSE-ConnectionGUID: uaYoMk07SxmaODhOGW2+aA==
X-CSE-MsgGUID: ZGRSphkjSM6QlPkegayp8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90161542"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90161542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:45:38 -0700
X-CSE-ConnectionGUID: 2aBjOBbwTRCV1d/WSWVxNw==
X-CSE-MsgGUID: DZj2cmmbRWmshYr/VnlCAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271239314"
Received: from calunden-mobl.amr.corp.intel.com (HELO [10.246.168.184]) ([10.246.168.184])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:45:37 -0700
Message-ID: <948e5124-7edb-4aad-858d-f66a961ca300@intel.com>
Date: Fri, 18 Sep 2026 15:45:36 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/12] perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK}
 constants
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-10-zide.chen@intel.com>
 <20260918195918.557421F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260918195918.557421F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/2026 2:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] perf/x86: conflation of UMASK shift and MSR metric field width
> --
> 
> commit ca73afb21aaf968ca13fd3d0ba413055c3dc1861
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
>     
> Replace the hard coded field width (8) and the equivalent 0xff mask
> used for PERF_METRICS MSR field access with named constants
> INTEL_TD_METRIC_FIELD_{BITS,MASK}.
> 
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index cc13164d948f2..cbc9a179f2e5c 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> 
> [ ... ]
> 
>> @@ -4742,7 +4743,8 @@ static int core_pmu_hw_config(struct perf_event *event)
>>  }
>>  
>>  #define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
>> -					 ((x86_pmu.num_topdown_events - 1) << 8))
>> +					 ((x86_pmu.num_topdown_events - 1) << \
>> +					  INTEL_TD_METRIC_FIELD_BITS))
> 
> [Severity: Low]
> Is it safe to replace the UMASK shift here with the hardware MSR metric
> field width?

It's safe since x86_pmu.num_topdown_events is guaranteed to be <= 8, and
it's called when is_metric_event(event) is true.
> The original << 8 was used to shift the metric ID into the UMASK field
> (bits 8-15) of the software perf event configuration (attr.config).
> INTEL_TD_METRIC_FIELD_BITS represents the hardware width of metrics within
> the PERF_METRICS MSR.
> 
> When evaluated in is_available_metric_event() during perf_event_open(), this
> currently functions because both values are 8. However, conflating a software
> API layout offset with a hardware register field width could cause this macro
> to calculate an invalid configuration mask if the MSR field width changes in
> future hardware.
> 

