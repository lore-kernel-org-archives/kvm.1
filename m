Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976336B076
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080536; cv=none; b=rlO4DDmVux/tOlJyxAydIUuepkieqgprKcSsWAny/6KvQkpsvtiKvpWiZA19CkK1i+GSjxcsOgbsMjE5rswV+ah8ZZBitxTDtGuA7yi3Xy/zMpcPfu+Rg1k1ueHFmWlkH87oKCbXV8/GDCxMldmWTUpwmSXtQYQE13rFJCUuqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080536; c=relaxed/simple;
	bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/LuF1F2DrivJ0CjbL2nrNLLyuiuAG5cYjyqu3SRmgT5viukSbbqgasU+rzpxlcunZIe6ip38Nwu3/hFJW0bPWlgT7258cIpzM9ul6utsopfU1JX5evchH6Osq90lyNff/CLhQpUhdXkp3I08DTeb8imprxt6Qy1UfS8ZrVEtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+jp5bNk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPnfHl3W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+jp5bNk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPnfHl3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778080531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
	b=c+jp5bNk+Varjo6OPBr+hYZkuJJCcoHgBlbrJyXUBAPPzrsRtAGGH256qwbpQX3NP8seyI
	Thlr2thN1cRRi21ccFiU1BQkzFepk3QrSrGjX2GLvsPvaRKHYE1jX85LM2hMCx0dttpuMu
	8wAELmLFkbuNR1LXQTTnP32l8eW5mSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-GCVpocsXO_Gh3yiy_P7HtA-1; Wed, 06 May 2026 11:15:30 -0400
X-MC-Unique: GCVpocsXO_Gh3yiy_P7HtA-1
X-Mimecast-MFC-AGG-ID: GCVpocsXO_Gh3yiy_P7HtA_1778080529
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso80041705e9.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778080529; x=1778685329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
        b=HPnfHl3WhXiNQLzmBF7kK7Jt65U184IqyoxE0M484yInTICyzYZGjvoFtNgfrA/vxb
         LgKndyUbhjOmyVGOYPU9wnbkMXnlkiFeCOhtA8DVSP1OfQEcteB65H7weMmbPLYHXSZz
         tqoncI/gvvSSrcHK7V+mdiEZ0MQfF5IVo0s1YqBB5yQqoSTzz4DXglfskPmm5aofCJZK
         1f/heqbeljqqjzI7rweXi0nRzCqlhVS+uj7jHcVU2MnkAjRIXa2x8cniN5dKHKc+gYin
         qxxGcIPkYwE12TpvP8eI3+2vYp2/v+68XzZGXa4agzNfuct1ohrRSCnaY5XgkSAKnmvM
         nF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080529; x=1778685329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
        b=Tn7dvX7iYmTV36yJzw+bsrGDCRx1mVlxjXPSkcc0XmRkaSI/v/thOdUa5Nb/szIwEe
         LH/KxEFEUwnlEW0MAFT4kbSe4aUBXO1rkIpcYZfjCT6SvpjAJQ+aQjcGCpMogxI9hjpU
         95g+IQUfrnC8BmezmD0oyBNTVvDQKvOycZ+eOBH9/GzBNQzU36FIM/2WIfz7fc8FVpCr
         TX7yu4nCfOrI5S20Lwoo2asI3nHmv4E/Mndrmgfsro5uj2A2fnW4yAeKGadO1i0cJoaT
         Hh0xbBa97ikrAfj6EqMjAVojk7cNa5KHdGaTGJXQR5gpcbdQK+je05vedkjmdMtm1VoJ
         BmEw==
X-Forwarded-Encrypted: i=1; AFNElJ+QmW5jemx3zuNkfoNk+KAtOT4AkEoOXl4GCRbw4E0+XWwrHOwnr69NUgvsFTgHGHuxT4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FUiT+BT5DyPEhzKHegyeYSGv2rLl/IgLSngouqXoPuKKFX/3
	iyX1JmhmsINoTpaA/h3ljR+wMXX3OZBH2SQnfnxyBOxc/JZxbSHASmrYG/2W7BFYbnZKFZrUJ2c
	DNsTzpp9RtNGeZdPW/ydg8Vqi1GevtWGFBZb4kwWRhYXGF0VlDI4KPg==
X-Gm-Gg: AeBDieuQ0sw9LyW4/Yx7p9nHjLo8hkp7K5gHYa7oW54ZCikfNst8ru3zPNArgWwvwJO
	Sm6zGwDosot2zn+BZQPaWNyZTFXj8G2E5hQT6rl4lwnKezpqmJG5m6aN6EcG7mnD7ZqxfxZ2Duz
	fCpHfpQdnJEmGgsyyTzYs8sybs8NkTD5v8q8O6mRYq6cf44G3LKO/wP+UqLN3wf8AYSlj/GSvkQ
	N5jFqX7YJ+aj/XHGLltrPkHfgmtSd0IWuUTsMqUigTGv0Dw105CNNReB1Czhrujiz9VNBdp3CrV
	d2SWQy2c9AShTSzgoHqNsWhyy9KHHTzV0YQljhrkIlr8JX0jJKha1arUs/z5t8URpSTFgz4Veoj
	c4fCVu5bji01as+NSzpGYSoxWOs1+oOChpb+BE35C+1ZoAE4nFQo=
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62856685e9.17.1778080529265;
        Wed, 06 May 2026 08:15:29 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62855865e9.17.1778080528659;
        Wed, 06 May 2026 08:15:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b26a3sm95210515e9.9.2026.05.06.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:15:28 -0700 (PDT)
Date: Wed, 6 May 2026 11:15:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506111507-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>

On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> There is always a discrepancy between skb->len and skb->truesize.
> You will not be able to announce a 1MB window, and accept one milliion
> skb of 1-byte each.

We can if we copy.

> This kind of contract is broken.

