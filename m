Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995F492507;
	Wed,  1 Jul 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912989; cv=none; b=FOguTGBH2yf+8kw5WgJx9gfua99ZndRNAUlLttPLqcg+wdxDAgIJaPCpm93IXYttFR4kX76rt71nTSN3dzMsiXaKWQZ3hTEPfva9WJ5IZBN8IJ0EIVIlkNwLCRKMal/AoU5h8tb2UZKvWmq97qG5bHljV6RijhO4J3e8UxSEiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912989; c=relaxed/simple;
	bh=kj8tVAMeyk2zaR0NgWiJc61AewxzrxHInMMw+uxN4yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTmDIy6VO+hIuctCTYyP/dgI5TWlRxfj77+IXM0dYReWWVvPqHJuDGRCYsahKwwfUAMAWL48Ti9JXVTM62qmMBWFguuhgC3Y1wLYoJlrEPYW1hS+3DrEpcB2I4BdnRRDzuP9OW7U4deoT1To/NlvhZzzpCd0+3XC7VCa0aJJbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6uV0JT5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6uV0JT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782912986; x=1814448986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kj8tVAMeyk2zaR0NgWiJc61AewxzrxHInMMw+uxN4yE=;
  b=T6uV0JT5b3ZMcCiBRUQ9GVZzCFZCQ1aNjHGeYnaTKo5zAYrFCQ9fIM01
   h6h2de9aN320b69eHvSjfYO4XHOiGJKK18UlEWfkhF4Hs/Cwzo0IGH4ZN
   sJgvOixwyDJZB9mzjkcRa/g7jnont94L8d9EGHy5G0VRNbrfFWUVe2Dt6
   KsYCh+Irx5R9jk0G0Db+Vvq1m+IoycLIMaxibau+ewlWBOe3ijrZijwuL
   3+EXmeHCzHS2dccOzv7Y0hT5eQ7MIyQzrKigohkKWFEfMINu87N2AAbV1
   bB+P8ysE3izUfvJS1KJJ+t/dljzd4ZvjB7poX7yCualHw/ah/zRP6+L9L
   Q==;
X-CSE-ConnectionGUID: EWnkm5C1SaK2jq1ha+4vVg==
X-CSE-MsgGUID: o43ckQgBQru8c7v5OIrlZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83517676"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83517676"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:36:25 -0700
X-CSE-ConnectionGUID: 1lEryM2mToWTiZ6o+ouDzw==
X-CSE-MsgGUID: n+BqvtQaR46j02XAnkeYnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="249205453"
Received: from meihao-mobl1.amr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:36:17 -0700
Message-ID: <81caa42d-9d07-4bed-892d-c24e0b298a1d@intel.com>
Date: Wed, 1 Jul 2026 21:36:14 +0800
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
 <f8937d16-4aed-44d9-a058-beff56eac4ad@intel.com>
 <CAEvNRgFLjt+-cO-XT0s8uW2xXgyd+VVZ0g0Os6V0+LBFQzx8cQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgFLjt+-cO-XT0s8uW2xXgyd+VVZ0g0Os6V0+LBFQzx8cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/2026 2:18 AM, Ackerley Tng wrote:
>>> I think this patch should fully buy into in-place conversions, so we
>>> need to also set GUEST_MEMFD_FLAG_MMAP:
>>>
>>> @@ -483,6 +483,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape,
>>> u32 nr_runnable_vcpus,
>>>    {
>>>    	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>>>    						 nr_extra_pages);
>>> +	enum vm_mem_backing_src_type src_type = VM_MEM_SRC_ANONYMOUS;
>>>    	struct userspace_mem_region *slot0;
>>>    	u64 gmem_flags = 0;
>>>    	struct kvm_vm *vm;
>>> @@ -503,10 +504,16 @@ struct kvm_vm *__vm_create(struct vm_shape
>>> shape, u32 nr_runnable_vcpus,
>>>    	 */
>>>    	if (is_guest_memfd_required(shape)) {
>>>    		flags |= KVM_MEM_GUEST_MEMFD;
>>> -		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>>> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
>> GUEST_MEMFD_FLAG_INIT_SHARED is valid only when the memory attributes is
>> per-gmem.
>>
> GUEST_MEMFD_FLAG_INIT_SHARED was introduced before guest_memfd in-place
> conversions, so I think it's orthogonal to whether memory attributes is
> per-gmem.

But before gmem in-place conversion, i.e., per-gmem attribute, 
GUEST_MEMFD_FLAG_INIT_SHARED is not supported/valid for Coco VMs.
>> we need to check KVM_CAP_GUEST_MEMFD_FLAGS or kvm_has_gmem_attributes.
> I think we do want to deprecate the non-in-place-conversions setup, so
> how about inserting a TEST_REQIRE(kvm_has_gmem_attributes) here?

Well, then all the TDX and SNP selftest will be skipped on the kernel 
with gmem_in_place_conversion=false.

I don't object it. But we still need to get Sean's answer.
