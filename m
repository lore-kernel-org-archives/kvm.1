Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9A2FFF90;
	Thu, 28 May 2026 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945367; cv=none; b=KfaM7pD3LaaU3aBkMmvQNlGba37GK5+yNY+WW7A+QRLCjrn3vPWIXP+wfg1HViBzTq6JIsarR2koDOoHbAVVNWTlXuO6Ydmf5GPGu97Mlplhq/FiaSq8MTgDbvNea6A1mpIjwSfFu299l2LeRpHXfTlVrmnkHhC78OuGgd2gUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945367; c=relaxed/simple;
	bh=q+hYNJRLyMrtKxeTXTn0MFJDaqGIR1rIaDHdEycycE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evLC14XiooegSwEeA82Pt6wOD5S+MitEALcgJA23IyNfCyzyHflxN8KDRN+sYIVAYCY9sv0p7g+j4qwo88Dq5ITBCyFBnkPqeCU4j1kDKqvYLOzZNV4bMvb4WTRxeLbJsPEpuDYpQQNhLJE5Bhw36wS2aOC7Cn7Qgjk9Rb2vdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmK1kqAi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmK1kqAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779945365; x=1811481365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+hYNJRLyMrtKxeTXTn0MFJDaqGIR1rIaDHdEycycE4=;
  b=dmK1kqAiRmwiaAFcQJv5pc8zenvAh1CTZTwag3dZ89cgiuraEsucx5N3
   OqHv7eruj7kCOC8mOCqRm41eMcRnMDZsxphWv2lSB2hVDqZpGqYRiM3fB
   1yo8Wv5O7+6QmMyXdZgbDtZ2aU4BfKa/6jn/kU3tYVVHbvp5+YoTGsSIU
   FMICMaCr+vkHAGLAXZPo8NquMO+DK1+uANil/NBmL7v8DJ7QoX/hlErVO
   BJECfpKsYUmWMnhbkFmV6nFMyWGuv7I6Tk/vF7XgUI0y+IS3EYk9orKT/
   dQmEKq0jdXSohqr6/OzdNX9rWTSSJqF5F2LHr3a06dy6Lw/KOhIKVZytY
   w==;
X-CSE-ConnectionGUID: hiNunkW2QmaC15VjJ9ankg==
X-CSE-MsgGUID: D5NBsdaxRIOc7wwizEP7wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84410177"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="84410177"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 22:16:05 -0700
X-CSE-ConnectionGUID: f/gsbL8ORYmukxROn9BEyw==
X-CSE-MsgGUID: Fv4MRA+3QeWtOOgJJ/8nEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="238274202"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 27 May 2026 22:16:02 -0700
Date: Thu, 28 May 2026 12:52:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <ahfJ9MW+kJp+kE6A@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
 <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
 <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>

On Wed, May 27, 2026 at 10:09:41AM -0700, Sohil Mehta wrote:
> On 5/27/2026 3:38 AM, Xu Yilun wrote:
> > 
> > Because for security purpose, these add-on features are always needed,
> > even if not all of them, so Extensions will most likely be enabled.
> > 
> 
> A cover letter is a good place to explain such nuances, alternate
> approaches, and tradeoffs.
> 
> > And even if someone switched them off all and saved the memory, compared
> > to the memory of a typical TDX capable system (lets say 1TB), the saving
> > is still little (0.001%).
> > 
> 
> In this case percentages make it harder to understand. Does it need a
> fixed amount of memory (~50MB) irrespective of the feature or the number
> of features? If so, it would be good to mention that.

No the memory needed varies depends on the feature or the number of
features. But currently I see the total requirement is ~50MB.

Yes I can drop the percentage, just state the amount in MB.

> 
> 
> >> In addition, could you briefly describe the complexity we are trading off?
> > 
> > If we delay the Extensions initialization to the first Extension
> > SEAMCALL, we need to maintain additional TDX state machine for
> > lifecycle, and we need mechanisms to synchronize parallel Extension
> > enabling request from multiple callers.
> 
> This would be good to include in the cover as well.

Yes.
