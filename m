Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D725D1E9;
	Sun,  6 Sep 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788656248; cv=none; b=k9x7dWA+GBnrjjqpy4/l4P+f7znpirZ6Nzd/t5DeYmAty9AYa1RbeFSjgbz1XnVqgxmsPcMwlxyPQ4pAqBoQLGtHJnvNaM684UCjKEM8S0xYdLxODpsuh4t4o8ffAzNJq98GbzkEPa4748VCTUxTaMY13XfPhi7agbViJZz9TmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788656248; c=relaxed/simple;
	bh=LpkrOOoV/9gd8nAX6hvbIqWRO7Ing9NTDjQtexKO5go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io4VsdNTRvECgHl7cELpvPoKc3z9RIUiXwKlvJObH9+R6PsZ1arzR/r4602r4OOX42Tnn/UA1lmNkPdpXCZFPFIeZBKITKz5TuOw2Px/3Dfco2KB6zhGf4Nu8+RaMPLjD9+fe0TrWRDl58hXGJjKwNa4svIXnO6ZlV9j/G63OpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1487297|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.295341-0.000320889-0.704339;FP=16959285472497698039|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j6cBMnL_1788656234;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j6cBMnL_1788656234 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 08:57:15 +0800
Message-ID: <3c8921d1-df09-4bd7-9f66-4747ea331f3d@open-hieco.net>
Date: Sun, 6 Sep 2026 08:57:13 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] KVM: x86: Add helper to provide intercept linear
 addresses
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-2-zhang_wei@open-hieco.net>
 <CALMp9eQoMn5BxXfu9ut5EZVGipfiZzbQz32mpi3TCjA6fA7jCw@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eQoMn5BxXfu9ut5EZVGipfiZzbQz32mpi3TCjA6fA7jCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/2026 6:34 AM, Jim Mattson wrote:
>> +static u64 get_intercept_linear_addr(struct x86_emulate_ctxt *ctxt,
>> +                                    enum x86_intercept intercept)
>> +{
>> +       u64 la;
>> +
>> +       if (intercept != x86_intercept_invlpg)
>> +               return 0;
>> +
>> +       la = seg_base(ctxt, ctxt->src.addr.mem.seg) + ctxt->src.addr.mem.ea;
>> +       return ctxt->mode == X86EMUL_MODE_PROT64 ? la : (u32)la;
>> +}
> 
> The linear address calculation here is replicated from __linearize().
> Perhaps something like:
> static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt)
> {
>          unsigned int max_size;
>          ulong linear;
> 
>          if (intercept != x86_intercept_invlpg)
>                  return 0;
> 
>          __linearize(ctxt, ctxt->src.addr.mem, &max_size, 1,
> ctxt->mode, &linear, X86EMUL_F_INVLPG);
>          return linear;
> }

I initially used the minimal calculation needed for EXITINFO1 because I 
thought some of the additional processing in __linearize() was 
unnecessary when reporting the linear address to L1.  However, reusing 
__linearize() keeps the intercepted path consistent with em_invlpg().  I 
will switch to __linearize() with X86EMUL_F_INVLPG.


> 
>>   static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>>                                      enum x86_intercept intercept,
>>                                      enum x86_intercept_stage stage)
>> @@ -427,6 +447,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>>                  .src_type   = ctxt->src.type,
>>                  .dst_type   = ctxt->dst.type,
>>                  .ad_bytes   = ctxt->ad_bytes,
>> +               .intercept_linear_addr = get_intercept_linear_addr(ctxt, intercept),
> 
> Maybe:
> +               .invlpg_linear_addr = get_invlpg_linear_addr(ctxt, intercept),

Yes, this is clearer.


Thanks,
Tina

