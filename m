Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0B37AA72;
	Tue, 26 May 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786029; cv=none; b=ChFpuM2MHEpQv7p1+lNDmEgnMgHUfWq6Na0G87/HcrKPyVR+X0I/ffdtSLZWyaOxohwiQYwiUdbiBQN8In9MZr2j3HZl5xWFs5pkx93I+kswcdJ7zQlKB0J5SS4V1mJeMFk7CvqUHNbzn++/uTzX69CiB6SsCYAkBhh2aNT9H9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786029; c=relaxed/simple;
	bh=VlxN1gZlE6div2qrTTk4vrnX8MwdS25Dx4Fh/5WzNJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow5L44lVhQREzQphXCIIO6/uz5Zfz11KSgb2J6OIfYROnzZxL9Dr4cq02S/uIbSWxOGEzii6tGgzuEcBM6uJQUUPc7hcfz8NdPmEsgH/haHkgnuIAhq5DAnbPad3wP9Im66Dkd+wEE2+T0cLPpTvO8bycrPFFg1F1qZ27Jcxkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nANuAOCM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nANuAOCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779786028; x=1811322028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VlxN1gZlE6div2qrTTk4vrnX8MwdS25Dx4Fh/5WzNJ0=;
  b=nANuAOCMfdOTx6NtFmAZHy+xEEIF8rTQcZ8KY9RDcJpANm5jk0peKPsR
   NtjQlb3bEeI1SND6Ado61xOYMhwM12N/2kettbJoyP7X/KqlbS4b3Hyrf
   btNKUtovV5W4jBWbdTFAqcRdtNH2P4prdEQ67HPY/dp6hgDYqXUpTaIH8
   8WZQ+g6TpJzhUnGPGh/IQk5CXCUx/TCq36+dtUQ9X1rnyNdCu/i42al1X
   PyLByCd+hVvhvTJUBBp+xAlYb9uZd4DKAUrt1EGSl7YNE/FGHaZG09xuW
   hwwZz98IA8pmc7WNTbrOm4iEuCukSlHzPVCmIwTWCpI/jndGZO5FonB6m
   Q==;
X-CSE-ConnectionGUID: IyzB+nAyR464tQqCrJmdZg==
X-CSE-MsgGUID: Wn9QjqqBT2uN9paDX9XN+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80502699"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80502699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:00:28 -0700
X-CSE-ConnectionGUID: L6PCRCCpS+2bd5HXY7evLQ==
X-CSE-MsgGUID: cnvgDg3/R3Gp8+IgzlN/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="265718349"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:00:23 -0700
Date: Tue, 26 May 2026 12:00:20 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
	rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
Message-ID: <ahVhJE7NHNblEM4W@tlindgre-MOBL1>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
 <ahPbb1Ws9hBruJ2d@tlindgre-MOBL1>
 <892508b2-6c61-4db2-a12f-902f62385e71@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892508b2-6c61-4db2-a12f-902f62385e71@intel.com>

On Mon, May 25, 2026 at 06:51:27PM +0800, Xiaoyao Li wrote:
> On 5/25/2026 1:17 PM, Tony Lindgren wrote:
> > On Fri, May 22, 2026 at 11:41:28AM +0800, Xu Yilun wrote:
> > > From: Peter Fang <peter.fang@intel.com>
> > > 
> > > TDX Module updates global metadata when add-on features are enabled.
> > > Host should update the cached tdx_sysinfo to reflect these changes.
> > 
> > This should be made clearer IMO. How about mention that get_tdx_sys_info()
> > needs to get called again to reload the TDX module global metadata?
> 
> Ah ha! This patch answers my comment to patch 1:
> https://lore.kernel.org/all/956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com/
> 
> sysinfo_ext->memory_pool_required_pages and sysinfo_ext->ext_required will
> be updated after extensions are enabled by TDH.SYS.CONFIG.
> 
> Patch 06 in this series already reads the tdx_sys_info_quote out of
> get_tdx_sys_info(), which mean get_tdx_sys_info() doesn't ensure all the
> global metadata will be update again.
> 
> So how about move the read of memory_pool_required_pages and ext_required
> out of get_tdx_sys_info() and put them after TDH.SYS.CONFIG, so that we
> don't need call get_tdx_sys_info() again?

Sounds like a good idea to me.
