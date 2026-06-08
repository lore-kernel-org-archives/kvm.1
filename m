Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EC37BE9E;
	Mon,  8 Jun 2026 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898253; cv=none; b=Dc/aG1p6Huc/FkeExo029Ed7e3vKLOwpKm9rN633kg/XBp3P5mtuyuSN8xzUE31P1IF2ebL3Nanno2AWh+2X1a/XGG69B0ZS6zQpbTkoht1v+1hdBBTOMNQVR/YfJEzkTMbAawpYCqtEAjmIZQqGo5SbLDAX0y3xF0rzJ8JBo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898253; c=relaxed/simple;
	bh=UhM05LYQzK8PNX2EjRBagWrP6FFhDloRZ4eE3WBSkco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WomuH58h0ef1fGhek8O+QUGFgLdD6Rff+jLyoTMksOEc/mlVVkJfPo1LE0PM2OjXOAUqQ4jCnA7mtEfSlCFyzmP4uQZJkPe6j/0ZlKhesb/qnA5svMN1rGFd1URICsLF51fmwYaB72sFfOcoolU6az+CJeLED+EjWlJAr+uDMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvGrofbP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvGrofbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780898252; x=1812434252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UhM05LYQzK8PNX2EjRBagWrP6FFhDloRZ4eE3WBSkco=;
  b=MvGrofbPq7JnTnaREWu+j5cEeNGK60ac72Kkx3s7VlXgUEKdpY40xu+S
   W/xIIyFdeqNUCZSHLOSiS2CT0cGBlPHCxqDjt6kXYZmWPOr6VkUZdy7uo
   hFgDckcBqY4iCDm4zfhtOwmAEg1WYQG3z579ZiWoGx6T5zN3yVGP34BoB
   H4eNEhKzAGBgPhDnD1iI5D6lxJfRDmxrM/dw5MF6Iym8Um7OxPQuFftIF
   64GjDFjUmhskfAZQOdZ1/jZZknTDAEz0bRMKR+CJj3eISd2pH/2uNKRig
   Qsk8Wctt8uOzVsWwyRX4bND/F9OKO4YJjtqe1zLqU4DMA46QU6W2dPOfC
   g==;
X-CSE-ConnectionGUID: /xyvxPMNTGu23i1eQaCR8A==
X-CSE-MsgGUID: U3sqoLNiSAe/d87/i+AOAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92192860"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="92192860"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 22:57:32 -0700
X-CSE-ConnectionGUID: JTWGYyAaQpm5TsCLm5FTmg==
X-CSE-MsgGUID: 0xV4nBAXSyuHM7jGUUtmYA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 22:57:27 -0700
Message-ID: <a58e2941-77f9-43cf-a54d-023506dd7eb0@linux.intel.com>
Date: Mon, 8 Jun 2026 13:57:24 +0800
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
 <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
[...]

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index f647e6ca6b34..48d4bd36c35b 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,4 +11,34 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  	return vm->type == KVM_X86_TDX_VM;
>  }
>  
> +/*
> + * TDX ioctls
> + * Use underscores to avoid collisions with struct member names.
> + */
> +#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
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
> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\
> +})
> +
> +#define tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	int ret = __tdx_vm_ioctl(vm, cmd, flags, arg);			\

tdx_cmd.c.hw_error is u64 and it could be assigned to ret, which is a int,
the upper bits could be truncated if the upper 32-bit is set.

> +									\
> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
> +})
> +
> +void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
> +
>  #endif /* SELFTESTS_TDX_TDX_UTIL_H */[...]
