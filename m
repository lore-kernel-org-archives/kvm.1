Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787733D5241;
	Tue, 28 Jul 2026 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268112; cv=none; b=NOG9z0vlmSGE4H1ohLqRaPooeZlsZ7fv74aoTICc4jeQQS79X5WFNvJxki1rleEINZiqhAHnt+loLdD69Q6eFa9VyqERdxBdn2PVOfkb2ZPDb1kTqcAuXWu/bVht1kejB3VZV7VMiPH4syW47q7C0uTzOyrLjRIsYfUX0owe2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268112; c=relaxed/simple;
	bh=WgJmTeDx+2zMS0L2yNoAcorFu1aZ4H4UnlagUpWlhok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWiUqg95yfqooKS/zQUl6Xu77nOXrvE5+zd3C6Liyb1GyEAvwEW88ppnp+BPXLr736b0HhJ7DN4TU1U9x4qcqNLBT8Qk2xsv987adtwCm6KM54nkmdWgnyGjViXhNDOjsl7l9+3+N2oSI1r9a2cedJ3u4KbdEb95FhSLjFBw6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jw0qQ8BK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jw0qQ8BK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785268111; x=1816804111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WgJmTeDx+2zMS0L2yNoAcorFu1aZ4H4UnlagUpWlhok=;
  b=Jw0qQ8BKOA6BXeXJXQehjt8drNdXGcbrYhXe19xgKqRqkOlwvZo8LgSQ
   rlJFyYXHLrsp9VIeexvAgjEM3/nuoOzKhzPZiFj/Xb0VIW4nz7i8vBn9y
   NBU3mb4SHJDfKMMoT7rZh9qE3Za4wIujNz8Du+aUXczTPHq57YnbUDFpi
   h9sQL8G9DmHI7QXRbv+iUK6xdACbxGoTvYCanMbLcuiptfwqMjFlDgNag
   f1iCf9UEHzyq802kV+EPfd840gl8WFrI0/f+gK1sNAlRjSeLZylb/AUmM
   1/lu7MmRIgRTDd7wl8NnMhNrKJ+jcjI31sSSFcutrp0i9EX9vg99zhHlM
   Q==;
X-CSE-ConnectionGUID: ZSQwfwWqRrmG9fJEfTYLPw==
X-CSE-MsgGUID: dW5Ji9VGTamh+LQEbnC56g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85947850"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85947850"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:48:30 -0700
X-CSE-ConnectionGUID: U+8L+fH/Qz+Bb4cVcnbPxw==
X-CSE-MsgGUID: 8S42o5S2TFq7+XGawL3PlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="263607652"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:48:30 -0700
Message-ID: <364fea79-1fc0-4844-a243-0601e9cbc7fd@intel.com>
Date: Tue, 28 Jul 2026 14:48:28 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] KVM: x86/pmu: Emulate streamlined Freeze-LBR-on-PMI
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-12-zide.chen@intel.com> <amkEEnR3IuCyncIp@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <amkEEnR3IuCyncIp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/2026 2:33 PM, Sean Christopherson wrote:
> On Tue, Jul 07, 2026, Zide Chen wrote:
>> PerfMon v4 streamlined the Freeze-LBR-on-PMI mechanism. When
>> DEBUGCTLMSR_FREEZE_LBRS_ON_PMI is set and a PMI fires, hardware sets
>> IA32_PERF_GLOBAL_STATUS.LBR_Frz instead of clearing DEBUGCTLMSR_LBR.
> 
> But KVM doesn't even support LBRs for the mediated PMU?

Right, we have the Arch LBR patchset in the queue, and I was hesitating
to include this as part of PMU v5 feature completion.

I'll drop this patch and remove the following assignment in next version:

pmu->global_status_rsvd &= ~GLOBAL_STATUS_LBRS_FROZEN;
