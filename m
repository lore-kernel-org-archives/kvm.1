Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF42F5337;
	Thu,  9 Apr 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719127; cv=none; b=LU6+scf0eQ58rwgHnaXz5tLSh/1fnpP4NraIDRdEOmubDu17vNyIbzr16WlIzkgfEf0365yKQS2VcwBjHwJ35f784GGn0K1z6/GhapTjKJ2NAD7TbKTfLpexWkLQMfEUFz5nYhoHIaFNmrV/vv0+TVyRdXhgIyOOA/nOShocq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719127; c=relaxed/simple;
	bh=yegpaodOIBBHPD7/HgECu/lOXWmpryrfdEmeCOgAXYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCSr1FiQEXjX8GtpRlvw6iCDGp/Jjz6Q8nrNPbZ1gitxYlrwlgmyS1AiEbOYOCmByvNgiUWFLKlPcsIKTSPd250HVfg8y2LgZOrYxfRkwML2n/nOjcXsuhdtBnnpRFY0pDCHWe/mxdcfftPBLRdXEathaDJcHbwqJg+kqgDi9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huXOqPVd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huXOqPVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775719126; x=1807255126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yegpaodOIBBHPD7/HgECu/lOXWmpryrfdEmeCOgAXYw=;
  b=huXOqPVd17+xd1pJnz/vO5Wh9Lzg03+ebrFaLib6p1dyEcxUaoXjgv14
   SH1EihzP9sGyzbnc/De+Pmho/XcaV46/1UhOR9D4KuD88vRPFSpHvPs8O
   FhU/KLH6kwS9CiRrUpWcFt+nQcZkNFL/6C7iUnyiC/B4VgNUIaC1YNla8
   Boftn/Cop7EenJv2v9WffjMTU5Ytb8c7yDpBoh9G9rOJbY8wX3Wa0ES2i
   gZIvJPmgIRg6TMWmqHfGsvPGVSCwjTPweMPhislwQIIUD//cUCkiMrfAV
   OEIGKkhc12zu4nLVRPWtEz/S377YS4FVOmVKniMnnHEGmQMsvLlXYbgHp
   g==;
X-CSE-ConnectionGUID: 2WwmcOrATiyrZ6ObIPttCw==
X-CSE-MsgGUID: BTK9UFFBTYa9HMS5Cv2unA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99342898"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99342898"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:18:45 -0700
X-CSE-ConnectionGUID: Jq13MwepQPyNiRWRNgjUbw==
X-CSE-MsgGUID: yNtTdR6IS8GrGVkNl0BpHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="223943836"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:18:31 -0700
Message-ID: <b68ce99f-80a3-46a9-bb49-c0a803fb6b0f@linux.intel.com>
Date: Thu, 9 Apr 2026 15:18:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: x86: Don't leave APF half-enabled on bad APF
 data GPA
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
 Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
References: <20260406225359.1245490-1-seanjc@google.com>
 <20260406225359.1245490-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260406225359.1245490-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/2026 6:53 AM, Sean Christopherson wrote:
> From: Ethan Yang <ethan.yang.kernel@gmail.com>
> 
> kvm_pv_enable_async_pf() updates vcpu->arch.apf.msr_en_val before
> initializing the APF data gfn_to_hva cache. If userspace provides an
> invalid GPA, kvm_gfn_to_hva_cache_init() fails, but msr_en_val stays
> enabled and leaves APF state half-initialized.
> 
> Later APF paths can then try to use the empty cache and trigger
> WARN_ON() in kvm_read_guest_offset_cached().
> 
> Determine the new APF enabled state from the incoming MSR value, do cache
> initialization first on the enable path, and commit msr_en_val only after
> successful initialization. Keep the disable path behavior unchanged.
> 
> Reported-by: syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4
> Fixes: 344d9588a9df ("KVM: Add PV MSR to enable asynchronous page faults delivery.")
> Link: https://lore.kernel.org/r/aHfD3MczrDpzDX9O@google.com
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Ethan Yang <ethan.yang.kernel@gmail.com>
> [sean: don't bother with a local "enable" variable]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


