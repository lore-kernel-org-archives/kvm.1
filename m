Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565314071D3;
	Mon, 15 Jun 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538552; cv=none; b=PUlKp3nmLsEHVO4O8rAkXUAMCFQVcP12jYuyCHCgZ2/IblAXW/76k145M0+hPThydmCZ/q5CxjyTpK/R95zI5DCsuWriTBqXsKlyN+P0YDO8bKe+dt+YNodT4aR13uvRtps0CtjX4sUKsBbVmSfp4ecbH/xdcL6vwk6xah7qQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538552; c=relaxed/simple;
	bh=fyl0yUaPClU2NroLplGRQmx8vws/UzQ/L1fCrdFgHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6fS0hBl+NwBVzceE3dPQuF/raArXVGWPG+btR3rDZV1OKFi7P2WNhezFOlwG53jx7AIN/6nztrPUqBz5KHwZ56u6C0Ob2mz02Dn/mgdOi3Nx1tCIlPg0IXBgxs78SIZ5RD96xnVb87FPiG1wa5W0rOLKkA5/VtPBBIws6A3cpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9DHI8pD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9DHI8pD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781538552; x=1813074552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyl0yUaPClU2NroLplGRQmx8vws/UzQ/L1fCrdFgHNI=;
  b=D9DHI8pDXUiBeiCQ3ierR5sh8EggLMOkG0dWfmEGDyG0d22dOkBvDNOI
   HIYYgtUueaPGvt61b36wlRGNsqUaUv35mnScnR4uXmimDctaYN0cQN42o
   NVVQoHCqwEc3DgAhKxOUOPC5FuLh59AJeCORaTKaXk+tgbL+ccczXOevR
   erJ8TXxyzoZDBp8Vt5pieICa15Gl/gwcjko/OYf3RBRA7dRyRfXzgOK9P
   9+0I+mSvdcPMDXuRxxKAeh7a64yGeN7fUVhSc+YptXOlC15UOp46CNB09
   JAJeuRLJYuxsz8ei8XEzmqH2aLbLemgAyTZoKvHtbbxKtuq03D68DwCwT
   A==;
X-CSE-ConnectionGUID: KG9U1OYnQ7mdC/B23IQAQw==
X-CSE-MsgGUID: 0SHVJ6TlTTaojrbsZTdEsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99858353"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="99858353"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:49:11 -0700
X-CSE-ConnectionGUID: 9b+mtrtkSSK5BG0LA5fjbQ==
X-CSE-MsgGUID: Ro29/Ul1SkGIttGVy9cQYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="247593571"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 15 Jun 2026 08:49:07 -0700
Date: Mon, 15 Jun 2026 23:24:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org,
	peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ajAZHwyMdSlhiNYx@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <6a2c863a681d6_9b85510064@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2c863a681d6_9b85510064@djbw-dev.notmuch>

> > Check TDX_FEATURES0 before reading these metadata. If a feature is
> > advertised, a failure in reading associated metadata causes the entire
> > TDX initialization to fail, otherwise skip.
> 
> Others already commented on the patch ordering, so I will just comment
> on the changelog to recommend referring back to the "any available
> extension, all the time" implementation policy rather than saying "Linux
> requires" which is ambiguous.

Agree.
