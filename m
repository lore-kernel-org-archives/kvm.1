Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082D233134
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787476724; cv=none; b=ed2rCkbjZPPrE+YvT5a0lqzuIIcc2aC9HymFzLhz5IFz2BJTSZC3OjJ2eYdNYsiANLo1pUL04oVAggVViZlHTyXDG7tUjlWWY24bg7O8/Pc6IDlW52+6swUBvyG9DyhLMiHiTuWK/7koIeaBEhqMcSVV2qWcllfk24bDCBE9OeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787476724; c=relaxed/simple;
	bh=6PT7rVuergyvwcyknrw1osn6+HOn5S0E1P3dvLxa5h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AunueWhB+nUOqk82QLf47o/pEkwmvmmObVP9duurLRB/hvcCRCONFlTn8p9araCx7qLRqQWHh5Z7eDVJqfRfQRnY21V4igDk2rFJRya9w6fOUcuc5ZBAVe1Xe8lZwn0u8clNkc8V94zMPdnG8aksKN5BK7xl62P6yKc+kIdtPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/uxrDiW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/uxrDiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787476723; x=1819012723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6PT7rVuergyvwcyknrw1osn6+HOn5S0E1P3dvLxa5h0=;
  b=L/uxrDiWDqJpPHLOtHdwvhbpLQDzBmy7cV2gUpF86FYVvDOdCcTmd0UC
   bY3dfyZiT+FfTMbHbgHIn/SaGMZosG2aAp0FpbogJup1SKWOLMfyj6rWN
   muA0KmGeop0eaikASl/EUICLtAuY0FpM6GHsV24STdOIpt+fmVWVkjVSp
   cjG8setlah3E9D3VspACoaqqBXGW1ybDDbnfHhdZCDRrDDXacCW9RMDKW
   qirbkYcT7+YRxcC66lhZyl6OcaT4bu/S8rZ3VyWufNkuzaT4jpuDsuoVc
   +8eA0MA8MmWJ1PysUB/LSBFB7pvM1IMuQ1OfytaxPfURQU/R4njaxTl5c
   Q==;
X-CSE-ConnectionGUID: U+8IWlcAQiW8/edUeZNEQw==
X-CSE-MsgGUID: MuT2sENkQXyKm/JXnyT+Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="99309101"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="99309101"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 02:18:42 -0700
X-CSE-ConnectionGUID: FDGporQuThWjmzNAJScqmw==
X-CSE-MsgGUID: pT3IMHInR4m+vAAJQnqRMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="271949254"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2026 02:18:40 -0700
Date: Sun, 23 Aug 2026 17:18:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 8/9] target/i386: Use AMD legacy cache fallback for
 Hygon
Message-ID: <aoq68Lm82kTfEWYN@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-9-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-9-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:55PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:55 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 8/9] target/i386: Use AMD legacy cache fallback for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> When legacy-cache=on, x86_cpu_realizefn() builds a hardcoded cache
> model.  It selected the AMD legacy cache table only for CPUs with the
> AuthenticAMD vendor ID.  Dhyana uses the HygonGenuine vendor ID, so this
> explicit compatibility path fell back to QEMU's old Intel legacy cache
> table.
> 
> The wrong table is visible through AMD extended cache leaves.  With the
> Intel legacy table, Dhyana reports 32 KiB, 8-way L1 caches in CPUID
> 0x80000005 and a 4 MiB, 16-way L2 cache in CPUID 0x80000006.  Linux
> uses the AMD/Hygon cache enumeration path for Hygon and reads these AMD
> extended cache leaves.
> 
> Use the AMD legacy cache table for Hygon in this fallback path when the
> new vendor CPU ABI is enabled.  Keep the old fallback for pc-11.0 and

nit: pc-11.1.

> older machine types through x-hygon-vendor-abi-fixes=false.

Thanks,
Zhao

