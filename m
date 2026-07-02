Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73373A48E3;
	Thu,  2 Jul 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977974; cv=none; b=myAb5MDlVuZNQY+z7h6sZWRY/nOPfPl1+9rVZAKco5+ZO7heqbzZWjXsjyZivOGmZVmSPS+FZarNp+xC6uMhcnrgIeTibyNH1Krm4TXIRE0PIqZl8K/SoAq0yTf/JHEXBVE4FMYqg2B21zpJMijZeXt1UESxod95UqlVLLHSpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977974; c=relaxed/simple;
	bh=j/OPuv0d6VRbXBYGR78O8nPZKRJDyebLraDM8i2fvTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsM010xGuH7D56AcUWA0UWe7XA8fJf5FJEPhpMykmgpEOeZJs83sZ++nL/CzfUpHJ+b/1twx+knUtXhSSgrgYnEDj8fZwu3PI5K4B1bgeyTN5Lq2ySVy9rMHuiC2/IUuuro2AWOF8rx/mtz2yryf+A9pCeCl8ZOobSJU6kJn2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lq4UvmLv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lq4UvmLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782977972; x=1814513972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j/OPuv0d6VRbXBYGR78O8nPZKRJDyebLraDM8i2fvTE=;
  b=Lq4UvmLvQWgPlB50tgfjCSbe2NR3cj7Mticubv7pO40txUrxnWO1JBIP
   z1mkPqCmngc64kh1HTSAVjme3YyUI2eH/R+Tb8Kzo3v8+LllZesF2ihEJ
   dIxFiKGRVigQqjqKYhCheilLOHHEVVDA0kwlk1hSirf8SqjrOI1ORuSHW
   o+YIlW2JUwidkw88ckUtkYK/THuYfC3w27grA7LCVYzHRMt0hZAEHtsTp
   zgKOQ/d2aF4bsIXoU0TdUgsY4U8RrSNFKn3qIYW8+WlMNakafFnSA54ur
   Dsv2Dd/Ay20VtXQVatZE0B29s0g5zKABf92eEmtjQZvDak1VMxp2QdMfC
   Q==;
X-CSE-ConnectionGUID: u/f6JUksTJyd0ShFMIAZ+w==
X-CSE-MsgGUID: hO/F1XgTRuOStwtNOxqtPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83589652"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83589652"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:39:32 -0700
X-CSE-ConnectionGUID: +MM1UJEXSsedtjolvHVGnA==
X-CSE-MsgGUID: kwjLY7vRQCuaPEqAhvuSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="290910560"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:39:27 -0700
Message-ID: <1694d6c2-2aaa-4277-ba83-97c4a3007417@linux.intel.com>
Date: Thu, 2 Jul 2026 15:39:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com,
 pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org,
 vannapurve@google.com, x86@kernel.org, chao.gao@intel.com,
 yan.y.zhao@intel.com, kai.huang@intel.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260526023515.288829-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/2026 10:35 AM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
> backing for the 2MB region covering the passed pfn. However, multiple
> callers can concurrently operate on 4KB pages that fall within the same
> 2MB region. When this happens only one Dynamic PAMT page pair needs to be
> installed to cover the 2MB range. And when one page is freed, the Dynamic
> PAMT backing cannot be freed until all pages in the range are no longer in
> use. Make the helpers handle these races internally.
> 
> Use the per-2MB refcounts from previous changes to track how many 4KB
> pages are in use within each region. Gate the actual Dynamic PAMT add and
> remove on refcount transitions (0->1 and 1->0). Serialize the refcount
> check and SEAMCALL with a global spinlock so the read-decide-act sequence
> is atomic. This also avoids TDX module BUSY errors, as Dynamic PAMT add
> and remove SEAMCALLs take an internal TDX module locks at 2MB granularity,
> so simultaneous attempts on the same region would conflict.
> 
> The lock is global and heavyweight. Use simple conditional logic to keep
> correctness obvious. This will be optimized in a later change.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]

>  
> @@ -2057,10 +2061,26 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
>  	if (ret)
>  		return ret;
>  
> -	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> -	if (tdx_status != TDX_SUCCESS) {
> -		ret = -EIO;
> -		goto out_free;
> +	pamt_refcount = tdx_find_pamt_refcount(pfn);

tdx_find_pamt_refcount() is tagged as __maybe_unused in the previous patch.
I think the tag should be removed.

[...]
