Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C512D1F1;
	Mon, 25 May 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688841; cv=none; b=HdlTO67LaZF+qOo2ki45YbEtwK7Efui377wo/PoJodnLLTjW3dirKLFZOHhLm0J5eQ0MN5iSuW7dCyVB/w3IUlG6n+mf2GeEkkZ94TOlw2YtPuxjV47k/vEdKb8JXggkrRMmzn/7Uk5DDSkGs7yv+pANnqVUCDU8pwNlxglhNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688841; c=relaxed/simple;
	bh=MlRJqyLjdxZ6bc6oLzgCm2gHe0XD5oU4+kyAXVXObos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7+7By6X0zy9swHc0wHSF7hzWM9Dbg4swtwXtf0eyI3Ymh7sQPa3x/vmKaH/d9d8rQrdBb1euYBMdk5UZHRsjavDDwlXg3IvX/Y6QP12b/MHvgr9eLZ/K88FIB2p/dD5iCecHI2daA74G3JU2OuYyoqtQWpzqYE7htBKIWA5XJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFKyf/af; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFKyf/af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779688841; x=1811224841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlRJqyLjdxZ6bc6oLzgCm2gHe0XD5oU4+kyAXVXObos=;
  b=CFKyf/afn2ktInTkRgiqfBrXe/v1xCRE7tNNB+6YNfzHNs1H7NGSQX+h
   SZnQK7k8fnULJxD5XwGxGBGC6iWSXB4lpxd2008VCS2Xi7b67eeCKtvgz
   YmUunbnA6+wD4ZZFzIAEWsys729b4jtIzSZEzqA8yxlFkuFOQ/iREhXWT
   ypTIJPrb/oHYic5ACY7dCUtrWQm17uQ0yuSmL35QeAEw4AWHqVOqvFIjM
   yFKIxTt+YU4S0LzCROwF4X4XwqNztfc3tWCDxbmj8C2PZe48xUo3b6ftq
   MSCUjF5rt8VOlpAyFNeAZqMIrjNrOyIrQnpHXnvtx1KNuurNat/AtE0IN
   g==;
X-CSE-ConnectionGUID: 6Aon84uhSROHGStBVEH0MQ==
X-CSE-MsgGUID: xC4Xwd4vTCixDKP6uv59AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="84393739"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="84393739"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:00:40 -0700
X-CSE-ConnectionGUID: jphD9s61THGXhW85SwlC9Q==
X-CSE-MsgGUID: FDeWkl5IT7iyyoRzfB0QXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="279619628"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:00:35 -0700
Date: Mon, 25 May 2026 09:00:32 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Message-ID: <ahPlgBgvIwimzmzH@tlindgre-MOBL1>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522034128.3144354-5-yilun.xu@linux.intel.com>

On Fri, May 22, 2026 at 11:41:17AM +0800, Xu Yilun wrote:
> The detailed initialization flow for TDX Module Extensions has been
> fully implemented. Enable the flow after basic TDX Module
> initialization.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.
> 
> Note that the Extensions initialization flow will still not start if no
> add-on features require Extensions. The enabling of add-on features will
> be in later patches. Until then, the system hasn't consumed extra memory.

Looking at patch 15/15, we need to reload the TDX module metadata at least
for the attestation. We need to do that early, so to me it seems that
everything can be just tagged __init from the start.

So you can just call init_tdx_ext() in patch 3/15, and this patch is not
needed at all?

Regards,

Tony
