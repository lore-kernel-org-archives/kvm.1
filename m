Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183710F0;
	Tue,  7 Jul 2026 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382522; cv=none; b=A5zuE7DoDRYr4j6gKN9jpm5EKt2LMjsudqNUUqGvEA3XD4FTJF54K1TChv6RojQOgQnpCJa8ryox2rIBzu5Lqcir/l5bbE9pl9VDEs3yR8J2nMY8oNqXRO+ZYwA52A/dvMe5hJ7/RDSWUPF16fB8JeKtaNwfBShoVY7c0pS/AYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382522; c=relaxed/simple;
	bh=AUjwQNUAEke7+mDDESKcFQnVghtxt8J15YiaN83WwRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWvwAW92HG783K8ayL4uWwE8pJ9zbxWJzUsNeTbNryrUThoSsnab5zXimo3Xfv8uLtji49L3elJPzTe8TdHicBPfs7hmAXwl1vQ4IIa0EEuGCq5sPg7O8eZbYWM8LlNY2Of7X5TifAKg2T9EFBXR8/UHZ0ljS5s3ipAFaAHdV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09217609|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0907494-0.00638481-0.902866;FP=7830629193968006575|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iEsDrXC_1783382515;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEsDrXC_1783382515 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 08:01:56 +0800
Message-ID: <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net>
Date: Tue, 7 Jul 2026 08:01:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: mlevitsk@redhat.com, Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/7/2026 6:10 AM, mlevitsk@redhat.com wrote:
> On Tue, 2026-06-30 at 08:52 -0700, Jim Mattson wrote:
>> On Mon, Jun 29, 2026 at 5:57 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>>
>>> The SVM DecodeAssists feature is reported in CPUID
>>> Fn8000_000A_EDX[7].  When available, hardware provides the length and bytes
>>> of the intercepted instruction in the VMCB, allowing a hypervisor to consume
>>> the decode information directly instead of re-decoding the instruction in
>>> software on relevant VM-Exit paths.
>>
>> DecodeAssists actually comprises four components:
>> * GPR number in EXITINFO1 for MOV-CR and MOV-DR VM-exits
>> * Software interrupt number in EXITINFO1 for INTn VM-exits
>> * Linear address in EXITINFO1 for INVLPG[A] VM-exits
>> * Guest instruction bytes and length in the VMCB for #NPF and #PF VM-exits
>>
>> You only partially address the last component.
>>
> Yes, and I also remember when I implemented some of the optional SVM features,
> I decided not to implement this, also because of the same reason - pass-through
> is easy but for all the emulated VM exits, it can be tricky to get that right.
Thanks Jim and Maxim for the comments.

Yes, that makes sense. This version only covers part of DecodeAssists. I 
didn't think enough about the other DecodeAssists pieces or the 
software-emulated/synthetic exit paths.

Since this patch advertises DecodeAssists to L1, L1 should get a 
reasonably complete and architecturally consistent view of the feature.

I will take another look for the next version and try to handle the 
remaining pieces properly, while also making sure we don't expose stale 
or incorrectly synthesized decode-assist state for emulated exits.

Thanks,
Tina

> 
> Best regards,
> 	Maxim Levitsky

