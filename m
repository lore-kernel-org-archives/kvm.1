Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42E134CCF;
	Wed, 17 Jun 2026 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668340; cv=none; b=V3qKMhhF1I+seHWrEU0AyrXR0CSsQHO0yTB3MocTNtRUg3YfjJlBsBA2P/6zHYYnXVp3hAMC4eRGHX83mfTtaCBZLjwYk4ul99gM9iNLyv2y1+3diU23RIumLMY8v2EEAnpGH5VNi9CjnS23MllEjCSiSsUHkVCH8sufB/Gyy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668340; c=relaxed/simple;
	bh=tQIbKSGCggsDjsPRQYgkiN1yqMvDId6VFgfc4clu/AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAWBQMD91RXv+5E9d8/gScCfPg3XJpJjB4WrF0PIdcpSdIK6SCAE1o2sfxyAtMaFB7ygVMwXtXOuI9GsRBYA3jjsdvIYOeQxinhysbJet9zNiWz0pHMtqkRfBNJJLPlna0XR3ryoYDbCKWobdWY1Y6g3hf6o84aJw82gkiFqjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAM810Fk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAM810Fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781668338; x=1813204338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQIbKSGCggsDjsPRQYgkiN1yqMvDId6VFgfc4clu/AE=;
  b=dAM810FkquGwRor8IRw48eA4egv+peULBUUJ/6tV9gWFF7YjtNTL6cpC
   cBEZr0hNts9R6OlO2e0JgMf7TmswWjoo+8n9Ed9qcbkLp3ptF9xh//Fkk
   IN+mW/xwc7oGV0n5WoiOJzZ0R2hnE2fYQUDftA1592kyeHQS9BVmIuPAm
   oWFdHccfU4P9viSmAhd2ep/pI7SahQK1vtLXBz80UcQ/4kHOOH5SEDl+K
   JRFo8UUVzshTtWSGVOvfADOF+wi2MJETGYJnbHXLTCHjMje12o8bvqFPB
   Ls/O/NtSw+zAskzxBXoKqoOiunM4hQrao5U166z//l9fgdVUFYYqy4HN7
   Q==;
X-CSE-ConnectionGUID: XMLQlR9qT1a3CTU0rBSv6A==
X-CSE-MsgGUID: 6L6Qh6KRT1qB6kJR03GHXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81581037"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="81581037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:51:58 -0700
X-CSE-ConnectionGUID: zSVH7aMSSmWNkKi6YvOJ8w==
X-CSE-MsgGUID: UdMBFn0qRjeB2ZEEfriO6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="278153339"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:51:49 -0700
Message-ID: <e0847903-e9ee-4b3c-b120-aaba46894ada@intel.com>
Date: Wed, 17 Jun 2026 11:51:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/22] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
 to validate TDs' attribute configuration
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-4-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-4-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Make sure that all the attributes enabled by the test are reported as
> supported by both the TDX module and KVM. KVM filters out the attributes
> not supported by itself.
> 
> This also exercises the KVM_TDX_CAPABILITIES ioctl.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 868ff62e22f2..e5c998874a0d 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -110,6 +110,18 @@ static void tdx_filter_cpuid(struct kvm_vm *vm,
>   	free(tdx_cap);
>   }
>   
> +static void tdx_check_attributes(struct kvm_vm *vm, u64 attributes)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +
> +	tdx_cap = tdx_read_capabilities(vm);

well, this is another caller of tdx_read_capabilities().

As I commented in the previous patch, it's worth caching the result in 
tdx_read_capabilities() like what kvm_get_supported_cpuid() does for 
kvm_supported_cpuid.

And it can help only print the debug once.

> +	/* Make sure all the attributes are reported as supported */
> +	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
> +
> +	free(tdx_cap);
> +}
> +
>   void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
>   {
>   	struct kvm_tdx_init_vm *init_vm;
> @@ -129,6 +141,8 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
>   	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>   	free(cpuid);
>   
> +	tdx_check_attributes(vm, attributes);
> +
>   	init_vm->attributes = attributes;
>   
>   	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
> 

