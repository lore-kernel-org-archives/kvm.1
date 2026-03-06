Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A112D8364
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766154; cv=none; b=mSI6JsWYIHiiJWFs1UMCVjdFzUeEfU2R9UlnJNn5JWWMzxDXmrW5iLiJY9d5cyxsciQoBcfb2mxrTwanU7saXdFotpc2FrwocA5FQwpEMXLNOuWXspH+L18NGpbSQRgVxToWZoiJCVUc6fIiGuyJwLhFRWTXkykH/127z47y+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766154; c=relaxed/simple;
	bh=DhvNDxxeIWLb9YuNZGM3wTYZ+ckehia3cilXA5xumY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5X+WaHnSy4CXdlCPjmDl/nbSmZTrY8z9d0G9/13ihktTgIsZ8EfHNnjHMHrBjp06maguwCwJqrFvXhwiU45Xqed2cPjjULBB2si8yEmX77FOJedi/xeGTqpxlvhPQsT7Ikgh/yxCCaBHu5fDkz/sk0JJLHINfqcfKhTvDADrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwWi/VyG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwWi/VyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772766153; x=1804302153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DhvNDxxeIWLb9YuNZGM3wTYZ+ckehia3cilXA5xumY0=;
  b=FwWi/VyG+mIQKxgnljrFHq1l+q2k15TC/TZvtbVeoKzuyWQ9qz+j8PnZ
   ryZXRMSSVdNAWni2fIwrrzcpJJ4zamD89XIu4n9XrEiqaZj2/7R6x1U79
   8dyfItPE+09XEvnq4BbHx0eapyeo1rTZPgc3TS408OHoyH9X4fsZNHJlY
   diBc9EJk97KdG6y6Fq3s36vKSdL/FRyFt+3HCEv9vPcMGNpVjBMIaG4cx
   3MzTYOiRvwBN+WzZVD+dV1U8rVN019nIYzef2Ng0rcbCbBZhJVHFTEWLn
   /UZFbxJDDvhPLCdTk2y4Q/ttpQy1ycx8S9r9m5MBKgu7LZWK6bfMX76a8
   Q==;
X-CSE-ConnectionGUID: HyaBg9dXSgSI9+OPkfUK+A==
X-CSE-MsgGUID: FOwHDxBrRi6PQoTB+YlX4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84954572"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="84954572"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 19:02:33 -0800
X-CSE-ConnectionGUID: hV1FhsldRRyy4/47AI7qSA==
X-CSE-MsgGUID: 753ji1UKSjqS6iqFsXsGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="219015950"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 19:02:29 -0800
Message-ID: <0fe9efc7-c3b3-4e11-b99e-17c80fe72892@linux.intel.com>
Date: Fri, 6 Mar 2026 11:02:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/13] target/i386: Adjust maximum number of PMU
 counters
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/2026 2:07 AM, Zide Chen wrote:
> Changing either MAX_GP_COUNTERS or MAX_FIXED_COUNTERS affects the
> VMState layout and therefore requires bumping the migration version
> IDs.  Adjust both limits together to avoid repeated VMState version
> bumps in follow-up patches.
>
> To support full-width writes, QEMU needs to handle the alias MSRs
> starting at 0x4c1.  With the current limits, the alias range can
> extend into MSR_MCG_EXT_CTL (0x4d0).  Reducing MAX_GP_COUNTERS from 18
> to 15 avoids the overlap while still leaving room for future expansion
> beyond current hardware (which supports at most 10 GP counters).
>
> Increase MAX_FIXED_COUNTERS to 7 to support additional fixed counters
> (e.g. Topdown metric events).
>
> With these changes, bump version_id to prevent migration to older
> QEMU, and bump minimum_version_id to prevent migration from older
> QEMU, which could otherwise result in VMState overflows.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  target/i386/cpu.h     | 8 ++------
>  target/i386/machine.c | 4 ++--
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6d3e70395dbd..23d4ee13abfa 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1749,12 +1749,8 @@ typedef struct {
>  #define CPU_NB_REGS CPU_NB_REGS32
>  #endif
>  
> -#define MAX_FIXED_COUNTERS 3
> -/*
> - * This formula is based on Intel's MSR. The current size also meets AMD's
> - * needs.
> - */
> -#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
> +#define MAX_FIXED_COUNTERS 7
> +#define MAX_GP_COUNTERS    15

I suppose it's good enough to reduce MAX_GP_COUNTERS to 10. I don't think
there would be 10+ GP counters for Intel platforms in near future. But need
AMD guys to confirm if it's enough for AMD platforms.

Of course, shrinking MAX_GP_COUNTERS to 15 is fine for me as well.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  
>  #define NB_OPMASK_REGS 8
>  
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 1125c8a64ec5..7d08a05835fc 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -685,8 +685,8 @@ static bool pmu_enable_needed(void *opaque)
>  
>  static const VMStateDescription vmstate_msr_architectural_pmu = {
>      .name = "cpu/msr_architectural_pmu",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = pmu_enable_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
