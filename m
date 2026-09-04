Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBF4CCDF7;
	Fri,  4 Sep 2026 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490471; cv=none; b=PHP5Hkej2tC/63ld5G0EFlvPWw0xZ5UuuOMNi2CDLAPWkIQkZTQhF4Jm3AOdtCeK8ZC3Oe0VpwSCCv8MhwP1f5KVQ2fb9BvUTaHlKIkyU6cvg4g9UwXwN+HSxULX3gxjXU3gGnoK3AzqwzIdS1BUVa+Ip/AF2QybDW2/fhHslpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490471; c=relaxed/simple;
	bh=n5QDR7Vrvn6lDrRoNf8YKTkeF2exwlOioT0rOy8npVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9npD3vkDEa19GBLFUV/6Anc368F5JEmSokVCzPbztelTeKMU7HvkztixmuayOE8Vcu2xLVEIol8Hbf0AeIjXjHazUTpL0+ZAxYrabrQL6fVUJqqCNk7zLXcasCkSctRkaIXX8DqfUMUezf6KyNW1ZxxADirq/6+jPLY1WKHCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8kkKPbb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8kkKPbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788490470; x=1820026470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n5QDR7Vrvn6lDrRoNf8YKTkeF2exwlOioT0rOy8npVc=;
  b=K8kkKPbbN3GdZ7D772d4DPW1vF1iJRawr2uugS1EQd0J27jQAWWMDuFZ
   poJydFg5Sd/KledWYFAFxT9GrGZt/fnj7XgRs8xwK3dnb9rg0QXoDL71B
   Qa9yXe2zLBZonZdjx4jDcQYHcls0kpZxXu7PAJ0maWFnP76f9R6nXgqse
   oZ2+n3GGMYhr9vGi47QMh7Y6VpsLTuYaWJ8teZ5KlhGyShWoSThziCjcz
   +7cn7L/uBkWKjk2KTb9nDKKG/LQU/qO6aysetjfV5KAi1a5gMofLKKt9p
   oSOy4BK5EV69kChOTEWUP4uQPZID5H27o4/YjLKqIG4gxFVdCXRH+E2du
   A==;
X-CSE-ConnectionGUID: wi9DZEWvTDO/hFff7ZXi6Q==
X-CSE-MsgGUID: QugJUou1SnaRGFkZOAG9Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88915084"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88915084"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:54:29 -0700
X-CSE-ConnectionGUID: DSQZZ5T4R0anNbbLBlznXw==
X-CSE-MsgGUID: wno9vNTHTKSJHGzX9StBXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="271865819"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:54:27 -0700
Message-ID: <5cf79075-eea6-46c7-9896-325576a23065@linux.intel.com>
Date: Fri, 4 Sep 2026 10:54:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] KVM: VMX: Use dummy pseudo-overlay struct for
 to_vt() and vt_to_vcpu()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-7-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Define a combined vcpu_vmx_tdx structure to represent the common layout of
> vcpu_vmx and vcpu_tdx, instead of having vcpu_tdx piggyback vcpu_vmx.  I.e.
> require VMX and TDX to match the common definition, not for TDX to match
> VMX.  This will allow moving to_vt() and vt_to_vcpu() to common.h where
> they belong.
> 
> No functional change intended.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
