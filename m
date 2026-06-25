Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95A1DFDA1;
	Thu, 25 Jun 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367818; cv=none; b=kLsl4pNwzWqTrRV0AE6iZN+lTW9xZzAiWvCjs93JmBo7PIQzw11eJwpMJrlEPFRaVkfsbcSAMakmTBek4/ligCC4V1yKkhYHdlo3WDFZacxLGzcZEB6CioXavaQk6pxjxeuZgsA3ZIXFb/rkTxvaqOLLLETgRpN+vXF/dSpm+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367818; c=relaxed/simple;
	bh=hB/FcuHz0s9EES8XLvLXUEyUO8Ik6yMs/1MEEK5Tpsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNPDE7/xqiS/kwayCM5jOx9Pv/IZbUpEqTCI2M/eVVkptvLAmzaGHVBJRY7Jwdcc3x6kBaXxiNNC61Oh8YCtTfBa/6pyPQMF6TduPuCdx5+CF9rnaugDvi5vu68Y7AwaeTk9oU0arIfoPsgqpn5E7lgeBMqGV4/94l3ayo4wwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYdg6E21; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYdg6E21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367817; x=1813903817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hB/FcuHz0s9EES8XLvLXUEyUO8Ik6yMs/1MEEK5Tpsk=;
  b=FYdg6E21E2aHYnP00+8TeK7LtyJlMFYX8LPKj0kj4xe+oMXDpOl/v9Ij
   lSw4woYLzSowNQJFei0jSveUFAKI4/6QkGsFk/NEgkcIU2bFFZl1FzXp8
   +XecQY4eLablSy/GK7Ug+glfafv2eocMYteXmi6QfjK0fFM8hV4BpvKTs
   0NL6/FNpv03AXwp7jEw2P9hi7FWkbFdR1/2RY4rUpNH2jx5svu3P714QO
   LOCa1wg95pCMgSIAooXHMG0Pcpq3Uwcxt5iTWLz7yumg3sgTiq/JDv2/Y
   00ll4V7KoygGR9qakaCtJGNMkgtNJgeIcdISj8WkCxW6n9cCMlHrDOMyW
   A==;
X-CSE-ConnectionGUID: H7Ax/fk+Q3y94HpOZ7bncQ==
X-CSE-MsgGUID: zQFDhLy7R7qPBsm9S+F8ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="105931506"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="105931506"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:10:15 -0700
X-CSE-ConnectionGUID: u+Ngts+hSjCxvbFUtS89WA==
X-CSE-MsgGUID: 7GOn/IhGSF+DA8PP5Cdc4A==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:10:10 -0700
Date: Thu, 25 Jun 2026 09:10:05 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 10/17] x86/virt/tdx: Move tdx_tdr_pa() up in the file
Message-ID: <ajzGPQRDCXI7ZLf9@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-11-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-11-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:48PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Move tdx_tdr_pa() earlier in the file to prepare for upcoming changes
> that add a new Extension-SEAMCALL.
> 
> No functional change intended.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
