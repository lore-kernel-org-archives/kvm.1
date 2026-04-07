Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3E1DFDE;
	Tue,  7 Apr 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570465; cv=none; b=gAcEUIl5qxzsVmUCMBFmBuCwdo1DkcW35Qc9fF72p8p4m8aJjmkH7Lj9LmzOFeNM01vCQ+k9+uBZeECSk+FW3oqgEQzTB7Y8vhda0usGN7zaiFTQ6De49SVadGxWJUrV5DR1F2yNy8hcx1kUDOme8z7cLI1/VhjnKFIBdJnoNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570465; c=relaxed/simple;
	bh=kJ0GCS70vO/MZssoToy89qES7JzGaNQ4wgCV3eoQDFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRh51YP5Uz+K2a06MaWFKK5hOPBRK93ZwiU+AV0ZV/30rFXHAbZITOhPDwwwcjEstUUXl7d3oGgw5r6NLHBXd9nstZV6VWsGPrjj83L0L/fylhQGSYYEXPLRg6etjdOlZuiXleD1COIyBgNJ35QwVBDWr06w7PI1f7maYLc8T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEzCjjsX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEzCjjsX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775570464; x=1807106464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kJ0GCS70vO/MZssoToy89qES7JzGaNQ4wgCV3eoQDFQ=;
  b=nEzCjjsXnE79uVRo8eIOLqq+WG9O1rBGc+YVEI7JvOnTK+bk82gsZNvb
   OK3myHeYzi3/zgFKLyBy2H1jAPEG9/LoJ/UGDyeEnL1dt4YusnK5Wen1s
   4YqSnxvANps8F56KEEZufWpMwweuCeZrsc1kknhmcXpy2Bt/cORRnwWRT
   TcWLslLz7Q8ZTyN3cEChtHVpZdm6UNbL6QKDEq8mlSZpfzEyBM6oEKu7f
   u8IHOJN6Cw0G26Sp684vE1s/m8K0eBPFkzSUPPX5Z3oONwVwsZMBQ7sE5
   DoEFI9lqykiISE5zYC0V+1hCPaqDdNqHAY180SR0lTQ0FNrDzzg1sNUae
   Q==;
X-CSE-ConnectionGUID: 2o2KanJ5QMeZxRip6v5oVw==
X-CSE-MsgGUID: jzMDXHPVSZmienOTwRrM8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76546117"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76546117"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:01:04 -0700
X-CSE-ConnectionGUID: ZccumsKvSnG+5ejUjzXtuQ==
X-CSE-MsgGUID: WuNUUB9qS3aqPaA83tZLwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223387596"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.241.144]) ([10.124.241.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:01:02 -0700
Message-ID: <8799eb07-0641-402f-a856-eb1ac3098df9@intel.com>
Date: Tue, 7 Apr 2026 22:00:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] KVM: x86: Drop superfluous caching of
 KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
 Ethan Yang <ethan.yang.kernel@gmail.com>
References: <20260406225359.1245490-1-seanjc@google.com>
 <20260406225359.1245490-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260406225359.1245490-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2026 6:53 AM, Sean Christopherson wrote:
> Drop kvm_vcpu_arch.delivery_as_pf_vmexit and instead use msr_en_val as the
> source of truth to reduce the probability of operating on stale data.  This
> fixes flaws where KVM fails to update delivery_as_pf_vmexit when APF is
> explicitly disabled by the guest or implicitly disabled by KVM on INIT.
> Absent other bugs, the flaws are benign as KVM *shouldn't* consume
> delivery_as_pf_vmexit when PV APF support is disabled.
> 
> Simply delete the field, as there's zero benefit to maintaining a separate
> "cache" of the state.
> 
> Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

