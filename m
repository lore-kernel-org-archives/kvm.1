Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747297;
	b=ibhv0mmifNOWi+XlDilygg4JRm4HyEP43Lwc535b7Z0JhJ03npasLyZyL6nY86RgsF+u
	 ujbYZvz7VvRASkFuHgI7ZrYcKayn5afKko4+B7zOVLn27MVgFA8bqCJhgcCz4Nr3AfZqu
	 v9oR0j/CrzKyxOHIJ42E3BqGxBuw+6Xb5ADOuLJp2sn1pw+UwyiA9yRTIzLwdqTf39HGL
	 9l1eMvk5SnSuKf+aUHrSmS4zG7rg1aG/DVB624FYSgJwiCweIjKSem1jkFX8IVwYB17wQ
	 lWw0p0ugEbYWJHeB/c2DEJMMBLQtned2WMBg0nSL1VsWwgCAWbbIDulojmC60nwRtig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747297;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=E01OFEDqH9sXZd7tPhFmVmg7Ca1ncXhpd94FrhXUEKg=;
	b=oh5zDsVuShjFHzj2+R+X5mNJ8t1Jpdyy0wiKRoamvCHnWfqtEqE3rqnbkHJfPVLILOiE
	 e2O5lv5ZHF+lrn/zwrgTNC9baIwfBDRTxzLPID0rSisUnfl3+PPqdbPXQYvLWm6THp2sd
	 YEV/OUviiuLz+QL7azpy5nsSRqvj0f/9bZxTQYPW4X9CYGgmNZDkGsgCRM18l7+LdPZRS
	 JnZMoaW+mawaGfhEm5FhVoEmyfuGJ/uN1/RLwsI8NcWLkJfgGVGRmQDhzYH2d2V7H+BmO
	 Isz7C1r9eOfQWTZbXaxr0QeKGVgNA+ncfNfzh8w4UdCi1utGnuWvISmlXpYF2eSdbgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hO3T1PDV;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45ED606A31E;
	Fri, 23 Oct 2026 09:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B45ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hO3T1PDV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792747298; x=1824283298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LFDdH9cxDx4nWcAvFzgFbCZpInF+MMfpZjdpF6Qea0U=;
  b=hO3T1PDVJb0lEnh3YD7/zIxjdt4BX5fV6TO9QkkoK5VNhLQNSjNTEbPw
   PjJwQCYWf4WREk9k4QWkwPuxHtArwhMM48vOUnI6cWV/Zn2FThjIYsYUa
   oRFOheWPM0qeF5uXGitBbg9Ovduj6YK8YmRXShecvenuu11cDkzQ+KQHU
   BbveGOdufZRprcYNp8woK1w3shUHyVfr4kHEDkDBK6p8sE4DVh8N339oD
   N/eBr9jSmueryhfwPMH0sYXHFaWPW16liicCuG6UHOaNCCfgTpbaMS1Tw
   5af1PXd9rb7dbizON5at1w4lqIEIkjF826O7hshHw20DDT2xYSADO/1rZ
   Q==;
X-CSE-ConnectionGUID: EOeKI8j1Qz+pRaQhYSj0AA==
X-CSE-MsgGUID: BpXVto6RSCud6N9Q4ZF5tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1612237"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1612237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:21:37 -0700
X-CSE-ConnectionGUID: kOs0lpCyS5KwgNZsqsOTFQ==
X-CSE-MsgGUID: yS19R6TbQwKWgi7eSHiYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4079337"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:21:30 -0700
Message-ID: <f7f84b44-e2fc-4d8c-b2e5-e5327086d026@linux.intel.com>
Date: Fri, 23 Oct 2026 17:21:28 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/28] KVM: x86: Add a helper to detect if FRED is
 enabled for a vCPU
To: Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org, x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-12-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-12-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Add is_fred_enabled() to detect if FRED is enabled on a vCPU.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> [ Sean: removed the "kvm_" prefix from the function name ]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> ---
> v10:
>  - Add back the change log (Binbin Wu and Sean).
> ---
>  arch/x86/kvm/regs.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 447f0ec3e63e..4e641a6c20f9 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -364,6 +364,21 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
>  	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
>  }
>  
> +/*
> + * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
> + * a vCPU is running with FRED enabled, because:
> + * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
> + * 2) To leave IA-32e mode, CR4.FRED must be cleared first.

It seems KVM doesn't enforce it in kvm_set_cr0() for 2).

> + */
> +static inline bool is_fred_enabled(struct kvm_vcpu *vcpu)
> +{
> +#ifdef CONFIG_X86_64

Nit:
This seems to be unnecessary.
X86_CR4_FRED is defined as 0 in non 64-bit build.

> +	return kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
> +#else
> +	return false;
> +#endif
> +}
> +
>  static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
>  {
>  	if (!kvm_register_is_available(vcpu, VCPU_REG_CR3))

