Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818313BED27;
	Thu, 25 Jun 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368003; cv=none; b=o6MZbYfMaOqFx/EQ0YpqcRMilGC5y4T55YTX0myzL1ltxJKOWOka319W6G+tNGL8H/eJ1Dh/Md/FVqGPzWJdxROLh8+IfS4hYuljIIWn3g65dk8yPL7F9Shmmmt2gwk7pB2ijRfx/YUVe+8pivCsOewWyJJcSuM0ZFNs8U1KAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368003; c=relaxed/simple;
	bh=uN4JWVvMXjSUp1Zb6TgpIalKMXaadyJR/LLKxhiu47A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JugXN9tLEFny1rBCDqXYFJlK6DKE9O1H1zIStv6AQdqQ2/ng8dsot/yKJc6fkmlxPjbOad1TcZRHpTHZA8fYI+kFnFy+GdxZesAD/V6C7iL8qXOxi3FTRwMjPkSmkK4eVYV6aMN6pc/3DJQrIqVnSjThO9t7BHSCZOcEJpf56CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V63xZUPI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V63xZUPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368001; x=1813904001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uN4JWVvMXjSUp1Zb6TgpIalKMXaadyJR/LLKxhiu47A=;
  b=V63xZUPIRqImVTskiQkhI5Br4/lKTITftwEHGlwf+m7ZyYHkE1PvSnEr
   Pdwb4LIRomNEF0Lua3wEuu8gL4pzq7Ee9lU7YnOtk7yilDTI2VbvtMzM6
   gq3ryJ/6GimjI8/yQqJJSick0OdRABnlPSAiDWKztGmW6mzJyDXPtyCrK
   9rgGwM7+kFu82fkLtNIVOxoNwSQRnn2Hqrg3B7l8WpcSnbTVdgOGOZhxq
   KHfmgSAl3CmM6ietHOjHbWmkhq9CMl9AXF3pA/8nlMV/TvvctQncwKzNo
   qRExyxvF0ID8DZ0/VpNpK8Sgjd0SxKILbrl6bscfMajdh3VxKW0yNT8nE
   A==;
X-CSE-ConnectionGUID: Taiw6Jd9ThyRLApPtEjIFQ==
X-CSE-MsgGUID: ov+5cGdUR3aQcCHvLnUspw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93792452"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="93792452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:13:21 -0700
X-CSE-ConnectionGUID: IrLwM2TpQP2U8tc3iQ3MlA==
X-CSE-MsgGUID: 8rrGNQlZSmyD0U+2FntUKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="249017862"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:13:15 -0700
Date: Thu, 25 Jun 2026 09:13:12 +0300
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
Subject: Re: [PATCH v2 13/17] x86/virt/tdx: Enable Quoting extension
Message-ID: <ajzG-KB0LoJJtGKR@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-14-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-14-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:51PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> The Quoting extension generates TDX attestation Quotes in the TDX
> module, without using a discrete Quoting engine. Enable this feature by
> requesting it in TDH.SYS.CONFIG and TDH.SYS.UPDATE.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
