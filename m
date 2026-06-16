Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6A3CCFB5;
	Tue, 16 Jun 2026 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586302; cv=none; b=BEWlCeDMObeqU2v122UYo28R9G4cifPaHBwPO4wnWt3UtcCKhWK1KBDPj3DjXvOgRd/NcGH+0MQix8emobG4xoaMgZfgAKpY4/LKbVveNwHLF9P6TXCLnHAQQgXyxF/6V0cl2Vo8oS+1t5LQo+f8t7fdlYx5Vzr4mcFyLGGw+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586302; c=relaxed/simple;
	bh=D1Ql7vxWraAOgtgwZytVGw/Dltu9W3G7MORQMwXCH50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYKc/gOacjYmheolPYgcHpxWC4MGzdQwwOgRu1EMbS/EyCAU79luEngI17Yg8bFEOlSED0TPr6BJ9KUaqOHlqaoFYDcQFNe7coBbFOfk3Rb0uf8VtTDb5p7gp3xe76L8jEmYSTiBTFC7c8uTBnVlglbn2uFNcRcjHrXI5l0qdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+GxArQL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+GxArQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781586301; x=1813122301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D1Ql7vxWraAOgtgwZytVGw/Dltu9W3G7MORQMwXCH50=;
  b=n+GxArQLoS9rG5v+U1bNwl9z49Zq3aJ9x/3hwpTJcqdrX17f+MULypeL
   KlOIdCfm/sleToQ79ufZWLN43fj11wPc4m21FtVBvVQgiabR68d7dbobm
   GGnjGTZVMAuODZO4aYgmL6qutfe145UHEEHdDvGP5Iv8AHAG5rzqzVGtk
   y7vF76NfSUZ26cEphqGsvHMDr9RG7oTYLjz4jNVnXaXYnDaPB/PeM6ufr
   0snoDfVACHfpd1rmMVEtfO7q4Ef4M/le8FrBkN3qSek0eT08KJmaIMc9F
   gykDgFRan8xKYuZglo7miyDLqoZGD5Nr1+EXnRwFw1xrBdnZNX5z23Re/
   A==;
X-CSE-ConnectionGUID: gRWHeEpFR2+/OPTckBPdJA==
X-CSE-MsgGUID: oFz4vGHuQ5i6l8GJnBKcUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92899258"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="92899258"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:05:00 -0700
X-CSE-ConnectionGUID: ChdxrJJJR6OknFgkYwt3PQ==
X-CSE-MsgGUID: ODg5jlqUR+6EmZWtMKrQlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="246769503"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:04:59 -0700
Message-ID: <48609d73-8a49-42ec-b4fc-11b35bb49229@linux.intel.com>
Date: Tue, 16 Jun 2026 13:04:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/30] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-21-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-21-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move a pile of MMU helper declarations and macros into mmu.h, as they are
> very much KVM x86 internal APIs and details, and not intended to be exposed
> to arch-neutral KVM, and certainly not to the broader kernel.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
