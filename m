Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71608375F8A;
	Thu,  7 May 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140161; cv=none; b=b8rsv+aaY6RC8udq3XsK0BCFHcNs+SkKRbkvGsNPOc1f8tjB2q3ZPkM3RPnIYlGJ9HQScKsnpu/AN25mFcjFp3NPl5sedR4+KtjaIvtWL/IkZXVPsuLLTHuGtY40BHms9J5LF9djAh5rNrAdwkrr48cHVhiVlvW1p2ZpfUTyizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140161; c=relaxed/simple;
	bh=jd6Cjpz32XIiuxDttxv5ZBmw9JX+EJaF6ywBf7XoMKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BR5PVzF6YtzfKtkZGQMrE5XHayZzt3P6WAOSECtiLKZA9D3FVFFyb3WocN3L0smZ7fcVEk+Qh+rUWXMiWaXZlHsG4oRauEdkzoMic3wv8igrZrcH+ujVVnH6Ld6MLPkqr/ZcOODW9zA9j3H3Z/N+odrtUW58oBtxsSDFpelvfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JheGDpsT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JheGDpsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778140161; x=1809676161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jd6Cjpz32XIiuxDttxv5ZBmw9JX+EJaF6ywBf7XoMKc=;
  b=JheGDpsTvijtcHoMUdrlY1gtjn1aYAI2tC7pxLjrHQdDPOWSIvs2fzo+
   8pnnj6Rrgw8vn0xF/xdqhVmyiZPzxn+uTABGcFZRWZd25PF3pP2qAkLqF
   aAYF+8DlAp3ezWA/PToYUroqHxS24NtzN8KD0G9pH7P0SfYNK+mO530dE
   QW6CXKH4Q19UPP0p9MBn758E+i+rvqv1Ya+okhgzLF5gKhYe06cmIW1QH
   tyMLDqvdLP3iYsk0oaYOc+FYuJo5ws0cOS/51dMl1u2VkcLTveiVi1Kf0
   JWI7b0dzV5wbPOpA+GZqldzhx5EpoDeFoa9hDUD4rAp1908CKp/oTwZxp
   Q==;
X-CSE-ConnectionGUID: Zr2Koz/3TyuAraBd8FH/AA==
X-CSE-MsgGUID: rphc78jARAqHfGRACukrqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82928362"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="82928362"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:49:20 -0700
X-CSE-ConnectionGUID: z5JOOq6QT6SwnT6PM4pOMw==
X-CSE-MsgGUID: xQ75mUKOSOelHPqLgdxWaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241371271"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:49:11 -0700
Message-ID: <28c8d380-d2e5-4f70-96b0-00225e0ea86d@intel.com>
Date: Thu, 7 May 2026 15:49:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] x86/tdx: Use PFN directly for mapping guest
 private memory
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com,
 pbonzini@redhat.com, seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com,
 yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com,
 sagis@google.com, binbin.wu@linux.intel.com, isaku.yamahata@intel.com
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430014929.24210-1-yan.y.zhao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260430014929.24210-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/2026 9:49 AM, Yan Zhao wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Remove struct page assumptions/constraints in the SEAMCALL wrapper APIs for
> mapping guest private memory and have them take PFN directly.
> 
> Having core TDX make assumptions that guest private memory must be backed
> by struct page (and/or folio) will create subtle dependencies on how
> KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
> allocated from core MM, if the memory is refcounted, or if the folio is
> split) that are easily avoided. [1].
> 
> KVM's MMUs work with PFNs. This is very much an intentional design choice.
> It ensures that the KVM MMUs remain flexible and are not too tied to the
> regular CPU MMUs and the kernel code around them. Using 'struct page' for
> TDX guest memory is not a good fit anywhere near the KVM MMU code [2].
> 
> Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
> since APIs tdh_mem_page_add() and tdh_mem_page_aug() are exported to KVM
> only.
> 
> [ Yan: Replace "u64 pfn" with "kvm_pfn_t pfn" ]
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Link: https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
> Link: https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

...
> +static void tdx_clflush_pfn(kvm_pfn_t pfn)
> +{
> +	clflush_cache_range(__va(PFN_PHYS(pfn)), PAGE_SIZE);

If the pfn is not in the kernel direct map, we will get #PF, right?

There is on-going attempt to remove the direct map for guest_memfd. The 
good news is TDX is excluded. [1]

[1] https://lore.kernel.org/all/20260410151746.61150-9-kalyazin@amazon.com/
