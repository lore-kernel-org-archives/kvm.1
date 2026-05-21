Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142B36167B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352050; cv=pass; b=hw1jtqzelLSmCfJCWmsSvajRErh5/xvIk26062F1/Rtc7+op3r27LY165hiy1mC2PLeQpYDjysSbGpcr0LbaOZA1m3AuBAA2oOX7fBtjaKYXnhDd3tuix/CY9NBsifO1FiGUExJBCgAHVx425OwHpMrcv8NlnGzdAOC3t6/JCWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352050; c=relaxed/simple;
	bh=Mea46XcA70zxzmyZqyD+qyEd3ZA9s42FFfqINPOE7cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBzVqqqizF9trxelcMtkvxD434Il/HK1bMDCjIV31RNL5Fw2V8nF0MwlyVefA7b0dP1DvjuBsVdDGTo1KdByNA8y+aVFofzhTKbcesLE+ZA8cM/5XzUEbQ2WdxveeoCvgurPxdz1PaQJspvug9b38tCBkgfWTDPghEPFR74UwBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8VZUagU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxFd7xv9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8VZUagU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxFd7xv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779352048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
	b=U8VZUagUhR3xhguPgv+jzwkwgNboMvr8k1lCViWaoXh+BTOH8D0WDglE6S2miRz9tUVcif
	F6PeZY8XWmBJLoRXo9n2i2IOPLhCfEUB3LtpUZ8KK8w3giZ3PnSS9ratQrMj1GzCGDxsHa
	nJJH/ILS5maOj11iX90whB9hcEv3s/M=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-JMEZBq-rMyeoSCf9-S5wVQ-1; Thu, 21 May 2026 04:27:26 -0400
X-MC-Unique: JMEZBq-rMyeoSCf9-S5wVQ-1
X-Mimecast-MFC-AGG-ID: JMEZBq-rMyeoSCf9-S5wVQ_1779352046
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65c3132b7e5so1997553d50.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 01:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779352046; cv=none;
        d=google.com; s=arc-20240605;
        b=VlT2kP9wEp3E4tR0RFCMZUJgrCXwhqhXFxvKbncFODcPZD1peaB0mZzrOzbhcF+Aji
         sITVa1x/2iRCQ/SFz2O7TOwyDYdutPlGbNVmPAP7A9YXmMEkSTZxa/BOI2OvovQc56ng
         5/QqmH31jFNw6w6bwXjLr906YB059pZLDIJ6tZO6zIXeC+HqhC5krqPFlQ/QImacn80u
         C8YgOiJAqCELvZxQ/Y3lA+c2ml/uS8IO9Vl9f07RRPstdnZTe4Hf9oSS/20i9NqMztJ5
         5sMKw7hDMP6+u+LD9cmTAcY/GOFujZgEiQGRRtF50N9zK/ogNgZovaZhRlXXZwUUD4MO
         5H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        fh=i5Oqa0aZHHjqfTpL/+t6C6Cs8S7CCrw/f3KArlxHdkc=;
        b=Z6vER2Ed7pzbRkcyJc6bD1IcVX8k9hjC9TdtGIbZeiK4WnB/SsDHjVV39KThCIG7IE
         udO67F2pd2RyHBOT2ilubqJLEyA9ernevMubynHGC/RzZvTD/aEM5TTt/c9pP3btANEF
         5THAlXyeJBXpLjcGic/goDi57mP3hyev28R2DGwmYHGFTvXRl4fQwJzKjiVf2MMGZNnZ
         ac27EZjjBq3/kZ4L+nMTnycI1SFTfP3U69XUWkOyCoPdoMmjU7xiHnl9H2Ee3wllQQlT
         PWSyX4cDZut1IjAtAxlnSYRLY9iXXZevd+bQm4mbGEKBRJnNTazauTFTuaT+PpAh2Idg
         o+kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779352046; x=1779956846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        b=PxFd7xv9n5Lh1trRRIkPAY7LZu/Wzo99r+UATtnqVECSVvybuDD50SwCYpEQGqL+HJ
         JwqBIi28MkizhMFkuAGDtzTrHe4ARSxKLNteND8xkg4vWudnbnVsMrpa4FKa6vLmhN8R
         XL4uBRm1nVjXxh+V4yC56DwYPFYlunqsJ9yrbGTT0nykdfj46Ew84JCaqzkFostmSZU5
         bKsl/zlglluoYTLSu7naM4KINIBnNBBDtHrkrfpbSCKckwNgWto1cknNmX3FlTP5vzHX
         Z99RfWf/XFq13hBMQiIReak6cesY3flXqusRMWkFY5HGb1kQgqCk3ny2/TeRDmDmbXBW
         qiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352046; x=1779956846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        b=rDM6uDLUDuOyMPexps0X0/23cusxR0Jlg/UbiGQX9pNBeWponeSDNzaIJxxHxib6La
         k8vBWi29+IY8l/jX8ngCQ+ocdUmHnOw4FWexVi84YKsS4iY521Dtoo0AqJcq0LOTZ0X8
         Zfghccl/LveHFL/JCOh7AmxZH/NyV84QnyonVSLuw0HaLQ5HcEH51SdEHfMa6/VqTy/q
         5KSenOWdLjzYCJ7zajmtY1r/Iigmtsung5e7/dUGw0iLTBgGPgFm8z1D2pPMPsI/rH+E
         Sutt4PGMlyg0p4jFZHW7ySDNfX1ua5MiAB0dASQVWNLyhzfS03qOssfY6fJfCcEqOsLI
         D/mw==
