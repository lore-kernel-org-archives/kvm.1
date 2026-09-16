Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B42364942;
	Wed, 16 Sep 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594392; cv=none; b=NTDS/0ognxRlFrb8NXUg/i/adkLFEvQNvgFlk0+MzSzMvvGDZPYYwKMuZvYnxfAFolGVounGZ9EBLYQK8dlyZlK/LlL7M2DDKPzhjSqg3LpCSkCkXKI5DRTKJgx1IxSqy+hH9iFPorkK0qodvzCaQA+XlSDTJaRMbwhICJ3wCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594392; c=relaxed/simple;
	bh=c0QBlhKG71j35+ahEUAuYE2gertFT0ypy2pMftXxiUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWW43x4UiQMrEyUqPcTEmi1ZduX/pO4hswXaRlCCSU1v6zroy0AF7xMrQLstqxxHBrQFC+aiU0rDTPIHiQ/TwJNZCB5kzpvCp+3vXIY9pcczrTIAY+BrY1Gu86k/w68Ot3ETmxrmh5SCLcKcXye/io20V17N3o2TWriEftad0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHQsP/UJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHQsP/UJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789594378; x=1821130378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c0QBlhKG71j35+ahEUAuYE2gertFT0ypy2pMftXxiUA=;
  b=CHQsP/UJiKtoZlUrc3BHFMv2QSI8XEPL7PyrX9PrBjrMOkXjRGfuoKsT
   A43VjpyFFhFPiHVRe8fXIHlTthPGDCv1/9dwpw+ZTPgdnvJD7ufopM8Mg
   PdoV0lV8N5ZB4OmIFRv1qmigqQF7TrE02Z5DLy7kHJ0XA69eG5tyRAJm/
   4UvstMbVV7ThBMTmfAwQHxKy3xB87IEcUkhkGu7OQsdr00JNt65VBr5Iu
   559G5VfwjMhqQiZQeL1x+DP53PrGa0Q+EFosJF6DuB3jYmsPmQDfruHhW
   P6V+bTeK9EU75H9KCegj9DomD0sKGlk89zrvGXSRAhNKVLhL9HdVZO+JK
   A==;
X-CSE-ConnectionGUID: YzF+IFzsSUK3vJcC59UWcQ==
X-CSE-MsgGUID: FLsIjSmORjKg5YZ4AUroUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89918470"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89918470"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:32:54 -0700
X-CSE-ConnectionGUID: eM7YEe0CTjObMA3wkOWBYw==
X-CSE-MsgGUID: U5+8yxvwTZuuuaD2Ee9rQg==
X-ExtLoop1: 1
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:32:52 -0700
Message-ID: <1320a70d-4d92-45bb-9cca-5e86199b4cb1@intel.com>
Date: Wed, 16 Sep 2026 16:32:51 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-6-zide.chen@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260817183143.226156-6-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/2026 1:31 PM, Zide Chen wrote:
> @@ -395,6 +400,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (pmu->fixed_ctr_ctrl != data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> +	case MSR_PERF_METRICS:
> +		/*
> +		 * Bits [63:32] are ignored on hardware that supports only
> +		 * level-1 metrics, but may be valid on hardware that supports
> +		 * level-2 metrics. Preserve guest writes verbatim.
> +		 */

That comment isn't correct. I've confirmed that MSR_PERF_METRICS[63:32]
isn't simply ignored on hardware that implements only the four level-1
Topdown metrics. Those bits are reserved, and KVM should reject non-zero
writes.

I'll post a fix in the next version. KVM will get the number of Topdown
metric events supported by the host CPU from perf/x86 and derive the
MSR_PERF_METRICS reserved-bit mask from that count, using it to reject
invalid writes.
