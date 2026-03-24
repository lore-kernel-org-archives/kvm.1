Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D624840DFBC
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316879; cv=pass; b=tKUaJ5wuu1ot5MWK8laoPdUbZOZ+uLbviLkku6xSFo90CufufJDsiqt6nUCAASzBC8KA4JlyyfcsUri/PjnAEH+W4d25c3IdT+u7hFjeh/XRIiEEdlEml+RczEw5hkNfeHCAZGCvy1WgkizLl402dT0ovaQkYSMwpSViEXjVs60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316879; c=relaxed/simple;
	bh=1L07aR3dyNbqvLj4qfcGbhsAv2cKMDPsFOknuyeD7BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEvQeMI97kHbQxNJo2ITdsvdtznD2rpfxMMJwrXw9HFlNnNyh+Zr7X5CvvT4mYSLpidF6QtrOq7CPIYv4ABv7d/LqtK/z2let3AlkxW3mcr927xXbympBeWTZdiqldZxu7oV6/oHCVh2VZxko5C/zXeetWT9CxPh6eKfpe4FeJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Er+r2EoM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCQ3z+Wo; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er+r2EoM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCQ3z+Wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
	b=Er+r2EoMjVFxEP8ShzTzZVB1q2vwUTatyXrxzQ7w/gIKyk5Ch+kn/dvRpeFXeaF1hYsjJY
	axTWFSVQcCnH6xROvmhW+IGvk2lM9tv40figr9tpOcjmKuLHPBapcUYpl1cuaEMOZ+Q/GE
	PVsaVcCDz/NThqXhLQMRqP9urfqUis4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-qAPKxKm6N8yKfTvs60mytg-1; Mon, 23 Mar 2026 21:47:55 -0400
X-MC-Unique: qAPKxKm6N8yKfTvs60mytg-1
X-Mimecast-MFC-AGG-ID: qAPKxKm6N8yKfTvs60mytg_1774316874
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b06395b7a7so59756415ad.2
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 18:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316874; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2D9m7U3UyN6pQVz5BJgXvFBPpZEl7HVZHV5KGz/G0CRyYWyI2RhGNehwH5sCgsHhz
         V1emJG2A6dhIXEeJAilQAqBLo8Uu3+w97lfNM7jeaFUOrvSMyFWzSkMjC+c5rrtKit5T
         TcMYJkRTZTNv1XCBfknSdmgzcmkfdNuLFZRXZBR3oQubuIpQL04Oukahb5TBVcseMhJ0
         fT/3PU2R6G8Ho9WGJvP03d8n+kYWSv3n1kf/v19hs/si32BCPuEfd9HHMDvDHwG1KKyM
         sWhHhSAkQPsH3ZhnDockcWZTV9Gjqn5Wzxz8IOSZQJpRzFo23D8I0ahlr2EH7e5//jRy
         fQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        fh=HS5rEfq1FabNwba8FYYOIokvRzypDWRGdI0F9vOxu2g=;
        b=Xdr9H7hHsvOQ3Zjzj5Me+xjdnL6g9QUdZIOfMwV36X14tFfN7iMP7hhFTC38oGPEVq
         9JcHomMgBItb2jMEyy+1xPzWxEQBQXomhVTIZxjImNRkofStPGaQCUG/IlBSCRR9K1Zf
         909G6JMwrlfe+xQ8Ewt8sYdVbrQ0zcF6q+/Eic+vLMajVMNdAbiDQqoF9DqTEmxstsoA
         w1lZGmiNDvIZSwlFSInFWUY5Idrj7o/fMlVE378icDMrk+g7O6dx3ImPKTGFSPI9Qadk
         G+8qScAQa7rucBye0f4Az4w7gWKjWM4fGzUjUyYp1Zz5NbMQH+N2pThjZRn1ybQfistG
         5nEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774316874; x=1774921674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        b=hCQ3z+WogmblH/QccdqTYTEOSZ00a9uS//I0pYiiDhPMtFBpqJ4D7pjHqpEv4zoKDo
         i7I1MRPn+YBODnieECQQiH0egzWLdkAxVDsxPveMMgCnOk3zw4fDcU8oOAeV0iVF8jNK
         4ykQEuqozRNCE0kCbAETlgSndlAiN410dsHvRPJ3snVJd9T+apTngZ03WKBvyzuKji7M
         mqWf5Xh8/2k8t8mlXGvcUJQnvxbH865lkQTl/BMSl7TlgOyL0tgjybIpjjFCmcwtrJXk
         Ip8YJu/quhv1U8j8SUfspF8pLE190+uyiU+bRQhEb5qzhoBmp+200AREbLyH0DcOEGyD
         DPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316874; x=1774921674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        b=KBrxymesPGwuQnIzGFkcGeXptv0IcF3qVyUB3fLnMq7TwHeYTUnsl7iLXNZyY0Ydvw
         xR3niVimM8d6gmFp6ypaPE66hDNL8dDVynXQHwX3PwrcIyqQSoCrrI4B9x661arNBPpT
         TRUjUu65HW1fz4a1nipeNXxYAce4hbo0VHtntrApEzKn5t+ZTLcbeVYq7nv2OdS0KYP0
         DXvptN2dWpM0kkQVHPyWJ2uXADAoEzC4DJlu93XGTR+UcfQNq2QtAMuvsBIxEoVEZ1kc
         cwoy+mOGCgdclRBBQ4qphmv6R6RRAyaFxVLfQHBa25PTFYaQIZQ2LI2q+4Rj1NJeWdbr
         uhoA==
