Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D8440A2B;
	Thu, 27 Aug 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832142; cv=none; b=EMbM6lisw2s8/I1LMf0Q45f/bhBXEuADmi6WKgPW4u+4ZzLZdNrO5YRcYHA+izTPV3AM5SnwhPji3tQNCm5JqMx7BV8CgeWGbcOAAzFb7MsZWiXKDV0jmj7bDrrzD3xYqj1KtF/5CymQ+BwdOjR3ezKVKSJPLqv7lHXRslbeWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832142; c=relaxed/simple;
	bh=be5ermLBcn/MMm/K8MsiEZi1P1Uh3O3KEB+S1F4rOVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbg9acYrL0cWp4EIk+9PWmzvktBPGqaBhxwErsyjDvJqLDTztSXhlbwgN7mD9yqgfzan4YoVZg0sIYRffbRuOv/TlmbQsnWwhXkOHypbbgBfM4z6clGQyb/KNqw6GiTdsc/b4pTICPKySXhI47afWoEk5sx8/+u0sIvxpthx4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSoXdZ7+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSoXdZ7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787832141; x=1819368141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=be5ermLBcn/MMm/K8MsiEZi1P1Uh3O3KEB+S1F4rOVo=;
  b=BSoXdZ7+n26WDEOZruoAV1JG9S9ZofqjpSrARAsbAU2DwPaBRvePlV6+
   WJ5+Y/Hu33kyFEYgNTcSly1reXOxqMkjiKH5CNNWTzjKwnf6gCIuXrXCn
   JoNVZ3M9nCriWl5LBadcVv/wTOuVkAEOJzlpHu5H48UwtOasH4VlX0JG9
   FgoJl+pU5dReTeksf6vwwEImJieJ4gfvblxOar0PGrUI4sAWxYzg24sdJ
   ydwKvJGyUxiNbvAu+6hYWOVDXlrMounifJI9BasusihJdVVWBWk5n0QYn
   vzZIQbTvHLbHsol6IeW0DCokNGBJUPdPVDwOdRn1X2vo+XiuY8atZ2MQx
   w==;
X-CSE-ConnectionGUID: 3bGrAYQ+TdSfkspj8Be1jA==
X-CSE-MsgGUID: RubjCxPRTCiheQu5/OZ2zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88382769"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88382769"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:02:20 -0700
X-CSE-ConnectionGUID: snHaFrKURi+w/a6fInEjjg==
X-CSE-MsgGUID: l9XAuIWsQuKfVul8TESBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="269802601"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:02:17 -0700
Message-ID: <2aabf3e0-1eed-4f7e-984f-19f427856ad8@intel.com>
Date: Thu, 27 Aug 2026 20:02:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] KVM: VMX: Move common VT getters/converters to
 common.h
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-8-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Move the "to" vCPU converters and common exit information getters from
> vmx.h to common.h to capture that they are indeed common VT code.  Defer
> renaming their prefixes to isolate the code movement from the massive
> churn that will result from said renaming.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
