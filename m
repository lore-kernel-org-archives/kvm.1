Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52369361647
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850792; cv=none; b=WmgsDn0LyBuWKRjH6RlzVR9YJv1/jJAbtlADCYQwQnT7w2QRyaIKrLjJPeXzxN80mNkaI/Bz1RSr2gnMVbpWH65ECAvIySbXkLPk0kUWoRkacXITAabBB8D3ENiAKv7EAQOyFu5oiD4HLI0xIvFfakZz7q3WnjsJ8cXtivz9J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850792; c=relaxed/simple;
	bh=7Dmeclr4hWpb5oIW709HVPR9P1oYHCoekKlfeETO7nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0YClhsQ1DYjpDDy71J975r8BRXGpllIbwHdj2l/M/NMvlBulV8QZhIR2AeVkBp/vlDQQqXAzNWaIdMdMwia8XY/pxOZc98ykoN6B8pIbSOUW59BRJiH0jHt9xGGdEXBDh+PFP698yaxaLL6lgUmyYS5Z0YwgTWlXFAZzDU8MWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7J1KSgt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7J1KSgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776850792; x=1808386792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Dmeclr4hWpb5oIW709HVPR9P1oYHCoekKlfeETO7nc=;
  b=M7J1KSgteJv6sMRO+dUU+Tm5HQ0Z+VnlwCPh923F2ymDo6r50Nh3+BeV
   ynps6k5YKQISkeww+z4X6HtSmf6gydw9WxvV8k3aWvaYXz62/gPKpWGUC
   oropV9b+7BibXQ2kBD9M9zqWaMsYGwmgsH1Psv2FXM03fWQBX0Bcn9qYX
   ZrIucXDqDmgrA5yobCab5dW2+r5sqV19eq6SkjFBtXlWfw3adSn31trdQ
   xibG+7BhrJxtIdDNnO6c77y+H4r3eLXHhNFIUObIkBUY80ckt2XkBvfQo
   0BjomNAYJsajGRfU5osqA/CyWCw3AXwmT1vS2SoxcsjRnfVC+4NiuUT9W
   A==;
X-CSE-ConnectionGUID: MgLZ0JN/RHC4h4+MbZH1+Q==
X-CSE-MsgGUID: 4/NZLJtvQQyzTrq2RgvTJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77503923"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77503923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:39:51 -0700
X-CSE-ConnectionGUID: X2fcTX03Rtq5mBwfFjHXCg==
X-CSE-MsgGUID: jmXs1IjLQgW9Z0pxJGBqtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236306754"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by orviesa003.jf.intel.com with ESMTP; 22 Apr 2026 02:39:49 -0700
Date: Wed, 22 Apr 2026 18:07:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Sandipan Das <sandipan.das@amd.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
Message-ID: <aeid0QluufANcH59@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-2-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304180713.360471-2-zide.chen@intel.com>

On Wed, Mar 04, 2026 at 10:07:00AM -0800, Zide Chen wrote:
> Date: Wed, 4 Mar 2026 10:07:00 -0800
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
> X-Mailer: git-send-email 2.53.0
> 
> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
> (bit 11), is deprecated and has been superseded by LBR and Intel PT.

I'm not clear from which platform this bit will be set by default?

> KVM yields control of this bit to userspace since KVM commit
> 9fc222967a39 ("KVM: x86: Give host userspace full control of
> MSR_IA32_MISC_ENABLES").

If KVM won't support it, it's better to only configure for KVM.

> However, QEMU does not set this bit, which allows guests to write the
> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
> this may lead to unexpected MSR access errors.

But overall, this way is a bit user-unfriendly. For cases where CPUID
is unavailable, it would be more proper to check the KVM API to
determine whether support is available; making this change in userspace
feels a bit like applying the special patch for a corner case.

I found there's another patch where Paolo and Sean didn't want to make
such changes directly earlier on....
https://lore.kernel.org/qemu-devel/20220718032206.34488-1-zhenzhong.duan@intel.com/

Thanks,
Zhao

