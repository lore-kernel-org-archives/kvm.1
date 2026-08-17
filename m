Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E454788;
	Mon, 17 Aug 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950255; cv=none; b=E7yvU/PCxRWt50i5hrlS0FTcdymvCYQW9Ihaqyph6r9mbhTaQGnu83X1VDL2blFxeT5I5O2xUyQmZ0ewMgECRCfnp7lAnXRrCiZ9OSwEig7Q8mOZi0i2PlyDe/pS4dp36rIOzuWrsd2LJqlRf7Y/uZpBhpXhgNiLLBGHSlRVsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950255; c=relaxed/simple;
	bh=RA5FgSZVpapWMdUBtU20qvgMdjrHlQepQpZ462xZyQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKLSQTTcnEOO0ajQwxU2wsI6ryvjfpd0THO7tjqHISCXy3Fihlg02BG/FvNf6vVt7E/nOvllgWTLzo9dP2VdW5U9qeDN2BR5HsBunGcUPfgs/Tj8gl0TbO3pdpzFnH91AdgxM732/VEYy0wNFKC4lx9gsMW21Cin9mSk3QANK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTPNko5b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTPNko5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786950253; x=1818486253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RA5FgSZVpapWMdUBtU20qvgMdjrHlQepQpZ462xZyQk=;
  b=HTPNko5bPVxKGoiV/EWHI6UJluBuiamtSJlXOG2R5wHc8N3A0O3//Gs+
   JRBtvJ8b3wYyPBRsFWoJ9LzkPp2bViK4qvWjaIF5rdbtxYGUkt+KioqE4
   B7BQCfnlRSNwV2UON7agDhga9tT2ez37Wrqp+hHAY+r3zL1qr7wQvu+48
   6hatzVY299W1n3/xnuQiDA2vzS2SgjgCt8a6iSiUc7z2NXJDmu2oeZ0Fn
   3DRY/PPoYxxW2mKZYS9ZDm38tmtJ7534FA4nhjnAAAP71HEpt1kjToy9m
   YRHp2EO8tgLzl0GCyJ+bLZ5WQ7n+o/eWS1zpfQySDSwHUBtpM6IEsL9I4
   Q==;
X-CSE-ConnectionGUID: IVgF8V/cRXCxr0MKi8UuWw==
X-CSE-MsgGUID: udm3RtujRva1S9aYL1TaBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98782229"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98782229"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:04:12 -0700
X-CSE-ConnectionGUID: Mob2L680SJCTucsB6h2a+Q==
X-CSE-MsgGUID: fRK5ee3mR6aFCoVoh2DF7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="289654401"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:04:07 -0700
Message-ID: <0a08eab7-e093-46ef-97bc-531766cdbcf2@intel.com>
Date: Mon, 17 Aug 2026 15:04:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/22] KVM: selftests: Finalize TD memory as part of
 kvm_arch_vm_finalize_vcpus
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
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-19-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-19-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Finalize TDX VM after creation to make it runnable.

The changelog is too weak.

> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 4b97a9a1bb5e..8319ae3d9fe6 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1489,6 +1489,12 @@ bool kvm_arch_has_default_irqchip(void)
>   	return true;
>   }
>   
> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
> +{
> +	if (is_tdx_vm(vm))
> +		tdx_vm_finalize(vm);
> +}
> +
>   void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
>   		 const void *smi_handler, size_t handler_size)
>   {
> 