X-Forwarded-Encrypted: i=1; AJvYcCWjQ3AcnBDHQDMFAY/wWstciRKDJakWC80jHcO4papz4lzrRIMee1yzluCOAD7PYYBdNaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwFy3tguQq08aJBYmjplWrFPd5nj5jNk7tbfpPWP4PANKXi9e
	PTkCQTwupo4+3xxqAkBAVla9rhUiQMCgNpK06+M12kE9S/m78hSiCW3lGoUsB66WWF6H+eWv7ZG
	r313MvZXWs9fypjorRClHhhgAKVZ6eYAAeDPsBlhXWKa2dBFoF58JFPdW1pXuVFuqmT53R+blvx
	q7Ibd/HjzYJKx+2VMSuyJddU6r2ipX
X-Gm-Gg: ATEYQzw4Oj7CjvAn1GKB5U46kMMMUJfniXNClvXp5reYFqR3DQn68P+jNBncaIiv4pv
	QVvMEInZSSE79vp0meGPPkJNqGZbYN3VUliim5/PCcUGqqCTcOXspS94ovQSb60i3G3lf//NwPz
	71LUB5hfy/m+tVcWET23OkMNfWfX31taUPD9Aj0xissS20RxqUKAKW83vAGA2JJXU5FLtBCMamj
	SVuWq8=
X-Received: by 2002:a17:902:e541:b0:2ae:cb0e:fd60 with SMTP id d9443c01a7336-2b08270e18fmr130322565ad.5.1774316874157;
        Mon, 23 Mar 2026 18:47:54 -0700 (PDT)
X-Received: by 2002:a17:902:e541:b0:2ae:cb0e:fd60 with SMTP id
 d9443c01a7336-2b08270e18fmr130322365ad.5.1774316873607; Mon, 23 Mar 2026
 18:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:41 +0800
X-Gm-Features: AaiRm5055yjwQj85B9qlGmz19tgY1mSWOMYoiCzZMRlFulSK7W_m9HQa_Y7M5ps
Message-ID: <CACGkMEuea9iPKojWqa0oJQWLMrqKtF+mQ6Aqm8D1XceWe6oveA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/4] vhost-net: wake queue of tun/tap after
 ptr_ring consume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
> function validates that the file belongs to a tun/tap device,
> dereferences the tun_struct under RCU, and delegates to
> __tun_wake_queue().
>
> vhost_net_buf_produce() now calls tun_wake_queue() after a successful
> batched consume of the ring to allow the netdev subqueue to be woken up.
>
> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes a slight throughput regression for a
> tap+vhost-net setup sending to a qemu VM:
> 3.948 Mpps to 3.888 Mpps (-1.5%).
>
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, XDP drop program active in VM, pktgen sender; Avg over
> 20 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c      | 21 +++++++++++++++++++++
>  drivers/vhost/net.c    | 15 +++++++++++----
>  include/linux/if_tun.h |  3 +++
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a82d665dab5f..b86582cc6cb6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3760,6 +3760,27 @@ struct ptr_ring *tun_get_tx_ring(struct file *file=
)
>  }
>  EXPORT_SYMBOL_GPL(tun_get_tx_ring);
>
> +void tun_wake_queue(struct file *file)
> +{
> +       struct tun_file *tfile;
> +       struct tun_struct *tun;
> +
> +       if (file->f_op !=3D &tun_fops)
> +               return;
> +       tfile =3D file->private_data;
> +       if (!tfile)
> +               return;
> +
> +       rcu_read_lock();
> +
> +       tun =3D rcu_dereference(tfile->tun);
> +       if (tun)
> +               __tun_wake_queue(tun, tfile);
> +
> +       rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tun_wake_queue);
> +
>  module_init(tun_init);
>  module_exit(tun_cleanup);
>  MODULE_DESCRIPTION(DRV_DESCRIPTION);
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c8ef804ef28c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -176,13 +176,19 @@ static void *vhost_net_buf_consume(struct vhost_net=
_buf *rxq)
>         return ret;
>  }
>
> -static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_produce(struct sock *sk,
> +                                struct vhost_net_virtqueue *nvq)
>  {
> +       struct file *file =3D sk->sk_socket->file;
>         struct vhost_net_buf *rxq =3D &nvq->rxq;
>
>         rxq->head =3D 0;
>         rxq->tail =3D ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>                                               VHOST_NET_BATCH);
> +
> +       if (rxq->tail)
> +               tun_wake_queue(file);
> +
>         return rxq->tail;
>  }
>
> @@ -209,14 +215,15 @@ static int vhost_net_buf_peek_len(void *ptr)
>         return __skb_array_len_with_tag(ptr);
>  }
>
> -static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_peek(struct sock *sk,
> +                             struct vhost_net_virtqueue *nvq)
>  {
>         struct vhost_net_buf *rxq =3D &nvq->rxq;
>
>         if (!vhost_net_buf_is_empty(rxq))
>                 goto out;
>
> -       if (!vhost_net_buf_produce(nvq))
> +       if (!vhost_net_buf_produce(sk, nvq))
>                 return 0;
>
>  out:
> @@ -995,7 +1002,7 @@ static int peek_head_len(struct vhost_net_virtqueue =
*rvq, struct sock *sk)
>         unsigned long flags;
>
>         if (rvq->rx_ring)
> -               return vhost_net_buf_peek(rvq);
> +               return vhost_net_buf_peek(sk, rvq);
>
>         spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
>         head =3D skb_peek(&sk->sk_receive_queue);
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 80166eb62f41..ab3b4ebca059 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,6 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> +void tun_wake_queue(struct file *file);
>
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct f=
ile *f)
>         return ERR_PTR(-EINVAL);
>  }
>
> +static inline void tun_wake_queue(struct file *f) {}
> +
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
>         return false;
> --
> 2.43.0
>

