Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2933F586
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520977; cv=none; b=EavxxC7zbvo58xVR3siYRN7za6hmcxjw7VxlLH7yBaY4PdWez4cZOfjVYu3xBT1MtEnoA4a1aNLxoJLOV2QFi5ykkruS1VHibEYUFtHrQMxS/I4zN1CjLJNPYERHpKSJLAwSOerlKFbTJ++kB+H8zgcpgtqBs18q2w5NwtH9QhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520977; c=relaxed/simple;
	bh=BlpeBgIASY+9tAhOV1MNVpKTHhND3x1qs7SH/yICdUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DA5UyUEVs+J2P0q6T0xhpaX4fiIMj5gw0j7vhK3e1miMss350Wk/qDyeHKsbUJhad3LdlCAZDsOIXZHroFqSio5rnkxoxaagZyhQoMb6AmClXMlItBGR6H7VH+NebQMJcdtVLBoKGg4jr9ovYEgJrhHRjfCJ85IhFDoVWWCHVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpQlsruq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpQlsruq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so24680385e9.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781520974; x=1782125774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlpeBgIASY+9tAhOV1MNVpKTHhND3x1qs7SH/yICdUU=;
        b=HpQlsruqrl27NexkBZmobA4G6gKq46wlksAJ6AwhEHRm88DEqP9/okuQeUUnbj21iC
         CQe2nkJ+74sfbz9y07wGpNHIJzQWtdm0scCZVECMxPct162FiOKfg5q1nEvpDcDU/DC6
         5jx9gtBJ3dbZMfxPFna3ZtfcSemijGtOrP+WoHNXXMPn4TaALppg8cvCvIWdVxf9ePIX
         jrv9HCNvgtZIHVD/voejFq+3Tratpp/6LqImsSgjlMbFpkX4iF7wO8wP82wQcYVi53RR
         BKbjMRVOKEoxdTIIyLx4Q235qLU3HzvXBcscquwNSk8YgZusYFmfEd05gpYzdCHCb8lH
         3RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781520974; x=1782125774;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlpeBgIASY+9tAhOV1MNVpKTHhND3x1qs7SH/yICdUU=;
        b=OnK5WO9ykkBBng+EPmnEe+kLpLffDx+PbssffgJFJ9rWwwVRqKbQvwuwAXYvpKpOdN
         iuSPjNI1M+PTr6u+H3OsoxyJvqX53RJTzfFcOdggZfz6o++MFdmqMs6X9OFiMKEY/aTV
         hXfsKck23bq752SJ4Svz+HWzsSdTEXg57/LMeu+rQmjSnIYpwRIFLfm0QUEsAxMgjyGT
         7pC93emwRklH4J8J0mLFKa9uuv02areLY3iCRYjwPlDj82kIYFxQ6ZvX2vGYjWS7lsgA
         J0poLNSWiTFdhoPbodKsoCGcbii/iIuBuDP0BIXbvb5meQ4lX7bKmLEyMcNIx2C1LYEI
         hcsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2CqEmLxYZP3lWoaVYJa3u7gElAHlCz4szXmP9FYbHUZdJllshPEOVT9ONdgR0JJNvGoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEah221OPdweQ9woeo8ccWKzNAxksR+BOxcZP5KOU+R9hcW7f
	ljLF8pjxeCtoTQQJMUDGeInHxMypCN7sGQ94dtFAyQbJhR0H+tWhuxPjAb68Yxg1daE=
X-Gm-Gg: Acq92OGbODtlqzZL+2yCWlvAbgRtzF7zZqynBbVznXdoaTBRM4dsUCl/JVpo9SX1Npp
	Phr1IufWwCNMJBRLfFjlk/WIzsz4XHi2P78q89QcTL2Mo63pDxycacRE7jL1/YTAfT76gd/1yxl
	dWqeiz777oB1IWcTxmC8YLuu8iIemQr94+iziRq6zWHolwswJJYlmC2Ymo0rm3+HV81APBTXH0k
	3qZj8vT8j1eufHkxM5qXAs2sTKzvuSzuOMETMt1phZP01sT4l4QGzLdfwiSOJcdQ60mgCJ8uJTw
	uFjog1Q128ZjWn73GIZJ5MM1L5X0mfraVLmBPvfJ614xlLS9FDrLrwDKn3ooB4fwVGkq7zCZySA
	l1uQh1uxSk7d69IKblZqdD8a5G39fJaPE1QdtV+Sqn8uGnU8rABqTlcZa7JgO/CL00bRjXRswPN
	+KpGcdjoBbI1rzGdb6NUCqT5LepYuXWhE41w==
X-Received: by 2002:a05:600c:ad9:b0:490:b58b:a4a5 with SMTP id 5b1f17b1804b1-490ec50f800mr123708325e9.31.1781520973992;
        Mon, 15 Jun 2026 03:56:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492201fad25sm250300855e9.0.2026.06.15.03.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:56:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CB79C5F857;
	Mon, 15 Jun 2026 11:56:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
  Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
  kvm@vger.kernel.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
In-Reply-To: <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 8 Jun 2026 16:53:25 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
	<20260529082948.363931-8-alex.bennee@linaro.org>
	<CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Mon, 15 Jun 2026 11:56:11 +0100
Message-ID: <878q8gjcms.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Now WFE can actually suspend on A-profile we also need to handle when
>> its trapped. To do this we need to pass the instruction size so we can
>> deal with the is_16bit syndrome encoding.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Doesn't this need to go earlier in the patchset? Otherwise there's
> a point where WFE can go to sleep but doesn't honour the trap bit.

Hmm - the way I read the description was we would only trap if we were
going to sleep. Pre 6/8 we never sleep so we can't trap. I could merge
it with 6/8 but then that makes the patch even bigger.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
