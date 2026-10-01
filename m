Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F773B6377
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849876; cv=none; b=CxjgIpftMa2i/90j8+M8bHsgEAUZMND33iqp1wlsKKe8WpsqTf1QnaTK6ofXw/zUv80eNmN5I8XVrXw5XfbuwipJFCY4Uk1TT3KG1c8rVUoxGOLz7UFDBZ6ARfrOjlUS9k/4KGEvINALpLTLlxZIL1PhFGSQmq9u6kjEdBy1CBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849876; c=relaxed/simple;
	bh=dUdFDVqTzQDPNI8dPEkhLuVWoA942/H4IpUUxhUFDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXBxG68p56mpMhZleFUX4FSJpotsqPn7bQv12mfrXsc/40xFbul04DnyisBlj+qOrlXCAWMPiLTLGFx/nHcve1U+YMqAA2zX+gcwBM0T1UlG2+15dq+mK27pZXn5BE4sk0hLAtSnheviSX6PnOp2c2P5wlSlkjkHBrDn6palsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEMv44Rz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kfDRs1t4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEMv44Rz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kfDRs1t4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790849874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
	b=aEMv44RzZ3gJWt43MIhf9sQWi5964CWP6YxrCUPfCDeXhZZLUvuVlR3hl9geYBwc9LQ1yX
	nSdfWLehAk0+ycnzxWV3e0mEVs1hk3L3o9p4+HmsBUWmmpcuDa+xKDAClJpUev7kV9Avx5
	r92XOLJ+cNC+amRRMQwX05HYifBl0aU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-bpp5k3ggNGyT49QbPGUezA-1; Thu, 01 Oct 2026 06:17:53 -0400
X-MC-Unique: bpp5k3ggNGyT49QbPGUezA-1
X-Mimecast-MFC-AGG-ID: bpp5k3ggNGyT49QbPGUezA_1790849872
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a022fee32fso3571925e9.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790849872; x=1791454672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
        b=kfDRs1t4Mf9cSev35efGkQBBMhJVocdinDTSrtNDS4Xz3G7ibGuHvWg26a5pzmk3yS
         XeeWMnBdi2x0PvmKrrFzsTW9G9LGrAxht/pxY+VEEsb+d5F1hSOy6m2pvfgxQWkFIxza
         rGTbSLeHsx+zzRMwrff49a01zbi9ju+LOkoj7wg6DY2q1WC68b1CfKhJZbdye7yMhWsq
         ALLGLiP/Qc0R666fpVhDjYxQcY8rQatjgTy1gqw9rUOdoZfQUN9/uLlCfw8q5wERcvZO
         7+PcQDOLBMNiMv2CXpOnMKw1J1hlxADunlDltu0JXdTUQ9v/nn8WPxkD+ZP+QsIx04pA
         SLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849872; x=1791454672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
        b=YPQQZ0IPfkPeUlAqt+LrROzL62ZvuiZZX+gupFt9S5KpwzdJozP9+w20f1VAOE+sgp
         4Gv+a0ayWIKbPNf+vAccs3X8rG5zuMGfdVf4NTDL/SoKjaqAmNvy02UVd6XakJnZq4vC
         n0pmIZru5J5+MlPNdQE4Lwp7Z4LmpNdNQ8tVOhLCxYLphiX9+xBSB0FmeGpC8ph2PSmX
         WHaJOiNEZmkN1FVcSCZjB0CV/u7KiZZ2/MBpX+D2mVEAu0y4PO7WR1UiZqQCys1Pk/Qa
         2NbL9UmUkiL7g4OAZgyjeQNpSWLRtHbqZMJBOlAtLXYXxzZYt2guGabsl1MmidBK4i0Y
         gXAQ==
X-Forwarded-Encrypted: i=1; AKwUvByb0LlMyit1VVqrbpawY0a7yHnxXG/VUCZsAKAAmvy9Tb3kokq43qUdrnF2w1sDqH7IpLU=@vger.kernel.org
X-Gm-Message-State: AFuF++mb5s3lt4xxfvN6UWwl7HmytjBkdgGyfW/sWbrCRSYtxgmUXnGK
	Rc/zMZApHSRV3a1wT5QMCRLH/0Q3I8c+twxhHbaGSYMYoQdrBYz4vcy4grSJrfnWShJD0wnbQ75
	paGtn25sg+2qbE1oLUeAT4qlY10gkP9Cp0jLCYaXzhtEQk4eyAS2KOg==
