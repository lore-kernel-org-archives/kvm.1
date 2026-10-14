Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A8395AF8;
	Wed, 14 Oct 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993576; cv=none; b=qGtUFVZeZdl6Tihge9VgVqxnFtRTPnENgC+26sWXVORXVcG0ptkXjwolpseThauMm5Q9rv3I93116CTL+a/JlpW9yiaI8Czg9+j+3nFaakNX0lEl113MGE3kXedOt51+5TlpOk0j2dBIju2eDYyD6ROuAV0Eu2XEa5VeUAkxPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993576; c=relaxed/simple;
	bh=WUMo5RJUrn77m2nX4zEX68U+Ul+lscPwev0cXcLqpO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnYaZXtGaAQyx4nMlV7Tp2LT+sYsBR6yl4WgNdDsOh3fdVm/EaynapY/3PldS75nIUhmwGbC1FClijohISsSo1trADZ02ouYGJI5MOqpH2WHj40a7+yefHNGp4Z3HFJiS+XD3JCsiaYN/oRAs2rTFuF0g9sReEEBG5Yws5tBjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5zHrduP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5zHrduP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791993574; x=1823529574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WUMo5RJUrn77m2nX4zEX68U+Ul+lscPwev0cXcLqpO8=;
  b=T5zHrduPsSxxocAP7ZvZUUImLBPJzA4IIJDBk4zTkn/A2XF9wwWxNFM3
   DmbSGGXPvSNqKeRPzoJuGsVcDxr0GLM82CO5GtddP72bwbQZqkJx+r+Us
   QC5fQM/UXKW0W7YQxwCJXgZVq9BLlq9SmPvLhBVSpNhe5u7brUukanP/t
   ef/JajG4kl47RlJJzGQfpJA1uBhY82wj84OVkzFQE/YsJXaRKuSb6JsQs
   Y8jx7+FzPdorUptlUjwxLLVW/sTrYosvgUN8gA1aEAs9P0xFBq0hz65uu
   xBgr+Q7yZSqEGTHpSkAohJF6JisY6F0uf3ONavVsrD5OK1cci9sBtO4rm
   g==;
X-CSE-ConnectionGUID: gjgdptpOTuaAfoD/wkwnOA==
X-CSE-MsgGUID: fPJWx6/TS9iCPNZJpvXhSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="844966"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="844966"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 08:59:33 -0700
X-CSE-ConnectionGUID: UafhCUUaRrCB88B2XL5vaw==
X-CSE-MsgGUID: wLbJRdF5Qs2oOZwrJxweCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1797720"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.110.30]) ([10.125.110.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 08:59:32 -0700
Message-ID: <c74922f6-7d74-43c1-9780-ce09eeb02b44@intel.com>
Date: Wed, 14 Oct 2026 08:59:32 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
 adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com,
 artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
 <20261013-tdx-module-ext-v4-1-de5ffac65470@linux.intel.com>
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
In-Reply-To: <20261013-tdx-module-ext-v4-1-de5ffac65470@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 08:28, Xu Yilun wrote:
> SEAMCALL wrappers are introduced to avoid broad SEAMCALL access by
> exposing only a selection of SEAMCALL leafs, but also to abstract the
> SEAMCALL register ABIs. The abstraction improves readability and reuse
> for SEAMCALL leafs that are called multiple times.
> 
> Some SEAMCALL leafs are not explicitly wrapped because the level of TDX
> ABI details needed to perform the call is low enough to flow well with
> the calling code.
> 
> For some of the currently unwrapped SEAMCALL leafs, the TDX architecture
> has evolved the ABI to introduce new leaf versions. The host can select
> the version to call based on what is supported by the loaded TDX module.
> When future kernel implements this version selection, more ABI details
> will leak into the surrounding caller code, which decreases the
> readability of the caller logic. To keep the ABI details contained, move
> the SEAMCALL leaf that will need version selection into a wrapper.
> 
> When defining the wrapper, the cleanest separation would be to have
> kernel data types for the SEAMCALL wrapper arguments, and have them
> marshaled into SEAMCALL leaf ABI types (often u64s) inside the wrapper.
> This works for many SEAMCALL leafs but becomes cumbersome when the
> register ABI type is a physical address which points to a buffer for an
> in-memory ABI. If the SEAMCALL wrapper only accepts kernel data types,
> it may need duplicate buffer allocation and copies to match the
> in-memory ABI. Another solution is to define a named helper structure
> that mirrors the in-memory ABI, populate it in a separate flow, then
> pass it to the SEAMCALL wrapper. struct seamldr_params is an existing
> example of this pattern.
> 
> TDH.SYS.CONFIG requires a list of TDMR information in the form of a PA
> array. The PA array is the in-memory ABI. Create a structure for the PA
> array, use it as the argument when creating the wrapper for
> TDH.SYS.CONFIG.
> 
> For readability, adjust a bit of the existing PA array size calculation:
> use the new PA array structure's element type instead of hardcoding u64.
> 
> AI was used under supervision to review code and workshop logs.

I'm wondering if this is a case of AI gone wild. There's a *LOT* of info
there, but I'm not seeing the thing I really want to see: Why is it
worth creating this helper _now_?

Also, the move to tdmr_info_pa_array seems 100% orthogonal to me. Why is
it here?
