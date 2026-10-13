Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE63D6CB8;
	Tue, 13 Oct 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882838; cv=none; b=BkrepsvEhYF7QXotN09el/mGqLiRGAG/U8A/aDIhMeyivDRqFe0fMcr9HgmZIB3PlxGfkNGZd/b0OfGuyEhS4XfB+RMfypT/FGIMvg/CYWU0GOlYopmy+VRSHQnTuzblcPL2eike7LiXZDvX9vyFUJ51jKECdprQTk0oSTwqvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882838; c=relaxed/simple;
	bh=8WuXXltcXDl81c5GBq7j7u58Lm4SbHUwf18VVH4JFtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4LOVvNX9eRm2gqXySIQif15bYOU68MLelQufMbpbCbK/62m7MZUhZaoKfu3jgPg48XBgZJEy8/t+1sFuaasLXue+t/fH7idQRRuJGSLS7s6oxuWI2DBHok+o+F7UHcuKBQmzQyAJ6VDzIgBz7WJNxHSBlY+5MwfVb79pwI5C4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awXUPArX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awXUPArX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791882838; x=1823418838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8WuXXltcXDl81c5GBq7j7u58Lm4SbHUwf18VVH4JFtQ=;
  b=awXUPArXDjlvxXFs0p8uX2eThCLaH9Aosyku1U59aMiwyzYFRDNaDQ0N
   YzXMH/MQ94OkC2lILEa/VsYgS3YTH42w4CVqito56R/1cAMebFAPy5WFX
   Qtpd2ogp54FKgnfqBP96bV2Ir4x7iuj660FdFi9ScMtGzRuGmNxgS7kPK
   Ov1WGzcrvUvTQOQbjqcOASHLucZCnLuELa27APMPQ7FuLCzMNRMZRRqq+
   VSU8T+MNS9lYLzdkVjEVtZ7r3vR/GZ8AYRWkQ867TJnFfgncX9iO9gE9b
   4xO4Vs/C0rziJMfqftSHU0KiVLgXfyory/+Kor8XWQbxFLfZKmJpLGatB
   g==;
X-CSE-ConnectionGUID: ZR4HleacSxexZl+15JaQ/Q==
X-CSE-MsgGUID: u54udIpHRRGUwgJXj92cUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="499372"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="499372"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:13:57 -0700
X-CSE-ConnectionGUID: FHN2UOaXQzuIJaW9MVmLPg==
X-CSE-MsgGUID: ZElhTNLOTN+PUVVkhqERAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1091783"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:13:38 -0700
Message-ID: <ea2a2768-5920-4869-9f11-d19f0310b466@linux.intel.com>
Date: Tue, 13 Oct 2026 17:13:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] x86/virt/tdx: Convert the td_ctrl metadata
 reader
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-6-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-6-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> Add a table that pairs each field ID with the 'struct
> tdx_sys_info_td_ctrl' member that holds its value, and read all fields by
> walking that table.
> 
> Annotate the table as __initconst as it is referenced only during init.
> 
> AI was used under supervision to review code and workshop logs
                                                                ^
Nit: Missing a period.

> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

