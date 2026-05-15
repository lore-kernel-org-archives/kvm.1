Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AD3803DE;
	Fri, 15 May 2026 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874197; cv=none; b=lSdypIw3sgojEyU2pVJxMsJRNVCYbfnf4vrQ0pOOrW1rkkCAoYkZ8Fyq+gQgrFiPfRPmz3Nhbhey3Zu1Ey1xVDbcu/s6M4bpTtHnTb8ofbC+9yYoURMSO+ltxutf9rFqp+PKU8+Jn1sVJbpeMPcLUhDGfmGgNrX6mPQCj58DIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874197; c=relaxed/simple;
	bh=fdIdDQDiHbbnW9hr54FGS+oiU8DVIb25pMlzmlFsHgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOeP7dbvN5q+mWVowSVIWYyayYqVY+B14Go9ha3xwGp+2Ow+eIh3Gn4peZPq4i1Z9vmjo2uPVDKODaCZ6Z8OKbSqNh7EfEyW02wSRMx6YzL/k4apXaHIQyfgH4d2q22UB+Ewjmhz2ENgC0vssxVTrVARicT2HnSlYQg/+mus8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPjSmTjo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPjSmTjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778874196; x=1810410196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fdIdDQDiHbbnW9hr54FGS+oiU8DVIb25pMlzmlFsHgk=;
  b=ZPjSmTjoJloXI/AsduQQZf3LP39BuQs+XLS8k15LpYkDdnHiOT2iOl/B
   SiEkup5iWZ4nAcBaR9hZkZG3uvh1Z8RCnfAi71YFGuhQZm9I4B7MJAkN0
   zz3dVNjV7FyPIDBbRu1PkztVh3ytBdyTpc+2nWOiobwXUToX4hR85DwBG
   n5AwSur9vpSoREZOH7DkFFO7Mfz0B3YGfL6ht0OSH+lK5dnnZLjaFvYMW
   1r4iyaVWU1nQfPyXecerzJ1MMFDgI6/LsBtapmshgZZfpWH7w3wupyOEA
   yQr1BxzT/H9CAx98gdDO46zKjRcOtIyOaquhLqbdBP3aYmqJnj6LCOIl6
   w==;
X-CSE-ConnectionGUID: tshg5X53Qnq6H7VxTnftsg==
X-CSE-MsgGUID: 9nj6ZPBxQt2S4hSQfgiJbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90144940"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90144940"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 12:43:16 -0700
X-CSE-ConnectionGUID: Pjb+8/1RRDit6jDnaM5+6A==
X-CSE-MsgGUID: g7ttQe65SuGAX6g6J5eimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243115885"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.201]) ([10.125.108.201])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 12:43:15 -0700
Message-ID: <488eeba6-5a08-4772-881f-7cf863f4a3f2@intel.com>
Date: Fri, 15 May 2026 12:43:15 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a module
 update request
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-12-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260513151045.1420990-12-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 08:09, Chao Gao wrote:
>  int seamldr_install_module(const u8 *data, u32 size)
>  {

Can we please do better than 'data' and 'size'? Even s/size/data_len/ is
better. This goes for the *entire* series.

Why not call it 'tdx_image' or '_tdx_image' or '_module_image'?

Second, I'm losing track of where these are in the process. Comments on
functions help. Here's how...

> +	struct seamldr_params *params;
> +	int ret;
> +
> +	params = kzalloc_obj(*params);
> +	if (!params)
> +		return -ENOMEM;

init_seamldr_params() should have a comment like this:

	/*
	 * @data points to a vmalloc()'d 'struct tdx_image'. Transform
	 * it into @params which is the P-SEAMLDR ABI format.
	 */

Then this site can say:

	/* Populate 'params' from 'data' */

To at least show the flow of the code. Gunk flows from data=>params.
It's *NOT* otherwise obvious what's goign on here.

Please go through the whole series and make sure you're doing stuff like
this. Comment functions. Say what they are doing at a high level.
Comment their call sites when what they are doing is not clear.

> +	ret = init_seamldr_params(params, data, size);
> +	if (ret)
> +		goto out;
> +
>  	/* TODO: Update TDX module here */
> -	return 0;
> +out:
> +	kfree(params);
> +	return ret;
>  }

