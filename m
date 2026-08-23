Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A072F8E98
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787474961; cv=none; b=IiwTrGJjg59D5AKlAzRJxAzWnTlJU9lo5gnFGb2NdNbn1YWTgL2BHZrHeMtLHV+CSLHJ753XU1GQjMd1rgatQdeg+0UzUn0atAHrz1FTO0SWPXvsQkI+dLAI5H27mXwrKdauY07uq4+/rNHW8wg4kjyp33QMEBN0wKhw7ncl60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787474961; c=relaxed/simple;
	bh=KqpTPPlexMgPtEc3la49a5XlMd291GyM/e41GB3+rBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox/5xyijV+OsOBDnbO9RNlwVTGunDx57y9x9tbfD09zRrftaXVyuKzHKqwBPVpYV73G0wudW/Md8kt8btyWaJS2cH1TimbgBskhqGu9vTv5v0/1GOV0bjBhjNz3LQ3TgXRDQHehA8BWiPamD3TWBmzgEKJIT66T+a22wD8WtyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkyZFj02; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkyZFj02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787474960; x=1819010960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KqpTPPlexMgPtEc3la49a5XlMd291GyM/e41GB3+rBI=;
  b=ZkyZFj02gSUQy9rUGrpZaS352r1NF2giUUaAhkWlfzyutRXq8ikokMIW
   Pyubii0t2gA44rdqpUHVtpNcBFKlZy44+LJG3pILn9oi9GppDikxvDR4l
   QD2Zkj7srcYCqzxdIcyr42u60D0bVPIVZ+frfxeBlbUU2bvZDGVnKmHjz
   ZP1ydEcNWEIxehjqmXgcqCovWOb+WUTmrC1TZz17UHASVppvdAXvXqa/k
   nWiIbd3vVDS/M5SrmGT9IXPN8e2PXxfnYvkoScgFd2Z7+AxgzXRhORMoH
   RStR76nK8MpkKmlDgFySnsHbmh4CPnZTp3RUq+t9wLoSJo1LYApPeHZPT
   w==;
X-CSE-ConnectionGUID: o0Aa9YS5RQWngi0Fw0SpDQ==
X-CSE-MsgGUID: zSykGi5vSXCQVTbsLERKWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="75493249"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="75493249"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:49:19 -0700
X-CSE-ConnectionGUID: G+pePID9SfWtrdOLbC2Zxg==
X-CSE-MsgGUID: C7LzF7nRTdO/SnzMNd3avw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="271945344"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2026 01:49:17 -0700
Date: Sun, 23 Aug 2026 16:49:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 2/9] target/i386: Hide Intel cache CPUID leaves for
 Hygon
Message-ID: <aoq0DKEJTYmfUlAe@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-3-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-3-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:49PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:49 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 2/9] target/i386: Hide Intel cache CPUID leaves for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
> and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
> information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
> currently skips that filtering and can expose Intel cache leaves together
> with AMD/Hygon extended cache leaves.
> 
> That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
> information through the extended cache leaves, so it should not also
> advertise the Intel cache descriptor and deterministic cache parameter
> leaves.
> 
> Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when the vendor
> CPU ABI compat gate is enabled.  The gate keeps the old CPUID output for
> pc-11.0 and older machine types.

nit: pc-11.1?

Thanks,
Zhao
