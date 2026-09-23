Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9249BD68;
	Wed, 23 Sep 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161468; cv=none; b=ayQekLCw+HRxl3CS8cgj7EQKqpmt0+/sFxZIEzyT4hn/JNaiqJq+g8o+ZkNk4xECMMy7EM+iWxwk+ZQHJzVh6awKL8M9P1XLJ9zxrQZTv2G61iNznwRylldQPmdUW2niiQEfl9ueVWBNZJ9Ulg35LgCoj9JPb1U+iG9FmTBMIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161468; c=relaxed/simple;
	bh=zGjMIFygYqqz687r0Dm5FHB9zulLKHdqaxokHtzat/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXOY38cotmwqreY0w8/ghmdwjKVwJfzI2+/URhOBBw94+Ee1Efl0meNGU28s5+SbkmKaDSgnXuMXKk+O1v7j+iSijJiDTjASzz5bKj123uUOMqqlJhkm0xUY3RzlZ/YcPUQxUwWxsc+tnybTAMM/P5uuFSKXHMEe2DxWBd4qm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghzlVDic; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghzlVDic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790161464; x=1821697464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGjMIFygYqqz687r0Dm5FHB9zulLKHdqaxokHtzat/0=;
  b=ghzlVDic6G5jPO39akH+3R5j7n46uaFUZMM8/WHyFy94MxbB11XlZT3w
   HEaJAfeGfQ325/E+IdRfUPi11WSlPkNT/4dgZQvLIWTcAMmq1JPV2O8Va
   Ym/PUrOJ5hpEINLPEf9h9+Evh50RR9yes9rXG3/WR7TTMRHKyGaBlh39h
   coI5myozv8it2WniHd+uHwFtdyBahrLuCQAXY0CS6q8U6n+1x6sXtD0IL
   ZBukH/rNi/RX0T3TKW/w5oelQLgy7CtV3mUMq/53m+wTPNaO4hS4PA2a2
   reoxTNixsyFagzXozGC254sz8uTZO9eR8Xisfup3KBP5Zjk5Vr4fru2je
   g==;
X-CSE-ConnectionGUID: 1QONjn5VSvmIYvQjstq08w==
X-CSE-MsgGUID: Rcwv5mziQMS4yBW2rSj02Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78398399"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78398399"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 04:04:19 -0700
X-CSE-ConnectionGUID: TVU7IVoTRMahSqgIQUYcpQ==
X-CSE-MsgGUID: IXCmbDfGQim3ZgcvijNH+w==
X-ExtLoop1: 1
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2026 04:04:17 -0700
Date: Wed, 23 Sep 2026 19:04:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v7 00/20] KVM: x86: Enable APX for guests
Message-ID: <arOyMJmOZVRp7Byr@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>

On Wed, Sep 02, 2026 at 02:17:44AM +0000, Chang S. Bae wrote:
> Date: Wed,  2 Sep 2026 02:17:44 +0000
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
> Subject: [PATCH v7 00/20] KVM: x86: Enable APX for guests
> X-Mailer: git-send-email 2.53.0
> 
> Dear KVM maintainers,
> 
> This respin is primarily a rebase onto v7.3, with the following minor
> changes:
> 
>  * Patch 8: Adjust the core API usage from static_cpu_has() to
>    cpu_feature_enabled().
>  * Patch 2: Fix an unintended code comment change that was previously
>    leaked to next patch.
> 
> Please let me know if there are any remaining issues that should be
> addressed. I'm trying to figure out the next steps for the series.
> 
> Otherwise, I would appreciate your consideration for picking up this.

Hi Chang,

I tested this series with QEMU master, and no regression was found.

my tests include:

1) Check APX enumeration & XSTATE in L1 & L2 VM.
2) (with AI help) Collect instruction test cases from LLVM/GCC and
   create some new, then test them in L1 & L2 VM.
3) Expand the selftest to cover additional KVM instruction-emulator
   cases.

All tests are passed at my side, so,

Tested-by: Zhao Liu <zhao1.liu@intel.com>

