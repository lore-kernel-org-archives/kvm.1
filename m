Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403A3B8D40
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433907; cv=pass; b=j9Zhit6iZOpVr/9bs8ucuohx4MljHmcFwEz9ZiG+/RkWhprFL4A7yaXYZkRJmGoMQ7QOsJmBVVPYQVSaMNiLJvfB9c1kG+DWfTvH0kYju0eegMQ9MKjpq5yeb7jGMB5pGr547ljpbdchVfA3nEiPQ5DQW4bB2+0ICMeMQz2UDh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433907; c=relaxed/simple;
	bh=1Uc6t1cwxW0MzD1dqSUvlR5rqITAHKLiUYzFlCfYbCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUdA2bMrhu1Ysls3OPz35EGPkEx68uxCTSE3s3Bzj1wuL607dKw0eYpNXmBtqavYKpYhHvSZ68LSJkDm/E6oI1el1rpSOtWcmozj3s9BsEHvKSooMW1chCOMlmv1qi9arR3YtcdS1bq1VV1iJaeFkYOJ2DfNKYPyL/ZelWCT2dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8h17s9J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k8c1JG5A; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8h17s9J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k8c1JG5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774433903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
	b=G8h17s9J2A17bpLlEZzx+cMqFoWKBjIwok/JGT+oyiL2v93hAn+uN4vWrMqf/bS6njEgQZ
	u/PfmWYtA1Zr7nKpg3Jdk67X9os+pigzYkdnyW9CLjLrczbeon9GJdjPgZx2NPVKG7HjvA
	ZB6mXl8lDGE/G9qCrGITbXOUFGU7xCk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-AUrv2NuFNlqiBlU4zANPrg-1; Wed, 25 Mar 2026 06:18:21 -0400
X-MC-Unique: AUrv2NuFNlqiBlU4zANPrg-1
X-Mimecast-MFC-AGG-ID: AUrv2NuFNlqiBlU4zANPrg_1774433901
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79868381229so25442117b3.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 03:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774433901; cv=none;
        d=google.com; s=arc-20240605;
        b=fSYQd9O9GfJ1IFGNkROMeoUzzPoW96UpmZHvVqCYJwRCzgzlcPmseHhb8Nv+QtKo7u
         vAE7WIq/fSWWxyRGA7S0ocvDM5Dk8yKbtftoJFlEbPIWSzfKOv/el782znPesrJC1ScZ
         +Is1ANnfYGfwMyn0ldUOfr3sqbfa5LfO4PsNPjQNhDLazPwKjq0zDKlhStNFCfQeANjT
         +dlpN8wpryH8SblFdwsJVI4PhQmF9i28EyjIwqHwj0isypXV8Hn4S8rvlfXcGqT6rxEO
         UtLj0I0iSz+VDXJvMZtwo4aBhc8XMndHYltZE50rwdMPbhYazR51KPknEacbqAzbNxhJ
         dhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        fh=m15FOu+3VrR5yrB3+eS9mjIBvgHcjMcdC5Hm2R/pm7o=;
        b=OCcrAnKq34AutRds4EN62WPyfnbjZnJDM4ixoHPyEGY2g8G4s8Is092OMNRz/E7Vqx
         oBdKVp693bvPEYXKUOlHqSo9q0duRs+GYQDZyWP7brubBUDMLdWmTI/gREuy4AMsOp2T
         Iy34Omjh3S7qF4kYTx9h0mcpV82zfuDZl6O7KeTY5+16VMtBXyaVhobeIQJmMUnQlM7N
         w6ujDVUV0nwlHTKaUlBLEjzpjSIfp4wSv+Fh4wyP127PEz8y9Wi7haQmWvfzn4qgsOya
         0pYeD0Rx1QU3jiQrUGZZnLd/wLT2hXhGHoh6NEsBD9nzmb6w1Hapk1BS1qeAlI1735Yt
         fVvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774433901; x=1775038701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        b=k8c1JG5Agh13tecyye3G/dBXeSoWEHgyu20i/HK0WpMm2AFG9kpTvNrLWYqBP+O3s/
         tHypkdE43WwKBfjRLoJgSSwV99V4JVgUbpqe62RgAym0i/zybZ+6C3lcjyHkvG7RwgQV
         PSYmTY8cMZZt0Xn7dvJGsvFwP2eyWTLrNr2moqUqNvANKsHQ6NR1cr/Os+Cy+ynJGYDw
         skKrdXE3TqjJIYqbCLpwsU3qFBzYzIKuI/J5j+soiFmkxPqoSVGLWLwO9yH4op+BPHkK
         /I0y48bC3Rb0rQ4mZoKg4saqVxuUvkp8fvSXqRV6Fgz74WGfbQro9hKXX0jDY8tfid5y
         DELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433901; x=1775038701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        b=hCbm+aaoskZBpqcZpdVJVNzau+FtDzWF8F0gMEOvAVFZUSwIFcw7gnEOMHcuasjfeq
         30koMyC9H6zHYO6cuBTRjTWaXBGEzsJA6cpj6wfVXn7KibZj3VgwJKAa5FgYPrM7fWtN
         pf/d428ZRHoSsb9qqK+vcTDQe/wCPh8cVxoKyCpaMd8xN98FVa1LtMDUfjPfE5Jd8YYd
         7QzmUYng2w0TU0W3vMakx+48iZGHC/2NTsVIbUR86tDNMKPjrIvBmPQjcT0+5O5NOiqZ
         dN8tQOVN38OPmMyI09n7o1G1KEBcu44MyESOcGRySo9FiJT8r1hdJsLoXHpMg46ifLX7
         CqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBrE8yM5LYkPypDYqWgw7M3bodrUinKjuHVBoeEOBfweHGG3c2yWfMTkLk8Rp388Dncf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5dq9Vky6tRVSfFoOBixW2MxVxfZE2N3akwkRxzOshZ4UIfA6
	FYRhCTWWu4HKBHzOniZ/TNbgjYDRZ3G8NycvCzEtc9G8dccVudVg4qpQQ/KULVJMflubnYcVKZx
	CCYPETXaCZquEYONnZr+PuFA8XAOD+cUODDZqI3UWZV1LUV0ThPoISo1QCCfxektdQv1yxi59Uz
	bcoiBawEdfK1BPku2KmmrXbuRUBOfx
