Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2058B6DC;
	Wed,  9 Sep 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963525; cv=none; b=FoqYTx9NNkVLd2egzCZR+ObJoc0PQQ6HLjaJTZDniXuRtaZqNpXaeO117KbZK/KQrojJ8xdPKw1EY4xqaU7E6MCcMfzoGJr7KwzIVuoxtE5XymrUH3g9Sv+DbfTUGqZQ4+qrb7tZa7BC1VtLakJOdu5m4AuUBKXaWMl5y3dGjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963525; c=relaxed/simple;
	bh=5RxqGiOqvxQ42jcI/R+4AhWh9zKUCWRV2YfnvhG+L/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWquvzG5r08hRpCH5X0245FRyurFw0zNUAnA1YiF3vyJVnAOPPTsqcmAm9Y1Rm8e3jylLMpFHbHTnydMfvKrN2msruUE1aO/+CX4B9CJ0r993WcQfyyEoF2vhhYJa/APH0gJLzrQA6S3SNW6/mbuDfNJzYt6OVHXWNnGPGIbLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPaHzul5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPaHzul5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788963525; x=1820499525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5RxqGiOqvxQ42jcI/R+4AhWh9zKUCWRV2YfnvhG+L/c=;
  b=MPaHzul5C0HeDNT1kj5sRt+OOJUbE2s+Uj55A0uA6mlChp5iYN2bFfSw
   homULyl0MEdoYOmtsIWBTkCLI9asWyaWuTMn392mN3gqa/aV93+NrgoXN
   F3XuJgCpjIRxttSwNIFl32jmxVdZy/LuFCIUrsKG8m90KVPHpKI0QPv9m
   9pN8sDofDYy0IFsqgshjQ0z4ZKCd+NXdIp8/LCL1ai5AEO/CkPHBhGY9I
   /hfVD1+eHRm4SgPHn6z4MTrnQVcRlFZKTyxBWPXh51Ge2LBkO8Kda7adx
   7v5WZ4rj49Ur160jhDMVmPpOhBlEGVUUsLPSKJpr22EjbYeWwpTYBIL2I
   g==;
X-CSE-ConnectionGUID: SSC5UvmFRm+kH75wxg/4Qw==
X-CSE-MsgGUID: TOkZO7lVSGui+5XTdpDS6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112166516"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="112166516"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:18:44 -0700
X-CSE-ConnectionGUID: lakSJqLdReqaVPUoH/cl7Q==
X-CSE-MsgGUID: oUo8Oar/TFmy1y6lxpTRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="269985528"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:18:42 -0700
Message-ID: <b456aa1a-43b9-4755-a13f-91ac0f4cb82d@intel.com>
Date: Wed, 9 Sep 2026 22:18:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup
 related code
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang
 <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260902230932.2760127-1-seanjc@google.com>
 <20260902230932.2760127-4-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260902230932.2760127-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 7:09 AM, Sean Christopherson wrote:
> Fold the GPA => GFN conversion and bitshift logic for identifying the S-bit
> given the EPT root level into tdx_set_mirror_root_level() to dedup the math
> and drop TDX_SHARED_BIT_PWL_{4,5} in the process.  In addition to deduping
> a small amount of code, using the level to compute the S-bit position more
> or less eliminates the risk of the mirror_root_level and gfn_direct_bits
> getting out of sync.
> 
> Opportunistically switch the sanity check in tdx_load_mmu_pgd() to check
> the mirror root level, not the S-Bit location, now that it's all but
> impossible for the two things to get out of sync.
> 
> For all intents and purposes, no functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
