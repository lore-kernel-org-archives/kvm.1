Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEDD2066DE
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769859; cv=none; b=WJvx2v2INGSaEoP+TjroOyV/tyxLljVDY9iJ5D9QalEik7ejKpoV/93b8CcyUB7syK6WFEj+93V45w4q3o6TdRwQfMfkdeKSDD4VGH8hjS1uQ+qtApmMeCyLzDFP4sWye4YVnAvxxI6EUUMaKbHYogYU/IuQ/egj7v8H4xjtXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769859; c=relaxed/simple;
	bh=0b3Gh85Tv7Tr08PJAhpkGIi508l+sNtqLAghxEDQf6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgGbj1BYSKpUUolT9ZM7ONL/hBRK4SF+W6DPNJewD/PfSneMVqDDZ392fV39se4JBVTY7RXDEloffRFrIvLm8/NRvFhESbG0j/mfJrxTcwrxl89Ey+KOb+MDD1OJ4geQnRtqHp6aN2bg6ouJzFQ2K+a5J/coYNJTq2i/fbCOao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rkb7+eFV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJCcJsfc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rkb7+eFV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJCcJsfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778769856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
	b=Rkb7+eFVhY7L/M14gKHM8UORFZQnmVc4lxffclM98A49lswcCgOJBH/yoVH+1jl9FOWrMa
	T5WjI0NwlI1ZUX+vbK0DB/SXcUbWnHLUP1x0h0VTB429h8cRjb5a6cGOYlUO20PXeQz8fA
	tHcptowZDgVakTZVPPneuX1bgRCgBhk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-YwGWSxPUP7y5-Np7vzuRDQ-1; Thu, 14 May 2026 10:44:15 -0400
X-MC-Unique: YwGWSxPUP7y5-Np7vzuRDQ-1
X-Mimecast-MFC-AGG-ID: YwGWSxPUP7y5-Np7vzuRDQ_1778769854
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fe40b61a3so1220075e9.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778769854; x=1779374654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
        b=IJCcJsfcavvLhZJfUCjHY+1b/1GSahhwDLeonatVoJ0DH6J0jJZDdwgH+LB43kpU2S
         OPwhYgEGUqJORMeSyfaNmn9vRrCkeiS+EpYZFvlBOFlKQRdt47QVMtS5hFxYuFnrOQHM
         JnoC41fIBDJ4OUz8r7aLQoD6tdDvyJja4YX/ehpD9arXShfo/CC+PdXcALx1shlq/K0m
         0dUjtKrAxrU++jxuD6gzTOqtzD7eMIAh50FjPU/rlTo67J/b82LYaC9Vg0ccYXF3rGWw
         HVcNI96jaX/Pu2Mtn2rC0flXgfPMaPUh5AuDh7vJMBJ6g2Zl3pLf/hOLyETbdRTWPay5
         a3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769854; x=1779374654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
        b=mbUlu1naWjSfzsgGExidf9e6e8E9Cx7jwnvVbBdLmghokOX3kFhy9eEEZGOsjZ/RWf
         gdYoItGMwMTI5JP0+qXPacNX6UeyN4IUYpAhI50jFdgsqYfwkoM8Lm7aDs2tfp9vgG0F
         3n/u2ZNLW587Z6hc72xoiy4AAUMh3PvT6MbFeBIO5B90VLLvEJWNcQqlslpXJhzr2bXX
         q+/P8k8UDhui24E+cmJ+ubMrXJBe5beANLsthqt4OBTvqblzuV2uwQ232VITNrn86UcP
         v5VFDv54PtH8Q5lp0u36MrtrqPBsX3pEYZWqOpfdSiDKYGpJ862UAUu0p6U4VBRZrbSj
         n+Bw==
X-Forwarded-Encrypted: i=1; AFNElJ+ChHef1KF59FmMyxEv7DlakIQBSqB3Kf70INMUf25+buta3gAFPDxt3ewWcwi4MXl9KxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEG2HQf90xiWzysxTNrHsy/hqk3Rm86C8OoqIUuJdRj6LEKnI8
	iVjoS7nTMR/5rv827KUlBQt88wDlEPH/Sz5QPlaBewlxh9THIiookRLQiLsycAfJxiy/Y1bTApk
	NDRlVw7kql/o6hNnRjJc+TljAdqzMv3k0ivi2D1JgbxX+GPgoH1Y9Cw==
X-Gm-Gg: Acq92OERsyfYvK7NnKBNqVEn7226X65QjddTLND1uSZ7ZT4EJIq/ff0QkUHBYQ20X7Q
	3LpvcxSv01CohJDjhQVCfXeluNQh8ymDLsinE2tMbziVj8/1w3vJkpBEM+AaxdQEHDOY8Mx8cH4
	4XyVsgca5NBxu0lrues6Tqj7+z/1xzXZPwncDpO+yt0b+jC9kibDRS+sV8ds00e/KcKMmDe3Rge
	t0N6z3w76Ax7NDlqCQtOJlcV+5F1iz0sTMhYRESnu0WwuWe4VnfPzmkKRHvqIlQNgwus6OwC4Jl
	sGAayXe2qoQjL1GQFi5w2rC3fuML0IlruQJ+nwj2UQkVtT+Rh0kwqWYHddLBTX/+/+bmvPsZcLj
	PONqzj77ZFz+ocJypjR3GBTMf4LyeTbhSdtfTLDEbaSfEznuRlHOqq3bWazmi2DMKQGIzqaW2S4
	V7XEmuqV+P
X-Received: by 2002:a05:600c:8b0d:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fce778dabmr120385135e9.0.1778769853885;
        Thu, 14 May 2026 07:44:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fce778dabmr120384805e9.0.1778769853516;
        Thu, 14 May 2026 07:44:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm7140850f8f.30.2026.05.14.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:44:12 -0700 (PDT)
Date: Thu, 14 May 2026 16:44:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 2/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agXe67XEf3O5YSko@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513105417.56761-3-sgarzare@redhat.com>

On Wed, May 13, 2026 at 12:54:17PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>buf_alloc when checking whether a new packet fits. This reduces the
>effective receive buffer below what the user configured via
>SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>silently dropped and applications that rely on the full buffer size
>to deadlock.
>
>Also, the reduced space is not communicated to the remote peer, so
>its credit calculation accounts more credit than the receiver will
>actually accept, causing data loss (there is no retransmission).
>
>With this approach we currently have failures in
>tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
>test 22 always fails in this way:
>    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>
>    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>    Resource temporarily unavailable
>
>Fix this by using `buf_alloc * 2` as the total budget for payload plus
>skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
>is doubled to reserve space for sk_buff metadata. This preserves the
>full buf_alloc for payload under normal operation, while still bounding
>the skb queue growth.
>
>With this patch, all tests in tools/testing/vsock/vsock_test.c are
>now passing again.
>
>Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4a4ac69d1ad1..e22117bf5dcd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -434,7 +434,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> {
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>
>-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
>+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>+	 */
>+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
> 		return false;

sashiko reported a potential overflow here:
https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com

I'll check the credit and overflow separately to ensure both are 
correct.

The portion relating to the user setting a buffer that is too small is a 
pre-existing issue and IMO an edge case that we can ignore.

Thanks,
Stefano

