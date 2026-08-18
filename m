Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D17440A19
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075759; cv=pass; b=QREnuNgJ2ICzAFLN0kc2KM0pXogulANnyBwaaKnH/c9877UR9926tFYxXtG4vHF7hpWoWu1VNp1cAHXeViPe6TP7DexfozVYg+0iJpB6h/iTPIVZWYT4HGtORLHiH1KjE6qRxo6/Xu2vU9oEdE5ny4bSO4ZAGW7yHL/cdrWst8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075759; c=relaxed/simple;
	bh=O/48gIa2vUi7FxYUqNtDfgAuIWzA1oYF6+91I1abQAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alvWbPd36TVhwQlh9qNMBc1JOHsGG5eFEvqKCU3xQKCKMWkQMmW+bo2vfrJeOwxJwNzF6rHR/zOYS5Bmwpq6wkWcsFwtnPyRG29xBZipQMVgkqReZsNrlfV2BBTAjEX/esH0dxpavFAP3baOHntZr2Z7CEPkiFdzACgsLM4LfmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRAb1drG; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRAb1drG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-498012a61f6so61105e9.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075757; cv=none;
        d=google.com; s=arc-20260327;
        b=g4Ly29aPiQIUfzeyhuL+lqV3wf53LMTxA8Oy12ZYrbRtWtKWTP+CMvu9JCNwuyY9jr
         X4AAO1nQukAM87uoEgfl4OAWz+tyk4Zu0+lxRif7Z4JKZT15prIV+mTdsCGovkC8gQUa
         5ttu17K79c7I6iM4nz+rPt8R3IoQ9pqp2YGtzGU7UiBDam7bfNd9W4zuM9HD3YL9D5hq
         rtXLq8qFxHincO0XdNj2rgi+vsDYOvav2dzV9JdFlrFRPKn+Jr0cpqjUCb92xFKvOLUT
         kxf1AGVLlsQxsln2PCgLIAsklHGKX46iafgEU4h7tgZKVnf91sj6D9BRnK+pTltLyeOw
         v4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdwPE7pm0zYRhFo3gxRQ7Z14QbNNHShboTJ4Fwvcgk8=;
        fh=1n7i8XpDozJdmKnkQppUvORMVSA0FUrmBpMjNEv0vwI=;
        b=KxNK4J4gXtIcRiwmJRBStZG8YLwuqwhJ6klf1qZqRX14GnWF97nTYPpKTxgjt1I516
         Sah7rnNkAEiY/A1PJleEV/6o40+JX3MEEiZicS+B5WDuKlfWbQD4dlKB1PANLrhgqIvS
         ihBOHZAxRJqdxhV2q/dJ+C9enZVcK28+pmTJ5LXZLWvxltPhGrS9955BvXtLft+A/aqV
         6C2XmQFq9+rbBXtF3H/hl5wOToGhblFvQWz6RQghAj8MswwgndZ8bwZH3G53BVxoGyYj
         3i7RxOp07fAPWYPa6A8F1xDXTvoemQsiI0Pdernk1hMW2fxMY9eWDhULnlNjYxOEO/Cs
         1MGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787075757; x=1787680557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xdwPE7pm0zYRhFo3gxRQ7Z14QbNNHShboTJ4Fwvcgk8=;
        b=PRAb1drG8c4phefl4H8P5Eg3+1XDJrnN208y9YJ1Qr8wfEwZQvlmWB/x9Hxnmi3va/
         3H9aTmlpthKY6rzY+kFe1OpIpSptdemZBvNelvCCJXvkJjdCJHWTs+3g0S7tbjD4v1cJ
         RXXSuoYInZB7ARJ8/UuNu2UF8/YwuZ0Zv3lbe+pvgeLInf4UTCFmBdp6JMHwiy7KgFiF
         eArkeEhrcRfLRTT4nFkHFKPMxpC/FdttZV1jVibfo9fv5Il54jaMr2ZhQARHx5ehXyoy
         +0HGrqeYs5HdFN55fqjpn9wEwynmM/n21X/aHm9TpRE5Ivm2qsBcHWuWG+xDpXjc0l6N
         dWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787075757; x=1787680557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdwPE7pm0zYRhFo3gxRQ7Z14QbNNHShboTJ4Fwvcgk8=;
        b=WYRbbjDar6QxsKwxWJbeNH1D88jvAsjdIcTYOhL1rcWLObiNW3vGijiudcWwvGW2eS
         RwxTtpprSHyU/Frufd76Y+lML03hhg1D5cf9dTGhIWMfzUeRwpwUpn6t/vklhIgiSx1L
         +xnLSLGLGPTp381fmvJBgtUXUGZGAXgjWsLso1A7dd8qEF0kEmSaKhlVB7nJ2jZPNpdJ
         BhQeqIlUi9GCXSjCXdwM3RppBdO02WIDjhoEa2Y49yUb8gwcoygaC6HqXGPvP1cYWSRx
         jTZ3U9DrsLleUhFQcRk3eq5YSs8qC+yBk1PMrpuECJppusix+JRo9s6AsDwqsQru+odl
         5zYg==
