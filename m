Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215501;
	b=MeHEJh4Xoa6c/FPcuk9l1Y2D9vxFhL8PnMam30bqDNDtFc8fnEnFHSJwh2brU3hp+N7Q
	 isawjtW1YelWc2ckvjfCWDp+AnegQHrhdYRO3N+RMTJ68kPdt1qi3W6A1zup+Nq6XEf3I
	 HQMRd7ywuopUa4T9v/pFguyRmRKdEWMYp6XM6+GMBUpozCshzTc6qxzb6pGThiQSx0frc
	 jykMv8P6SKRexBG2VUio4vIVM23in2cXB+6dFubBIPpwEX73P8Y2ibhYfhppN2Gg/48GE
	 qdDax1KiD03l+Hb0FHJsVsiwm9nlHdgrbrqt5RF98LLbo+61+qVOpFdJSzeirXzsh6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215501;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=egzxngU69vKcrr7+p837GGhnPvFEBet1zuOWDt4J3YI=;
	b=mNfhlI1XhRjYeUp6+62khyKU8ZHKP78Z0bsbu/vQYJZY9Nl04qDDItbnx9IMpuZnL6nP
	 0+6JtwBNC3TLkUqnsnwO6pUMCvhmcpDVecIpR++tZG1E1XMtR7NvVTPNzMb8KuU1/H5is
	 h02ONK0Ac2oaM6IUq06Nn1GNrSOsTBnBI0VPYF7Ve2lLxKLI7fC/WlmXFjF3mrDnXpX9Y
	 cWTztykPrAjo6UlctGnDslu/58AKfBvFiIVl40yvTxHi4i2Dx4kv/SD7Y2Vfx5tJqpRKB
	 NmdwFPfXKJnR9Lia7dt0dL+kRRrRrmOESyrozRC5BQzLJfpUIEQpPui7DS3rrV3NKAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cGRTTmgM;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4094606A321;
	Mon,  9 Nov 2026 09:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4094606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cGRTTmgM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794215501; x=1825751501;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=13TAfu869OtGIxSBgxkcnFwjcF4uUzC6r7aMz7+y47M=;
  b=cGRTTmgMqYutSoMgM0DRVo7d+H2WLaqLhi1XwzKPvLhfblfKF8VMEV7J
   li0XCM31EzIx8kWAnxmob501hZYyZ9xcguVi+WKgd6PSCnWBcM+wdTIAF
   GqsZvSXnY53Er8hk5BOvTG9z2nGCWigRJW4kv3nIf2DbxleBVKL3vQXbF
   ZPedlNDjf0ZNiaFDwIB6eehDXapfujNRCkZJBVmpt0e+2Y9ZrFUXYcvZQ
   x28PZ0Cq7XZRnH7oNn/3K6MPCKRb8klufOZeSicq/znMhvMMdUZK8Lfxh
   7zTg2zN69EQwmF944PkjPVu4QpDLkSno7IuwePulvFjPY8pNJMPTQsAkW
   A==;
X-CSE-ConnectionGUID: tV7WAmX0TEa9mXWVIN1Wkw==
X-CSE-MsgGUID: 51e/B9THSK2SNl0LchO8mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2934162"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2934162"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 01:11:40 -0800
X-CSE-ConnectionGUID: FNDEk0SGShCMDGU0eOop1Q==
X-CSE-MsgGUID: hjF5Ezs7SIaOgd0QS3sSWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8391745"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 01:11:35 -0800
Message-ID: <0a02bc98-9df3-4f18-b52f-9a7f70653be1@linux.intel.com>
Date: Mon, 9 Nov 2026 17:11:32 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/20] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
To: Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>,
 Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-12-2024e8fa517a@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261105-tdx-selftests-v16-12-2024e8fa517a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2026 7:46 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
> vcpu creation.
> 
> KVM_TDX_INIT_VCPU has a strict prerequisite for the CPUID state. To
> satisfy this requirement, call KVM_TDX_GET_CPUID and KVM_SET_CPUID2 to
> pull the CPUID configuration from the TDCS and commit it into KVM,
> allowing KVM_TDX_INIT_VCPU to succeed.
> 
> Additionally, unlike tdx_vm_ioctl(), tdx_vcpu_ioctl() doesn't check
> hw_error. KVM's vCPU-scoped TDX ioctl handlers don't propagate SEAMCALL
> errors into hw_error: the error is handled in the kernel and only an
> errno is returned. Checking the ioctl's return value and errno is
> therefore sufficient.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       | 22 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c    | 27 +++++++++++++++-------
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 11 +++++++++
>  3 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 4330290d29e9..9d951f67b3b5 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -46,9 +46,31 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  		    #cmd, ret, errno, strerror(errno), hw_error);	\
>  })
>  
> +#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
> +({									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (u32)(_flags),					\
> +		.data = (u64)(arg),					\
> +	} };								\
> +									\
> +	__vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +})
> +
> +#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
> +({									\
> +	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
> +									\
> +	TEST_ASSERT(!ret, "%s failed, rc: %i errno: %i (%s)",		\
> +		    #cmd, ret, errno, strerror(errno));			\
> +})

Nit: missing a blank line.

>  void tdx_init_vm(struct kvm_vm *vm);
