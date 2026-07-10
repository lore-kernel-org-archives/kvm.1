Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4122097;
	Fri, 10 Jul 2026 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654384; cv=none; b=bsce9Vbsy8URgBcAtsUTek+YvOaYMKww2/JEZx4tsYGRSx5UzLW6yOc+4OBSUa26GgnWJmKPdkD0fBvBB3nmMkFjqwzWg14evTGJQD6n1ZNCRjnpSB3wB+GUp4+M3c7QLRezD3XSPH0sGwlIhAQzG4VcIV5SQgSsRXauBk3s/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654384; c=relaxed/simple;
	bh=wxG3iOtajXHkXnF6It1b0JI5hhHMd2h1ezzqy4Qe7JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlWTsBujOY6aOnT0aDr79CDmtmQ7TB8VboKjkwuSjoXeoI4o7ikbH8z+9SECHhyRBnn7EQwdUxvibPgtHxmIIhRfDVH5aM7Kzh5PMzk65MnYROcTjCMB2a3sJQ01i6RkOBJamZbCqooVmeJsDChu2jfO3YvVwmwruDTimdnDbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkcQxB7H; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkcQxB7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783654381; x=1815190381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wxG3iOtajXHkXnF6It1b0JI5hhHMd2h1ezzqy4Qe7JY=;
  b=nkcQxB7HDzUqZ088vDxO8bLtqs+cG3Qwjsu5+CH1ILwUgUB7KlFKZmf9
   WL2Lxfk6V85TIR9P2XeG2BYvtTMZXuqMbsJVLWwVC2SgteEg7cwFdutVc
   76cWwhpcS9wwgL7pO5N7FDgXUt1OOmm9t9YN7Z5435BrvDpNjpnEaChm3
   BMVy7PGwnl0IK8ayvdEBQ1O2IhMJyEQx0oUSWNSE659EiixKTziNaaWoI
   AHYObylFZfcbQKZLNgMrFHWD9hakwo3TS8788DSbZucqZm7//OD/J2rCc
   cXlC3nTVL5Bor/TVzr35aks/rcOIvWKaTLPZA9DykwRDuS4Jyl2HFKVWv
   A==;
X-CSE-ConnectionGUID: 2RFSyBF6RqO6Sl7tHULKzA==
X-CSE-MsgGUID: 5JnU/bcmRGu5xJohUShHoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84466164"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84466164"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 20:33:00 -0700
X-CSE-ConnectionGUID: PYgBp+vdSYyfnWRYlj+iOw==
X-CSE-MsgGUID: aPnN1mQdSqW9CJxcLyZGxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252123823"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 20:32:57 -0700
Message-ID: <62069ec6-b586-446a-a696-6aa3356ac665@linux.intel.com>
Date: Fri, 10 Jul 2026 11:32:55 +0800
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
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260612110853.3188196-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/2026 7:08 PM, Peter Fang wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> The TDX attestation driver currently uses a fixed 128 KB Quote buffer
> shared with the host VMM. This may be too small for Quotes using schemes
> such as post-quantum cryptography (PQC), where certificate chains can
> increase the Quote size to several megabytes.

Nit:
I think the description here should be more accurate.
"Several megabytes" colloquially implies sizes that could easily exceed 4 MB.
And it's a slight contradiction VS the 4MB limitation below.

> 
> Allocate the Quote buffer based on the size reported by the TDX module
> instead of always reserving a fixed-size buffer. This avoids wasting
> memory on platforms that do not require larger Quotes. Older platforms
> fall back to the default 128 KB buffer.
> 
> Because the Quote buffer must be physically contiguous, its size is
> bound by the buddy allocator's maximum page order (4 MB), which should
> be sufficient for current attestation needs.
> 
> struct tdx_quote_buf has a trailing flexible array, so use offsetof()
> instead of sizeof() to calculate the header size.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: GitHub Copilot:gpt-5.4

Same issue as pointed by Kiryl in the first patch.

> Signed-off-by: Peter Fang <peter.fang@intel.com>

Also the use of struct_size_t() instead of offsetof().

Otherwise looks okay to me:

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
