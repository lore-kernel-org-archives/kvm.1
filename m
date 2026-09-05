Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826D2FD696
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569105; cv=pass; b=DI1hGxCBiE2Wn9/Y4Dve2tpKDOw9kIvwKOiICWKnCf/jr5HrnyrjxdDMSWPpUDwZ7P6P1ydSS3QcoylFf3vttuGQGrPp/MhHRNQ2MpQgRBqcJx9/2101j76G1Kwmlzb64nzkeF1iwUJysXS7bsuwjNTYpMocK7rVeW8Ham/P+9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569105; c=relaxed/simple;
	bh=DW6wbmUxstvUjLcrpQZmIK9RqXPWAOU7XHIXv6Rvtno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgVmjqNud6OmOZkpcSAgbVdk5Ri3wf7YBQf+rCKKOQXDn59LyABP/+H6rV2KnoMuskH7Y63Me6tsdGTx4E87S7cjfEVjLbFyIyhYFD3nOpM6E4430lCevAOlfxbcUPAJH4v2BQuPfsw0sWs1yW2jC0R1J3oGIYXDRMOXGwMov98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyI9fs46; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyI9fs46"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d8dso1791a12.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 17:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788569102; cv=none;
        d=google.com; s=arc-20260327;
        b=CfYex0rEQYt56gw3qfxM7jUGh23kg02qm+KlkrsaAwsD/LYbzKO8Om2j+1WDaXGyDN
         QZm0SCdnZmN7P0MA+pjYPxhzr0apOVaNCOk1BsYWk+HapE1o/Sbjo2qKN5Fv9nao1KMZ
         aYNihNXuOlZeMf3olCJpvcvPoesMzuqFOTcmR2ZdJyuH2CuPAOJ+wBdYQFtHBBkmgVAQ
         apE1KUMjTByijYuiE+2DkeCMIHOcUA/mcjUFtFvoFi+hvco+vCxjIBkNYcB6QD2rV/2+
         IcVJnaFQa6WeNKO6OHwqs0Ux0ESYVtDXetBLzXDAhzQaguhxpsDbULJiE2w4StkYN0xx
         B5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P0qdXiSaaoLWSkRGl4kXPpi2MGKhx4sNOFo2eMkbT7Q=;
        fh=35vyJMcf5v+Mfs+tNc1KUxIfe+uTnCUvakfaa7qAbVA=;
        b=qfye+s0+6eIGcjW5a3WR9VuZ1zlmd6h9cXFcnxw0crOmrlFsRgn/++sDA+YBCOmUDS
         RaTl0tkKiCpN886PWi+2DJ8vKp5UsUhuoCZ/y/YHF1bVDlkwlgXTLBkltPcnaBLSxv0H
         h3YTIRZUxYSOocV6GddnAfkEapu6VCwM5tpELFaMXizTbBV80ZJsCp0eCjTtDmyjYQa3
         9beZURmPikBrffEUR4t1F1+MeA0fDVYw5aGs3/SujqWalqVCAogTULEL7fCC6LhXOMU4
         RXZesgIBvHbJiDJ0zD1cI0LHn9RpYIT7kg3Y7K/006LygRfJWMUFQceS7QFeOIVoSq6y
         QTyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788569102; x=1789173902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P0qdXiSaaoLWSkRGl4kXPpi2MGKhx4sNOFo2eMkbT7Q=;
        b=OyI9fs46s9KMNJD7zN0urJ2M2pLl4IzvJarbo0V33R8l8ylqpl+3wEZEfwkXElkoz4
         21yBThMXt8LoGu3v2xbogXWB9+B+xIUmd8M/qipodHejCfYlyS8hdfd62LlEOOk+xqSg
         ly5l3fjwbyDs8MRaKow1+6UyH/NQ72+RU31PfGmrCT41jPfib50DlRzDqjW5Gn2067sa
         w8paSdpGcdO9f1XEM18/kNr+aGlRQOm04nKJar490EwIxSOa2dFCDem/CHTj7Vs6hISm
         EMtPPDpVU2jexo2y48QtYW0/C9aJ81cO9p3gTrvVpLoFx7ILMVH35lVkRYv9HbJlrs6k
         BkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788569102; x=1789173902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0qdXiSaaoLWSkRGl4kXPpi2MGKhx4sNOFo2eMkbT7Q=;
        b=UsLlJYiyJL+1+E22s7BYcr+TgW0KzksyTYQOQm0PVWN3whUlr/ZFmpGkLfzdbYWbxS
         q+AAnkJA5lV2B9HShVUZJmlXBZPsJVTPBLRYmWONCFwc4qBi71keFdHXAaigyUKo4KU1
         CDVfCP2hzeO2IJL+GTkX4HZYvTV+if9NAofKsTK6IUr/q/mT2ZGGvqlCtfzP48mfpPxp
         MsTBJKiWkqxN4hUzPwct8Kd7AmdbgNlrb9afzoqG6jifE1znAHnoOOzOpS9yYkE5sj8E
         6gjXvqbvEn4Kfdt6rtitaq4p6x930mc3ke2US1QSCj14lYYRzHekzP8MRDVkbc52pHuv
         XdJg==
