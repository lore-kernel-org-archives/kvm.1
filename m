Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C6497B87;
	Fri,  9 Oct 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533567; cv=none; b=i+gIlyOeAzh5LPsOroxvA1dLGjRM3VYvu6cbWMNGyBORWm8O+sJ1/fLP2D9Sv8oDhGKvX+WuyTIxVurbDSDwVzcOfXEfXhyzZqRwI+j/dVcOlISiTQj4fOjHYpMGXyt+RIF8X11ywN4m2GYC4rIcPePmEyrEs3y5l0dAXTlpR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533567; c=relaxed/simple;
	bh=D810hF2o1LB5SqZDV9eib/xbHSJlNo1j3icxmEqZVKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k76GOmy/v/h5YwWZdSTcryBnzvkrBhAMbZdDNclGWTLw7GSPQvaphGCa5hXfsRZy7xQCimLPbdhcHJz+HdU2ZwS7htyYr0uf/jF8o7LfzdXRcZVNdhmZxSpm1p2usLt9CfpIeq07t/4n97jCnDVybNPT8IXX4gJ9GPrbn98wRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkMXxc6L; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkMXxc6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791533561; x=1823069561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D810hF2o1LB5SqZDV9eib/xbHSJlNo1j3icxmEqZVKs=;
  b=fkMXxc6LvExEiSztLFPbARVf88rN9+tZ0n/zTX7h9VgLw+eARz8828/v
   m8r963k6v1KjQCtZc0jGoG2vnauL+4mbvYKihYNrwG+2KL6HRR+t2wpG7
   0N/BNDEoNPj99ZRA6Bk6qiDsXk/8a6esgfxuWK1kVe7BfteH4dEabMNO8
   9XqlDcpdgzp+yUvPsBLO1XZHf5/NYya+jtL7lA7q6Fli63N69RLnSkLSz
   tP2a1I3hR2uE2cftz90vs3ROXRtyNe07qun+6ZiGhj4q3uT8Z4xYysFpR
   1vM8DYtdLHu3fPIAObknz1HoLTzjfPhGk+0Aq+6daBg2/o6B5RFukzQQt
   g==;
X-CSE-ConnectionGUID: x9HAVtyySZK1UCVX0V+RfA==
X-CSE-MsgGUID: mqdE2yufRR++lUKroeQ6Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="340155"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="340155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:12:40 -0700
X-CSE-ConnectionGUID: vb6Kwe/+QhCKUC4+mj+bdg==
X-CSE-MsgGUID: FA90pO7YRVuK1PwyJLL16g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="334663"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:12:30 -0700
Message-ID: <934a6eed-a692-449b-9fbd-b69e59ba287b@intel.com>
Date: Fri, 9 Oct 2026 16:12:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 19/23] KVM: selftests: Finalize TDX VM in
 kvm_arch_vm_finalize_vcpus()
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ackerley Tng <ackerleytng@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-19-7c62a5d8a992@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-19-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Finalize TDX VM after VM and VCPU creation and memory initialization.
> 
> To integrate TDX VM finalization seamlessly, the finalization is hooked
> into kvm_arch_vm_finalize_vcpus(). This approach avoids the need for
> every TDX selftest to manually finalize the VM. While it does prevent
> TDX selftests from customizing memory before it is locked, no current
> selftests require this.
> 
> In TDX, finalization is a mandatory step to make the TD runnable. It
> also finalizes the MRTD of the VM's initial memory and state, locking
> them in for future attestation and preventing any further modifications.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b4b76dc505ae..e1d0fd5ed1f6 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1536,6 +1536,12 @@ bool kvm_arch_has_default_irqchip(void)
>  	return true;
>  }
>  
> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
> +{
> +	if (is_tdx_vm(vm))
> +		tdx_vm_finalize(vm);
> +}
> +
>  void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
>  		 const void *smi_handler, size_t handler_size)
>  {
> 

