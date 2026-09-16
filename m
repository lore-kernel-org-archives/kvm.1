Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F345000;
	Wed, 16 Sep 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518684; cv=none; b=kX5YT7OeE8VDqqJxzYP6HVvV5xZVbYyL0uSd7c6olHDYexsbzzM8aNwGIGjq+9+1z0R9RyIPyiWR3JRXhSTnkhZ5OtLa4iS3V4w1lCoJx6XNCimyOnvnYTfMhi7JlZzkD6vcl3RAFQjnbYPyuOwfRGqxeooetYnH9LhWmAjggPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518684; c=relaxed/simple;
	bh=kCxwuC7dMHYQ4sYN/7/iFSsHj/IK2Vos6fZU6YhqjNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMkh1yb39mgy59BhOZnjLQV7j20H7nQgS7FYrLkn7xtLdlTf8ouQa1aCrjkNIMjUC5/zrmo7bV8u7/1oAHwlhCucukN6NgGhCShIQeI8b4A25hcODnFz76lmpKUf1Yw6BeeylXo+FtRVEeUaU3vebn5BXofDZdXMZB/sXcXL13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09281327|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0524633-0.000200874-0.947336;FP=17182777707830527215|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jEZ0uKj_1789518354;
Received: from 172.19.20.178(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jEZ0uKj_1789518354 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 08:25:56 +0800
Message-ID: <3451f275-d88d-4db9-acb9-ca80d717df7a@open-hieco.net>
Date: Wed, 16 Sep 2026 08:25:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] KVM: x86: Provide INVLPG linear address to
 intercept handlers
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1789281096.git.zhang_wei@open-hieco.net>
 <fc88f299f41c99ddb5851c24d97970dc29584876.1789281096.git.zhang_wei@open-hieco.net>
 <CALMp9eSv77sBcfYpPJm4Uk+9CePV7YMdYXhvBHKHSvacnnRBUA@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eSv77sBcfYpPJm4Uk+9CePV7YMdYXhvBHKHSvacnnRBUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/15/2026 2:23 AM, Jim Mattson wrote:
> On Sat, Sep 12, 2026 at 11:44 PM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>> INVLPG's memory operand is decoded with NoAccess, and thus src_val does
>> not contain the operand address.  Intercept handlers therefore cannot
>> construct exit state that reports the linear address from the existing
>> x86_instruction_info fields.
>>
>> Add get_invlpg_linear_addr() to compute the address through __linearize(),
>> using the same flags as em_invlpg(), and pass the result through
>> x86_instruction_info.
>>
>> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
>> ---
>>   arch/x86/kvm/emulate.c     | 18 ++++++++++++++++++
>>   arch/x86/kvm/kvm_emulate.h |  1 +
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index 8071b372d233..1dfece6af81e 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -410,6 +410,9 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
>>          _fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
>>   })
>>
>> +static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
>> +                                 enum x86_intercept intercept);
>> +
> Nit: I would move __linearize() rather than add a forward declaration,
> but maybe it all unravels if you pull on that thread.
> 
>>   static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>>                                      enum x86_intercept intercept,
>>                                      enum x86_intercept_stage stage)
>> @@ -427,6 +430,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>>                  .src_type   = ctxt->src.type,
>>                  .dst_type   = ctxt->dst.type,
>>                  .ad_bytes   = ctxt->ad_bytes,
>> +               .invlpg_linear_addr = get_invlpg_linear_addr(ctxt, intercept),
>>                  .rip        = ctxt->eip,
>>                  .next_rip   = ctxt->_eip,
>>          };
>> @@ -702,6 +706,20 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
>>                  return emulate_gp(ctxt, 0);
>>   }
>>
>> +static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
>> +                                 enum x86_intercept intercept)
>> +{
>> +       unsigned int max_size;
>> +       unsigned long linear = 0;
>> +
>> +       if (intercept != x86_intercept_invlpg)
>> +               return 0;
>> +
>> +       __linearize(ctxt, ctxt->src.addr.mem, &max_size, 1, ctxt->mode,
>> +                   &linear, X86EMUL_F_INVLPG);
> 
> What if __linearize() fails?

This was also my concern with using __linearize() in v5, which is why I 
initially calculated the address directly. I wasn't sure how to handle 
its failures when we only need the address for EXITINFO1.

Simply propagating the error seems questionable, since em_invlpg() 
itself skips the invalidation on failure and returns X86EMUL_CONTINUE.

Would either of these approaches make sense?
Option 1: Factor the address calculation out into a helper shared by
__linearize() and get_invlpg_linear_addr(), leaving the checks in
__linearize().

Option 2: Extend the existing flags argument to __linearize() with an 
option to calculate the address without performing access checks.

Both would avoid duplicating the address calculation or modifying
ctxt->exception just to obtain the address for EXITINFO1.

Do you have a preference, or another approach in mind?

Thanks,
Tina


