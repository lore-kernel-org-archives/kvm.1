Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067781;
	b=OSmBkSCCpNNWhPmoyHIufwEc6qQXVqkemYOJUQLBzbINLPxNHj+mFgMlWiRE+XuZhN3l
	 gVwfGN9EKn/NywZ7cWSBn+rGec+Q1B431drqwY5ya4AWJ0B+s8CWKZEEUrDebm+OVsCTX
	 daTAcMuXtdTvSZCpkMAAQWmE3xEtaPZ+zlfM1bCVbn3UaSeYa+M7w2PtYH7rnqCvdXUmA
	 4/V+1IHRuPCEfGdq4G+5v8Y0f4ulIraD35ZDY5cvWgrdeM+EpJNZM6ZF1yxPgxplaRbvb
	 qPKdwjwVZxn5Ws8UTatPNSX8ot6kfDn6zZIClkILhmLX7uiSq37cM1PUsQ1S5fnmIcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=xKhWfAhnFH1MoQBYnntrqmndPCEzikmuR8uNGBngT1E=;
	b=vuAhw9hu0H/gSMz/A3DXha0d/Z6o8cDNg5hqKkUdgl4x6nTNuu0Zeax+yT5HevGsQJlO
	 njrwT8kk2iPB3pxwCZlLdiAYj9QSVnUokNhG56KfP3hAHDocJ4aaUZLsHK4umE2yyHz6L
	 V12xiKfw4s2Rur01/zvFJeEK+HfnVghGysu3XA+oVePiMwusFSPzXjwkcdzJO6+ASP0qY
	 TPdYF0w1Y0v1onGu+FWCKDrIOlaTkzExxfB94PLoDj9ejXiTP04yqUxbHAyB6G7dXAvBo
	 Hrl25LxscVuq4qx6qcGfUbHT3gUsyVxdne95cFuwYYLdsakT5LMUXXTFVQtiyDK09YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gp19Jox6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE7606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 05:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FEE7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gp19Jox6
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso2395077a12.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 21:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067779; cv=none;
        d=google.com; s=arc-20260327;
        b=lzvV1MEXMwSIG0trAicM4r77KA43tKQHbsWHQCY1j21AA1Hh85YLFJqKqL+ziZWENn
         GefPIvD8ICJuojdWJfTRuq417OAQsyRcdAWhDWhymC9+sDj4OkV2XRptRFF+TQ3rCqqu
         XdMbOhfjkLHdpO+peazd0Tq/cPTuIuXMZrVm8O2qtD6V0MetCwPjYT14LV+CupgMTgFF
         BKQNSEUlwFHsceFT4o8H/RE5yMF6jt/shX+SRQN8yDN12FaafDtGGLMXx6PtNuCM4hAc
         EeAt2pQlMVouD/TAO9Rt0NF9MKb3uLFdhyY12cUBTaPbcM/LuY/D53/uTk7sdaW93Qln
         5sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=xKhWfAhnFH1MoQBYnntrqmndPCEzikmuR8uNGBngT1E=;
        fh=CVnWWBrL7GOeaKeSrSKLMmuf2k3jnC4sDF0P77jmDHg=;
        b=jZi1sttxzrqSvcj/QdbXn25N9aEPzfgegOUVeimN+fYASwZMLw7DM8aXNiL8Y10HJ5
         G9EPnVd6CTARZ9yNDmJgFr2wjrLB1dAZ9robR4imlMY4AM7LMyopECbopBKuaqFpLtTr
         njnITa9AGxRSrgbUJ1hy+RVBA6B12WyJjoTRWUrsWKTqBNGe4/vdviNus8L5vgy6Doka
         SY01ewRriuw/9qz/CaLX3v6EG+CaeYK7/efxsaLvo/hl+g4A18iFTJQC8yET/DN1cEGd
         /H1NZwpFLliLrjaSfyl0fZ9jO+Lo9oyQGcChl7rf0qQPjeygmUq52eyKSWxO5VYDLBO0
         AGiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067779; x=1795672579; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKhWfAhnFH1MoQBYnntrqmndPCEzikmuR8uNGBngT1E=;
        b=Gp19Jox6nlC9RZkWxZWAYNWjJFQn+GIAfGYru2VmYt69ZJmk2OqaT25ngUDeEZoC3C
         jog2SioSnJt5Hy09NXwu4XCu/RpcGtxtHncgjuJvdtRW1ciKKbFX1HgCSFvS/F6ecoRC
         iTNoX85jsdX5ZVpsZiUQoC3CAxwbq/VonYWY5VOoSHl/9gT8UQxANxrqfk21nOHfmkcT
         ndP/hYhRGl9/ncMMyGU5d+cGVorufvBpmMnTEts4Q+Kdi/VsPlJsbrY7oBIwk9KuEE+F
         NIFmE9ACc98c4N9fh0A58pNT0bWyEbmJJXvY2n9B2dywExQLAQHrdgTd91rGFYbQFQlS
         mIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067779; x=1795672579;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKhWfAhnFH1MoQBYnntrqmndPCEzikmuR8uNGBngT1E=;
        b=dotq/025++A5V6Id1MXNO9Gl0pw46uW7iiRzXH9d4zo2miJuFLqO4nu0AzGtc56Lea
         PzeYDKa/+vh0tnhHqLGYE7gV7eFS/jqDQUNQgE0Fc4evFvKVoPGUPmZG2K2BRybh5akC
         S38uFk7ESQYe9AV+QnMnWmuVBKt2vy9HWSXEe9vcl+pJSKTQf29FHj+8Aq9Q1oufvzrn
         EVhqzcfyeJs+pf0YP+5THMP+ZQ5zr/YKea9eW2bnzgsYOZhv1JWi9gRsjn/1TXLDPugu
         W7H62ABBwXHRQAc5bRzXvBPDxUymFydhic+SIam/lT7ewfIkItFTi/Rw2nILJKOtY/EU
         F/cA==
