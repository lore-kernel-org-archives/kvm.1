Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E41EEA49
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947088; cv=none; b=Ld8WhX3/uF5oYlSZOrUjH7zvo9g8cHMEeWKWw+RVWKpFzkLFLGuXRhpdGVnsJajNqofzctcz9gQKqL+evrEYOp4tMkcAbuf48GoDG1X/Gmyk2Nik2J6SHDZH43gz7lxsLungMK2IvwtzFq41B4nfQn8WX/a/z/Qvp6D3LDks1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947088; c=relaxed/simple;
	bh=grKZz61OVYFNNJHJ5sYeUmbUtKNym66hz/hWDIAvdCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io9YkpUfNAfL+fp/0H51tLkH+7fS0meO5vK/3HTf6/XndZO8BzCEHStp/jdR60l/J11P9e8YS52tCqAiU/dekvBPZj5Qqcb/my+ETFyCQwlJf31atssmFMJ6BLdPL96HyQRVhwNm54x/zi+W7bf+NAyyq32Ra7c0r4ojMYOzKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUsG5QdU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUsG5QdU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779947086; x=1811483086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=grKZz61OVYFNNJHJ5sYeUmbUtKNym66hz/hWDIAvdCM=;
  b=mUsG5QdUwNVPo5ohcACnAQBAgZ7tbvV1rC/01dNoYb5lWT7psrQwqq+y
   WCfpYfGAncRv6Cm3wLwZAzh231TWbKe0DtzDbTl/wwPVvKa+CT4dBWJCm
   6MB4L4VhIlrHTShIEbKtUXdeIdD3ZiqfbgIPS0UpA9vIkHFdOjEU2mV9r
   c6Ilc6YZPGpw/R1yPEyGdfF9sVUo1w/ennr9K6nPNrMSnxGinx569jIpt
   idaNpqSEF54332doyn5D+wYFibO1QNnmSKdbPHZ7IWoRyr0QWJEMWojxd
   FTO/5mnIZHQFclh1RhSNRWvWBhRqDSb69CX0Ux1ILKsxCbAcooLzjwmte
   A==;
X-CSE-ConnectionGUID: EQvCSHwWRtKNjraFriIwfQ==
X-CSE-MsgGUID: Xht9YFF5R7W/JqMaAVdSEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84673512"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="84673512"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 22:44:45 -0700
X-CSE-ConnectionGUID: yzFselZYRyqWESurnNzUkw==
X-CSE-MsgGUID: 6hpef2JIQNmdfTYsyZP6pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="242612230"
Received: from unknown (HELO [10.239.158.62]) ([10.239.158.62])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 22:44:41 -0700
Message-ID: <04f3184d-58f5-45c3-b5d4-5485e68946ae@intel.com>
Date: Thu, 28 May 2026 13:44:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/12] guest_memfd: support in-place memory conversion
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, berrange@redhat.com,
 armbru@redhat.com, pankaj.gupta@amd.com, isaku.yamahata@intel.com,
 chao.p.peng@linux.intel.com, david@kernel.org, ashish.kalra@amd.com,
 ackerleytng@google.com
References: <20260528000416.8161-1-michael.roth@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/2026 8:03 AM, Michael Roth wrote:
> This patchset is also available at:
> 
>    https://github.com/amdese/qemu/commits/snp-inplace-rfc1
> 
> which is in turn based on the following series:
> 
>    [PATCH 0/4] "guest_memfd: Fix handling for conversions of MMIO ranges"
>    https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg07547.html
> 
> 
> OVERVIEW
> --------
> 
> This series adds guest_memfd support for in-place conversion of memory
> between private/shared, and enables it for SEV-SNP guests. It is based
> on recently-added kernel support for mmap()-able guest_memfd
> instances[1], which allow it to be used for shared memory, and the
> following patchset[2], which adds additional guest_memfd interfaces to
> allow it to be used to perform in-place conversion:
> 
>    "[PATCH v7 00/42] guest_memfd: In-place conversion support"
>    https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> 
> That series also introduces a new 'vm_memory_attributes' KVM
> module option, which sets whether memory attributes are tracked
> VM-wide by KVM (vm_memory_attributes=1: the existing 'legacy' mode),
> or per-guest_memfd instance (vm_memory_attributes=0: the new mode
> which allows for in-place conversion). The latter is intended to
> eventually deprecate the legacy mode, at which point in-place
> conversion would become the primarily-supported mode.
> 
> 
> MOTIVATION
> ----------
> 
> Today, SEV-SNP guests (and other CoCo VM types using guest_memfd) keep
> shared and private memory on separate physical backings: a userspace
> memory-backend object for shared pages, and a kernel-allocated
> guest_memfd file descriptor for private pages. KVM_SET_MEMORY_ATTRIBUTES
> flips which backing the guest sees for a given GPA range, and the old
> backing is typically discarded / hole-punched on conversion to avoid
> doubled memory usage.
> 
> That model works, but has a number of downsides that impact certain
> use-cases:
> 
>    - Each conversion involves discarding pages on one side and faulting
>      them in on the other, which incurs allocation overheads in the
>      host kernel for every conversion.
> 
>    - Some use-cases, like pKVM[3], rely on memory isolation rather than
>      encryption and rely on in-place conversion to pass through things
>      like secured framebuffer memory without needing to bounce data
>      through separate shared/private HPAs, which would introduce
>      unacceptable latency for that sort of workload.
> 
>    - Hugetlb support[4] for guest_memfd will rely on it, since things like
>      1GB hugepages with a mix of shared/private sub-ranges would generally
>      require 2 1GB hugetlb pages to remain available to handle shared vs.
>      private accesses, which quickly causes doubling of guest memory usage.
> 
> Recent kernel work[2] makes guest_memfd mmap()-able and lets the *same*
> physical pages be used for both shared and private states for a given
> GPA range, allowing the above pitfalls to be naturally avoided.
> 
> This series wires that support up in QEMU.

+ Peter,

Peter had the series[*] to enable the mmap() of guest memfd and allow it 
serve as unencrypted memory for VMs. I believe there are some overlapped 
efforts.

[*] 
https://lore.kernel.org/qemu-devel/20251215205203.1185099-1-peterx@redhat.com/

> 
> DESIGN
> ------
> 
> A new dedicated memory backend, memory-backend-guest-memfd, allocates
> its memory via a guest_memfd file descriptor obtained from KVM with
> the GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED flags. 

A quick feedback:

The design choice from Peter's series was to extend the current 
hostmem-memfd backend to support guest-memfd instead of a new dedicated 
backend.
I think we need to evaluate the pros and cons of each other, and make a 
choice.

(I will go read the other part later and provide more feedback)
