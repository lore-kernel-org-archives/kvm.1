Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF043D3CF7;
	Wed,  4 Feb 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199402; cv=none; b=jUUu7WOrGR+vt7m8eCqz9y00eRnJpmxAz2uHsOTO2uxMT6JG/qvOwvw2wz+8cizz9kJobJrk+LbMjI/D3+Yr35w1BW+8U6lmgqUe+hEigRYlnudz674Fuu+qDbVh+TNtwuWGx3cxo4qwA5B1fMtBkfK/v9mYBqVyrCAKHX+dnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199402; c=relaxed/simple;
	bh=1OeKvx8xrEXVkxqWRjRKwhKLAIAayTvVwL4gtfXI2jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVfPO6R57sOTfi1hs41rG9YT7N6ljsuomYGPsQT0OV5If/r/FCT7wuIDf+99FRw7mcsI+A/g8F+ZZLu1eARAVwnkexF5xu5k/RMVPmAjEp4oe+GHmTWg3B2qqNNSAEI43JqG4eI2QssALRUx/ZSn3LsU2XNlcUO6jK9054A6KiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6dvr30c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6dvr30c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770199402; x=1801735402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1OeKvx8xrEXVkxqWRjRKwhKLAIAayTvVwL4gtfXI2jI=;
  b=V6dvr30cbR+1ag895IasxQFaRTNvGxPWxPXLw+zjW1bmuycLiaPF4gDA
   CvpUpfg8HRlaC5sguH5gocVs8ZkPi1+dXifhp4Wmr8Uf+zgYn4JOF2G59
   mhcH+xNjoXxPMa4P0pEEVXgCBF/LnviZohZxCmCNDb/6QJhp8fkbV9ga7
   jSLIUp0cWbnDMge4rz3FZ75xoSzTDc5yJav3+dcsW2U7fmVjJ+httK1eP
   bA6fxogRUZZp5RYKIZLqviSYmo3LGddH+NXogsmvBYe8ih9HLeVjKMZQk
   DaMa7hmZGyxNyO8NcXm3gGnTo9iV3xsWi3j5/jyZtSzP7rDlIj58wTQBz
   A==;
X-CSE-ConnectionGUID: 7miTNwI+SWec918Dk27esg==
X-CSE-MsgGUID: 4+pnto63SG6BuorjMshS3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82751356"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82751356"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:03:22 -0800
X-CSE-ConnectionGUID: 4jkRUiBkT5CFP/Sk8iyufQ==
X-CSE-MsgGUID: FCEuuxQoRO+ckrE+Vjb5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="240803116"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.244])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:03:14 -0800
Date: Wed, 4 Feb 2026 12:03:10 +0200
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
Subject: Re: [PATCH v3 23/26] x86/virt/tdx: Enable TDX Module runtime updates
Message-ID: <aYMZXjWE2LDZARSn@tlindgre-MOBL1>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-24-chao.gao@intel.com>
 <aXdMfzIxF6KR7VCe@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdMfzIxF6KR7VCe@tlindgre-MOBL1>

On Mon, Jan 26, 2026 at 01:14:07PM +0200, Tony Lindgren wrote:
> On Fri, Jan 23, 2026 at 06:55:31AM -0800, Chao Gao wrote:
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -32,6 +32,9 @@
> >  #define TDX_SUCCESS		0ULL
> >  #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
> >  
> > +/* Bit definitions of TDX_FEATURES0 metadata field */
> > +#define TDX_FEATURES0_TD_PRESERVING	BIT(1)
> > +#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
> >  #ifndef __ASSEMBLER__
> >  
> >  #include <uapi/asm/mce.h>
> 
> How about let's put these defines into arch/x86/include/asm/shared/tdx.h
> instead? And use BIT_ULL?

Sorry I was confused. No need to move these defines to
arch/x86/include/asm/shared/tdx.h as far as I can tell.

The BIT_ULL comment still remains though.

Regards,

Tony
