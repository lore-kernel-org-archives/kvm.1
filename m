Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A203C276F
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735603; cv=none; b=tVMHThFO9AW/OfHICXIxH5zngqoK96u9fYrt1QIaGaj95gUsenDkZsuT5D4AGXwQVFbIx8u4Vz36AWcDH/X+w2qfWNZNZyDXgZEcaHKqRiWwfKrgXMvJ7/iDZMMeiuu7TtZA2UoGRXoImzG2QgmFqPuJoz/a5XQX/8aUhL/bo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735603; c=relaxed/simple;
	bh=wzTBF1EzB7+KMBjDU0jDqnZ3WCqA2gwJaJmjZat73Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LO4tzC9WNvJ7RzD2wxHXlarGHI8Iu0dA42ZpcmuQWx5n6JB5Nd8sz5kLKyhysyWA7s835M7g4CBNr8uoCqS5+eV9UzZF7IG1cfDt0vhCVCDvDh6m8wMXeyGGsEx9M0SHG9NGBHJKUj4v8C5Py92F0wNeGQVYh0Y5AUaKAaV5QKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImXFJ26B; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImXFJ26B"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so405222a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775735601; x=1776340401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SR0E+cafF0XtqSHjIkqxPcUXF9aNBWr75PUx5G6N8/k=;
        b=ImXFJ26BjdrUFg3+8ayJEx9lDyHlmtU5p6w6N5OOtV2HN+zn0rLPAS7Dc7cqSxFWTM
         UHJAxx481zz+tOFOI+Z9OblJbX3pNclzGkBHGbTwUet2cnU/B/QC5sZ6jBcKhYMVRYkw
         Ee2q+06zvsvQeOEeKwW6M05BwQ0H8epNWSQ0rU4IJUTysoNlPHdORIlbG2XENcEkv743
         tN+CZ0G00GhNAYLwN83jOIcm0KB3jWyxzP/TGLsLZl/aXaErB4uKJpgUxCu8Vj0fVEHg
         AXZ/RRrG3Rs47KqloRojpW0W2qN+SK/RyMZ9ULHKAU+C6Zaf2ihlRwXjQHGNLDhIL3QF
         RmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735601; x=1776340401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SR0E+cafF0XtqSHjIkqxPcUXF9aNBWr75PUx5G6N8/k=;
        b=dtLLme268G6S8UET+VJju0t9n9B85CzDHZ7jujROL2h8L3dk+wLfYtCa+4Z/kspvAe
         ClGFIweVxUIbh2f+EJyjsBgn83zsOkg0K+slHVM21OD1AcCvbm6DhGB6YWgrkWOw0Bn2
         XIGl7rjYKfkhPWCPUr2zVFEjXjXJafKMb+w1fAEj+zxBpyBVSDyC0uHtUwuQ5ln3wWdP
         LKRb6X8rVtKMFc8WjBf5mj3ZnnFN4Uw1aN211htdZnFvG20v/ipDmJeOgAjlniLcCw1r
         GX9XoJA8vWArNPmQwO+uLWCn3MznfsmWUsr+nyR8P5BXRBixpzEJq5oV4olkhp+0llAo
         Lc1g==
X-Gm-Message-State: AOJu0Yz9uNEA7rqqxVjpI4UZsndi6OzqFPVi8e5ObsU5bZ7nkyw6l4KA
	8FZoxvvchyiWSzM8p9riCElN1ztHmemILIV7m5YQ3aOkK0/m4FptpK8u
X-Gm-Gg: AeBDietMFMpvyFiyZm3TAd2OhK3iwEiaoMD5rL7UO3zveyYkO+vPDCyDow/cVFEnbOD
	mDBSXNACVis1k6VgjRcOf7pIyd+PWATXOIDO4BUzBgXBHwchTzLSYWrQ1uen0m448nZlf2ASAkR
	iZJAaWzVTiemdEnwSU450w1UEL/3MFFyaczpM8JkIEEAgk08B/BPtH5rbrMdTYULkg/PDhEE7ac
	C0IU3ExkQz9U+Y/MdRaCwu2NOOJi+VuT9qxoY1OcnIUQA/2yy0PgQMgFMpr8AnGvDy0entbI8dv
	Xq7JVKouXXgb9exoB91va6SUfjv6EFGWICuE0I7jtXOu4AINOnPSTCCOd0q+w4VwNjB6ghV6PFe
	QJoDz3RozqWdUBFZNftVAiNcYMajQuFG83J0Ghy6TSb8sRvIaHDfbaGDTDJK4D/OwmQNm/VGSMV
	dc1dHtzfjGK/QUQRWt1jG9/qxNaJx5DaZZyzP0GEylMncGtzbMiw3Sdt0LCojdj2TP
X-Received: by 2002:a17:902:e78b:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b2815b522dmr266926835ad.0.1775735600684;
        Thu, 09 Apr 2026 04:53:20 -0700 (PDT)
