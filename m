Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CE352C34
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798901; cv=none; b=GtNYOrBZLvAy1gM1u0J1zVPXNGFU4mjyz2o4oLwAlbPhIOCj3UGWMKB9yujHCLyiswWeEz4KRLyw8GhMLOlLdgZRM7cIaXTSGNQBGSN+skulqcoQInfUOoDqr+buVwZqdb0WZ01ye4KnVb7OZHCFkpAarahr2cIbgYzw9+1C3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798901; c=relaxed/simple;
	bh=mfnmosi4BV4jhmRUatumaECzfPfZP7C/+XKW6zJu1ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRG6raxomcu67NFeGGXZwKf4BZeQwZamEBP8tvQ1owxwumAT+VmunTIOG9mtL7pCFNsRxL1/DAUeTUMMtmL9Cc/WuRjzNL3/GWHN4WPQPjv2tTHiIEPulnIyaOrkmB2ItpTw2Z4vzWE6FkABJ0G/56EvPJjls+oIki3R4bqLe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqdiTdOg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqdiTdOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779798900; x=1811334900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mfnmosi4BV4jhmRUatumaECzfPfZP7C/+XKW6zJu1ls=;
  b=JqdiTdOgtXTLeNY7JLrIPyrWk7Qw3+XxMWSaewpBFYLJYs0Y55HL/J9W
   x5j2pmUQGxhEw2Ah90wg8OMj1RiEskCei1N7w8wvQleL3ENI196+LfmKy
   29QSxZMWHRwttVCoapPq5VQiOFSqogNTSNK4M4+qdCi1c5lFpn0yLA1fD
   7bnE/b7Zba/urXh6J0bTmZh8Mh+pMI+iAbtHTFT5UZ6TkX74hRBhXJIlv
   BhTtGKtLFTt4ATW2rFqNsvfjoaqDlQoKFrXIowujLSS0mw5di/95LLZ3+
   nuEeAFaeuCm2hpqA6tdEQ9MS2S0HAu89oTZIFQEgUiOj+U6iMYQabbFta
   A==;
X-CSE-ConnectionGUID: Cmvs/Qo2QMCuVWuGvJmgRg==
X-CSE-MsgGUID: 7+PslqHKRyGU38frNiBqLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="79643742"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="79643742"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:35:00 -0700
X-CSE-ConnectionGUID: vJFMq+I8S7uPIp70jDQWIg==
X-CSE-MsgGUID: oEp8hdNwQci9V4eNsDiBOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246996805"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:34:59 -0700
Message-ID: <d4c1baac-f81e-4ec7-9d57-be0c51640d2b@intel.com>
Date: Tue, 26 May 2026 20:34:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 4/4] nVMX: Validate DEBUGCTLMSR_LBR
 states during VMX transitions
To: Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-5-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260526031704.109102-5-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
> Add tests to verify that DEBUGCTLMSR_LBR state is correctly
> handled during VMX transitions on top of the shared helper.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   x86/unittests.cfg |  9 +++++++++
>   x86/vmx_tests.c   | 19 +++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> index 78c15e2b..d089c86d 100644
> --- a/x86/unittests.cfg
> +++ b/x86/unittests.cfg
> @@ -487,6 +487,15 @@ arch = x86_64
>   groups = vmx
>   timeout = 240
>   
> +[vmx_legacy_lbr_test]
> +file = vmx.flat
> +test_args = "vmx_legacy_lbr_test"
> +qemu_params = -cpu host,migratable=no,+vmx
> +check = /sys/module/kvm/parameters/enable_pmu=Y /sys/module/kvm/parameters/ignore_msrs=N

What's the purpose of checking ignore_msrs here? can you elaborate a bit?

> +arch = x86_64
> +groups = vmx
> +timeout = 240
> +
>   [debug]
>   file = debug.flat
>   arch = x86_64
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 934d6021..80ed541a 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -11843,6 +11843,23 @@ static void vmx_rtm_test(void)
>   	report_pass(__func__);
>   }
>   
> +static void vmx_legacy_lbr_test(void)
> +{
> +	if (!this_cpu_has(X86_FEATURE_PDCM)) {
> +		report_skip("%s : Perfmon/Debug Capabilities MSR not supported",
> +			    __func__);
> +		return;
> +	}
> +
> +	if (!pmu_lbr_version()) {
> +		report_skip("%s : LBR not supported", __func__);
> +		return;
> +	}
> +
> +	vmx_debugctl_transition_test("DEBUGCTLMSR.LBR", DEBUGCTLMSR_LBR);
> +	report_pass(__func__);
> +}
> +
>   #define TEST(name) { #name, .v2 = name }
>   
>   /* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
> @@ -11968,5 +11985,7 @@ struct vmx_test vmx_tests[] = {
>   	TEST(vmx_bus_lock_detect_test),
>   	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_RTM_DEBUG */
>   	TEST(vmx_rtm_test),
> +	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_LBR */
> +	TEST(vmx_legacy_lbr_test),
>   	{ NULL, NULL, NULL, NULL, NULL, {0} },
>   };

