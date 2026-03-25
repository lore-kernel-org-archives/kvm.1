Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1A3E63A0
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453787; cv=pass; b=iY3QgdHn3PKpSOeuupCrniqmYIQ1WFZLA7ZtFjnJ56SlRUYZndZ7wtMXK+0xUQ0iVHK7BrhSz/jyuKEHat+dT/eOyzZvmBJFzlHI+kcp3XsI9J9nZ0/TnlUChIS6IM2eKm7FX2+lSE+wGDwCyG5nBOC+6+vx1Fh2eIYXcAayQwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453787; c=relaxed/simple;
	bh=SMw1jlxrpubfTnHEDlbO4rziVId8vc4wQCntfT4i+lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn20HiILHtoqPqzN54f9d9mYKsYWqop1ZTRSvs34x6JjRUbWt1NovL32W5u+4N7srteM1s2wArXLiDzt4WZ1SpdyQxCln+/YHD++/Lk0cnqk9dkuA0Se1CTb3ZVnzU5OM9gPbKUUMJ1dEeObrDsHt8evDS8E+buRvGeq1bEvGzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NboHdeJy; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NboHdeJy"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so4392965a12.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453782; cv=none;
        d=google.com; s=arc-20240605;
        b=TfwEUmrlFGNFyhsHGX1C0eHoOiE+NrEsEz1Ney0VZH5+BBSQPf+bFP/NenkiSasXmy
         1GfJoDF2gL9wK9d6DD+XbiCqhTDCF0dQhsXlg78Ub45BJewazHE8kIVSxBa97dxjQH5l
         c5v0EYAmwkbHGJy2HeOSW31CAFTH28VaP/Skm4XzyCOuOl+eYDaXWq2rwKo9fDrzbPip
         UK752NtXcwhy4HBgILQzEjLCpb1vAlgYAUodxdOcF50nRzt0rGWwWpF05fptSm0fYTXZ
         70J30GkDdQuYz7H2KRDENfdCzmiG9uFMquyNpfKrmzH+iEUcPa++IyQrPp8YaeI74YCV
         6YkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PetZC3qxgw91I7G4PL1kgiG97oaIIgIA0g2FQ1jwb8M=;
        fh=9EKgHE4K3/GOa6svzgVqMYwSueaDXxijtRGabUeczGs=;
        b=SByldn5C2sqCSGQAP8AwtRcaiV82b8uRHZpTT5TnKLZeHYqJQRi0b6ILNptVSk++TQ
         XFDd0Z0mP92oSP51i6qpU5LfvBHukDGskDq1m4LWPPkRpdOwP5oHpN0MbVf7XAgcTDto
         OqVJp41VPb7+onfXO2Pxt0PMNDpNfLEqlCipwwvcJbtPHx6Ute5uU2KDnhYmnu6BfgdH
         hseHmPgRW4X9a09Vny0tCOKHHyl/DAIcNpyLvcLrA+xrMhaqjyCqR9ptyYUJxk3QuckA
         Dax3KmToO2puyoqbe4aKPfPfWkHBczUq0FyH/UarzUp0MhceRJlS2wAmsLoUoF8TP2eC
         iTFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774453782; x=1775058582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PetZC3qxgw91I7G4PL1kgiG97oaIIgIA0g2FQ1jwb8M=;
        b=NboHdeJy5rqGSnXILD9hwlr7QiyRU1LH/ue16iQyMsxCAyhZj1NvxCbm2HAeBhkudu
         FAC6KYzF734ktdTxcB05tjcgxJty3pUoyU98ok+Ks13UjLw2J/gcW0KyOTnXcKQ8J8Pj
         z7NS7clU2pMGlFojeHqUVytaEmqQv1dJrZPFe9yftZPIKqRgNksGlvqfhNgT5ECOdDRh
         BE6iuCGcvAbY68M752e+aCt2jMXMusBcxQa4WX3MHDvHjAXMRlM61xlzilZ6y0L6oFH1
         WbnrQej0rE3qZXSxCJgQsEOyjVsjFXAAMsviK8eGZMwQKl2Ly3HsBCplL72PGSQRPwT6
         tf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453782; x=1775058582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PetZC3qxgw91I7G4PL1kgiG97oaIIgIA0g2FQ1jwb8M=;
        b=SqLd0EulKItSTTDG14wLPH98dgiYEcdNSVyJVvlYeL/2upvKclXHFVCEKaZ65naM4d
         Eh8uKGi/29awJzm9x03ehtS7ttX/dsZYuytPzNG8Q4sHFLi/nPcKcrYJYHqAjXKk4NPE
         bSy/1acHzeaX1JTLTcz7vtnNthLyXc1N5rtR3yygSjyRyEMT8Ig9y8chrZ/GAA0OVFmQ
         9eIh1+gzn+XZS1sOwN7B0/VsDuE0xz0B3wTTTzKzsDrHVe9ZBamNQayU2DJcZET9leho
         30FXf52WPC8tQ31yHW6IsooEXMlRXJuKWf8F3Qi/Fp2/zy3kswykvHqTERsTqXvMAZwz
         LQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE+8mcwAMfd2ehOlG0wr6wxjAKpdKlRDh+g4KYd+KGTBT3B/idOh1/XziWH4T3aI+6rF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+Vah/XNiDtEEmjfmAqFzsDyDNj0Vzet9ZUeLrsPgZ4ejfJeV
	slKmC/vUFgvKXaDZJyJeanW5/9dlkPHuBGFaOhrG/i7n1DV/OMGcOHz4B9OXsRTi3al+C/vvy4k
	j4iz1wtlTQXnIwsqEDXnyE5WTuTkF4POCon4Qrsc2sQ==
