Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79824B28
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549945; cv=none; b=KVj1KdK/fTDXbGMtNX3Wt8fMp6KI+WMoDQ1DcUJTWllh8rj7DRcNkMDrtWCkEduyBPDm5g5UAdAkdEq98feQ1uxqIUCzBQwapQln5pHvRteUqo4/NZdGJDRz4M1QqvAt2JzMbh/EZlbk9lzubaIefVMhLUQvujgS7nLkkP4AwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549945; c=relaxed/simple;
	bh=0Bsfa3a2i4uHH9RVZ07JPgXdXR2aVjd8JE0KUFLgrrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYJDXCh2yLlq3vW97c1bWD75EfWLRmieP9FqiVBiMEnzIZ6KnFVMwP1lKhmNHUfU2POyr77lzT9PvA546aDxKZ/HiNN+l5I9IqOgZA5VYGCiKswIk6nRAQrBKaYdtDBp+E3X2Ev+HM9avVOPSQv2DHWfjSzzsrJQAhwrLmHdnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnm87Edj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnm87Edj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787549944; x=1819085944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Bsfa3a2i4uHH9RVZ07JPgXdXR2aVjd8JE0KUFLgrrg=;
  b=cnm87EdjjmzzZZphi8T+94kQ6dgw7EvjvZHkVix02Ye5K9Bepl00Z4Xn
   MUePVhN8L+AAsukAri37DX2BtzcGC3Dz0W6vow8fHLYXQF+xlvqhWNkF/
   Xaetfp7f7a7tweFwuNXuxwYlc2LvNcsJICjGmF4EWnWIcSeJwKqpeU4Yg
   nVGhC53VIsXS9kbaDbvbAu0osvJm/yxLnwwLN/y5y+KBrFixORDVMCMtY
   se3FnyD8gML/2W/a9VPRhXJNwXOLO6r/xNbS0vaiyrZD6d1i9HqRuViOz
   mCeHnw6XLquadK1s4BoyC3G3DK37LJRweBYlh1nucMngwsN4jZ5vAgcx+
   A==;
X-CSE-ConnectionGUID: VByVMg4PQBieijTsgzk4VA==
X-CSE-MsgGUID: bjfphAgcRMel6CwQE7gqlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91667740"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91667740"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:39:02 -0700
X-CSE-ConnectionGUID: /IxB/yekRSCZz7oMUwbGDg==
X-CSE-MsgGUID: cxQixFWGQ0S44HasKyWaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="290429884"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa002.fm.intel.com with ESMTP; 23 Aug 2026 22:38:59 -0700
Date: Mon, 24 Aug 2026 13:38:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v3 05/10] target/i386/kvm: Classify PMU vendor families
Message-ID: <aovY88W/XD0fQeTH@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-6-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-6-zhang_wei@open-hieco.net>

On Mon, Aug 24, 2026 at 12:53:09PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:09 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 05/10] target/i386/kvm: Classify PMU vendor families
> X-Mailer: git-send-email 2.43.7
> 
> The Intel and Zhaoxin PMU architectures are compatible, while AMD uses
> a separate PMU CPUID/MSR layout.  KVM's PMU initialization, host/guest
> compatibility, and MSR save/restore paths open-code these vendor checks
> in several places.
> 
> Introduce X86PMUVendor and helpers that classify the existing CPU and
> host vendors by PMU architecture.  Use the classification consistently
> for the compatibility check, PMU initialization, and PMU MSR paths.
> 
> This is a refactoring with no functional change.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 72 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

