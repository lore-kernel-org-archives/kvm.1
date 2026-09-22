Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286A3BED59;
	Tue, 22 Sep 2026 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047798; cv=none; b=cSP4wxqZOImhowGyBQkEWo3orNE6A4p0QeeyIvqyLo2ClbvkCxqN4WtK47SZYDQHInQo1F/SgGRbEYZr4pvf6B3gjwxSJ+wwoDpBF753zBanxbfMTFWhfirYMtIypZ6D9uMsD7mLDtGbLJwwVaFSrFaU44YBmWB05pKEX2pPnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047798; c=relaxed/simple;
	bh=SVm41OZDERyMbvVTxmiTRg3xb66LpgS8Y/6xUH4zR64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScxafLpNCaONZQzKTAJGD62BKVlpvC1ZxzpYV5h3GxtIcVcZb+RAbiIQiicNzaauCIu17btOjEmzu79Z5W/Skams984TW83o0LjCsNKzLUqAOsY0B1zJTsZA/FGaZtKdOejOdLoMAEUvdyU9ViRm1Uev5j6xkuZamFjAbHjoAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mf7bUm3F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mf7bUm3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790047796; x=1821583796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SVm41OZDERyMbvVTxmiTRg3xb66LpgS8Y/6xUH4zR64=;
  b=mf7bUm3Fi/6UBo4gQsukM4kr+iRB+UQl0R5Zc2ehSuI5jRjzdr0+zjyR
   ocD+B4NABBL7FKQt/pQv+OJUj+xPVt/KngJBSZQVSSXN90zMoRk1LQogT
   kYjwQpkMz3PP4M5bz61ydN6V4+42bdr5tFVW4ocVQ46x2KWf7P2aGNaU2
   aIxe0TsrIkmVlKlLrDQ7EuyXW2CW1aOzZbcMq7B1Ue7TLUO42o8xuYm8n
   PlrtFnwWVNkbwtMnSnLWUsOa8wxyQf6EnxJfNK71pCuwhykKjG5VfObNQ
   0bk8PimSissIAaAyoa3kLX92TD+ttL9RGCPw8BT9hS4gyhCixFTyUvdF1
   g==;
X-CSE-ConnectionGUID: aEUSKI4NQwSR3OPKGNOJtw==
X-CSE-MsgGUID: COM2ROUyQgG6HImKlAarRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94445020"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="94445020"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:29:54 -0700
X-CSE-ConnectionGUID: GnXQpSrDQOeBXWUjJmoPWg==
X-CSE-MsgGUID: 5v+si7JnTvGeyPcJvPKOeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272138332"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:29:53 -0700
Message-ID: <977a9079-44ac-4850-b6b4-29b126101f55@linux.intel.com>
Date: Tue, 22 Sep 2026 11:29:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Move bus lock handler from main.c => common.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260922000152.1113202-1-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260922000152.1113202-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 8:01 AM, Sean Christopherson wrote:
> Move the bus lock VM-Exit handler, which is basically a one-liner, from
> main.c to vmx.h now that to_vt() is usable in common.h.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
