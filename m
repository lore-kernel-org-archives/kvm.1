Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9223D333D
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228320; cv=none; b=kAWWrSDjfnHmpBu9luBEtMeLejY4yreNRlJqYg0xqI8BqJxQoGcJqAw8bJDIoy+RMNBAAFAK68xDJVvhoanVif9CR0qEy6atuEyKq+flThvYc4wmFmr7jRSy91dYrkHBRSBv/5G8X4+FB6+a5B4Nm+HEKoIki/Iq08jfgJdaIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228320; c=relaxed/simple;
	bh=vU2gwqtPmPZh2g0hFkB8Fs/RniRfLGWTYMGvkcIMbaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IVuXU9bzDjZfhiQZeBpaMpTG2bI45Qtfy0Q9dcYffFCKLiiW2SjMBL+NYFpDf7YGva6EYwVvUPa1mq6XHrH9vGt35aS5M3n60SZmcNusrf/Gce/+U8ILLAuBQ5b2H77iwhU9HwDtMpnTGcpA1Bo029K85gBs/0Y5HdrZZHJHKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+xlg6lu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+xlg6lu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439baf33150so773074f8f.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773228316; x=1773833116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwOLdfYglkXvEbpjeXL/9obUVa6Ww4oqmXmr77l0E64=;
        b=w+xlg6luPxLV7d7K5kVySt4CkvHOV/yPSznHZCnefrtqWToWJDpg+1EacNZdn98VdA
         k6HCBGoHkp74UbDgos2GzjnkHixFu2jO1LKSySYg63yWwqvywFQiJ+tmVkcd9YzQj4v9
         LuLKGo6CrynG2RUXISEktdeVlcMia3BO8H0vcl28wVYVrOj2wXkZWaTStL/Z+FYjAU6a
         r+SrmJUL/U1gmJARuxczUZuu/umG/ATeGJ+t/b6b+s+RSJGmq8T5nmxVCU0wZXc1o4dT
         ojwXCMEE0HjT1U3VH2vosCCyMAZo75NSl46Wmkjzzsdzb2Hrmfa1ZP+ta2+wGaHJhUgH
         LbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773228316; x=1773833116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwOLdfYglkXvEbpjeXL/9obUVa6Ww4oqmXmr77l0E64=;
        b=I6Njj30rus0wjjmn3fmkYLVqUie05pHy+ujO577UvvaW1GedzwuaMrbRsNaPGwMgf9
         arXGypFB7MChRQSg3t9oExlnqx3v3j5Fwm8RB7YauBUEwUOpMzAKysbdO2mMwj66ytRe
         KiaaP3R3FDDFkmnMavUhDF4OrBy0K5pK64ofb4d3zcKKKqudm05VNvrE0Qp8tvnIQuaW
         BXYH8Almc0U2rhL3qyi4qvCoodXdmr3gnWuMd90m7eMc6XXw6Qb5oj1IThSj1X/phdQ4
         2u7elp4imsv5F08WvVzP5fTuD79INBuRV2/Yv4vbLhk1Mm8T1RGs1ppFxPpvDGO1VoH9
         jCGw==
X-Forwarded-Encrypted: i=1; AJvYcCU6fYXCpQLCPgyHr/qXC+GPnY4h/6Y3iHddQaPWdypbfgdnWPFvZdddM/cgrRLBr4MJsQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCfzPCL7f1v8dWXK2yLts62R4dv+XTs245tWmdwaAqiq5oIWf
	eQmp53I6AwVcWc63AS/LeqW6cAYbBqzyFHdOObOG28HPBBughC8FZgDqE3v1XNP28DT2uc3h5Fw
	cSSYF714=
X-Gm-Gg: ATEYQzyURGO9S7ZwrTQVp/l0CaSz5VeCBSFdB2oBJvDCcSIGlUmnbsd0pvOS7zSKbLP
	ydf69bg988Tl5UQVmdvgaRqGl/jkuM75WS1vGhLTnkC9sn+SGjED8SVh8leFIz6S7+5EB5370Zk
	996UqsqxZvv/VnaAKk6i+wtY8zopM76Wsbij47C3fYjs4wnf+T+ssaVPmQdzs/FdGyi2yEPgc+g
	CdQQF8x0+SyjLthl6iFFh1nKcbfcuLf9cGmCHgY2B0MLb4LrfYMRTMWLd9BhEMOMbBIW3Tpq63S
	Swpae/e2zIn1/Om7HZ1ekQs54kY2863C+n+naQ5C6eFUUokp/nX3v1xZ0eMU0qFMzc0YyQRSiS2
	1zPEOe8w8/mH/LLokcUEKz5EiA9N35f2gf7is1Pj/biyX/DOFvFQ5OfZlAGobR3J/B9eRoRGpVc
	kSg0Kk7uZz8U3ux7G4P76tByHBqNYjgbGZR7JuhoPGqYWOgoGjf0XWeRcGzPdi2cfhvR7McGwCT
	d0w
X-Received: by 2002:a05:6000:2013:b0:436:1597:7c7c with SMTP id ffacd0b85a97d-439eff27f89mr13375935f8f.13.1773228316124;
        Wed, 11 Mar 2026 04:25:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5677957f8f.16.2026.03.11.04.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 04:25:15 -0700 (PDT)
Message-ID: <02ff7f80-25ea-4617-a6f9-a938bffdc04f@linaro.org>
Date: Wed, 11 Mar 2026 12:25:14 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: fix typo in variable name
To: Alyssa Ross <hi@alyssa.is>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20260311095315.25013-1-hi@alyssa.is>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260311095315.25013-1-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/26 10:53, Alyssa Ross wrote:
> Fixes: 94a8d39afd ("kvm: Consolidate must-have capability checks")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>   accel/kvm/kvm-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
