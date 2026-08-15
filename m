Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD66355819
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786780579; cv=pass; b=PjXanVlBQOk5nRQT/8+Pb+C3e7SB5WEQxRrqzGAoEI1ng7gcg7S6IdqycxqDthYv6gVAEqVkAf57NOqxMT+By1Mi63M+zueiHvG/bee6JDnhHo5GhIBxiI63A53IS4qbLWPAjhOxdG7CHwJe8pyWWvMwj/0VQE5IcklTXqJE2k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786780579; c=relaxed/simple;
	bh=oS2jgexovXKZsveAUZFioS88sWSaj+0/57ed+61vT5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1fNQY7ShsPLdTWMhNCuhCo+n03tU6sV0HggKKQyRD7Tn30pUHqWKturQMDaO2zNCX1UB5rJTbuDIh9dx46dDEBe3GcUFjgB+1GYIANhtFeKzghBuYMnxEqyYOq7DC6eD/vFJIRLgRTMnAdUDvJRTyd/eEmjCr5NeSjVNUDgCdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOUyu68l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=geFy/E2S; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOUyu68l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="geFy/E2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786780575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oS2jgexovXKZsveAUZFioS88sWSaj+0/57ed+61vT5U=;
	b=aOUyu68lIf/oHgojW/jdS2UYqGryGLMTS3KAfnk30Vu3HLEB9D1hiL0p5mVVR7wiJXGB78
	r1DPaiLhbFYl38qOBlsu7roJ6YF6e9WTTf36QSg8JCa7K1NFYp+xhu42mqRfdx06CcvJEQ
	RQsHWmhNsFAqLZMmQuNXqv5B6ApHzC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-foAwsCwMOZuEymKR3yH8hA-1; Sat, 15 Aug 2026 03:56:12 -0400
X-MC-Unique: foAwsCwMOZuEymKR3yH8hA-1
X-Mimecast-MFC-AGG-ID: foAwsCwMOZuEymKR3yH8hA_1786780571
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47feac2021eso992043f8f.3
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 00:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786780571; cv=none;
        d=google.com; s=arc-20260327;
        b=K4B1M88y9sXDV/z2eZJWSZ/4YLuxvky5Hi6cA0L+ZTshxGeclvbeVwPO/z3brPAzxR
         jQV2V/csjXKL7nQ8+tJhVy9XzkivYLcYegn3ftd+7SnwZh4Wz26DRPI7GcaTyCVUTIZe
         TVjRBMdjt2vVhYVhaCCg3FY8wAlYRsB9wVmiYV0b6+27DvhVtzWhSvNAx6ey5jJWpvWW
         0pnAzP09hU2NiAPHD9EoyMFBkz8rqR6AEGZbLKkQoiWLCqiYdcYmOdrCotGT3KnLfXC0
         qYVsmMmYwjNYb+paYOmtjH0+vNpX4X0bVNaLO3asVjPuPhzxkxt9aAgRGMhlaaLfaNp1
         ag5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oS2jgexovXKZsveAUZFioS88sWSaj+0/57ed+61vT5U=;
        fh=uj2eFdtsQq9D6xSa4uhD/OaMiv2Kk3vBe3bGaaCKM9A=;
        b=Il1MKH4LcQvIfZmFx0Lf78OugR/2es+1d3dcij5NqcyPmCCnGFKJyr/xlX7iTRdOyN
         AUqLpNYwDXHMg7Ph8AxeafKBNUEN+xPvTljrUl7kEbxVmri4qEnhLgLYlQaeBKgwbLqD
         4Y+qE/ZYvpn7m8x1/4xol+FX3NYs5a+CBKt2uhZnQMK5QvXfAot7yAncNwenOVsIrfRM
         E+gob6I+0dAcBgL+ZpmniFSL64VvO0BGpo5hWbcNgIDYAHbJgRtaFchVsFq6tzxQNBGe
         nsG07IHYoJWP/HPbgLSAKYXabPNdG09AbUkN1EYJ9KHBvhTOF/3QtBwrCvyi6KQ61oZE
         aUvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786780571; x=1787385371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS2jgexovXKZsveAUZFioS88sWSaj+0/57ed+61vT5U=;
        b=geFy/E2S0UBXaAhzhc2FqD4EUb3FhBC3nzUHKKX8bXcmtv2R8X3CxIK9sAGUeNAvoM
         hLXj1Nez9+ZBQXl6+Llj0sSkPwksRkBOc25Tnnrr41QbDug2ti8HbtUM8XIQazXgG7yW
         y+ktsf2k89srUNo9Ydj6G9vQZhQOaCoowoPTNgvW2aiD5rfPNtRQUsD4gpCU7WYlMN79
         QFwFkqG5gtY/oV+C/5ISKMZNkvNZyWwqWuXud2X9haXbC2OI2B6n6wJzEkRuvo9Mhj5y
         7Bgb92I86r6Xa+1kuVttoaVk7A2A8m+2Kb3ceNjV4kczFwTqot4UyPvUhAbPe8pZxa2s
         f//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786780571; x=1787385371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oS2jgexovXKZsveAUZFioS88sWSaj+0/57ed+61vT5U=;
        b=ctDPey5jksGraKrOeMkaP8eABOR0MMS7Lx3SoqwCQBK877LFl0D8yIjlv8TG3GLZGs
         /gxP9tfd+voO7oc2YvmpGnAenOVMdQkFQ3alCpKTPHnCDzSsT/r76qu3QuzwMI6DLkfv
         zMaWN2SYP4Ab7d4m40Xgghlj9TwAs0UWI92o6l5smQbEj/qRZywgfbe87GkXEuJeM3IM
         WcSouyXJiHr3vXRa3III8FalSasV5bYs/ZYXRZuQXIjzRcSqBQayDpvPAdKLs0IMiMZx
         ePg/vATcERTznHi0px/K6SP1C7u0axw4VpydMZNs7jb950d0vpghuySD3KJWi78Vyouv
         alJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzCWxXMHSoCSPnwMb8VPODt2bu7e8UrjYXl8l1uYUDvgSjWcoUQeWCm+/aG27/2yMz2Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2SX0EMj8Z+j0JOhhbYlc+Kfx2NegAozrd2tKp93IBbYkuQV/
	PzNipd4eGjVd/ncxtJele/9D5ocILBMhcB9U9V6rohjYr7onreKQrpN6b2NGu3d6NNxcYYPatfE
	zMhF2BSzHzKn07Y+nO08mTT2bqiruwfJIqB5NvxHnI5BP8lbyFJM5LqYBhsqgUE/V9mEGNA6oON
	lIwd8tw50E0zfvVqGfdTwWpMKC/pHp
