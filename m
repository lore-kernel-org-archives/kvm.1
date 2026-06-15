Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580593B5E15
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552926; cv=none; b=AzUfP4+N35q1XeGvjrG+WZGpQinev5NKnPYH5zb8uDWjmrDZ33i+4OKIotCWnexAIiJPz+ar5m7DBnyedFpuCGzpU2dwh175X+Pcz/vuGKJTINZe4DzFrU8v8NJncv+UPihc29khqGVJq+axBQW3IovVGqJAw8ak7af6MxcV6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552926; c=relaxed/simple;
	bh=HywRkiOpkQuCnAiRcy1+1nGB0pyzOVqxgczZaqgqCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJoWoj1xKykPD7WiGHcj7v67yjcYlB6GMKFNSDHevjSYJVACG4IkdIURJ5SNQgqEELPpq0+SIdEWYjtqVjIV4mo75WpWTkoiz8DG8kIzUj/jtlJC3XyzOYy5U0WSGTpBQfcxgiW46KaLZxWWVHHQllvFFDCHNSSO1IETTfD8rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbJcuINd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mAIyE5Je; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbJcuINd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mAIyE5Je"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781552923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
	b=gbJcuINdCEDyQFAi3wvcsqAclZg2zxw3WaqYtLoHGjIJAswaJyFZL9jwF0noNAKq00Su/j
	XL1eIOv3nPZ6w+tuS0KPkL0lOqXUuJB/HpZRhmmxDGXnVYQeLY2jhKaCMgEH4Ey2aGRq/C
	a1O+XN2VWaSnl9+K8Y5TXJ+sojW/ZTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-9IYfPrnLMzOZkSy367rSqA-1; Mon, 15 Jun 2026 15:48:42 -0400
X-MC-Unique: 9IYfPrnLMzOZkSy367rSqA-1
X-Mimecast-MFC-AGG-ID: 9IYfPrnLMzOZkSy367rSqA_1781552921
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso2710339f8f.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781552921; x=1782157721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
        b=mAIyE5JeEujnTY2QcHz2rk53WzH5gW8ATzl1nJSJsw86LoGhm6w3K/MUmHALSrcVFi
         i9knH0/bgeldvuraP+R3sg+gnXhs4uemTtIRECaaoK8PnK9cMc9ENbjWo+gr92Y3S6w0
         lXCVvMRr6eHiK7ur8VSCkaGAOHj0TSkSrhutYR0p+D96qez+pVP1fPAJkq97UitUmkGK
         cO6J2dearHn4wZyM58VGfwTFlNtWRUALcgtC1NLpV+jIKBwn/KJZBl5JG9+RHl3o3ZhZ
         8cAzRhCtkqXX+674/03VmAADakZB0H+Hm8YU9RhAbdivnsL9dTVXhkx0qSX6m/Ve6u/j
         /+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781552921; x=1782157721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
        b=lq9ZX7vgIwfrld2J/cUxd9w6A2yzBt1KgqB5XkGNIgQTw7hBzplL38IZrGHcLWMRTw
         xzC4rr5KSs8/83y7yHl29V806pWIqgCR3Rc7akT0vcwF1uHpGAKYr2AmIWbm3QtOZJp6
         1UCgzUn4/isRcJH7zRxXF+D2KSkwWYboEgezIGLZFEhHVjeF+hOPUCIcDwj1JU8QQtcN
         HJh/eFcImH6m29f/dw3uNcQLgzI8qnmeCa03TffEqMAjIbsuOPZxnefaBpdZ575dcybd
         z06PgqAO2rsJx72mmkqi32DHvMW8YWJ3nyGmswrxUBzt9xLZiyS/qnlMwuo9izhIgfoH
         d/KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uvUHynTcC5GAmu55X1Z/Vbj8SPCIUGQmqXT+vsn+NOSHyzOn2Ob8WNjScpGETHaQrd0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKA42YZ10FqEsRQgfTdht2JYkN/u3bv0oDHT72EX8cGhxyyg/+
	kn4GVEuKYvzJmhGSGB38We8aQvULYTDN11YDaggoZyntz7B06Hpzl7Zgj3Ow+VF9VcBspGzBOGj
	w8NmlEz4ipfEoiYG63UUVEeaZqLlMi+6jXmElfmsBcM/nI3xPTCb89g==
X-Gm-Gg: Acq92OEvPV9tFC8vwkDLETUqBW9g0L36O0y4OC9NDb81yFteVuv7xkdzSyVcCaRsqqH
	sUC5CTdout78qtkfUyYOSYvUJp7VNg/ALD8vPPIxUrY1F9yzZij6/PVG+si6jwkfyyYO5iN7Fii
	vyql51i+jM9vfkWPv4bCnCQ39ZZJXDPohnXi1PTnwwK7ZZyv2E9Jbd45Vxs4X8LSxe6cKJHQmer
	ARs/jOWp9sv0Ie5O8Eh9kWyCLTNP0YF/zmhR3UFU8iJ91CO1rWfukL20xHFNd6r/4yBQJinm5G0
	9QZ+kchy+79q3/HSinffgU6iKOSjb6zKyPTjkxiki2rg7ovOlbAY/qgOUjDNjP7Zht1omYYEXTK
	iDMInHngFqqaQ6EnD8JkrZm+cgCBWoyadHmzfFkiRYqc=
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr208652935e9.7.1781552920900;
        Mon, 15 Jun 2026 12:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr208652615e9.7.1781552920426;
        Mon, 15 Jun 2026 12:48:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm35788998f8f.33.2026.06.15.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:48:39 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:48:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Message-ID: <20260615154828-mutt-send-email-mst@kernel.org>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>

On Thu, Apr 02, 2026 at 10:18:00AM +0200, Luigi Leonardi wrote:
> `virtio_transport_stream_do_peek`, when calculating the number of bytes to copy,
> didn't consider the `offset`, caused by partial reads that happend before.
> This might cause out-of-bounds read that lead to an EFAULT.
> More details in the commit.
> 
> Commit 1 introduces the fix
> Commit 2 introduces a test that checks for this bug to avoid future
> regressions.
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Luigi Leonardi (2):
>       vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
>       vsock/test: add MSG_PEEK after partial recv test
> 
>  net/vmw_vsock/virtio_transport_common.c |  5 ++-
>  tools/testing/vsock/vsock_test.c        | 64 +++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 3 deletions(-)
> ---
> base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
> change-id: 20260401-fix_peek-6837b83469e3
> 
> Best regards,
> -- 
> Luigi Leonardi <leonardi@redhat.com>