X-Gm-Gg: ATEYQzwvzTP1gCqgDIJENUQxqZS4l2wrtoYg9BRxuKG1Fp9JneggjZCR4z2PXyNehUa
	enzTSQxLI1QRKsUM49OGsJYYoAyCzOT3zWkGV0JIpw4aHTjnpGLy1c0D0AM34ahvwwy7XXzQbrl
	Qz25KBdMb0QS0wdXbSXa3LxwR1Rh3lfJ9YXzcHuh9Wa/UxApGTX/vTD29LfKNMPwMLd7U0vmfpA
	atKvw==
X-Received: by 2002:a53:acd1:0:20b0:64c:9f60:19d4 with SMTP id 956f58d0204a3-64ed77ef1ecmr4805267d50.8.1774433900729;
        Wed, 25 Mar 2026 03:18:20 -0700 (PDT)
X-Received: by 2002:a53:acd1:0:20b0:64c:9f60:19d4 with SMTP id
 956f58d0204a3-64ed77ef1ecmr4805242d50.8.1774433900219; Wed, 25 Mar 2026
 03:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-9-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-9-dakr@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 25 Mar 2026 11:17:43 +0100
X-Gm-Features: AaiRm50qMzjkKEJ7Fkr-Roi7I1a_DrzOw3E963yu_3LAy7xQt4ygKXGG9Px12Pc
Message-ID: <CAJaqyWeuvD+XntgE9q4epQELpYYTOs1CznFn_tuOxeh_LurrcA@mail.gmail.com>
Subject: Re: [PATCH 08/12] vdpa: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alex Williamson <alex@shazbot.org>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-spi@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-arm-kernel@lists.infradead.org, Gui-Dong Han <hanguidong02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
>
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kern=
el.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 539fec78edb4 ("vdpa: add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/vdpa/vdpa.c  | 48 +++++---------------------------------------
>  include/linux/vdpa.h |  4 ----
>  2 files changed, 5 insertions(+), 47 deletions(-)
>

Consolidate this logic is great, thanks!

> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152..caf0ee5d6856 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -67,57 +67,20 @@ static void vdpa_dev_remove(struct device *d)
>
>  static int vdpa_dev_match(struct device *dev, const struct device_driver=
 *drv)
>  {
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> +       int ret;
>
>         /* Check override first, and if set, only use the named driver */
> -       if (vdev->driver_override)
> -               return strcmp(vdev->driver_override, drv->name) =3D=3D 0;
> +       ret =3D device_match_driver_override(dev, drv);
> +       if (ret >=3D 0)
> +               return ret;
>
>         /* Currently devices must be supported by all vDPA bus drivers */
>         return 1;

Nit: Maybe all of this can be replaced by
abs(device_match_driver_override(dev,drv))? Or maybe we're putting too
much in the same line.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!




>  }
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> -       int ret;
> -
> -       ret =3D driver_set_override(dev, &vdev->driver_override, buf, cou=
nt);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *=
buf)
> -{
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len =3D sysfs_emit(buf, "%s\n", vdev->driver_override);
> -       device_unlock(dev);
> -
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
> -static struct attribute *vdpa_dev_attrs[] =3D {
> -       &dev_attr_driver_override.attr,
> -       NULL,
> -};
> -
> -static const struct attribute_group vdpa_dev_group =3D {
> -       .attrs  =3D vdpa_dev_attrs,
> -};
> -__ATTRIBUTE_GROUPS(vdpa_dev);
> -
>  static const struct bus_type vdpa_bus =3D {
>         .name  =3D "vdpa",
> -       .dev_groups =3D vdpa_dev_groups,
> +       .driver_override =3D true,
>         .match =3D vdpa_dev_match,
>         .probe =3D vdpa_dev_probe,
>         .remove =3D vdpa_dev_remove,
> @@ -132,7 +95,6 @@ static void vdpa_release_dev(struct device *d)
>                 ops->free(vdev);
>
>         ida_free(&vdpa_index_ida, vdev->index);
> -       kfree(vdev->driver_override);
>         kfree(vdev);
>  }
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2bfe3baa63f4..782c42d25db1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -72,9 +72,6 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @vmap: the metadata passed to upper layer to be used for mapping
> - * @driver_override: driver name to force a match; do not set directly,
> - *                   because core frees it; use driver_set_override() to
> - *                   set or clear it.
>   * @config: the configuration ops for this device.
>   * @map: the map ops for this device
>   * @cf_lock: Protects get and set access to configuration layout.
> @@ -90,7 +87,6 @@ struct vdpa_mgmt_dev;
>  struct vdpa_device {
>         struct device dev;
>         union virtio_map vmap;
> -       const char *driver_override;
>         const struct vdpa_config_ops *config;
>         const struct virtio_map_ops *map;
>         struct rw_semaphore cf_lock; /* Protects get/set config */
> --
> 2.53.0
>

