Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F68488220;
	Mon, 12 Oct 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809467; cv=none; b=sARKLVFtmIv79ToOxfDCaHv0S9WXXVhs2jdsaCmfUHYKjSyCI4TETBPDv2vCycp2D0zkfQjPxhAri3VvaY3a9zAixwGQX/WhxqwXC4b7tddQrRizobwXas97P4N5taB7K0pdVMP3JxVDV3cwIbHsmYDzFxnF7ubTVejK5hS6rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809467; c=relaxed/simple;
	bh=J281vyTDkc4oPl0ubD8MnyBNn/xynYR6kCoWRZKXzLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bXEpzHsBkN2CqjWiT8awoi4DopyUbGfxA7viiVwdbdQ7KoWnXVlKm8PB6u9knLGB3vJw9105kFLIxg4JpbgVXfeeZupvr0guT+VvQU2C3H8HVI2QFvlHCVWRyhk9iZNmJ7/LSIdUIW7X6LFTJ2JAHYJRTGejYMUaJU0tKN7pQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbGFeKmN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbGFeKmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791809466; x=1823345466;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=J281vyTDkc4oPl0ubD8MnyBNn/xynYR6kCoWRZKXzLU=;
  b=mbGFeKmNKKf20HWIV0T6rLM887BniVS6zUFUEX3uAAX8xism3Q/k3FZr
   S2NgdDPMKI/i9ZfEEte9cdxGCaFGSIDJMEEZULLfHkkOJLBlsPMumfoU5
   3USLOleJMQeP5pMLYs4UgVCJ+wpCuM4p1/TReHx0QQf7Jb5Zlgq7xZee1
   tcktwfhq0fCHSza58VQhA0xmCc80IkIg/CTtkW/mpOAZ36jYmJmHgnrae
   xtaPbMuVh+HPru9fQIwmh3fxsmeNPD30/cXPx8+T1mERoM7wo9ZpJSpsb
   VLRqZqWNiwxvCLBN3m1q6ffz57E6yBVIiBDWA0XQlT9l3CRIyGwJlUw5U
   A==;
X-CSE-ConnectionGUID: oHbQmhTNRbmcDs8JR8eyMQ==
X-CSE-MsgGUID: eoLEHZT7Sk62jvtx6igdaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="413829"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="413829"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 05:51:06 -0700
X-CSE-ConnectionGUID: e2po26hBSfyFYqV9WT0vaQ==
X-CSE-MsgGUID: OzF3553zSNup9uKdGxmXfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1077325"
Received: from unknown (HELO [10.238.3.65]) ([10.238.3.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 05:51:02 -0700
Message-ID: <7f23b307-7484-49ae-8ce6-95633942604c@intel.com>
Date: Mon, 12 Oct 2026 20:50:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
 <3c6e968e-f625-4ea7-b815-1c9be7d2bef3@intel.com>
 <72e0478c33976f56c79dc6ca9c9823373a868583.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <72e0478c33976f56c79dc6ca9c9823373a868583.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/2026 12:31 AM, Edgecombe, Rick P wrote:
> On Wed, 2026-09-23 at 10:18 +0800, Xiaoyao Li wrote:
>> What about TDH.PHYMEM.CACHE.WB? Can it be dropped as well?
> 
> Apparently not. I'm not sure we can't push harder on it to drop that that too,
> but it had a slightly different reason for existing apparently. There is a
> different flag for it "SKIP_PHYMEM_CACHE_WB" which we don't check.
> 
> Since it isn't needed for huge page code reduction, I think it's not a
> priority. 

I agree.

> Do you think it is worth mentioning here? Since it has a separate enumeration, I
> thought it was separate enough to keep the log simpler. Keeping it down to what
> is need to understand and not more.

I asked because I don't think TDX spec clarifies it clearly why it needs a
separate enumeration bit.

My understanding is that, for runtime removing a TDX private page, host VMM
calls TDH.PHYMEM.PAGE.WBINVD on a page after removing the page from the SEPT.
For removing pages at TD teardown phase, host VMM can do it in a batch by
TDH.PHYMEM.CACHE.WB to write back all the pages so that host VMM doesn't need to
call TDH.PHYMEM.PAGE.WBINVD on each page.

If the page wbinvd is not needed for runtime page removal, it seems not needed
for teardown time as well.

Considering it helps nothing to huge page code reduction, I'm OK to leave it to
another topic. Maybe we can mention this consideration in the cover letter and
explained that TDH.PHYMEM.CACHE.WB can be discussed and handled separately?
