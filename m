Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273193002DC;
	Mon, 26 Jan 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424885; cv=none; b=Ua3NRcfl53KI09Z9aGCOHlOiXorxskD1Hhbxq9DN5W8+aEoXMd/4+VPuU8U3psLCzJvVapAuzIcaWMjiZlqmiA9Z3bM+cpncpPof/X8VdmWULGaxiKTcO/3NpJ/s8JJkWeRxFez+26ASAy0elpTKHnZBbGEyI7KWpjd5wwT4Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424885; c=relaxed/simple;
	bh=SNwr5aGg+jTIM2hL6kKNz6Oti5VreB//TNHn+AUYnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZlhEz55GrAnkVkrCPpfgUsw6p1HQ31OOyrWoJvt8cJuSpZd5FsjqRlVmLc4yT+ZOB8pzKhueSiAucEecvl4IBpF1hnjM6LI8FPt8Tj5iMLCZENogUuiujXCifBykv+Ayx+aAcEbTOkSKU0FcBUNPBZBQvwSP8YjIEUXW9xctS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoomSed8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoomSed8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769424883; x=1800960883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SNwr5aGg+jTIM2hL6kKNz6Oti5VreB//TNHn+AUYnRs=;
  b=GoomSed8IzRShvMfOXCnaeIwzAjXlNq58gqTUDCNKnWTVMc3jzVoq1v+
   VtYu+0jbZvV456u41hbCTJl8hdQp0L/nKdnlBaC5/sqFfOVY0uupz3bmL
   TJb3D8O5xsIYM1GgKN52V+1HMJbjch5+POWWSTkvhTOmxYA+W5XBzJKzN
   tIcDvPO9VGPhVloo6+sgYruxU8O3i3GVkw1UFhHktrYanKIWXFwCEBEq4
   SXwDT7B2wfT8iOF39EUEvkEV6MuR4fzNORv22G3Uz4AFt5LEyAmxE96m3
   Nbq89Msc8USY/gFxibs/Rjj1Va/bgytHiocEJl1Hy8bXyPlBOgQ70k5Q9
   A==;
X-CSE-ConnectionGUID: EZCYotcuS0apKFq4ka19EQ==
X-CSE-MsgGUID: emJ2iUuyTOSD/VKY6m0s8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70503958"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70503958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:54:43 -0800
X-CSE-ConnectionGUID: ssbkUkpBQ+mQxcIWCFcn2A==
X-CSE-MsgGUID: 5ynHz4SfSAKShgyLwYClHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207708461"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:54:34 -0800
Date: Mon, 26 Jan 2026 12:54:30 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	yilun.xu@linux.intel.com, sagis@google.com, vannapurve@google.com,
	paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
	seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 21/26] x86/virt/tdx: Establish contexts for the new
 TDX Module
Message-ID: <aXdH5taHr_Kcgmdx@tlindgre-MOBL1>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-22-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123145645.90444-22-chao.gao@intel.com>

On Fri, Jan 23, 2026 at 06:55:29AM -0800, Chao Gao wrote:
> After being installed, the new TDX Module shouldn't re-configure the
> global HKID, TDMRs or PAMTs. Instead, to preserve running TDs, it should
> import the handoff data from the old module to establish all necessary
> contexts.
> 
> Once the import is done, the TDX Module update is complete, and the new
> module is ready to handle requests from the VMM and guests.
> 
> Call the TDH.SYS.UPDATE SEAMCALL to import the handoff data from the old
> module.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
