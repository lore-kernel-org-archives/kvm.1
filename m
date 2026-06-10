Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E12C11CA;
	Wed, 10 Jun 2026 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063090; cv=none; b=rtqXX6+edMQygvJV8Jeh8Idh7b+CsHmHsUrC3B50N1WfkQSd3BRGKyGrQj17G2Bg4Y0v9sLQTLb2r9EDW+K//BN48tCuokfogYVaTUrRxH2aADOBFaxSpzfMfpIIQ7OCdy64NqECZZqIIMG+0ItFyDaGZzneHN48L2yJWbmbaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063090; c=relaxed/simple;
	bh=5m8rpWcj8S1LrjDLtPFW7I3UyIZB8r+D/oJzbIFA1uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+D8KwT2sm6pf4ajIdn3oQnEfDUYOSeiV6lGJG5KlIV2UUELMzhQGffaXnWB4nc6VMRkF/59qQ6/9WdlhJs2wAt5DrnCOLsu+Pp9EU3jSXja4TTZp4EUL2TDNVPU2qV9rRQv68UrNts4kybY/YFHyhK7AxSZfAEIlSzWj/dI6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcSyLRB5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcSyLRB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781063089; x=1812599089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5m8rpWcj8S1LrjDLtPFW7I3UyIZB8r+D/oJzbIFA1uY=;
  b=BcSyLRB5GFLKYbzj0l1xnk9VYabDuYIZwR7isD2V9wJg57MH7xrnVet5
   fBu4iZzMjm51cldFzjyibv/tx6baw50KSollbX4sRZWxyahUaFoYUQ47I
   p3brSUS0YkiWG4rlXfVjG9SFLUmI3OmI2dTCkSfp68DWgA3RQEQaiK7Cu
   r6ZZ80o33zPA6t2dMczmsnuVBwG9CpQt1S2lNXOA8qoNbyQcLryLLsPzU
   OTSYoEl31t+QTchqA4o2ZO+y5DiCMW3pY2iZcVJbD2rr0XZT3sMMZ2/mH
   hpzwdXRoStNXDPaqjPFu1aStAPZFUPkAaRN8B9A6bqW+IX1ORD1KG75UG
   Q==;
X-CSE-ConnectionGUID: PGr9x+hlTC6t6nXN0cj33w==
X-CSE-MsgGUID: 1MFNxNTWRr6rPrJlICa1Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="104511842"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="104511842"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:44:48 -0700
X-CSE-ConnectionGUID: iVCN9X4TTrCCDqpOnegVsw==
X-CSE-MsgGUID: im8uohycQcuHzMFbyuHPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245198930"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 09 Jun 2026 20:44:45 -0700
Date: Wed, 10 Jun 2026 11:20:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <aijX6DkLP8eMRhIa@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <1783e7bd-3759-41f7-93e3-2f9e21264bd4@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1783e7bd-3759-41f7-93e3-2f9e21264bd4@intel.com>

On Tue, Jun 09, 2026 at 04:06:50PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > Add reading of the global metadata for TDX Module Extensions.
> 
> For tip, isn't the expectation to explain the context first.  The
> very first patch, might be a good place to explain a bit about
> TDX Module Extensions in general.

Yes. I'm trying to add a long context for the first patch but was
suggested to move to cover-letter. I think I can add a brief
introduction at the beginning:

  TDX module introduces a new concept caled "TDX module Extension" to
  support long running / hard-irq preemptible flows inside. ...