X-Forwarded-Encrypted: i=1; AL+hErF+w8o5yLQyy2wJ4ITD19V7Y7OUPHmGSHlMqHuaGI2wWmfskDpsy9JYuVxonBxRaZl3zo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J53uCFap/Gu42uPCHi47Cq0bTS0fNsxRKJ5+CKj/an5JFki6c
	cZ8vgG8nHZ1hKbmXv4FdCdAfkk2EBH7Nmh5x7LIne7oaEbW4n73Y1JuDVeN/ugU9CLCGXCrT/P8
	vGvOkOv8VCP1oTgZWkItB68RK1ju5acc=
X-Gm-Gg: AYBFou2dvHi/992MPThxr4Y27NweA9QLlS7oI0X4OnpXGu+11ZgPMjO9gaBWAgPJ9nP
	baRCSpVsv0IzgoemUi8FoNVjRLyPtQq6vRZ+jEuAlf2Qu1Urj7v2NBSQkPILc/2r3kJyHvNCSIn
	fK1JthEOZmG2gEO7+QlSy9clWzF5iCY5L4G3Ev9pTOecvbLbTpCTNyv0nD3KOgLdESdiB6fSexE
	X9Tx4bu+0A49VpWCXSE9ALBlIak8MczGwC1M8e8Jm0zdQGzr7MlOSfDBSiaTLZmBzWDZCWPoCzz
	ZrqpSI3cBJuzcmgv4yo3L6rBPV8hEhQvLnjKXXUfFtFqKAHJMEiuN5nSZQT1O+XXWPlaasJGGax
	dWOTyGJqyLUcu27Eup7DIXREtjz6r9TfRjPvlmRyXgMuv2ogalVpyqA3kvdYlXS1fBLpGZHCg7H
	cM0XV8XndrbD6s4Xek3/Cqq9/ZOrwKMdK24214ZR+odt9Na2YyCYBi0RM=
X-Received: by 2002:a05:6402:4285:b0:6b7:a5a4:7205 with SMTP id
 4fb4d7f45d1cf-6b887eb1fe7mr3974112a12.12.1795067778960; Wed, 18 Nov 2026
 21:56:18 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Wed, 18 Nov 2026 21:56:07 -0800
X-Gm-Features: AclHuK9LKYVZiEsZnTp2j0Cn26lMdh6iKrN0JdwqU91MaVZZWGmReLPcsSb0KYU
Message-ID: <CAKSQd8Wcw-DUR_JO9YFw17u691gjNyvySwfhPW_P5P3ik=_tBQ@mail.gmail.com>
Subject: Re: [PATCH v9 20/20] KVM: selftests: Add APX state handling and XCR0
 sanity checks
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, jmattson@google.com, pbonzini@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

> Since APX repurposes the XSAVE area previously used by MPX in the
> non-compacted format, add a check to ensure that MPX state is not set
> when APX is enabled.

For the sake of completeness...

EVO processors do support simultaneously
enabled MPX and APX, with state that does
not overlap. (And several MSR control bits.)

--
C.
