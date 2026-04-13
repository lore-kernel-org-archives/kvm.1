Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6C23909F
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052758; cv=none; b=QR6LrU/yJ4jEBzfZu2SBrNtfc1gFaxRBhnwf8kE3URzNMTAXYRYQPAgqiu34Erlad58pauU88jU6KuWr5AvjF9hMfHv5ai9L89nEtrbM54nCDwkb744RLZRScDEaR5DATQwshsW4v/Qh4YMDuoFZU/p6b140BxOP8/6wHiI/7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052758; c=relaxed/simple;
	bh=JlUG/TUKuG7rL6ZYA9/Mh5+GD5LydlwTTPT95CzFIWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvXnEMgLCWSI5//RvcF5vi5QTJcBkn3AQB0ufJKYKb849iVTv8zjIXh4CCdKaAF6X5vPlFl9VbXPt43TG6XBJXo6K/siMSCSn+9aeXX77g7EBLmOcBefeYzeT7pp/FCuzEtzASsA5qewfe4SSUoloMDEsJwJkiGhwdxv+q3/QrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NI8rUyou; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NI8rUyou"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2531606a12.0
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 20:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776052757; x=1776657557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxRbxg8Dl45tJ3KaekQoaNpVkcP6TDtqvHIeRgO74Nk=;
        b=NI8rUyouUwhBNtNKyQeKOUewCQlI+A4MfS4VAaVVXzOhX39qlLCyEi+2TxlTv/E1oV
         8z1o42I6y205kllQTz0SXkxeXHN+uGopJ8lXgkPGrAFhj9oMd92P9QeLKLXtkQLD52di
         idJJifKCYjHS63Q2tz7MAxrhGO5Jmwv3WUNkeYDpfgQvtsgT8VywAspXb7ec0TlBDk8T
         YfgEW9T5/5u3CR+OTWh9XndYeBAVmQx+wI6SKM2fHw1/MvndoGEIXLGBwiybjD+bwuEN
         4voW0itlGzB6/JrgTwS4eSl9bXvZ5MhXvbNQ1Knq0PjDU5u8DGW+vgRPwlNXMK0OpUUX
         cGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052757; x=1776657557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxRbxg8Dl45tJ3KaekQoaNpVkcP6TDtqvHIeRgO74Nk=;
        b=JeaqDxvuGAu4Fc5z2et2OQP+ahfTgQ7tNHXmneJXQ70p2Ti2Fgi2cdWVpJRN7aVX7w
         S6ajmqJG8e3JkNAEpF6u0ec/OUBtWl5o0nwoSfRjK0Ma23dN0vpocMzYspVz31Whf3n8
         w6QHrl+pYA+v1xW0TfgexsEi5dfLs5lzhpP0WMZ4Hn/Os/YPrBjsRNVEEGvjtfy7hxik
         KAZ8+t0LTsban7HoTy8SNwvQt0j5XfESN0aWW6CysV33dpExoOoMBCPIo8JYaBQ4/vgn
         TDK2ARct7n38QOEaxAga0E7/bInMHDMd+ZWHGM+BjBTh2ckB4vq4GZkiN0FPtW2tLSzL
         2rdg==
X-Forwarded-Encrypted: i=1; AFNElJ9NQDwbjxsy11m3s6T9FkEXBR0DwuUjj9hWrDEIPQXatDNUrgHYH1H/mU0Hmc3m+I5IfIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nEBLbntlhKh1sb4ktw2pUU85zF3zyNBJ+N72aRPUltsSlDev
	7Ie+uoKUfMSTzPWFZMcVCCGvWcK+bJSBAm54lHiC58Ts1vWX4N+5h9fqFFcsCWjD6QQ=
X-Gm-Gg: AeBDiev+w8Fdg5wjJk/qCAkRf4r6AtTWBtwJhcI4gqPXOh3PgPcg/JcB4ukxxYK2O6e
	bf3bdjO5s6OJwYgNW7dQsu7KU6U0ECL2nx3J2CyMO1ZKVgRfp9NwB65I2Sr/Cqo/vCXI6xEtKr4
	+kFKZIG1obDTDCjKbRfJ2UFulugrAQXDzfO+HqwM19mVdyOy4g3WKJj/SVke3R4wHElgefjn7EQ
	qK2mxIl5Ehi1yak7d4YM32tmSf+g5oEzMGMfXR4lkR25ygg2vbzsiFr+HT5XwOKmL46O9wwWz1Y
	p3egKwcsJZwDE3lTreMX79VgjdUuhnn3JxEBvGNaMooOmHfFrDAt+YarePhPLHiRuUPb09XqwFL
	CPHQsEgPmT6OdJH6/YEx8SjKffkpUMg0H8sPeROnqFvwLW6E6WwgGFr07JIhumf/1Cs+qJ6uPEp
	VqiZf8dOHlVKrzmpy9RQeOYfMRdhDPRpHtoCjWcfZnCIotJ2c/sRwlCoERfDYQuv1M4gIfHb23W
	DTn9KM2VbGxiqbGaMP6Xb18kWwUKNroYKGeh+eLD/DO2wBSkNyOU5k=
X-Received: by 2002:a05:6a21:338d:b0:39b:f433:945a with SMTP id adf61e73a8af0-39fe3f3f110mr13413019637.35.1776052756898;
        Sun, 12 Apr 2026 20:59:16 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? (bg30dj032xp6rdh0yngy.ip6.superloop.au. [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc424sm8401019a12.9.2026.04.12.20.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 20:59:16 -0700 (PDT)
Message-ID: <41c52a26-d5bf-40e0-a7e8-7d8ad8d7bc0e@linaro.org>
Date: Mon, 13 Apr 2026 13:59:06 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/27] target/m68k: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Restrict m68k_monitor_defs[] to cpu.c, register it as
> SysemuCPUOps::monitor_defs hook, allowing to remove
> the target_monitor_defs() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/cpu.c     | 18 ++++++++++++++++++
>   target/m68k/monitor.c | 21 ---------------------
>   2 files changed, 18 insertions(+), 21 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
