Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262638331C;
	Thu, 21 May 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358307; cv=none; b=X7v5LQO8LeTTABAHo6D+1Y9pBvoP4SofFZcWAw19WosgMdLzvKd0rLmegMCD7Gn53x+MIzyP5Z5bw9KJfXma2QSqM9ePH9+KLy6+x6u9+KYtNgO60RZTK3Bwv3R/4hMwNLI1u8Z2HSQ6JGKHHu0gyup091nPED9wSoZdKmb9t7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358307; c=relaxed/simple;
	bh=OWGYQMGyEM6nrHvdPX1irYG/Seix5hjLIcg09LV1Yx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyBwm4uYGJujEkFh/1qTzz61xDvFWNZC2Lo69KSnUov69t02E47leTOrY5+h2VkRRlwErpQ0UTQYRL2/rZIZl/adyJeXS4bTuIDq+FcNvxn4Klbg9bzpykNCBYix4hLCdL/y2XnKo5/HizmzWQXt4lj1XybRUyITulyYM2PbOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2Jj5gLj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2Jj5gLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779358306; x=1810894306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OWGYQMGyEM6nrHvdPX1irYG/Seix5hjLIcg09LV1Yx8=;
  b=k2Jj5gLjs9Js997D2PlI7irPJ4vRLAdldD5NlL2U7YVHkxAtPeN645r2
   4vBBIFT4G5AgJOWdIheTQSrd14sW4N2ZhlSrxiCluUsRKEFxu2I9NTlVq
   PHXxHoodxQiM0JBpaPp/Tyhp4WTS8q3GKnHjogsisvpRW/ghhcGJ6f6Qq
   Jmjgq5j8ZiQXyT3kci+hlzTjxpSM4OPRdozhL3t6J90BDBVFPsJ898Saq
   2PhRurCrNuav4YMtmGfgQzkYPM15q4kBWaRqTvIfS3dZpeumNdSHXYAHR
   uoCJt7JjXvfcQc/3kUoEDvfm3t+6T67meSsQILxu5+20YXXuATfsok8J8
   g==;
X-CSE-ConnectionGUID: yfXJ+2mVSKC4l9WfjoXWbQ==
X-CSE-MsgGUID: g7novJr9SFuvBgr0Ll6S6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="82851907"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="82851907"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:11:45 -0700
X-CSE-ConnectionGUID: vvdP/pRWQRKQUOZgy/C4uQ==
X-CSE-MsgGUID: KY1RAFGsTnSdhfwkh2eofg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="244479359"
Received: from unknown (HELO [10.239.158.74]) ([10.239.158.74])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:11:36 -0700
Message-ID: <d56d0062-9b35-42ad-8a16-22aba99e1f6f@intel.com>
Date: Thu, 21 May 2026 18:11:33 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/25] x86/virt/tdx: Consolidate TDX global
 initialization states
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, yan.y.zhao@intel.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-4-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260520133909.409394-4-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/2026 9:38 PM, Chao Gao wrote:
> The kernel uses several global flags to guard one-time TDX initialization
> flows and prevent them from being repeated.
> 
> When the TDX module is updated, all of those states must be reset so that
> the module can be initialized again. Today those states are kept as
> separate global variables, which makes the reset path awkward and easy to
> miss when a new state is added.
> 
> Group the states into a single structure so they can be reset together, for
> example with memset(), and so a newly added state won't be missed.
> 
> Drop the __ro_after_init annotation from tdx_module_initialized because
> the other two states do not have it. And with TDX module update support,
> all the states need to be writable at runtime.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
