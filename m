Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD25274670;
	Sun,  6 Sep 2026 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661481; cv=none; b=J4kLL7eKrLlLmwoBpLoKW9Koc4Fs3OLGTnFaPjYi92InFLLCRGCKToF1qcBGEJVhneyh4vlqvuacw91lkn8OoSy3R1k7b6wpI5Lq7aDwz0eVIOln89b1E9PghXNTPwruVZqX3GMoDUvSqBui6exqGrfAL0Nr/lrRF5b4/lQLsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661481; c=relaxed/simple;
	bh=r/VZTjJO5GS7lw0uLWOlkPH65LWQCrZPfv0NwJNnGIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOxR1QnDQK0/C74jUBTWLHnB3xXoSAQ5RtI2h/ObmYICnwqdzY2gGV+EAVLZr9BMDx2IYLZNMrPk2JBx9BgzyB76CEaeOYWxKTi8G0faABOwYgTW5fOUTnZOetzGZgEOLn/grzAwEh1FGVUjTsXUFE0IaYY0cdZe7ouQooJFTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3617381|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.148656-0.0014093-0.849934;FP=16441498516227483405|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j6i0n.R_1788661467;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j6i0n.R_1788661467 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 10:24:28 +0800
Message-ID: <38bac307-e0c5-4a93-98c6-140b1c52d41d@open-hieco.net>
Date: Sun, 6 Sep 2026 10:24:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-3-zhang_wei@open-hieco.net>
 <CALMp9eSmrHdLpOi9-xQvcRUxyVN-8CG2MKWnxKfXFaBBDztzNg@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eSmrHdLpOi9-xQvcRUxyVN-8CG2MKWnxKfXFaBBDztzNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/2026 7:07 AM, Jim Mattson wrote:
> On Mon, Aug 24, 2026 at 5:40 AM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> +
>> +       vmcb->control.exit_info_1 = exit_info_1;
>> +       vmcb->control.exit_info_2 = 0;
>> +}
> 
> Can this entire function be integrated into the existing switch
> statement in svm_check_intercept()?

Yes, that makes sense.

> 
> And, if !guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS), should
> exit_info_1 be cleared for these intercepts?

My reading is that exit_info_1 is undefined for these intercepts when 
DecodeAssists is not exposed, and KVM previously left it untouched. I 
would therefore prefer to preserve the existing behavior and update 
exit_info_1 only when DecodeAssists is exposed. That said, do you see 
any reason why KVM should explicitly clear exit_info_1 when 
guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS) returns false?


Thanks,
Tina

