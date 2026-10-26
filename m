Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033664;
	b=1z2zMYamh0G2GJHqI1tRpUcslRHqaVw+ns0CuRbHg4jWOkG/jr1qBjIPSfU6Ly88KPvu
	 4leocG4+l1jxiUUv5tmsKaxtJ/o8VOQI+nZrFw/34Dea0mmGgKuP+l49UKuBIIf0aSUTw
	 6anDd+xBoMOuAqUAOuh78mAHZ534dKtdmGh2OpNhYctsF+iGsISK0k1Fivy8RQHUNhY2d
	 0tfwCW9VNWIGtZar7d3000B7up538a9zrKBHJkPGq8EDh060++l3dIzU4GxWHqhT8kh3k
	 frGSXK6IcUnm/AG8KEJp9i+qMWZva2MDjTplf91L5ZS6ADWDbTtUIGD+NpGwbm5IgJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033664;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RDoSB8ebN9NLHsFF9yL5/L13nXm4V45D3m+h/cdIXKY=;
	b=TqDmavanfhPOOrqCkqHVMN0u7V+WboSdG9617EHuVBvnQh0UHVHhvy4BoMJfIo5FZsUs
	 H9AaTd8kCQZGENy5O/IfzvIH0fGveNbewQ2QgQBCtijbRs9D3R736ZZv/tDU5RnTBBf9p
	 UKOilc7mP6Z48pwo4Hykm0BrsBWfYOQT5v6PWtwxOBd6jODyw5Yfh9pUIVz+gRlFNEWkH
	 UxGJIAQTMeqrs2Ob0HLHw1hSzThfTh79xuGXCOmO4n71illxfPl5aZRypqEBb5gWKLuMw
	 oGVqDFjTKwRoWvctYsvAaXFoo+wnqi977hbcYQwwl4fczLJHKCo1wumjhAJjccG3TwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AKr3So+w;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cCkN+9Ay;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD307606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 16:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD307606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AKr3So+w;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cCkN+9Ay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793033662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RDoSB8ebN9NLHsFF9yL5/L13nXm4V45D3m+h/cdIXKY=;
	b=AKr3So+wW+Fj4xGhRQ0y/q8FSethT8diwGvH74yyV+DG+14ggExe/yh8WbmSDdM+ZU1ICp
	i/zRjRBHhAJ9gSiHp+xpBcDmxxqncQK+HlDWgup0+1GM79D9Wksij5JmtJfoqt9kejVZgp
	tyQeRyLuFRH0WQF5veSOie+02TLPx+U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Iz9EY4YyOwaSVfLqa3zamQ-1; Mon, 26 Oct 2026 12:54:15 -0400
X-MC-Unique: Iz9EY4YyOwaSVfLqa3zamQ-1
X-Mimecast-MFC-AGG-ID: Iz9EY4YyOwaSVfLqa3zamQ_1793033654
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so2848308f8f.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793033654; x=1793638454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDoSB8ebN9NLHsFF9yL5/L13nXm4V45D3m+h/cdIXKY=;
        b=cCkN+9AyY4TCmDbSSv7di4g/HdsGwOHU+XEYLK/x30FOoHnUFFqyoocpTlYW9YqdRd
         uGu6tNkjfqsaiO9RE1pv4TDcvf2WdUXDxvGckMZlB4YPLeDBenKYjBhxXZgzCXdtuSWV
         zaNC2ClU1e1QY7/OW5fGJsBTdOaseE9zh6lUzlhsOjlqETfY6Ubh78ZXm3lnhHNiACLj
         TUMoXM3OxEnYYtAmicxfH4dji9Hk5rYkKHGdjSQ+IObNLGXmhkX2M4YcW9AtwZ4Mxp8a
         PksEKnEsxE7c+q9wia8xbcLc3VoV5S8LuE1vPE0fiHxL0fcgCUuwrMPXaCW01+5pqIvL
         HKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033654; x=1793638454;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDoSB8ebN9NLHsFF9yL5/L13nXm4V45D3m+h/cdIXKY=;
        b=XeiXcniy2upXTmNDeasv0O1MpQ0aw9/uJ1xpCpJqZPU9sLigt/+FtcLvv84v4gfG40
         kdCCQ/6r/hnPww25N5FomulnR6xQYYq4k4LGNwxu3SC/bpsQp5pmGdaS1VVPn0NI0xl9
         q7kbgZq2pCxmDKE7NwPfys9g2OIAX6mYullYMscDPXxVKIN/b0nYXaMPmWB/I8UAvyMG
         kTzYruZ/78QriyaZQLghrWpJwpq35QZjTJ2V5NRWuVr5oWVRvnMCkE0jf//i1BM+kT1u
         2h8uywMvNN2uqIEMNMU/OJE323BO2/3HW6flXhnwI0anGHoKsHeMH46DlmjiFoKghmTB
         c+4g==
