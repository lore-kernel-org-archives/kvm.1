Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E140961E;
	Mon, 15 Jun 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540598; cv=none; b=MPiNc8nRHD5sjV1L3VUGDBwZZes5Ax+rIvQi97WlfkW53GL9deKlwi5OiHecwwwzMjxMkREWEKLG6BbQBUpCBGKDfY69yvidfrEVaFcCEZh0O57wx1h2skR+zC8XFZvh0500C0bncOjDAApIiN77d8BjnBaY9G0WNXqOjUx9lxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540598; c=relaxed/simple;
	bh=hadKou4uoljaU+4LI3Rv8abKPkMOjSaFglihRi7xjFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD85LFiX75apMjo4OmOwuD8/6OnhAYGNI1nI4Djbr0byvuF04SrsuzbT3Gero4h8TYnSTWdE+xEeoUjNe50rF7jYnRAbTESmuI+XUqNOkZmZ6qopREKAlAD2gRTGIBR3TmE6GBf+L1aiePqy0eWA/HsX+7B4wLtoJw2edTEoZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9j9uSkW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9j9uSkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781540597; x=1813076597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hadKou4uoljaU+4LI3Rv8abKPkMOjSaFglihRi7xjFU=;
  b=G9j9uSkWwtY5xH77oG1sPMhOL3xAIxm4moiU2KkoqD0VQ99D1WYYO62X
   Kt3plEttB26G0w1/Iqtbm2S0OiipSGslhSP/JUNeP7aSsfboXiOqQ0Qo1
   qbeoYw/YcnbsByzbcUC6ETCWX+4AlOt2wrxFKJAb6gIc0mBR3KC4WhiCf
   xF6W6HbI6aGDKR+chWeuEgkTbSjNgAGO7YJapVJiXJ4iIqT3giDW2cFWT
   +8iGwcf81GhJAAFWxFbWo9GDQ/YcWZGjv1exT/LMjWydZc6bCTJMqfP0F
   EZcpEEMCoagtUmtB3eBBU6Ix1EnaumDXz10KjWMsFuNTi5mj2j923x4N8
   w==;
X-CSE-ConnectionGUID: vNZ2voRcSUKvnlz5lxBSdQ==
X-CSE-MsgGUID: KO6jGC2eS9WXJ+WOR9IYtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82394280"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82394280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 09:23:16 -0700
X-CSE-ConnectionGUID: n/IvD/qPRly03AV42TiJ7A==
X-CSE-MsgGUID: erddFOBIQRujdY0BKpx1Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="249407173"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 15 Jun 2026 09:23:11 -0700
Date: Mon, 15 Jun 2026 23:58:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org,
	peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Message-ID: <ajAhGj391ysXQS5g@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
 <6a2c9f90d348_9b8551003e@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2c9f90d348_9b8551003e@djbw-dev.notmuch>

On Fri, Jun 12, 2026 at 05:08:48PM -0700, Dan Williams (nvidia) wrote:
> Xu Yilun wrote:
> > The detailed initialization flow for TDX Module Extensions has been
> > fully implemented. Enable the flow after basic TDX Module
> > initialization.
> > 
> > Theoretically, the Extensions doesn't need to be enabled right after
> > basic TDX initialization. It could be enabled right before the first
> > Extension SEAMCALL is issued. That would save or postpone memory usage.
> > But it isn't worth the complexity, the needs for the Extensions are vast
> > but the savings are little for a typical TDX capable system (about
> > 0.001% of memory). So the Linux decision is to just enable it along with
> > the basic TDX.
> 
> No real point in rehashing the rationale for the "any available, all the
> time" policy yet again especially when this directly conflicts with the
> "relatively large amount" comment in the original cover letter.

Agree. Will remove the section which is copied from cover letter.

> 
> Otherwise I agree with the proposed reordering of this initial series.
> 
> In general though, no big showstoppers for me in this first 4.

Thanks for the review!