X-Gm-Gg: ATEYQzwdH8OrcI+zEcrxRzTAQj3BeH+EZ+YBWIeIb6a9P04LUZij76LTITucNvwzuVw
	I8erQvriXJIQAUpGRIcGV6CVqL4K1APV1WL3R9qg7Rymwmr7sU4+AnFOZ02vxj+V24/tuyYMbS7
	sh1CeeGTnXmO1JsYx/2UZM8roISh3tHWHiiUF3Vk5YGKmw7EfzVZl1nI7t77i0PMpQSgfcOWrV+
	tKsb5auMm/Kj0266knYw9eSTKzbxkNqKu5s/V8hglTJjlxFwHcGwQGSWFu5VRaEwFrc460d0a9H
	Od080uriZgViQFlPxqo3jwnJWeIX/Ap6GjC4N/jGOA==
X-Received: by 2002:a05:6402:3251:b0:668:368b:38d3 with SMTP id
 4fb4d7f45d1cf-66a82634560mr2196905a12.12.1774453782373; Wed, 25 Mar 2026
 08:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-8-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-8-dakr@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 25 Mar 2026 09:49:31 -0600
X-Gm-Features: AQROBzDaUkN0ZNcFR8HLoPUZ0UwwRolGugOyW2ifJVz-O5YTothUc8ZwonnT9P8
Message-ID: <CANLsYkyNx+e=QrSc=ZOqgMcOpwqdpCWsuhrvByJYcXLHPSHMUw@mail.gmail.com>
Subject: Re: [PATCH 07/12] rpmsg: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, 
	Mark Brown <broonie@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
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

On Mon, 23 Mar 2026 at 19:00, Danilo Krummrich <dakr@kernel.org> wrote:
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
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Fixes: e95060478244 ("rpmsg: Introduce a driver override mechanism")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/rpmsg/qcom_glink_native.c |  2 --

