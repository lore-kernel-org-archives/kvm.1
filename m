Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6437EFED;
	Thu, 21 May 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358331; cv=none; b=IqtIgxs9TgFGFRAP4KPVMPpFwPg3SZfK/t17LjYCyf85mmV+JzQCg93WaMuZTCYA15+bzpFvvMIeDjHLAOHuGvwQjAdMONP8wjcZZtTfms5R62S9eTIh8P93OWC2Mkl6jqyx3ciMfsw/cuoES8oGt3F9n5EZmQRHnzVxUrUZRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358331; c=relaxed/simple;
	bh=5wNi/zZ2GRB/OTJY5lyYidZr2VSjMsAvYbu1hrrcNm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTAG+k8nVQ/Y3nqMns/F74T8mCZGFhl5GfiJibc8euJ5Qv2h/PgbRtYif4AACasYzNgY/jadnEL8uv6PVHIvSseXybhzV47+spdl7Z1FQhyHJo+cE8gCIutKvr+WL8kCTMDuiZdY5bgOwPAd11rgB5tfxXvMuqmu6ZPVI7RCQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fa6Bkn3X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fa6Bkn3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779358330; x=1810894330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5wNi/zZ2GRB/OTJY5lyYidZr2VSjMsAvYbu1hrrcNm4=;
  b=Fa6Bkn3XhE7oHUfYhxHfcrDwUFRAu/0Mp/OCyuvYUA5wOa1ei1COYBBW
   vNFkoyJl18YwWZRoYUjSurv3iQVidC1NZaDJ2BxNZuiac6jhxqVjQkYFj
   AUPwHdobiSOEisl2dY5N+DykF4Mu84n0v5nRtq9jAQcMYQWqtBDnxarOC
   7Hdvjk4Cc4OBRMxXYxf6GctH4JmLAkPxINUFinE2kTCVmwaAkJ5sRVlUY
   07tyxyHGBmgrfJ+tKnAIOo72PrafNKmKeWGxmuuAiVlxdIVoeZGxatu4B
   ZPhyo5syDAddnes8vCQL/dnsI0fFUjfcd1J5Sd/cJxxSe2xRdGEolXZTw
   g==;
X-CSE-ConnectionGUID: +XmRIx/hTNCpjpO31g5/+g==
X-CSE-MsgGUID: 9t/yJajAQmq0O3Ya97G/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90965721"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="90965721"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:12:09 -0700
X-CSE-ConnectionGUID: oRw91iuHRLawIZXNja6JQQ==
X-CSE-MsgGUID: NdcFgbaGSruwGCOeUT+kJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="264295700"
Received: from unknown (HELO [10.239.158.74]) ([10.239.158.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:12:04 -0700
Message-ID: <cf42a721-4c77-4034-811a-e21db7910cad@intel.com>
Date: Thu, 21 May 2026 18:12:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/25] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, yan.y.zhao@intel.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-5-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260520133909.409394-5-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/2026 9:38 PM, Chao Gao wrote:
> Future changes will add support for new TDX features exposed as
> TDX_FEATURES0 bits. The presence of these features will need to be checked
> outside of arch/x86/virt. So the feature query helpers, and the
> TDX_FEATURES0 defines they reference, will need to live in the widely
> accessible asm/tdx.h header. Move the existing TDX_FEATURES0 to asm/tdx.h
> so that they can all be kept together.
> 
> Opportunistically switch to BIT_ULL() since TDX_FEATURES0 is 64-bit.
> 
> No functional change intended.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Link: https://lore.kernel.org/kvm/20260427152854.101171-17-chao.gao@intel.com/ # [1]
> Link: https://lore.kernel.org/kvm/20251121005125.417831-16-rick.p.edgecombe@intel.com/ # [2]
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
