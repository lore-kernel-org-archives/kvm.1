Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A555367B94;
	Wed, 23 Sep 2026 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129928; cv=none; b=kmK7WIUTZI822P71LmjwYVKP2/ocut9/ECq/rr0pbvA90dqDNgnxmq/54wzJllv3V9I2fboFDd3p4O1SXBlBi6sAN8IV0oRkOKRp8UYH/7Z3xotYbTHfmLBInERy2CZg/RrAojmjTpJMRQLYdokPY5Z9f5XlaU2F+gVFMl5YlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129928; c=relaxed/simple;
	bh=O+LCRIQTYZVhktauqoEd3NdKsW3tvkPlu7H78yGl9nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YJXx7O84MyQjTeL8pZuHbfIeKBGsjs8yC06d66qmlqkywJ3q1cP48l0i+O42m0gQbDkU/ceiqkdWCvOxIr8GDcBwlfJMKTv5p9rwxyH1J8bk0ErgeWOTbtkAYBDWI7Jc7/erXOPcL4aqxeZBEmZYsRyb8tiRuEHmT7zqToirhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESDodc3n; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESDodc3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790129926; x=1821665926;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=O+LCRIQTYZVhktauqoEd3NdKsW3tvkPlu7H78yGl9nI=;
  b=ESDodc3niX34Difik3CxXAP9h7C+w+HkJiPgXsDWH2PFqDoLQrlGK3OK
   vWOU9FoBh+Qfs33XZe/IX+aXYkxfv0GQMDZV0Js799AnHMKWKHawg8QMe
   +XtwN5OIXYtPqrRczJ+jWitq2OLHfGQu+O+Y0JULqcfzYcjJcYvK3fmWj
   /Oj7Zeg3yqgBLD6QJztni0NARVwfl/j8qTjlQEpcCfzNej4UL/xb57w2o
   NfY18WJIrSBbPNfqSjtAJ+8CV6TDXHerlw9dpN8dImeVsCt3eO+NkipNt
   JQFy6SY3XfSpQ6mw3CbgyxF1XDYEmiIpYwkzsC7CnO/onzOF73giw/LwC
   g==;
X-CSE-ConnectionGUID: U4UosHHVTByU3TUF7JVRgA==
X-CSE-MsgGUID: fcfqmnY5QsWoq9n432l0JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="116312452"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="116312452"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 19:18:45 -0700
X-CSE-ConnectionGUID: 5BPqopjgTCGiZxmZtb15ng==
X-CSE-MsgGUID: 5jXiAqvIRS+eJAA8dnM//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="273579086"
Received: from unknown (HELO [10.238.208.182]) ([10.238.208.182])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 19:18:43 -0700
Message-ID: <3c6e968e-f625-4ea7-b815-1c9be7d2bef3@intel.com>
Date: Wed, 23 Sep 2026 10:18:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, pbonzini@redhat.com,
 dave.hansen@intel.com, seanjc@google.com, x86@kernel.org, kas@kernel.org,
 adrian.hunter@intel.com, yan.y.zhao@intel.com, binbin.wu@intel.com,
 chao.gao@intel.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260922205215.870563-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 4:52 AM, Rick Edgecombe wrote:
> In the early days of TDX it was expected that pages being reclaimed from 
> the TDX module would need any cacheline from their private KeyID alias 
> flushed. The TDX docs describe doing this in a couple cases, for example 
> reclaiming the TDR memory:
>   Flush MODIFIED cache lines: this is required to avoid corruption due to
>   cache line aliasing. Note that all cache lines for all other TD pages
>   must have been flushed before the TDR page was reclaimed.
> 
> For a similar reasons as why the CLFLUSH_BEFORE_ALLOC features0 bit was
> never actually set in any TDX module, this flush of the private KeyID
> cachelines turned out to not be needed by the final TDX solution. However,
> the TDX docs were never updated to reflect that.
> 
> Since private KeyID virtual mappings are reserved for TDX use, the TDX
> module has to do the clflush itself. The TDH.PHYMEM.PAGE.WBINVD SEAMCALL
> leaf was created for this purpose.
> 
> So drop the kernel code that calls this SEAMCALL and the two helpers that
> facilitate it. With the removal of tdh_phymem_page_wbinvd_tdr(),
> tdx_global_keyid no longer needs to be kept around as a global variable.
> It just needs to be selected and provided to the TDX module during initial
> setup. However, don't churn the code to remove the global variable because
> it fits neatly with the other KeyID partitioning global data. It is also
> foreseeable that this would be used in the future for other SEAMCALLs that
> require the passing the global KeyID.

What about TDH.PHYMEM.CACHE.WB? Can it be dropped as well?
