Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5F3ECBF9
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798817; cv=none; b=qnhf3Z8A/oOn3ZlB84o2loLtBfXZkoHbmrdq7zDz3eU0KN1rtzEu5ImYOe/UZxP6eqrMUbLrHcFXJG5CfbiYL1NDDPAVhQh7rXvotJpAKSWr5+/5urjopOowUSVLcylrbTB3cd5bhapmYuc8e2KyQdWXL7W5s4izrbi5PR3GAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798817; c=relaxed/simple;
	bh=E33KGN/IorWffLC6VTm0CbaLGXOFBrQrEeXUGW4b9XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNgPpw94Jboh7pFid72dbQZrcDqM96aa+u1QP9eYBLlnbvdmsQQzb1IL4g2ZB9jrau015ML5EAEFX/FRp8+j8Gbodx52za16fCW9NOnEsKiCBaATJdBIvOEeqk1vh5G644q+P1IpbxF3LmPhd1Xi4pUjdmcDQOBwyFaqCzXs/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVRAB11G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVRAB11G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779798814; x=1811334814;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E33KGN/IorWffLC6VTm0CbaLGXOFBrQrEeXUGW4b9XU=;
  b=BVRAB11GgbDmEuKkDSzWQlIrM1E3MmMHdsdMQYGjVj5AgawwruIgd4SK
   G3mmwP0/bxVo7CEKXcCo/DmtntSlBy6NLKOaAv83X710XmMU91H7WnXAy
   Chsw9GCoy7AzhhPOaC4Z3AT0/IkWQ0X5m+3q2RborFj64oOIHSN8IWfGB
   b5GMkaLk2fLR9pbHRU8hqVdW2WXR47DHnLP5+ztVxWLaO/s0rmKvERZuT
   sGQdzYiAPUmhFfnIUaZ1cF1nIrV/dJA11tqaw5XTJTJyhkAUB9eTfrqrr
   qdP4tDD9RJFhIMmMBJKLdAZCKxIvdLIykvrO9LE/XcqG+QGuUOak3g4AN
   Q==;
X-CSE-ConnectionGUID: omMyA2wfR0mwk5fPx5v/Xw==
X-CSE-MsgGUID: ALOutzAgTAefmSV/791hDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91715454"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="91715454"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:33:33 -0700
X-CSE-ConnectionGUID: qbZ7WbIARMisMsCfKNNqgw==
X-CSE-MsgGUID: 30zVm06GQzWUxQhSk6AJQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="265770779"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:33:31 -0700
Message-ID: <0ae16f40-f724-4122-9063-ef2b11532f16@intel.com>
Date: Tue, 26 May 2026 20:33:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 3/4] nVMX: Validate
 DEBUGCTLMSR_RTM_DEBUG states during VMX transitions
To: Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-4-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260526031704.109102-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
> Add tests to verify that DEBUGCTLMSR_RTM_DEBUG state is correctly
> handled during VMX transitions on top of the shared helper.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   lib/x86/msr.h     |  1 +
>   x86/unittests.cfg |  8 ++++++++
>   x86/vmx_tests.c   | 14 ++++++++++++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/lib/x86/msr.h b/lib/x86/msr.h
> index da75740d..8b019f7e 100644
> --- a/lib/x86/msr.h
> +++ b/lib/x86/msr.h
> @@ -110,6 +110,7 @@
>   #define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
>   #define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
>   #define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
> +#define DEBUGCTLMSR_RTM_DEBUG		(1UL << 15)
>   
>   #define MSR_LBR_NHM_FROM	0x00000680
>   #define MSR_LBR_NHM_TO		0x000006c0
> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> index c8426770..78c15e2b 100644
> --- a/x86/unittests.cfg
> +++ b/x86/unittests.cfg
> @@ -479,6 +479,14 @@ arch = x86_64
>   groups = vmx
>   timeout = 240
>   
> +[vmx_rtm_test]
> +file = vmx.flat
> +test_args = "vmx_rtm_test"
> +qemu_params = -cpu max,+vmx
> +arch = x86_64
> +groups = vmx
> +timeout = 240
> +
>   [debug]
>   file = debug.flat
>   arch = x86_64
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index a3e52d3b..934d6021 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -11831,6 +11831,18 @@ static void vmx_bus_lock_detect_test(void)
>   	report_pass(__func__);
>   }
>   
> +static void vmx_rtm_test(void)

still the name is not perfect to me, otherwise

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> +{
> +	if (!this_cpu_has(X86_FEATURE_RTM)) {
> +		report_skip("%s : \"RTM\" not supported", __func__);
> +		return;
> +	}
> +
> +	vmx_debugctl_transition_test("DEBUGCTLMSR.RTM_DEBUG",
> +					 DEBUGCTLMSR_RTM_DEBUG);
> +	report_pass(__func__);
> +}
> +
>   #define TEST(name) { #name, .v2 = name }
>   
>   /* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
> @@ -11954,5 +11966,7 @@ struct vmx_test vmx_tests[] = {
>   	TEST(vmx_cet_test),
>   	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_BUS_LOCK_DETECT */
>   	TEST(vmx_bus_lock_detect_test),
> +	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_RTM_DEBUG */
> +	TEST(vmx_rtm_test),
>   	{ NULL, NULL, NULL, NULL, NULL, {0} },
>   };

