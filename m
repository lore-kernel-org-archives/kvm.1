Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6413446B0;
	Tue, 18 Aug 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041086; cv=none; b=CGFkU7PjgLGuwqo6PgAHNx+4qoufbxAwm3ecXffULhkDeAEe09B9o6KSpaG/ee2I8vgAClF0srSYNqu1aG7t9QyhjX8YSVJF3afFH9UpT6OoJBcrw+SUsLylCbonHL0tCFIWmiSRT4bVQvBBUCagXGg88ZXhtegqe+lYe62Show=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041086; c=relaxed/simple;
	bh=fzBs/v2lX6bjtMxVASfa3Y/bIx0O7kOhrBTzv/t/o9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoWKxWu35ZjG1Q4Rw/jTuOfoP8/OOnYwLi7zu5pvrZNWI/Mkta3bELDZbOTgizsLh0b/H1z/4wQJQk3fb/MIbYDrNap4Qwbpbeac64E6lwCmhoEIDyOuuNYUmhJfxS3axhuCKqJ1Src//Vpl7RoPnsLsxOJ/WS1JuGosucQV34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUzkCRBh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUzkCRBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787041085; x=1818577085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fzBs/v2lX6bjtMxVASfa3Y/bIx0O7kOhrBTzv/t/o9Q=;
  b=QUzkCRBhF+vNSf0pvJ8JMQvRyf2CTA0yzdbo6glYMmNp4slobhqxYJSR
   1ViOkRxvHz+TjGDennOxn3CRMMk28lc+/CfkxOv9Fji8hQ/XOGB1yTq88
   QuBimZtk0ahqwN68zQm38VBeUUTqIJgZtRkO6qBNdKex5i31qktufQmnx
   /46JaDPLjGONYIm5CZ4JqQAr7TGpIxty/yNcolQ/jYMXaBg75pWftD3Y5
   IL5ryH861o6G9nZQcSG2Vc+1gv4JbSDf/xRdVZUwGiFZryeqbNAzWeosO
   KOadQh9iS+5uv0oXZp1BUqGrC925flienCYc15GbUnZutmV0VNFRNNueR
   w==;
X-CSE-ConnectionGUID: E90ld30xS96aUGEXYOrUeQ==
X-CSE-MsgGUID: aFR/hc7FSHm/qs+LODiJpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91208464"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91208464"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:18:05 -0700
X-CSE-ConnectionGUID: GW7Uc7aNSUmptCHDM+hl0Q==
X-CSE-MsgGUID: I4skbCsrQlWraST++Eojdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="258946082"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:17:59 -0700
Message-ID: <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
Date: Tue, 18 Aug 2026 16:17:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place
 conversion
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
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260722-tdx-selftests-v14-13-15ad654a50db@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2026 7:13 AM, Lisa Wang wrote:
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 4a48c4b42095..e547ea341ff7 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -484,8 +484,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>   	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>   						 nr_extra_pages);
>   	struct userspace_mem_region *slot0;
> +	u64 gmem_flags = 0;
>   	struct kvm_vm *vm;
> -	int i, flags;
> +	int flags = 0;
> +	int i;
>   
>   	kvm_set_files_rlimit(nr_runnable_vcpus);
>   
> @@ -495,14 +497,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>   	vm = ____vm_create(shape);
>   
>   	/*
> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
> +	 * initialize it as shared if in-place conversion is support, so the
> +	 * selftest framework can populate it exactly like other memory
> +	 * providers.
>   	 */
> -	flags = 0;
> -	if (is_guest_memfd_required(shape))
> +	if (is_guest_memfd_required(shape)) {
>   		flags |= KVM_MEM_GUEST_MEMFD;
> +		if (kvm_has_gmem_attributes)
> +			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
> +				      GUEST_MEMFD_FLAG_MMAP;
> +	}
>   
> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
> +		   -1, 0, gmem_flags);
>   	for (i = 0; i < NR_MEM_REGIONS; i++)
>   		vm->memslots[i] = 0;

IMO, this diff belongs to the gmem in-place series.
