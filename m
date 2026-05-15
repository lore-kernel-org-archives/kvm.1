Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4FD3D646D;
	Fri, 15 May 2026 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837192; cv=none; b=skfjnGoll3KEgfhkpr28xUB0VVHUzTFOyWNORHPviTxDN0HWEwHFygR3Xo2K4jeJDrDpppJdmQBti/FlCWwupqG9dt+PFF4KSriKPAbwcdw818U3+FlRc+nbplh96qaxoyzTvTX7ZW7+xMHSBzpG/E4v6dhEa/SHZzpspBM/DUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837192; c=relaxed/simple;
	bh=7E11nnfPn4JbqJmKnXNMEf6zZwxy967QlJeMvDKWHUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEQAKQSG+zkxNP6zPOD5lkp48zZWhQzGur865DaVRKLLSmlUb3r8mPWSsGMedccLNRMMoYVMoCQRvgGIdjJphU1wVCXv2I/XIIhHvQh/yPHcIvIJpbC+xyAtLhe6KnxKxoGT6JVYu6XwMbkFenAGuOWE5gK0WvvRNops77J3R/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoZCQ8De; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoZCQ8De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778837191; x=1810373191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7E11nnfPn4JbqJmKnXNMEf6zZwxy967QlJeMvDKWHUs=;
  b=YoZCQ8DeRoZRbTHUinvqozaCXjPBLj2rj/U81TBFDIlGVP4YIlRMnRIO
   j6dJM1TsBS/I5OB7CJm6bN5z+otVJzRf7HABnXRckr0WOa8vN5uYRVuIZ
   Jr6541X6CprygWgpbeYIihwvAxS9St3BEAmxuXjAj+DGGNQg2zpryuNW1
   cOF/Ou7cv3ywc+Z8SKzp5e7upRvUffDaeF/VNqcgsM1YIFhTpKZOg6X9+
   JcQQ5ZrUHF+xu8JYNpwCk7R0sEGkRWSTRfgL8nLAFaSNctdsWXBopYDYY
   4/SayPGP80K5efObPYzqX3KT22dFXyCSmJoGUmwOIyuY+gGkDWEW8vxip
   w==;
X-CSE-ConnectionGUID: rBnzmt0rS4abOXaFTRNxPg==
X-CSE-MsgGUID: shlcTVFRRsSbAM5GHCUTkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97364957"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97364957"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:26:30 -0700
X-CSE-ConnectionGUID: 3lMQwoCUTYukRwTZmgXYHA==
X-CSE-MsgGUID: V45DRmfKRiq0X9827hNd3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="268993390"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:26:27 -0700
Message-ID: <07568ad3-f629-46a8-9ff7-a5551a7e30fc@linux.intel.com>
Date: Fri, 15 May 2026 17:26:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] Revert "KVM: VMX: Read 32-bit GPR values for
 ENCLS instructions outside of 64-bit mode"
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-12-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-12-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Now that kvm_<reg>_read() are mode aware, i.e. are functionally equivalent
> to kvm_register_read(), revert aback to the less verbose versions.
> 
> No functional change intended.
> 
> This reverts commit 60919eccf6764c71cef31a1afeaa1a36b8e5ab85.
> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/vmx/sgx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
> index 2f5a1c58f3c5..876dc2814108 100644
> --- a/arch/x86/kvm/vmx/sgx.c
> +++ b/arch/x86/kvm/vmx/sgx.c
> @@ -225,8 +225,8 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
>  	struct x86_exception ex;
>  	int r;
>  
> -	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 32, 32, &pageinfo_gva) ||
> -	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva))
> +	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 32, 32, &pageinfo_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva))
>  		return 1;
>  
>  	/*
> @@ -302,9 +302,9 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
>  	gpa_t sig_gpa, secs_gpa, token_gpa;
>  	int ret, trapnr;
>  
> -	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 1808, 4096, &sig_gva) ||
> -	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva) ||
> -	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RDX), 304, 512, &token_gva))
> +	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 1808, 4096, &sig_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_rdx_read(vcpu), 304, 512, &token_gva))
>  		return 1;
>  
>  	/*