X-Forwarded-Encrypted: i=1; AKwUvBwUrag9Q02i/J3jbXEz1cxwJmtCGpL6dH01hFz0VyU0hdtHwlmooT6NJKML/QrSDdizbhE=@vger.kernel.org
X-Gm-Message-State: AFuF++mY9tX/Z4DZnZ33pJ7yIElQsM+oqm7fEtSGApgWEwkykiJPP9nJ
	P5FjFc2/r/DIvga59X8XGjhXcYgn5fbra9rq/viuABlht1ksmELjzX3XvXSgbsI5Dd5fevMgLKI
	ipUcq1QZ43avFmy+OIuFNsS6DHR8LyS+wk8nM0Xrb
X-Gm-Gg: AYBFou2QqqyH9TnHO/9i3zIAQ/l80ZnJwACS0s+9iYUofNsj0ni2uRU3CTlCUhxoZE3
	llMqAyNszPTUiWtULQ1FInV0gtCVtiYCbGRPGbdYb0C0r1ebU0qKZri85DCPdlWWeV1z4pBtBMM
	+4AAjUcNNhQzJhBcy77htpPl/SbMonjvkTwUc+5Kk1pF9k5BrEmTZzEN2phshAK2Ru0v8VKUS48
	mtd0D47WoJAaWlnh8knxP/dQ/i6YgC906YeVEZKedkjKtoEf7adSVAwpVcJNbrZSkhUEF/efqIL
	42bVYqfCzAu71wTmywCFoOA+2taq5+HZAjl6Whf4SYXQDI+x1LS6cFM=
X-Received: by 2002:a05:6402:1a4c:b0:6a6:9d10:f52b with SMTP id
 4fb4d7f45d1cf-6a7f682636amr13303a12.12.1788569101906; Fri, 04 Sep 2026
 17:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net> <20260824123954.315112-8-zhang_wei@open-hieco.net>
In-Reply-To: <20260824123954.315112-8-zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 4 Sep 2026 17:44:47 -0700
X-Gm-Features: AcwNN1UZwSKJ9MC3qwJwI8ljAn8Hu3imGZF6CsHrJI6l7M3IeDffrx60t7WpNbE
Message-ID: <CALMp9eSTK_m4XMyBk2U10dhQo-ve+M8CmToVyFcS40o7RoSX7A@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] KVM: nSVM: Advertise DecodeAssists to L1
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> Advertise DecodeAssists to L1 now that KVM virtualizes the
> guest-visible DecodeAssist state in VMCB12: EXITINFO1 decode data for
> MOV CR/DR, INTn, and INVLPG exits, plus instruction bytes for nested
> page faults and intercepted #PF exits.  INVLPGA's linear address remains
> available directly from the saved guest rAX, as required by the APM.
>
> Expose the feature only when supported by hardware, as KVM still relies
> on hardware DecodeAssists for VM-Exits that are reflected directly from
> L2.
>
> With DecodeAssists exposed, QEMU configurations that require the feature
> (e.g. "-cpu ...,+decodeassists,...,enforce") are no longer rejected.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>

Once the implementation issues are addressed...

Reviewed-by: Jim Mattson <jmattson@google.com>
