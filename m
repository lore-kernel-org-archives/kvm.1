Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD546AA88
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708601; cv=none; b=KQJrUJ9h1XmcTnjNaI3OLeF4CO4yLZCdI9hLFjswvxNwm+Tcd6dsf8PspCIMKJNtvArA2kxGnHCjUoSCzJVHHFKj39BEm85INdDcwrUWqU0Oc/0/hfxXualG+kMKUx5tT9bmi0rbRselLiQBETkqvhhOE99y0xOqkNVbKoNbRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708601; c=relaxed/simple;
	bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNW4zFKgUgV1B/IZgCMR+SfPBAGxRdPNwP3xKKvor5TXLHYaZ0q3XfXHssHJ50mochH/4fzdi7kSi0YCXe7QWWss5NqUkdV28dzhaw0jct8yYysboVbtiu4FPKMA9+bFjLVqsEO4svDRmz407ldZ+v5V1SH4iPZnnA+II+k0xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbhDcVGb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbhDcVGb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e507b079dso510817b3a.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708600; x=1787313400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
        b=nbhDcVGbRY6mEqtji4ay7q2+IgyyPEQWwJJNfssRWJArWGGxQ5FF/BGPblC4PAHeRx
         1qM/1oTnuvSc3id8cFxNLvRpz934XWJEmdJ8AdLD0maQIPPm1WCac5WX1PH7FTkS1iso
         dEoWDn8Kf1vOK2m+jBdoHDuzBWWjUxvqvgM+B6VQSSwM9/PbpIlQUYdTavzVbOHCBqXq
         EMZ/HMeGrIVrdW5MxpL23QAMaMGKNydw9hRxXSm/PusMv1L9jmTlHrpgLXTXFE18kYyZ
         1tEiZX18Sn7Ze3xc0twCmfLDyFNCzpmcFDHZfp+TkCuRvo+Og98Qz4qHBr9XIeMF65VU
         //Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708600; x=1787313400;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
        b=hm0UdT+70HcyVd1BUVQEVRocN35FAOrcravYWTnTgPKjO1oWNWJSds2sqg3/iMw7AU
         lAlqWwLua5cStQHUxABrNjrvQKT6wqtRLtAIwf+hQwne4pS6zxpXAZW2jdT5vsE0YXbb
         Pc323bsXCTx3Gl82HieJAS7Jx8axkqgEc7t+/iDuB9nOpiEKftX/SoSycaEaJruOY1lm
         Qt+WjVNozBPHUZzxQpj9RUd5pt8wWvvanVIPPBnv/NkVAcplGNjhcjJ6GI84XkhUqORt
         Iue/88tkKI2RQ8isy0jEzAl/0ibZLivBrx0TaW+GCBb+MpGNisvMic7aGuS6zs8mDFNn
         fLIg==
X-Forwarded-Encrypted: i=1; AHgh+RpqvBWKFiIl3MAJmHcImZyVpzZkIC5I7h+0TQoCHbgr5TwjBktSn+o5BjX/2MdvuWdWe4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmdScfIDeqJxr9G5cXG63TDfetbNX0b8fX6bTPDVWJS9AtEUp
	UCsEGgM0YsAetUc0MLmYH6hMr07DONuGxp9Pk7kUR8NgSSy3360Vsslsd1jFA3l7
X-Gm-Gg: AR+sD13tatKvoZtdi8dJeNEu1koOPLILUpigVjQczAfoR+Z6cx4s/ISjmEJL3gFcih5
	aHb+AkZHL6270Xp689AXXrBSXpiZ5YNxjRIwNYjb9lWqaBysn9HZP+ABjWY4MzdeU/ppA3mnes5
	O7PmP1nNNShSIZazyKp10ugG2E0RvjbsgEXwnXzOHpV26SmqpQXpCdECOPoxfEgD+UDTrlkQXCo
	7nsPB7NxKP6OBZFkE1+p/kj50OFxVYr7+ocSidWw+Fid5KYoQ8EaCOinqPJoDI5+ksughkTU9Tn
	3GAYjLJUDVS0B1bz+rt/RXq3ZnXEFtPdn8VjLe/xPKHr5WdZptoxqYF8I++U/7FPCiqUiDoIy4i
	p/1mbIqqKfDHxTMg3nspu3RksIWCiW9nIrWYtvYOPddM8NOsEFT+B5SLUbPrzA8waV7G3tQxO4V
	iMCKb1DicQhZBXwFYxOH9FywqkUrp9Yne/4aPb1+0vnB5w9f79K0oVimfsFurN
X-Received: by 2002:a05:6a00:b48:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84fde41c7a4mr5213758b3a.31.1786708599236;
        Fri, 14 Aug 2026 04:56:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm366669b3a.11.2026.08.14.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:56:38 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: Jia Jia <physicalmtea@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 19:56:12 +0800
Message-Id: <20260814115612.127842-2-physicalmtea@gmail.com>
In-Reply-To: <an7KyotZ5vZOURu2@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com> <20260814072903.124991-4-physicalmtea@gmail.com> <an7KyotZ5vZOURu2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Will we do the same in vhost-net? If yes, all the callers will call
> vhost_init_device_iotlb() with dev.iotlb NULL, so should we remove
> that behaviour and add the check we are adding here inside the
> vhost_init_device_iotlb()?
>
> Or there is an use case where vhost_init_device_iotlb() is called with
> an already initialized dev.iotlb ?

I will check whether there is any valid use case for calling
vhost_init_device_iotlb() with an already initialized dev->iotlb. If
there is no such use case, I will move the check into
vhost_init_device_iotlb() and apply the same change to vhost-net as
well.

Thanks,
Jia
