Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84B1DD0EF;
	Fri,  4 Sep 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488371; cv=none; b=no9WoOyQgbGAa+/2V3sBlCdTT4r88EdxuGriHOyYMxnVA1MgpTyRieyhOodpwTwjcU29brlcT5GpIZCxNDergUnWljOU/onzilLEBa/iTR6vmDivRIOItsUKYsy4VsTlithe2SiUZ9gHaJClXwvpbpH5O71iuFnZyr0V8WymviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488371; c=relaxed/simple;
	bh=n9F4+oIz33XOGAxqU12gJL9Chj1DXyGyLxMUbOV2nbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpqQwcLhao1ia09+Qyav53OTdWxuWP6VPAmBIC65h3zHScgyDHSCYfW52qNnL6eKNJyznnZ+QgkZ5I1Dix0heyO5lu80Ku137+w7do+JPrjrQvkWPSwDrz7P8NbgV1xTkpxtDI3cRZCsOFzzKBNPhskQ3EI5oAJ39OgTrSqPpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4Sx4dhg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4Sx4dhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788488368; x=1820024368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n9F4+oIz33XOGAxqU12gJL9Chj1DXyGyLxMUbOV2nbc=;
  b=T4Sx4dhgdtTq0AfBOxeVKC92gKBAjF6h+meoz1UZRvjDxev9VG6rZ45z
   4D+czwAjpfK4t7M0pFJm3rmo2mz50TSLuuT882XEk4zpNC8BIQuvV0Zqj
   8rqcOzAyH3rkFGZFA5tGToQCu8m4F/CFv5ugpzKhfQXuDMMXjMnU66s+j
   hbL51r+ZuoaGCWKn3an8UCMeMSzkmcTEL3haS/ATjhrx3RuWG7MC9zKe+
   IxBTxqLMnchZOc+WuOvs+DyNOcy4JtJwGOGFP1XhlQtrI7OiOGVd+800a
   0u+n9fcsV2tLv7h5pULyV5XdGLFY+AAvXId166JJ0g9sS1OpQDEMNVWDY
   w==;
X-CSE-ConnectionGUID: G9DO/BHLSlGCXsmE5T5Lcg==
X-CSE-MsgGUID: necl5fd/Tr2GrP2yRGzh1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="114530283"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="114530283"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:19:27 -0700
X-CSE-ConnectionGUID: Gu6nYsrKRA2TQcJZir+zpA==
X-CSE-MsgGUID: 2RDhmA47S+SJPKEcw5Q67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268597112"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:19:25 -0700
Message-ID: <02491bea-3d12-464b-a219-c2b8d41d8d5b@linux.intel.com>
Date: Fri, 4 Sep 2026 10:19:23 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] KVM: VMX: Disallow using to_vmx() in common VT
 code
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Poison to_vmx() in main.c and posted_intr.c so that attempting to interpret
> the vCPU as a VMX vCPU will fail at compile time, as opposed to failing at
> runtime, or worse corrupting state without outright failing.
> 
> Note, to_tdx() is buried in tdx.c, i.e. isn't broadly reachable, and so
> doesn't need the same treatment as to_vmx().
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
