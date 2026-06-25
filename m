Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E61624D5;
	Thu, 25 Jun 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367536; cv=none; b=rb6urCbgWapmGdPqylR1JYstS1WpNMehojseSXZ9qkrBFigNcBMNBKko/fk60hgD/6txR8qmk0yZGLHRVedbqJiDbqeSgBJ4g8/XtA7flzLO7wRAucIw8atLYp7tk3TxzF5Z5zaqDOZZXLbEUwKIeBsjEsxCr99Sxu49PJLbYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367536; c=relaxed/simple;
	bh=Q/90ChCIfNk5vxW9mzTK44NeY6YWv7qicgUT4Fhl1RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9eFmIvUvu9Wt0KRPV9IhnQB2WApANzMPXAPCL9nbUiC+QQyYthv+hNS0S5lTcpWcLgq36jcwcDr4n/j1w5pKX43Ut14oh8m33GiasEn6nr/VFoUweUdvDdx2xpkm2rYz9fbC2NstZ8VQ5uecO2I3gKDUMoVEi6WlGS+zWtBXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNDfOuJm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNDfOuJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367536; x=1813903536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/90ChCIfNk5vxW9mzTK44NeY6YWv7qicgUT4Fhl1RE=;
  b=cNDfOuJm7BqrYwO42YGhY/HxgG4CdnL4jAKDHGyEtnM/uk1Fpau2Lg9j
   2dayLUMyHuLeSK+0nod5vuanpbsoapf08+Mz9L3P9EMIo+bfJf2Qbflwp
   asujB0mWiVNlTO7pFZnOWT5c4wKMRwZDC+fMBJNvEcxqLn5YOuWJSAeDt
   KoO2E8DM2JWg+iSTn6wl/XIaJZYj26RhM9z8ZyATajHRVQkoexHNNIDT5
   OhDJwTjoYo23AD83Z7mUa8hLs8M/xM1xJr3M2o+MSMuIhPehjmJMzNC4y
   I0OGsTaLBxYU7VxLzTb97fgYEoSt+Yr8fcgq5Xrr4hPeigw86QR0H53hE
   g==;
X-CSE-ConnectionGUID: /I4jKnqYTWSjJeGnwfutmw==
X-CSE-MsgGUID: pJCmVmDTTbGqTQTYaXN/mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100565095"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="100565095"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:05:36 -0700
X-CSE-ConnectionGUID: 4N/0SCMHTj6NgGUfkHBHgg==
X-CSE-MsgGUID: i2GrOEpzSiCzX15HIVpXmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="249380047"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:05:31 -0700
Date: Thu, 25 Jun 2026 09:05:28 +0300
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
Subject: Re: [PATCH v2 11/17] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <ajzFKBZWpbwefE03@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-12-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-12-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:49PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
...
> +void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
> +			 u32 *quote_len)
> +{
> +	struct tdx_quote_data *qdata = &tdx_quote;
> +	void *quote_dup = NULL;
> +	u64 r, out_len;
> +
> +	if (!tdx_quote_enabled())
> +		return NULL;
> +
> +	mutex_lock(&tdx_quote_lock);

How about make the pre-generated static tdx_quote a template page that only
gets read and copied to an allocated bufer here?

If the tdx_quote template is only read for copying here, seems you're not
going to need the mutex at all? That is assuming tdx_quote template does
not change after init.
