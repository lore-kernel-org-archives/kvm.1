Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D03D9DA3
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265788; cv=none; b=iCo4o8WPR5+5euoHoE1qSOhhEfIGAWdIygZUJVRNljQqF4vILmJtgdnsdQhmYC0MxYu6sXvIT8xJn1rbD3jgKQzsCb0yhnsMYYz3xbn0SNDgVi+MaNBae/OSuwoZZPkPrdFfe3cbgPSxmVQfImOVrh36TH25jxmHt5oHDVVgmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265788; c=relaxed/simple;
	bh=8KxSLwY587LR57aGsCLpqgDw1kJidOt4vFYe6TGecyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvxxK+uw5Nox/3YEyaY6HKqAYJfMhEKGLpsUY5G15oERwe8jJczaQ6wwwQi9rnyui5Oq7wxXmwVh4aUSP4wp0tqDGLkcnxChhxu+YxK5saSRelD8EWgZiO04ek3M/M/D9bBL2SGNwHcRe01MN9VorKpQeqTACtpM7MLkEhFazDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM8XyAWn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuT5V+ZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM8XyAWn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuT5V+ZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
	b=LM8XyAWnQBCs4yOOGdOQViIkammF0tA7bkoKOUUxyIx36ZPEVOSAN5fJ8DiaGzUvpzHkpV
	JdJ6Oh0gdxn1vm8bt7YRlPIoEvX/eWv+LObud+2NQ0MSN29l0n0wuPcoZabysAkL8SQVsj
	L7clWT+gx3NIUyw0Uix4FijwINM1F84=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-9N2P08c7N_qH2KGrmAOFDw-1; Wed, 15 Apr 2026 11:09:43 -0400
X-MC-Unique: 9N2P08c7N_qH2KGrmAOFDw-1
X-Mimecast-MFC-AGG-ID: 9N2P08c7N_qH2KGrmAOFDw_1776265782
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d721a4858so2659938f8f.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265782; x=1776870582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=KuT5V+ZDxxwtul6OrsVNM8Sat89SsEhCBRx0bHYl/l5KUpaBA85cIRvWe1WrY24gjB
         ex453lm0Z0SJq+kD5nvTjO/giQ6Lj+QyV1tsL2syuK2TfEQRqrjARtYQJNYocaoq3ncq
         YD6aTD7DWoj9f0vgCFxodyhbONRIt5a78QOu1QDj6k0bxDJ7xxuF+K8NVueubrPf5Q//
         d77bZUus/+i+/EoYOjjWsCHP8rmnbYcpMXvx8HX6aeybJZGDafr2tPAHV7/f0B23B6R3
         KKgDG4BNpzg9Vi2PsZvnuCaJYP8rDlQ3Ofv3eeQoe/6xLXSm11Fcz5XHwppwPMxrDf2p
         ZRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265782; x=1776870582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=VTVPHOEtC4dbt0lKsbvbwYEOt6Kwnaz9eMnLx/z760FNDblKDEDZSVMRMStKXOVykN
         w8BzcwEODnk+FuIfHApXjKALTQNSmq03A29IYK0XSHJ/+NXm0ru2RX3GlwUM2+daNtIj
         7z3coOFY40h7WlVLV+aeGK5wO+9jtSP/Y8me07w2onB80C+6AfdX3TuNUrcIH47lFNLU
         7zwwCnNTqfa/87jEpG1PthQKtZMxHP17AsX+39rS4PFWI3qYlxJqDRM2YMZgMufx6Jlm
         2r0EaXMUH6ifuEGAyuCb5x2MXvtBCDFX/i1QPbWP0z/MzX4GJOO37ESdblOARi+fOcoU
         AsWQ==
X-Gm-Message-State: AOJu0YzoFX3hA95mmmXoVoWrjJZnr0Kjb33E7Vl+cAz60j0yTngXOZl4
	9Gu5V7hSu9cbtIr8+8NjJmEZ32Bd3Gjmvi+1FDktWsKBPnaG5YiCZp2PmwuINfrBFCNoFpzzyVa
	V+rBY014aFkrwl7PSKMyREpFI6kfedyaMBCqCKK58fSZSe2zXtfIuLQ==
X-Gm-Gg: AeBDiev5fEHcGaFHmQgEOTc9WMj5Hu7AhbmDR3iZsLLDP6V4n4yzYjPRlayVYd6SUpM
	LmInLPH5ZAVnCAgvu1Bezighwgu6v8n42wKpZbE+++UV3HC6ac9Vrs3opQGYx5asfoZBKtBMxs1
	rQpG8to6+YyxxoVcrdK41Rp1tXh1a75Qn42+VTDYu6JdQia9PFRRSDs93V7+VV26Sa7WnEjfyJk
	x3iEcF4qpt+36EPWOGIxBmn1O5KEfRlqnfY09KZmHUpLKSR/bWmfOvKmbl6tF7/5PatbCi8sZcI
	mLec3S35qv4pC38GBZKxV4TwYO6tjLyvC/fR2wyr4AYBRf6L2FapGJbLOTTd3mgEi3lBFC0zC2B
	QzbfZ2c/29JL9PKcyoAC9v6FdrIyH1XxLsRcj0OIkwaZHZtW0rJXEcaO/iZtp
X-Received: by 2002:a5d:64c4:0:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43d64259b42mr30842185f8f.8.1776265781734;
        Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43d64259b42mr30842115f8f.8.1776265781194;
        Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:40 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:28 +0200
Subject: [PATCH net v4 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-fix_peek-v4-1-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a152a9e208d0..b5015ab2ee1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -545,9 +545,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0

