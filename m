Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F1298CC4;
	Sat, 10 Oct 2026 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603169; cv=none; b=ds3PEd/QNd0kjCIW79I6FvVtqaAXLrYYR8B5eWsJ4a5VX1YjUZcTQt/kM1KAiwF6ckdhmhoZRKOqn2mJBegzW5yWKKHlxCPTd7gWOeEDmIEnYfB63gE3C275IopB6q+Y7HrTAeotbgsf96vLDCeWjr3Y+w1gQs8mqFsrWs4j4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603169; c=relaxed/simple;
	bh=L1xvLFtuvT5GKWDgJ3c/DJEPvPiVYnbScbik8/+g7n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jg/f8Fj9oYhqZl+GB4H1RCaYeCNuhqys+QXVgoRw8eqb7xhLB1DT+kne46fqDxf783sG7/NZTNDWB+gzAut+fGVw5aLZOKBG22heUsZ7+pflRojeUDfdWXd6ZMXmo6av0t0BAH+iWs8jYAeu9q1yHDz8OuUNpxHeJ+FBtEQ73EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuN+CprY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuN+CprY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791603169; x=1823139169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L1xvLFtuvT5GKWDgJ3c/DJEPvPiVYnbScbik8/+g7n0=;
  b=QuN+CprYDK1kgcGcRUFzSUPCPVlz/u6v9Tzf+e9NpCWS0ENHeYJeqJmK
   kl/XPB+jK3uy9jGKh01gKpOGEEzpAJlB0MTLOLyUIxneDrpiVYp6JP92O
   SxUptgCZU21KvS4bbFEQ6+Yp+Oyd35QgIrX/6CkJApzQ7lzl4Kz3NkvsR
   hK9Pm0tujlFYHvEMDWM6NUz6SwCQaLWAX3sWIlTLaV4zajij7kuvqUwDm
   2XbmJUOLAvmEHRzAlzauwoupzNI9otXN74Rh6iSqjV1QLewGE+AU1FFnQ
   6Y2TMCn7c7VGzJtY4q2vz0wEK0RAULZZYOrB1Voh6l/yrrd1GjwFw6Sw0
   w==;
X-CSE-ConnectionGUID: 5yvbENDaTWCn9BUJN7udOA==
X-CSE-MsgGUID: nkv2gRXGRI+OoqfqqEtBAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="404479"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="404479"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:32:48 -0700
X-CSE-ConnectionGUID: 3lYJoxIFQmKA4unwBVQFlg==
X-CSE-MsgGUID: h4ITtYXwQ3OYJZS+UVq/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2199563"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:32:42 -0700
Message-ID: <4d57c0f7-5ed9-4a1f-b401-a1072af5dd6c@linux.intel.com>
Date: Sat, 10 Oct 2026 11:32:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/23] KVM: selftests: Support guest_memfd in-place
 conversion
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
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-13-7c62a5d8a992@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261001-tdx-selftests-v15-13-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 3:37 AM, Lisa Wang wrote:
> With guest_memfd in-place conversion, the memory region can be set as
> shared, eliminating the need for dual-backed memory.
> 
> By setting the region to shared initially, the KVM selftest framework
> can populate the mmap()-ed guest_memfd memory just like any standard
> memory provider.
> 
> For CoCo VMs, pages that need to be private are explicitly set to
> private before executing the VM.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c         | 20 ++++++++++++++------
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c |  6 +++++-
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 7625908caf21..f474664b5d92 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -494,8 +494,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>  	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>  						 nr_extra_pages);
>  	struct userspace_mem_region *slot0;
> +	u64 gmem_flags = 0;
>  	struct kvm_vm *vm;
> -	int i, flags;
> +	int flags = 0;
> +	int i;
>  
>  	kvm_set_files_rlimit(nr_runnable_vcpus);
>  
> @@ -505,14 +507,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>  	vm = ____vm_create(shape);
>  
>  	/*
> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
> +	 * initialize it as shared if in-place conversion is supported, so the
> +	 * selftest framework can populate it exactly like other memory
> +	 * providers.
>  	 */
> -	flags = 0;
> -	if (is_guest_memfd_required(shape))
> +	if (is_guest_memfd_required(shape)) {
>  		flags |= KVM_MEM_GUEST_MEMFD;
> +		if (kvm_has_gmem_attributes)
> +			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
> +				      GUEST_MEMFD_FLAG_MMAP;
> +	}
>  
> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
> +		   -1, 0, gmem_flags);

This is common for both TDX and SNP, does it break SNP?


>  	for (i = 0; i < NR_MEM_REGIONS; i++)
>  		vm->memslots[i] = 0;
>  
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index e348507a6be8..40ee9b1951c2 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -23,6 +23,8 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
>  	gpa_t gpa;
>  	u8 *hva;
>  
> +	if (kvm_has_gmem_attributes)
> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
>  	vm_mem_add(vm, VM_MEM_SRC_SHMEM, alloc_gpa, TD_BOOT_CODE_SLOT,
>  		   nr_pages, KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
>  
> @@ -44,9 +46,11 @@ void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpu
>  	size_t boot_params_size = sizeof(struct td_boot_parameters) +
>  		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
>  	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> -	const u64 gmem_flags = 0;
> +	u64 gmem_flags = 0;
>  	gpa_t gpa;
>  
> +	if (kvm_has_gmem_attributes)
> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
>  	vm_mem_add(vm, VM_MEM_SRC_SHMEM, TD_BOOT_PARAMETERS_GPA,
>  		   TD_BOOT_PARAMETERS_SLOT, npages,
>  		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> 

