Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79A2C1788;
	Fri, 15 May 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826968; cv=none; b=qVqm9UW3qvbrzZMgFRI/WWjezodV5y/54ufdBPmRHEnd4y7t9Tmqz18DesHxcvsuTEKTw06s9pDijI9iWX6Dpz/IH6fywfhpC5dY+ssAuQ6pT8QSfJBbWF+K0rOYLXFe6o1+yxCAHHNnfMNPRKyJiN+x/zpKxD2uaJYFZ09M3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826968; c=relaxed/simple;
	bh=+4AeulQzD37kZOUE28U9l/cmQsoYUzC1yxLCdrk2Bko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI28JnLuH95cepd12FeBYKNscAL7U3jSntYcnNnBe20BTOq7pghAfZDVpWxuUsBfIq9FpwxctSgKCRV81UlpArl+bBCBhUH5QcYFh0dQvhqX95iK7gkkgDYPmYhXG7ugx39zp38BNLWEofve0zlCQJXT5Y2u7u+BWYJneNYIDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnuwxVGh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnuwxVGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778826968; x=1810362968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+4AeulQzD37kZOUE28U9l/cmQsoYUzC1yxLCdrk2Bko=;
  b=XnuwxVGhoymaoAVY0UT+kR2UysnRQphHk6aVpturoVCB9yxUfpilhiHC
   IZDQIFg7jbwJ2VljL4eXO4uxrBxljMKUkDsfdQ6dtVui1GZIzmDGvoZaL
   PlHqi5QoF7mn4/vFup3qmlmzoGh8eerXvTnZrD65rjk6oXodTbRn8dWrt
   OHH9TEd6VzkKZt23aPDlAjByWkLupmVE/5/drUUWOW+YBAj2nZoWk+DDc
   AJqUvHdL1AjuuHYvOBrRS7XYuq6RY6evtxFH5OzLdGk+Svd2L6jp2tMwO
   ESznN1arbMB8k7eJ9KK6lP9eR+tjDUMmED3ym9S3lRH85MSNEPfAG74+G
   Q==;
X-CSE-ConnectionGUID: znl0wEaeS6GUCe8E77FT0g==
X-CSE-MsgGUID: EcK4/9KwTTygszUTg4L9rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79673184"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79673184"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:36:08 -0700
X-CSE-ConnectionGUID: 8V/pLRLDQqqQ2zugjXMBGw==
X-CSE-MsgGUID: 4wgy2oNtQl6dgThe2YslJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232217271"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:36:03 -0700
Message-ID: <784d6d93-07d9-4fe7-a531-957fa45c9b69@linux.intel.com>
Date: Fri, 15 May 2026 14:36:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] KVM: SVM: Truncate INVLPGA address in
 compatibility mode
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Check for full 64-bit mode, not just long mode, when truncating the
> virtual address as part of INVLPGA emulation.  Compatibility mode doesn't
> support 64-bit addressing.
> 
> Note, the FIXME still applies, e.g. if the guest deliberately targeted
> EAX while in 64-bit via an address size override.  That flaw isn't worth
> fixing as it would require decoding the code stream, which would open a
                                                                        ^
an extra 'a'

> an entirely different can of worms, and in practice no sane guest would
> shove garbage into RAX[63:32] and execute INVLPGA.
> 
> Note #2, VMSAVE, VMLOAD, and VMRUN all suffer from the same architectural
> flaw of not providing the full linear address in a VMCB exit information
> field, because, quoting the APM verbatim:
> 
>   the linear address is available directly from the guest rAX register
> 
> (VMSAVE, VMLOAD, and VMRUN take a physical address, but they're behavior
                                                              ^
                                                          their      > with respect to rAX is otherwise identical).
> 
> Fixes: bc9eff67fc35 ("KVM: SVM: Use default rAX size for INVLPGA emulation")
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/svm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e74fcde6155e..4ad87f8df392 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2415,7 +2415,7 @@ static int invlpga_interception(struct kvm_vcpu *vcpu)
>  		return 1;
>  
>  	/* FIXME: Handle an address size prefix. */
> -	if (!is_long_mode(vcpu))
> +	if (!is_64_bit_mode(vcpu))
>  		gva = (u32)gva;
>  
>  	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);

