Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC2494A09;
	Tue, 14 Jul 2026 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046134; cv=none; b=CgiQjbYXUkUQpNJhdCeOoFbsfHt0ItrXBXEM7eAxmcpyAGs/9dpuqKBhqumy0ltMehQo7rX5PoIxFsnZMg8Fi6zAaA7JHGELeIZ/gPBa2krJnTUssmHVk+v8vSeoZ8Nl8MWsM/8VdxUc7/TfcqLoZj9VyxdZfDJzayMOzaDyLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046134; c=relaxed/simple;
	bh=IjW81UlirIvo9gXdrU2y8CuTZ4JeckEqr9kHsxEIZns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHncjcc4vl3N+3mHmbupAnyn8SS2KlBs/mfRV29WyR4d7CuzfuqCsXhlXDPxn4E+cX5ZwAVQWdA5Z+DcaLb/2u104adSFUPxiixZzkdZlJ4I19d4yznHfvWZdTQx77L1xvdtv+A6AbiDdUHlzg8uORnbt9U6b8J2Vwey9Q9HtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lX8vfuE8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lX8vfuE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784046132; x=1815582132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IjW81UlirIvo9gXdrU2y8CuTZ4JeckEqr9kHsxEIZns=;
  b=lX8vfuE81PwlgGKoZ2gaAwWZAS+sFb9634Ot+TFRA0Hd2QIMJJzFMK6S
   wwqwATKNVwJ/0+B+oDmmnmSLCvSBbwMP/mwzPXryeFwG+wQn8guhcoT8J
   OEc2fgLpja5oSez+6mv1qBvgQMhe++M20B4ObVpzp8jwU4LdDbj0nNrQq
   v1YdxhU8kLgEeyCcLOjHD0IRki2p2nhme1AE4AmkAntXcvZLymjOCQgkS
   TIAg7SBS54c+Uw7bxOShJJIL/tVUmTVFssPq4H3aXm0K+QGTIiFrMtCBU
   Yz02iqOdxPIZW+aOIvMHM05CTtA1jbz7l9dSM6YMigUdpSqJmRQ6G3Vc+
   Q==;
X-CSE-ConnectionGUID: jiDnqzn6SIyaW693DpnbLQ==
X-CSE-MsgGUID: CLOEvjZfSnuu0mkmWorTog==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="83795558"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="83795558"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:22:11 -0700
X-CSE-ConnectionGUID: WAKzB18BSE615YnM24rhyA==
X-CSE-MsgGUID: /a5HeManRwyQIFFRvkmKyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255949195"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:22:11 -0700
Message-ID: <dd51743d-74b2-4f89-a447-06618a6301ae@linux.intel.com>
Date: Tue, 14 Jul 2026 09:22:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
 <283d7cc7-e87e-4d4e-b1d9-ae19725e1606@linux.intel.com>
 <20260714062502.GE3178326@pedri>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260714062502.GE3178326@pedri>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/13/2026 11:25 PM, Peter Fang wrote:
> On Mon, Jul 13, 2026 at 10:27:46AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi Peter,
>>
>> On 6/12/2026 4:08 AM, Peter Fang wrote:
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> The TDX attestation driver currently uses a fixed 128 KB Quote buffer
>>> shared with the host VMM. This may be too small for Quotes using schemes
>>> such as post-quantum cryptography (PQC), where certificate chains can
>>> increase the Quote size to several megabytes.
>>>
>>> Allocate the Quote buffer based on the size reported by the TDX module
>>> instead of always reserving a fixed-size buffer. This avoids wasting
>>> memory on platforms that do not require larger Quotes. Older platforms
>>> fall back to the default 128 KB buffer.
>>>
>>> Because the Quote buffer must be physically contiguous, its size is
>>> bound by the buddy allocator's maximum page order (4 MB), which should
>>> be sufficient for current attestation needs.
>>>
>>> struct tdx_quote_buf has a trailing flexible array, so use offsetof()
>>> instead of sizeof() to calculate the header size.
>>>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Assisted-by: Claude:claude-opus-4-7
>>> Assisted-by: GitHub Copilot:gpt-5.4
>>> Signed-off-by: Peter Fang <peter.fang@intel.com>
>>> ---
>>
>> Looks good to me.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Thanks Sathya!
> 
>>
>>
>>>  drivers/virt/coco/tdx-guest/tdx-guest.c | 52 ++++++++++++++++++-------
>>>  1 file changed, 38 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> index a9ecc46df187..162fb47f3fae 100644
>>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> @@ -163,7 +163,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>>>   * DICE-based attestation uses layered evidence that requires
>>>   * larger Quote size (~100K).
>>>   */
>>> -#define GET_QUOTE_BUF_SIZE		SZ_128K
>>> +#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
>>>  
>>>  #define GET_QUOTE_CMD_VER		1
>>>  
>>> @@ -171,7 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>>>  #define GET_QUOTE_SUCCESS		0
>>>  #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
>>>  
>>> -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
>>> +#define TDX_QUOTE_BUF_LEN(n)		(offsetof(struct tdx_quote_buf, data) + (n))
>>>  
>>>  /* struct tdx_quote_buf: Format of Quote request buffer.
>>>   * @version: Quote format version, filled by TD.
>>> @@ -192,8 +192,9 @@ struct tdx_quote_buf {
>>>  	u8 data[];
>>>  };
>>>  
>>> -/* Quote data buffer */
>>> +/* Quote data buffer and size */
>>>  static void *quote_data;
>>> +static size_t quote_data_size;
>>>  
> 
> [ ... ]
> 
>>>  
>>> @@ -286,7 +310,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>>>  	if (desc->inblob_len != TDX_REPORTDATA_LEN)
>>>  		return -EINVAL;
>>>  
>>> -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
>>> +	memset(quote_data, 0, quote_data_size);
>>>  
>>>  	/* Update Quote buffer header */
>>>  	quote_buf->version = GET_QUOTE_CMD_VER;
>>> @@ -297,7 +321,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
>>> +	err = tdx_hcall_get_quote(quote_data, quote_data_size);
>>>  	if (err) {
>>>  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
>>>  		return -EIO;
>>> @@ -316,7 +340,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
>>>  
>>>  	out_len = READ_ONCE(quote_buf->out_len);
>>>  
>>> -	if (out_len > TDX_QUOTE_MAX_LEN)
>>> +	if (TDX_QUOTE_BUF_LEN(out_len) > quote_data_size)
>>>  		return -EFBIG;
>>
>> Nit: I think this check will be more readable if you can rename
>> quote_data_size to quote_buf_size (since it holds total buffer
>> size).
> 
> Hm. This pairs with the original "static void *quote_data". Or perhaps
> "quote_data_len"?

Yes, it pairs with quote_data buffer name. May be both should be renamed.

If it is too much trouble, just leave it.

> 
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

