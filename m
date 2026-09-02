Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24C438029
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344241; cv=none; b=Mmx4TLJQyC+dAZSHzHWCVjYBnW4G7fsiv8AVgBvIBV3dStBgHkvkcf6HRwFNMtPAGVkitHQdY6oEK6OfNpagEdrGu/UmQwe75vEKPevxedjOOsqp7TjBIdKCOC/KM/mGxyVv9ZRAD/it38whvkbFMISE2BA8OygoTeb5Utc6tJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344241; c=relaxed/simple;
	bh=5xDoOGVEAfaCNOBWKYCtz8R6SkpZnyMAfT6Ty7MY+48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmX3aUbhnODk4mpP6HrZC6UybVF4rr94kec+yhyuGqzOMXw44AWTrYoI+yrMYZNzMFhOD7IuxS45zrPxC16ki8oMASEqx3Q6f+CZBFu0Zzvj+QhR4wpPx9thwNuBaXJayujixrzkMUGZNCU7rwLRaF4nJ1GRJN820NuGgjKkwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF8UKpsj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF8UKpsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788344240; x=1819880240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xDoOGVEAfaCNOBWKYCtz8R6SkpZnyMAfT6Ty7MY+48=;
  b=ZF8UKpsjjLAZAcZIWa1sOi2zst+NOpRPeFwnjcElbEemFxL6CeSz6SAb
   615EvjncQWsQTwP0stueBrzaQGGjjadtRBbF37qdeKwu6X46RzQ99r/IN
   zQLZnXn3IOR2WYIPrZM4KwndltKMd7/lc5HuMq70vekYH1V9uhquCGykg
   aUMAjtCLnUEX/6F4QY8U8Qj/kv0ZHUmNhe8PsxHQ7QpNSHkh8z3IBv+YK
   ZwglIA0/BIcDepzsePwgNH85Bho0k651Ega0QjcoNvwe3X3T9KOnV6cDs
   le5kmpOLOsV5Ox8MF7jpYgqBfymuYuxuUWNt5Vx02BoU/yjGzG1OCYaEx
   A==;
X-CSE-ConnectionGUID: gZfsXxwgRRqDEITcIAfD4A==
X-CSE-MsgGUID: +gw1zRyRRyikBzLIRyqH5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88826547"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88826547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:17:19 -0700
X-CSE-ConnectionGUID: otuvmiMjQhu5XFdjwpqQ1Q==
X-CSE-MsgGUID: pQ0p2WAvTOa0RO+eT7bOCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268827933"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2026 03:17:18 -0700
Date: Wed, 2 Sep 2026 18:17:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
	sohil.mehta@intel.com, xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 4/5] target/i386: Introduce SierraForest-v7 to enable LASS
Message-ID: <apf3rPqdNmhP88xe@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-5-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-5-kishen.maloor@intel.com>

On Tue, Aug 25, 2026 at 08:57:33PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:33 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 4/5] target/i386: Introduce SierraForest-v7 to enable LASS
> X-Mailer: git-send-email 2.47.1
> 
> Add SierraForest-v7 to expose Linear Address Space Separation (LASS)
> on the SierraForest CPU model.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

