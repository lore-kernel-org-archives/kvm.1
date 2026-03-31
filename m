Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E1399345
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952454; cv=none; b=hX0KZBl4ry2ODqnrkwg1Fs+cXSC2DAZod4neeEn1wg4wRBJxn59pY8UdflnLcQz/3iSJJyRqmmXwo8Vrnn/Z7YVM4v3DcgttJaBi010sVT1SJFpOE5ZiLNcVF4jAhHFoEkjrEXMUQ/QkE0Zvznxm+k9/srYa6cV9/2EeY+Lxgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952454; c=relaxed/simple;
	bh=B4JPY+GD72hLkcp17eDRaKvM8eIzcvfwPtz127IvXvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaedjG7oPUNWfWIZtfx1N5h8v4YKHC94Q73WMo0IyFfb78USekcW2lwxiS1fq3nL1ntjsGQK3FNI69lPd8Nk8XxSi76I18seYDLOJ7gaJymIXqONYtbpLCrfMaX9ofTM2jCKSOhjDH9sNsVt8V/aK/kXaigKLuu5XfMYqnv2K7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpnWSTKw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpnWSTKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774952451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pCXL+2IK3yKq0pjUbay1yh/At0kpulzJCUofbRTMB0A=;
	b=OpnWSTKwFXhpVHjH9QNH4MfOtJdqwMkmPHjnxPOBpTkqPqfTUPNgx98W14hanICmBzn9j8
	mxwuZe0EA5Kn51ESEv7YMsqN449yIIMRU8mbH3t9EMhtCBaHDDdpqDWSM8Kcae86h7oDhv
	j/arx5IdVQZ7xUM9wjqN1QQvJF220pk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-9k4bx3ydOliGEE5Bm2IoZg-1; Tue,
 31 Mar 2026 06:20:49 -0400
X-MC-Unique: 9k4bx3ydOliGEE5Bm2IoZg-1
X-Mimecast-MFC-AGG-ID: 9k4bx3ydOliGEE5Bm2IoZg_1774952448
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3FCE1956046;
	Tue, 31 Mar 2026 10:20:47 +0000 (UTC)
Received: from [10.44.33.100] (unknown [10.44.33.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43F25180036E;
	Tue, 31 Mar 2026 10:20:43 +0000 (UTC)
Message-ID: <7c2c8f49-5778-4b64-a54e-1ef0f5e24edb@redhat.com>
Date: Tue, 31 Mar 2026 12:20:41 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Add support for cmpxchg16b emulation
To: Sairaj Kodilkar <sarunkod@amd.com>,
 Sean Christopherson <seanjc@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, nikunj.dadhania@amd.com, Manali.Shukla@amd.com
References: <20260306102047.29760-1-sarunkod@amd.com>
 <aar082uQQhXKNiSQ@google.com>
 <d2cba245-8532-4f89-8a95-0661b4c3eb36@redhat.com>
 <99507d9b-c3be-4a77-8b84-79a30c7dd402@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <99507d9b-c3be-4a77-8b84-79a30c7dd402@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 3/31/26 11:28, Sairaj Kodilkar wrote:
> 
> 
> On 3/12/2026 5:16 PM, Paolo Bonzini wrote:
>> On 3/6/26 16:38, Sean Christopherson wrote:
>>>> -    if (ctxt->dst.bytes == 16)
>>>> +    /* Use of the REX.W prefix promotes operation to 128 bits */
>>>> +    if (ctxt->rex_bits & REX_W)
>>>
>>> Uh, yeah, and the caller specifically pivoted on this size.  I'm a-ok 
>>> with a
>>> sanity check, but it should be exactly that, e.g.
>>>
>>>     if (WARN_ON_ONCE(8 + (ctxt->rex_bits & REX_W) * 8 != ctxt- 
>>> >dst.bytes))
>>>         return X86EMUL_UNHANDLEABLE;
>>
>>
>>> And then emulator_cmpxchg_emulated() should be taught to do 
>>> cmpxchg16b itself:
>>>
>>>     /* guests cmpxchg8b have to be emulated atomically */
>>>     if (bytes > 8 || (bytes & (bytes - 1)))
>>>         goto emul_write;
>>>
>>> That might be a big lift, e.g. to get a 16-byte uaccess version.  If 
>>> it's
>>> unreasonably difficult, we should reject emulation of LOCK CMPXCHG16B.
>>
>> It's actually pretty easy because a kind soul already wrote the
>> cmpxchg8b version of the macros.  Compile-tested only (and checked
>> that the asm does have the instruction):
>>
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/ 
>> uaccess.h
>> index 3a7755c1a4410..f40e815263233 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -388,14 +388,13 @@ do {                                    \
>>          *_old = __old;                        \
>>      likely(success);                    })
>>
>> -#ifdef CONFIG_X86_32
>> -#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label) ({    \
>> +#define __try_cmpxchg8b_16b_user_asm(_b, _ptr, _pold, _new, label) 
>> ({    \
>>      bool success;                            \
>>      __typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);        \
>>      __typeof__(*(_ptr)) __old = *_old;                \
>>      __typeof__(*(_ptr)) __new = (_new);                \
>>      asm_goto_output("\n"                        \
>> -             "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"        \
>> +             "1: " LOCK_PREFIX "cmpxchg" #_b "b %[ptr]\n"    \
> 
> Hi Paolo,
> 
> I think its better to keep two implementations separate because this
> adds an additional complexity while passing the upper and lower half
> of the "_new"
> The cmpxchg8b expects ecx as "(u32)((u64)_new >> 32)" where as
> cmpxchg16b expects ecx as "(u64)((u128)_new >> 64)"

Yes, makes sense.  Either way, you have the existing 
__try_cmpxchg64_user_asm as a blueprint and that makes it much easier to 
implement __try_cmpxchg128_user_asm.

Paolo

