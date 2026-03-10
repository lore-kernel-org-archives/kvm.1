Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855119D071;
	Tue, 10 Mar 2026 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106192; cv=none; b=PcVSsIYQa2TPQBKr5hggLoV+YuaUUfDuOXbPNnKr/aDSqJ/5Rj3kEvTUNQDghXVYDYbIGZfh2BeeIP2vODm/Z/4AWEM8+W3jV90d457V4O+teJznhW8w178oSuIfzCPoXjdJ014qaaCch6W9T1spwE8m4+KVQJf6r02SwB/89eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106192; c=relaxed/simple;
	bh=gz43Mj2oXlYu+w6zv6iXQcm0PwcTvoq9HfUZw6RWieE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3Nj4qarbmNfIu4rbkbFjV6y7/MCR3oqr9RMK8ld8ZGVrLQJqIjrlGQtqsnWNXhH65+b6d3AK2hRiBPsiCtQJPocfyhyjfeV+Qump0dqYbLj8YTWkrtBtfdryDVZ0Aamrh47gCdMVBGDpWhNpNhcywWMm7CX+vfOxEPOWuM9xbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw9hR1eX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw9hR1eX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773106192; x=1804642192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gz43Mj2oXlYu+w6zv6iXQcm0PwcTvoq9HfUZw6RWieE=;
  b=Iw9hR1eXGsNpOYpbUMAOUQBj1bwu3JbKB18e5/TLDjQsVn9PgMNIJnfO
   OgbNPoM1filxdUicB2it3uniNxXW0MvQpBMa7M7cZ91UFJDpklYysDUuG
   AqWnLw63bdV15WMuSlZzdSJBNGj9gObTWt6777x/dBCxEwWWKWgULMgjH
   BMurrZC5w6uClZZ6XGZNRTSq8llDQdtjAKaQR0bxfwKYGhHfCRWnCsALt
   I5yO4yOgZrWzmKiHSI2/aEm4Cm6vp117ShZRDktsc44LrbF80k8oFVBAV
   OLbokWXsHbArANdR5pg+2RiTWFxDZXoe/0CjW0DYfg+CCRsFwiFEZ+Z2Q
   w==;
X-CSE-ConnectionGUID: DBLrUxOpSIeUP1/ueHpQjw==
X-CSE-MsgGUID: fROjqRBKTaaOttr0sSfVMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85619075"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="85619075"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 18:29:51 -0700
X-CSE-ConnectionGUID: XbYawSbvS/qxFZEU60kr8g==
X-CSE-MsgGUID: AZ7OPRmWRyeOqF922POAQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="216378204"
Received: from unknown (HELO [10.238.1.107]) ([10.238.1.107])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 18:29:49 -0700
Message-ID: <5a1fb240-1806-420c-bf30-8789752aa717@intel.com>
Date: Tue, 10 Mar 2026 09:29:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/tdp_mmu: Fix base gfn check when zapping private
 huge SPTE
To: Sean Christopherson <seanjc@google.com>, pcjer <pcj3195161583@163.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org
References: <20260309083844.217215-1-pcj3195161583@163.com>
 <aa7X3YNbQ9Zuq6cJ@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aa7X3YNbQ9Zuq6cJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/2026 10:23 PM, Sean Christopherson wrote:
> On Mon, Mar 09, 2026, pcjer wrote:
>> Signed-off-by: pcjer <pcj3195161583@163.com>
>> ---
>>   arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
>> index 1266d5452..8482a85d6 100644
>> --- a/arch/x86/kvm/mmu/tdp_mmu.c
>> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
>> @@ -1025,8 +1025,8 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
>>   
>>   			slot = gfn_to_memslot(kvm, gfn);
>>   			if (kvm_hugepage_test_mixed(slot, gfn, iter.level) ||
>> -			    (gfn & mask) < start ||
>> -			    end < (gfn & mask) + KVM_PAGES_PER_HPAGE(iter.level)) {
>> +			    (gfn & ~mask) < start ||
>> +			    end < (gfn & ~mask) + KVM_PAGES_PER_HPAGE(iter.level)) {
> 
> Somewhat to my surprise, this does indeed look like a legitimate fix, ignoring
> that the code in question was never merged and was lasted posted 2+ years ago[*]
> (and has long since been replaced).
> 
> The bug likely went unnoticed during development because "(gfn & mask) < start"
> would almost always be true (mask == 511 for a 2MiB page).  Though mask should
> really just be inverted from the get go in this code
> 
> +		if (is_private && kvm_gfn_shared_mask(kvm) &&
> +		    is_large_pte(iter.old_spte)) {
> +			gfn_t gfn = iter.gfn & ~kvm_gfn_shared_mask(kvm);
> +			gfn_t mask = KVM_PAGES_PER_HPAGE(iter.level) - 1;
> +
> +			struct kvm_memory_slot *slot;
> +			struct kvm_mmu_page *sp;
> +
> 
> [*] https://lore.kernel.org/all/c656573ccc68e212416d323d35f884bff25e6e2d.1708933624.git.isaku.yamahata@intel.com
> 

/faceplam, the buggy code was written by me.
