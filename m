Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8A43E49B
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904636; cv=none; b=sLUDf/P6zDoQgzF+ry+K9o/3C1f5Vq1OoybwDzOIbQ2NNEaNGATCjgoMWumL5tJc+TYPpmbYzHvCVJFQfP08pFJqshK1lkLy86r1xD8Fe0G8+wGiAnCBnDrH7QhysOw7T+91U60ej11IIs9SeP5qsiSZ/leSRCNfw1MJ9YAX/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904636; c=relaxed/simple;
	bh=x1xPAWVqmFFpSPA+VakWzfc+aEye5SR14V9oZ2uueRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJVwrCOqqciGdIlK4P5+WK3v26y24Pcmy6PWMhpugjxq9ywpOANH6/7m017DFdQe+oshHdg34gpsVfh8ns/HS8NEE9U87v+j/K0s+CYkuFrBp3CAC45S6SrJWbzeXLXzIc0xdlCRooPpCrkMA7LR2IdXXBzW9TsWrPkdzC7diEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbqk7s0d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbqk7s0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782904634; x=1814440634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x1xPAWVqmFFpSPA+VakWzfc+aEye5SR14V9oZ2uueRw=;
  b=bbqk7s0d8Pg9Pl8TklJIA7fnXp8ERBI5gQMtZdEFDW1vXEKPTR9/VkZf
   Y06ZjiVJ36DEyM5MRwZdoqkINH10gytr9oCrqwyDGXANstYjPLm8Bgqnk
   LrusVLKhkjnDFtq5wg8Nk9f8gCHMxtVb+giYkVy3US2O9G16KYt8ifhZ5
   8ZAx9AoK+bvIPOKY/FQ7yqR1UBpraB0p/eDiM0VLz3Bj+Kx2O4XGrUsGA
   OqvJnYlwzHYhl81QFSvoagfmE36wu07ZH2VvKFqg+fto9M9M/WYmHquE/
   9CZe75JHWl0Xu8oAwDct5O/nOBLR04z0/Aho2+jg+nfHJapf2X1HfTzkW
   Q==;
X-CSE-ConnectionGUID: apXh6jxESrKrrRDoEZLodw==
X-CSE-MsgGUID: au4ICM1eSgW788X0vLplww==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87315783"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87315783"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:17:14 -0700
X-CSE-ConnectionGUID: vOBjFhP5QZCQJfdQOLC84A==
X-CSE-MsgGUID: h1p8aTixQAajmMnrAJe8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="248076056"
Received: from unknown (HELO [10.239.158.49]) ([10.239.158.49])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:17:12 -0700
Message-ID: <affe09f7-31bd-4d86-906c-9c6f92eb903a@intel.com>
Date: Wed, 1 Jul 2026 19:17:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the
 default
To: Ackerley Tng <ackerleytng@google.com>, sashiko-reviews@lists.linux.dev,
 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <20260619005856.09DD81F000E9@smtp.kernel.org>
 <CAEvNRgE6iKBhMYM64rgvuVEOvAFyNoryzpjTtSQRf5TcrLTepA@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgE6iKBhMYM64rgvuVEOvAFyNoryzpjTtSQRf5TcrLTepA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/25/2026 7:47 AM, Ackerley Tng wrote:
> sashiko-bot@kernel.org writes:
> 
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] Unprivileged userspace can trigger a WARN_ON_ONCE if the host administrator misconfigures a module parameter.
>> --
>>
>> commit bf8cb04a544d7b8235d73034e0febf195ab335c3
>> Author: Ackerley Tng <ackerleytng@google.com>
>>
>> KVM: guest_memfd: Make in-place conversion the default
>>
>> This commit makes in-place conversion the default when the architecture
>> supports private memory. It introduces a module parameter to override the
>> default and adds a warning in the CoCo VM memory population path if in-place
>> conversion is disabled without enabling per-VM memory attributes.
>>
>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>> index 86c9f5b0863cb..5cb73543c03c8 100644
>>> --- a/virt/kvm/guest_memfd.c
>>> +++ b/virt/kvm/guest_memfd.c
>>> @@ -1193,10 +1193,15 @@ static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
>>>   {
>>>   	struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
>>>
>>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>>   	if (!gmem_in_place_conversion)
>>>   		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>> +#else
>>> +	if (WARN_ON_ONCE(!gmem_in_place_conversion))
>>> +		return false;
>>> +#endif
>>
>> [Severity: Medium]
>> Could this WARN_ON_ONCE() be triggered by unprivileged userspace if the
>> administrator misconfigures the module parameter?
>>
>> If the system administrator sets kvm.gmem_in_place_conversion=0 on a kernel
>> compiled without CONFIG_KVM_VM_MEMORY_ATTRIBUTES, it appears this warning can
>> be reached from an unprivileged ioctl path calling kvm_gmem_populate().
>>
>> Since an unprivileged user creating a CoCo VM can intentionally trigger this
>> warning, could this act as a host-side denial of service on systems configured
>> with panic_on_warn=1?
>>
>> Would it be better to convert this to a pr_warn_once()
> 
> Sean, what do you think of using pr_warn_once()?

How about don't expose the module param when 
CONFIG_KVM_VM_MEMORY_ATTRIBUTES=n? something like:

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -103,7 +103,9 @@ module_param(allow_unsafe_mappings, bool, 0444);

  #ifdef kvm_arch_has_private_mem
  bool __ro_after_init gmem_in_place_conversion = 
!IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  module_param(gmem_in_place_conversion, bool, 0444);
+#endif
  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
  #endif


>> or perhaps validate the
>> module parameter at initialization time?
> 
> I thought about this too, but didn't want to move it to initialization
> time because this (populate) is probably the first time the kernel
> knows for sure something is used weirdly.
> 
> Like, perhaps the admin did compile without
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES and also set gmem_in_place_conversion=0
> but wants to use the host only for non-CoCo VMs and hence doesn't need a
> warning, idk.
> 
>>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com?part=24
> 

