Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79541E89C
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876872; cv=none; b=NRgwZnqiRf08eKl4ohKNEY+ygxBMA8oJhwZDaBrXimKfoMfHRSj/fTRYRAoFZV3BqG92TFXCyquZyovR3N7KFJLHRyoEau46wHQuhi/ps5C2g5zFG9IKKj9+LMEAhtTLRwpOM1DEuw5djwfZg68EwEnNvNW2zBZk5YZQ2JVppS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876872; c=relaxed/simple;
	bh=Wz55H6yeKFTfj5Df3+mC3xa0Dwhv4O9SPiWkxsXJVhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGbZ5Hkjtb6tXBh0T7253Blg1Jj/s6wNfEqdbb+1ZtK3dPyklW4i8cbrU4K76O+3NrBB6cBrL/EWrLmv8IpP5XxoI75JpC3WzWQdcRL4Prcbz6pfU0n7tpfIAebuti06ZyEuCWvvHuzCyXCYcKsEvxSnnA1fxeaUwesFc7nbLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gVUlhePt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVUlhePt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so22182145e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776876869; x=1777481669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/R4JUxI0x5y7vpWyLyEyIuZWveMbmO6xl4uXL6GDrQI=;
        b=gVUlhePt9zgsWZcUFfviLs4Yi1pJugbQfjPwl9hiWsQVR1vP2DPhC5uCPkQgJYWC1P
         peBilLFMjIwV4iOam1W46cumHrzWgIyNuBI1vEt/5/euoeDiFuqYXQGo/AuAtz87Omlw
         HjHEsrHJONOz5hhzFT9GhXI5Jt2PoLcEDLfFchfomQ0a/immZalshOQybOKNIXTxkeTv
         yvaciwiV5dpps/gP+pUFK2Ig5mMo7rbDrga7vVbCgPtaskoW5mYzo+w4wAA80/+Bmg0w
         vJ9FyPKsUcsH7kjRmxCYg6FdlgvJBNmj63hzhdgcvPd1DjsEOP0UDeZJCkDum72jOnQ7
         foxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876869; x=1777481669;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R4JUxI0x5y7vpWyLyEyIuZWveMbmO6xl4uXL6GDrQI=;
        b=YF1q1hD0T7WwY9pcFgJDGy2IfSUkYJQuVuJvs8y0llND8ZLN8puy46b0FdFPheQ5OM
         y3Ww/0LLR3uYkOqdYFjYdFf4R3fe26xyp8Ke8eBbv1kPsVyr8tWL8O+FUfrlHsnDbf5W
         cmUqiUFESpCZBbKdIAY6Ha3QCIfzbquBYwg0Df6d8HcnMxhaH1XXFzNz3TQncUUUaGDo
         nRxBZHMOvMSErm4WD6gpdHXysTwI9kjOmYw/mAsjp8Ka5+BjzxLqYbpgHJ9+zF6+aU3r
         6uWxcFRyCwZ2FT+J6IhvA9lNUT9Z3YEqWPI2FDoNmV5VSDq5k6X/XFeJVnT6ahHd6Yqa
         tqOw==
X-Forwarded-Encrypted: i=1; AFNElJ/ViOjvi2hz9BndK8DGvcHhSYnllLwNBR1CJkdh49bwgNkRtCLV14IRXP2qdfnD6UGu2TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUF5LCGiPs61oPw38KqGqUSQvZPivhvoJaL/KvdszSE3cK9Rs
	MiDcBiVak3mpWl6PpRGct0sC6JgAMgwSJ4bg+lOwweC4pk2kO/2bNUZ+gidR9XHkrZD+SmK2/+s
	+gCsd5Ys=
X-Gm-Gg: AeBDiet7rj1Kio/V/s6u5mAB7YX0owDdRVIZlneB8yz4O8HesnVJdyKbCQ9n/q2qAXn
	pBNSbBUJ6vx6J5f1JLdYyu3R/2VRG8A1NOpRCJJYQjR0B0MyWXJDuChyChBhdCzv6gXZq4hZKUj
	n7RfHTY2jQ13aUqjbOPGa9NBMx4F7YFVOk8VB+FnDVF9swqIBEiOdc44ZCc0GfUmALikodTBt1H
	YzFHoPu1ksK7uWAMrhLhxrXFZ7tXsPuyVQcnsqPoRtkPMirTUB5haGyqMdMZl8YQKqevmOBTppf
	57GeZ+e1YBaxEr7SXl6cxypsaucPYf2GiMNf9+5Tb3dua6chbrdzlWkTnG/DoSezdVKOpTXke0k
	Q1lWyF/GGij3KL72GtO9Uu+AC5KhyMc9b+E8xHCUNN5OivYWbnprqVZ4nfJL8UxBVj0acx2fplp
	4ad1IEKh0tNO3ktB4q151rpy6cFXOzo1Fx5OwTE23z9qKE3tmH8+HpAkGEYpUW1jvRp76w5C6Us
	a+48hMw181FVC0=
X-Received: by 2002:a05:600c:3546:b0:48a:5546:61a1 with SMTP id 5b1f17b1804b1-48a554663d4mr123234745e9.15.1776876869171;
        Wed, 22 Apr 2026 09:54:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0c13sm145632745e9.21.2026.04.22.09.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 09:54:28 -0700 (PDT)
Message-ID: <c7d5c311-d010-400d-a2d5-3fb355cc5326@linaro.org>
Date: Wed, 22 Apr 2026 18:54:27 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/32] target/arm: migrate fault syndromes to
 registerfields
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/4/26 14:52, Alex Bennée wrote:
> Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - use !is_16bit directly
> ---
>   target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 74 insertions(+), 13 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

