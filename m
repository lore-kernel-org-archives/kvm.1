Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7640E8C7
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012481; cv=none; b=t8Pph4mbracsYSKuIqIp58B2gCsrogXVx4ai/P9TPbvnrubE2Oojr0+IMFZ/8XWN4qsaAX9vHy7U9vUCyQUnQ1IRSMWOTJL3bQylCgpCShfb9VNvJAYFD1ws1sQTdGvoI4ZrxpSycJIw+BFV42wxnTtDuvCZOSgMka5SEHvgefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012481; c=relaxed/simple;
	bh=0/cb6X+3/7WDEPBMpZS9PoJb9fPynqblASk+IpgSwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvphQ+Vx5liO9VmwnrW6x2VQgWXgH8+TqfWHUsmvHgq71nNLhwoCYHxtg40m1XkuIf+8AM4Ju/J7Wbc984hKXsAnOFWDoKwyXCqmZnFBYueWuZ3lbPXQEcs7n6dlEA0fJkTZxCSXsbt4OyDoM2Xa+fOQGWMHjX8gOtt/qIMR8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VERxQwgl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VERxQwgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781012480; x=1812548480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/cb6X+3/7WDEPBMpZS9PoJb9fPynqblASk+IpgSwBA=;
  b=VERxQwglE0Irk5iK7DxJLbTxwCei2KxJLPqny/0xxRwFy8+M/phvM04c
   n1h9wxCFLFhL0XirphSpw7tZQSi0+ERg3/EDqOPiVhiVnqVTMFsd6sR5P
   Buco4x65Zswe6Zj+ugkSyhDKldjXk+xW0dIo2D6wPE3viTMU91HuTWQW/
   Eb/umUUI32du1eKt1jbGX1VmmA8ZVExLMEJHIt3Pa/Q+/su/0OQawjfKM
   rxO+bbegGzuld5A2kSuW0ktutyOTP0FB1pMP/oWdX/12cmbRoLjjHjHtT
   kNEUBJOM5PskCUhjqlN/0PLcZufaFcvLCRV5++J5+89D8d+HF+Vrp1Vjr
   A==;
X-CSE-ConnectionGUID: g/lKtTSkS42nG4zNVrXu9w==
X-CSE-MsgGUID: 2AY+DVf5S82qqXqMdlHHgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="69305659"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="69305659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:41:19 -0700
X-CSE-ConnectionGUID: dI1afqVvRE2u2hWhsADygg==
X-CSE-MsgGUID: 3S6CJqNqTUKf+M/aa9Mvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="239527819"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by fmviesa009.fm.intel.com with ESMTP; 09 Jun 2026 06:41:16 -0700
Date: Tue, 9 Jun 2026 22:09:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
	mtosatti@redhat.com, dapeng1.mi@linux.intel.com,
	sandipan.das@amd.com, zide.chen@intel.com, joe.jin@oracle.com,
	qemu-stable@nongnu.org
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
Message-ID: <aigek5eqJr6DHZau@intel.com>
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325021236.14574-1-dongli.zhang@oracle.com>

Cc: qemu-stable@nongnu.org

On Tue, Mar 24, 2026 at 07:12:36PM -0700, Dongli Zhang wrote:
> Date: Tue, 24 Mar 2026 19:12:36 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU
>  getter
> X-Mailer: git-send-email 2.43.5
> 
> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
> behaves the same way when PerfCore is unavailable.
> 
> However, once PerfCore is present, AMD PMU switches to an interleaved
> layout in which selector and counter MSRs share a single alternating range.
> 
> MSR_F15H_PERF_CTL0 = 0xc0010200
> MSR_F15H_PERF_CTR0 = 0xc0010201
> ... ...
> ... ...
> MSR_F15H_PERF_CTL5 = 0xc001020a
> MSR_F15H_PERF_CTR5 = 0xc001020b
> 
> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
> addresses for selectors and counters. env->msr_gp_counters[] holds the raw
> counts and env->msr_gp_evtsel[] holds the selectors, so with the
> interleaved layout we must translate the MSR address back to the logical
> counter index instead of treating the interleaved slot as the array index.
> 
> The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
> the end. And in the reset path QEMU simply zeroes everything, so that use
> case still works.
> 
> However, the live migration is broken. The PMU state is stored at the
> wrong indices, so the destination VM reloads mismatched selector/counter
> pairs. Fix the getter to use the logical counter index rather than the raw
> interleaved offset.
> 
> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  target/i386/kvm/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sorry for late response, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


