Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719923D6CD9;
	Tue, 29 Sep 2026 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648024; cv=none; b=uo/bDNkQiof6x8aqr5FssmT1DX5IBNpHjWwkdetg79TgRBDVhC2j0+DMFi3eiedh/0CdexeXXCOm29GXBin9qvNSb3Kl9Fu5PDWiVZgkFO94FkRsxyB+kSuN9xDTN6j/sU+AJ6aBF4O0kxGC6pwCi5DdYKiZbIBrNVv+moOR9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648024; c=relaxed/simple;
	bh=Pp5VRBkjB4elVFpl2f1Es0x5rsY1T7If7PisaWtPJD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMAOug1rSfKBJPfa32+hb1qYyE0zaATaQ1UjBZRZUmvkGzCrprN1VwEK2ou5BP/dhqMhTj2W3PfTn63XR0/lJqDGmg40oA9Ui7rJJ09plC26z9uc3QDDG1W1x/Ky9vA5wQKRsxmf1AOqi6qyRqYua9KKE2rSvEuH5VihAS6cZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIa97cbf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIa97cbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790648021; x=1822184021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pp5VRBkjB4elVFpl2f1Es0x5rsY1T7If7PisaWtPJD0=;
  b=EIa97cbfQBjPkdXnXynVVX43Jj+EMpCGYEp5snl8hapuftY926wrQA32
   RWDFf1Ux2lP73MZlI+NwBD+nauu2Jl6kos8wOS9y1rFulvb4ww7mBszrv
   LjaEOVntqNdd9l1sg3BMZDpHFnraGIg1PZgDw0TcFy8caCVScLraUGNOI
   cP2yvniZt0Y5OZlorOIDhIOtfeWYd00c5a4HU6a5VbqrP08jd2HKge1/M
   E5hHWOQyRPL5xZp9espvPIhtzu7k1R1Oud8NsVIRforeF1onYGrqacSDD
   I1yGppf1kCO2VFaaXyH6/xvVxQrQW/aa+gd1NSkjpVqGIReZ1pYGCGFsj
   Q==;
X-CSE-ConnectionGUID: FVs/VaOqRUK6q/ApnXAGlw==
X-CSE-MsgGUID: NDAJ2AhdRjKlV0xEy1Ko1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101523555"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101523555"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 19:13:38 -0700
X-CSE-ConnectionGUID: m4gpygLMSQi+Q/m1ctdwvw==
X-CSE-MsgGUID: DRiAzKsyRX6UiQKYzwyHdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274331823"
Received: from unknown (HELO [10.238.1.46]) ([10.238.1.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 19:13:34 -0700
Message-ID: <bd46aaba-2c07-4b4d-b76a-30a1dff21b0f@linux.intel.com>
Date: Tue, 29 Sep 2026 10:13:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an explicit
 type
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-3-peter.fang@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260928100913.2265687-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/2026 6:08 PM, Peter Fang wrote:
> The Quote buffer is always a "struct tdx_quote_buf", but its global
> pointer is a "void *". A function would have to convert it back to make
> sense of it.
> 
> Declare the global with its actual type, and give it a better name.
> 
> This creates variable shadowing in wait_for_quote_completion(), so
> rename its parameter for clarity.
> 
> AI was used under supervision to collect/apply feedback, review code and
> workshop logs.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
> v5:
>  - New patch. [Dave]
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 35 ++++++++++++-------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index d0303e31e816..896eb0a09c4a 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -192,7 +192,7 @@ struct tdx_quote_buf {
>  };
>  
>  /* Quote data buffer */

The comment should be updated as well.

"Quote buffer" or "Quote request buffer"?

> -static void *quote_data;
> +static struct tdx_quote_buf *quote_buf;
>  
