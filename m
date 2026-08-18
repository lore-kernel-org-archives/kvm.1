Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74434DCD6;
	Tue, 18 Aug 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077841; cv=none; b=b+UHCKJypWbBrtTDumu+FZj88jbHhnkZhVKfUZt4zHfOJGtiQKjkAUJdSBgyghrRhEA7YrANQfnIRpA1ajNhlW+SkxCS2xkiv9gq1iSxQ7QcM5/sN+RV5R6BJZwrR6Gqc/tA5VrFmXMIeINaCPnCcwmRch/Z5BM5qQHJD1Hdfgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077841; c=relaxed/simple;
	bh=OifyDmtF7aGLxK+GIfjGGWqID3Pft2TdvjfmPOg6RNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFRwGkU97T+TaFfIwKK24ZGkE8AkbNSUAh/mzwpgtYwHb48YufC9s7sv5JIVUtT/6bFLuMVmhx6J98+dL2Pb+J/wLsNwn8WHzUehr6Y7xTRJjDkI/3Bwr5zkwBLJdHANsg5idD2ELbcSe/Tf+YBDxXfaoPq9KovRYDr9F+ioncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meAleQXc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meAleQXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787077839; x=1818613839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OifyDmtF7aGLxK+GIfjGGWqID3Pft2TdvjfmPOg6RNw=;
  b=meAleQXc1UPmllyzoUvxgfhnthZaiiVl6iorKi6hqF63NDX2ttgipTgk
   Lu9hmMqwAYi+DrrNc3oKhg7CO4DGVEfcLtOXwkbpC9CZLSjWa8qMCAWna
   83SezyWjo2ki/H6N7qGNnWn/ZREkroOxAHcDMobqO5hFW+LLs4kjDVnXV
   PhWriNcgjvkXnZfOPgixDuAL/ql+xwaRTNQ2DeCgT84aq1QnNYbGiY7cA
   el8cX5042k9fi0mqO/bPTA+f2OoaxSzmjkBglgeNPxhXOll4aWVDON2qT
   ax+AtLsoZFHL6StdJeaPm1ikaxyFh1ibxaprb9afhdMLRjAoUyeBzSxGx
   Q==;
X-CSE-ConnectionGUID: agi8pMUERaCDq9oOlp94Hg==
X-CSE-MsgGUID: Z8W40p3cRr+R04ltsl1tjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87600303"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87600303"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 11:30:34 -0700
X-CSE-ConnectionGUID: KcavLuuBTmWlqIilQCgbEw==
X-CSE-MsgGUID: kXSwHcT+RJmOCpjnj6WzoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262032100"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 11:30:33 -0700
Message-ID: <cdd88e7c-abc9-4e49-8947-bb7226f3a385@intel.com>
Date: Tue, 18 Aug 2026 13:30:32 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Andi Kleen <ak@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-8-zide.chen@intel.com> <aoSZRRDtNxNA0UtK@tassilo>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aoSZRRDtNxNA0UtK@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/2026 12:41 PM, Andi Kleen wrote:
> On Mon, Aug 17, 2026 at 11:31:41AM -0700, Zide Chen wrote:
>> If the host has the PERF_METRICS capability but it's not present on
>> the guest, RDPMC interception must be enabled and KVM should inject
>> an #GP when the guest attempts a PERF_METRICS RDPMC.
>>
>> If the guest has PERF_METRICS but RDPMC interception is enabled for
>> other reasons, KVM needs to emulate RDPMC with type 0x2000.
>>
>> For simplicity, Metrics Clear Mode is not supported.
> 
> But is the bit cleared in PERF_CAPABILITIES? And would 
> the enable bit fault?

Currently KVM doesn't advertise
IA32_PERF_CAPABILITIES.RDPMC_METRICS_CLEAR[19].
> It would be better to just support it, metrics clear is actually useful.

Sure, I'll add it.
> -Andi

