Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6973B42E3;
	Mon, 15 Jun 2026 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511204; cv=none; b=krFsqy17xOyKuRALf9/UkyADJ+FAk072lV53vd+D4rnuHzzfcrPUGU3xhd6i4NWFcnr9MXih4EMcS7Ibrf4q4nrM3WxhE/ajpjyIJ9RXFhH0WlSPdh0tQ9yd/Ja/jcbV/IzdbVi3drY7ykk8lr2nN0t5sqAjVjDgF5bAeizgUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511204; c=relaxed/simple;
	bh=M3sGPEMVqa0Ld0Qk8LLOY8lCoOEtGLknWM+k1y6h9LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlzGMN5NsfMyU4Nbq28OtoMtl2dotvQbdAik7wxc2vEZ/EdAaMfVADef6Eb/M5FtE9I9alNXFiFlIPevmB9DSXmuB/+Lfdcy39jCxqDePErPstsC50P+ZbriyIsvwzlazgwXMZ3WysyDepNs3ooVBJPhTOa9tNf9GbrVXwUOq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJsCmzUz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJsCmzUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781511202; x=1813047202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M3sGPEMVqa0Ld0Qk8LLOY8lCoOEtGLknWM+k1y6h9LQ=;
  b=OJsCmzUz4+EhcYOtoPN09sglWQjPXuPLnnV8YTaZJJOeKAYdDa7sRAw3
   BGlcEZv5q1Sr36lvbe7jMH+1+lqX1AGOwSkCOtmHupvue6UkifXZ7WYiy
   lL3WrEuSfkO0KB7oDWxdgslYgA9e7Tn2typGWlOnDd4/FNugjb4uwXGaB
   a3mHpsamb+W5/BdNqsxxax9XyFK+xTr4WSZfOWPaaOAswnNi+P1ug+0WD
   opI20EHToFk97PC9RFtNMFNhAHwT4A0q70hNm0eoBpvDqjCa1ut7uL1GI
   7KRu8h21wcyTG29eUFrUO0pXsJBmBpZntee67M/GguCHRn48o2O50lNgC
   A==;
X-CSE-ConnectionGUID: O7I53zV4TUuI+dV6B5Eu5w==
X-CSE-MsgGUID: FiTJ51/UQT23Ubig0jiYOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82256415"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82256415"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 01:13:21 -0700
X-CSE-ConnectionGUID: KwWGtC6bTCyqsu53jUNZQg==
X-CSE-MsgGUID: 8bpKpUpJSHiccUe2e1nb3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="249308301"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 01:13:19 -0700
Message-ID: <5c7f27d4-9561-4ad8-9cd8-de8af5ebba5b@linux.intel.com>
Date: Mon, 15 Jun 2026 16:13:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/30] KVM: x86: Move kvm_{load,put}_guest_fpu() to
 fpu.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-12-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-12-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
> moving the bulk of KVM's register specific code out of x86.c.

Nit:
I think patch 4 did the moving, so it's not "in anticipation of" anymore?


> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>


Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
