Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766535DA60
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998587; cv=none; b=T7OidYxiD0AzubwVbwc3QWFl9L0tk8J8U11bOfHRVlwZuBFOKYSa3M+KYJ684wR/pCB3spsihcxtk7fZP4uswHCDL3P+Fd+Z4AehM1GEMmD6i9k49w8HqUJ0CmxqPex+QDiFNj2USC6Ckd0pLY6ti4Vzy3vmxPet8vh/n4Rb/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998587; c=relaxed/simple;
	bh=LcwrEE/Su6MqZg1BVVUXTgS+hDQtivNXll3DuxETR5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uX9Fsk+hZ+MGHTdol88+IrbVG+z31HTGIvauiUbVHj7kgFeLmnSc5TVv0W3zI9ye/6mg9SurC5XW3fEAJ6qDRfwStWtNoy+paC5ese2u2iKU/4HKKoYQyrLkK5K4X/d46cHUGKgCsM0Xqn2+kf/E0r2WRsNrrzEtt2Cj8rYmmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpLq93JW; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpLq93JW"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67e23011c93so1232041eaf.3
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774998585; x=1775603385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAxWk+l9wnHigA07/m15Z7FRvAHJCuXF+wjFvuQTo7w=;
        b=WpLq93JW1LhcDqYBATrkbc/fP5BwgszTYjHTA3FXUN1LOsuQJot7TD0HRvUVli1J/S
         vz89CzQT7EHzaHrVzxI59BFstRbAp3sdQjjqhvLjzee16e344e115X5WWBURKvbLTYlV
         N3Ju1z+DHTPVC47nnOttAyrL6Nb28EyoeVawU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998585; x=1775603385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAxWk+l9wnHigA07/m15Z7FRvAHJCuXF+wjFvuQTo7w=;
        b=Vn98i/uHNj450mC06QKY4ew9eYNmA+YrXX3zcSMNMqsZChL8e80ixGOw4+GPV1TPQk
         EZmHfOjDSLcctJLhNfDbB9ObpOXUMtXYTB6faaqlfKece3dEHt0CHux6V/hI9+3E6hYe
         0h0T+LMLc9vj75LUwN2fZMp95wlT6CteHIgEWaR1nCG8luSW4GThWa/oTcm52pTwl90K
         p8bJXP5t6FiAUTMKu0TCFpfrXrgbqbfMayHY+pEgX54GCl+YsX0Zyv/LW8fahzWTvtK/
         XYxipezeTwwWc5LnqaE7SPxqD4hnAF9JWR25TgNIe+0BhzONQkXiIZMlpufbpSTDKULH
         19nA==
X-Gm-Message-State: AOJu0YwtCDtpfB4hOFGCpO5Gb0bPHgh5aAFm/oZw/l8udIodgwariYlt
	WXTOG8VlDNVLCOjn4nb5t+90HPfYGmr1WaKtWWN5usdjOA9xkFztdk2hf+EafdH3ks8=
X-Gm-Gg: ATEYQzxoIC4UD9FIc/dSbtzRyTDkycwMHRSOq0pXMuKJ8FKcAI8aaIVdDwn0jroqxQv
	nkloSuuVfG98MxFwzEeINs21eIDoxxDxYp/2un/RweFeU5C0Vy6I2gmI6cO+mxl4hEWv0Q2pYx6
	ngL1DA6LSMfS3v6LONYysuihu+epGMdtXb6N0iiWNOJMyqDCi65sgbBuRCyzWu9ONM7zuoBxNTE
	PmgcXT91B+tNdJsS1KaCTIbwyDDTL+VCyFB+VpMRADzCVUwuvXEhO+UNitecii85rTiSNpih02v
	14qQ3lJip/O/dX79k+bOZ6qtv2ZNE9ep1TXtNwuPdGPjx29j/9ZJyrrvt9UlQadUFtqqXTkIpFh
	ifEHpIn/pklzgvszPUSz3jevl43h1gHVnHlrI2jiT1XwG/c/QN7sdck3jLuW+ElgLPvaJlReTJP
	t3drFIfjHNj0MxlLd0ORx5WUt/cbNGrfkUx+o=
