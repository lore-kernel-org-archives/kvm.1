Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1194A3F2E;
	Wed, 14 Oct 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963968; cv=none; b=QqO1efyqS6z9ukODdi1+AvaZp7R6RH2YCS4fGJygiQN0mUF08aBUvmthRT7SmDCaXBMJFT8InNNrBcdFYi4HxNqN3RWnwVrUyXsrqsKstvnCl4mxDNZ+/kVSaE15AzFJGvNMcJyGeqNvMVK+i49LOzeaYpTA/Vy565z5zhRl4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963968; c=relaxed/simple;
	bh=Ft8VHNpwB+nRlfnciFrjrfrOLSOioUiRPl004H6PJzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hicwC5Cs8D77mlIejguOLkgNg6iZnd+paKgLWlOJOvH/dAiq4BAdopxzzKZK8nFj10Z38xLxFdguSgbmVLYeW0MIkd0M4xDA7HXZd8XkmdDcpAoJ3gpBqLGGvuu52cV1BghFjlkUhy6VXiZGrMdCLrmRTp3c9GIOd9Q0Tocqvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYtF4EEp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYtF4EEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791963964; x=1823499964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ft8VHNpwB+nRlfnciFrjrfrOLSOioUiRPl004H6PJzw=;
  b=mYtF4EEppFw79TSS8yv5Gkre9yEi/EmU3GlG+v+WS6v8AEFBhOLzgJ/k
   CAGkm7LrkdKpTfV3WppOtfb3Ur/S01dV7izpefKFtftEWm8oDPxW/mJ8E
   h8I7PVWlOzCbgZ3i4qFVDiE7aE3TiwDh26gHYxXFju+NCFPh6JA3ExoNT
   nP7z+azwDWR1N8W9wyNQDtkQgXMi1IfJxgnObivtBlJIeMSeJYX3k76XU
   EkXQVwvrqBwTobxDgtGsyzIv1RWjus8RkJLUwzFmfU4A/rww7q7w6Svbd
   fZtdWA+EhLfxLx2Xdz+/rtwGutlna+2cZULgSC+Np4cvjJpCApQEkf2Ks
   w==;
X-CSE-ConnectionGUID: xiAAvTlWRuyvWgZ1PGsImg==
X-CSE-MsgGUID: v5CohEH3Qn+8rkpmwNCEIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="695567"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="695567"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:46:03 -0700
X-CSE-ConnectionGUID: 2ojtZJNlSjG9GLS/6cg5SQ==
X-CSE-MsgGUID: mrEUVQEJSBqCxxf5HkfRug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1577676"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 14 Oct 2026 00:46:00 -0700
Date: Wed, 14 Oct 2026 15:41:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 04/10] x86/virt/tdx: Convert the tdmr metadata reader
Message-ID: <as8yRs4TyqCZjcn+@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-5-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094754.27702-5-chao.gao@intel.com>

On Mon, Oct 12, 2026 at 02:47:31AM -0700, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> The "TDMR info" metadata class has two readers: one for the fields that are
> always present, and one for the fields that exist only when the module
> supports Dynamic PAMT.
> 
> Add a table for each, both pairing field IDs with the 'struct
> tdx_sys_info_tdmr' members that hold their values, and read all fields by
> walking the tables.
> 
> Annotate both tables as __initconst since they are referenced only during
> init.
> 
> AI was used under supervision to review the code and workshop the
> changelog.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
