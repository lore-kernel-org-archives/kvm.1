Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52432D876A;
	Thu, 30 Apr 2026 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577153; cv=none; b=AKd5rONbB/8iGxrZWmoDd0UJtWdqDAlEIVtr7nmfoXuSTUMWy6zNmMlsQMVxWji3IDEXS3yK6H7w4XPAwsiW6cnwN9nO7RVdR0J95M00iiSPQCFDTWMPi6OFLxUWmybMc2uhlOuiLZviQBH3NKjkWuNFGjSVZSYPZa0Ejv2CEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577153; c=relaxed/simple;
	bh=6dBDporUOHlhRFoPnEKMbDDUiZkzE8G4e/S74V9XVU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7UVaAU+f511oYQzWhufD4OG7TSkB12sD3HpZluPZhYeXm5X5iiz9FavgahBs/t/Ko1yv8GL1JFKO6q9L2nmhwVGc1XhHw/+hWSrbX9fRVdh5aIdSS/E1vtjVDgA73h9BE0K0+QklX+17JfbM/U1xLWyN0k73LbrO7ZHnvo0wAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcjEfc0K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcjEfc0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777577151; x=1809113151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6dBDporUOHlhRFoPnEKMbDDUiZkzE8G4e/S74V9XVU8=;
  b=AcjEfc0KVG5iscEUOFYeutlLUstCXtaHbwJQLdu0YsNcf51I7KKjpCEh
   xOigpGQc+yV6SM/Pn68FNpW9n8IrvNAl1HIsjfAjqixEyKEpX9rNvzWw9
   ljRzLWEhh8behIaVagI4CNRJKV51rP5rJrzAiRsh4M17Qz9XpJXGkWiDQ
   f4l+Qb6Mz1dr6QjwbbGacO5bqctg7T41V8tYgVefydFi8/+zQtKaOsA1t
   bSWpH9PZIcV6qdvnTcfKgBX2pvUfGuLyKvDpH4nPMfLzGFBUDzT+48S5r
   L1AX41WDWFst3vUD8EMhzvNXwKnZhlQCdibJ1DZoJw/bbaQ5N31cbDIN2
   Q==;
X-CSE-ConnectionGUID: UVojYwbZQXWc3A/RH0+g2A==
X-CSE-MsgGUID: msnjbHDwR5W7V1dY6MtrTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78645274"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78645274"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:25:51 -0700
X-CSE-ConnectionGUID: tAPjKxIiQeKGOF2OzOUwUA==
X-CSE-MsgGUID: 8qty0iXFT0KKTe2S/aTqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="230324251"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.109.74]) ([10.125.109.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:25:50 -0700
Message-ID: <36c477ba-13b0-4361-baf1-16cb19648f64@intel.com>
Date: Thu, 30 Apr 2026 12:25:51 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/21] x86/virt/tdx: Reject updates during concurrent
 TD build
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-17-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20260427152854.101171-17-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 08:28, Chao Gao wrote:
> tl;dr: A TDX module erratum can silently corrupt TD measurement state if a
> module update races with TD build. Handle that by rejecting the update,
> instead of introducing new TD-build ioctl failure paths.

The downside of this needs to be discussed. Namely that module updates
can be blocked forever.

> Long Version:
...

This explanation is confusing.

Focus on what the patch *does* and its features and downsides.

*Then* broach the alternatives. But, please, clearly separate out this
patch from other opining.

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index de822ed9ef0b..b063aabe2554 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -26,11 +26,18 @@
>  #define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
>  #define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
>  
> +#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
> +
>  /*
>   * TDX module SEAMCALL leaf function error codes
>   */
> -#define TDX_SUCCESS		0ULL
> -#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
> +#define TDX_SUCCESS			0ULL
> +#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
> +#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
> +
> +/* Bit definitions of TDX_FEATURES0 metadata field */
> +#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
> +#define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)

Refactor first. Add new features second.

>  #ifndef __ASSEMBLER__
>  
> diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/kvm/vmx/tdx_errno.h
> index 6ff4672c4181..215c00d76a94 100644
> --- a/arch/x86/kvm/vmx/tdx_errno.h
> +++ b/arch/x86/kvm/vmx/tdx_errno.h
> @@ -4,8 +4,6 @@
>  #ifndef __KVM_X86_TDX_ERRNO_H
>  #define __KVM_X86_TDX_ERRNO_H
>  
> -#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
> -
>  /*
>   * TDX SEAMCALL Status Codes (returned in RAX)
>   */
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index a7dfa4ee8813..7864ab68f4e3 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1234,10 +1234,13 @@ static __init int tdx_enable(void)
>  }
>  subsys_initcall(tdx_enable);
>  
> +#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT(16)
> +
>  int tdx_module_shutdown(void)
>  {
>  	struct tdx_sys_info_handoff handoff = {};
>  	struct tdx_module_args args = {};
> +	u64 err;
>  	int ret, cpu;
>  
>  	ret = get_tdx_sys_info_handoff(&handoff);
> @@ -1248,9 +1251,26 @@ int tdx_module_shutdown(void)
>  	 * module can produce and most likely supported by newer modules.
>  	 */
>  	args.rcx = handoff.module_hv;
> -	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
> -	if (ret)
> -		return ret;
> +
> +	/*
> +	 * Mitigate the erratum where updates can break concurrent TD
> +	 * build. Do not pre-check support for this flag. If unsupported,
> +	 * rely on the TDX module to reject shutdown requests.
> +	 */
> +	args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;

"Mitigate the erratum..." is a strange way to start this.

This would be a much better format I think:

	/*
	 * This flag will <say what it does> if <triggering event>
	 * happens. That eliminates exposure to a TDX erratum which
	 * can <explain bad things here>.
	 *
	 * This flag is not supported by all TDX modules and may cause
	 * the shutdown (and subsequent update procedure) to fail.
	 */

> +	err = seamcall(TDH_SYS_SHUTDOWN, &args);
> +
> +	/*
> +	 * Return -EBUSY to signal that some ongoing flows are incompatible
> +	 * with updates so that userspace can retry.
> +	 */

	/*
	 * The shutdown ran into a "sensitive" ongoing operation, like
	 * TD build. Signal to userspace that it can retry.
	 */

> +	if ((err & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
> +		return -EBUSY;
> +	if (err) {
> +		seamcall_err(TDH_SYS_SHUTDOWN, err, &args);
> +		return -EIO;
> +	}

Whitespace between the if()s please.


