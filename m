Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0C1FC110;
	Fri, 10 Jul 2026 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651129; cv=none; b=XYJ1iKFJzvywcnql64/I29QbqvKoFTkbUAye8N8FUe8lzI2vtGhtp3wsIK5ToVYyjjyGHr7SE+eSIZY/ZPJ0xHzXkSMwYuj0HaTA5yr3/jj4rmCHtWJhUaSaWqKVK4vOYdY1n9pqkUjnKVjkrOPtjUOcOgroJQMwe/r0yt7QbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651129; c=relaxed/simple;
	bh=0x4C/1T5Fv93ZRCdQSTMXxEAbc6R3w5NCQmzNosc7lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG90INUdo2gSYO6GpTPOS9tRHIpRG2utXqZ4/TardAgWQrnJ/vIO1hAPwLgxcbiXJj0HWgZ8dvu59zd0CnZkD4CEaD3G86eTsiViYgSRzIrLCWwdeNLHdZresUrWlfU3mQNx2VjyymnMhVSR25w+N+Mh+TrQMdK6w33aAnUqYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUk5gxZU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUk5gxZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783651128; x=1815187128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0x4C/1T5Fv93ZRCdQSTMXxEAbc6R3w5NCQmzNosc7lw=;
  b=XUk5gxZUzBIa3CSaBPO+W3tPRMMpIyo1JKYnj5YFcqJFiIxqsp+p79Wh
   dPk0w1qd1u5R7zJN0wo4K5XzjREk6ukp/X7mgikMTXrDDVOw6+cQ9tRe7
   0gbL2rWQKI5e9aR/gyvd5+wtxQcLRUpaYLNSrBxpExMP3qPi93l2gmfUJ
   TNO2mA0P5nQoTCLP4pabdWgUuk1laPkNhgNwa10KzMJTAuj5DKNs6Ld/O
   SzlT+LYkhLnHN26e9+N+cKzV0f1rRZnTDHDrhT0csjjetaCCfV1apaP1C
   r0GL1keMNCSfoZ62gYTC7+mLumtPUXolxudNvrC0XmVLGQkGJi3/9GpPp
   A==;
X-CSE-ConnectionGUID: 83s7oaxHSsSmzzRfmQbb8w==
X-CSE-MsgGUID: HJO9jbWHRqqP+u88xu0wKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86892644"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="86892644"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:38:47 -0700
X-CSE-ConnectionGUID: FcGnj3rGRLmz9m//DZZF2Q==
X-CSE-MsgGUID: QWs2GEtpToOJleyf+4+PTQ==
X-ExtLoop1: 1
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:38:44 -0700
Message-ID: <a95a286c-5fa9-47f7-8a9a-4ecf3aafdfee@linux.intel.com>
Date: Fri, 10 Jul 2026 10:38:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
To: Kiryl Shutsemau <kas@kernel.org>, Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
 <aiv8mrJDgs_e8eLq@thinkstation>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aiv8mrJDgs_e8eLq@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/2026 8:36 PM, Kiryl Shutsemau wrote:
>>  
>> +/**
>> + * tdx_get_max_quote_size() - Get the maximum TD Quote size
>> + *
>> + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
>> + * guest driver uses it to size the buffer for Quote retrieval. Older TDX
>> + * modules do not support this field and return an error.
>> + *
>> + * Return: Maximum Quote size in bytes on success, or 0 on failure.
>> + */
>> +u32 tdx_get_max_quote_size(void)
>> +{
>> +	u64 val, ret;
>> +
>> +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
>> +
>> +	return ret ? 0 : (u32)val;
> 
> Cast is redundant.

I thought in Linux kernel, the explicit cast is often preferred?
E.g. as documentation of the metadata field’s width here?

> 
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
>> +
>>  static void __noreturn tdx_panic(const char *msg)
>>  {
>>  	struct tdx_module_args args = {
> 

