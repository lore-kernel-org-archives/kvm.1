Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361D30568D
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090430; cv=none; b=FI9kbU4NRQuSR2wv2Poidmtgjbht/uPgJVl2YLGefsW196UpZ0z0BNeTd3Oq/2LcARUwqwdVmoN+eVtnQ1TxgEOhXfRKXZgnSgJ2OFaNg1CD0I47cGYdLIsQzD5XC93cVKcekgonlpUQecG0E8tik+saNBJCQw1bCi0vm+Soick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090430; c=relaxed/simple;
	bh=5kJ2Go7AkLtFV2jFRRdtLJkmd6ieGvPNuDNh0ryIaMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iT2TLiu130btQuqcgni+hlE8gal8yryPfjqPby5zqEE8LNdmDtI/lGpsX39TFNW4foLAvlEGt0638SSlrPwb2LLfgtBBYhE20+85geIo9iiJmKxH2Gvo/a5PNuWlcbn0/hfFe7fQWcz9n5/dY7TRUDWNDmcUVJIt88NitNkDKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAJicJOh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAJicJOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779090428; x=1810626428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5kJ2Go7AkLtFV2jFRRdtLJkmd6ieGvPNuDNh0ryIaMY=;
  b=SAJicJOh81XLy+jKv+TswBhu9UOayg5p0M8S1bW4iwgq7x6V3Tdz4JVH
   qZzd8Bel6z9yvUV2gp1PFoJIPlHS8YHd6t1Kuip/+lra6x/HCHa+FYccu
   4uCWWCro+otaBiGv4DIenyEWCAYfxyKlZhV6o39n/u7V7ZMcUWrC+uPPf
   /utWJ5ZKymcJsGCJkFjJYNWULASzc/iu4YrE3QeWkTUJag4B0QT5WDVGk
   Kl9HfAaTlvamq6VuT1bzwkUlaq5OG6gn+HXf9pEfjZuV8dClahnSS0t78
   sMB6Fauod7/iA7gpVoCiBBnimbp3hnJZ5mj/Y1S/KQGey2Mw1Wj81uu2e
   w==;
X-CSE-ConnectionGUID: DkXLn/DvRg27W4/9gCZ1EQ==
X-CSE-MsgGUID: zY4SPyW+QmazbOPoYnf+Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90246139"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90246139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:47:08 -0700
X-CSE-ConnectionGUID: izV970MPTleKfVWY2Lx9kw==
X-CSE-MsgGUID: IXQYGeAsQ+yMv8V5JtwcIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244330469"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:47:06 -0700
Message-ID: <464f364c-0c5e-4457-a706-89d8629cdba9@intel.com>
Date: Mon, 18 May 2026 15:47:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 rick.p.edgecombe@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <c6d216fd-3ca5-4ee8-91d9-ffb088c72fa5@intel.com>
 <ec9a3882-4505-45f3-b7f8-634cca3a18ce@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ec9a3882-4505-45f3-b7f8-634cca3a18ce@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/2026 3:24 PM, Binbin Wu wrote:
> 
> 
> On 5/18/2026 9:38 AM, Xiaoyao Li wrote:
>> On 4/17/2026 3:35 PM, Binbin Wu wrote:
>>> Originally, we had issues on TDX when a new hardware feature, which is a
>>> host state clobbering feature, is supported by new TDX modules/platforms.
>>> A host state clobbering feature requires KVM to save and restore the
>>> feature's related MSR(s) on host/guest transitions; otherwise, if the
>>> feature is used by TDs, the host state will be corrupted, leading to
>>> unexpected behavior on the host.
>>>
>>> Currently KVM hardcodes a deny list for unsupported host clobbering
>>> features for TDX, i.e. HLE, RTM and WAITPKG. However, KVM can't keep a
>>> list of bits that it may not know about (e.g. the upcoming FRED support
>>> in TDX).
>>>
>>> We had been working internally to propose a TDX specific solution to
>>> solve the host state clobbering feature issue. But during a PUCK meeting,
>>> Sean mentioned that KVM had a more permissive CPUID configuration
>>> interface than desired and there were problems due to it in the past for
>>> normal VMs as well. Sean suggested that KVM should introduce a more
>>> paranoid mode to check CPUID from userspace for VMs in general, as well
>>> as an opt-in interface for userspace. And TDX should use the
>>> infrastructure to enforce paranoid mode non-optionally.
>>>
>>> This RFC patch series adds a paranoid CPUID verification mode for KVM on
>>> x86, where KVM must be explicitly aware of every CPUID feature exposed
>>> to the guest. When the CPUID paranoid mode is opted-in by userspace or
>>> enforced, KVM will reject any unknown or unsupported feature from
>>> userspace. And it starts to enforce paranoid CPUID verification for TDX.
>>
>> This series misses the (important) part to use the TDX overlay to guard the setup_tdparams_cpuids() (and also mask the supported configurable CPUIDs in init_kvm_tdx_caps), to solve the initial TDX problem.
>>
> I think the patch 27 is what you referred to.

ah, sorry! (I was checking the code when reviewing in the middle of this 
series while I didn't realize)
