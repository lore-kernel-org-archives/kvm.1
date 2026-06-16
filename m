Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE8359A9B;
	Tue, 16 Jun 2026 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599254; cv=none; b=GMY9Ud3htQoCa5Xe26wMW/JNYlZnPlZShHU0h2bjGsGbfQ1jgzPByS+3c5U+siXJ8K1sb+lB4tprRDWsauWs81NAvpBAqA+XmA9C2jFctWMbxL6FJ1NGLdzXx/Zmtb2jLzz+QJa3NawLpByl4oW6S+dm2PuuSK2MJKJgnFPBqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599254; c=relaxed/simple;
	bh=wb/WXsXuApjlxc41RDieDlXRM+ORWIAbz6+MASS8Cks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3OK4YPvao7JJWF9FBBCKLqjDtm/dt+JzYTwzvb+o/6VeJT0EiOYv+QvF2zlyfCbatKZTzgo23S2DYsjeODm8yN2Kptmj7BLKSuuA3YhC+oCuz3RGwZD8VYhHambtcJVCjUw5mUZktZ/SRhJuRl+RP9PSkOEIK/Z6za6/VDwqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeV6H9Cj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeV6H9Cj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599253; x=1813135253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wb/WXsXuApjlxc41RDieDlXRM+ORWIAbz6+MASS8Cks=;
  b=jeV6H9CjL6L27ngKCnvrnIQ0A08imVL7fGvT0hlmwoXWLZQQancPCsGV
   +bwBwOwEVwIz7PxtX8BWgLWCkJv9hNjoePkA2ONusU38CHoZKRDLXkkER
   IAsNxxgQg+l2mb0SuStyoLeqRAv4+TVO8//0EdQAiwQgWMi6ahbFaHliF
   S6g0dGyeQiqPCWvOT25TMqCmFw9H1MBgJfjg8daN1hiGehinqv+DAx/hN
   MuTq3CM2OtcXqoC+JHyb/y3brgRvqoEzhynCdbfPFMoMxtrKYNL61+b/e
   xZItJTiUAytlrpeNGzR+VfT5o3elM7Y8oaVfdjtLcrVgxm14RPA33fdzo
   w==;
X-CSE-ConnectionGUID: bedkuMUTTZyVXe6wUD5QNg==
X-CSE-MsgGUID: ND3XKAz9RTSvBAnFv3gN0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92917879"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="92917879"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:40:52 -0700
X-CSE-ConnectionGUID: y8HklUrUQ2O8E1LzmfuEyw==
X-CSE-MsgGUID: MHN1CFHPSGCX9BV8azO82A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="243334383"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:40:48 -0700
Message-ID: <1b1bd9bc-2b09-4f3e-af91-813bdd7735e2@linux.intel.com>
Date: Tue, 16 Jun 2026 16:40:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/30] KVM: x86/mmu: Move kvm_arch_async_page_ready()
 below kvm_tdp_page_fault()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-29-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-29-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the implementation of kvm_arch_async_page_ready() "down" in mmu.c so
> that it lives below kvm_tdp_page_fault().  This will allow moving
> kvm_mmu_do_page_fault() into mmu.c without needing a forward declaration.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