X-Gm-Gg: AR+sD11Sz8Zy4K+h+130U16Y16lo5Zisny7QNVNV/rXq0kgR0UPB/4SIH2TGotsvRyc
	muGq++EgNyssY0kGDRYY0ZrpI0QftwCx166hEcBFtJFSDqbd9M1Pqta6Q5B6k/cP+ICjAhfHVps
	FBDfbXeLbEwab5gADEGOZYLsYFo3GGvtGDdeKhGrTYPGbEvb0Dd2eDpERRqZnOR7dGE9c0P1Ags
	kNnV4kmJzX8z3fE2ipxCZA+9gymd4CM89WKvP3nQn18qE96v20PtY5gQAw=
X-Received: by 2002:a05:6000:985:b0:47f:f3fe:1ebf with SMTP id ffacd0b85a97d-48160760ce6mr16878669f8f.20.1786780571039;
        Sat, 15 Aug 2026 00:56:11 -0700 (PDT)
X-Received: by 2002:a05:6000:985:b0:47f:f3fe:1ebf with SMTP id
 ffacd0b85a97d-48160760ce6mr16878626f8f.20.1786780570616; Sat, 15 Aug 2026
 00:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <2c501584d34eea17016d39c9a5f78ca3d60861b4.camel@infradead.org>
In-Reply-To: <2c501584d34eea17016d39c9a5f78ca3d60861b4.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 15 Aug 2026 09:55:58 +0200
X-Gm-Features: AcwNN1XX9MMOhRVIngXaFGbeTok_aF-DF_lHqqKCoRseS6Pn6J0-kAtMlyPOwLY
Message-ID: <CABgObfanoHLfdfNshuLCHkWgtsP5Km9G5WsdwfGBcLsJ_LKD8A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests for 7.3
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il ven 14 ago 2026, 21:25 David Woodhouse <dwmw2@infradead.org> ha scritto:
>
> This was intended as the safe stable bugfix part, split out from all
> the RCU and rwlock RT fun that can come later:
>
> https://lore.kernel.org/all/20260811094829.98794-1-dwmw2@infradead.org/

Ok, I will take a look.

Paolo

>

