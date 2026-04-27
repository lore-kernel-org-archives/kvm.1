Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADB3B8939
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288969; cv=pass; b=pzVCKDxaMvEtdvJMq1hAoDBtyj2SRuubmCZQyO6mWcxXwX3CAhooKFouxNcpPhLcRY3Jouk9RQAYzVhDyEVTsweQ+P54BQ0lQHnyBfjPd7B7PVupfRFx+Aolk6b6CXRDeKK0HjfSFOLFJBKSUxUAldyxel5MrOpXrS1feWuwu28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288969; c=relaxed/simple;
	bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkuz9BWNeixCvyx59uwnIBRf1inDdzDbVKb2A090WKIaCe/PeiiKayHy61RiV5f5/ZNXeEghNEPhM2KBfT2m7ahwXa9CvJItRMSAtZRNqpmnxZOetbmayCN7qc+lLxj9t+VasTFOVrkx4jCpYnP9oLbC5+2h5O2Y3e7UWDzD3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m03wDaaz; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m03wDaaz"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65890a6ca20so947772d50.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 04:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777288965; cv=none;
        d=google.com; s=arc-20240605;
        b=PX9c93+6vnAH44dQRCTeyfvtiguj6f6SThKVHB+03cJvqmo7jufjLHNkTTG8Yy0cVG
         lvWOVkrUUj4PCOYI6woXCh9y80166MeEQLJl7DnoByBnl6A9T1HYD33uvyfc7DYuYsHh
         9P4Uda14jd9k9fwOG5bgUyXxEIwMLHmSbzg9lCA7jLwP5kn5rxVzMtMn2O4IjIABlZeV
         RLsFhWLOsfLzhYZ6SfN3s58cLow7uSma2RULfgFul+fNtFZFF0AGiej+y+cHvyKJNG0D
         8mwixQoKE3RtwsaD6mXjgA52UmOYDX1TxDvzgqaOkXdHEp/y6YDCJc3ddBntvAk2F4/O
         9qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
        fh=vmsEmJOLoBYSF66G4wAzejmoRoB7/h+1tx5QCiPHTJE=;
        b=WoRbGGwc/bk3IeKXJnsxmGYvQEDCPM7vznSzjYtoZc2UVXrvBHpvheWvnRX3+90mYI
         B+Xcy5i5yNAyG7qSrgwLrKqs/55rKFxUwhSF1z0vB7DceumHUAquP3+00zDZVjjBtvLZ
         8fvBGpQ9PdACqK+cIzdkZ+kpw1Mfy+QEnL6jKL7jrIO5ZeccPPEDtj3RgcWMJA5raqcK
         Phf1bS2f1RYh7SaXxf67XCBsHAB93EGDurk3K+UDPp8p/GgMbaT0rh7QxkSKElp2OBKe
         4s2Mjl53QGNtcdCWjzVBzGczTZ/dvcUgeHQdpXwmkn5WsHTW2vhWtMNTpGCogkDtAhSi
         N6BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777288965; x=1777893765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
        b=m03wDaaz42Ske8BcwZ0vTRkAfMeRFFfYFYu5F7gx7t6pPn4hiuQ2H41jFsId792gAK
         QYzdcQgjlYd1RV7saIBiDpYJJs1ETkNYwJNhqwsJq+2iZvVTV+Lksk/GXlJxP8un0eR2
         0BYJw6hJFOUGr/jZSd3W55gXb/jdTAPOBKRF+0+zKyIBdmAPswUm3z88gk0ICTu1bUOD
         cBREga3QaQYULtBu41gx1K7xUCqB8t1p3OR6xBwvgwhp+FqSbiG95FnlhkMtiKlXkhLN
         TiiRMxF61bLhq4Y30P2QDa3TBoS5WEAUQY0pWRGz6rp4ifYGiKRuXezfilUa4caUjseA
         FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777288965; x=1777893765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
        b=jGqNya97aDSZVNRjEU7s3SR8fMwN00bglnj50RM30/zp+wB6N5NF1VEgjcrZwRRbwo
         lUQnnwGtuJPNPR2il76+ki7gJvHwOMfXdvOklY1++Nxnhsqg6pue2T46LNEoVfIH+93r
         XELdWnU+uxk17ptBtjk05szo946necDkgqqinEzhzDe5SyWbvjRjlj1jxwsdY2A6FFRx
         MmVscPgDi770IAK6G5m60HrspxyA6yiT1TBNhjNUsLzFCLD26lUuts6CP5yxsHyd5RWB
         KSoMU3fGcNTb20D2elee/ZNx+WDzsNds7KzQpN6TLj2pDj7NYnIpPKjGrwoYt00Ytfpz
         UPbw==
