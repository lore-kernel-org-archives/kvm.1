Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448358;
	b=KRuErpqQI0Rpuvtl9cbz7OtpoZKZc61t6sjF0A2Nw4G2S7WdFj56CNEKfhj51uI4dU+x
	 HOokHyynewWzGmmMDEEw2e9QrvID1ZUDSM6rkucADP/47wzxQaAig/i3u243i+IT5lF11
	 0Jn2/1d/tWory2bDKQsYWcfcS2EtCyPpUDoOwMf2oqrkYqwi7CqAMykLZU9m+dtVM0BY9
	 L62iQ0doYKM7WDaVqOSsXKkMX+I6kz6BVj/E8Nyv1ob34xKib+zEkjU7keD84B9T8YcU7
	 MOrfupHWULmTlhptdw3e3QqwTMTtkihb3SbqdT3z7w6FakMNY3h2zAWuPX5WkcqrI0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448358;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
	b=FdduDC+vyNQTAVTek+bYyfVL+EsjsUkAVCPWratm2gLiUCH8YiKyvIK+K1jXRGOs6V+I
	 NbuUfP2vnERaTQgMCZdaZ99AlHurSyNq9vLB2rM2Ej3+l5UNyCOuq8UH3zwD8ED8LdldE
	 p6FgQ9dM9ZMRIgeKlhipeIs92HrXyc5Vg/sMVrBj9ID9CxIXTMKo2Wgc0X9KLINJOFZnh
	 d+9X1be1XF03QMroTpu1mcORn4s38JbNbogLk4E0cBI0vaIey3pskK4KNnaYVWUJJmjZQ
	 9miCszrKLVsKXIskXoGfSFniZh5PDD9l62Y/qlfMG9PQN2QZzYCovlExtfQOUJmWUyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aw0syXUY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L7yVAW4X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234F606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D234F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aw0syXUY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L7yVAW4X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
	b=Aw0syXUYpbjiEzsTh0p7d5U2TP7uwPaCdBQktY5FokElC7amRHy24VaJ4NhiK1Ia2541Rt
	7vTUOslbDRV0T5jZFlqwzmG2RKly6RySsPaGemQvBIm8pxp0S0I94EV5Z+Mi6nTHmRiMon
	jWZg7ljZK/xs4lvFUtj/MDaoHzB9VXQ=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-bxuJt7UoOSCUL_bzyCiXUg-1; Mon, 23 Nov 2026 15:39:15 +0000
X-MC-Unique: bxuJt7UoOSCUL_bzyCiXUg-1
X-Mimecast-MFC-AGG-ID: bxuJt7UoOSCUL_bzyCiXUg_1795448354
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677c2db10b1so5116240d50.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:39:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448354; cv=none;
        d=google.com; s=arc-20260327;
        b=BRg4fXrViSHMDU3J4GqJnvOvhdMoB9ncFv8Uc+3w7KatAvOYDYgHnnEmnPZ+S5hRFj
         kt5hezuVfAYH4u+1acb8PcOAs8/DcHz+B6wza0gwilTJipMw+9CBGo92KYdTWtpyi5tt
         8yNsHzbZ1x+C9JuefSX4OvMDfI57A9Mk5quxDswDac8kb0KBRCYoPCvs1r5R19hOR7NI
         J9kryLmyfU59eGNjK/LkEqx6xVyOpfPtqqiN2muMLSym9+ieS53g4tzgzeNbm3lof/sf
         rwaHk5kkhcfWSkAiCubS46t3OIU9YjcAssSljVRERUIa6SdgssjuCvlZYz0pCgTkvqYi
         6TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        fh=i+Zhq6f3ZJL7ZwZlaQt3KQYVN53JhntQ2XMoH+58ubM=;
        b=fGYRY1qErQoVEpkGjrK+W4CWiWfYkMgzE7ZQRmSKFImUZOOtdeuKJ0Eji8xgF4jZnJ
         QLuAL9w358eGJ3XguJFjnMWt5wy7/ss6OX1UZpySNbPBhvACMlTrhTiyAJsI3Gzctjlw
         6BsxnzCG631DcaQpxuzw8yFZ5PJq321Ql3OqpECOQcFH/R0t7+aDbm+djItgBEKPGWPK
         Dqps/gRFzPIm/oKGC3Ekt1+ErXsYb3CumbLktwmwSuBNWagEl5gc+XB7w1xnb57ylda6
         kZr/VLE3uyTNYMdnOsLxVYxf6aMYK5nArVRNonwUUFMSo6k9A3CcLeFoVZtqntI0esSy
         0/JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795448354; x=1796053154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        b=L7yVAW4XayKESw0Z0ypaaNCQwNhK1/UdB2KJtndGOO8ABCoM4cD3s9Dta3TGZ5rfJq
         GAy0EM48AUJUROlm4Es61DJpyI8PnqMwgIS0fsnxvYvjszHlgdpBTaaPA5sEBkzRy61S
         L0wg/KG1W62msYksfUFWsCWkQ2h9GRcXaqx/P51bS0IOJXQH17d2NgLlPp0wRQZMnOWh
         Lnwb4qrZkwZA6Z2AWdZ3ZtxI7V/yNL1RjyfPpI0VNV4ULRVlsjxnnBANrCtS/JKFZ6ll
         Jf20FabpCR0NEhlgg46jfsZV7vbwaXh28Qfd5KAKzgWMIeShGQUnoGg+H5gV9FKjEKkb
         cduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448354; x=1796053154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        b=gGc03+HYxzBPDa1xn4y9h0PSkcYY/sxyzfmHybi2ty0jy1vU9qc6mcepER0SerSS3M
         7idq01+u6mS29zClV76ve+u8ELuiIjuy9QAC+5wSTfJdKc7T0JQURzgD1u83QAIreM6O
         X3aYgxuZtkQWxxgR0GDUsKA1zlB4uvOYcIMQVDPNx5jX033EIG5fPBpZO6suCUs3knl4
         dPa+JLWtEVu0DupXJPi4zvhfHgd4SykhzhyK3BYGCTikZEDUoxPqNqVUnfSO78gIk1dV
         6N8Ww4vS6JiU0ZbqXuGT/QpJFOjiPpfK4peQ2UJS+VlYXseTlcPL9oJKsIIrmOvYwRcz
         G8Lw==
