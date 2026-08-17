Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3D244687;
	Mon, 17 Aug 2026 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786946904; cv=none; b=oOskfcHWc4ajC53aGQTgwOso32fuWaxl2s9h2LEPWIlEKXRvKS1RHDRiXgccU92yyidJLqRUiAN8vLFwyjnshZODOxvq3U3CoU03w8Nv4C44qtYoxb7fZKCr5JaYTX8CUx2uovdtRzzmf3Rabdk4v+RcUHfriwspnDPDC6EPULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786946904; c=relaxed/simple;
	bh=cxd/eaZrUGPQr9SwGdjLfU8BfsvOHh2FVOBjrb30QcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=revIY0H6ovtT6cyD2jrUyptzdUvm4JfEog2kNMaDh4h9aW/DrgvDSza//u+JjJLrY3iiDgzsBdNKIWZmqBxpLKBS17N8xHFqCxq1Nwc+zSTCzoDeTjPfJMCxW23168VmkY5onFu4pEHQ/LHV/OyfqSwVYakGxUEZ5vbhzzNWFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQXIhh2/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQXIhh2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786946901; x=1818482901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cxd/eaZrUGPQr9SwGdjLfU8BfsvOHh2FVOBjrb30QcM=;
  b=MQXIhh2/+CO943IJ1tEQcK3FMfOErPjT6TUR8xJ0EqN1q2XeQEgeklYe
   vvAcgFhQQG4j6qZR7tvqqDB9qkIDtGsErPmIwSDoQp5hrOr0LmWZe+F2n
   x5B00jFzofjsPRAqptuWpz88/9KxcXPJt9Xs8I9hDj/F63+Nfe8NKwj50
   4Rv1pyo8GviKYqeaLqRKBLzI1e/J3fP8W0NV2nuy06YGh3uU/f6ovabmT
   AHCgtQyoD9B9Xzt6M6c9uURwBFNsKLwXfxeQ2dQ+lUOI6eeHihIDHwai2
   0+JsKK3r6HnJ/2+acXO1DL+LbbHzjqN5U0iR+R3hrD+2VgAnFwaeMc6Pi
   g==;
X-CSE-ConnectionGUID: PR0RYPJeQRmZM5B5eFOH9Q==
X-CSE-MsgGUID: mkfBbL0qRA68c9ie9XjsNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="74948784"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="74948784"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:08:20 -0700
X-CSE-ConnectionGUID: OW4U83oESBiRZlRy7o0WVg==
X-CSE-MsgGUID: t3/Yoz1XQiOIwm2zaRoL6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="270019324"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:08:18 -0700
Message-ID: <e7430468-be26-4f96-a185-a774783d04b6@linux.intel.com>
Date: Mon, 17 Aug 2026 14:08:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: VMX: Move the shared "IRQs off" exit handler(s)
 to common code
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260814161129.2177118-1-seanjc@google.com>
 <20260814161129.2177118-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260814161129.2177118-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/2026 12:11 AM, Sean Christopherson wrote:
> Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
> capture that it's a common handler and to allow guarding against incorrectly
> using to_vmx(), and to allow for
                                   ^
It appears to have been abruptly truncated here?

> 
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

[...]

> +
> +static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)

Since it's moved to the common code, is it better to rename it
to vt_handle_exit_irqoff()?

[...]
