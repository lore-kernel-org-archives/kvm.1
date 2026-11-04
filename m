Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775474;
	b=TKmEzr7EQm3K79Gey7NJ5Olg/MFybxMeyUqrqGF2PJe9j0SoaLSkrw9RMRvkMrDHTrZ2
	 0TKYPHTpYaAHr/VI75ebTOGpFFcJz4LowhjaGnmaOBXKA10dvH97M6ZPn+L2BFxZoodtn
	 WDR6vy/++PujEPMRd1/vaSUwxTMOQxbyprJIju7XdLlgM+mO2kPAgxdpLTxMdnI3hD19N
	 we6y4VhC3wTHzKeseiKFwhnsqc6DirQ8NZwnjMYve6mKhbAubZKED42yyzKfPiPhNwy9I
	 EFEkTqGUuj1+DTgZuaL8+mCJwJ3rUYa7k9suGr5IyCor8YmOkXg8f3IozQ+8odRLuuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775474;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CtbI9z2Ao8Mb8HCETNcNamwRtXTU4jMBmej4A4WGLvs=;
	b=cyX0ZP+3e5m42eMc2jj2yKcP2vk1tt1/S8HLuQRFgkRZyKQed9sDVsLB6mfckldUrbzA
	 X9LrayOi/boMlRwb2gEIU454PQF9RyxYh8PF95hINsUgVYmEtz4m9XgtaI9wqRgqfzFa2
	 xd9s8g4o7Wccmo2g4kJHFIVZaCei2c9uzZPgC/+FCURgzYyKREHwqqEwv5aiFth8JdX7C
	 s4IDVmuhGFl2mB2ZF8SMfvdKtoHwkF3xYRVI7hyPkfdgFxkd5St7SKAkVzeWf5qqfsbHY
	 7LaFymUbOHklT3CsVb1jvUNSwR0nkeU3cqQa5nDw4A9OPfsjLwIgJ2sP0ulYS55hgZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PfpmsAnQ;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B9606A31B;
	Wed,  4 Nov 2026 06:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51B9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PfpmsAnQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793775474; x=1825311474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e3HUinfHssBFc/cB56hXJKEMk6fiHsv3VhTWwxJA+cs=;
  b=PfpmsAnQijCrRLksLiRbq31a1oUKZimlpuK+7FngZaHkXM9FrvGbCjzs
   SG1a1gs4xJ2HHfsvoXKIwUNI/Ay8XqTgeoy7yBDnnjSY9ND7okNh2wfF0
   59JsVHVkeB+///knsyMx+GIMjHObhbJf+E7KFuT1XBo9Vl8qmLT3vf42l
   B7MWzZh6PL/pJb9JtPIF/ChgKJYLUY5yn5IZTimjDOURYakcG3r7HtFwg
   IUVsUztmPBiaAVJTRpBfW5tymcaQXrahUqfOsS6K2yGrEbyS1J2lyIWkF
   txRHwp6rJaAj+wVuXs+5B0NvShEqJYCZCBJQ2Mm8qq3SqUD8iSamWd5eH
   A==;
X-CSE-ConnectionGUID: 2gf2/0L7TNSzmNj8xbYlsQ==
X-CSE-MsgGUID: +fM7WvzrQG+jeFoAuzMMJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2421503"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2421503"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:57:53 -0800
X-CSE-ConnectionGUID: LTtAi5YgSO23D8S37DP0zA==
X-CSE-MsgGUID: 1zbJOZF7TvqTJvio1dI5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6659557"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:57:48 -0800
Message-ID: <f5a4c1d5-cb66-4efa-80c6-92b7d8f543d4@linux.intel.com>
Date: Wed, 4 Nov 2026 14:57:45 +0800
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
Subject: Re: [PATCH v10 22/28] KVM: nVMX: Restrict event data VMCS fields to
 FRED-supported hosts
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
 <20260911213659.2025974-23-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-23-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: Xin Li <xin@zytor.com>
> 
> Prevent L1 from accessing the ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA
> VMCS fields via VMREAD or VMWRITE when FRED support is disabled or not
> present in KVM.

I think the change log should tell why the patch only restricts event data
fields.

> 
> Signed-off-by: Xin Li <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v10:
>  - Split out of "KVM: nVMX: Guard SHADOW_FIELD_R[OW] macros with VMX
>    feature checks" and renamed (Sean).
> ---
>  arch/x86/kvm/vmx/vmcs12.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> index 837cb3d568c3..67c730e31465 100644
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
> @@ -222,6 +222,9 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
>  	case HOST_SSP:
>  	case HOST_INTR_SSP_TABLE:
>  		return cpu_has_load_cet_ctrl();
> +	VMCS12_CASE64(ORIGINAL_EVENT_DATA):
> +	VMCS12_CASE64(INJECTED_EVENT_DATA):
> +		return cpu_has_vmx_fred();
>  
>  	/* KVM always emulates PML and the VMX preemption timer in software. */
>  	case GUEST_PML_INDEX:

