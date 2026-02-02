Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8D2BE7DC;
	Mon,  2 Feb 2026 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018701; cv=none; b=qoqX6yZySvYk4u69CbA4FOJ/B2F3sS81+yNOuWJnh+xE7gEuUwX1wMCh14wtsOzMeti2rUUok7VFCHVp3MhwAznvZlNjtDMHrdyKNptPdTbQ1HDQQHlZ8DcOY/yCsgGuwEnflgb7DH2c/is/3ab5CwJtM5IGE33Z/vUNo7S8evQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018701; c=relaxed/simple;
	bh=0pFTkINYXGPbXoEai6AMtRdLBHDACOexaYmNPlJgOh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=groKjbVi4V6vU+o3jJAcRlMPftNk7vNYFrLPHpi1I6086sRJ97fpK1marJlu3+vd1P9qOxQLjbh9ChwkghLeKEAqe/bdmXYTed+G2D1irdpTwDGDqSNc7/w3BMECoWxVG+Vj3FtuyO76EVcZu0A4bH6+i3dxSADrZLNIEsKtB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJrooV2V; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJrooV2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770018700; x=1801554700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0pFTkINYXGPbXoEai6AMtRdLBHDACOexaYmNPlJgOh4=;
  b=WJrooV2VXYb7WaI8rPbZ6HdVmzHdYjgZWN9T3Ws9kyDtfB4Nrrjc7FXc
   LK0jbUj8MahwzKigEbxkcUVDzXIhKBrdmnA9EhpqI11cZUP1f+9b2Lkdu
   aP3roftxtDwE9mvDpyBASBxu/hYk7OGoKC7R1xy2uSU8ldK3t4W9A6tvX
   T4ReTDr5LAOq3+IvauvFL9IAJZlUXuZoNQWM2X81D3DSsmm6dwCwdi3x2
   fcYmAwxo0a5Ysg6MlLw3sKNKzKTxOkLbDhrYmjr8cUBPn7mO7gWLO1iIs
   PPBbbw7jHuFYuB3aBt95eF3k8tRaJ9CSj7f+dhFzwa3WeUCG/XYmf1aCT
   A==;
X-CSE-ConnectionGUID: 9C+hhNoJStaoA3vKbV67bQ==
X-CSE-MsgGUID: FDWpeWBLQYyADO+Pog9a5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="88750780"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="88750780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 23:51:39 -0800
X-CSE-ConnectionGUID: Q7zI3PUzRMCnayHeKCUjqw==
X-CSE-MsgGUID: 9l+BeM7UTgqCWVC5CrkDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209449160"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 01 Feb 2026 23:51:33 -0800
Date: Mon, 2 Feb 2026 15:33:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	sagis@google.com, vannapurve@google.com, paulmck@kernel.org,
	nik.borisov@suse.com, zhenzhong.duan@intel.com, seanjc@google.com,
	rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 22/26] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Message-ID: <aYBTNYRGAFqlgCSl@yilunxu-OptiPlex-7050>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-23-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123145645.90444-23-chao.gao@intel.com>

On Fri, Jan 23, 2026 at 06:55:30AM -0800, Chao Gao wrote:
> tdx_sysinfo contains all metadata of the active TDX module, including
> versions, supported features, and TDMR/TDCS/TDVPS information. These
> elements may change over updates. Blindly refreshing the entire tdx_sysinfo
> could disrupt running software, as it may subtly rely on the previous state
> unless proven otherwise.
> 
> Adopt a conservative approach, like microcode updates, by only refreshing
> version information that does not affect functionality, while ignoring
> all other changes. This is acceptable as new modules are required to
> maintain backward compatibility.
> 
> Any updates to metadata beyond versions should be justified and reviewed on
> a case-by-case basis.
> 
> Note that preallocating a tdx_sys_info buffer before updates is to avoid
> having to handle -ENOMEM when updating tdx_sysinfo after a successful
> update.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
