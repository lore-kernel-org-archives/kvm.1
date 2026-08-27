Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50428440635;
	Thu, 27 Aug 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827738; cv=none; b=LyAJR7aQzqZRGIN57CZyIJN44hILhhun+2SZO8lPDaY7XLEn79nRhhwiFb5BIJrZv/gyx1IBEQ7QAetwi28KjeQ7RTmn2Wv8Ki4OKBCBIuSeyfLcUAhPRVLcFgoQvjY0QKbOQAk+yOa+dTnKe72ZG8tYMfoma7C97kYXUFXWiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827738; c=relaxed/simple;
	bh=TqF+xfAfMAJ6k5CDUR3fE0IcvS3Wrrg5/AHvf+9d/Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UylNglG13rCXjpffwhqtl5g4f82sSQVtLe70HVyqklt9PW5Tyh1gnRST3VODb6anhtTGeXpXWSew8OJ0xIcnfHcDJWG+1OORoPC7EacxysWd2oYIPj2Xo3EfbqC3px9/XQCQDyiERRw2HtY2Jm6Be83TpOFUEcs2WdFl+tqGki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b958ALaB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b958ALaB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787827736; x=1819363736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TqF+xfAfMAJ6k5CDUR3fE0IcvS3Wrrg5/AHvf+9d/Ck=;
  b=b958ALaBVHTXaPz2no5DT08GaLRTlUWjwDcmAQNzvdaXVTJZfY5sDz+k
   YQ8iBDsOW0leSFOsNkK+VLJ2wgyJJT6So//cQEjRB6ejBpHDTRlEP0AFP
   I5RxSIASXJToMGrjgKb3JT2VA/8wiEfwm3lrxErZ9SHW1YIA0RbuYxJ4k
   nuVIiv3+f7YdWoxlG8v+ASVNLP3NlE2p/I+sAme61ZZCnicWdt6BKg/Ir
   /c1etaiwupI7Vhg0Tq/ERhGLLQ1/iR5KXj2sLZnglJptHgWjokBGRYP78
   75slJF3unhsupwV7Rnt/Slgr5YvpB7xXZSAFZO8wIY21GhHj/Jpx9Um6x
   A==;
X-CSE-ConnectionGUID: LO3oFTFETuykofNDMXMVtw==
X-CSE-MsgGUID: mEuTnht6TFKMK72u1BeDYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87267641"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="87267641"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:48:56 -0700
X-CSE-ConnectionGUID: XXMngeOuTsufj5lRRe2GSw==
X-CSE-MsgGUID: qtd2HkLWTzquSkdeKMPShg==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:48:54 -0700
Message-ID: <56ad5526-76c9-4cca-85bc-242a09a98936@intel.com>
Date: Thu, 27 Aug 2026 18:48:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] KVM: VMX: Move the shared "IRQs off" exit
 handler(s) to common code
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-2-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
> capture that it's a common handler and 

> to allow guarding against incorrectly using to_vmx().

For this purpose, it seems better to put patch 3 as the first patch?
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
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