Received: from [192.168.161.51] (mbl-65-153-179.dsl.net.pk. [58.65.153.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3a0fsm309911735ad.59.2026.04.09.04.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 04:53:20 -0700 (PDT)
Message-ID: <8262fe0c-cbec-4c85-b5ee-2f6cc20cf57a@gmail.com>
Date: Thu, 9 Apr 2026 16:53:09 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Guard execinfo.h inclusion for non-glibc
 builds
To: Sean Christopherson <seanjc@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aqib Faruqui <aqibaf@amazon.com>,
 shuah@kernel.org, pbonzini@redhat.com
References: <20260319000842.1213426-2-hisamshar@gmail.com>
 <091f264f-21f1-464d-913a-1500643728c7@linuxfoundation.org>
 <137f63af-a993-4b1c-a9e9-931718a47343@linuxfoundation.org>
 <f044f31d-740d-4cdb-834c-59de7691203d@gmail.com>
 <4334432d-982e-4450-9281-de739c25ebfd@linuxfoundation.org>
 <ac0lGVlg4cJSNCGl@google.com>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <ac0lGVlg4cJSNCGl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/26 19:01, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Shuah Khan wrote:
>> On 3/25/26 12:47, Hisam Mehboob wrote:
>>> On 3/25/26 23:03, Shuah Khan wrote:
>>>> On 3/24/26 12:02, Shuah Khan wrote:
>>>>> On 3/18/26 18:08, Hisam Mehboob wrote:
>>>>>> The backtrace() function and execinfo.h are GNU extensions available
>>>>>> in glibc but not in non-glibc C libraries such as musl. Building KVM
>>>>>> selftests with musl-gcc fails with:
>>>>>>
>>>>>>     lib/assert.c:9:10: fatal error: execinfo.h: No such file or directory
>>>>>>
>>>>>> Guard the inclusion of execinfo.h under #ifdef __GLIBC__, and wrap
>>>>>> all backtrace() usage under the same guard with a fallback message
>>>>>> for non-glibc builds indicating that stack traces are not available.
>>>>>>
>>>>>> Unlike the approach of adding a weak stub for backtrace(), this
>>>>>> explicitly handles the non-glibc case rather than silently providing
>>>>>> an empty implementation.
>>>>>>
>>>>>> Link: https://lore.kernel.org/kvm/20250829142556.72577-7- aqibaf@amazon.com/
>>>>>>
>>>>>> Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
>>>>>> Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
>>>>>> ---
>>>>>>    tools/testing/selftests/kvm/lib/assert.c | 7 +++++++
>>>>>>    1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/ testing/selftests/kvm/lib/assert.c
>>>>>> index b49690658c60..3442b80c37c1 100644
>>>>>> --- a/tools/testing/selftests/kvm/lib/assert.c
>>>>>> +++ b/tools/testing/selftests/kvm/lib/assert.c
>>>>>> @@ -6,7 +6,9 @@
>>>>>>     */
>>>>>>    #include "test_util.h"
>>>>>> +#ifdef __GLIBC__
>>>>>>    #include <execinfo.h>
>>>>>> +#endif
>>>>>> Is __GLIBC__ defined in musl-gcc? Looks like that is the case with the
>>>>> error?
>>>>
>>>> If __GLIBC__ isn't there you shouldn't see this error because the include
>>>> is in - this error doesn't make sense if __GLIBC__ isn't defined. What
>>>> am I missing?
>>>>
>>>
>>> To clarify the compiler error you mentioned: the error log in the commit
>>> message shows the failure that occurs before this patch is applied. Because
>>> musl-gcc doesn't define __GLIBC__, the original unconditional <execinfo.h>
>>> inclusion causes the build to fail. The #ifdef in my patch was intended to
>>> fix that exact failure.
>>>
>>>> +#ifdef __GLIBC__
>>>>    #include <execinfo.h>
>>>> +#endif
>>>>
>>>> Also check tools/testing/selftests/bpf/test_progs.c - I think backtrace()
>>>> stub needs be defined only for the !__GLIBC__ case
>>>>
>>>
>>> Looking at how bpf/test_progs.c handles it, I agree the weak stub approach
>>> is much cleaner. I will implement it so that it still prints an explicit
>>> warning message when a trace is unavailable.
> 
> I disagree.  _If_ we didn't need the __GLIBC__ #ifdef, then I would be in favor
> of __weak, but since the #ifdeffery is needed, using an #ifdef and a __weak symbol
> is double the ugliness.
> 
> IMO, the way to make this less ugly is to using a single #ifdef and a local stub.
> 
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
> index b49690658c60..315175ca49f1 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -6,11 +6,13 @@
>    */
>   #include "test_util.h"
>   
> -#include <execinfo.h>
>   #include <sys/syscall.h>
>   
>   #include "kselftest.h"
>   
> +#ifdef __GLIBC__
> +#include <execinfo.h>
> +
>   /* Dumps the current stack trace to stderr. */
>   static void __attribute__((noinline)) test_dump_stack(void);
>   static void test_dump_stack(void)
> @@ -57,6 +59,9 @@ static void test_dump_stack(void)
>          system(cmd);
>   #pragma GCC diagnostic pop
>   }
> +#else
> +static void test_dump_stack(void) {}
> +#endif
>   
>   static pid_t _gettid(void)
>   {

Thanks for the suggestion. I will send a v2 implementing this approach.
