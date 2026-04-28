Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC7274B23;
	Tue, 28 Apr 2026 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354294; cv=none; b=m+U9sIU+jxOVGPvpiaP8donBOdZb5+PA1JrZ0LuK73lsIwSQqsxnSpbhfJmCOlSw51XKF7dAQYLI0cZyG9s67rifzPRRHTTF1jXcFsTK3/Oz2V+ggiAnq3mTrNEtr5yUZ7kYfjo4M1ofuJWmfuuS3/FWkpSGAnuLIAGNvGJT/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354294; c=relaxed/simple;
	bh=ZQD/7NDBZLUGR9PfzG4/DrCuHMrvTRqWnHRdplwB0Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVVHLIFQlmXin3nVjkiI2dZl0fUvru+WTD8dr2RUVVWVrmkjgMnAAxEK1vCdmdcVSlCtI/H8McoNZ265FNjAJpPV0V/Ova61k+d+4hAy5MfenoIqSkVPBhUra1IFesHKaAWsnJl3xdQ+5SnozLu3Yd4uOP6uV7g2fFE9ZX+0ZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iefjk9Xs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iefjk9Xs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777354293; x=1808890293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZQD/7NDBZLUGR9PfzG4/DrCuHMrvTRqWnHRdplwB0Yc=;
  b=iefjk9Xs6eG+4OrFnl0/hquJs559GZIS8e9QlLhQRBCvYW8QphSCeiLX
   ZArbLN9sPFfDZFFZpOwsPVLIdYCMjP5tS+h3saKEWjDo/T64oXzJ5OQtT
   xXgc/wcKxRgkdFI8gh9MOCvodq4eHgpVJ+safsH63qYAr/D/5V//hai2W
   FGgQHHe+8639gwoyaPY8O6ixeWZnBkficAkuQVlMOcZIw56IMBplqa5CP
   Xq6RlFIglhrOLDN75kVWH0JerB6IT5KqiTZzU+5fcmvWLSkj7snjggjrk
   ZOUVZSmwZOp8r1zn3TsZIkcMCwu9sGzCWbYoZfMuCYTwWvhH0yplYyz4W
   g==;
X-CSE-ConnectionGUID: HmFFbUW+TVeiYbqV6wRWWA==
X-CSE-MsgGUID: uPoMrVb3RQuShhshjYnw5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="65782480"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="65782480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:31:33 -0700
X-CSE-ConnectionGUID: FBADyz7nQCid/gLOeZBF1Q==
X-CSE-MsgGUID: 27KnJNDGQjupDn7qufwTHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="230681066"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:31:30 -0700
Message-ID: <fea2bf8b-c52c-45f8-ad57-5056d0a6fd55@intel.com>
Date: Tue, 28 Apr 2026 13:31:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
To: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, dave.hansen@intel.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 chao.gao@intel.com
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-2-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260428024746.1040531-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2026 10:47 AM, Binbin Wu wrote:
> Add MSR_IA32_PLATFORM_ID to tdx_has_emulated_msr() so that TDs can read
> it.
> 
> Linux kernel reads MSR_IA32_PLATFORM_ID during init since commit
> d8630b67ca1e ("x86/cpu: Add platform ID to CPU info structure").  KVM
> already supports this MSR on read for normal VMs by returning 0.
> Without support for this MSR, TDs get unchecked MSR access errors.
> 
>      unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
>      Call Trace:
>       <TASK>
>       ? early_init_intel+0x28/0x2c0
>       ? early_cpu_init+0x9b/0x930
>       ? setup_arch+0xbf/0xbb0
>       ? _printk+0x6b/0x90
>       ? start_kernel+0x7f/0xaa0
>       ? x86_64_start_reservations+0x24/0x30
>       ? x86_64_start_kernel+0xda/0xe0
>       ? common_startup_64+0x13e/0x141
>       </TASK>
> 
> Add MSR_IA32_PLATFORM_ID in tdx_has_emulated_msr() to allow TDs to read
> the MSR.  MSR_IA32_PLATFORM_ID is read-only by hardware definition, i.e.
> KVM should never add it as writable, no need to add it in
> tdx_is_read_only_msr().
> 
> Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Nit: It would be helpful to add the info that read on this MSR from TDs 
always triggers #VE so that Linux guest will request emulation from KVM.

> ---
>   arch/x86/kvm/vmx/tdx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 04ce321ebdf3..812ad99b11e5 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2094,6 +2094,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>   bool tdx_has_emulated_msr(u32 index)
>   {
>   	switch (index) {
> +	case MSR_IA32_PLATFORM_ID:
>   	case MSR_IA32_UCODE_REV:
>   	case MSR_IA32_ARCH_CAPABILITIES:
>   	case MSR_IA32_POWER_CTL:

