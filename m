Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450130;
	b=AN20ZTPTg5LC/qq2XOK2Rq9oq1txD5gi0Y9pb1OvV12FI4OsErKLSszQJYz3EILSQcUN
	 TygDUdMTJ1L2wtO8eyogOjNqrkXbAKW2apXpPn++S+WlEy8EbnQyZkUsHQDq2C80iRdtQ
	 mO0wStOSrpjeZFh43Clg8xaL8Dk3c6x9FclbW0bTb988pUmH3SK74ik77aZmLpA85pk+U
	 BEOwwzuNHZZTbeeJvcCW14c35LoSmgzMJ3ua2x5BFoJaNIkvHIW+IRXT5ifwWuvQdthGH
	 CaVyPbuHblaeK2c+LQJr5xcktclZFEDC1Qv6QKDlLBniEOdkCqz6ZTeniSVzmb0UMMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450130;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
	b=stjLoAkFO/6N58DGE4+AC+juYDOW4pYX9A+F/nQceI6P07GaBVtAqID8F/KVx+/Lmsxm
	 XylDeFrMYhagxzdtzbapse7dN1cxgt3BrbnDkdQevME3RwrNqV69TOByq364qqtnusWQ1
	 V/CCvVW3Rgj7KzRbTKEyYrBrrNnItogEvVDGk48cSjtOUE1B3D2bOWYlud9DyqrjQsDCj
	 DFwwFxTKNMWcumF+uOZI47Cs9sCsc7QoHEcUM1ZnEhf6i96PRsLf8D6GQghfSc4v8YfcB
	 3MYLewr0Vif5BsJa84l4Zy7vV4RjQwoM+1na2DOvP2O9SGvq2MSEC6vZfLpG5Z4/Z5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5nucsP5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F8XSS4AH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80592606A32C
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80592606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5nucsP5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F8XSS4AH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
	b=C5nucsP50WObmK5Q7uRc+TveRbQ433qzGh7y2uyYQKa3lu8VBblMI/jfSafsNlAU5bzqM3
	2Oof31kKa1N1IDRagkxQGSOfEn7xcPfxwBTeYUwTJmOllC7W87Xmt98CG4KzUEqxzOoPdu
	PXhmAJmsmsCBRCvg+AyMrINooTjHRUA=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-TYmpQx8_PEKoFa1Tv9W9Ug-1; Mon, 23 Nov 2026 16:08:46 +0000
X-MC-Unique: TYmpQx8_PEKoFa1Tv9W9Ug-1
X-Mimecast-MFC-AGG-ID: TYmpQx8_PEKoFa1Tv9W9Ug_1795450125
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67bda487981so4861063d50.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 08:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450125; cv=none;
        d=google.com; s=arc-20260327;
        b=RNPAT2voJcu7BRHW9/SCqL/y7BCyAjwlApC5A966uJyxtwoy/YHRPG/gHxMc/bLZvK
         dh/S/XbFDwc03SgHT4gZbuUB80jpO1Cb41fBBBvls0qVSqS9wFqPz+SAnSISzwNWsOqo
         zTyP6eKGuulYFDvXcW19f/CtqkMakrKAWaoLnLetB8Gni+6akA1pfI+6oSJUV7eBAGxY
         SxtgsQFW4GlVIJMHiXxvo2K6WSdcwrP2VNI9u14cR+9mnf8fHLkKSgvBxiToq/8F5KQ0
         r2X5Ata/VlmD+83Ra6QlJy5HvzF29qH/XJcaHENIpX4PfDK1VLxoGpHX++dR/O7lNPid
         sN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        fh=7qA3UzGzYsjTVK7O07RpMrxdQziP+VhO63baluMwRRI=;
        b=aZlPcRkptnHk78wm3EIzbEK4Cvvi2+wHpOwrfpb7fkj7n0BpuD495xuMWMlBsiSMD8
         KhT9NX9mEfd6nZgpZuHydhMYb7iaPgc2afbVLmOY5KqMzIPA7tcMmRjReslvSlHfYhlB
         lPEiiJ3ybyxmWAGO4p7EmiaGFow8RE3W66r9VfQjXAXiqB6+8Qry30rs70JR4oNVDhd5
         dkxpobSh03XBsfSh3A+d4sGluHMdgwy3dahoQe01c9faHrt/u6UqAeBx6KsE2CnOUDsK
         a9KB0lMiTMS/Lpom1hasjFgZdPAwY+eSAV05bwRo/ND6FDAbt97LtyUHag7utHBVUVDu
         RwYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795450125; x=1796054925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        b=F8XSS4AH+jbfK2n80Q2fOBkgol2BK+9eeiWpA3qc8uNnYfSmPR4Lym9UL4/4Fj3eSv
         3EL2QMlTsdxU+ehYxtFFrMazhADuiBCIji4xQ9n4t879wnYluCOMdAchmuxwSd94ednu
         utGQvW+/dyQ3oJHulzSQawqw9RBDRot4tfwdyFc4EwnQH4S2bWJmc5z59jsrm/TXL/hh
         IguYUiWQAL/T13tuXolEsly8Sb54z/s69Brb3G8P1eO9ycyFu2+k954xKX3zgkrjzYei
         nlaj+wQF1bQ11UxgmVAyx4og8R0hq2o6UL51yxdY1cFW6/K7KQplVcCtr7OM+jYf9UN+
         AVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450125; x=1796054925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        b=H7HRRhhpzcJtA6YRpRzq91/paxY+lM6Y7hBvH72iOylOXZvRPnRiPuupeS729WZffL
         L5wG0C3vuEjeNEjyD+ZAeuQRURCHj3vOGMJMNMHzyRFNUDBLnp7bGIgoAb0sIcIlACTI
         ihlqwvkKYhwRxoOZLkqpQG12ZRpBkIM7mNXJE4cfFkuowmX5Zj6f6/3leMGrwS+jV4Dm
         us/uKCLqsEgJeVJuYIhC3dies4vH3lOl3J6rvUg04lEwEiCP6lPRph9TOsK/D0ktrhFT
         i5GgJJZHNwPJ4kCBzjNpZAsI9qHBk7SqvjKZwycRxX2zlAoK00DfnVop5GqZJkeNAQSJ
         IHjw==
