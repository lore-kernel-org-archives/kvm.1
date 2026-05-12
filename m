Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BE349B1F
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619625; cv=pass; b=OWo1neMADDzgTXOoMN5hTMjor5nE0IYGoaqaPXUr8cFoFyFGqfXRK4+yGib66NYZIxXUH20QBMV47j494EbtNclcRwlihrVtIAV9a0+9Qe78o+YzAXHHdOTCoNhQb7yy8IayG4zxWr0RbBaRDplyM0orPVrm8kcCgxuJ7b2UQOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619625; c=relaxed/simple;
	bh=yjcYpwM0bNWA8F+oMBSlbnJX7nZ+1khq657ozFenk1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YM0iPMJcI/obOH2N6NAv1LG1XuQwQufBAra6RO2LnwtUaUV52TYzpvfmaC6ZjlWx9TQApKYbtzu1E7g+VxfVt/5y53pOhRtI6fJ19i1RM88sWonX0b9sHulxOOyJZjiLyDraOuqxHHaQVHHp4N8NeG5O15oqiKaJKPc5QRSKacs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtkDglIZ; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtkDglIZ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130c9dcbd25so5675154c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619623; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4WJJ27QW1a6QAQXBg9cjnvbQm5H+ULzIr9JWWVOw2n0JfB0mTWyFD6BugzBfZdh/Q
         2qlQR2M64Qk4jIefy0FPo82V0GxbXk4VPnmniILA8nzGo/gc5HxUHTPm3PH5mulEHDaA
         YDL/a5YB97WlE/iV7392Ac4vy2gwHaOMA/vHc73p3Sj8wcLci+lGLgRSlAm8adl7v6zt
         JBj9ZMTw3rf/NapgFeuT7ihJX4/qBKVguLozJPeUCyEF7oWjvbCMlV7Ogftb+GC6mSO3
         WEcXO54uRBreK4W9AMbzBCKqao1PTas/BJyg1GKTiq5isEWqa9GgJA5Xp1oGlJCNkiBY
         aXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9t69VAH4Nc1O0MVDyKt+JQMOR1DA7dJ94HBiu06W+HM=;
        fh=XTiv925dEY+zcna4Wv0j3M4k/KV91314FUuTYlASvCY=;
        b=cCQswlK9tOuwqP3Dy9gHMt1enDL9c9Js65Fg6FrIIiRlXMBCOz0nf5eZVLKF3YJENS
         NH7R2y27iHVL3tP/OpJFq3oK02rCRmSlpGGYBQIyJXZcI3wMXxdxJ9NdZeay/rvCuReN
         p8DQTiAHPYn768OoC94bu4FHUYzdIFszJ6xLdOrdSKDEG0HF0xmPHu0TllYfs0msLQ3M
         uPWZ/Se4k0hXxbx0NICUA4ZA01BobVmPm5glLjC1Y/djEr0gYvxpL9mjCV7tubx4XQt+
         k5btIFtJnm9QR1AzPlgnd6gEkjMEHKUE+J+NgtmdIv9dGzEIEOAlfcVKdsxtITs25K0G
         VM4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778619623; x=1779224423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t69VAH4Nc1O0MVDyKt+JQMOR1DA7dJ94HBiu06W+HM=;
        b=ZtkDglIZCzMqVKlslcYeIWa4fMw4MlfV3oJMtM7GZ2rJgye9v3/aCb0QeVVybFrecD
         LdqF+odeevCXDg0PObnnv6axovAqnZxD6oE2BoKnUaYu2bNIsDp3VIDcd688Z0GaXaBB
         qYVBW2SBFGc3gr5bDppXMY7o6bc0GrBoWZ3ZFtWSR3K/+2gRatWQBDK0HpxI7jtUiUZ5
         emTWLpM182MDLlaeuE4xhSZYBfVwzDKeXGs78Zyc8H4gte0WcUEHwsHN81NKjkFaACnW
         aGdo220EYBmd5Cgvx4idDSTfr+1SahlSMxVT0evJNq/dVMy8lbJhuhUuIgwayd7gbH2C
         9tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619623; x=1779224423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9t69VAH4Nc1O0MVDyKt+JQMOR1DA7dJ94HBiu06W+HM=;
        b=LIAhT4J5XJdxb2hVZ9KEgJGdSpldoXvSqQ6vGaM+iiYQiyZatq29ChwE9K/9S+3Av8
         GyfGhWKE7b8Oipsf/iP/AWWiJ47voXKW5low9EGJMNO7d9qEOcQgyos54uAdnyh2uldN
         zbseplx/c+UsrQaP7kiE40ZT9pmfVEyaeZppkysL7jwy78lGeusONve3lIn9slirrPJW
         iGyf0nAJ9MZYx9nSYJK/AmZMzz4IuTt+rl/3zJwXEtiG5ecmH7zjC4tqvq/d1dUH8zpy
         rWxndoL2SB7UXLT+o/oc5ETC8rSm4ChSbR3W+nt2ViwmMQWwuri2soRWCMgGIs8l18L4
         YJuQ==
