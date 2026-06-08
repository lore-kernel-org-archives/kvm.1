Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072803B0ACE;
	Mon,  8 Jun 2026 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907671; cv=none; b=OP7diz3Mft2V/IWe+nSdwMi68j7aFU4xlJqe84GB6TkRGQ3y38yWYwGhYGERe6/1PNNEZLBY9Xeq7bT2KYUsnu/XmwGi3xqfLHl4yo/PljNonWUL6wAnyGNcHHq60rKhWcw3iWofDK7bJVLb9PF4DbZsDZq7WEqw6g6sDoB10+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907671; c=relaxed/simple;
	bh=FnQ1JtRVzrteGPjxYql2+zcjsPi1FKMeGzG2Ym0Gt/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOC6XpJYO5iYpOXlqyIwlyZd8fbsOF4iuEA7axF6IQdMk5uu4kHxsNuqpQA7dIXrDDUwoK7uLDPGj+MCI8VblqApCkYpbfVgouFQPw8+v6D8oPwmbSkeGxoOlfENbsx43BIl+x8p92ir8dmeMGY+qYlkzlh1wKL7nx7IUDxGR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJPwNxTk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJPwNxTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780907668; x=1812443668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FnQ1JtRVzrteGPjxYql2+zcjsPi1FKMeGzG2Ym0Gt/U=;
  b=IJPwNxTkw9BHHgIkVJV6CTnQZQMKaudDyawl3LxERikCTQbOzo8kjkjF
   zIEpsshwgEJvJf+cmDXoG6hROjDYh4j+96iIj23BIEQLk8/22//v83rF9
   yA2bOWjiITQZQMTvNwFfUO9kGCJBw3/NYVT3Cg8onVjCxaUdRy7Ountjw
   nS3jdYBIdscjwr2o50/cEt/aZhuQ7NnKQZXm3LPG7CZ4z85q/pK9Gv9y5
   oRRvOx4YVzzJBh1CHqFD2BGwCaXvzjDo3jPed8y7lTAVwFjoIBEvsa0Pl
   h0TJl+td6SRqrVTfA8e+ZdBOUU2fhUS8c8gMBstOK1ylIJBTWFljWXV58
   Q==;
X-CSE-ConnectionGUID: JnhxoFjwT2+BFdnUWkDhIA==
X-CSE-MsgGUID: 3zHd2XOQQv6Rvtg4BteMMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="93027187"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="93027187"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:34:25 -0700
X-CSE-ConnectionGUID: Vir/7hP/TfWq59yzcSm1/w==
X-CSE-MsgGUID: +bKIBP4fSUKCyspCfRmD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269463675"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:34:17 -0700
Message-ID: <bc8b458e-7893-4ad4-89a7-44568c227d32@linux.intel.com>
Date: Mon, 8 Jun 2026 16:34:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 15/22] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
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
 <20260521-tdx-selftests-v13-v13-15-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-15-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/2026 7:16 AM, Lisa Wang wrote:
[...]> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 9660ea9d2f31..4d01f806b37d 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -39,6 +39,30 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
>  })
>  
> +#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
> +({									\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (u32)(_flags),				\
> +		.data = (u64)(arg),				\

Nit:
The two lines' backslashes are misaligned.

> +	} };								\
> +									\
> +	r = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\

Similar issue of the truncation of upper bits.
Though TDX KVM code never sets hw_error currently for vcpu version. 

> +})
> +
> +#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
> +({									\
> +	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
> +									\
> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, (vcpu)->vm);	\
> +})
> +
>  void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
>  void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
>  void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
