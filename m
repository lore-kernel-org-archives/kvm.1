Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B503DA5C3;
	Wed, 24 Jun 2026 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315827; cv=none; b=nzqpMuFyo8hue78gwIEjiTGmaFM5vdptd+sAWZzmoTmjkvvrjP5KEH5Ej4NIsw/VarcuoElF9nqIB9sK4W5pugJgGtTrhOcEvZHm84IiqWHnsCamz4nkNtks0nNh6pivEO88mSgEvmfpK4GprNgoEzasNQVPMuZ+UKzr4mLfE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315827; c=relaxed/simple;
	bh=5YOuVHtOcSqCS6wcZuSBHTS4usorpWqZnTw19YeQUPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5timyMdUyZI35FTG/jP+8IBrr2GyfAnGNMdqFTKT3o3I8YJ4RgD1jKKX3ducFWXjG2+TvnkG3hyBtYj7x6kk+GxjPhFjNAxz5MtP0Elpezz/BbV2xfYNG8c/6QKtSKU99T9hkG5CGTBco5BgyMloc0bSVh4h3+Lg5ZFf86qeVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZG8bbzc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZG8bbzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782315824; x=1813851824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5YOuVHtOcSqCS6wcZuSBHTS4usorpWqZnTw19YeQUPg=;
  b=lZG8bbzcePErxkNYhnRV6P3WMVkl4E/0LCeJQe48yU0FgJKyQM46Di0C
   sdERm8Bmob2PxKB8WEPg0t/7jeFYk6llMIkjGN1ePQ2V7ithftCQFGbll
   wjZk0rhsqF7wIccUhMjZdOBC7kgDLvhT+6GC5qGevnmAgoEowkY9VnFbq
   DDQyRrOeh7Inb3nwN//9wC40p2mWoNsCdEpk6eGFFmrS+CH+fLj6PYcHE
   h5acF3ZMPDqDLWiDezzzGfhx+zy4O9IwIPy+Re3xRyZXavAeqHZ0XF6Eu
   zJYl8CqGszidwjmiWCrig9VIgHOubz5mn2VODCxufh8r4psXIks5152II
   g==;
X-CSE-ConnectionGUID: SI3+IOWPR+6Pxo338I9cWQ==
X-CSE-MsgGUID: 4snxtVNaTiecuLKh2EvErg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93442444"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="93442444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 08:43:43 -0700
X-CSE-ConnectionGUID: ewQvxYfZQtGiPvo02jLRKQ==
X-CSE-MsgGUID: vsG9ZIE/RFyuWOMq8tB0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="251876562"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 08:43:38 -0700
Message-ID: <f8937d16-4aed-44d9-a058-beff56eac4ad@intel.com>
Date: Wed, 24 Jun 2026 23:43:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 13/22] KVM: selftests: Set first memory region as
 shared if guest_memfd
To: Ackerley Tng <ackerleytng@google.com>, Lisa Wang <wyihan@google.com>,
 Andrew Jones <ajones@ventanamicro.com>, Binbin Wu
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
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
 <CAEvNRgEBiivp9tOHZnFmWvF6ek-Ar-m2B+hb=-H0dgAcM2=z8Q@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgEBiivp9tOHZnFmWvF6ek-Ar-m2B+hb=-H0dgAcM2=z8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/2026 7:46 AM, Ackerley Tng wrote:
> Lisa Wang <wyihan@google.com> writes:
> 
>> Set the initial state of the first memory region as shared if it is
>> backed by guest_memfd, so that the KVM selftest framework functions can
>> populate mmap()-ed guest_memfd memory the same way memory from other
>> memory providers are populated.
>>
>> For CoCo VMs, pages that need to be private are explicitly set to
>> private before executing the VM.
>>
>>
>> [...snip...]
>>
>> @@ -495,14 +497,16 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>>   	vm = ____vm_create(shape);
>>
>>   	/*
>> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
>> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
>> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
>> +	 * initialize it as shared so the selftest framework can populate it
>> +	 * exactly like other memory providers.
>>   	 */
>> -	flags = 0;
>> -	if (is_guest_memfd_required(shape))
>> +	if (is_guest_memfd_required(shape)) {
>>   		flags |= KVM_MEM_GUEST_MEMFD;
>> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>> +	}
>>
> 
> Just noticed this while hacking some SNP tests.
> 
>> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
>> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
>>   	for (i = 0; i < NR_MEM_REGIONS; i++)
>>   		vm->memslots[i] = 0;
>>
>>
>> --
>> 2.54.0.746.g67dd491aae-goog
> 
> I think this patch should fully buy into in-place conversions, so we
> need to also set GUEST_MEMFD_FLAG_MMAP:
> 
> @@ -483,6 +483,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape,
> u32 nr_runnable_vcpus,
>   {
>   	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>   						 nr_extra_pages);
> +	enum vm_mem_backing_src_type src_type = VM_MEM_SRC_ANONYMOUS;
>   	struct userspace_mem_region *slot0;
>   	u64 gmem_flags = 0;
>   	struct kvm_vm *vm;
> @@ -503,10 +504,16 @@ struct kvm_vm *__vm_create(struct vm_shape
> shape, u32 nr_runnable_vcpus,
>   	 */
>   	if (is_guest_memfd_required(shape)) {
>   		flags |= KVM_MEM_GUEST_MEMFD;
> -		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;

GUEST_MEMFD_FLAG_INIT_SHARED is valid only when the memory attributes is 
per-gmem.

we need to check KVM_CAP_GUEST_MEMFD_FLAGS or kvm_has_gmem_attributes.

