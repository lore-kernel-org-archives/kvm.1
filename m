Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CF301471
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780347189; cv=none; b=BbcX+VeNj3uMThpnHguvyObjfATDAPhMfqsMfTCzyTFpUCOqRq2UA1jvSL3lZruege/NsC4FWuAcrwqFrM5sltJXXWk49jVPgQGz2B+cE/GT9ppXzlZEuWJG6SKIMI6+w2s1McddbTkNYHSkMikPQjtMLjRjRXz0dmdTT4Oen1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780347189; c=relaxed/simple;
	bh=KoP13Y6OZWScbESb/LUoe9UoBT5GkYRp3ikpwv6Ctxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP+PjenQUHuiTu5zrfzxIeaIpZIs8cXGTb5OqoZ9XiIjnHfG4Qy+BaRquji6hUn/SQYC0k7z/Q0wLhvzH5YiRsspGci+CDNKg9rWpA5kNqQ65k1tDm8+LJ5v2r88YXCYXd1tWSmf+Bq/4UcpA21nbCrGR6AWLky0AMn+bC0gl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5FEsI9S; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5FEsI9S"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so2655563a12.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780347186; x=1780951986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foWgpeWyomyZgltEG4IvNdN9+2kLzERIP5xs7MGfKH8=;
        b=G5FEsI9STcHQYVhWawyKrrJbTkb3zHF0LJhYNAR6bS0glLqwoizvwFvzwZt2ftkhlb
         hmtnqMw9lEB8ySJIo6EjKZnYe2wRiUbQD6T4hVEjJT07lJGzKgUsU3eNq3C0awLd0oum
         6wjBvsx0RSnh81vpFRxS3XD+V2cacY/0txw60D1vHRRKkUdvK4VhT8Hq2kWc35GR7tjY
         X5b/6irVa9P5gXSOFIAQyj2aLytqsaKM+gnyARsai88vcot3qBLR6nsczbbV4R32QjDN
         yqnDg2jMNES2ZAHK0UUX44BlMLcjCepGHNO+GYmVpLeUvHDdyKDhh4tmtX/jJ1Z/xyb/
         gAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780347186; x=1780951986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foWgpeWyomyZgltEG4IvNdN9+2kLzERIP5xs7MGfKH8=;
        b=R5ctAixo2ocr/xIaVQsgvrIAEnIJNPtyYN4cU2wNh9AVBCnSQ7RfTBtWYaafmWycWZ
         syOtqSBOOpF5yJ5VMZcW5dA8rZbGQCseuyXdUqHchKfYxvNMkD72bo2XfORge0BrBL2W
         UQV+dLr33QMJLzILMKzhzyddr5ozLYN9R3FOz2HVBs4GVODxd71vVKxDmWoQZyEVFAGf
         hLIK9vL27I4lfYNeaBu/04uQbADwRM1yWVaRx//sn1wQxjs0+UQvhbPITG188YUFHk4z
         F4vUB1zadKVmWUZkwHdXnYs85oIHXAyFqg/e/4gYUb70UllNhXSK19VWJE105L2vAcGK
         Uw6w==
X-Gm-Message-State: AOJu0Yx9ui2V8dPJuR+vTMmGEWJ/NkiU3rjmHBPRdWcVulbFh6HoJW28
	L43AyHu9eMHm7HmRijHuv6lszL2QsJ/+HYtOamo6ZnQoGMrebRJ7Bza5scJNRvPO
X-Gm-Gg: Acq92OE5nJdenN7bbsITH/kohY5Yc3XKQTrjFMA40It3ovLiIgTKgbmIrCbu1KiPr1T
	aSGIxkEsProReQTQH3D7SgN8BZWg0O5KRUWRoGAddp0ymEsUv8KG5shcXj2slNRvyTG1EKqKyGr
	m/bhxGsx1rGzHsjBERwmDjWgwJnnLeLQjPo2YZZZZx6HaS4MIIZ7mQ3ThHa6p9TJmXynfpseLHj
	Onat3P1QV8gz2+QgG6n0Cj2hhe7B4fWX9R1+EmOEz0XOsjg/6eQjj4i1o3erBpRPeTUF6e8binJ
	Vd2odraNgQi6jN56qje00GOlvWMttMHTIGeYQNGGNhE3zcN5QMm2VHv0fRkJvcStbfmuMHjUyzv
	vCV02foavUvYkV1hP8hvzFGNUFoqdAT+i1mUYGquO4LpiKzTkpbSLBOLKwFAeZm3Imz7imB1Yjh
	mU8fQ5+erTbX5J1aPyktsNbPkiW6tg7j2eTP0j+0fRFU6aDw==
X-Received: by 2002:a05:6402:5209:b0:687:7fa4:faa0 with SMTP id 4fb4d7f45d1cf-68c8d5da27amr7167090a12.23.1780347185751;
        Mon, 01 Jun 2026 13:53:05 -0700 (PDT)
Received: from [192.168.10.9] ([39.40.47.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb869dfdsm2539335a12.29.2026.06.01.13.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 13:53:05 -0700 (PDT)
Message-ID: <71d7060e-6478-4884-94f3-78da4f90d35d@gmail.com>
Date: Tue, 2 Jun 2026 01:53:02 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/include/linux/types.h: add ulong typedef for musl
 compatibility
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260531144934.403888-3-hisamshar@gmail.com>
 <20260531150112.5084E1F00893@smtp.kernel.org>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <20260531150112.5084E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/26 20:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Adding `ulong` typedef to `tools/include/linux/types.h` causes a `-Werror=redundant-decls` build failure in host tools like `perf`.
> --
> 
> commit 88e8d7a9a4205d14733be0e5978d3a32589a15e0
> Author: Hisam Mehboob <hisamshar@gmail.com>
> 
> tools/include/linux/types.h: add ulong typedef for musl compatibility
> 
> This commit adds a ulong typedef to tools/include/linux/types.h to fix build
> failures in KVM selftests when using the musl libc.
> 
>> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
>> index d41f8a261bce8..ccc90dd4baeb2 100644
>> --- a/tools/include/linux/types.h
>> +++ b/tools/include/linux/types.h
>> @@ -42,6 +42,7 @@ typedef __s16 s16;
>>   typedef __u8  u8;
>>   typedef __s8  s8;
>>   
>> +typedef unsigned long		ulong;
> 
> [Severity: Low]
> Will this unconditional typedef cause a build failure in other host tools
> like perf?
> 
> Because glibc and musl <sys/types.h> also provide a ulong typedef, adding
> this here without guards triggers a -Werror=redundant-decls build failure
> in tools like perf, which compile with -Wredundant-decls (via EXTRA_WARNINGS
> in tools/scripts/Makefile.include) alongside -Werror.
> 
>>   typedef unsigned long long	ullong;
>>   
>>   #ifdef __CHECKER__
> 

I couldn't reproduce this. C11 §6.7p3 permits compatible typedef
redeclarations, and -Wredundant-decls targets function/object
redeclarations, not typedefs.

Happy to hear any feedback on this.
