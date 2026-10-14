Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FC492E49;
	Wed, 14 Oct 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964052; cv=none; b=gkWMfstAto89goPCgnaQ4LETTPuepVTwqFHRyYrkyU7usz+hj7rTML+/q9+9Ja41PRHQHtfBUOnwKg1maM0TOype7OhVi5NDf84Ye4UxgHdKG5zPiCcodHys09AtRcpbqr0N9/66ldLltlAN8gwEK3XIg8L7NRcdwXkg5+qiCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964052; c=relaxed/simple;
	bh=EYXS/kL2y7GBY/MlH56LZFQvQgGLkP/AbqS+BI6ikVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNWtkxzyneTiMQAHcvD0/KqwDxYDmFHfFLG2oHzyj3U8CpQJa88/FFJr+4tYW9zudfvz4d1q5csHr1PO3kqEj3svYkqtCIkaHUkqY2XNKKspWE+E2Id4iSb+Rh3ThbhQ3d2UlfDz94cFo2AltYclOdRslSKLvKib2PIn2GmBNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVaVwno4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVaVwno4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791964050; x=1823500050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYXS/kL2y7GBY/MlH56LZFQvQgGLkP/AbqS+BI6ikVo=;
  b=nVaVwno4O8Gk28UT0Eyds29NvyWhyARBP10HL3mhTluN2Q2Oxzh50Frh
   LEiIMyWCOxwMd6kJE++Ibe5wIukEjGaFNqkHhbb/F5n/RgnVuFYb/ChNy
   U0sQ1KJMtM4cEtGfbLM6bMbpYbdRu1DMxkBKMdil+YT6x2L46yJLF9QyX
   NiGccdB9ulLotHpTCzhizZ6myjI/S5OEhycXR/8epPl+88y+aYBitD1FA
   IWVCEhrxzjg1JaCiQXxtIRAAE1R7RkpLhpJffvvRi/zcQ7PdyKb0+DeYo
   iuVeO3u8f4fqRALMTdBhAQWpWq6ZgVCknZzg5fV8WmvzIyZVaOWdYcS7J
   A==;
X-CSE-ConnectionGUID: +VNr3iO9RhWiseUHTvGyBQ==
X-CSE-MsgGUID: YSjP4PRCRzSGLsCk/RSaCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="705350"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="705350"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:47:30 -0700
X-CSE-ConnectionGUID: 7rM1GZrDQWmla3VkqQ3gqw==
X-CSE-MsgGUID: tBGmNA1ITwm6otok0XwTFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1715751"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2026 00:47:27 -0700
Date: Wed, 14 Oct 2026 15:43:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 05/10] x86/virt/tdx: Convert the td_ctrl metadata
 reader
Message-ID: <as8ynUj4icWsvZEF@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-6-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094754.27702-6-chao.gao@intel.com>

On Mon, Oct 12, 2026 at 02:47:32AM -0700, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> Add a table that pairs each field ID with the 'struct
> tdx_sys_info_td_ctrl' member that holds its value, and read all fields by
> walking that table.
> 
> Annotate the table as __initconst as it is referenced only during init.
> 
> AI was used under supervision to review code and workshop logs
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