X-Forwarded-Encrypted: i=1; AKwUvBzugdAyER0o8jjv+9rNtE6l8A3mqt6VnFMWuikH1QfTaC1yq5nP/Z3xycrdSdM4ddTTeSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbmV4W9IzJ0WSooDIUqsesfSPYOJCprc5o93JNiNwK3o4u3ao8
	oF5nmb9SsMdarYiYvs77XwfiBO5LmY56Vz0u/ggC9wF8chPsgv12NcMsU+ngDODOQlNkyfV5l5U
	z/oOSGAah/t8niPl36tBzpswfsASu7oaDvypmzdq5LwdpBlvCZJXV9A==
X-Gm-Gg: AYBFou2YIL7nkObYAXcbniAsBGUezYEvzcRENKiBmBVQ9RYfbbsIpQ60fMa8qn5g3PV
	YF6eon5H5LqRQQeTt3+tZb8FtPbj7enXO0L2FZTG3YIeWnVJ463MOmKb/522uua1l9VSu1l0vcH
	90cNweomR+A+Oc+x/2dhHj1ipDHKxWxZnQLhjfE+xVy00ogBOhRg0qo6GIRyRp+K3iO1Ks5kCuT
	5XbFG2mgVbBJ5nG+VYho0T6sb1oafgz6w0/fnMGsPNPbsrT9Z0nBTffSeyqFSb+I41QfKB+Qpf0
	IMg6KUOj0KrwSXlVhV3hVRbDwEMCZCisXGQJ/tOl5DK41RWfMDHMuAknb37aeZYg+WvIYoQ=
X-Received: by 2002:a05:600c:3b04:b0:4a2:8f4:96c with SMTP id 5b1f17b1804b1-4a35acb6c17mr135421565e9.29.1793033653769;
        Mon, 26 Oct 2026 09:54:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:4a2:8f4:96c with SMTP id 5b1f17b1804b1-4a35acb6c17mr135421015e9.29.1793033653390;
        Mon, 26 Oct 2026 09:54:13 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa097sm227762095e9.3.2026.10.26.09.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 09:54:12 -0700 (PDT)
Message-ID: <06896daa-020c-4387-bf50-09742e6fbd11@redhat.com>
Date: Mon, 26 Oct 2026 17:54:10 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] target/arm: enable WFE sleeping for A-profile
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Hao Wu <wuhaotsh@google.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Pedro Barbuda
 <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
 <20260624103049.884930-7-alex.bennee@linaro.org>
 <ae52ca61-b178-48bc-a456-27c6f3393b13@redhat.com>
 <87se1s4f1i.fsf@draig.linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87se1s4f1i.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/10/2026 17.12, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 24/06/2026 12.30, Alex Bennée wrote:
>>> To enable full architectural behaviour for A-profile we need to do a
>>> number of things:
>>>     - add support for the event stream to wake things up
>>>     - add support for potential trap on sleep
>>>     - handle the global monitor's interactions with WFE
>>>     - remove the M-profile specific gates
>>   Hi Alex,
>>
>> this patch broke the test_arm_quanta_gsj test in
>> tests/functional/arm/test_quanta_gsj.py. The test is not run by
>> default, so nobody noticed. But if you run it like this:
>>
>>   QEMU_TEST_ALLOW_SLOW=1 QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./run \
>>    ~/devel/qemu/tests/functional/arm/test_quanta_gsj.py
>>
>> you'll notice that the test never finishes on the current master
>> branch. When switching back to the commit before the "enable WFE"
>> patch, the test works fine again and finishes within a minute or two
>> here.
>>
>> Could you please have a look when you've got some spare time?
> 
> It works on my current dev tree, probably because I have:
> 
>    Message-ID: <20261012134840.1051969-1-alex.bennee@linaro.org>
>    Date: Mon, 12 Oct 2026 14:48:40 +0100
>    Subject: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
>    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
I gave it a quick try, and this patch seems to fix the problem, indeed.

  Thanks,
   Thomas


PS: I think we should remove @@skipSlowTest decorator from the quanta test 
once your patch has been merged - the test does not seem to run that slow 
that the decorator is really justified here.

