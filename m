Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EA453A25;
	Fri, 14 Aug 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696395; cv=none; b=allO3iR9XO3ZDESC7QlqwcRt7ye2zqiIE1y2r/21SbRoygdjdN+i21rsRBh6Bc+jYAjB+o2dKVb3Pq012NMa9st3O7k+m1moGeoY0fsf7MiHH5iqoaZuSNmESkEC+P8IMnT86ikZ1cCjLtE3j3r0mNf40YGuAafZ3dWJTrcfD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696395; c=relaxed/simple;
	bh=mNltrAyR9hZzHlJWXIBFJLDbWMrhnCpIF5u/lBabfts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcqKe/2/vLmq1BE8kVbYmDzgRaux+KTtUc/RZcGJegzcPfjUAKYw0TvvcY+b7s+NYpneoROyUvRzNUz5kD2HlZ+W5PcJVvjAu7/JY4Lv/bHxtM/EtPNUzCSnzkWeQdkS91pmwo70cOMDoDrnXD7SZqYyIapEXJmWq+LmrDK/rK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+xPeKkK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+xPeKkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786696392; x=1818232392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mNltrAyR9hZzHlJWXIBFJLDbWMrhnCpIF5u/lBabfts=;
  b=C+xPeKkKUtg5f5IPy0+hIZe8QRwy8l3PpfYLo97COR3OmSDpw6bQW1ZG
   wZ3laMVfcm/oqYYutfTb/r5Qk/yTUaIWT3LOUKuG2wYMrsUs3+wDCssIU
   ut72iv9ZgjKTeJxuOiNxxP6/4ByAkZVVf5KDlLU/MWwIFiZIKigzju2q5
   luS5Ahbk0VcM4arO1fBEzTdi6JiX2kb55Yi54IvTX+cr2eTjBb9IuS6PX
   81MaxOrqocspQzB3r81wALwq3Qast0NRnUvD2h/KQ1cKLe+gYtZQG9ddT
   O2rq+z4DO9YtupCSKgc9uRMJjrTXbc0MRvep3ucX2O4te/fXF4HObCYT6
   g==;
X-CSE-ConnectionGUID: K9lKaSLkSsSFdz/GSPQVWg==
X-CSE-MsgGUID: RQaFkWBBQZCrzBqCmL19Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87200435"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87200435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:33:07 -0700
X-CSE-ConnectionGUID: JPzmKiCQQ+Gz5oN0oJ8dYw==
X-CSE-MsgGUID: EHPMtIH9RMOCEe3sPv2Oxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="266153841"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:33:01 -0700
Message-ID: <31ddbd64-eeb4-4008-87fb-ff57de93635d@intel.com>
Date: Fri, 14 Aug 2026 16:32:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/22] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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
 <20260722-tdx-selftests-v14-15-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-15-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
> vcpu creation.
> 
> Since the cpuids for TD are managed by the TDX module, read the values

Please use CPUIDs instead of cpuids.

> virtualized for the TD using KVM_TDX_GET_CPUID and set them in kvm using
> KVM_SET_CPUID2 so that kvm has an accurate view of the VM cpuid values.

This does two things, and KVM_SET_CPUID2 isn't a hard requirement for 
KVM_TDX_INIT_VCPU.  we'd better split it into two patches.

> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h       | 21 ++++++++++++++
>   tools/testing/selftests/kvm/lib/x86/processor.c    | 33 ++++++++++++++++------
>   2 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index f5003cbaa106..07e7f5c90329 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -44,6 +44,27 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>   	}								\
>   })
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
> +	TEST_ASSERT(!ret, "%s failed, errno: %d (%s)",			\
> +		     #cmd, errno, strerror(errno));			\
> +})

It doesn't handle the tdx_cmd.c.hw_error for vcpu ioctl, but handle it 
for vm ioctl, which looks inconsistent. This at least deserves a 
justification in the changelog.

>   void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
>   void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
>   void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 8f8bb90fec35..f6a2aa6b86a4 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -838,6 +838,17 @@ gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
>   	return stack_gva;
>   }
>   
> +static void tdx_vcpu_init(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_cpuid2 *cpuid;
> +
> +	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
> +	tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);

If I remember correctly, though KVM_TDX_GET_CPUID is a vcpu ioctl, the 
data returned by KVM is retrived from TDX module and TDX module only 
maintains the TD scope CPUID. So the CPUID returned here is TD scope, 
for per-vcpu CPUIDs, e.g., x2apicid, we need to update them accordingly.

This seems not a functional gap. I'm OK to leave it to the future, but 
please leave a TODO comment for it.

> +	vcpu_init_cpuid(vcpu, cpuid);
> +	free(cpuid);
> +	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
> +}
> +
>   struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>   {
>   	struct kvm_mp_state mp_state;
> @@ -845,15 +856,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>   	struct kvm_regs regs;
>   
>   	vcpu = __vm_vcpu_add(vm, vcpu_id);
> -	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> -	vcpu_init_sregs(vm, vcpu);
> -	vcpu_init_xcrs(vm, vcpu);
>   
> -	/* Setup guest general purpose registers */
> -	vcpu_regs_get(vcpu, &regs);
> -	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = kvm_allocate_vcpu_stack(vm);
> -	vcpu_regs_set(vcpu, &regs);
> +	if (is_tdx_vm(vm)) {
> +		tdx_vcpu_init(vm, vcpu);
> +	} else {
> +		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> +
> +		vcpu_init_sregs(vm, vcpu);
> +		vcpu_init_xcrs(vm, vcpu);
> +
> +		/* Setup guest general purpose registers */
> +		vcpu_regs_get(vcpu, &regs);
> +		regs.rflags = regs.rflags | 0x2;
> +		regs.rsp = kvm_allocate_vcpu_stack(vm);
> +		vcpu_regs_set(vcpu, &regs);
> +	}
>   
>   	/* Setup the MP state */
>   	mp_state.mp_state = 0;
> 

