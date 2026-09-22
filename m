Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527EF1CAAC
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035403; cv=none; b=dCBbtMnCJB054UF+0sXdSmCtCgP+fE4AXNpluyeYy7/9aIwETECRCKd1wT0MMowLRZb8vvLWWZaYWGRyqxE/wU2GnuS5xc80BFziXiGgf93e3sLPux/ruaRglSl4iOeeXl0C+Hq3alMZIRUNtuSkfp3e7LtbjrQjvF71ilzJce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035403; c=relaxed/simple;
	bh=vKsQIcEbICL2cS538widqBhaX2fpHL1SWkPMaF1u46U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AazY2FmbNoRXFOfOD5TdGmTDGoIyjoYWoVb6hMSGRVwu7b/ZXr6VmMhxTEna7B0MCo4R/3g7aIlxsU5DuH4ZIRBjRnb0CN3Bwf0ahz/yK98Wrqw1qZvTtTkG71v0BdlVYZ3oecAfFgdVclABGBzSQdvwWxKHqq26Sht/PMS/EK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbzK8ioH; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbzK8ioH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790035401; x=1821571401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vKsQIcEbICL2cS538widqBhaX2fpHL1SWkPMaF1u46U=;
  b=EbzK8ioHsoRuuOgswojbCRS5P+0Ekifgoh3oBKa3Vk6OjYibXiyBEfw3
   p98aeNtoQPRoQmzkHF8JwRiYRz9CWU3JYABD8caNLTJh7tmWVzbxQ+7iW
   VC8aO/H+2LSnyE/e4jjSS9/c+97v5huLkacwX0tHlErheySThhzXZSSvS
   qrylNp/4JVqwRL+dAAwVRTWOxxg5KYXd/lpSEI2VLnyzf3ZGlBt1AbREe
   Vjq76TOZCEvzgg358Wad9UjrWs9MT4fGlC07crVqefInX+2sxV5wAy/KJ
   6Pu+Bci/5rx2J9xGl6Tw6jnRzXtm89HmABYub15UsVFCtqbLjir5KFX2+
   w==;
X-CSE-ConnectionGUID: nv5BEGEwSnGIM7PWAe6jsQ==
X-CSE-MsgGUID: CZehfk6iRXyLCTxH9WST/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1096830"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1096830"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:03:20 -0700
X-CSE-ConnectionGUID: R7rW5tmERD6T92VaFx1WNA==
X-CSE-MsgGUID: 08YlfDtETNegGtgVoaHHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="299121810"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.249]) ([10.125.109.249])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:03:19 -0700
Message-ID: <07297a47-9dc8-4e46-bb5f-fb228ba6447f@intel.com>
Date: Mon, 21 Sep 2026 17:03:19 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TDG quote analysis
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Yilun Xu <yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, Vishal Annapurve <vannapurve@google.com>,
 "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <aqxGN2Zc8sOl2RKx@google.com>
 <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com>
 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com>
 <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com>
 <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
 <arG7delLjerkKbYQ@google.com>
 <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
 <arHB1SACk4Z9kJq3@google.com>
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
In-Reply-To: <arHB1SACk4Z9kJq3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 16:46, Sean Christopherson wrote:
>> Oh, and folks can _theoretically_ do one quoting instance per VM. But I
>> think the overhead per quoting instance is in 100MB ballpark. 
> MB with an M!?!?!  What!?!?   How?  I was assuming my 32KiB threshold was fairly
> conservative; what is the TDX Module doing that it needs 100MiB?  That's insane.
> That's literally 3x the footprint of some full-blown VMMs.

First of all, I hope I'm getting my wires horribly crossed here.
Wouldn't be the first time I threw a couple of 0's at the end of
something accidentally. It's why I'm not a pharmacist.

Elena, am I remembering this horribly wrong? I think the interesting
numbers here are probably what the smallest possible extension TD (aka.
NRX TD) are, and then how much each quoting TD adds on top of that. Any
chance you could fill in my horrible memory?