X-Received: by 2002:a05:6820:4c12:b0:67e:160c:369b with SMTP id 006d021491bc7-67fabcd99b7mr657522eaf.49.1774998585004;
        Tue, 31 Mar 2026 16:09:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e231ea41dsm7828492eaf.15.2026.03.31.16.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:09:44 -0700 (PDT)
Message-ID: <4334432d-982e-4450-9281-de739c25ebfd@linuxfoundation.org>
Date: Tue, 31 Mar 2026 17:09:43 -0600
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Guard execinfo.h inclusion for non-glibc
 builds
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aqib Faruqui <aqibaf@amazon.com>,
 shuah@kernel.org, pbonzini@redhat.com, seanjc@google.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260319000842.1213426-2-hisamshar@gmail.com>
 <091f264f-21f1-464d-913a-1500643728c7@linuxfoundation.org>
 <137f63af-a993-4b1c-a9e9-931718a47343@linuxfoundation.org>
 <f044f31d-740d-4cdb-834c-59de7691203d@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f044f31d-740d-4cdb-834c-59de7691203d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/26 12:47, Hisam Mehboob wrote:
> On 3/25/26 23:03, Shuah Khan wrote:
>> On 3/24/26 12:02, Shuah Khan wrote:
>>> On 3/18/26 18:08, Hisam Mehboob wrote:
>>>> The backtrace() function and execinfo.h are GNU extensions available
>>>> in glibc but not in non-glibc C libraries such as musl. Building KVM
>>>> selftests with musl-gcc fails with:
>>>>
>>>>    lib/assert.c:9:10: fatal error: execinfo.h: No such file or directory
>>>>
>>>> Guard the inclusion of execinfo.h under #ifdef __GLIBC__, and wrap
>>>> all backtrace() usage under the same guard with a fallback message
>>>> for non-glibc builds indicating that stack traces are not available.
>>>>
>>>> Unlike the approach of adding a weak stub for backtrace(), this
>>>> explicitly handles the non-glibc case rather than silently providing
>>>> an empty implementation.
>>>>
>>>> Link: https://lore.kernel.org/kvm/20250829142556.72577-7- aqibaf@amazon.com/
>>>>
>>>> Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
>>>> Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
>>>> ---
>>>>   tools/testing/selftests/kvm/lib/assert.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/ testing/selftests/kvm/lib/assert.c
>>>> index b49690658c60..3442b80c37c1 100644
>>>> --- a/tools/testing/selftests/kvm/lib/assert.c
>>>> +++ b/tools/testing/selftests/kvm/lib/assert.c
>>>> @@ -6,7 +6,9 @@
>>>>    */
>>>>   #include "test_util.h"
>>>> +#ifdef __GLIBC__
>>>>   #include <execinfo.h>
>>>> +#endif
>>> > Is __GLIBC__ defined in musl-gcc? Looks like that is the case with the
>>> error?
>>
>> If __GLIBC__ isn't there you shouldn't see this error because the include
>> is in - this error doesn't make sense if __GLIBC__ isn't defined. What
>> am I missing?
>>
> 
> To clarify the compiler error you mentioned: the error log in the commit message shows the failure that occurs before this patch is applied. Because musl-gcc doesn't define __GLIBC__, the original unconditional <execinfo.h> inclusion causes the build to fail. The #ifdef in my patch was intended to fix that exact failure.
> 
>> +#ifdef __GLIBC__
>>   #include <execinfo.h>
>> +#endif
>>
>> Also check tools/testing/selftests/bpf/test_progs.c - I think backtrace()
>> stub needs be defined only for the !__GLIBC__ case
>>
> 
> Looking at how bpf/test_progs.c handles it, I agree the weak stub approach is much cleaner. I will implement it so that it still prints an explicit warning message when a trace is unavailable.
> 
> If you are okay with this, I will move forward with a v2 patch.
> 

Ultimately kvm maintainers make the call - send v2 patch

thanks,
-- Shuah