X-Gm-Gg: AYBFou3hEzlpxnPo36UTTVvU7L0PXiS+Tp2wKsMh4p5OBmhShBCCPuLgqlHALqcAa1n
	Bca07xsN05jglUQzqqKNuOUs+OQJ70ozlB8+FlnbfXI+oiPddKSLYBgId2nCVwcYRksXhD0c+Iz
	u1P2LrznEwgKXrwDULTfbS0afFUArpeckc577wvUlRFEfxqMgauN+YZWepzJhxZqsVO6cnsFSoV
	wrVuzHn0zMFrIBPxiG2qKN2Kd0dd/C1s35fbEiLn/LQ9lv/TVssUrd+sr/JcBCrKh4qVpE9EouH
	J5b8OUSdoRQLULopUo+lE0grOn2LvBu6FM097FiteL8qqt8kWIdx3iAl41Lm3EPU+kYua2HR0bm
	t
X-Received: by 2002:a05:600c:a40a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a01b12384emr64731035e9.27.1790849871592;
        Thu, 01 Oct 2026 03:17:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a40a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a01b12384emr64730455e9.27.1790849870881;
        Thu, 01 Oct 2026 03:17:50 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e721sm5651491f8f.20.2026.10.01.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:17:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:17:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload
 length
Message-ID: <ar4xDQliGcCQEfSA@sgarzare-redhat>
References: <20260930044147.3818241-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260930044147.3818241-1-4ncienth@gmail.com>

+Cc Will that touched this code recently

On Wed, Sep 30, 2026 at 01:41:45PM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
>length, while virtio_vsock_hdr.len independently declares the payload
>length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
>for handling large receive buffers"), large descriptors use skb fragments.
>
>virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
>skb, leaving skb->data_len and all fragments attached.  The zero-payload
>fast path skips the helper entirely.  A guest can therefore retain the
>full descriptor allocation while receive credit accounts no payload.
>
>On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
>256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
>full-payload control retained 265,984 bytes in four skbs.  The existing
>SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
>descriptor-sized fragments.
>
>Set skb->len to the fragment length before calling pskb_trim(), then trim
>to the declared payload length.  This releases unused fragments and lets
>skb_condense() reduce truesize.  Move the zero-payload return after the
>helper so zero-length packets are trimmed too.
>
>These skbs are newly allocated, unique, and have no frag_list, so the trim
>does not enter an allocation-bearing path.  Keep a warning for a violated
>caller contract.
>
>The fixed v7.2 image left a one-byte skb with no fragments and reduced
>the zero-payload queue to one 960-byte skb.  The build had no compiler
>warnings, and the run had no sanitizer, WARN, oops, or panic findings.

I think this is a requirement for every patch sent, no?
Why putting in the commit message?

>
>Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>Required configuration is CONFIG_VSOCKETS, CONFIG_VIRTIO_VSOCKETS_COMMON,
>and CONFIG_VHOST_VSOCK.
>
>The source reproducer is available privately to maintainers and is
>omitted from this public AI-assisted report. It exercises the real
>allocation helper and VSOCK receive queue from an in-kernel module, not
>a live guest virtqueue. Guest control is source-confirmed, but live guest
>end-to-end validation and deliberate host OOM were not performed. No KASAN
>splat is expected or claimed; the oracle is retained truesize and receive
>credit state above.
>
> drivers/vhost/vsock.c        | 6 ++----
> include/linux/virtio_vsock.h | 9 ++++++---
> 2 files changed, 8 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index abed1fbcf66c..fa59456abda9 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	payload_len = le32_to_cpu(hdr->len);
>
>-	/* No payload */
>-	if (!payload_len)
>-		return skb;
>-
> 	/* The pkt is too big or the length in the header is invalid */
> 	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
>@@ -411,6 +407,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 	}
>
> 	virtio_vsock_skb_put(skb, payload_len);
>+	if (!payload_len)
>+		return skb;
>
> 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
> 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057..31358683e23e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
> {
> 	DEBUG_NET_WARN_ON_ONCE(skb->len);
>
>-	if (skb_is_nonlinear(skb))
>-		skb->len = len;
>-	else
>+	if (skb_is_nonlinear(skb)) {

Would be nice to have a comment here to explain better the reason we are 
doing this.

Thanks,
Stefano

>+		skb->len = skb->data_len;
>+		if (WARN_ON_ONCE(pskb_trim(skb, len)))
>+			return;
>+	} else {
> 		skb_put(skb, len);
>+	}
> }
>
> static inline struct sk_buff *
>
>base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
>-- 
>2.55.0
>