X-Forwarded-Encrypted: i=1; AL+hErGFmGOcxsSw8JKBBgHibVjMFbDi0njupt1hSB3AZKCN+GK2BiseD8+0A6QiuvCdsmCjTYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NXoS17aKBoQW+wc08DctAF6PTgnWQbEoWKQq6AV6ZqZY3lYkO
	f8nkFPC3Is2s/pk20uhSkvhH3Baz0kv85shG5QcOTr/Gco3Id1wUNQoWSmkL/cgo6ZdsFqmVDUs
	uxtuv0njEkBo/fnPOdlEN14f7YKB48cAWVErPdcwCcTXx1gdtjzMkqLrBDWmOfDnzRNPrb0nzE/
	wUp6rL/nCxL4JTXI/crPe2s5HIXwZD
X-Gm-Gg: AZFdTZf+rZGrzWDuU7TRFo8rTiZXSnfWygH7vO/R8/zrwvycsncxA6FC6pZt0xsD8cs
	mw1E/B36DZZaZK7GHUrdSlLSaK5EYsiR6CPvbVSizRPPLYU5xr4BXIH3uDpveEIsiMZXU0LcPjS
	i+woT9DiOSLz9lFb7/flS9eR7k+TVFJL3C7dp03d/bbp3XqRcc+wA+fihhTgvwtN+XItg42Ygey
	7BFM8nuzMyn0Ezb6kOwyEE2XCwcqwDi8WICjEKSZordgghs3d61IvN/Qmo=
X-Received: by 2002:a05:690e:4883:10b0:677:d5bd:8349 with SMTP id 956f58d0204a3-67df445d5bfmr2252250d50.63.1795450125561;
        Mon, 23 Nov 2026 08:08:45 -0800 (PST)
X-Received: by 2002:a05:690e:4883:10b0:677:d5bd:8349 with SMTP id
 956f58d0204a3-67df445d5bfmr2252240d50.63.1795450125014; Mon, 23 Nov 2026
 08:08:45 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-3-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 17:08:08 +0100
X-Gm-Features: Aa3M54pR7ZVMpPP5oNO1OCA7GwyP-se96UdMP4VNO94DAWt_5DL7ZGYCWayniuk
Message-ID: <CAJaqyWedvj6htnM4rJyrbynW3u1k=6uLHrfuK05YvM5z8v1Hjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vdpa/mlx5: Fix error cleanup when VQ setup fails in .dev_add
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> When setup_vq_resources() fails in mlx5_vdpa_dev_add(), e.g. because the
> firmware rejects the provisioned features (HOST_TSO4/6 without CSUM),
> the error path unregisters the vdpa device first and then keeps using
> it:
>
> - _vdpa_unregister_device() drops the last reference to the device, so
>   mlx5_vdpa_free() runs and ndev is freed.
> - destroy_workqueue(mvdev->wq) then reads the freed ndev.
> - put_device() on the freed device underflows the refcount:
>
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>   Call Trace:
>    mlx5_vdpa_dev_add+0x3e0/0x760 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x362/0x440 [vdpa]
>    ...
>
> - mgtdev->ndev is left pointing to the freed ndev, so every following
>   "vdpa dev add" on this management device fails with -ENOSPC.
>
> mlx5_vdpa_dev_del() already does the cleanup properly so use that. Just
> make sure that an extra reference is taken during the call to avoid
> _vdpa_unregister_device() from freeing the device under us.
>
> Fixes: ffb1aae43ed5 ("vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add=
 time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 6830a80e8543..7a39b0bbbee3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -161,6 +161,8 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *n=
dev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>  static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu=
eue *mvq);
> +static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> +                             struct vdpa_device *dev);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -4043,7 +4045,10 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         return 0;
>
>  err_setup_vq_res:
> -       _vdpa_unregister_device(&mvdev->vdev);
> +       get_device(&mvdev->vdev.dev);
> +       mlx5_vdpa_dev_del(&mgtdev->mgtdev, &mvdev->vdev);
> +       put_device(&mvdev->vdev.dev);
> +       return err;

As a suggestion, the cleanup could be more symmetric if
mlx5_vdpa_dev_del checks for NULLs.

But I'm ok if you prefer this way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>  err_reg:
>         destroy_workqueue(mvdev->wq);
>  err_alloc:
> --
> 2.54.0
>
>

