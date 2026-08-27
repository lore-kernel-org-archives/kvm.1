Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4852F7AD2;
	Thu, 27 Aug 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831947; cv=none; b=FKHaYiT857J8NykNcqav1o/B5naX3NxYt/RAlsx+wm5HJEDEtXY8VB3PE0Vxq/Mu3KObZ9DyXYBE/b8rbYfBPQ1qOY4D6vnjOOVlFGY4cq/hyNcblYuWx8fTkvnZHlQbnVg02seMfzBnIHGy50fU3oMPQOU2lAO79FvcbVpHOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831947; c=relaxed/simple;
	bh=kS6ytQQ6q0R74tYQWG1swwo5Vl/KkrJwJ0Lbu9SeWr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf16CPDrUQ4FaXGaLLlyrjJjMW32SHa4lyY/CXwb5AUTqgFZIcnPdXMHC4vDOWDkHWtiMkLoCnhJI9v15rECiXNl8a65MdgGNbXSf+ox9E0KwiixzDWgp79w+HBvQCzb/M6nLcCVM4AsBI2xUqENClyS1KKoUZJjcZJnzk6V3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXxm8UmC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXxm8UmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787831944; x=1819367944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kS6ytQQ6q0R74tYQWG1swwo5Vl/KkrJwJ0Lbu9SeWr0=;
  b=fXxm8UmCOJjikB4CQgX60TZ9DrE8fF+KByk5mGXZb4lQPufXBRKX0OzG
   Pr6QzPdMmyXvlAt49yBjWsew0Wu8ueNsH9Vj5DjzobjgDP5zoaYaf03ed
   mC7HeZVi0X2hciEOIaj19MXffpcCmbPO5w4yje7x/xKRovnfjM8vlg0wp
   fhKuT7UteqGkbneSqJzFqoyM3ryS3pc7knmEO5VmnCDn3vkOuXjrdTyi5
   xsb1lix+XbVEF1Ewyj3Lntspq5KNd4EM/1RRl6iW/xcS9aXh7FTCSwmZq
   NM6vU6kvnpHJ4SfbntOnlghu+x15EN1VxA4K+iOqbFzCSKMD2kkffp4OW
   w==;
X-CSE-ConnectionGUID: s853uiIjRNGnscEeH8oc1Q==
X-CSE-MsgGUID: eigDddPMSsOS/ElNwoRs6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88382318"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88382318"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:59:04 -0700
X-CSE-ConnectionGUID: xwCZYXx4TjGvtCtC7qxaVA==
X-CSE-MsgGUID: wwG9ts2ORV2UamLTP5AZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="269801642"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:59:01 -0700
Message-ID: <37003be3-82a1-4417-96fe-26a37fa36335@intel.com>
Date: Thu, 27 Aug 2026 19:58:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] KVM: VMX: Use dummy pseudo-overlay struct for
 to_vt() and vt_to_vcpu()
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-7-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Define a combined vcpu_vmx_tdx structure to represent the common layout of
> vcpu_vmx and vcpu_tdx, instead of having vcpu_tdx piggyback vcpu_vmx.  I.e.
> require VMX and TDX to match the common definition, not for TDX to match
> VMX.  This will allow moving to_vt() and vt_to_vcpu() to common.h where
> they belong.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