For the below files:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  drivers/rpmsg/rpmsg_core.c        | 43 +++++--------------------------
>  drivers/rpmsg/virtio_rpmsg_bus.c  |  1 -
>  include/linux/rpmsg.h             |  4 ---
>  4 files changed, 7 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 9ef17c2e45b0..e9d1b2082477 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1623,7 +1623,6 @@ static void qcom_glink_rpdev_release(struct device *dev)
>  {
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>
> -       kfree(rpdev->driver_override);
>         kfree(rpdev);
>  }
>
> @@ -1859,7 +1858,6 @@ static void qcom_glink_device_release(struct device *dev)
>
>         /* Release qcom_glink_alloc_channel() reference */
>         kref_put(&channel->refcount, qcom_glink_channel_release);
> -       kfree(rpdev->driver_override);
>         kfree(rpdev);
>  }
>
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 96964745065b..2b9f6d5a9a4f 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -358,33 +358,6 @@ rpmsg_show_attr(src, src, "0x%x\n");
>  rpmsg_show_attr(dst, dst, "0x%x\n");
>  rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -       int ret;
> -
> -       ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *buf)
> -{
> -       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
> -       device_unlock(dev);
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static ssize_t modalias_show(struct device *dev,
>                              struct device_attribute *attr, char *buf)
>  {
> @@ -405,7 +378,6 @@ static struct attribute *rpmsg_dev_attrs[] = {
>         &dev_attr_dst.attr,
>         &dev_attr_src.attr,
>         &dev_attr_announce.attr,
> -       &dev_attr_driver_override.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(rpmsg_dev);
> @@ -424,9 +396,11 @@ static int rpmsg_dev_match(struct device *dev, const struct device_driver *drv)
>         const struct rpmsg_driver *rpdrv = to_rpmsg_driver(drv);
>         const struct rpmsg_device_id *ids = rpdrv->id_table;
>         unsigned int i;
> +       int ret;
>
> -       if (rpdev->driver_override)
> -               return !strcmp(rpdev->driver_override, drv->name);
> +       ret = device_match_driver_override(dev, drv);
> +       if (ret >= 0)
> +               return ret;
>
>         if (ids)
>                 for (i = 0; ids[i].name[0]; i++)
> @@ -535,6 +509,7 @@ static const struct bus_type rpmsg_bus = {
>         .name           = "rpmsg",
>         .match          = rpmsg_dev_match,
>         .dev_groups     = rpmsg_dev_groups,
> +       .driver_override = true,
>         .uevent         = rpmsg_uevent,
>         .probe          = rpmsg_dev_probe,
>         .remove         = rpmsg_dev_remove,
> @@ -560,11 +535,9 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>
>         device_initialize(dev);
>         if (driver_override) {
> -               ret = driver_set_override(dev, &rpdev->driver_override,
> -                                         driver_override,
> -                                         strlen(driver_override));
> +               ret = device_set_driver_override(dev, driver_override);
>                 if (ret) {
> -                       dev_err(dev, "device_set_override failed: %d\n", ret);
> +                       dev_err(dev, "device_set_driver_override() failed: %d\n", ret);
>                         put_device(dev);
>                         return ret;
>                 }
> @@ -573,8 +546,6 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>         ret = device_add(dev);
>         if (ret) {
>                 dev_err(dev, "device_add failed: %d\n", ret);
> -               kfree(rpdev->driver_override);
> -               rpdev->driver_override = NULL;
>                 put_device(dev);
>         }
>
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 8d9e2b4dc7c1..e0dacb736ef9 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -373,7 +373,6 @@ static void virtio_rpmsg_release_device(struct device *dev)
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>         struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>
> -       kfree(rpdev->driver_override);
>         kfree(vch);
>  }
>
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index fb7ab9165645..c2e3ef8480d5 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -41,9 +41,6 @@ struct rpmsg_channel_info {
>   * rpmsg_device - device that belong to the rpmsg bus
>   * @dev: the device struct
>   * @id: device id (used to match between rpmsg drivers and devices)
> - * @driver_override: driver name to force a match; do not set directly,
> - *                   because core frees it; use driver_set_override() to
> - *                   set or clear it.
>   * @src: local address
>   * @dst: destination address
>   * @ept: the rpmsg endpoint of this channel
> @@ -53,7 +50,6 @@ struct rpmsg_channel_info {
>  struct rpmsg_device {
>         struct device dev;
>         struct rpmsg_device_id id;
> -       const char *driver_override;
>         u32 src;
>         u32 dst;
>         struct rpmsg_endpoint *ept;
> --
> 2.53.0
>
