Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FD4D2ED4;
	Wed, 29 Jul 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349777; cv=none; b=IBVn+CGT1Rq+jXNdkmm5Wjga5DcR27b1Sfcl8vO36m3XuEKVh2Bh6pixmlNnLd+Ag5KfTUAnBuDL7WjOYPX9uI44Zx56R6U22SFPJPv2xf/dW5gpBMZjJ5g642s/o21/9hqe8PyXYOEgX8xyMq6mTJ06JXwxEmpjIeJRW90sIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349777; c=relaxed/simple;
	bh=+AeacpbeQv/GkMsfjF6JrZr812QeEHglMVtIdTZwwzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXjPs6YPEAvG2G0HvpVdyTDiTwwwcJAmxHYCMQ3Y1NSM7j0cZLG5i4PKbV7DZfD7SX2HbRMEZI8cwG+CnAWkZe0lh+QoaQBbKzSngwVQQIOgZ/G0PDQxcA17ttb9YtjUX8MLoCNGEpxysVce2W6fSvtBS6rVv6d1D7O6gS9pqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKqs7M2v; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKqs7M2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785349775; x=1816885775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+AeacpbeQv/GkMsfjF6JrZr812QeEHglMVtIdTZwwzs=;
  b=FKqs7M2vNeuBF8XFpLAxTkbygHa8MJc2Dq90MDvmAyQgZ/Imw24Q4EO4
   NZ1zujJJkiWsv16IytTdwxg1ozlp5DqyWEhRmCMoQN1DL3eN/lqKedBck
   b+Pi7pGake2urVdGxTCIBm21gPJvNWVKE2nkYEZ/A2MmZClYgOrYGQ8r3
   c47YBL6/KtEprXluJRApAiIYn76U69r73GiTK3gOiZ37kKLjvVJC+Vs6q
   u60A6RbyKcEFBoe5XlXBDXnB4n1HpkzUwtCOXC7M0x3CLypaVoS3pufUU
   uSlSQsxzd2d1SPRdXGs4yOIUnAwMHrXIwAVtCmDYg5WckysMb9oeMLeiQ
   w==;
X-CSE-ConnectionGUID: ebK35JI5TFCtM51GZWXd8A==
X-CSE-MsgGUID: RIIwpFHZQ3i7xVbygux/jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103369972"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="103369972"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 11:29:35 -0700
X-CSE-ConnectionGUID: vV+rzIWcQ1qj+USdj2FMWA==
X-CSE-MsgGUID: TMA99PcsQXmKjx9SVTQSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="263574597"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 11:29:35 -0700
Message-ID: <575d74b3-1531-40a3-abc3-bbacdc08832f@linux.intel.com>
Date: Wed, 29 Jul 2026 11:29:34 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] virt: tdx-guest: Calculate the Quote buffer size
 safely
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-3-peter.fang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260729122939.1340412-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/29/2026 5:29 AM, Peter Fang wrote:
> struct tdx_quote_buf has a trailing flexible array member.
> struct_size_t() calculates the size of this kind of struct safely. It
> handles overflow, which is an important property since the Quote size
> comes from the host.
> 
> Use it in place of the fixed length limit.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---
> v3:
>  - Split out the use of struct_size_t() for buffer length from the v2
>    "Allocate Quote buffer dynamically" patch to refactor first. [Dave]
>  - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
>    reworked.
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/virt/coco/tdx-guest/tdx-guest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index d0303e31e816..f47c5429d002 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -170,7 +170,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>  #define GET_QUOTE_SUCCESS		0
>  #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
>  
> -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
> +#define TDX_QUOTE_BUF_LEN(n)		struct_size_t(struct tdx_quote_buf, data, n)
>  
>  /* struct tdx_quote_buf: Format of Quote request buffer.
>   * @version: Quote format version, filled by TD.
> @@ -315,7 +315,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  
>  	out_len = READ_ONCE(quote_buf->out_len);
>  
> -	if (out_len > TDX_QUOTE_MAX_LEN)
> +	if (TDX_QUOTE_BUF_LEN(out_len) > GET_QUOTE_BUF_SIZE)
>  		return -EFBIG;
>  
>  	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

