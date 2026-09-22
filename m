Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB252842D;
	Tue, 22 Sep 2026 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071541; cv=none; b=g/CacPIrbxyffzRZE075SPfqUabS4DMlPwuIe9LNmj2Pp9RlwGLOCf+TtulgvSEjCdZ5khzwI8iJdudin9EPTBcSc1Nrl3My7b1TZ/ptbAtIL5kNSNzawi2DYHa6uyEAYwmk0m8loCOUCggJwMFllGH6sTC2tWXAEbckInxikFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071541; c=relaxed/simple;
	bh=azqoBLcIRtkqga/94EgW9QqTc3pQevTwyEKoZ0sulzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqLcgkyGkOcyhZJ9YYCY2poy7y2F9bICD4PAdBcxju/oulEUOyFGLGCvKXuN0rLZ07EMq8n1UqePM+dE+eOM2ejTxJpopLgyavb3QXvPssuH1oxvhez/5h/dojQtBhF1VpGIXFiULygwc/hsbKyXXxqpYDzCds4UtRgq2Kz5xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ1RR8SQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ1RR8SQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790071539; x=1821607539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=azqoBLcIRtkqga/94EgW9QqTc3pQevTwyEKoZ0sulzs=;
  b=IJ1RR8SQh4dxjPoIguBi8rQAvC37YP03QFbHM9oHrUvcejVVLx3uFzqW
   /6LPhCqQF9IgXYLRiXsXskjG3qE9BX8dO9Lz6CKZcCVjwPztSeyDu1ecV
   7sVFJbbwtAL+IWMGzvezHBP6siN685N/VbDeWuPGT8kHG9MEy/VQclxd6
   mZUgCEp2Oh6hdKm2045vDt1jQN/nFVavEo5NKqAcCgMeaNh+yVdI9cj13
   xFohbDdFHsqkfmYDHB2kzhZqMF9CPiqnfWRm6d2K9SfcADTOGz7XB9nAV
   AnOM3r30dVVwIWs9VI3lmJyD+mZl3bfTXEotI8Mg/RCoV/4PGIjgDjHEM
   A==;
X-CSE-ConnectionGUID: zisI6daNS6+4vuVXeA3DiA==
X-CSE-MsgGUID: mSVDBkpUQAyVjT7I4bV6lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="102009456"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="102009456"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 03:05:38 -0700
X-CSE-ConnectionGUID: UgLfJpcqQdC+iRM7cpWMvg==
X-CSE-MsgGUID: Bc4Gm6yhSjmuIx4yAygBMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271625176"
Received: from unknown (HELO [10.238.208.182]) ([10.238.208.182])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 03:05:34 -0700
Message-ID: <620e7e38-4287-431c-8285-575c84aa1f6a@intel.com>
Date: Tue, 22 Sep 2026 18:05:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Binbin Wu <binbin.wu@linux.intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-4-peter.fang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260915092632.2822169-4-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/2026 5:26 PM, Peter Fang wrote:
> In preparation for dynamic Quote buffer size, replace the fixed size
> constant with a variable.
> 
> The constant is sprinkled across several places. Read the size from the
> variable instead.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

One thing below,

...
> @@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
>  
> -	quote_data = alloc_quote_buf();
> +	quote_data_len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> +	quote_data = alloc_quote_buf(quote_data_len);

since quote_data_len is a global variable, it looks no need to pass it around.

Same for free_quote_buf()


