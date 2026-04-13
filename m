Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3801624C0
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055299; cv=none; b=l5df+8UuXHpWbpgwmyIC3Bp4RPAGZW6tfM+3HBbPBgJXY773F4Jmb+A9ljwlDauq2PD7/qSfMm55unq8NYMGsX2l3rYpS13Mp3BaJ1eR44HLsT1kepQEQ4IcLahbu+8LrMcmfC0m6kq+hk0P79plhuiENDDhUEIN6D9fZsvxC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055299; c=relaxed/simple;
	bh=9QMcwr3K9a1rUC6dPSs4TB5F2gYSDrTYe4Yx0qG4YjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6Z9kS6ZtMzVHBdOzRYLWWRNR9hnSL3mx+dTU6eFpBZh7KLAu49Oh4eJnyZNU1bsJjSWaHHXl4+ftq0PfOnpiC1aDzLCUcYhFi72gmDMGqwQW5sSEJiKDtP7qNqlV6s8kC9L9iiDlGAfyzehO3Ea9mjMiYtklpCfjPUsi4ku9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dTRP3eW7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTRP3eW7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaed195901so17670695ad.0
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776055297; x=1776660097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QszutIL7wDTHLCDNTzcTvkrv//j2mQDdIveZtbTBtCI=;
        b=dTRP3eW76afdEEl5Q9Q0Tb+ZmxDBy9IrDMI8GR64fHKwD+yfZJV0bI1Ts+NpXCgvme
         OC999HFax2exYUS09Qs4LPRtyEIPco8fRdDgXU4kaoeV3qsDN5mb0bQJxxkljJQw9wgi
         Se4n4R6/bxkB3iNMiU3ZmseuTLBKSnO66VaLI7vBz7i2r8p8eeux8fbQJMIYYK4LM4xO
         +vDUxk8Xgpu7+vpnfcYS1cM8paFnRvVCZQyra273AOF6PzHd2zh5IfuQZCEIoDQOZmn4
         ZSP+uBsDk0MdSvwlULCL+46Qu8jS68mPev2jvKzXwq3uLjmwVHcOt/yJyNJotStyT+iN
         n/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776055297; x=1776660097;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QszutIL7wDTHLCDNTzcTvkrv//j2mQDdIveZtbTBtCI=;
        b=QL2bX55LTdLC+UFBL6y6fCm+/pD8KsY8XoYkcwXD6ymYFlzwO/GOM+gTur9h23yT1J
         TnU4v/qFS8jAPXWj2nTfyU9xRj2yPi4uFT1Fj6i20WFNFpYoPH0Nu3GMyeCyFEBXHeRh
         IPJZ8o2YuF2j/kadqGYea85L4VYbc4Wu9HI8vDWT5imNuUOw4ijrsAuisii+rh7dd1Bt
         GDJlyXmhDKICYFBAii1DMCcUw5fEk0kPAtydbN2yKKlWN9hvD11UdMGhAGDXmbih94zH
         vopiDvhh+bcoZKv5CLmnazr+E5O7dwAQvCkwII5TW5y4jN+ona219WpPhh/2ZaxV7yjx
         3YYA==
X-Forwarded-Encrypted: i=1; AFNElJ/RQ3qbCrRkUYNBYCahNArrukyReYkmdczE8BbZWoGxkGuXNAUO8bbtNotDZIM3Pt+6Uis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgizK1zowiXrVRgYslL0mr2qr/syvelvtWMebFutKCnNSoute
	nop3GFDuYuwQL8MgSS20W/VHo6lriTNSTGn+bwcUnPOAyhs0lVv9Ew++rjtz29D9A5w=
X-Gm-Gg: AeBDievxzk7WvrOnTlhdW+o0pmHAyeNNsONZfJPOSMoa+E1k3QgsCDg1BXV027MXZkb
	cpgQd629uLHC3xJma45hCaQ5fzJv7CQCscGrercR4LALvDQC/NTqP3KLK/5oY5MSc8DXD91AVxA
	hMqBaKcxMlxWGfki7ObSShE+0+15sjbnJeJiB88/Ou//Ixe7VW6RcYsI3S2jVD1q5O5/pDSoHfw
	eCVbSL++mhmRxvh9WAIucj5DeuqQJHaRBq32ESQObjofbc3Gn4J0CszhAAtZCIEvtY87GUd8RLD
	OtZ/btDGkGzXKknF5WjyBEra3ixIl2wr32Uku2vpxGkOjNOGraAbm1CGuPHrThH/h/gK5GeQPSk
	7ejIiDmtcVQ5aU/OvUs8cpqKyXSBqhvD3jNFJ6GBe/4pideRu+UTRMoKrdsDRrInD2u5XH3PArf
	9EGYT1lVRhioWfu4heMc4BTPLzUq389PHeTPTsdrQ+AtlXzmblvGnseUlsdTTpLf2nWe5DFl78B
	bAVxss/h+tpmOiOT9IbMa5z9hTCSHu3sOPA9+4LHcoZRSl6/cic6hg=
X-Received: by 2002:a17:903:2c50:b0:2b4:5cb8:99eb with SMTP id d9443c01a7336-2b45cb89e2emr30003155ad.27.1776055297031;
        Sun, 12 Apr 2026 21:41:37 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? (bg30dj032xp6rdh0yngy.ip6.superloop.au. [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm101698425ad.71.2026.04.12.21.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:41:36 -0700 (PDT)
Message-ID: <cc224b46-c705-46c7-94b7-b5638bbe3a0f@linaro.org>
Date: Mon, 13 Apr 2026 14:41:30 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/27] monitor: Introduce HMPCommand::arch_bitmask
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Add the @arch_bitmask field to the HMPCommand structure,
> allowing to restrict a command to a set of target
> architectures (represented by the QEMU_ARCH_* enum constants).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/monitor-internal.h | 6 ++++++
>   monitor/hmp-target.c       | 1 +
>   monitor/hmp.c              | 4 ++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 3ecd394ecf6..78281928e7a 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -74,6 +74,12 @@ typedef struct HMPCommand {
>       const char *params;
>       const char *help;
>       const char *flags; /* p=preconfig */
> +    /**
> +     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
> +     *     Allow to restrict the command for a particular set of
> +     *     target architectures.
> +     */
> +    uint32_t arch_bitmask;
>       void (*cmd)(Monitor *mon, const QDict *qdict);
>       /*
>        * If implementing a command that takes no arguments and simply

This and coroutine could be placed better to avoid two holes.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

