Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54B342510;
	Sun, 20 Sep 2026 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866743; cv=none; b=tI0e3VoDn0zV90JUH+haR8dWwXMb8wtrOqtg7BEqBltgnBob6Qp4qXI9FF6lkLsCofSzBNdruFbNWvjVdoZvA5m6i14SCukR2X2i6OIR7g7pJDu8Tgz2f+dmwsbm0a8D9FOexnS+FQTBx16ZjE/APoTRb3CU4PFc3/Xs/AyJ0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866743; c=relaxed/simple;
	bh=Vi2TEmlrT2sU/jz1u4mJKXT8twlyCdRxU6LegCVKyEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4roM1PWNYd5yYJ99JMwvq3JkaFHL5EV/FXoZNrmJp8/Vy6u7kcVb4LbtleBYm1htg4pFkWR+YeJ3OglrbPtEOLDjd3X659ZAnAgsBnddIIdYe1hm/CzhmVEYEvqbmcP73+a9wt0WWs0ewdRb66KP5HTfELWJn2ifGk1zROGRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCxGm8JR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCxGm8JR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789866740; x=1821402740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vi2TEmlrT2sU/jz1u4mJKXT8twlyCdRxU6LegCVKyEo=;
  b=iCxGm8JRgKihFyll9sk2JkTK4csQXMnejsRW1xC4anLLQAHeHbfnG9lz
   VekqzFLYaD82SSX1UTHP+WbJJCr81UbO/hnSiEbWzK0FCfrjAXc8iwBEX
   D+4HPAZovQrPalvTPhAW0vC3v8SluFCVIGilDA4gt2aQ1+BPEKXT54W6s
   fUkbfqXS+MTvlmZqiVgfdjrITK8V7HZTYLPz1qX+e4Ga4sckys0MOsw7n
   5XL+3y2A9xSVOS4THDdLXh55sHnoDPtypnY3Oa+xzZw3qDzc/DyK6jKPg
   g0Kg0XMISSzBDzMBFtM8mFfcLoMyegN6uUfb8Lx62BmLpD1mnmLKat3u9
   g==;
X-CSE-ConnectionGUID: MzfJtfgSSNGdTkmIRbylOQ==
X-CSE-MsgGUID: bSoXOhC5Q7ORRLdR91aSfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="90246257"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="90246257"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 18:12:19 -0700
X-CSE-ConnectionGUID: vdEm01clRZWxfJWzl0CbPw==
X-CSE-MsgGUID: oHLJuQchTESrtdldG+UxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3165056"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 18:12:18 -0700
Message-ID: <6d3d2d97-82ed-4cb3-8a76-e8bcac57f6ea@linux.intel.com>
Date: Sun, 20 Sep 2026 09:12:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Remove always true ifdef
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260826100321.1309685-1-nik.borisov@suse.com>
 <b519578d-60fb-4248-88eb-05bb9474762f@suse.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <b519578d-60fb-4248-88eb-05bb9474762f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/2026 7:36 PM, Nikolay Borisov wrote:
> 
> 
> On 26.08.26 г. 13:03 ч., Nikolay Borisov wrote:
>> CONFIG_KVM_INTEL_TDX depends on KVM_TDX_HOST, which in turn depends on
>> CONFIG_X86_64. So it's guaranteed that any code under ifdef
>> CONFIG_KVM_INTEL_TDX is also running under CONFIG_X86_64 being true,
>> remove pointless ifdef guard.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> 
> Gentle ping.

BTW, I find the patch has been applied to kvm-x86 next branch already.

> 
> 
>> ---
>>   arch/x86/kvm/vmx/main.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
>> index f204a0fc0a57..e9cca303c855 100644
>> --- a/arch/x86/kvm/vmx/main.c
>> +++ b/arch/x86/kvm/vmx/main.c
>> @@ -799,7 +799,6 @@ static void vt_write_tsc_multiplier(struct kvm_vcpu *vcpu)
>>       vmx_write_tsc_multiplier(vcpu);
>>   }
>>   -#ifdef CONFIG_X86_64
>>   static int vt_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
>>                     bool *expired)
>>   {
>> @@ -818,7 +817,6 @@ static void vt_cancel_hv_timer(struct kvm_vcpu *vcpu)
>>         vmx_cancel_hv_timer(vcpu);
>>   }
>> -#endif
>>     static void vt_setup_mce(struct kvm_vcpu *vcpu)
>>   {
> 

