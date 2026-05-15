Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259303E3C78;
	Fri, 15 May 2026 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830019; cv=none; b=EL3yxKU3wyFBktky5+qTjeQPoS8fIsvympFmWdbsURRS0sLajoeF2K4RypejcfHrdUHsbDNGYLr8ogQEKfe9wXNolj0rXaVqSPC5Qvrc3KSDWuMggtUM6fboWeADvPP5qDaLBC929c5RB7Q2uqoENNBOZOHI7ihq5xaWRz6SqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830019; c=relaxed/simple;
	bh=XjmDfLbSvtyGrcG/wZsXDUkMd0QJdX4aAsxqeeZXPls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keyktoppJo+rUttgehB9bOAwS/3CYRUVXDd1rXdh7FfvNay2UYmowhzwgqFKH8in/QPmFlIpSQ42P3O2aBE6Gq1mslu185yadBPCl1K6IO+2bcJTrvq5l3jNhbjABI2kAVcWMY3Fejr8h7qW0ZS2liCVekY4zNBkxpO3XyPhdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTT6rCTU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTT6rCTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778830018; x=1810366018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XjmDfLbSvtyGrcG/wZsXDUkMd0QJdX4aAsxqeeZXPls=;
  b=fTT6rCTU9BM7DgOJkkCYayOf7ZCjwy0Fk7u5nvuoHBdYJSNTybn8dUbj
   M/law7EVCvC0pje5KmZmTtiVUD3IFG6+VSH/QP2s7yJVt7ys96OOA1gZn
   v4LzrzenhbFY3q21D9Male+rcHDi3Aol1EXLYKU2YVYdeeEupCFpjlmG2
   /OexEpo9G9G8mFiaVt4HCaBDJP87fVbtZx2hRrKJ+bXm53o6YqnAS74Wk
   0ilsGp3uWR43+D5JaCuxVSvLzcDRBcYhRJFBq2p8sJBdZHGbc5a/QY4BS
   FdcbgFzwNQf4FtCITZ3+KhP0mX4xDr5QSC/o04VS+pI9Fjoz+YFAfFNfT
   Q==;
X-CSE-ConnectionGUID: NtUs/u75SS2fb1kqGbIctw==
X-CSE-MsgGUID: dwNLJDFbRvGQZluthqSf4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83639095"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83639095"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:26:57 -0700
X-CSE-ConnectionGUID: l/oh9JMoQgygpMKbshPR5w==
X-CSE-MsgGUID: wMrdRKAcTLq1GHBsjEoRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238502826"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:26:54 -0700
Message-ID: <fe3c24ea-5815-4c5b-a529-4f59f1ce540a@linux.intel.com>
Date: Fri, 15 May 2026 15:26:52 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-5-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> When getting register values for ENCLS emulation, use kvm_register_read()
> instead of kvm_<reg>_read() so that bits 63:32 of the register are dropped
> if the guest is in 32-bit mode.
> 
> Note, the misleading/surprising behavior of kvm_<reg>_read() being "raw"
> variants under the hood will be addressed once all non-benign bugs are
> fixed.
> 
> Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
> Fixes: b6f084ca5538 ("KVM: VMX: Add ENCLS[EINIT] handler to support SGX Launch Control (LC)")
> Acked-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/vmx/sgx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
> index df1d0cf76947..4c61fc33f764 100644
> --- a/arch/x86/kvm/vmx/sgx.c
> +++ b/arch/x86/kvm/vmx/sgx.c
> @@ -225,8 +225,8 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
>  	struct x86_exception ex;
>  	int r;
>  
> -	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 32, 32, &pageinfo_gva) ||
> -	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva))
> +	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 32, 32, &pageinfo_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva))
>  		return 1;
>  
>  	/*
> @@ -302,9 +302,9 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
>  	gpa_t sig_gpa, secs_gpa, token_gpa;
>  	int ret, trapnr;
>  
> -	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 1808, 4096, &sig_gva) ||
> -	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva) ||
> -	    sgx_get_encls_gva(vcpu, kvm_rdx_read(vcpu), 304, 512, &token_gva))
> +	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 1808, 4096, &sig_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva) ||
> +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RDX), 304, 512, &token_gva))
>  		return 1;
>  
>  	/*

