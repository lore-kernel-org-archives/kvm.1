Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738160;
	b=on5JhwaBqyrbO7oGsUsWu+mFozOmqT/75gDlG2+f8Joba8aOTNhrke6w7A0KeJSg0jQz
	 Esb2kVQIZ3KcXASR4vsTRWq7xGTfsgCtWYKXxb3IZNLaZC46C2iJMLX9DdVNGPpYRvGTP
	 mXH4afLnmFqDqpZHU4N2VwJrpRn5hkAvsNVaid89JH3000rkEgkw417M4OWI5fCkMSeZt
	 n+B10uHggWk89dOphAvAsQtm+hbKf0UThpusVSLMKihkseEj6HoZ1tSjWkjGAJAaNnK4j
	 EvcrmFdbZM5xncx+hHcGIgIGTq4LTj3JFbxB1NeBSxoHiMa2gvXpMIkmENdzgfxE88Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BwLp3QfU2sOxvBZM8DouICo+apOt//WLVr04keFV3KA=;
	b=KFNyEy7nlXQwX5cXEABtx/6rWnQLzVjNbLeV8Pc/BuDa+OHRouKC4GcAVooaSeLCo5cY
	 fdyHj6q5mjG0FY3UGhVHBXgWQbXqNm9+6rrdqNFudpa6bAn+LCCu+T69OGYwiaJewBrWf
	 n1gvIqJh9UVj2gqOOOLiHTzbEmxV3pZvdHu6yexHnfQQvwXHJxhul4NUdFSJDYy8fC4Jo
	 k6yHYUR9DHhK1LztonabvsL037UhmfP8gN0rHKIymkL+VQimUL4z3FIw2cW4J7U6093n5
	 G4O8aCqO5d1FtpK4w8L/KtrigTjVtGtzRuXHnkH3lbUxXst6WEdnu+IY5fCu+5P0bbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZMd9mc3M;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0B606A31D;
	Fri, 23 Oct 2026 06:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF0B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZMd9mc3M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792738159; x=1824274159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=boXZwJMU/3Bv1Xe3K7Nqjbqy3UaF2PKOM3J7JBumcJM=;
  b=ZMd9mc3MOMmJXntdZOJfSp0keU+I8maH/K4jUbG7wQUky6Cv5nyT+oPN
   2vi891BmKssjyZIEovjFw80/evC5kWwXexqE+xqKuHSCGiA1Lkr5sGkax
   eGlO1dcauPDQuJzuwaKlqffaFQw98PHCQLdgMHQ4yfKlpjA1vJ4dNtMu+
   qZf9i7HrakEeLJmH+KVm8SPikyWyABb4y4tHkHO9ErmTHhYMp8q471HnF
   JgA4XBpXfRQwppIouzRJVUJ8CfCv+Kyni/Ymq5wOS7d+pBsfvoqS+wLpe
   hTwewOmb3E4Vh2jCeEopa1uBiBLKHsbz0psdWABwm62g4DFiLKwnMnwpA
   A==;
X-CSE-ConnectionGUID: VAbShD2ZT025p+sXznVhzg==
X-CSE-MsgGUID: upGeNo/aTmW3YBgQnSix/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498003"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1498003"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:49:19 -0700
X-CSE-ConnectionGUID: 6IigzIhqSvKN3h/YLYaUmA==
X-CSE-MsgGUID: 1pPxJ9cpQ96AIShE8W0lFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3465966"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:49:12 -0700
Message-ID: <85872794-1868-406e-8ac0-5d9de522a8cb@linux.intel.com>
Date: Fri, 23 Oct 2026 14:49:10 +0800
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
Subject: Re: [PATCH v10 06/28] x86/fred: Export this_cpu_fred_rsp() for KVM
 usage
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
 <20260911213659.2025974-7-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-7-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Introduce and export this_cpu_fred_rsp() to provide KVM with a self-
> explanatory interface for retrieving per-CPU FRED regular stacks for
> stack levels 1->3.
> 
> FRED introduced new fields in the VMCS host-state area for stack levels
> 1–>3 (HOST_IA32_FRED_RSP[123]), which correspond to the per-CPU FRED
> regular stacks for stack levels 1->3.  KVM must populate these fields
> each time a vCPU is loaded onto a CPU to ensure a complete valid FRED
> event delivery context immediately after any VM-Exits.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Two nits below.

[...]

>  
> +enum fred_stack_level {
> +	FRED_STACK_LEVEL_0,
> +	FRED_STACK_LEVEL_1,
> +	FRED_STACK_LEVEL_2,
> +	FRED_STACK_LEVEL_3
> +};
> +

[...]

>  
> +unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl)
> +{
> +	switch (lvl) {
> +	case FRED_STACK_LEVEL_0:
> +		return __this_cpu_read(fred_rsp0);
> +	case FRED_STACK_LEVEL_1:
> +		return __this_cpu_ist_top_va(ESTACK_DB);
> +	case FRED_STACK_LEVEL_2:
> +		return __this_cpu_ist_top_va(ESTACK_NMI);

Nit:
How about adding a comment to state NMI and MC share this one? 


Also, currently, FRED_{DB,NMI,MC,DF}_STACK_LEVEL are defined as
number, may be it can be defined using the new added 
FRED_STACK_LEVEL_{1,2,3}

> +	case FRED_STACK_LEVEL_3:
> +		return __this_cpu_ist_top_va(ESTACK_DF);
> +	default:
> +		BUG();
> +	}
> +}
> +EXPORT_SYMBOL_FOR_KVM(this_cpu_fred_rsp);
> +
>  /* Must be called after setup_cpu_entry_areas() */
>  void cpu_init_fred_rsps(void)
>  {
> @@ -84,7 +102,7 @@ void cpu_init_fred_rsps(void)
>  	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
>  
>  	/* The FRED equivalents to IST stacks... */
> -	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
> -	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
> -	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
> +	wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
> +	wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
> +	wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
>  }

