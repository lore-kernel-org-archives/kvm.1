Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342587;
	b=3YA8W1DWgIwzPgo3OmZMA1VQ7tli9F8RZdjAnupeD9dn6mC326QJh6/MgoMj089gUGBm
	 KA+v9F0IN5+xER2AV2PDXQQeLhKC9BMhgjTr06buUMqP+IhEEwBsUDsE1abQRAVjif6WY
	 IAc0v42TGUhKiefJ96/cd7RNvJVrfw8NC9YnaaD5Kd415Ade9UScXFmHuZjW+wwKLEHZB
	 DUS4AW28kZpw4zVKRCvdeoItMCEq+/Sai4LINHTrO7ZEzG20K6bjvBI7FzIEqz2xvXUrO
	 qXeFnS/l1y5r67c+tCtXT2oveXVzbdVRcAgL/cdgo4HCdudiOwJJ/Rfl5m88dhoYVvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342587;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JuXi952FsDjJhJT+JGh3Ua47MpEPJYCkj3UAjd1LQec=;
	b=FLYiF0+fmgLSSVGZ+YUEqotDhr4I7xk07WxWXCg37+WEovCOdEM3qEVMdzRbSRW0qJQw
	 Qk0fPv01tER7VI+Lnaj8Huk9e9ZpuPChWomkb3hEeu5QD15GXcho/s9EFuYK/mIK6D3Bl
	 UWJoQBfJnHeJLJZxPlFlRni2eulDYJ38VIe47aDRiIpukMJ1fRZNf6ZfgWSXOGojem8sK
	 bugBIj3Y+yAxobjDW5zxXwj1pDM/g4n/XntAI3jm0fmP8mmlb3cQJuyP0Yu+MVS7FNnpJ
	 +UQSc3yTJfOMEYun983iYHnUZEphl9YugB8SBCpRL7qNMiEu/SM3A1pzqu3QAGZCj8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CS0uuwo6;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A4606A31C;
	Fri, 30 Oct 2026 06:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CS0uuwo6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793342585; x=1824878585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pq35H8oWxEAEfaKcFCrhRdow2wrZ1TGL9MQL4x0/uII=;
  b=CS0uuwo6y28o+H3sECVaBlzH6RtlN2KnXrFzvKVxi8qbD9yTWwzoTA0s
   iuK0+seE+s9ZwHT0OucKxJTT31gzzpyYz1eTwjyh/vqttbqN3P7fkOEDi
   8Fp87uNNcnksWuwpPESNpq1dulWqam7fkjK34bmPYxAGhZTxYNMXZbb5E
   PTjSHiY2hnOx+gYt8FLDGBQxzfWgJkl72mQu8KMiiMx7rz9lrki4em/wN
   opRGdOOCu7hMrSWrAOQIJbsN4o62t1pHee5gtyEi9+2J8XXvM+yTBe/Wh
   +sj9rlGMbJu5C51YXbFbw/M+EskcFdcO224pebcNcrXW3+qjH02MvLSvo
   A==;
X-CSE-ConnectionGUID: FEk564pERky1Wtghfhxi8Q==
X-CSE-MsgGUID: TWB5dFnSQHO+9wCSz8VKvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2193165"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2193165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:43:04 -0700
X-CSE-ConnectionGUID: jQA90I7vS8SfeoBXB8ahTg==
X-CSE-MsgGUID: yGXTMymSRTiwYhgOcsrVSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5253035"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:43:00 -0700
Message-ID: <51fb9ceb-3fff-401c-8e6a-2a249e3f358f@linux.intel.com>
Date: Fri, 30 Oct 2026 14:42:57 +0800
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
Subject: Re: [PATCH v10 16/28] KVM: x86: Mark CR4.FRED as not reserved
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
 <20260911213659.2025974-17-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-17-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when
> guest cpu cap has FRED, i.e.,
>   1) All of FRED KVM support is in place.
>   2) Guest enumerates FRED.
> 
> Otherwise it is still a reserved bit.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v10:
>  - Check CR4.FRED against IA-32e mode in kvm_set_cr4() instead of
>    __kvm_is_valid_cr4(), so that KVM_SET_SREGS no longer rejects a CR4
>    and EFER pair that are loaded together (e.g., when restoring a FRED
>    guest)
> ---
>  arch/x86/kvm/regs.c | 7 +++++++
>  arch/x86/kvm/regs.h | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index 8f66438989e4..ba6c8856b4ff 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -429,6 +429,13 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  			return 1;
>  	}
>  
> +	/*
> +	 * FRED can not be enabled when EFER.LMA=0.  Note, MOV to CR4 outside
> +	 * 64-bit mode clears CR4[63:32] so only emulation can get here.
> +	 */

Could you elaborate what "emulation" means here?

> +	if ((cr4 & X86_CR4_FRED) && !is_long_mode(vcpu))
> +		return 1;
> +
>  	if ((cr4 & X86_CR4_CET) && !kvm_is_cr0_bit_set(vcpu, X86_CR0_WP))
>  		return 1;
>  
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index ef46918daf43..5db01693ad07 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -28,7 +28,7 @@ static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
>  			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>  			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
>  			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
> -			  | X86_CR4_LAM_SUP | X86_CR4_CET))
> +			  | X86_CR4_LAM_SUP | X86_CR4_CET | X86_CR4_FRED))
>  
>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>  
> @@ -423,6 +423,8 @@ static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
>  	    !__cpu_has(__c, X86_FEATURE_IBT))           \
>  		__reserved_bits |= X86_CR4_CET;         \
> +	if (!__cpu_has(__c, X86_FEATURE_FRED))          \
> +		__reserved_bits |= X86_CR4_FRED;        \
>  	__reserved_bits;                                \
>  })
>  

