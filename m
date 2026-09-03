Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E940349CFF;
	Thu,  3 Sep 2026 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413613; cv=none; b=Ll/bDezVlZVZrI35pXY8Bfw7P3bGWuc9i0hgoESgz86rxi6De2aKrwIK1LTWAekrjLBBypenvuN1de8bxUjkc1ddiBZuLhf7sdSORiNvjrKH0z7VHNXI0oc3sZwMFHMd8qUwUXDCWWwZb1NzU/wokCv5+iOKB/MearMMTlDYqno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413613; c=relaxed/simple;
	bh=gkuugO112N4Tf9bmShuxwN5FBDt25t9OXk0IxwtkVxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eep8Y4N+BhaPg+4OVKyozg2L8b/xfYj/fF6Uut8vrA30koxqLSB+0xTcKhmaeTS4JhfPNw/AeAPu9PTVzuXuhwz16HleOEcGoJAT74Mm7CvaY7LFT2Wc+h3OZ75cTYeipf41mGbvpoXE+tZER+w/iDcs5jnOYnzTK/AcmTWbnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtXVMS0K; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtXVMS0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788413611; x=1819949611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gkuugO112N4Tf9bmShuxwN5FBDt25t9OXk0IxwtkVxw=;
  b=DtXVMS0K1hu72jTmLo/nLS8SBQt6gcXSTZ7N1Rtv8eJ1SLTkd6EtFUZ+
   g3nwtnWPkhk/wfTZHmFX5Cv0rUcDIUokwbUFVzFzhM5JylhHXUgXMTg2j
   fgD30f7hV/uMGyEcixMtz1w+bqiD6kb+eRp2Hf4Yp/2hAtru4e5Oo3bs9
   nOOkHWCmHeAlD7Odg9D3tOjK/4wGQlDaKVncQ+6S6pXsgcgeRnxGhqtq2
   y/2sxk1PHWjUxJnqMctyWfe5WUW5hOF2IzuDVWrduwS2RQ6gC3MOhwd0Q
   Qc4nHLTG7F1LCQGl8k0xJdpIWp2BLwRzF8ojbZ/gfuP97NzrqmHCcbSYQ
   w==;
X-CSE-ConnectionGUID: Id0wsGU8TgW+9Y0tD38Cpw==
X-CSE-MsgGUID: yNFat7hKSN25c9m59/XxmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88647153"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88647153"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 22:33:31 -0700
X-CSE-ConnectionGUID: y9RPmHCKS/6e8cak2d+Nzg==
X-CSE-MsgGUID: n692O+J6RxmWIn43BhMIdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="269075572"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 22:33:27 -0700
Message-ID: <55c04d6f-dd76-49b0-9dd8-4c0818818c39@intel.com>
Date: Thu, 3 Sep 2026 13:33:24 +0800
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-3-peter.fang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260729122939.1340412-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:29 PM, Peter Fang wrote:
> struct tdx_quote_buf has a trailing flexible array member.
> struct_size_t() calculates the size of this kind of struct safely. It
> handles overflow, which is an important property since the Quote size
> comes from the host.
> 
> Use it in place of the fixed length limit.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> v3:
>  - Split out the use of struct_size_t() for buffer length from the v2
>    "Allocate Quote buffer dynamically" patch to refactor first. [Dave]
>  - Drop the Reviewed-by tags from v2 (Kiryl, Binbin) as the patch was
>    reworked.
> ---
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

