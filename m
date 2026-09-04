Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958213AF2;
	Fri,  4 Sep 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488916; cv=none; b=jolFrP6DFCzFVwSWa7AW9yyeBZJ3ha8cl53FdEbaxnzdEMhPMfajBAc6H1WPzT1R4zf4K6bQtoTh7s/qPupL93i0YGxsZphyd053KhPdH7xWTJTpeZ8glRCItRstYZtNVT8xYxqAI3tKn6xdjIc4gkicBtyhFLtlJDefGqrUpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488916; c=relaxed/simple;
	bh=8ba6wolkvmeQ3axq+ltVJTJe0uSWyR9WMTW0iuQCMVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oq0gkfdLrNBHz0vC7qyY9R7BKuSG/A79RkkD9fp0MC87ecMHfxcLl9oDPRdBkTJKXhuMA9P+07gEvP4tjaSHixhY9oXObce6jWFqsL1/HjBcxQoVOr5NO6fnhNg8MdeN0mEMzZtWKwn4n2mycRz4JlHH+9+igxCE1+3ydA9PDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6+TlaCl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6+TlaCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788488915; x=1820024915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ba6wolkvmeQ3axq+ltVJTJe0uSWyR9WMTW0iuQCMVo=;
  b=G6+TlaClBlDflbf7/aPkCYPHriBMhuTQ4aI5FogWP3kT3hMNJVpfR708
   EfvcO3bpwOV9amXpti/Hw8nqsDrFsxYxsEkhch2BAmBFyEhqXlEIsUAuf
   3YvkF+9gkZIUFyE8u36diVW2RdMFT5POhZBQmk+RbjoA11+RIieXTh0gR
   Pp47hEHE+UXhL819IRSeAnxS16wuGTlkQZDmPITlLieyeT9VytESs147z
   9/k4FkkC37QnlzPb1sHxJUUiggWu/oQ0uwcCV9ZQRdNmr/RSta/gOcKkb
   mz6FbJbjnKZWm0OXHtqVAPZY2KUNtB959mdPlq5sr7EkNxH+YGSXMqh2U
   Q==;
X-CSE-ConnectionGUID: s4/27MZJRA+tGjekc9EtSA==
X-CSE-MsgGUID: KUsgGElwQyyaunRBn98MLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="114530754"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="114530754"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:28:34 -0700
X-CSE-ConnectionGUID: OT45+yh4SUiihUlZ2MIVqg==
X-CSE-MsgGUID: ujKiwGojTsyp8eAiNZE6Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268598642"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:28:33 -0700
Message-ID: <fa1a3a0e-e33b-4976-a0c4-f4055df403ae@linux.intel.com>
Date: Fri, 4 Sep 2026 10:28:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] KVM: VMX: Move the shared "IRQs off" exit
 handler(s) to common code
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
> capture that it's a common handler and to allow guarding against incorrectly
> using to_vmx().
> 
> Opportunistically use a "vt" prefix instead of "vmx" to communicate that
> it's a shared handler.
> 
> No functional change intended.
> 
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
