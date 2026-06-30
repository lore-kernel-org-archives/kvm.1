Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733A31F987;
	Tue, 30 Jun 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817825; cv=none; b=lpEmWEsDbuNo4kq4/mBkhsoFmbC83aNaK6LJ8Gv72ejcn29txjoXEiZLqTAlibyyTl+0vcGnpwgYohoARD0mvGFnX6P9fOXZ2ygduJcs6HI7T2K0KLKWmVXSXqMhezv60zSxJ/jdmpV09AngHButkDt88lcoV6gq8PtfjFQfklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817825; c=relaxed/simple;
	bh=IlOiklHOXwmwp0vtiS+gd5qOIwexun6AyiW0nv87qTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTEH1Nt/uradScQXB6iU69+bgmSGG+bFLyWttutjRMefi/NdUQyp3d35fjqME3dNpukY+lbzeixF1k3QxwUuDPJ8Fg2P4nWd/6fsQHojgcWwBJa6087IPxsNmzMOsiE4Jtcr8TRhDLb5bW2A+ZRx8MZZI8OzpoCJR8Ei2L6Dciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dn98edRZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dn98edRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782817824; x=1814353824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IlOiklHOXwmwp0vtiS+gd5qOIwexun6AyiW0nv87qTQ=;
  b=dn98edRZL3irF+O/0FF1W/7+CHLH9TkE53O7mj7vadzt/+tUQvuAIgu5
   zL6snaCAWtbZoUBgP+Wv7/Ot9uX1v01J4ZU02QY6HyBJqlKyScwIoFtyf
   W/DJ/JoJTda+i6r3ux9miR4VNN9UmfGR6hygnxaVEedIcFSePBEtz42wA
   gjmpRMwjGSFla/7xru+3nBZYnE/nppOwXQUQEE9RgjRY4L1EQLOxEVHs5
   nWZlBsINEhyTp7z5ogZCFByG+vRyvDVuFp16QZqDLcokiBb98nHrToZj4
   DG2XkMwC6Ure43yYtEOFYMBWMyHCTbO9TXWpNVLvHEy19HwhZTmVc6m7q
   Q==;
X-CSE-ConnectionGUID: pIKBeG22QUiUx5PlIyILww==
X-CSE-MsgGUID: XJCV3UqVRK21eP9ZVuoOrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94127204"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94127204"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:10:23 -0700
X-CSE-ConnectionGUID: ZqReD9O9TrKigWMzkBHldg==
X-CSE-MsgGUID: M0p7rEZNRKGGpolu3Yl60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="275472852"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jun 2026 04:10:19 -0700
Date: Tue, 30 Jun 2026 19:10:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	dave.hansen@intel.com, dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <akOkGqH6RQEs/RWN@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <akIR1ClnTs1bRsD9@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akIR1ClnTs1bRsD9@intel.com>

On Mon, Jun 29, 2026 at 02:33:56PM +0800, Chao Gao wrote:
> >+static __init int init_tdx_module_extensions(void)
> >+{
> >+	struct tdx_sys_info_ext sysinfo_ext;
> >+	int ret;
> >+
> >+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> >+		return 0;
> >+
> >+	ret = get_tdx_sys_info_ext(&sysinfo_ext);
> >+	if (ret)
> >+		return ret;
> >+
> >+	/* Skip if no feature requires TDX module extensions. */
> >+	if (!sysinfo_ext.ext_required)
> >+		return 0;
> 
> What would happen if the kernel doesn't do this 'ext_required' check
> and always does the extension initialization?
> 
> If TDH.EXT.INIT returns success when no extension is configured, we

No, TDH.EXT.INIT fails when ext_required==false

> could drop this 'ext_required' from this series entirely.
