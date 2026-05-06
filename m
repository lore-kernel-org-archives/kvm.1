Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5B494A00
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081936; cv=pass; b=e7nBF7DDx5eHknFNJaGU3CW90Nc1if9nLF4Sune+tdZmUm2HlgXge5eCi28GzMV4GXLt/wudqVMAzsgunUCM9L8eklVr551tGUb5SgQxRIeyGiwO2gJPYnA0Toe4joYm6VbnfVtEWBM3I3OfiPvc3b8v7cJKczLNSKXDuk428jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081936; c=relaxed/simple;
	bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xz9QHsGCJtV2Kek3ehCbhbim7F4JfmAHq5Nzos26ZUSHj+ufWQO45Cbgydothm5B6TeYDO+Rl5wMi3AGk1iQCgLqU+b7bhPEH+6a3K2w3iuwbAtRsoW/49NFA0NcQzRvQCIOjybTXsqssLxOz4+vec0tcwX7NAnuwM/w7S7m1Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vI/leYgS; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI/leYgS"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d87c138e1so66300101cf.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778081933; cv=none;
        d=google.com; s=arc-20240605;
        b=lfJVQB6zTR4jfagnJBLoLi71pHBe0oKxJ2d1Q2XjIqiC0k+8GWTOYW4KMukXShpn6Q
         Q+eQlVjMNWx2Nn/lXNlUR/K5agG9pVNtHIoUcmKtj4BWx6ajueYjVGmNdmvHVrGBSmIp
         zzrK6X8DkSnBxyS6zKYPGbEWURQnU4Y4DyInaju/d0K76syzgwth0bIHqz91MrAvrsJQ
         JsDqWhTznlc2zPwwta1opLeZmiLFnjqWy/vAoS45d8P+i7W8qiuuShEQeWg+OlJpWgyV
         zofTDN/DWwWT2IYmCbOB2Eu/zUBjaCmu7QBJoyy8Vl4b/WcUbMG1RmwFXcJy/trozmZE
         vhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        fh=YPHuNHBQlCGFtjej5NuHrXLn+RtW9WBbV5O6t7aBu6s=;
        b=iSBnpxLmc+qYwfzzauv6+DWmcw2B0mZ9eB1ArFtfNUwKgutHTz9Rmof5ukjCniGDtJ
         /qv5PZbxcXciaI0Vsvn9hyzWhP22QaEZjh6x179IBIlUD6Rr0yXsq3udgKkSfSI/oUHJ
         uIVYbTqI6l3kdfpJnYMu/YKx8GTF72PwVJksD+Vcie2VVO2sJALpwPHzWdyNWLdGx4tS
         4fyhdKyIMy0x1D8GdXVaHc91EGXhHQIE3A80lZ+GV/UzAOkgR0oyi7D6EZpaVYqflzay
         iErcTDd8gyFgtpHkcFcbjIckMeRYB90nCW2h1Wy0FDkSgtaSjNngF5uyPWFtqwtGYVV1
         sdqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778081933; x=1778686733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        b=vI/leYgSKSdkGtCHzOOsfZzB8bQLoTLFlSFqzokAA5W0A15tHkce7hD4vReh3yOTs+
         SYMWzDap8utv3MtQcOrLDVwZdRF2NB2UsMEPUzKLc+8Y4ehBQWdqhTC3ujgUOhNRg7ZY
         4Le+rUsb0rVIdi17jnVCKz1ptNKCw8FX57dfh01XV/AORmzlx6TETrf+U93kTvPXIXkt
         MA/gJhEEbqwHuxIAgFmTjQ8T2HzmF1dfvrSmb2USgH5LaZJWI+FaTLaqSVCA4pHrYp2l
         NWHHoqM9XX3b8j0BT5Ep4zazCL2mxAxZm5X+xUNK8Og47C2O4bXYTVrCjdr+O7ARwkoK
         ykSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081933; x=1778686733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        b=XXp47hBZYC9tpWDfqVob16Eow8lQjNKB0qo7qBqIog/rtCfbvlTyv5WsOHYH9AdPs+
         TSaHcknfX6S1ZC+2aqFiDQ6FV795dWENzz5cHiCT6w3tzkinppCFK1CocF3F/gQsiNt5
         KBzUiLza9BDNRrBqQrShwL0WlU8KQKt5Pign/lVSnrS5FOUzHEAGhMl1y1yrQD3Q6oam
         UaKTnSOXB17xtkd1eXGAYFbBt1DO28MpFbOqXNAMeGstQRVPTQc3Gc0pSTvEsmT04qGF
         PuWNCd44U+GgRRHUeza7WE01fEVAG+bfzGqoFVxQVRD90OUIQk+3C5YD2QbXwcw0Qyky
         53hg==
X-Forwarded-Encrypted: i=1; AFNElJ+Uw4JStQMTWKHqAFsM9lBsTSgOYoxeS5uZGjOpcBAkerkVXKEvMDeAM5uUn8CgNN+gQcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGG2QSZw8aCIMcOPnBT2qrsAr12NKy/K/y6pxeq0Yu61eB2YKu
	lfJEwh4K1F1TStzeWVSEsh/I8va077zUf5UTY6In4ADX79Eehl4xw0OpLM+WHJQV7+KiVCXxFz8
	yWB3eifP5U64QIukgzI8CJBzs8IS/cGijNbgdZG/H
X-Gm-Gg: AeBDiev0xuAspLsEwn8SuCWnW7V8uQSZ+0e5tGMcjs2ZmannsnSh2+i1Vrdi7kcddKX
	+ojdy4x5S1vTtxhxBZxE0A6lJYj7hvOYaFJI98bkvSJUsL7qtpIJGouGSPw+zCc0L4pgjioN8W9
	qnAXnDnedcxwtI5AJwDxRFmv0Bj7HG5ULjPV7+9tX35rjI2rep6NtT3u9CW1fkETWH1JMbDhFCc
	rZzmrmM+y8EqG5w0VjUvN75GvOo/mwpefXMSY0cXUwzM4Q7F78LGNKbc8OzCk11EpUP9gtVNhAV
	2HzNP66H59Tee5AHb39EWogdfKvXgKMu09TCGR7VJu6PI8x2dV88/fXbf0CpKdt5fEIm9vaZjiJ
	AYoHj5+9c6kUnZbQqmrQHqIHvGAUVIxkJ+DziMgI=
X-Received: by 2002:a05:622a:48c:b0:50d:e298:8f1c with SMTP id
 d75a77b69052e-51461fce4d5mr53275791cf.32.1778081930259; Wed, 06 May 2026
 08:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com> <20260506111507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260506111507-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 May 2026 08:38:39 -0700
X-Gm-Features: AVHnY4JGcss5DSvVQJ4HSN2zeUaBN69s0ioWUQVWnh7DFq6P70Z49QIoeMVTrAA
Message-ID: <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 8:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > There is always a discrepancy between skb->len and skb->truesize.
> > You will not be able to announce a 1MB window, and accept one milliion
> > skb of 1-byte each.
>
> We can if we copy.

You mean, ignore VIRTIO_VSOCK_SEQ_EOM?
