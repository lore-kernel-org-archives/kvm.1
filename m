Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98212269D18;
	Fri, 28 Aug 2026 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884289; cv=none; b=g8rWU8hmvJ8ogt6bnSbkOalLg6+TlGxiIRVvEBt0BPNQEovXoeQVuxE89ZcryeuRa6Pk5BSFi63wYmsAOsAYKSIK0lt/Kv6jfd5MaKqYUpK7yRmI/MIF23+FJsJo+qmhq596Rn5EmyQg9eagG8ySKUspvwwYY/Mt5vG57iDMj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884289; c=relaxed/simple;
	bh=AmiWvQK4BjI6lzNZRrFr0LIfvy0ZFnT1ZUrg4z7d7Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSxVFtIgsII2v+qxEW+RagGk2g027GERuBz9enVqM94E2E7SziFaefLTzvqIuv3vN9xueh4MxebNnaUcAf4CuDUy+5qpHxXjbcfBSBK57RL7cWtBHYzTkC4gf8c7j4sjC2ieH2pNVGAvAsQWNWyVd49yRUNVBJyDAVVF8tafwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqDyjhTi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqDyjhTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787884287; x=1819420287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AmiWvQK4BjI6lzNZRrFr0LIfvy0ZFnT1ZUrg4z7d7Vc=;
  b=BqDyjhTiThYleq1oUr11ehq4QgOeL0hxsgCjPnmdv2DmZuzPIROywhL6
   TGj5JT1s/KIq+ogq7ZRQ3uGh8gH2AIWgwqDVO+HpjQd98b7w+uDV4/38z
   EQZPfWpfVSb+kM5vA2woehTPqJc2oDXMCSW0oNHe9It4Xsv71tVZ52+ee
   qkd0krWSv3sd3ks+rksxFPhJD03Ef+Q0ahbhwZnDYIowzvigx2XAB3iqQ
   3nBi837vnx79LZo9d89DSyDihBrrImwLkFycztgdbgxX+tgiDW6q3ZAUx
   7iknEQOM4V39lrtjfXZUaQm0GjS56xR0tyAZcLO9A8+9Mcrw1G4W7aGcO
   A==;
X-CSE-ConnectionGUID: V/ODj2O4RsKIdExRhewtPg==
X-CSE-MsgGUID: E5x249wHRd2BUDQTLAV0EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88268023"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88268023"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 19:31:26 -0700
X-CSE-ConnectionGUID: vqL3zOR/R32niEzjQE5kCA==
X-CSE-MsgGUID: F34iZPKWSFatSuLeRGc7VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="292851178"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 19:31:19 -0700
Message-ID: <b4cffa34-864d-4fd0-9fc7-a7d4514075b2@intel.com>
Date: Fri, 28 Aug 2026 10:31:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
To: Peter Fang <peter.fang@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
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
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
 <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
 <20260828020612.GF33657@pedri>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260828020612.GF33657@pedri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/2026 10:06 AM, Peter Fang wrote:
> On Mon, Aug 17, 2026 at 04:38:49PM +0800, Xiaoyao Li wrote:
>>> +
>>> +static u8 vm_type;
>>> +static gpa_t ucall_mmio_gpa;
>>> +
>>> +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>>> +{
>>> +	vm_type = vm->type;
> 
> vm_type is u8 but vm->type is unsigned long
> 
>>> +	sync_global_to_guest(vm, vm_type);
>>
>> It works and it looks simple. But we have the architectural approach to test
>> if a guest is TD guest, by checking the CPUID 0x21.
>>
>> Since checking CPUID 0x21 is not complex, and as a bonus it can help test if
>> TDX module behaves correctly for CPUID leaf 0x21, I think we should switch
>> to use CPUID 0x21 to check if it is TDX VM in guest code?
> 
> Hmm... This makes me wonder if vm->arch.s_bit below could be replaced
> with the same architectural approach. GPAW is available through
> TDG.VP.INFO or the initial RBX value. This does require a bit more
> plumbing though.

I'm afraid not. Because below is host code, and vm->arch.s_bit is not 
used in guest code.

Or are suggesting something like dropping the

	if (is_tdx_vm(vm)) {
		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
		sync_global_to_guest(vm, ucall_mmio_gpa);
	}

entirely and use below hardcoded value instead in guest code?

	UCALL_MMIO_GPA | 1 << (GPAW - 1)

>>
>>> +	if (is_tdx_vm(vm)) {
>>> +		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
>>
>> So the passed-in @mmio_gpa is not used. Why cannot use the mmio_gpa,
>>
>>    slot0->region.guest_phys_addr + slot0->region.memory_size
>>
>> chosen by __vm_create()?
> 
> Looks like this was discussed previously [1]. Maybe at least a comment
> here would help?

yeah. A comment surely will help.

> [1] https://lore.kernel.org/all/ajGaMb6Lrk3OS8B4@google.com/
> 
>>

