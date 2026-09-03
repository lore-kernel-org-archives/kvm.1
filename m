Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C339A4A7;
	Thu,  3 Sep 2026 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415182; cv=none; b=m8AyhS+g0O8ToTKPIYisyGHlTzhad/A2gWtkbMvIje3VF/6XjrO+8I9+XBScewMU2XfC2/t4UZB6PnNfRg4GXBZ5RQuVI9Lk4rMOeGqD6VR8D7BUTj/JpzWVf60gXEBrOrvflrRs7k7TnoXmbbaQ2daqnO2LvkukNuo07Yyltjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415182; c=relaxed/simple;
	bh=FfxYG0CZyWtxZUhsaC3BQ6+9g8CCmMqS+gpG7CSvN6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seYVRB8VKX8ZvOR2kaPCX2jnuFw+gT908JzrKRhrQXXpGeA+mqx+bbA/0DAV2AoN6KtB6PtW9jOHJn9KVRVlhbfKELZ9qo/ZyxgyfLPRaFnLH5tm6dCW4LxWlpHtCVyu/S8hAhQD9jm6Phd7L6yaSkv66obONMW67xmCAgUuzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIIEQZUH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIIEQZUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788415176; x=1819951176;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FfxYG0CZyWtxZUhsaC3BQ6+9g8CCmMqS+gpG7CSvN6Q=;
  b=HIIEQZUHEcIjqxkLdAqqbcbrSCULMRbH66XCJX3j6Sdh3fps0t10PRho
   DB+/4sEK289eM1rMf/uUcskMkA5JZftrRFEq5jXIv3sCkeY53crPpAFFG
   +X0ytDX1DYFTq2yj/AnNPJT/efvZXTOX52LOHdhE4L7ioc+utJlsyv8Mi
   KE2kHDU4Wt1Fe5DJcX2VxswU5Ltnrh91EAUoVdsJK1bT1524pZHfF//uv
   CXSl2MtUsbx3DJ/Vh2kraRlxNYb3YJcvAttSyAE9QJGe8m7zolDfSDQOA
   3Y2qI5/8jY3a+xK9zT/Tk2mDf8ei3Dfwbcs5Is1x6bUak2orwCIvR62YK
   A==;
X-CSE-ConnectionGUID: SrXGic7hSQCHNUgT4rVEdw==
X-CSE-MsgGUID: V7dzE3I9QTqF5WLqTfp87g==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92586132"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92586132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 22:59:33 -0700
X-CSE-ConnectionGUID: SPhLGJ/LReSeuEdcucE+GQ==
X-CSE-MsgGUID: xhaZAg/dQ7S+U423fKUGtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="269626375"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 22:59:30 -0700
Message-ID: <e6121cf3-83eb-4cc8-919e-2557fbcab3c9@intel.com>
Date: Thu, 3 Sep 2026 13:59:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
To: Peter Fang <peter.fang@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
 <apit+fXmapCA2qlc@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <apit+fXmapCA2qlc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 7:15 AM, Peter Fang wrote:
> You are also dropping PAGE_ALIGN() in alloc and free calls. You can
> mention it in commit log.

I think it's better to keep the PAGE_ALIGN() when assign quote_data_len,
although GET_QUOTE_BUF_SIZE is aligned already. This makes it super clear
we want to page size align the buffer.

And in next patch, we can make it

  quote_data_len = PAGE_ALIGN(get_quote_buf_size());
