Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CB1684BE;
	Tue, 16 Jun 2026 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579891; cv=none; b=i7OvqlUfIieX8NpKV69VfZ8pzC81oEjsHqqQP5SU0u7p0YIrzXKSvh/7YIudn/6q0NoY7qQm+n8xK5freYk/T3lPaZQju6b41E3IoVElA1/UItmzXpbAD3IRVGbGThvGbm9prN2fwjw7E6quKtJfEMClQW5COqO6TF5dQUIuD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579891; c=relaxed/simple;
	bh=jcPR15Y/TuEv/NAnaCPpDViu7dfTZNaKfE5D20az6Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcXbSZNIJSEmdMURqpivkXg5qpZwcSWew63NjhmCXxErqqQqW0wW25GXwIosY1U7otdTLBRMx+bZMCCeHAsm5lKpi81lEmXmoPiH9KlAFsp3BXqMoXXc+zJP93uk9bqUSZMVI+hhUB10dmqliqWwCEX/TbE8wkqt3dESYEjoJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQI+X+/N; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQI+X+/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781579890; x=1813115890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jcPR15Y/TuEv/NAnaCPpDViu7dfTZNaKfE5D20az6Ak=;
  b=IQI+X+/Nus7zoZRw13Fmx5Wy3vmucWH2eFkpLfQ4aeyJh+RNU6LQRlVS
   Jkw5AJwEyEAaw1W4aKgwEcatophGlJDDPhfeLBaDo2amlH8Qpk+ij4BFG
   DrJ+9m+rrcPgcate+JZ8RLtCTtI+m14AuYZt1bglrUVr/EioivTGsHCDd
   kNOueyh/zxTkyU/mGrGsPXYtjF3a/2H+qkso9fTWapVHmt9pPrh9N6T55
   phBAwGsa24JRUUyHzJ29BeqEqbqj97+AHzI/+vwk1Lo/LxYuUv+snYffl
   s9uIx4qMEUQ+qo2hv7Tu3AXW1Url3hzH+O6tfEJ0+wZ0zduMGVGD1+ueR
   Q==;
X-CSE-ConnectionGUID: GKgYJIppQl+BYVYCtTfy2A==
X-CSE-MsgGUID: kw2/X4zxRU2zIPRh6El6CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92652055"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="92652055"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 20:18:10 -0700
X-CSE-ConnectionGUID: OBN3I02qRbquFW4EQsKvaA==
X-CSE-MsgGUID: HJf9/fEmTaaqkEnh5eutMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="277840276"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 20:18:08 -0700
Message-ID: <a3a42c01-34b5-4056-898e-8da320477b00@linux.intel.com>
Date: Tue, 16 Jun 2026 11:18:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/30] KVM: x86/pmu: Move "struct
 kvm_x86_pmu_event_filter" definition to pmu.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-20-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-20-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the definition of "struct kvm_x86_pmu_event_filter" to pmu.c, as the
> as the details of the filters are very much implementation details that can
   ^
duplicated "as the"


> and should be buried in pmu.c.  While the _existence_ of filters is public
> knowledge, almost by definition, the contents don't need to be exposed
> outside of the PMU code as the filter data is provided by userspace, i.e.
> it pretty much has to be dynamically allocated, and thus never should be
> fully embedded in a globally visible structure.
> 
> No functional change intended
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
