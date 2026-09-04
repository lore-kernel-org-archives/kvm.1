Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661637F75D;
	Fri,  4 Sep 2026 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490650; cv=none; b=G4bRkypmNMrI4BTtvUwuQ8brXIUDCahmVop6qI8Zdr5XgXu0po+7r0Cq64bY4HILTG4dqCftPxJU4M7hHq2F5G/TvsAhNuIaMmHgDH2iamxlfHHPurjJxouUuqNAcde1CdjOJGlgaArO/QtRobUIzgVSeKW2H7R1wjAY1tBag7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490650; c=relaxed/simple;
	bh=iYR0oXIVSet/9AajHwy4Lq+E+b35Sv5mxgNq+z07olo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBs1PnNunXUzGmlkRp8UE1HVo4kKbLtVSLvrfAvWEZw6WaJpABhTsweOmRBhAjhUceMGZiyc5jV9zVJJWcKeMgvGFARfPEy+JW+sPZcGwTVYbiuKRT51Zg7qKI/QN1yeQHUUD/iBm8/qV3CqD2TAFQTs1qrFrZXcVS+ee2cCDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNkLDfEo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNkLDfEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788490649; x=1820026649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iYR0oXIVSet/9AajHwy4Lq+E+b35Sv5mxgNq+z07olo=;
  b=eNkLDfEoSsleJ+RAw8W8VVeX4y2/B5DWTWTx/kusCh5jIquaRhW1utnd
   bad+wT8WIoQdWzKrJMwBSS0o9kBasUr7/6yoahJ3RLSqHUXxJoZsn/T3k
   zhsAHQ4uyI23tPORAzhg8bmn3kplD/+Amgm+WTOTZsJyI6jKCRKoaAzAI
   du795forMYeDlXTghKEpe6ozs38HkC4w3aJkQA3fhI68ZCZghh+v2rELh
   EEArPHoaJTUg5E8l1wHntlUfM46f5bUNrK74zBCyr15HUN0l+N4+Em6vH
   wzkBvprTfybTL0ubxrBiWlse3OTQX0ugTMzI6qBGcwl7fSNfPMYOu+eQd
   Q==;
X-CSE-ConnectionGUID: T0H07J30RgyMSvM8M5CCHA==
X-CSE-MsgGUID: dYz6cGAVRdGxtNfU4IVlKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88915231"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88915231"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:57:28 -0700
X-CSE-ConnectionGUID: G7VWnjz4RHCa39LLyAPYcQ==
X-CSE-MsgGUID: 0tp4LJ00QECHbx4nGvqFkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="271866133"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:57:26 -0700
Message-ID: <4e14c6dd-e350-45af-afa5-b3680a32d854@linux.intel.com>
Date: Fri, 4 Sep 2026 10:57:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] KVM: VMX: Move common VT getters/converters to
 common.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kai Huang <kai.huang@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904010353.3175819-1-seanjc@google.com>
 <20260904010353.3175819-8-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260904010353.3175819-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 9:03 AM, Sean Christopherson wrote:
> Move the "to" vCPU converters and common exit information getters from
> vmx.h to common.h to capture that they are indeed common VT code.  Defer
> renaming their prefixes to isolate the code movement from the massive
> churn that will result from said renaming.
> 
> No functional change intended.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
