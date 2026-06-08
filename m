Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AB3A3826;
	Mon,  8 Jun 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905813; cv=none; b=navR1OORRWeJDP0tMKgoCrRT/KmeVVAkkCGtlzex++nRa9rI+nY66U0RZ6LF7bOfuz0k0AjqZDEhZTwjzVqkMybcsSYMUhX8gSsbDwYKRFPaLr9qcN6X6bjSHGbSpsAGiCYXt2nD73ya4RV7eaXLif0T6SzCekAYhUbopTYySZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905813; c=relaxed/simple;
	bh=lWOxm6TUe+DG9ihCJuhA3Y9rlGGk3r5B8BALzosQTT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sluJDXDcgs0pcLVfaaUNXn+nNd65z26WygK/E/4QHO6tHkfkxoJM/zUSssBhewvtPg2v6gD49gokiYKghu3rKmiSA6Gc9Dm8IXSrermQKHpqjPOi7SuwntKU2lZbh1jdiH66ZTzdiTw6C7AdTCzvj1F6wy40zr31BqsXj2bGx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bky4TLfV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bky4TLfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780905812; x=1812441812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lWOxm6TUe+DG9ihCJuhA3Y9rlGGk3r5B8BALzosQTT4=;
  b=bky4TLfVyiHfTCwaPyd5+EwfKae+dovif/JBHVMtDU/BQ2j0gZReB3pm
   sdkGy4Z66K14yhZviQmPhml6+A/M2Y1s20qaD8VFIa9iU9RqEf2UomlwQ
   /3YYB1+Y2HTSY0j+ERMolgqP709ptSGfP3JpOgA4WV5iUWtK2cxEuWRdq
   jRo61SIf2XEfFFYb9KniwNSYqfNI1aTsgUlrzIV+Sv9zgfs77XNnVLknn
   4ATM3TDAoU1Tuu1U3Ei0vfS8BU6TI9DOWqtIrcMHqLns82KRbTROrbS/1
   z2T22lii5N7HSKepQbiYXhozKPksakeDhvP8uO0H2A9t6AWI6R4hV9rkK
   Q==;
X-CSE-ConnectionGUID: a3D4ZPOwQCmXIj78uau3/Q==
X-CSE-MsgGUID: 13qDwj0XTZitwyFJHFdHdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85261201"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="85261201"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:03:32 -0700
X-CSE-ConnectionGUID: DG8gH77kTXCi+6OfFkzb8g==
X-CSE-MsgGUID: hj9ON4Y/QsyZrIxnE+OQsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="243025774"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:03:26 -0700
Message-ID: <eab3711d-c5b1-4132-92e4-7f7040fcd17b@linux.intel.com>
Date: Mon, 8 Jun 2026 16:03:23 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 13/22] KVM: selftests: Set first memory region as
 shared if guest_memfd
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
 <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/2026 7:16 AM, Lisa Wang wrote:
> Set the initial state of the first memory region as shared if it is
> backed by guest_memfd, so that the KVM selftest framework functions can
> populate mmap()-ed guest_memfd memory the same way memory from other
> memory providers are populated.
> 
> For CoCo VMs, pages that need to be private are explicitly set to
> private before executing the VM.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 9a29540fff40..1bab7d76a59c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -484,8 +484,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
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
> @@ -495,14 +497,16 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>  	vm = ____vm_create(shape);
>  
>  	/*
> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
> +	 * initialize it as shared so the selftest framework can populate it
> +	 * exactly like other memory providers.
>  	 */
> -	flags = 0;
> -	if (is_guest_memfd_required(shape))
> +	if (is_guest_memfd_required(shape)) {
>  		flags |= KVM_MEM_GUEST_MEMFD;
> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> +	}
>  
> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);

The build failed due to this:

lib/kvm_util.c: In function ‘__vm_create’:
lib/kvm_util.c:507:9: error: too many arguments to function ‘vm_mem_add’
  507 |         vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
      |         ^~~~~~~~~~
In file included from lib/kvm_util.c:9:
include/kvm_util.h:714:6: note: declared here
  714 | void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
      |      ^~~~~~~~~~
lib/kvm_util.c: At top level:
cc1: note: unrecognized command-line option ‘-Wno-gnu-variable-sized-type-not-at-end’ may have been intended to silence earlier diagnostics

It seems the patch set doesn't wire gmem_flags parameter to vm_mem_add().

>  	for (i = 0; i < NR_MEM_REGIONS; i++)
>  		vm->memslots[i] = 0;
>  
> 

