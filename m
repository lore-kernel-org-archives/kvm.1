Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA0413229
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461817; cv=none; b=dzy2v0MqDYN+SVHjeuybHXn+PRwFJwlVpgem1pMoqNAqaeBD5sKewFQNADt7PBGGHYyxLTAyyJT/Wp+d8dfeHrGYmyyGwZmtawNU6o2HCoKV7872gX7tbZfTG6GeykLd1y2F5cU4+NXtsIGVBQCE0rrRwNsT0a+yhYPkDUj5nuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461817; c=relaxed/simple;
	bh=A+jUmXiUjqNgfZWHo7uvi8hZQpP3vPOx34iWFM4RRMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdwXajGtfERoF25s8FKSyjtVQ8uyWafHtsNTXPfpa/kr0HWN0e9hw0or5t5Mc9FbemLI4sFkeqjfhlPgO6HJXHBxQNxbH2Btie+6sXjLn232Rp74tJ255CKheMyMYssuECsyv0OKDlAH10WD2Ks0V0AzCnle/KstSvGhuFu+4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAlisuWp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAlisuWp"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4be94eeacso59721a34.2
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774461813; x=1775066613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s91KuRYxNM++mXxBR/3RAyKkSTkEX4JgZkC++rqVfdE=;
        b=iAlisuWp68vnkd6erN6uMVElne/aJvj85hZf4QVFundtxyx78307fiUDtxlVRlwVAF
         dtYB8ORxVeCSacBNT99J5hJd3RhYcUP4Oaf/5r4jkxUmUoGJPeiulQpWyCF/zMx/i4+j
         rGPLdyxNXMeDqLGPgtVKxgDsLbkrdiDRxClcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461813; x=1775066613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s91KuRYxNM++mXxBR/3RAyKkSTkEX4JgZkC++rqVfdE=;
        b=TL2I66WPcqGPMdjXe7KR8FB+KFnInGuqnDnvvibuihVx6ISnglI//NU3u2VggUa+CN
         m1o/iY4pwpa8RFbdgGpsbjXm5MMgZMzE+Pwlo/rV4KvS9XcSssabVsdjCY6ZkCkLTSKC
         h6FbTGjadvPg6Uo8Lwej9oaEYwabR5NANhpMXyG/6ebmqLl+W1iSHI/gmDFMyLTq6Hna
         zOA7MasSXuVGOPinWOVpvbNHzSvZ9NfhO5bGP2VNXGOcyb0bZk4gpIC6gKcX+ZRhjsgK
         Qq3nFaNXSyRglO67DElPGV+e0y+gqOlYjfdSiDF6RXv6AfV7qSuNXt0+zTBEF1gk9sd7
         03tg==
X-Gm-Message-State: AOJu0YwqXY20rjcHMLuJv9mLJH4r3dQEayPZtGitUmK8eFNPA32bhrll
	KkY8ZkJQoO1Qwt6gVSv+pQEFFZJOyY91GStjcjfri3Ai+7kENvI2BRfYGC9E0qC4Nf0=
X-Gm-Gg: ATEYQzzJ0WZz2BAD3k0RncQcZImH+Ka5z6ZYjiKop7WmM3NL/PSS9pB6uEGPNOXc5S6
	6AsqlseIEYbZ7Y4Z8wQNaBnVRhDohNq6MOq4+TBLn+LBi0rj6P1JQHUQ/iJSgaWo8/+QOY42nqS
	i8Wr4kGavpCQbqSRwWlbJIjx0cAdHu1oiw6GiuBn+AlFGpUPKC/l+5VDfElq0GMDOmzdA3zA8IA
	YzkXWTq6Gz30muzsMj2NezdKwjkRu/ZoX2pO0/wwXBMGu6Y02xsTSban09qvb05BaBrAlPQH4BB
	rCH0/im0XSTUZSkfKDFhbexW30/UH2ilcwivbcCKZtFO+P4HD1CvmQPck0vo/r+YuImwi8NqNrW
	HEcx+Qx7C6f3wL3wXAxrN9tbL8SW0BrEx/1S6ctA1zxmAoGo4/oi3n4u4iP6EMbApot1ax6i181
	UkkKNivNAadgCxlLqrWEzcbTqlfYGlXAttrHc=
X-Received: by 2002:a05:6830:3811:b0:7d9:d390:1c35 with SMTP id 46e09a7af769-7d9d687ef23mr2267519a34.31.1774461812521;
        Wed, 25 Mar 2026 11:03:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e6fb2ddbsm314756a34.4.2026.03.25.11.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 11:03:32 -0700 (PDT)
Message-ID: <137f63af-a993-4b1c-a9e9-931718a47343@linuxfoundation.org>
Date: Wed, 25 Mar 2026 12:03:31 -0600
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
 shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 pbonzini@redhat.com, seanjc@google.com
References: <20260319000842.1213426-2-hisamshar@gmail.com>
 <091f264f-21f1-464d-913a-1500643728c7@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <091f264f-21f1-464d-913a-1500643728c7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/24/26 12:02, Shuah Khan wrote:
> On 3/18/26 18:08, Hisam Mehboob wrote:
>> The backtrace() function and execinfo.h are GNU extensions available
>> in glibc but not in non-glibc C libraries such as musl. Building KVM
>> selftests with musl-gcc fails with:
>>
>>    lib/assert.c:9:10: fatal error: execinfo.h: No such file or directory
>>
>> Guard the inclusion of execinfo.h under #ifdef __GLIBC__, and wrap
>> all backtrace() usage under the same guard with a fallback message
>> for non-glibc builds indicating that stack traces are not available.
>>
>> Unlike the approach of adding a weak stub for backtrace(), this
>> explicitly handles the non-glibc case rather than silently providing
>> an empty implementation.
>>
>> Link: https://lore.kernel.org/kvm/20250829142556.72577-7-aqibaf@amazon.com/
>>
>> Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
>> Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
>> ---
>>   tools/testing/selftests/kvm/lib/assert.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
>> index b49690658c60..3442b80c37c1 100644
>> --- a/tools/testing/selftests/kvm/lib/assert.c
>> +++ b/tools/testing/selftests/kvm/lib/assert.c
>> @@ -6,7 +6,9 @@
>>    */
>>   #include "test_util.h"
>> +#ifdef __GLIBC__
>>   #include <execinfo.h>
>> +#endif
> > Is __GLIBC__ defined in musl-gcc? Looks like that is the case with the
> error?

If __GLIBC__ isn't there you shouldn't see this error because the include
is in - this error doesn't make sense if __GLIBC__ isn't defined. What
am I missing?

+#ifdef __GLIBC__
  #include <execinfo.h>
+#endif

Also check tools/testing/selftests/bpf/test_progs.c - I think backtrace()
stub needs be defined only for the !__GLIBC__ case

thanks,
-- Shuah

