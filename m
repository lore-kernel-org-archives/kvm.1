Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC93C09E1;
	Thu, 25 Jun 2026 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368189; cv=none; b=eZ6kWQv0yxmGNLdwNC6VGuq+3zFS8niAVZ9+hoGjzBxeYyTCFoM2uMEQf5chD/T+/oh5q/DhFfsB9DvD8bMyJsn8NN117qNOG/e0eTvwMVknhi0/iX2cPHP6vYdcT/ZTU1VjDKULkrWrNrkui/VlSUaxYbNZ5vD75U4aqSA2FRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368189; c=relaxed/simple;
	bh=tKZ6xRo1kL3QcP279+SWAD751M0HETdyoU7bb9QFcDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/6t2wMGl3nNv6WDBbetEW0Kchn2Q8rKIDG2nX0TnAt+yULT4E5AZjA8VhLle6vfBMCVg26IWkG04tLeUYghZo0vFwrLX45O7IeCvPIzedCFWSP66sqp7J33/D8Yk0tZ/PHaNGS8Qzmw6vvhn09edU9lYXNuGz/x8eJKPbCmZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkfT0nQ8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkfT0nQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368188; x=1813904188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKZ6xRo1kL3QcP279+SWAD751M0HETdyoU7bb9QFcDY=;
  b=LkfT0nQ8KAUld6MUgUUyAEwkFox4ynyzrulAHKKO3KIbUS+sY5rkRSYL
   J0dSdhSKiM4BT2w+XlGl3eUEMWqBCQkbMJgIeDTNtGxtO2ehH2EhkgJRS
   AurHNw4+cr0CnREnUCcQrbnr64JcoSFqrW6cHJyCVCiBjh5pHXlA4RtFc
   Jc59OAK/Pu8SNtxe0fCdiHXEOI29KpYgRUcii11q12BAYbpDP9I+jr7UN
   +NSyE4bTs2cZyCy4rRGAiSiePeWO4k7a4qSFgG3qs5O/V27BBIHqKuW5T
   lWllJJYD2Qm3/cfEmSbdyVmtyUOX9SHDIOc8cjzO5s/L4aiX1eWyT16w4
   Q==;
X-CSE-ConnectionGUID: 7FWRR9EjT8W3sd/aELHQzg==
X-CSE-MsgGUID: tg4hFBWLR42Fsg4J8Lo/pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94630691"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="94630691"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:16:28 -0700
X-CSE-ConnectionGUID: Hs9EeI9gSTyjJ7zL2+uncQ==
X-CSE-MsgGUID: Pz6mt3TpTN2w6J7mU1+/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="249385355"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:16:24 -0700
Date: Thu, 25 Jun 2026 09:16:21 +0300
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
Subject: Re: [PATCH v2 15/17] KVM: TDX: Factor out userspace return path from
 tdx_get_quote()
Message-ID: <ajzHtUmxGV4Gz6kN@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-16-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-16-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:53PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Separate the logic that returns the GetQuote TDVMCALL exit to userspace
> so that tdx_get_quote() can be extended to support in-kernel Quote
> generation.
> 
> No functional change intended.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
