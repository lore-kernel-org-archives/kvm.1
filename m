Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EB38D3F7;
	Tue, 18 Aug 2026 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038431; cv=none; b=eQ460QZ8hbqxMzX641mwByJSH5/kYMTINZzU44yuACcmUVGx85r5dXhbb+DHqtbffW1q18kmuED6RjY7IpRoee3nLkiu0Lhn5bkPslUQqoa+lsc0s3CJvoSJeazopjmWUQKGjIT3n76T6qhgmpkxKR/QLmMISPDKbCXqawym96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038431; c=relaxed/simple;
	bh=+Ez1C771ix9X3B8jwdeUYBhWqwriYoHlS+4Fq7dKDcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfj4ZyPZdMsrblinefMJuNIbQsEDCytBHhgirhfTTMAWKyHt0aTIHIW+GpCIfTDqgnlQKfySbAacApXa7wKHFN+vJfOUf3+toDRuBhjrlMQvOc66Qw3VKJQaWGkiv3tqMsIts8spylhd1E97xWMXyxWXxl8gS2B8GH6jTMGiYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaNLCSM3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaNLCSM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787038430; x=1818574430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Ez1C771ix9X3B8jwdeUYBhWqwriYoHlS+4Fq7dKDcc=;
  b=BaNLCSM3uL6MWDHNbaFzR+gh6xcfv3ln0xmdJwJ253M/hBX1nIiBmTnI
   pTR/mJeAvGzPe5dTHHtXp/wLh5I01TCpdFpECifwYy0yO2Yd8q7JZ4+gy
   EJWObQ2octkXKnW6aqkPXeX/zhtpm1JV9+55KKK5gTt/rkf4n5sqYn/T0
   GGUEgohJD1HgjM9/BpBwmhfSk9MWBS6brYVFilkuAyVIxTM53Xqxz8ahn
   jnOXsv+o598UrWtKCEFXOBVeH842NCsKhSRrpaKMhiZnHBTzEiUzbM7QW
   snTFbwvL+s3wLTjHYhq7I6jru53y4fjUn/XeZSTnyl+2EUT4JatoWGPuB
   g==;
X-CSE-ConnectionGUID: 5BxGhGN1TGWjCX7g2gazbw==
X-CSE-MsgGUID: XfygqeULR9GNt8A3DkN22A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87285058"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87285058"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:33:49 -0700
X-CSE-ConnectionGUID: hFEGvi6nSWyAs8kPKAIkcg==
X-CSE-MsgGUID: 3fvu30GSSkeeLmpl6H/Txg==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:33:42 -0700
Message-ID: <e5cefe2e-5cde-45c5-8d28-e64b434a0c2e@intel.com>
Date: Tue, 18 Aug 2026 15:33:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/22] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
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
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-18-15ad654a50db@google.com>
 <befe73e1-3287-440e-90de-6c62f6c19d47@intel.com>
 <CAEvNRgH00s3NWUH8EGUZq3WWweboBcUaTZs_0Cye5D=3o0OALQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgH00s3NWUH8EGUZq3WWweboBcUaTZs_0Cye5D=3o0OALQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/2026 9:52 PM, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>>
>> [...snip...]
>>
>>> +static void tdx_load_private_memory(struct kvm_vm *vm)
>>> +{
>>> +	struct userspace_mem_region *region;
>>> +	int ctr;
>>> +
>>> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
>>> +		const struct sparsebit *protected_pages = region->protected_phy_pages;
>>> +		const gpa_t gpa_base = region->region.guest_phys_addr;
>>> +		const u64 hva_base = region->region.userspace_addr;
>>> +		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
>>> +		void *source_pages = NULL;
>>> +		sparsebit_idx_t i, j;
>>> +
>>> +		if (!sparsebit_any_set(protected_pages))
>>
>> sparebit_any_set() doens't check if the input is NULL. So we need to
>> check it here.
>>
>>> +			continue;
>>> +
>>> +		TEST_ASSERT(region->region.guest_memfd != -1,
>>> +			    "TD private memory must be backed by guest_memfd");
>>> +
>>> +		sparsebit_for_each_set_range(protected_pages, i, j) {
>>> +			const u64 size_to_load = (j - i + 1) * vm->page_size;
>>> +			const u64 offset =
>>> +				(i - lowest_page_in_region) * vm->page_size;
>>> +			const u64 hva = hva_base + offset;
>>> +			const u64 gpa = gpa_base + offset;
>>> +
>>> +			if (!kvm_has_gmem_attributes)
>>> +				source_pages = (void *)hva;
>>> +
>>
>>> +			vm_mem_set_private(vm, gpa, size_to_load);
>>
>> So vm_mem_set_private() has to be called at this late stage when run
>> with in-place gmem. But for non in-place gmem, we can actually call
>> vm_mem_set_private() in __vm_phy_pages_alloc().
>>
>> Calling vm_mem_set_private() here instead of in __vm_phy_pages_alloc()
>> looks like a trick to me.
> 
> I thought this is fine because __vm_phy_pages_alloc() seems to be a
> rather low-level function, where the responsibility of the function is
> just to allocate (for find some physical pages). Calling
> vm_mem_set_private() in there seems to be doing too much.

__vm_phy_pages_alloc() takes a parameter @protected, which is used to 
tell the allocated physical pages need to be protected(private) or not.
It looks weird that a page is allocated as protected but actually it is 
still shared.

>> That is, we cannot set the page as private
>> when allocating a guest physical page as protected because if doing so,
>> we cannot write the initial content to it.
>>
> 
> I think calling it here isn't a trick, it's a good way to reuse all the
> existing code that builds up the guest image in place. In-place
> conversion allows you to set stuff up in shared memory and then convert
> everything when you're done and also populate the memory.

This is based on the assumption of "in-place conversion". However the 
TDX selftests should be able to run without "in-place conversion". There 
is no hard dependency on it.

I think this patch implements what patch 13[1] of this series says "For 
CoCo VMs, pages that need to be private are explicitly set to private 
before executing the VM."

But all of this is for the case of "in-place conversion". When "in-place 
conversion" is not supported/enabled by the kernel, 
GUEST_MEMFD_FLAG_INIT_SHARED for Coco VMs is *not* allowed and all the 
memory are private by default and no need to call vm_mem_set_private() 
here at all.

[1] 
https://lore.kernel.org/all/20260722-tdx-selftests-v14-13-15ad654a50db@google.com/

>> This is the topic about how to implement the infras for in-place gmem,
>> not the issue of this series. Let me go read the selftest patches of
>> gmem in-place series and we can discuss there.
>>
>>> +			tdx_init_mem_region(vm, source_pages, gpa, size_to_load);
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +void tdx_vm_finalize(struct kvm_vm *vm)
>>> +{
>>> +	tdx_load_private_memory(vm);
>>> +	tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
>>> +}
>>>

