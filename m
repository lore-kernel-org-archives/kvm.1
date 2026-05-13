Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22291357D04;
	Wed, 13 May 2026 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670181; cv=none; b=TL8cB60m7sWZCl/j3vop9t4VdZbgPuWEx0Ao8/EHkqjMJRV4psrFvGN6BIoylNwMFGoBk+ROvBqva6OCWnhOd19xRzC+oLNW83OIie1MAKsan6jEgTnZaRDBAyPaDS3jV1nhRKbKCWeuJyjKdeGWV8QOVI3gyGAp1hZi6PoDUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670181; c=relaxed/simple;
	bh=2R61fqNPCzpBcZ/nHkgNVU+bazmBf8PJ695F17PhxTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1JEsqWxewwHYZ8QrhuRvjr+xjwKwB83LtoVhDL9qOSYkqZWqUsjCf/A+tXY8lmH2Ap34Rwa1IvnOlHXqRoTXHGMZ9jn+F8vD83PGRwAohP6tj/BIXIYOtZACThpVDSam9dsOydy4hU5JcgB3Sn6vN4KDUZmjxDobZk3sG0coP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lh7i3ISM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lh7i3ISM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778670180; x=1810206180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2R61fqNPCzpBcZ/nHkgNVU+bazmBf8PJ695F17PhxTw=;
  b=Lh7i3ISMO0XT9RajOp4+A1+0R5GaK4ogLf/8XV6n6aFPUxSp6Cf28tFm
   DO75Q5MHk9NlpaaEJJFTPKsYcLC4jMSd9cZ/F46J/+sb0B8Fsc6dTXIzb
   5GH9Z4JQrFtbeenxb7oNtA4kBwG6xw8tE4HGmrlvlpCEpSnFp+UCS8zZk
   RuP6q/klm90HRn79EA+HxfKRckThw+EpWfwS8Rau5Ijw06tCXo90bfOmr
   wTwZaXtNk0nn+sMzT4bLIfq79eS+5TVAkBHoe1OTKPp5eOYJCDwiHgKij
   jyZ7BXm7/VYzX/2Cc9oXkrWKLOijPZG2BZWlWXYv118Fq4dzwfjbBiC+A
   Q==;
X-CSE-ConnectionGUID: QDOR78JsTFWws1tK0AyK6A==
X-CSE-MsgGUID: 77qxwAn7S8uKYgHXQiNmiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79706970"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79706970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:02:59 -0700
X-CSE-ConnectionGUID: Rys882sfRLGtOP/u0wJptw==
X-CSE-MsgGUID: Znw0lnbVTXyzYaElOvQyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="243042703"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:02:57 -0700
Message-ID: <4365e457-3d3d-4bc0-ac11-b3d4dfe8ccab@linux.intel.com>
Date: Wed, 13 May 2026 19:02:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 6:14 PM, Borislav Petkov wrote:
> On Tue, May 12, 2026 at 09:57:58AM +0800, Binbin Wu wrote:
>> hypervisor_present could be uninitialized if dis_ucode_ldr is true.
>> intel_get_platform_id() is also called during the normal cpu initialization.
> 
> Right, that needs more surgery. See if the below works instead pls.
> 
> We might as well do it - the question whether we run on a HV comes very often
> recenly - might as well make it an "official" variable.

Make sense.
My version treated it as a bug fix, so I tried to minimize the code change. 

[...]

>  
> @@ -179,6 +172,11 @@ void __init load_ucode_bsp(void)
>  
>  	early_parse_cmdline();
>  
> +	if (!cpuid_feature())
> +		dis_ucode_ldr = true;
> +	else
> +		x86_hypervisor_present = native_cpuid_ecx(1) & BIT(31);
> +

There is one case not covered by setting the global x86_hypervisor_present at this point.
Xen PV guest will not go this path, so Xen PV guest will not see the hypervisor bit.

But maybe we can just ignore Xen PV guest case today?


>  	if (microcode_loader_disabled())
>  		return;
>  
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 37ac4afe0972..a4c0a0cf928b 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -138,6 +138,9 @@ u32 intel_get_platform_id(void)
>  {
>  	unsigned int val[2];
>  
> +	if (x86_hypervisor_present)
> +		return 0;
> +
>  	/*
>  	 * This can be called early. Use CPUID directly instead of
>  	 * relying on cpuinfo_x86 which may not be fully initialized.
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index 3b93c0676b4f..a10b547eda1e 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -48,7 +48,6 @@ extern struct early_load_data early_data;
>  extern struct ucode_cpu_info ucode_cpu_info[];
>  extern u32 microcode_rev[NR_CPUS];
>  extern u32 base_rev;
> -extern bool hypervisor_present;
>  
>  struct cpio_data find_microcode_in_initrd(const char *path);
>  

