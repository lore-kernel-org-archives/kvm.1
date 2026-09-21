Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112414A5EB9;
	Mon, 21 Sep 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001880; cv=none; b=bzoK26nt9YrnDJaJlHzkIoBTzURxTdVSxs/FwsHr1oc5feezNdx3I+xIiLu10fgMh2ddrX+Wdhxlsz+81b0+3OsRnJrfe7WOyVQGQbLXXbXQ7hgxc6RKX1o3Tj6ZLtxtyNNgv+E8AZwnZxMcm80HIVMI4BufetD8YNO0g5I0aUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001880; c=relaxed/simple;
	bh=qm23bpznxQLyH0ApgbQLKOknX+sH9kLWTPAQwoHf1Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVccXwdYpmSI/g9ndYgwt4kXcLOvrg+hGLD20ggeshtYD/GXIWJenldO9uWJsafSFDfoS7oUEPfHRv/WKv79DY+7mOMcArvEtBrjZ41+tTZf/etjacgExRBXTHSFKSb5vJwp3jsQ9jdd3jXaBr2gx7RcgBkyNdtwbgljZQRb6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrXpfX+p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrXpfX+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790001878; x=1821537878;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qm23bpznxQLyH0ApgbQLKOknX+sH9kLWTPAQwoHf1Sg=;
  b=WrXpfX+pq6vYYhsEm9KyayYGtQiXwvAMQKC3uhuWKvuLx8dY42cC8Fvg
   VRfDkXdUh2YprK9zhz6n2rH79kJaINZx/ZzK2GuvucllkHyh/ZKOngJOr
   kkitLjY/XeO3pU9iSztff6Uya1NJmqQ4/7fhJOX+25vrVPIrh4SiGPZ77
   Q0Y9wrTpakfrq5JIY1O0AoDWxJ8WYeyn+bNoz6kZHS4eXdtCKHKWbRktq
   E0m5xx/nbnr5xRIbC1NTr1C4bBJUqJ3F7qydnumuPAIqnlzR/1o4geoSJ
   0GjqD77upk6ba0Vi3ROnYYDw/D2kjRN38foYHmy6O+gCPsYN49Ic5RAKL
   w==;
X-CSE-ConnectionGUID: sGku6yB5QBOvKBQ6+5rD2A==
X-CSE-MsgGUID: v0bsjKroRT6BGM7Eu3wxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93015651"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="93015651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:44:37 -0700
X-CSE-ConnectionGUID: CkAo1t1aSB+6+zvPprEOmg==
X-CSE-MsgGUID: ShhbAn0zSkaG5lxzbTluEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="280728553"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:44:35 -0700
Message-ID: <6d9113d7-cfae-480b-908a-5cb52020a6c8@intel.com>
Date: Mon, 21 Sep 2026 22:44:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for
 TDX
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 nik.borisov@suse.com
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/2026 5:48 PM, Xiaoyao Li wrote:
> Hi all,
> 
> This is v4 of the series to enable the Notify VM Exit and Bus Lock VM
> exit for TDX, which fixes the KVM CAP issue related with them and allow
> userspace to actually enable the features.
> 
> Compared to v3, this v4 adds 5 more patches.  The first 8 patches target
> for stable kernels while only the patch 9 doesn't have to.  Patch 1 is a
> single patch to enable Notify VM exit for TDX.  Except patch 6, patch
> 2-7 are mandatory for enabling Bus Lock VM exit for TDX in patch 8.
> 
> Patch 6 itself is a fix for VMX and is OK for cc stable though maybe not
> necessary.  Patch 6 is added to this series since it can help stop Sashiko
> repeating its finding of VMX's pre-existing issue, and it's also necessary
> for patch 9 to consilidate the exit handler for VMX and TDX.
> 
> There are other issues of existing code found during previous review, like
> the EPT MISCONFIG handling.  Given they are not mandatory for enabling the
> Notify VM exit and Bus Lock VM exit for TDX, the plan is to address them in
> a follow-up series separately.
> 
> Please refer to v1 for a full background.
> 
> v3: https://lore.kernel.org/all/20260812080229.2481439-1-xiaoyao.li@intel.com/
> v2: https://lore.kernel.org/all/20260810112200.2326727-1-xiaoyao.li@intel.com/
> v1: https://lore.kernel.org/all/20260805031257.1844914-1-xiaoyao.li@intel.com/

Hi Sean,

What's your plan on this series? Can you queue it if it looks good to you? Or
need me to spin a new version to address Binbin and Rick's comments on the
commit message?

Thanks,
-Xiayao
