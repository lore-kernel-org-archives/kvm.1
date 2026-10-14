Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6836BCED;
	Wed, 14 Oct 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964107; cv=none; b=TaafJ0VYwmQ8F6r08bvrUDAWiqhSL8s6nsCBoqs5VRS4KzbxoCTKzzh3BT7wiQP1AXCJPnvSjeXBAqqyopm9qm9BGB9+DDuD9HS0bmWpbj3iwtsEybwJnTsHibT3ll2u65iUUGsHcvN5qeUDx4MKd4Yn65pktTPy1NUnz94g3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964107; c=relaxed/simple;
	bh=mau0UFJlAQZkAU0PjFL0FWTuuN0SHvyeiv82fHx/k2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7bNIgg/zfWIDKLga5oTMugeRCC+htODap19dTnYS0mAAAqz39m60zDAWx8+XYYe+/hh/nT68Tt8KYf8HnTZXVtLQg0RIcQSRmaIcOiWaMPPh+39jaYHfOF/O3x4lNx3tq2CB5yxVMbcND6L8EfOp9SinmD5BpbqNiplM8Nbb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLjN4eUA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLjN4eUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791964107; x=1823500107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mau0UFJlAQZkAU0PjFL0FWTuuN0SHvyeiv82fHx/k2g=;
  b=GLjN4eUA0uH7AYlLW4dolw6WmtEAZctsmIG4/Sg/X20AujqZVP2hMRfI
   SA4ObXB36ptof/Npre4qh2waRUWhMq92iE6vrHOb/h9DXgN63ed3DhBHc
   z//QUuEWNSN4QROJQENdIq4nf4G50k/Ey26shXApgEeViCPtCb42ALQT3
   3FGMP+BHts/9jGog6Gzz6ibzhEyOQ+BYS4qZAGtDFbp1xpyvLYCS9/iS0
   sAaTIhu5+jFCBKp4sI0hosfGdJ8O2MdwHAuJH/BghmVS+wrNv5sxN9CZH
   hHRaP66dTrEF+OKE8omj0bXU/WB+TWhigl1KtHEc7DAka0l1HXL/BL9B2
   Q==;
X-CSE-ConnectionGUID: jYPz81mFRMGaHM6vgZNmEQ==
X-CSE-MsgGUID: NR9l74cDRKivDOfz9DVrNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="605675"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="605675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:48:22 -0700
X-CSE-ConnectionGUID: oGMjdDHFT261FXdSpsEUAg==
X-CSE-MsgGUID: JZ3zbRavQp6iPh/+m8NTmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1306099"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa003.jf.intel.com with ESMTP; 14 Oct 2026 00:48:18 -0700
Date: Wed, 14 Oct 2026 15:44:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/virt/tdx: Convert the handoff metadata
 reader
Message-ID: <as8y0dzw56mR/fB0@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-7-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094754.27702-7-chao.gao@intel.com>

On Mon, Oct 12, 2026 at 02:47:33AM -0700, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> Add a table that pairs each field ID with the 'struct
> tdx_sys_info_handoff' member that holds its value, and read all fields by
> walking that table.
> 
> AI was used under supervision to review code and workshop logs
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
