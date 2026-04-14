Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8B3EC2E2
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183032; cv=none; b=DHKCvgpspnRNymp5j6B2QHscF6t3nsvqXce3IIUIcLD0WzV2F/l74IVWs/OnG7qEASTCUM3sI+l/ww2RA1us8WjxKrXhQLwCwbU/wOzsX9WqFPf6fG2v8B91329j+nxQAkUB8GV9B9bwgPtUNNAwVouhKodL954eG40Ag8Wb4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183032; c=relaxed/simple;
	bh=8KxSLwY587LR57aGsCLpqgDw1kJidOt4vFYe6TGecyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZVGoP5lKz3GWcZb+/Kjq/Q+jOeLEe85Ty5Ow9FO50NZ55AyNFkT81kLPXRZ1wNnqS2+/uH6QenmQoyspIOemGcR9T0u9vF+TsnCh3pVCVcWsylEE2sOS0iL7f2JRKIBMlSwA6wNFFsarOygboPCD3f96Oh5X9REfFvrmaPz+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMzKIUBo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1bfUYR3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMzKIUBo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1bfUYR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
	b=MMzKIUBoEDSROwAa381QSUT3xNo7/Gz/GZ7x1g2Crr/miHummwPM/3s+nQGOr/w7maZllm
	fVQ5O9M3k1aiZfvWam6ZG12AhlKVzqcFs0MBMPXchqf0Q2iNoD+QtNmi1Aau6UjN6MiWwQ
	iCRmkyB1S4ssDAyuV1+IJAIuR5ok81w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-QI5vypTIPByoOK78I_0mOA-1; Tue, 14 Apr 2026 12:10:27 -0400
X-MC-Unique: QI5vypTIPByoOK78I_0mOA-1
X-Mimecast-MFC-AGG-ID: QI5vypTIPByoOK78I_0mOA_1776183026
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d00dd913cso6299421f8f.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183026; x=1776787826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=a1bfUYR3Z8jsK6ngfE5aV6nn4igFxI236y4VbJXay7vQrMsiH6r5dYiBZY4Sy96sGY
         tfdNGMKD3ESwrGm+mdtON02U0KStduVbPdcRwF6RPiY1il0ZOzV7dB9wJMGCBoTYllXB
         sC0Q3r2r2a3lTzUjXeQtqoi0BGsTv2ogjeBR4uJ/QLIelTB6MPfDvqQsa4HWSJ1HzTTf
         2IMOrH9SB9p6ARIQ1WSkeDOJE9hfHoYyF+jP/8Z+B9M/EpjFmCcifOSpVnD+LcwpBWSr
         WhVsl8aYfcWhdqaVxpqcdFX6ua7qsMesqiYj+JChIpjW/QUfSLhZViSxQexmtVxF3RHE
         raOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183026; x=1776787826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=SwBEMs62oznaKKHcNBXX0RJNvUFIPkbDZ5JKiulTlkqexpJmM0MdVMa8rKLAWFSfFS
         vWSbxgXH+L4PErY66vM60xS+KtS2D4APCoNO8P2niM99NEmRO1SsM4BpsMklSQK/tgN0
         UsPye1YlNH7tCujtfgUTpnd8cfloMQ75xa3m6N4eECcta/1xvgpPEqlEbyMXLz7rJQYz
         DXCURcuILaQ0Cxd/Sf+FFavxWeeDpYtdPfMfNZeRl+3IpOc4XVERuW4Gqpu2gf6DZQQG
         c35KzQxG4eATlEQ0Nzdj8zESHCRx2zXJTunPuI6PujoDbh1Th5MYvn7HgP5+RWxI0Y9c
         rPSw==
X-Gm-Message-State: AOJu0YxEpqRfgC0OisolRQ7UgY9eie1h8Y41vUUw/chrWn3GNQzLtMeG
	SfZXPnR/CEbRpTrGwAeSoORYYi18eFXpFYp7HeQlXMd7etPloIVIKRRc53KhQy/xp7z0oPMfaKV
	7rsHkYggyEamvY9yNHHHcWIHqxizBRYLO2Vf2tw0GsRFle1ywNca4YQ==
X-Gm-Gg: AeBDievrqcADFC94Jj+H9y0le/07XXkbcS3QE1O/s422P8h885RyJ3iFIm7XFZscmJw
	WJv/YdhhWrfvyH6u5yZUQJHv4gQVj+Kj0Whv6Dw8NBPxVF4CaRFY9YDB1XqAL27bCeptCXBdTvW
	d7hRYgWEbz8jI5yFSVOdt7wESe+bNyOYynZhrFaoWOVfrd0FJfmGA47R0YcBqtkmXEM/aIsMHHm
	P4WpNU/hdxSXE2eNpNmyDk5Qm8882I1T2/ibdn+Up7Qaz+D3uKUaN6ERbKRWpXg08VIxAZpvSMr
	M2xZrE1DvD2DeJ8r1AqVtLFBl86ERQxieBqOSklxZoP52twOj1I+sj9FMf7XFX3HGcJHkT/fzZ9
	WWi7UQcv7zIcTvFHby1oBuTE5z1zvB3HQ0zw5w5HqQq8cFwdRBT/MuHTKX20p
X-Received: by 2002:a05:6000:4284:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-43d762e777dmr15595054f8f.17.1776183026412;
        Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-43d762e777dmr15594975f8f.17.1776183025862;
        Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:21 +0200
Subject: [PATCH net v3 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix_peek-v3-1-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
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

