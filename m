Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB73A6B9A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482519; cv=none; b=PGn/7bwfu8UsbIUW1MntjgzzCaW5VFeHSY4/n+1axfymDENd+lgypb+eO2TGAH9rgKG2xJdwYZJrQRWm3lav+uGgpjp6CD2XjXeNnjr2Tk4jCOB14tn8eY664Z781Orq3Xgqm/slhRvkK01BlvJ6dpgC1CZ9QlbRihn2qcH/9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482519; c=relaxed/simple;
	bh=tYnyno8ORy37n0jY2memjbIWsmgQrZQUlonD0QoPVjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIGZZPZ1uWF0immcmm+6F0eLsDH6rpmaLYe/8Xupzfi6JJUcItrrKmu8Zh/XwWtWLkDl2rMsUbxH2rqCQDuP7LFmQ79mAopr1UfZFGZl5m9A/T8UnT5d/OI816km+r+z3wX5yA3cQ6FBPxoUe73SGOKUIpBMKnDzn2B4BBlpaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08424093|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0166486-0.00529842-0.978053;FP=2869144909575110999|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.ia3Fx5Z_1785482500;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ia3Fx5Z_1785482500 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 15:21:41 +0800
Message-ID: <ac3191b2-daee-40d7-8a26-51ac9fca2c5a@open-hieco.net>
Date: Fri, 31 Jul 2026 15:21:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] target/i386/kvm: Use AMD MCE status encoding for
 Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-5-zhang_wei@open-hieco.net>
 <amxJf2elltpmBHFD@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <amxJf2elltpmBHFD@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/2026 3:06 PM, Zhao Liu wrote:
>> +/*
>> + * Use AMD-style MCE status records for QEMU-injected memory failures on
>> + * AMD and Hygon CPUs.
>> + */
>> +static bool kvm_mce_inject_uses_amd_status(const CPUX86State *env)
>> +{
>> +    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
>> +}
>> +
>>   static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>>   {
>>       CPUState *cs = CPU(cpu);
>> @@ -707,7 +716,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>>       uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
>>       int flags = 0;
>>   
>> -    if (!IS_AMD_CPU(env)) {
>> +    if (!kvm_mce_inject_uses_amd_status(env)) {
> 
> Maybe we can check hygon directly here?
Yes. Since there is only one user of this helper, keeping the check 
inline is clearer. I'll update it in the next version.


Thanks,
Tina