X-Forwarded-Encrypted: i=1; AFNElJ9Av6QlgyLw0DVmi+MKAyNz9bDVrfXtgqzawazRye6+ScKYDKSGt/ddtunf+e1km0dVM84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWY/XoHG0zzR05ZIEwwTsOZoCKPnaszYcYNli8wmk5ZzssXjTm
	E5kMqfWTxa3gAcaDOYaR+hJ7AiGAwlNhtSG96+fnaa/Yt4+W7iFj5qyTViH1PjPiWWoPzZBMqZo
	hrWyU9zgC4JpEyxtHsI/m49YY9NHECYI9eJqF3hAXXUPc0vp9I0yJgwo377nqDVNalVuJKI/u6I
	6p7Vbtji+JxaEr8h1+JRJN7p19ISQzh0mBtO9V2Tg=
X-Gm-Gg: Acq92OH1z6wn6pD/N6lnUxgHYJXN1LUkFhDb2RIx6sPvjDpQaJEglbKQpvbfF9l9V+0
	fNx4uRTefnT0jcgvIxri0Q2GD4GkufNnUE/eb9IWbqgoW6Zu+Y1QsEOqStKfuNgsIJjWab0LFXq
	KtPZzfLH9IXUBfQf/dvcOnJ5syMu4DEtxHX6ksjQkiP3LfAZlw5FNW341dVBMj34qThhQzPboYm
	1QCMnK5/xPw5A==
X-Received: by 2002:a05:690e:400a:b0:65e:3df3:1c71 with SMTP id 956f58d0204a3-65eae3402d0mr1402729d50.43.1779352046106;
        Thu, 21 May 2026 01:27:26 -0700 (PDT)
X-Received: by 2002:a05:690e:400a:b0:65e:3df3:1c71 with SMTP id
 956f58d0204a3-65eae3402d0mr1402702d50.43.1779352045681; Thu, 21 May 2026
 01:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511094504.1619893-2-dtatulea@nvidia.com>
In-Reply-To: <20260511094504.1619893-2-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 May 2026 10:26:48 +0200
X-Gm-Features: AVHnY4KzvfnK96jq_WEM08qHvg7RJR8HuiYmXJ5atCT1OCaQOTYbbzhAXG5NZTQ
Message-ID: <CAJaqyWc6gA=TU-YMYdttH3_MjBo+644kgmah1XZnvxP58Gxzag@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via
 backend feature
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 11:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
> once DRIVER_OK is set. That is too strict for devices which can safely
> handle this during live migration flows.
>
> Bring back this behavior under a new vhost backend feature flag. The
> feature is supported by mlx5 and vdpa_sim devices.
>
> Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is=
 set")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  3 ++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  3 ++-
>  drivers/vhost/vdpa.c              | 13 +++++++++++--
>  include/uapi/linux/vhost_types.h  |  4 ++++
>  4 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ad0d5fbbbca8..f89177957c76 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2906,7 +2906,8 @@ static void unregister_link_notifier(struct mlx5_vd=
pa_net *ndev)
>
>  static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa=
)
>  {
> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>  }
>
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 f=
eatures)
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 8cb1cc2ea139..253c7fb35ea0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -428,7 +428,8 @@ static u64 vdpasim_get_device_features(struct vdpa_de=
vice *vdpa)
>
>  static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
>  {
> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>  }
>
>  static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 fea=
tures)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 692564b1bcbb..67b3f49fa709 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -682,7 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                         return -EFAULT;
>                 if (idx >=3D vdpa->ngroups || s.num >=3D vdpa->nas)
>                         return -EINVAL;
> -               if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
> +               if ((ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK) &=
&
> +                   !vhost_backend_has_feature(vq, VHOST_BACKEND_F_GROUP_=
ASID_AFTER_DRIVER_OK))
>                         return -EBUSY;
>                 if (!ops->set_group_asid)
>                         return -EOPNOTSUPP;
> @@ -791,7 +792,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> -                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
> +                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK) |
> +                                BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER=
_DRIVER_OK)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>                      !vhost_vdpa_can_suspend(v))
> @@ -805,6 +807,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *f=
ilep,
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
>                      !vhost_vdpa_has_desc_group(v))
>                         return -EOPNOTSUPP;

Ouch to me here. By reading the errno manual:

Nit: By reading errno(3):
ENOTSUP - Operation not supported (POSIX.1-2001).
EOPNOTSUPP - Operation not supported on socket (POSIX.1-2001).

I picked the wrong constant even if they share the same errno value
(by the same page of the manual). MST, is it worth changing it?

> +               if (features & BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_D=
RIVER_OK)) {
> +                       if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_AS=
ID)))
> +                               return -EINVAL;
> +                       if (!(vhost_vdpa_get_backend_features(v) &
> +                               BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_=
DRIVER_OK)))
> +                               return -EOPNOTSUPP;
> +               }
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &=
&
>                      !vhost_vdpa_has_persistent_map(v))
>                         return -EOPNOTSUPP;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 1c39cc5f5a31..ec1ff8a2e260 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -197,5 +197,9 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>  /* IOTLB don't flush memory mapping across device reset */
>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
> +/* Device supports changing the group ASID after DRIVER_OK.
> + * Requires VHOST_BACKEND_F_IOTLB_ASID.
> + */
> +#define VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK  0x9
>
>  #endif
> --
> 2.54.0
>

