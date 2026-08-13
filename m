Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007373955CF
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610551; cv=none; b=rL5P27PZoz3+O733lq/s5sfwW9rYEwmQRrJvOSbpdJnMje17E78nr5g1DoDZHSiH8+FGDB7pPPFIihTyrSOvep7SydacHduUUoFIWihqvB2Im5xrcOi98hL8EGCtVLR4GylZa4vuycB0h/dI0Jdase6D2oEq1xhXsDFbPJpVa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610551; c=relaxed/simple;
	bh=0KAfdatrp5NmxkZzJ5tFT0z3k0Tiv9cuF3dydjmsMqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpMY6Cgp4jmiChpmtFHAJTC5zJb+DJbb5cSzqGnz1Yw696IdQAPrTZ5Z5NlGT640ZkiAJeDqAZPhgUlXae0kwUXUIee0qvo5cOdipvBA7QtbF1SSv5bmVTuqbSWDc5KZRUWMt3UxexeneASyPPvCao3m0F/CLRhgej9Ck5Uy4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVnouKPn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVnouKPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786610550; x=1818146550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0KAfdatrp5NmxkZzJ5tFT0z3k0Tiv9cuF3dydjmsMqY=;
  b=iVnouKPnomuTWxuFWfgoXqj4jzEMmebp6jfNNvKfaWlTx8C+5nyMZ85u
   M1F1Gfshoxfq0hFdmlYYk545XJ7urQWIgNINCak+Kaeh/VFDhIp5z4tun
   j36f/9gYWDn8Vh+swAi5aUud4CMJDiuIR6vzFAMYsm+c6nalMV3w4ygHC
   RDeLW9hca7e+jisex1gWtRGpOJxMpH2xwR3dNQm2ImW/pYlMAJm5D8Gna
   IpgAa71YaELzWZ7tSys2jZm9sqOmBm0M0HL0jdplBFl2YPkCIQrVUwxxw
   kcBdD94RyES29E6cEIEpVPOzIypD/Na+BgxYFp4WA8To9ICN6vPO9iPW7
   A==;
X-CSE-ConnectionGUID: sCo2S+j6RNqbl7f2itoUmw==
X-CSE-MsgGUID: ZaOo1dHZSZ+C6IJJqo9uIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87304167"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87304167"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:42:29 -0700
X-CSE-ConnectionGUID: tH3lincAQay6xn5uxQUj1w==
X-CSE-MsgGUID: 1X+jZ5p/SIer6l+YBXvTKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="264463501"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:42:28 -0700
Message-ID: <0e7524d5-8798-49fd-b8a8-9d7e5977f23c@intel.com>
Date: Thu, 13 Aug 2026 16:42:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com>
 <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
 <an0MdQKMHclUjW9r@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an0MdQKMHclUjW9r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/2026 8:14 AM, Sean Christopherson wrote:
> On Wed, Aug 12, 2026, Xiaoyao Li wrote:
>> On 8/12/2026 4:23 PM, sashiko-bot@kernel.org wrote:
>>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>> When the basic exit reason is set to TDX_INVALID_EXIT_REASON here, but upper
>>> bits like Bus Lock are preserved in exit_reason.full, does this break
>>> tdx_get_exit_info()?
>>>
>>> In tdx_get_exit_info(), it evaluates against the full 32-bit exit reason:
>>>
>>>       *reason = tdx->vt.exit_reason.full;
>>>       if (*reason != TDX_INVALID_EXIT_REASON) {
>>>           *info1 = vmx_get_exit_qual(vcpu);
>>>           ...
>>>
>>> Since TDX_INVALID_EXIT_REASON is the 16-bit 0xFFFF, this check will pass if
>>> any upper bits are set, even if the basic reason was marked invalid,
>>> incorrectly exposing meaningless hardware state.
>>
>> Oh, I should have called it out it's intentional to check the full 32 bits
>> Exit Reason instead of checking the lower 16 bits .basic field as what it
>> did in the v2.
> 
> Please wait for discussion to die down before sending new versions.  You sent
> this version literally the same day you responded to some of my comments on v2.
> Now the discussion is spread across different mail threads and I'm having to
> piece the converation together.
> 
> In short, spamming versions makes it harder to review, and thus slows the process
> down; it doesn't speed things up.

My apologies for this.
