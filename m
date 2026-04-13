Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396F40DFAC
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776049839; cv=none; b=LC+43+D2OrHirnDgZwqrkfsESnzfA6bpq9484WQGYyZeATb+7MeCOt2VRCZa4d9PlBYga3dH828Zpz/vPjBMki3XpR7YXtb816qpYu6nmPqp7cKNYW0UeeLRiEBEwjL33RYwk+dKFWbNFp3clrgIw5cbWxo0EDrxKG/y3caecK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776049839; c=relaxed/simple;
	bh=9TWpN4CBerVAJP1NyOLcBhXjIAkk4IXniiDaca9LRD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgzghJ520QGTU6+tJuu152twqQYtDArz6crEiNzopdYaxao/z90eWcFhdBdS/dYRFZ/VmUe5NTNvuTu3l+57n2NrA01XXx8D+ey9kOnBJORTnVFGhaxe6k2ONnqJAERy3BjLUvyAw9n2MUHqWSFx/G0xD5HBi8NrJcZi5zU9Btc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A53pJHrC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A53pJHrC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad617d5b80so21060135ad.1
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776049837; x=1776654637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdhSIse2soKursAdJjmWecwFzqSOmdWCQ6ry2TyOSSY=;
        b=A53pJHrCEPXJn7nYiYc6YU22hBRIsRGMLId0vuO8BH4bTXoUmgNfI/C8SHP7vgzFaO
         mwngt1lqo07JgxWPpZl+7oti+PQXp+0YDiwGYY3fWr2ESxEsUqAnvI2Or9qB+mZJ2i0z
         rsy/XUR+saJsYACTW17MS4bQIrUMkGbTNgSBX6kk8sLK+miIy55e8Gg6Rj8AH5LfQWct
         2cEEyF+MkfMSrI0BcVNYdjyHLSeQj5BUTmqO67OXarTmRkhdVJFR/OJMiq3gKipxFjoq
         RVLJceP2VjN11cqs0A9nlbz9+HIE9WiAI0QbKWX4dficpH3DxnRiTzp9XYchidjlfb5h
         sRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776049837; x=1776654637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdhSIse2soKursAdJjmWecwFzqSOmdWCQ6ry2TyOSSY=;
        b=IBwbmpEThzpdQz61xkcacxTUbh9HIpclYG7PKNgBi79XZIB2VvGzF2vbEE3oi3cWYL
         KV1KJnhbNUTY62wtDeX1PtMRzYvAym56ezDmB/FEKyjVBuFzVsb6lZltqjUE2Eqxryza
         lWvq5aVNv3Pki8ZaKMvQf9kxpx7hj45OyS49zvbAANKk7ITErsamB1UBZ7huRvmxKeLV
         lXLtANgd8EbOnBH3X+Rildzu6JJ5SZLfdoktXNbIx2rWl7qHFjTavRfUFJx199lPbH3n
         9oBKiTT8FTEvEL9t8t9KKF8/1oSAhO4XDKJ5uOX5VVe9CIQI1BoRKGiqWFLbn7SCCXkf
         DujA==
X-Forwarded-Encrypted: i=1; AFNElJ/1NJ+8ntqy7eks0XyqZy65iOxoXgKpnanNzhzyiBWAkigRfeKKnHva0ywvG+OXMIdlzCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNvm22Al57MttbdeU2+4YMcfjZGeJ36BqowTsgQbvcoNPiRaw
	ji5lxufEh7PhzRzyQu6N2dfjb1L8rnDpGFVCEqsKptQF2w5Us8kd+3Ezrwp1+hbbCNA=
X-Gm-Gg: AeBDieuPEB5Ev2+78RRcOUD1VWYLLfZ4uH6saBxa5PpIDz6eaN14qspfQB/Fs19gl+z
	K7FjWl36ZER8GzFQPkVWemohGNOeqVCSHFT3RbtvA/pdrIcEV0tmbIZ6IFGj4WXyFXNGsQeUHql
	c+oV6tIhmx8Q0PboHmIjNJ5pmX9hbYTSpN0PvbZ1AS3PP+hccS9GktatQMrikz8VnBPzEnVSxHt
	51hgKupDX/XtxkHTV9ZLYiiVEXMZxYp+PmLdJoM1yQ6e+XTPWuck2GWAt4T1c77aFjY7AujttUQ
	dKbISg5lwq2lP4zXhISGEjOFvyVB/BDb5YP3KzNuuwFBacx0LfZenaaIwtZE3cGjxC7yQo3QTGX
	gZ6AWf3w4QpeBcD87H26UA9HmhxZA1vR1XmVZmP3n3WyvZ5eYANylv7oL/xie3SHbol8boz6R/Q
	yMEulOiAc5qVRtLk7n26p8qBTreZ0mRlo2fAO7TXvm2QmRwcoOnDlzk+FF/Ipy3wQQmv7egyqjs
	WaPxRm+yp+B3A==
X-Received: by 2002:a17:903:3c2f:b0:2b2:90f3:d774 with SMTP id d9443c01a7336-2b2d5938b4fmr114072035ad.2.1776049837082;
        Sun, 12 Apr 2026 20:10:37 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3ab3dsm103442415ad.74.2026.04.12.20.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 20:10:36 -0700 (PDT)
Message-ID: <8f06d37b-111e-4255-8830-b63e5c8b143b@linaro.org>
Date: Mon, 13 Apr 2026 13:10:27 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/27] monitor: Forward-declare the MonitorDef type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> Rather than having core header forced to include "monitor/hmp.h"
> to get the MonitorDef type declaration, forward-declare it in
> "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/monitor/hmp.h   | 6 +++---
>   include/qemu/typedefs.h | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
