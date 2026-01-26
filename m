Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E432AAD0;
	Mon, 26 Jan 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421777; cv=none; b=UfNZhbaS5l9s/eaSA0b4YihDfaLdD+8DgTuXX15G6TiXLTNDu8cVIWF6jNgm7UNrEOioejFaunWbou1HKeR6Ryyqs3MR/WDYRtbiWuSZXYVzkVDAqalvIghzKBbQSCraCOGy5IGpw5XlWsT3auGMd+JczXSoXU/94EiVIiPwfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421777; c=relaxed/simple;
	bh=0y1P2h2Xqtw4lamrYwKDWCOEESIF886bNLLphUJ9l+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxZH4uwCzuODS/ZmEnMj98Plqlp1Y4H1NoX+bFnYO40APW2Xi/0Pl1zTbC6qm4pQMiqtofhPqu9cBKZn6QO8PkTNOnRbUwAPHPeJ/eTcCittzlexiiU/Uo1vdj81Ka7vaud63y9vrzhAv7gRMQMKFWyGRH+sBgLE80Sj+UeHUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCrADpPJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCrADpPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769421776; x=1800957776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0y1P2h2Xqtw4lamrYwKDWCOEESIF886bNLLphUJ9l+c=;
  b=RCrADpPJjRelq7DiSrTNBSOnuMHSFlLuKetPpz5jxoJoJQc06liPQBhT
   H25BFt5rGHXfLmHdC4/AfP9K+q/mEyC9j1jfuq8aaJsvVHuXsTpaqFFpr
   lRaPYhJYcBZhqENGKlr4OdISsvojxN4UajQAI3LVyOFCglJdjBdDi2B7Z
   oL6/JqwFTZA29xfjj8TTR2k74CupiW7qwhXbLHSIGct4GYq6JABW3oe/c
   0isCeJbPv0iHAujD/wb7wEGIWBFkLOtPUTImJHKdCNtXal/FCd3hHfY7c
   JtmuN+AkKe7d2a1Ct43TuTaHLFIhBF/ao6COovNd3dupO5luZ0KcrP724
   w==;
X-CSE-ConnectionGUID: TDdKiHriQFChqZ3+x1a0Pw==
X-CSE-MsgGUID: GlIpLVpPQk6HPKGj9FRK6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74463812"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74463812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:02:55 -0800
X-CSE-ConnectionGUID: z9JZdROLTsqGcpncayiH8g==
X-CSE-MsgGUID: p6gH+1YBSTW3mB1tp/Uluw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207444604"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:02:46 -0800
Date: Mon, 26 Jan 2026 12:02:42 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	yilun.xu@linux.intel.com, sagis@google.com, vannapurve@google.com,
	paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
	seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 03/26] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
Message-ID: <aXc7wqVk0tDnm-CU@tlindgre-MOBL1>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-4-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123145645.90444-4-chao.gao@intel.com>

On Fri, Jan 23, 2026 at 06:55:11AM -0800, Chao Gao wrote:
> From: Kai Huang <kai.huang@intel.com>
> 
> TDX host core code implements three seamcall*() helpers to make SEAMCALL
> to the TDX module.  Currently, they are implemented in <asm/tdx.h> and
> are exposed to other kernel code which includes <asm/tdx.h>.
> 
> However, other than the TDX host core, seamcall*() are not expected to
> be used by other kernel code directly.  For instance, for all SEAMCALLs
> that are used by KVM, the TDX host core exports a wrapper function for
> each of them.
> 
> Move seamcall*() and related code out of <asm/tdx.h> and make them only
> visible to TDX host core.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
