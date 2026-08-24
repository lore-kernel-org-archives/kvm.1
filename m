Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F133546F7;
	Mon, 24 Aug 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584544; cv=none; b=pf3PXWV/cCF1M1TjF71RLwuL5iAtn5ythSCCy5u8TNPWYbb3RGwu3mmQKwVdjE3zpkZwQGyUKTECxKdf2aeK3f70RNudfmrWD9XCty7KEyqV4hSZQ9Lz/jNAuvD3/ZOkdD5Q+xPw4sSdhtwK19BKG6A1Bv0H2sRIMHU0lH/sA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584544; c=relaxed/simple;
	bh=blpA8OY4JE5bXReN2tfzd97azjD9+HtkK3+VwPEJQ40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm0XHWbUZQFEn2zPG7pN1xtLSuwwAt36p2RM5H4gYGfUQ+TtatRs/TamdIX8PUD34515weZEmViKzNr8moTnJoodObiAXx96CDxjfS0L6VgaofV3VlK3v94NmY/jEvImzbynbwGdZYYHHHbka3jdX+HXq3oXDVK6tWXBgkURI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxKEuq4U; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxKEuq4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787584542; x=1819120542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=blpA8OY4JE5bXReN2tfzd97azjD9+HtkK3+VwPEJQ40=;
  b=cxKEuq4Ubh6SNxvVogOmuATBUacCs6keBTML1XzcFNuAFO2Yo07Eik2D
   seBy+++wiKGdUjG/zej4PmG1xfsQELnOn/c1Tf68IZ4svbpe3LZjSq3QK
   jkJXptvwfEfhm1jZ5gc788T0epRAplrop15SN2Fv5FdTcQ86G2MayJGU+
   b/E2WPb71uHC0xFmWzQnto7cV8SHpaOFqd93LJJZ5JdOzPJzXJeYNdksa
   wHbwc3kjDjP6hYh357WZsN3qnTyeLk/NYyDXnVmbks4QiRezb1zP00Uh5
   E/Ieukd/p1rThK6GLb0KtAuGk5CkfrHHXUCVoYtcmSEa2FFLJDE2lGGlU
   A==;
X-CSE-ConnectionGUID: b+goZj2VR/G4GLuxfQsdrA==
X-CSE-MsgGUID: kZ8W0prGQCKzYd5nCUjdKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99563286"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="99563286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:15:41 -0700
X-CSE-ConnectionGUID: Gy2yMNMKSg2G0I5Z6ZxFKw==
X-CSE-MsgGUID: GWZXmF2ySiWpFT14r//GXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264411279"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.108.191]) ([10.125.108.191])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:15:41 -0700
Message-ID: <22bf174e-788b-4038-84e0-c6bea351830d@intel.com>
Date: Mon, 24 Aug 2026 08:15:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX module
 init and update
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kas@kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com,
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com,
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-3-yilun.xu@linux.intel.com>
 <27321cc1-5428-4590-a88d-b2824659c89a@intel.com>
 <aovmxjpVFqOR3QXm@yilunxu-OptiPlex-7050>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aovmxjpVFqOR3QXm@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/26 23:37, Xu Yilun wrote:
> On Fri, Aug 21, 2026 at 07:38:42AM -0700, Dave Hansen wrote:
>> On 8/20/26 20:29, Xu Yilun wrote:
>>>  static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
>>> -				 u64 nr_tdmr_pa, u64 global_keyid)
>>> +				 u64 nr_tdmr_pa, u64 global_keyid,
>>> +				 u64 addon_features0)
>>
>> addon_features0 is just a copy of the global, static, not changing
>> get_tdx_addon_features0() return code, right?
>>
>> Why pass it around as a function argument?
> 
> I thought that we need some place to explicitly see the TDX ABI
> definition - what are the inputs the host should provide to the module.
> 
> The addon_features0 is the *option* the host should provide to the
> module according to the ABI. The global, static value for addon_features0
> is Linux's policy. So if we need to explicit the policy by the code,
> this helper and its arguments are good places to show the boundary.
> 
> But yes it does add boilerplate to the code, I can drop it.

I'm not arguing that the helper should go away.

What I'm seeing is this pattern:

int helper()
{
	return something;
}

int func_low_level(int arg)
{
	// use arg
}

int func()
{
	int foo = helper();

	// use foo

	func_low_level(foo);	
}

When it could use this pattern and just call helper() twice instead of
obtaining its return value and passing it around:

int helper()
{
	return something;
}

int func_low_level()
{
	int bar = helper();
	// use bar
}

int func()
{
	int foo = helper();

	// use foo

	func_low_level();	
}

So that's what I was asking. Why pass the result of helper() around when
you can just call helper() twice?
