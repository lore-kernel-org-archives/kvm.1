Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355EF7260D;
	Thu, 25 Jun 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355088; cv=none; b=AU2hY9vrH+ra8BrirfVMlVB48ZbxGP3Ppgtp7u5JfJmT+Hw5pHMPhhX6xhE0uNPla5q2l/ykWCqSqaDj5c2NnYqMuAGA7ySxFw7Kf8beboadJcd1hTDiYu+H96AHJBhoh6dPOfiVn5PyV0EQavHq3LFegXcmz/gT/e6YqX5p/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355088; c=relaxed/simple;
	bh=3qAbsSbzpe2AKFo1ftuQfOGV7e4Mi46D+/R47z5c55E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdyhZ125XqxHxrZ0H7qXasfgs/cR/Qx2ZdnEdpjuR7E0nxi/eWEwfJRBOxnTAwmAnw3gtUCo4xdICMMeCoKju+jfPUyPCgZG41tjkB12paYXzYJGZL2V1I6Pvg8xPPRmnzRGu+3gUHKYkLIeKPXX7VZdo4WaVg+7YGin6S/5Pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwFCzH14; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwFCzH14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782355086; x=1813891086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3qAbsSbzpe2AKFo1ftuQfOGV7e4Mi46D+/R47z5c55E=;
  b=mwFCzH14E090shvkp8dA4FTLE7MNTRLFqXnFakWo/RnvSyPYjsI9FROM
   ToxM/jhF0/d2oW2B+rJnw0Rxq5iL83ejo3YmMEmVOH5j1uReWaBVoTwni
   cLldAHTJNG7T0cYuiNgsbMtBbd8ZaG5neVotKGlGscOUo6JLWsvCrs1xE
   1k7rngN5wNXCaZtDuSEv1Si2N74uTbWztFQZH+8j78VMjOiYHQbhgi/ak
   ARtk+zukCAokf2cfN7JdEMv7iIMU5vVuEui+0VNe9Itk/F9bGSR4rAbbx
   EaU5pAYyOLXNdp7QdILZbPGRaVxz7kn8BhPKZLjRNPJFsvSIk3r/jYPVP
   w==;
X-CSE-ConnectionGUID: 1JPCIzoSTuKIzhvzpacd4g==
X-CSE-MsgGUID: 9h+RtsOzSwuasCYaDpYarw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94619144"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="94619144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:38:06 -0700
X-CSE-ConnectionGUID: zrW+IegPTx2jTYs8hchbvQ==
X-CSE-MsgGUID: irBzmXXPTfmZzyazgqiyiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="280425023"
Received: from unknown (HELO [10.239.158.28]) ([10.239.158.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:37:59 -0700
Message-ID: <8d2fc372-270f-4a46-b673-e546099af9c1@intel.com>
Date: Thu, 25 Jun 2026 10:37:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/22] KVM: selftests: Initialize the TDX VM
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
 <d27cce6a-da0b-46dc-96b3-5f2f699907eb@intel.com>
 <ajxtMdOFCPiMU0Pw@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ajxtMdOFCPiMU0Pw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/2026 7:50 AM, Lisa Wang wrote:
> On Wed, Jun 17, 2026 at 11:21:49AM +0800, Xiaoyao Li wrote:
>>> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>>> @@ -11,4 +11,34 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>>>    	return vm->type == KVM_X86_TDX_VM;
>>>    }
> 
> Thanks for the review. I will change all comments for this patch I did
> not reply here in the next version.
> 
>>> +/*
>>> + * TDX ioctls
>>> + * Use underscores to avoid collisions with struct member names.
>>> + */
>>> +#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
>>> +({									\
>>> +	int r;								\
>>> +									\
>>> +	union {								\
>>> +		struct kvm_tdx_cmd c;					\
>>> +		unsigned long raw;					\
>>> +	} tdx_cmd = { .c = {						\
>>> +		.id = (cmd),						\
>>> +		.flags = (u32)(_flags),				\
>>> +		.data = (u64)(arg),				\
>>> +	} };								\
>>> +									\
>>> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
>>> +	r ?: tdx_cmd.c.hw_error;					\
>>> +})
>>
>> It looks __tdx_vm_ioctl() can be implemented as the static inline function.
>>
>> Given all the existing xxx_ioctl() are implmeneted as MACRO, I'm OK with it.
> 
> Most vm_ioctl() and vcpu_ioctl() used MACRO.
> I prefer to use MACRO for `tdx_vm_ioctl()` for the `#cmd`, but I am ok
> to change `__tdx_vm_ioctl()` to static inline function.
> If we can only change part of it, do you think it is better to change it
> as the static inline fucntion ?

Personally, I like function over MARCO, but it doesn't make a huge 
difference either way. Let's keep it as-is and move on.

>>> +}
>>> +
>>> +static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
>>> +						      u32 leaf, u32 sub_leaf)
>>> +{
>>> +	struct kvm_cpuid_entry2 *config;
>>> +	u32 i;
>>> +
>>> +	for (i = 0; i < cap->cpuid.nent; i++) {
>>> +		config = &cap->cpuid.entries[i];
>>> +
>>> +		if (config->function == leaf && config->index == sub_leaf)
>>> +			return config;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>
>> No need to introduce a new fucntin. We can use get_cpuid_entry().
> 
> I think we cannot use `get_cpuid_entry()` directly here.
> This function is called by `tdx_filter_cpuid()` to check if KVM's
> supported CPUID entries are present in the TDX capabilities list. Since
> the TDX list only contains a subset of CPUID leaves, some queries will
> naturally return NULL (which we want to gracefully filter out) However,
> `get_cpuid_entry()` has an embedded TEST_FAIL(), which would abort for
> any missing leaf.
> How about I add a `__get_cpuid_entry()` to share the same part of them?

yes, please.

> Lisa
> 