X-Forwarded-Encrypted: i=1; AFNElJ8z2lJR/xz7+WxEm37SeUyCQzIkp9i0y5DHyfukWGTn9je5MvgT+QkoHgZ+WZkEhoRYDwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLY/AFjM4Mx11rBOO5IjRf/tqYWE+f/5azqvzZQDXsciD82WWB
	bDCuohPiMaGOqNjZu6YwNx/N2ueHgIzuJtjGZVlneQ6L/Z30vjnO2nqrU+2SZ/AT2kEsLOJBlh9
	7H4jnIXAXj/ba2oL75jyja/FyhaSNHB7RFMQ099QnkQ==
X-Gm-Gg: AeBDiev5fIX3hmA1TjWcZmP8Ik4uhLuNmlJbYa7ZfDolrMKu1g0abvDZoNRre7h4bgx
	QsiTXvPRLIDfqDGDHwrh1UZ8Q4hGDuHvSR/c4fOFkRpo4L42cVwWQbwj0yTQ2PeyzaH+heFcZle
	hQ0OJuWfO13m7RwEDLKklBoFDONo5Dge2bd8w0dzOZcsX4pbL4wPHtJTJwU1Hn0BiJl1jfHWj8M
	9JKuY+N3MO+vDMlgKa9/68OZyhYsPfpxLpUYUMdnY//qW3DvOLbJwY2aCYasipafaZGayn8WLaC
	2aVe9j5Ge4soZG5S0jJVf0OaK7egYV59j0S+AsavtOdMZdLlj1ugJfzMjcxuPauAYg+mmwQa4x7
	mGA==
X-Received: by 2002:a05:690e:4192:b0:652:c12f:18bc with SMTP id
 956f58d0204a3-65310a3a628mr32618634d50.43.1777288965320; Mon, 27 Apr 2026
 04:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 12:22:34 +0100
X-Gm-Features: AQROBzADG4QwKVW78l2Y-krxUGH0JZTq2v5PrDXl03f_kk4zSO8vVSythrH3RFc
Message-ID: <CAFEAcA99QzC6D=H8jet0aLrp1BByhOq9x6T8bUJ7SY6qTvoWcw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: Mark host feature cache valid last
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 13:13, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> kvm_arm_set_cpu_features_from_host() treats dtb_compatible as the host
> feature cache valid bit, but kvm_arm_get_host_cpu_features() set it
> before later register reads could fail.
>
> Set target and dtb_compatible only after the feature data is complete.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> This fixes a semantic issue I found while writing the next version of [1].
> I am not aware of any case where it manifests as a real bug.

We're not currently consistent since we have one check that might
return false from kvm_arm_get_host_cpu_features() before we set
dtb_compatible and then several after. But I think that the
right thing to do is to set dtb_compatible right at the top,
and adjust kvm_arm_set_cpu_features_from_host() to copy
cpu->host_cpu_probe_failed in its "populate from cache" codepath.

That is, if we have an SMP config and we can't get the host
CPU features the first time we call kvm_arm_get_host_cpu_features()
there's no point in repeating that attempt over and over for
every other CPU. We should instead treat the "host probe failed"
indication as part of our cached data and copy that.

On the other hand, if we do that then the practical upshot will
be that we print the error message once per CPU rather than
just once...

thanks
-- PMM