X-Forwarded-Encrypted: i=1; AL+hErGC3bCU7eTKAAPm1EJuAh+cA/BPGn2wgAmCtXXW4RNSUqJDoVfq3h7QBTA/kYfZ4IJ4kPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/wlawP2F05WW7EubRQZi2G9CW8+5NOBOjl3kvVYKq5UiKViEm
	PG/JAW48uX+pvQ+GTphpt+wPqJs0m2BAhSa9jHFbEp2q5m1o7uUw81WTKnafLI6D+44JSOVBdy5
	ertEV0XUhMaRxesLQ/Btk7gRiAG7vY/hSDZe6sz2wDXhrcCSVjVeuR5VDeZLAb5nlsKWvDcZPE4
	mt9HkdZ3dsT662afLc7jq1S+yZZ+k5
X-Gm-Gg: AZFdTZdrHnDuIrO84/DhJapxc2csm3ALUTH2eCCI5Z0oh8tmftgCGobDt6bKtESM9xA
	RHbOsNK1JP0RUsFIzvWcfEH89ctkd8stXOeZIJMDz5n2rFdU/VClVsaUEZFAGYckLl7WNZVj92l
	X2Sq5REEBsNKHD/KdUcCV7CTNyfc4l9e3vL5CoNu4zgvp+DP7EMuD7bmIkM3MBz9tmptABO07hP
	Q7BBykzpTg1Eglv2acWivCGP/Q04Yh6SY5g4HIlSO2DpDgv8qIcNHKYmDg=
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id 956f58d0204a3-67df44b55admr4416365d50.70.1795448354405;
        Mon, 23 Nov 2026 07:39:14 -0800 (PST)
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id
 956f58d0204a3-67df44b55admr4416353d50.70.1795448354006; Mon, 23 Nov 2026
 07:39:14 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-4-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 16:38:36 +0100
X-Gm-Features: Aa3M54o_X1llfaYVgrhNMk5-QtVPWRJiZP6Jl7gQZsBvDw4xjjtYogw0lgFiv-A
Message-ID: <CAJaqyWeKT3A2A5OHiB47j1P+e8BSoAbtJ9XaGLjU+kKOzOusMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Increase the maximum virtqueue size
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> mlx5_vdpa has always advertised a maximum virtqueue size of 256 through
> .get_vq_num_max(), while accepting any queue size in .set_vq_num(). The
> hardware handles larger rings just fine and users have been running with
> 1024-entry queues (e.g. QEMU's virtio-net rx_queue_size/tx_queue_size)
> since the driver was introduced.
>
> The commit in the fixes tag vhost-vdpa enforces the advertised maximum
> on VHOST_SET_VRING_NUM, so configuring a 1024-entry queue fails with
> -EINVAL.
>
> Advertise 1024 which is the max that qemu uses today. The device itself
> supports more but doesn't advertise it in any way.
>
> The Fixes tag points at the vhost-vdpa commit rather than at the driver
> because that is where the mismatch became user visible. It also keeps
> this change out of trees without the vhost enforcement, where virtio-vdpa
> would otherwise start creating 1024-entry rings instead of 256.
>
> Fixes: ccb1dc7c527f ("vhost/vdpa: reject VRING_NUM larger than device max=
")

Is it worth backporting this change? Nothing should break (or be
broken because of the 256 vq size), it sounds like an improvement to
me.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Cc: stable@vger.kernel.org
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 7a39b0bbbee3..f1c5f72032a3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2965,7 +2965,7 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_dev=
ice *vdev, struct vdpa_callba
>         ndev->config_cb =3D *cb;
>  }
>
> -#define MLX5_VDPA_MAX_VQ_ENTRIES 256
> +#define MLX5_VDPA_MAX_VQ_ENTRIES 1024
>  static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
>  {
>         return MLX5_VDPA_MAX_VQ_ENTRIES;
> --
> 2.54.0
>

