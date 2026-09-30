Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAD349CF3;
	Wed, 30 Sep 2026 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744500; cv=none; b=amPnXJL5yezTwkOy4G5M/7YYFnfbSjlNlGWHXtUUegXRdp56Jrwjdyxfp27s2cL1jqJSZRDEF1Xzs3z/fMYY93fzhHIKFGRX6b/IJ6uNJH8/EtKWTgqpdmDvjq5pUeeOXI8+Ag77SlOdXx6+ybDPnDVU8uPR/znC3W2dYSTwVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744500; c=relaxed/simple;
	bh=aUKwU2DWc7V5Su7nqtW4pZQu87wWCIMqHJeLprSBsvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjX7en5yBP5Y7G9SAsH0tMss994zGMmtsewrFfX4JTOZYybWAZj9C4vwQiNE2QAidomS8yJh49ulqVvEUh2rSCl8XwK3WBeKwv3Z0t4D/BY/AWbiMk9yunDrZgHdcqTU3bVw7O/p4gjOknApUc2STwlK8BkInVGhJUXebnkN0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJZ0P16U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJZ0P16U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790744496; x=1822280496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aUKwU2DWc7V5Su7nqtW4pZQu87wWCIMqHJeLprSBsvM=;
  b=aJZ0P16U9w4Jqwq7Oh8RTrqpH7+mhVmH9wB9FQmCVRAZq/BOpgqLhpRU
   ym6diCt4HztcicaTHVbjJBFnHNKYWydmbkdNpmKT+F4vKSQ3Mncp0+czK
   7B1Z5GmbAWCSCD9Kl55+XY21xo+2makzFzmfFHMoD9Zmrrrv2STzgiPgZ
   cnW+JksIqu2lJyuhXcqTJ1kxx7vYFbxH6dDeOpOSeWtOmFik/thH+E4n7
   WGD/gWd5S0IGQmwNs77cCwaXaIKB0lmg/vaopmqywcYrvmBt+SeFSDPZe
   AFK931UamnlAWTlbqQBHh+kirj+X2UXxRoe/CY2Kf/bn18xn7vLOC3yYN
   Q==;
X-CSE-ConnectionGUID: qeVQs3CFR+m3wtvleo/9WA==
X-CSE-MsgGUID: R85fkf2eSGmwTJMHYdSBbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91572138"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="91572138"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:01:35 -0700
X-CSE-ConnectionGUID: JFZwRH4+S+a5LPH6hoF1qg==
X-CSE-MsgGUID: QS/qow+DQM+CCI41419sUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274186761"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:01:32 -0700
Message-ID: <2e6e9a97-e3f2-4978-93f4-bf6224b7a06d@linux.intel.com>
Date: Wed, 30 Sep 2026 13:01:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: TDX: Ratelimit the "EPT Violation on pending
 acceptance page" warning
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Sashiko Bot <sashiko-bot@kernel.org>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260930001127.3170009-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/2026 8:11 AM, Sean Christopherson wrote:
> Ratelimit TDX's kernel logging when a guest accesses an unaccepted page and
> has opted to disable EPT Violation #VEs for unaccepted accesses, as the
> pr_warn() is trivial for a misbehaving userspace to trigger.
> 
> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260923164348.2DB2D1F000FF@smtp.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Nit: should this patch be put before patch 2, to avoid a bisect window?

Otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/vmx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index e3723f1222fc..4cac43299851 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1937,8 +1937,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>  
>  	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
> -			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
> -				gpa, vcpu->vcpu_id);
> +			pr_warn_ratelimited("Guest access before accepting 0x%llx on vCPU %d\n",
> +					    gpa, vcpu->vcpu_id);
>  			kvm_prepare_shutdown_exit(vcpu);
>  			return 0;
>  		}

