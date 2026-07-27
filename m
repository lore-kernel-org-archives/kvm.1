Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47B36DA03;
	Mon, 27 Jul 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141723; cv=none; b=nTdOirPzt3GWqsm5471yYslOgOIkmYfAKqhFSvPjuZoSFquJacwcNc8WbEwA8DSuSatg2X71AEvydw9IG1Ke1LhsmnU17gO/lVndVEnqU8qAdN1/rk/nVpLby+f/sEDhvnDtUxooaY8eru0QHInpl097NAWfQG7b/9KLnF+fXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141723; c=relaxed/simple;
	bh=3FPSZ6yCMhVh5x8tRri3kZ2gJ84+qX/PSuG02RDTW2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlpgrDUaMxYsN0xILuyiDNgcQHjdkFGsBBFGTI6hBEhIb/EghrMK7RfcE+BZz5Q3DGC+WImzatXbs49lqoBvz1ageWiIGzib+DnNPHNqCMjPctha+Gqz2NwlaUGaQTLxAkyZgbUsbQR05Ei+cXXJrrF5Jdm/C5nj0cIO0haEcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6UybnSr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6UybnSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785141722; x=1816677722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3FPSZ6yCMhVh5x8tRri3kZ2gJ84+qX/PSuG02RDTW2o=;
  b=Z6UybnSr4Ifd0FzIq4qN6cOiiwx9E5+d6z9vKUazm0fHcHysf6aDf8w9
   WrDMT9TKLXjc0wXXvevtoxP4sEB9ptL+sTb+Na0P5hImSYegJCCtdq7TO
   2yUAOz9XNutbH1rFvwN1MvJMe35S5mEBCqRBlNQO4NoCX+kX3wKtSNGg7
   81u9iG8da8nh9OPjHrNk43sks8jFBP0BMVr5qiQUTw7M7gmuev7qzsgC3
   9RGgfBwx1hBNdN0bQiMaRd9kdYgRDssVDn+a4cuGtEbBXdQLSOnT0rcK7
   RIWUGBKUXNZIbXacUndKrVdx9aSvgCPpJ4/xbNp4Vautw9mNS5DTX7u7T
   A==;
X-CSE-ConnectionGUID: meRIdd0HS1CciGVettIpFA==
X-CSE-MsgGUID: c1odU52iQim9Ors+AYxNnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103117318"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="103117318"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:42:02 -0700
X-CSE-ConnectionGUID: ihvrM6vmTSGaZs/kQvndSw==
X-CSE-MsgGUID: s7qOnIi8RhGW5X6WHBxRqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255419305"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:41:59 -0700
Message-ID: <6d1d920e-aa3f-4d52-baa8-22a69274421f@intel.com>
Date: Mon, 27 Jul 2026 16:41:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] KVM: guest_memfd: Pass the number of pages instead
 of the end pfn into .invalidate()
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>,
 Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-2-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260723210811.72720-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> Pass the number of pages to "invalidate", i.e. reclaim, instead of the end
> pfn, as a first step towards aligning the function prototypes between the
> de facto "to private" and "to shared" arch hooks.  Eventually, the goal
> is to end up with kvm_gmem_arch_make_{private,shared}(), and in both cases,
> providing the number of pages makes the call sites slightly nicer, and also
> avoids any confusion over whether the end pfn is inclusive or exclusive.
> 
> Opportunistically rename "start" to "pfn", again to align with the expected
> signature of make_private() (which needs to pass a starting gfn as well, at
> which point the "start" becomes noise).
> 
> No functional change intended.
> 
> Cc: Fuad Tabba <fuad.tabba@linux.dev>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
