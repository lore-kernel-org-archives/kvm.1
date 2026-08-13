Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9032ABCA
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612463; cv=none; b=tXJ9SzX2URGJ/r0OW3YzHl9DgxEPTKfS3+SzVICdrMVq+lYPxyTiMaskzGT/LlE/m5LOnS+etdsy9laZxpPUnm/UqwNHTS/bCIL1xdM3SZBkXhWvW/hbawmrk97gWqY9zpoHWpg07pQ9CmRrR5cbziVbk7szWPVMXxLYYdY6Igs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612463; c=relaxed/simple;
	bh=OWUMjswUzu4FIhnAXtgfD2CXxeLWa7HJ75JodK3l8r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlsgiI8fTS7X0G3OZovp/N3MHW8mhxFVRqnoBSV+2EFmsxtM2FSBYWN4RkQdViwnHl7zQDdwCQmfKqeIRlmSzlOIFepRLAYQ/5gxPJHAExztunWSCTKWEyp3y997z1aNOrJXmg2BNKajiADOevHMT3l4DoCA+CGmK+7BZiYnD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1259383|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00281212-7.93854e-05-0.997108;FP=5182439596747294178|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.ilDde5q_1786612449;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ilDde5q_1786612449 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Aug 2026 17:14:10 +0800
Message-ID: <f6ea6f1c-46e3-4853-b3a4-f2ae91442e56@open-hieco.net>
Date: Thu, 13 Aug 2026 17:14:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] KVM: nSVM: Advertise DecodeAssists to L1
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <29c2042af283e6d1a0b928b78d944b499153dace.1785411877.git.zhang_wei@open-hieco.net>
 <20260730123316.AC92B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260730123316.AC92B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2026 8:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing VENDOR_F(DECODEASSISTS) initialization in CPUID 0x8000000A leaf definition.
> --
> 
> --- Patch [8]: [PATCH v3 8/9] KVM: nSVM: Advertise DecodeAssists to L1 ---
> commit 2694559bd05c1133d7f21075f9c95dc19418651a
> Author: Tina Zhang <zhang_wei@open-hieco.net>
> 
> KVM: nSVM: Advertise DecodeAssists to L1
> 
> This patch advertises DecodeAssists to L1 guests by checking and setting
> the X86_FEATURE_DECODEASSISTS capability when supported by hardware. This
> enables QEMU configurations that enforce the decodeassists feature.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 6e2ceb700567c..4e01a6ede4246 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -5588,6 +5588,8 @@ static __init void svm_set_cpu_caps(void)
>>   		 */
>>   		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
>>   
>> +		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);
> 
> [Severity: Low]
> Does this feature also need to be initialized in arch/x86/kvm/cpuid.c?
> 
> Currently, kvm_cpu_cap_check_and_set() is used here to enable it, but
> VENDOR_F(DECODEASSISTS) appears to be missing from the CPUID_8000_000A_EDX
> capabilities array in cpuid.c:
> 
> arch/x86/kvm/cpuid.c:kvm_cpu_cap_init() {
>      /* All SVM features required additional vendor module enabling. */
>      kvm_cpu_cap_init(CPUID_8000_000A_EDX,
>          VENDOR_F(NPT),
>          VENDOR_F(VMCBCLEAN),
>          ...
> }
> 
> Without VENDOR_F(DECODEASSISTS), this skips KVM's standard compile-time
> validation and raw CPUID masking logic. Should it be added to the vendor
> feature list as well?

Yes, DecodeAssists should also be declared with VENDOR_F(DECODEASSISTS).
I'll add it in the next version.

Thanks,
Tina
> 
>> +
>>   		if (nrips)
>>   			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
>>
> 

