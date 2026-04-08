Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97D38F639;
	Wed,  8 Apr 2026 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645235; cv=none; b=pwyQZNBP4p/wYWJtDJ0QjUzZQVK2FnqXy/yl5iu5/OkxFEx2MAjZ8LZCevWlh/qwjJRwuzakvw0iLtnYOZFuYLiwYCwbX3LhZ9YrEnxjcZeNA+tGposWoe32rf+AUVzc5nxTVetbNpPHv9OHcNvIvVcLdt8LxQ4aAlowcNfMt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645235; c=relaxed/simple;
	bh=ok2kNDZ9sbAF+klV1c/5CMnQx5AIE9fVShLUiIqfEtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzEhTHhm/QJ3nCg+/Rzca7KvHLe9TzCYDXH7oCA1gORDVE8Zztcba7B7kkaoh47yKzQOYEtiPTv79BuyN7Ybp7OMUER1C/Oddyeai4AseIULKgrITvLl1MjS8TeRIDAbrfGunRes1eMi2eVuA+n0V4yepdCoj5XqkwBXc8/YPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=et2bfv7c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="et2bfv7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775645234; x=1807181234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ok2kNDZ9sbAF+klV1c/5CMnQx5AIE9fVShLUiIqfEtw=;
  b=et2bfv7caKHoKVc0b+XXHzY/MA0g5xBO2avl26FYNINVZJP/jANuXQSS
   Vmv3qLLxMfDWM+0Sair1jk3qGVuiCWG2vL+Y8lBHD5OqDBZUoJMXVyuBD
   dZim1V12aWlQ7YQnyTcAOdKerKweQ4RYDOZ0gI1k0E6aStctaUbDfDS8m
   zRKjjBiIG1IU0IFRx8dZa0A/dQqJNxJayrd+jw1E2ZrXeGHnopJbxxYqe
   YQ8dCtq6KQ86WBgXqE8d05EoF+kp6BxxfWiG9JbUn8hRcQO+BsKhHRkgY
   ORiqAYpD8ySRsxpENKLqWdePYBIWdrBMDo/V72tTpET99ztM07GCMcFqx
   w==;
X-CSE-ConnectionGUID: ChWACNKAQmymqSUskxgOsw==
X-CSE-MsgGUID: HTKrxP0PRVWT6HkX7ieOew==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87700173"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87700173"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:47:14 -0700
X-CSE-ConnectionGUID: viTcMjAbSJiWJUwegwaW3A==
X-CSE-MsgGUID: vKf6TG0HTam1ahAqgHqWKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="258868253"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:47:11 -0700
Message-ID: <10e539d8-e698-4b79-a24d-83854f06f1a9@linux.intel.com>
Date: Wed, 8 Apr 2026 18:47:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, yan.y.zhao@intel.com,
 kai.huang@intel.com, kvm@vger.kernel.org, kas@kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/28/2026 4:14 AM, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Centralize the updates to present external PTEs to the
> handle_changed_spte() function.
> 
> When setting a PTE to present in the mirror page tables, the update needs
> to propagate to the external page tables (in TDX parlance the S-EPT).
> Today this is handled by special mirror page tables branching in
> __tdp_mmu_set_spte_atomic(), which is the only place where present PTEs
> are set for TDX.
> 
> This keeps things running, but is a bit hacked on. The hook for setting
> present leaf PTEs are added only where TDX happens to need them. For
> example, TDX does not support any of the operations that use the
> non-atomic variant, tdp_mmu_set_spte() to set present PTEs. Since the hook
> is missing there, it is very hard to understand the code from a non-TDX
> lens. If the reader doesn’t know the TDX specifics it could look like the
> external update is missing.
> 
> In addition to being confusing, it also litters the TDP MMU with
> "external" update callbacks. This is especially unfortunate because there
> is already a central place to react to TDP updates, handle_changed_spte().
> 
> Begin the process of moving towards a model where all mirror page table
> updates are forwarded to TDX code where the TDX specific logic can live
> with a more proper separation of concerns. Do this by teaching
> handle_changed_spte() how to return error codes, such that it can

Nit:
The patch adds a helper __handle_changed_spte() to return error codes.


> propagate the failures that may come from TDX external page table updates.
> 
> Atomic mirror page table updates need to be done in a special way to
> prevent concurrent updates to the mirror page table while the external
> page table is updated. The mirror page table is set to the frozen PTE
> value while the external version is updates. This frozen PTE dance is
> currently done in __tdp_mmu_set_spte_atomic(). Hoist it up a level so that
> the external update in handle_changed_spte() can be done while the PTE is
> frozen.
> 
> Link: https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
> Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Based on a diff by Sean Chrisopherson]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---

[...]

>  }
> @@ -708,18 +698,49 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
>  						       struct tdp_iter *iter,
>  						       u64 new_spte)
>  {
> +	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
>  	int ret;
>  
>  	lockdep_assert_held_read(&kvm->mmu_lock);
>  
> -	ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
> +	/* KVM should never freeze SPTEs using higher level APIs. */
> +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> +
> +	/*
> +	 * Temporarily freeze the SPTE until the external PTE operation has
> +	 * completed (unless the new SPTE itself will be frozen), 

But the KVM_MMU_WARN_ON() and the comment above says the new SPTE should not be
frozen.

> e.g. so that
> +	 * concurrent faults don't attempt to install a child PTE in the
> +	 * external page table before the parent PTE has been written, or try
> +	 * to re-install a page table before the old one was removed.
> +	 */
> +	if (is_mirror_sptep(iter->sptep))
> +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
> +	else
> +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
>  	if (ret)
>  		return ret;
>  
[...]

