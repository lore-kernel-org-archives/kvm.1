Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F52147E6;
	Wed, 27 May 2026 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855981; cv=none; b=ghl8XJqJnZLWmdC7wupFlEdfutoHD8MDoGIqGI/BwNBrlgmFjlHg+clEx1u8D18vktfULME12bV4bTS4xAu9TrIX3uSZN3Un68iP6D6lFiQJvX8e5u4x3TxP1SVR6nsjF50DtGSfApw8OSrhIRE6gyxSQPhvYUSy/sawJ7OOFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855981; c=relaxed/simple;
	bh=8S9DeWDf9rS39tYOD89/iMetZxfaG9F8sPnegQBMG5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwRR12kZyM7wg7+PNlGXhDZh9hqiMHosZMoICjeeGbEX0aB3LOsfq2DVYEzb4bc7Y2qJ/bMz61w62pq1cluTKBrXq+pBh6HkabJAlxBZPQ2RrzfWu0aaoCVzkgPbx/yMqRjoez9Ian92V4SucSSEqbSZXDCsnjZOR3U8p0/PkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlfHl/qS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlfHl/qS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779855980; x=1811391980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8S9DeWDf9rS39tYOD89/iMetZxfaG9F8sPnegQBMG5w=;
  b=mlfHl/qS/b6XBWlHwFwUVgMPdevr4e4YNlJCbX8ph71o4qcTGOAxTecJ
   tO0nztqKirg/0+Ju0R87gmTLX4W//gjhNC+7c4MJEXVr/YIoUk4J5dN/z
   yQl5XjlSlz4UPseZTTDw8gSE/uGdhgPvH1J+ixYzo1BV4TksVk7cEnT5Q
   0FyKfoJx7LlAlUBY4Zr36tXTwStIeNrUIi6H/NB/7+8IIDuehkvJTOqZq
   ghc4TFEXJClNtDkA0mkkkjHtcedzf/5aJYAzWCkY7mCUZmIbi/7SyuKfQ
   SCsoULqMpnoh1zNRvX1C27jmmI1KXWboIvr6ftWQLb+ckOZrR3dDlP4dG
   w==;
X-CSE-ConnectionGUID: U4vbVWIaRkummuF/9ONGag==
X-CSE-MsgGUID: Xrp7+QGOS4S+0XThu3grMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="92151714"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="92151714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 21:26:19 -0700
X-CSE-ConnectionGUID: HZlQrGcBTe+4v5CAiGASlw==
X-CSE-MsgGUID: 5sYiMExoRruMOBdz31zLwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="239505904"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 26 May 2026 21:26:16 -0700
Date: Wed, 27 May 2026 12:02:21 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Message-ID: <ahZszST9gQB9XgYS@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
 <ahPlgBgvIwimzmzH@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPlgBgvIwimzmzH@tlindgre-MOBL1>

On Mon, May 25, 2026 at 09:00:32AM +0300, Tony Lindgren wrote:
> On Fri, May 22, 2026 at 11:41:17AM +0800, Xu Yilun wrote:
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
> > 
> > Note that the Extensions initialization flow will still not start if no
> > add-on features require Extensions. The enabling of add-on features will
> > be in later patches. Until then, the system hasn't consumed extra memory.
> 
> Looking at patch 15/15, we need to reload the TDX module metadata at least
> for the attestation. We need to do that early, so to me it seems that
> everything can be just tagged __init from the start.

I'm good to it. The Extension initialization will not start without
add-on features anyway. Let me move the patch as the first one to avoid
tag churn.
