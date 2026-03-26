Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDE34D4D5
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507448; cv=none; b=htvxz2iGCNDQz1yimTB9NyXKK0/I8DOvAdbqc7DTucVCeNltuEtfPFdmWqg8SMEcjZlEWSJsrECCFBYK0wNSaIfwRaxzG1h6KRc13bk8fBJzCQdDPdYRo2LlVTpJqIc4EvyvH+aGeNvwEGC7Ik2cSFf7l5XqHJ9stknNyUFOwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507448; c=relaxed/simple;
	bh=4jPEZvZ6gctyCCaqfdCH9xKCb5073nIAO9Zviwnovdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE+5inK/GiLV9049R4I4lbaFrpI/QkAFFLaygIygWP9B+VdPzmtyo5Iz6umD+fJD1SyFjN00hTbmraNDk6hCbvxipmj73YSIsEJGRgPYJ8zYnG33RRhT/Tfot12iSDrJm7PLNvY5XWooDtE6QUiG5ldgRTou/Yz7veZq7KzZGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b=IaHwCFnl; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b="IaHwCFnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1774507411; bh=4jPEZvZ6gctyCCaqfdCH9xKCb5073nIAO9Zviwnovdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IaHwCFnlUvYmpPnik8hmUaaAg/v7AWzR/fdqlz8fOJpG2OnvwOVaCQOXqTlUVoPfg
	 bl2b1mSlkBh20HH3bKvc5o+i6H6QLd0Y6mkqdSWZJdXM26gZ3olyml/8LyVY6txwHX
	 IEPB7uTs3NjIECIhVseVi70N8WrW66Sq8iLDzIl4m+XuyHURIMILjW2/gAiDyifUDn
	 bykhPBRmGn84ReKt53NhQQr9En32RHNLz573wGRBCI0hAVOjiRyl6lEbNCUURaMTbd
	 JvUKFfx6zGufvuwEaJnICtOU2JVPhS2x3PXy9rJTnAvtYg2a0qyrCV8gInXPSjAq4I
	 otvCs6HmXHBMA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 606F0197BFA;
	Thu, 26 Mar 2026 09:43:31 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 5B4603874A7;
	Thu, 26 Mar 2026 09:43:53 +0300 (MSK)
Message-ID: <f5cf28ff-5f11-4ec1-b985-f32f1c0f0fcd@tls.msk.ru>
Date: Thu, 26 Mar 2026 09:43:53 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0? 0/6] qom: Restrict compat properties API to
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20260325151728.45378-1-philmd@linaro.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.03.2026 18:17, Philippe Mathieu-Daudé wrote:
> Remove QDev uses from QOM to help build the guest-agent
> binary without pulling in QDev methods.
> 
> After that only util/qsp.c is left (cond/mutex atomics),
> see this thread:
> https://lore.kernel.org/qemu-devel/a547c29b-3ab7-42fe-889a-19668bc9d090@tls.msk.ru/
> 
> Philippe Mathieu-Daudé (6):
>    MAINTAINERS: Separate QDev section from QOM one
>    hw/core: Move compat_props_add() to 'hw/core/boards.h'
>    qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
>    qom: Declare compat properties API in 'qom/compat-properties.h'
>    qom: Restrict compat properties API to system emulation
>    buildsys: Allow building guest-agent on 32-bit hosts

Series:

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

This definitely helps with qemu-ga issue (a few steps closer to it,
anyway), makes things better separated and cleaner, and might even
be simple enough for 11.0.  Though I'm not sure for the latter.

Thank you Philippe for this!

/mjt

>   MAINTAINERS                       |  21 +++---
>   configure                         |  64 +++++++++++++----
>   meson.build                       |   2 +-
>   include/hw/core/boards.h          |  11 +++
>   include/hw/core/qdev-properties.h |   1 +
>   include/hw/core/qdev.h            |  27 -------
>   include/qom/compat-properties.h   |  40 +++++++++++
>   include/qom/object.h              |   8 ---
>   accel/accel-system.c              |   1 +
>   backends/hostmem.c                |   1 +
>   hw/core/machine.c                 |   1 +
>   hw/core/qdev-properties.c         |   1 +
>   hw/core/qdev.c                    |   1 +
>   hw/i386/pc_q35.c                  |   1 +
>   qom/compat-properties.c           | 116 ++++++++++++++++++++++++++++++
>   qom/object.c                      | 102 +-------------------------
>   system/rtc.c                      |   1 +
>   system/vl.c                       |   1 +
>   target/i386/sev.c                 |   1 +
>   ui/vdagent.c                      |   1 +
>   qom/meson.build                   |   3 +
>   21 files changed, 248 insertions(+), 157 deletions(-)
>   create mode 100644 include/qom/compat-properties.h
>   create mode 100644 qom/compat-properties.c
> 