X-Gm-Message-State: AOJu0YxGjHDk5KOORDOgaEdwP8wSSXEliMFDHtmY+/m5nAlEkEjRQO62
	elUOsCAqrLmNtwzxcNTjAx7aaf/G1GHO+wA0y9kOFM4L7VN0GJvokfF17URktOezZdpdTHsY+gH
	txjQzPyA0DrmzfHxCRwr/3wHvHpCexCYPhfhhaJpd
X-Gm-Gg: Acq92OHvyjr7iNf3IsbRL86VasQaYe8tFwD7GVzH96PdvcWPJLTLHmjZaKagc7ouFm0
	oBfaLOjGEn7tTmCLWGKKtSd4fVeIK5StYq792r4H7uFj9WtjHJMtirB0wEslbYSEB6KyaW/aNEg
	hSRUQYrq5LuF+lOK3MV2RkFtftrqJHJtSMMIzqC9ExeGEwn9JF5g8z9SznSK2LZ0ZcbiK5sE9ww
	nq6QOdfHR30p1SzBC2gKUgEm9wso5VcCWyNI4ts53it6zeqKcHLv9sUyE5fHQPRjU3gn1onT7n+
	TaEytm/eeKe75+prmTM=
X-Received: by 2002:a05:7022:2394:b0:11a:fb0a:ceca with SMTP id
 a92af1059eb24-1333b2d9c6bmr3134966c88.16.1778619618598; Tue, 12 May 2026
 14:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com> <20260511234802.2280368-3-vipinsh@google.com>
In-Reply-To: <20260511234802.2280368-3-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 12 May 2026 13:59:51 -0700
X-Gm-Features: AVHnY4KwNtssIpJT8BgW9ND1vjmOC-DKwSQu-Dn5zwJb7fp396v17OflLbojuVc
Message-ID: <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, 
	amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 4:48=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:

> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index c12d614fc6c4..019de053f116 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
>
>  config VFIO_PCI_LIVEUPDATE
>         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> -       depends on PCI_LIVEUPDATE
> +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
>         help
>           Support for preserving devices bound to vfio-pci across a Live
>           Update. This option should only be enabled by developers workin=
g on
>           implementing this support. Once enough support has landed in th=
e
>           kernel, this option will no longer be marked EXPERIMENTAL.
>
> +         Enabling this will disable support for VFIO PCI DMA buffer.
> +
>           If you don't know what to do here, say N.
>
>  endif
> @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
>           To enable s390x KVM vfio-pci extensions, say Y.
>
>  config VFIO_PCI_DMABUF
> -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER &&=
 !VFIO_PCI_LIVEUPDATE

Why does enabling VFIO_PCI_LIVEUPDATE require disabling
VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
but what specific problem does this solve or simplify?
