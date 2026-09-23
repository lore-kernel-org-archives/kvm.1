Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D79446821;
	Wed, 23 Sep 2026 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149672; cv=none; b=XRPf+oudwB3u+9wBc8WNUWgt/HDDUqW75/f3oOKUJ+GYoT4eI3Do4MIiA0wSq/hWCpSYC+PF1V5gMatkTIUFeV+FfENMtBJ8H3wAnELAm5VyDVHkfrPBRiXeNs4UjN99KFRKHCoVBEV8tYzc46sUloxZNZr05KrpN/eeD55rhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149672; c=relaxed/simple;
	bh=2dDicVXRAjt7NPjDCajgGPNXdxkyaqGKL9o+Y6VYnfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoUy7eLe2tBLErrmtt6lC7pbiNyINssp/ted9psxCpo8O2ejwEg6WLN1+XW5n4VPyhxi9qu7SSdMAsI1xtv4Q8mg94FRnFKELuo+tBX7PAYR0HvSLHfyntloO8bZhGVz3MM50goqhXk06F0tRr5496eH+/wIHhzqkc8sgcUZ8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc4syK+1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc4syK+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790149670; x=1821685670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2dDicVXRAjt7NPjDCajgGPNXdxkyaqGKL9o+Y6VYnfM=;
  b=Bc4syK+1Wa4/X/brPCdI1JqyFQr9D8es2rFdZgHgk4WpvxTuFbu3Uo2X
   jwfkf87tfIdxDMj5WCIse+fVhHKAjzLYg3QUeKWy1ua4lzkyHki6fB3bZ
   oiLXDi/j7Jrj5eK2ZFpU6MuSWZVLTYQ/KGey9iec/zyI2IhGgBTxk+zYx
   F9onwXn8Z8qbj17zgUaMq1P46Ds0acWQrP7y6vRALjxAF7AGf4a//u5Vh
   /Uq4am22++CgU2MBClf/zrPVJlfO8zjD1437K2DRslARLRCPrsLtd5uLX
   Mtj6/ag4QKaDcJq+EjThzVlsTrxoJ77ByTXWiGIOVuHoiqMhRatIXNhdU
   g==;
X-CSE-ConnectionGUID: jCH2w/+LTHeGvzbQcoB75A==
X-CSE-MsgGUID: VvUOSWRoTV+7fm08Ar3sCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101406681"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="101406681"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:47:50 -0700
X-CSE-ConnectionGUID: XHnquBthT6GR4+uFk/kjvg==
X-CSE-MsgGUID: 2/7LKeoRSKWkytcAL7Tmlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4565033"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:47:45 -0700
Date: Wed, 23 Sep 2026 10:47:41 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
	x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
	yan.y.zhao@intel.com, binbin.wu@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Message-ID: <arOEHVklXn3VGBQt@tlindgre-MOBL1>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922205215.870563-2-rick.p.edgecombe@intel.com>

On Tue, Sep 22, 2026 at 01:52:14PM -0700, Rick Edgecombe wrote:
> In practice this bit has never been set by any TDX module, so flushing
> is unneeded. Going forward the TDX docs will be updated to clarify that
> CLFLUSH_BEFORE_ALLOC will never be set in any future TDX module either.

Should there be a separate patch first before these two patches to bail
out if the TDX module TDX_FEATURES0 CLFLUSH_BEFORE_ALLOC bit is ever set?

Then dropping the related code would be safe to do without having to
ponder if it's safe to do.
