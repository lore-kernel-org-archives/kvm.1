Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC22395DA9;
	Wed, 10 Jun 2026 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078935; cv=none; b=pbxE9v5mukqCapW+S5VGDb0RFhL4wlV1sSy880+B8AnFLgvFI6s22kIbkYARlsas8OCOdkqmeDIAxZlOjxj/Kg4BbviZqJlnCnGNMgNwM3e5NJkOPTkBP5EH6x7TmKm6wegkpsmW7xvSkNhMe9bl/BDLhelqIVPRosHC3mS5T1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078935; c=relaxed/simple;
	bh=A6Q+8jkFk5qYGuzlU0EFsmoMuystZMGRG3neQusWxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUYQfFkqaTyfEqyUpGH11EdGHAeWGZtiXNNDwaGHNcGAK6183B4LHxdx8I0+QVIIc/mTF8rO39S9ioi2Lq7GMHLo+KJjv4mO6nMI3ujSKZtNTISOd0/qvMSEQU8UY38DEorq2ISkzv/s4r9MvLY6jRI1cqN+6YGOUmDNKlIi2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PF7agJh1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PF7agJh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781078935; x=1812614935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6Q+8jkFk5qYGuzlU0EFsmoMuystZMGRG3neQusWxFA=;
  b=PF7agJh1f6c4pqII9/1a31vRXb2jxp6wleBt05uw3347EqSA8FlGGmdW
   tzcdI53evNgv+jG4hvGkQDeIjLK5nw9IN9xxj5uMoGlWTLdB2qQrvIPkj
   /V+cKMtFud9cB7GvHIR2exkWIOBst9NED6oal02i1FB9kPpN52pzTHmv/
   tCxv5k0PUiv7v0jsCo6nKehdnK4MKRJDGb7RjxNR8wi5zczwjLCbzeWgT
   SCiR0ggkjuu1QNVnDZDNLojUih2khoUbAcVxjtHZMUkCbtbE6yOpvIciZ
   22HF1ilbbfgPMqi4c9Tlc4UGmK7jnjmAH30udAFRYptE+sa28nSylfpRI
   w==;
X-CSE-ConnectionGUID: dm7Zlp3/T5GWlb/0ezOd2Q==
X-CSE-MsgGUID: rkah6I3+T4Oe4I/Tuulvzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99283381"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="99283381"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:08:55 -0700
X-CSE-ConnectionGUID: EXjDNt0tQ2ec+G3M46i2vQ==
X-CSE-MsgGUID: vI2/hr+5SFS78zjNrBNzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243135429"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jun 2026 01:08:50 -0700
Date: Wed, 10 Jun 2026 15:44:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Message-ID: <aikVzTYAYpgNtgT9@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <f7238ced-73a0-44f3-8a50-23eb5a2da5dc@intel.com>
 <aijygJ9YqskIOvB3@yilunxu-OptiPlex-7050>
 <33974159-ec7c-4c5a-845f-02ea4e67a0c4@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33974159-ec7c-4c5a-845f-02ea4e67a0c4@intel.com>

> >>> +	if (r != TDX_SUCCESS)
> >>
> >> Similarly could this also be TDX_EXT_MEMORY_POOL_FULL?
> > 
> > I don't think we should pass the case. The Module provides the number of
> > required pages via metadata, host follows and feeds pages but the Module
> > said "Sorry, I'm already full". This is inconsistent behavior that we
> > should call out.
> 
> TDX_EXT_MEMORY_POOL_FULL is not an error code. It is a success code,
> so the question is whether it will ever show up on, say, the very last
> TDH_EXT_MEM_ADD.

It will not show up. I got from Module team that it shows up when the
poll is already full and host still adds more pages.