X-Forwarded-Encrypted: i=1; AHgh+RrCHLmCbxCSv8+W0J8ydst66u1aG8MBk358Q4Q/eNtq4/9xYA5xFo0x21VWrrZluJJ7xvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHBSzV1OMX2Da0QdmnrOLtJ8tyi5ZoeltIQVzGLyOEjVFDPVx
	vivlFCQvYf5vDHTPNVgwtkU1Q4/PAYE89jLExLk1QExZWUW2fQOo8pxkm4d/+IUzf+A8Lui6xxa
	8C/PD7EO/HZGlySHb9hZvTrGmny+OYY+V06KjuoVX
X-Gm-Gg: AR+sD13sUq/o29AbJuCRVLEPwbjsXLkUGwX5J3v+qll3BUvEKJNrsHT4TUqUHZmq6vj
	u9pfFHoyBLm7hVE2vhme+hn9aBYDIPYTzhSZiBS4hE9tvzf6lcXeL/h2HIQzxy5Zgbi/zD0xZ2o
	IO7t0AodyUHws9G42mA2wZy+SynY9xUwyj7WJOyt7EIlHy9mVNuYdYUyuLwUEFgejM2sFXRy0Nq
	zj9GJUtGTjiEPoXG+QVosT3IoUI19q9ppmYB5t36DOsyBWl5ptPh7UUSKiXVbWslx+LZnuaG/EM
	LVCcdglS/7W9QKEKBVgCnPHAd22MguG+tc5kew5MJoHCGXB++VclbpJaSKNmjqMfXGV5cREA7Pk
	Rdg==
X-Received: by 2002:a05:600d:8445:20b0:495:76cf:3bf2 with SMTP id
 5b1f17b1804b1-499a2b6ddd7mr990425e9.5.1787075756253; Tue, 18 Aug 2026
 10:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817080759.25601-1-likexu@tencent.com> <86qzjxyvpx.wl-maz@kernel.org>
In-Reply-To: <86qzjxyvpx.wl-maz@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 18 Aug 2026 10:55:43 -0700
X-Gm-Features: AcwNN1Xge_o53aSOcYhkgsrThZL6nmQlGNWnTD1LEZPHs0U-nSXTMj9os8NN8Fw
Message-ID: <CACw3F53-_kQV34Rtjc_ZLnS8=SNyPzW5PfRbczEAGGF2oRZ5wA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: arm64: Skip sea_to_user without 1GB hugepages
To: Marc Zyngier <maz@kernel.org>, Like Xu <like.xu.linux@gmail.com>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:53=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> + Jiaqi.
>
> On Mon, 17 Aug 2026 09:07:59 +0100,
> Like Xu <like.xu.linux@gmail.com> wrote:
> >
> > sea_to_user backs guest memory with 1GB hugepages but never checks any
> > are reserved, aborting instead of skipping when the host has none:
> >
> >   kvm_syscalls.h:68: mem !=3D MAP_FAILED, errno=3D12 (ENOMEM)
> >   not ok 1 selftests: kvm: sea_to_user # exit=3D254
> >
> > Check for enough free hugepages up front so the test skips cleanly.
>
> See my comments at [1].
>
> This test is totally borked, and Jiaqi stopped replying. It is a
> liability, and I'd like it *removed*. But if you want to fix it,
> please go ahead.

Sorry the test was written in a way that is highly customized to my
testing environment, and I have been occupied with many other
work-related tasks.

Like, I can help review the patches for the test during this weekend,
if that's not too late for you.

>
>         M.
>
> [1] https://lore.kernel.org/all/86y0le9cvz.wl-maz@kernel.org/
>
> --
> Without deviation from the norm, progress is not possible.
