Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24238424D59;
	Mon,  7 Sep 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767730; cv=none; b=STRsectX4EWmSSzLJJlD7VS0+TNzocHk3OZVzXWySUij0fLk3o7sYlHU373Z4ahoauzuZR1uWP5CaUYdbk+rRJOJ6Qv+kfE18G1a59rf4EsT2LEOalHGE3JqXgHrVUGq5nQTidfdGy+7T9EvmbMzyooKo4m5Se9be5TYqTXCuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767730; c=relaxed/simple;
	bh=fuSWLEFBTzJgPkHaWZrg6BhQcGsJg4w0tE9ijo9r/4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9YwNZKs1y2tN10PLCy2lS+Morc/GpwLwpZMNkF/GzRNTcwyslRGDAfAfwcDshujYoPR1b8T3SXzBBxJX6FNNWTfmVd3hEemQiru7uJoRjbVu+14lwtJZiWSuWh+Cm+MzWiC10dQhpPC46XIL1IZAhzkOHTWYfaueV/DJGJRHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3O4e7p+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3O4e7p+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788767729; x=1820303729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fuSWLEFBTzJgPkHaWZrg6BhQcGsJg4w0tE9ijo9r/4A=;
  b=W3O4e7p+T5Lij089ZWJw915d8ONTXuozffCRU4Tku5PmmMHbdA71sN0/
   afo6IWj/qgLa/hk7FqQS5nycEYU7oRIuWE8qF2ex7V84wLCMKxXKCNs4x
   ptl0CKWCpggRs5ASV6XvJ83acKKewfrUbX/gSMW/5lYb4Of2t52fFlBkf
   E7TeCsrQKI4hAmx27bJww8HLfDT5DT2juscNyHW2o02/9nFd/Q7G0dZGz
   2f1/20O/mvqLi1TLKoq5li4Q+brTQuMdx2FebHWK+mbVj/dI522ZylBZp
   EGoCIiHt5y2wDl6WzlcAKW3vEAjyvnPG2m96uU3Qe29XROp/ezBVVjV00
   Q==;
X-CSE-ConnectionGUID: mJm4X/PaTZSC1s5wfsBZFg==
X-CSE-MsgGUID: uV22pYfYQVWeJkfZhJFPmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="92866219"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="92866219"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 00:55:28 -0700
X-CSE-ConnectionGUID: xsUhN4GTSia0ierEx9vdew==
X-CSE-MsgGUID: 5ClV+JO2TCK2+n/MwSNskA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274153509"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 00:55:24 -0700
Message-ID: <8d20d04a-3503-42d5-8aa0-90b96aca2fe4@linux.intel.com>
Date: Mon, 7 Sep 2026 15:55:22 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <75441677-635e-4a2b-8e11-f5e70a1433a5@linux.intel.com>
 <appp3yiDbYsekIzP@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <appp3yiDbYsekIzP@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 2:49 PM, Peter Fang wrote:
> On Thu, Sep 03, 2026 at 05:17:02PM +0800, Binbin Wu wrote:
>> On 7/29/2026 8:29 PM, Peter Fang wrote:
>>> In preparation for dynamic Quote buffer sizes, replace the fixed size
>>> constant with a variable.
>>>
>>> The size is currently a constant sprinkled across several places. Store
>>> it in a variable and have all the users read it from there.
>>>
>>> Signed-off-by: Peter Fang <peter.fang@intel.com>
>>
>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> Thanks Binbin!
> 
>>
>>> @@ -191,8 +191,9 @@ struct tdx_quote_buf {
>>>  	u8 data[];
>>>  };
>>>  
>>> -/* Quote data buffer */
>>> +/* Quote data buffer and length */
>>>  static void *quote_data;
>>> +static size_t quote_data_len;
>>
>> Nit:
>> The existing code is using "quote_data", it's natural to follow the style.
>> I personally feel the var names are a bit ambiguous on whether it's the full
>> quote buffer or just the data part.
> 
> Yeah I agree... How about I change it to:
> 
>   static struct tdx_quote_buf *quote_buf;
> 
> This way it's explicitly typed, and should work better with functions
> like alloc_quote_buf() and free_quote_buf()?

tdx_report_new_locked() already uses the name 'quote_buf' as a local var. :(
Maybe the local var can be dropped, but tdx_hcall_get_quote() takes a "u8 *"
pointer, which will require a type cast.

Anyway, this is a nit and it could be addressed in a separately if needed.

