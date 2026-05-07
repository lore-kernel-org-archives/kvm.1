Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84473191C8;
	Thu,  7 May 2026 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140469; cv=none; b=kJB/KkNpUQ5k/fd8QWb6xbVsNOjRggIsyOBRFJedf8cNMcremD9TQuGm2yHEVziKNh2LSWnR6rWFr9ys2ublu/EBUTiFHfTaBX+gB7xAa0eqQOSdr4bMTNaeEYzRwCeX3ZvKfIj5my0JgIaggELxS040xxrSWFqOP30NFsAW2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140469; c=relaxed/simple;
	bh=/udflDc8cothw4i2dsB61q4+3RTwijgBESwA8j1pUNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3+QMz2kuZYIixJq8A46/yAivlQFuk+PTflX/XG/FyuBqFNCseJPO3zEU9XzOhLTfMIa+XkV3pCGDSWXICK0RlmS79D/V6E9SBDU+FM4SU9yBkJACJUFQdddwvH4SsOO3OoGb6/l7XesdSYmhjPhgXx7+wlLSljNh/SpWx6myF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCNT17w+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCNT17w+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778140468; x=1809676468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/udflDc8cothw4i2dsB61q4+3RTwijgBESwA8j1pUNA=;
  b=HCNT17w++UtZWduCRuCLC1ZxTj9gdrVhCkE/zevBuB3a6IbLtPccWctT
   2C39lx3acKYX/rdgx2SfhOyK5B4xyAxbva+nXD+4BHaapwwMCsSPRqJRU
   MSevCeLnRLDsj/SlsMmHlATVxpal5r3s9wb9+xUMj1RyXDBgZb5N6kJl0
   yHS0uNXhT1Aup94Rz/HJ89hH0RyliP7iKDV7gDY6wGnRjt/JivlZVfUie
   eN0/2Mmqf2VWmHIEW8YH/MXjj8PelT3uiUJqZmQGqj5VVLk+A6x68LJv+
   vbHJP39S3Q4HT7ketT7O484gL6x41Q7HYwg4yruQDZ6rre+xQvG9Bmeb0
   A==;
X-CSE-ConnectionGUID: uAOVKGEaS2+QNMpcxPH7sQ==
X-CSE-MsgGUID: jtqyOEAzQwSyz3sGK9xO0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79192803"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79192803"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:54:27 -0700
X-CSE-ConnectionGUID: Hwba+87XSxWKjyA1Pg3xPg==
X-CSE-MsgGUID: eiAgj3DXRjuMJgPiNCGbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241372691"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:54:22 -0700
Message-ID: <90e91a3c-3f5d-454c-878f-335b19af71c3@intel.com>
Date: Thu, 7 May 2026 15:54:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com,
 pbonzini@redhat.com, seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com,
 yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com,
 sagis@google.com, binbin.wu@linux.intel.com, isaku.yamahata@intel.com
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430014948.24226-1-yan.y.zhao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260430014948.24226-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/2026 9:49 AM, Yan Zhao wrote:
> From: Sean Christopherson<seanjc@google.com>
> 
> Remove struct page assumptions/constraints in APIs for unmapping guest
> private memory and have them take physical address directly.
> 
> Having core TDX make assumptions that guest private memory must be backed
> by struct page (and/or folio) will create subtle dependencies on how
> KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
> allocated from core MM, if the memory is refcounted, or if the folio is
> split) that are easily avoided. [1].
> 
> KVM's MMUs work with PFNs. This is very much an intentional design choice.
> It ensures that the KVM MMUs remain flexible and are not too tightly tied
> to the regular CPU MMUs and the kernel code around them. Using
> "struct page" for TDX guest memory is not a good fit anywhere near the KVM
> MMU code [2].
> 
> Therefore, for unmapping guest private memory: export
> tdx_quirk_reset_paddr() for direct KVM invocation, and convert the SEAMCALL
> wrapper API tdh_phymem_page_wbinvd_hkid() to take PFN as input (thus
> updating mk_keyed_paddr() and tdh_phymem_page_wbinvd_tdr()).
> 
> Intentionally have KVM pass PAGE_SIZE (rather than KVM_HPAGE_SIZE(level))
> to tdx_quirk_reset_paddr() in tdx_sept_remove_private_spte() to avoid
> mixing in huge page changes. The KVM_BUG_ON() check for !PG_LEVEL_4K in
> tdx_sept_remove_private_spte() justifies using PAGE_SIZE.
> 
> Do not convert tdx_reclaim_page() to use PFN as input since it currently
> does not remove guest private memory.
> 
> Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
> since APIs tdh_phymem_page_wbinvd_hkid() and tdx_quirk_reset_paddr() are
> exported to KVM only.
> 
> [Yan: Use kvm_pfn_t,exclude tdx_reclaim_page(),use tdx_quirk_reset_paddr()]
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> Signed-off-by: Yan Zhao<yan.y.zhao@intel.com>
> Link:https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
> Link:https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
