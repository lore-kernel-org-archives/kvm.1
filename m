Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977622E7377
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780265576; cv=none; b=IwXxrQOl8roNhMhtT8oltZkRITXzON+XGnbYDCWZRuKyeFBfjAZLEh5kWik/PGMbJYaRVfRrO0onvkba8lHxrbMpFkSvbMpQruEFCd1zgFqzRBQA0+e6FbYY+1abXG09ga/ExnKVbF2mJV3ISnS8Vs6UTTk6FJ+eyEi1VdtIJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780265576; c=relaxed/simple;
	bh=CCLdSYDcbA4vAViSDI7JcS1ilcApUa3TCZJ63QiM7o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1P8XGPxNoOyZtE5j5LiImT7crvU8lsyOU7+2eOs/DQQJUdTysFZaoyWz/qeeTIyPZpcjLJ/Terx8ApsBaw4MYbSzXsBdCtCFb3qaBpThYnfm3mBEsbN7ZulaZuGKslxcajgBduCMVndS0/494TAN9ROgqM0aQZlUVR94emDb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BtstCuK5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtstCuK5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a7627033so5870675e9.0
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780265573; x=1780870373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWF6tyr2CYayU1PYtFJKATyY4aqFNfuk6d6waCisXn8=;
        b=BtstCuK5eXAwutS1y40aUEhbxECtURrEe9tn9HEXIItnsoN28V8FiIrt6kOamQksdc
         BDNv+M6KJ/QCeK/Y4s/B8b+CcGR0YjtaandYhiv25XNP8gDXsQg9P51m9FD6QpblmiMQ
         vSyMfcXuXcJgESCQytVryV6UUpxrhio2A+ur1v4enKunGIyBgpAmDKUG/azqnHeaRuq4
         2Rque+iIV/8yQnMCxSCciaLqajnvt7u7qvwHZuf2av94uuw4oc/9eEu7geU7w/kVzXKH
         2/zp8rVv4QJzZM8+sjAqKysZ4nQbS9H01BqYSDhcNvBVfMmQnM3wWhqQWmPF5ZfYQmp5
         BMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780265573; x=1780870373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWF6tyr2CYayU1PYtFJKATyY4aqFNfuk6d6waCisXn8=;
        b=nNoIYY63Dl96rXAvxIdkzWtzp5WEa9ZAoXnLjzrQm2pFKJrjDO4lHgrltlBbh6L4UB
         56hYh11yZGu7UuOACVp5QhYecsyaT+b+8c5kb0VmMqIgUct8brxIbfTl+WSDAwwcFCkS
         gcTXDIL/pPYe4lb2SBgbUxpFcbSTLLv/KagVQn9PZdAky3meyNrkPRlYN1TwMjKBNF5b
         v1Bu4q7B2HFoAylKgaj+o81UNn6FqUtKyP7PNjg+GSMxFE6eYu+Bd+tp9GkWZOrrNYPn
         6f0/brRfqGE0LefPZj8MMDpvLi7pn7RaqDP4QWiiGD7zf36c0TPMnq7vt7InH400gh65
         wbkg==
X-Forwarded-Encrypted: i=1; AFNElJ+mf+LTt+h6F+5N1a6rwo972+MlHPjwlDRCoeHi/BTC+zdStj06MUAJNWNRumNi9ZLMa6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUoYUt3aIzEukC1xrRvC0iSXm2+hWY8BJup4ZpB++5eb0gqV+
	48c5y5Uv2LfU5IykURSmYDOONC/8X0/IDO4XvbRDVtMSSWS1V6q6HJ3YNYfwTPoh/vQ=
X-Gm-Gg: Acq92OGTJGl2auXzHTgO2ZhG8N0k2RK8ba+rc/uNUP60WUGncdWotXCaUZa3LfG4hEY
	V4RdsjX4Ax/cMAG1UXjH7Y+zthihDdlG60xCeJ1WAagt4rwCxichH+zqee1YmoGIsaFfzPEqblL
	WlzJFQ7kp4hZLWPgY2qovYubnUrLM0/tx2wkMJoa7HkQQk6TU+MsXVdiodbqbX8Fsd3C5ki8IwR
	QWjkQuRHq9R2uijbk1pQOVuUUcasif1Nvpxore94rzVUdfl7WZDKP0KR18SyztJo+6HutjkVtxL
	eQc8dWrDMsLfWgaMuEjH7zc/Pqs1jdU2C1L4YMy2Lm7Kn7Hp3GvrY50IrqmocGhmNrI1oGlVLod
	KUraB0FVk8AmKuCTDmu216irQ5cwLaKR8ACyNVmmKgiNnTlhHcCmwcxtS9pqpHSwL/oLeSS+XHR
	lYaQyIR3+8bLbWPgG0FJIz2UgqcIc19jyMYPFZqgplWPInCFiXuHKofJsQ9GiauqV47uMiet9de
	5qo
X-Received: by 2002:a05:600c:6d2:b0:490:5368:743 with SMTP id 5b1f17b1804b1-490a2946a23mr100294545e9.32.1780265572879;
        Sun, 31 May 2026 15:12:52 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c123406sm82118745e9.5.2026.05.31.15.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 15:12:52 -0700 (PDT)
Message-ID: <b8f40cca-2646-4912-8aa6-43442eab4f31@linaro.org>
Date: Mon, 1 Jun 2026 00:12:50 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] accel/whpx: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-8-philmd@linaro.org>
 <8889E557-72CA-4DED-B06E-4D82135CF923@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8889E557-72CA-4DED-B06E-4D82135CF923@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/5/26 21:03, Mohamed Mediouni wrote:
> 
> 
>> On 29. May 2026, at 16:24, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Register the new AccelOpsClass::cpu_instance_init hook.
>>
>> ACCEL_CPU_NAME("whpx") TypeInfo is now empty, remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> accel/whpx/whpx-accel-ops.c |  2 ++
>> accel/whpx/whpx-common.c    | 17 -----------------
>> target/arm/whpx/whpx-all.c  |  1 -
>> target/i386/whpx/whpx-all.c |  1 -
>> 4 files changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
>> index b8f41544cbe..099e8ef6da3 100644
>> --- a/accel/whpx/whpx-accel-ops.c
>> +++ b/accel/whpx/whpx-accel-ops.c
>> @@ -98,6 +98,8 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
>>      ops->handle_interrupt = generic_handle_interrupt;
>>      ops->supports_guest_debug = whpx_supports_guest_debug;
>>
>> +    ops->cpu_instance_init = whpx_cpu_instance_init;
>> +
> Hi,
> 
> No whpx_cpu_instance_init implementation present in the commit
> as far as I can tell.

You exposed it in commit 4610fee3242 ("whpx: reshuffle common code") :)

> 
> Did you miss it? Other than that things look fine and a stub implementation
> should be okay.
> 
>>      ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
>>      ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
>>      ops->synchronize_state = whpx_cpu_synchronize_state;
