Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486560;
	b=0zbWK31qCmsJxSNE+b+MAsIMtIwctE2xGHkj3ggmeXVpJR0WdmczbBeh5TJRHNUL/dzV
	 Phd7S1Yj6M9E4kJw8viY9G28e4egfXGZBSMRUZV9KpaRvVEROIiE0QaOQBmSgXFJrnyRV
	 n7Wz6J2eb0sA5dRY0HzelHoH/g/x/G8CQ+Pgwy/Mnk1isskKBvLEvC5fxwZwfkJ0/AZBn
	 76AvQ8I6hFy0IGg52GMfCaQCbZIKUHmwwN26ofytyI0dhgYhl7LKJO9RtmegqEfo5lNIO
	 AwZS4FMpWakypWVXgWvTfsitL/XVOZphg9cVI/8hmUpvQNcUKiKq0edo2hPX4PCoAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486560;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XlQpqxMRX2HU2uhm8SxtYuDE1WGAscTMQBDBwk7Z4UU=;
	b=3w67JDoauv3F4p4+mkZFC0Giqv8gCcVBwq2L3vl+6Mf0UknHPaoYFI5yNDSSjZ5MYlku
	 YOrUNHybZK8wY+Y83mp1kyOhZJ1l7joelkHTQDBFrWOQmCtPQhisnSd29v/aO3Fdse9tM
	 L5AUQbZFbFJHD7rFp7+Xb6fRSfmmPNOr4zSqe4CY1cTD4MmMAziHnZrtLr58gycXCB3+f
	 Qi0FnQPlPNdfwbACMy9qeNHRy6h9UT5eVFEtJX64fLaZeSBCX1lmqHoPOym6yOxqVhhnL
	 fiZLDEiWZbMFTzfU2hljjCkjKLFxBI4ssk2eoUQpkU8oE5tZMWrCealJdlu8YoFqY4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A+3Bnczc;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505E606A31C;
	Tue, 20 Oct 2026 08:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2505E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A+3Bnczc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792486560; x=1824022560;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=4nJ1AELYVgWN4UjiEx/SGOxAu2AWTS83yfs0aMMhJjs=;
  b=A+3Bnczcgn37KXlOTBmdbpBGTFR4diWCfYHDJ3zBc9QF2AGSly/h0hNK
   k3YNirnJa+3tectb1mzViUSe9SUfELpMakuRdNLzmzUiotyPWR2/lK7dJ
   zRU5bqR6jTr9HNXPhSWHh8ZvkXiw3LPzPBkAY8ozwWU+hRWfWOaaQA160
   tiqR8MoMZOQ1VQCsxwTIM5jVCj83oEJP7qaPYNpzTsTR+e+6fyw7WkDvm
   XNHTj9rus5tQqh5NZYwA4i78QYIJ78xlNGv6YzjxLQoK8K8cDbvazkKDK
   tk11OX06FV08pUxwhJJEJcxyEH6/plOLTCSS8oyt9nQymvnh4jvrXDpwP
   A==;
X-CSE-ConnectionGUID: dNTUsBGrT9qlCXNS6dietQ==
X-CSE-MsgGUID: 90OZbTnLS3SIlHcbTxHorA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1073440"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1073440"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:56:00 -0700
X-CSE-ConnectionGUID: 3ZelUOtIQSyTRAxtXNnDUg==
X-CSE-MsgGUID: nHBKbUWCTR+lKJuwUVxRow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4518302"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:55:56 -0700
Message-ID: <d872b0f0-9992-455f-9f04-4313fd185cf2@linux.intel.com>
Date: Tue, 20 Oct 2026 16:55:53 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
 <20261015191710.3632302-3-rick.p.edgecombe@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
 x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
 yan.y.zhao@intel.com, binbin.wu@intel.com, xiaoyao.li@intel.com,
 chao.gao@intel.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 nik.borisov@suse.com, yilun.xu@linux.intel.com, tony.lindgren@linux.intel.com
In-Reply-To: <20261015191710.3632302-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2026 3:17 AM, Rick Edgecombe wrote:
> In the early days of TDX it was expected that pages being reclaimed from
> the TDX module would need any cacheline from their private KeyID alias
> flushed. The TDX docs describe doing this in a couple narrow cases, for
> example reclaiming the TDR memory or guest private memory.
> 
> Similar to how the CLFLUSH_BEFORE_ALLOC features0 bit was never actually
> set in any TDX module, the flush of the private KeyID cachelines turned
> out to not be needed by the final TDX HW either. However, the TDX docs
> were never updated to reflect that.
> 
> CLFLUSH_BEFORE_ALLOC handles flushing when giving memory to the TDX
> module, where the alias that needs flushing is the default, normal KeyID
> 0. This was done with a clflush of the kernel's KeyID 0 mapping of the
> memory. For the reclaim path, instead it is the TDX KeyID aliases that
> need to be flushed. Since virtual mappings for these aliases are
> restricted to the TDX module, the module is the only thing that can map
> the page to do the clflush. The TDH.PHYMEM.PAGE.WBINVD SEAMCALL leaf was
> created to facilitate this.
> 
> The docs are being updated to clarify that calling TDH.PHYMEM.PAGE.WBINVD
> is not needed. So drop the kernel code that calls this SEAMCALL and the
> helpers that facilitate it. With the removal of
> tdh_phymem_page_wbinvd_tdr(), tdx_global_keyid no longer needs to be kept
> around as a global variable. It just needs to be selected and provided to
> the TDX module during initial setup.
> 
> However, don't churn the code to remove the global variable because
> it fits neatly with the other KeyID partitioning global data. It is also
> foreseeable that this would be used in the future for other SEAMCALLs that
> require passing the global KeyID.
> 
> KVM previously needed to call different types of tdh_phymem_page_wbinvd_*()
> helpers for different types of reclaim. So it had a stack of helpers and
> some open coded logic to use them in the rarer TDR reclaim case. Now that
> the wbinvd is gone, the steps for each operation are logically equivalent.
> So collapse the helpers and just call tdx_reclaim_control_page() from the
> TDR reclaim path.
> 
> This unification brings TDR reclaim in line with the behavior of the other
> reclaim paths, by handling TDH.PHYMEM.PAGE.RECLAIM failure by leaking the
> page and setting the TDR page pointer to NULL. This results in reclaim not
> being tried a second time, which is reasonable because the first reclaim
> failing suggests a problem with the TDX module.
> 
> AI was used to review the change.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
