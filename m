Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D739DBE5;
	Mon, 12 Oct 2026 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781691; cv=none; b=fkpzLDmedH0AiU3exsXuGHUdYpTYhBQAE8w4kxOc3aSiNiGBy3IYMY0tmxnClZRBtHGcLFztaPGyD7/2dGNDC9TEhROJ/lZ43GyIlJ03VF9DsyCSzM8No6+upNaGjA0Odz3DIxmGPu7PGz/Vcr1MKrgSBllKJpplAGIAlcQ7AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781691; c=relaxed/simple;
	bh=K+knay5Iz8E3ciwKAf777y2Zx+awC/so3KBEGtn46Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4zrAgMdxux16JlTNXbciAet4L/utEa5BShnOOpD7Kc3nNTZNagOxPj5RtMqdacDhH8fe+9Yy10l3ZHBV6bqXRvAHwk/2l0DbCir4W0lJrBZvFI1l7UdB9NynoGg3MFHszSkXxhGmXRaoIzjH9lCB/oQLzuKC6/G+7OJcOSaLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfShpwnp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfShpwnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791781690; x=1823317690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K+knay5Iz8E3ciwKAf777y2Zx+awC/so3KBEGtn46Pc=;
  b=UfShpwnpWNEvKEGLkwcgLSRm1lJq6u8K1ANjZbnOBIwQLJC8aJn8cDrN
   6HwDqE/C9Jw+Os2tQSkzAE0OJJ6TBD3NVJG8Vdpf3W+Hvs2rxJx77OnXi
   OPaDLwH2ak21rjDcwc0N+z2bpkuonkMDftVY7mSqXL9zAd45JN7eWoEmj
   OddkMPEZ3Rozg724ciekZYVG6TDvtNzU0gsNB9U1c+f7nMpBlHLcrFnVx
   i390uagq23XuS+sRkO/99aAE9VjPTv+Xd4kaBRBNNzhtH9ebahCS/7Twq
   0EB6LPrhVjxCW8FExsJ53/rDV6Tvagr2Nx8VL6fmMv5hxJ0k9ZISXJsB0
   A==;
X-CSE-ConnectionGUID: 9PBV1l1ZTMCki0pL6Zr8dg==
X-CSE-MsgGUID: BJDBEXISQNGNJYCfxzvCBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="473586"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="473586"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 22:08:09 -0700
X-CSE-ConnectionGUID: Wa/IBWVMTyCjQ17JLx1EDA==
X-CSE-MsgGUID: qvRab8M/RaeQikEe9gqBTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="736169"
Received: from unknown (HELO [10.238.3.65]) ([10.238.3.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 22:08:01 -0700
Message-ID: <e32bd731-454a-4152-b13f-2d6e8c57d90f@intel.com>
Date: Mon, 12 Oct 2026 13:07:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/23] KVM: selftests: Support guest_memfd in-place
 conversion
To: Binbin Wu <binbin.wu@linux.intel.com>, Lisa Wang <wyihan@google.com>
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-13-7c62a5d8a992@google.com>
 <4d57c0f7-5ed9-4a1f-b401-a1072af5dd6c@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <4d57c0f7-5ed9-4a1f-b401-a1072af5dd6c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2026 11:32 AM, Binbin Wu wrote:
> On 10/2/2026 3:37 AM, Lisa Wang wrote:
>> With guest_memfd in-place conversion, the memory region can be set as
>> shared, eliminating the need for dual-backed memory.
>>
>> By setting the region to shared initially, the KVM selftest framework
>> can populate the mmap()-ed guest_memfd memory just like any standard
>> memory provider.
>>
>> For CoCo VMs, pages that need to be private are explicitly set to
>> private before executing the VM.
>>
>> Signed-off-by: Lisa Wang <wyihan@google.com>
>> ---
>>  tools/testing/selftests/kvm/lib/kvm_util.c         | 20 ++++++++++++++------
>>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c |  6 +++++-
>>  2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 7625908caf21..f474664b5d92 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -494,8 +494,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>>  	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>>  						 nr_extra_pages);
>>  	struct userspace_mem_region *slot0;
>> +	u64 gmem_flags = 0;
>>  	struct kvm_vm *vm;
>> -	int i, flags;
>> +	int flags = 0;
>> +	int i;
>>  
>>  	kvm_set_files_rlimit(nr_runnable_vcpus);
>>  
>> @@ -505,14 +507,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>>  	vm = ____vm_create(shape);
>>  
>>  	/*
>> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
>> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
>> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
>> +	 * initialize it as shared if in-place conversion is supported, so the
>> +	 * selftest framework can populate it exactly like other memory
>> +	 * providers.
>>  	 */
>> -	flags = 0;
>> -	if (is_guest_memfd_required(shape))
>> +	if (is_guest_memfd_required(shape)) {
>>  		flags |= KVM_MEM_GUEST_MEMFD;
>> +		if (kvm_has_gmem_attributes)
>> +			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
>> +				      GUEST_MEMFD_FLAG_MMAP;
>> +	}
>>  
>> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
>> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
>> +		   -1, 0, gmem_flags);
> This is common for both TDX and SNP, does it break SNP?

As I commented in the v14[1], I still believe this part belongs to gmem in-place
conversion series. Without this part, I think the SNP selftests will fail if
in-place conversion is enabled.

Ackerley, did you test SNP selftests?


[1] https://lore.kernel.org/kvm/f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com/
