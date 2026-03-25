Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB7331A41
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430998; cv=none; b=l8Mbq5QW4gCCnrau3SwnDoIFWxJz1Q7njeoBWYr7Ktn4MlwDEbUvOwzkFshoxN+oXNf0kKsi2R6QztyO5op8EJ/4QQmPYqmGqPlAptgYSqHXuGcd36tUrQsDWPtKhrKL7OSYhbBXuV84NaATLR1FVSEsvp3bF+1WbmnIYgB2cxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430998; c=relaxed/simple;
	bh=hzAY3ZoPFk3ktxoVDsUh6drVK7glBEle7ZgqK1lKcjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb9VW17x3uu9wKf7biP2npOSm7O81HANd9hQgdLNUxzpVVyl5XcyQUCGuFwPwYYKr09zUlt85cekN9xlNo9G6QlPhLB+ijv9m4q3PiR0nFhelvZNt7Cm+k8MyMkARsXlkT0lIEy0C32ZMu9YInsGRQhGdhLPyLGTXJE7+c+YUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIIwNU+n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhpeRjpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIIwNU+n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhpeRjpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774430996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/X6OQFIMMVlzQpHVcxvz5zk00vazKEddYu1a8TXBALA=;
	b=UIIwNU+nPUJJvHBBie22wcCjzDVg3JpRuHuXBHiy0rjpN6rDxNAzNlOeQY2QG9m8DWuxEm
	iaNmUUXhpXPFoYwUfpFYc/GchGtfpCQlnmZs/FYSLP7O1jEI3zV30Rr3AOr8Y9H0wsXSVL
	jcPPi+BUVu4IYinrziQaqTXzZ8OPLkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-hBhGWAnGN4yBYh-qObZ7rQ-1; Wed, 25 Mar 2026 05:29:55 -0400
X-MC-Unique: hBhGWAnGN4yBYh-qObZ7rQ-1
X-Mimecast-MFC-AGG-ID: hBhGWAnGN4yBYh-qObZ7rQ_1774430994
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b47c19ed8so2443159f8f.1
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774430994; x=1775035794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/X6OQFIMMVlzQpHVcxvz5zk00vazKEddYu1a8TXBALA=;
        b=JhpeRjpQEerF7GJ3cEBXJfXL4JOri2U0d5RqtfvHTpgkh71sO3rKFhA//EvtsgVwti
         rfnOwsNQ4rTslJ40Fzk9I0TbeYYUZ5Xv+zq7TaUjVgRwEsyfKg8s9Pq15BcpYJETUtzy
         GjGQegUGrxeQbyDwEtvCmuJ/etjn2Bc4A2bLwFUIE5xQiMyNNgnAbKrvUtZPa+3AgtlT
         YSrq90f+jFYACy0hlMqgRYq76+qOcsEKLNZTY0NUghWrYxq5yY9PNJVoNX0sjXNzPxo2
         M/ehcd6FIcjjB2W43nFQqKbujTW9hL8QGwdrnKMudE6yCBqYGN/Cv3ygswIH8iM7CfKC
         7oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774430994; x=1775035794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X6OQFIMMVlzQpHVcxvz5zk00vazKEddYu1a8TXBALA=;
        b=erQs0r/GATCxJsWMrdQaTbYCMHE3p0QdR54mmDgPt3Q+OOg+nqSW+zhJ63x++MarGm
         3VeRJnsKmf+dEJEESDFilVcR8M2KZhMSa1mYXRPEHhoehOI/7j3jwPSa/JcKeeapnBW2
         5uxXBN15BSyTbZI7LMZGibLUjB118YgZZsIcr+NZBzMOfUrs0GpZFixznjZqw2IoK9/z
         IsrJx6n2yhsB96He1yhym/QgEEt2d4RbfkCY6AcreUenVhR9U8sB9QwtSHU7qzNhaQVs
         IUjl40d+PU2Wwd1PxhdHOo9F1mKrfWhfYHaYfESikqjlZbkn9wsKCssp1cW6LVHwQutO
         YPJA==
X-Forwarded-Encrypted: i=1; AJvYcCWbxzmFwvVZqiz9NYFqEPEoQ1j97AuuBGfYNHdxxHbsAN4v/D4iXxrmB13fx14CfeUtdc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbNndEf34Wgu0dNWzq/dNV5cSva1r2yf2IsFTNUeKw4cq5Ckf
	EA87esnwS7sLLkhCLXIWr0K8MCMlD17Q9E+q0VRG8iCadgJRe+4u7aWiLiOGXwszvDvd9WaSGVU
	DODrRSjR8AK/IqZAM5ZGMH0qYC4EQriYerhnAM8GfduEYezB0xTr/0Q==
X-Gm-Gg: ATEYQzxt6y/atMjurgAGx/NLTvVJCK4+wQ17Be2Yd2s+tXeijCQGGSSYKYzDMFMa3xL
	2jCq9mVL0FhBw4JmQo7qoeE8ku5XZ/tF56RZhPoxxRK7XLkDVujI3NTbnBdjgYPnZXmbk+RFbDS
	Fw2M/A0NHjoyOLjDd5BCHVC+pKQ9MxSG4HHQYNmyIM9B1dk/6zIh7E+VGNW2qfhDwJxViX/WYCQ
	QkE60IV69q9rUVhJAHH4/5L/biG/i0zK3jVTZKKUBmhWTK61Ve0yMEwYbl9UMtHZYAOfx8K0lyn
	IF5G2wUcdt/V95N35Jc0T7SkDd953ryMvmlSKZpciVnMjOtk0rKVMNFXw6FqnBqw+XuNpj3WeW6
	eY45j8FlwrpATRIRo
X-Received: by 2002:a05:6000:400c:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b88a3d3cdmr3692824f8f.14.1774430993612;
        Wed, 25 Mar 2026 02:29:53 -0700 (PDT)
X-Received: by 2002:a05:6000:400c:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b88a3d3cdmr3692727f8f.14.1774430992928;
        Wed, 25 Mar 2026 02:29:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470380asm44280922f8f.24.2026.03.25.02.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:29:52 -0700 (PDT)
Date: Wed, 25 Mar 2026 05:29:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
Message-ID: <20260325052919-mutt-send-email-mst@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>

On Tue, Mar 24, 2026 at 01:59:04AM +0100, Danilo Krummrich wrote:
> This is the follow-up of the driver_override generalization in [1], converting
> the remaining 11 busses and removing the now-unused driver_set_override()
> helper.
> 
> All of them (except AP, which has a different race condition) are prone to the
> potential UAF described in [2], caused by accessing the driver_override field
> from their corresponding match() callback.
> 
> In order to address this, the generalized driver_override field in struct device
> is protected with a spinlock. The driver-core provides accessors, such as
> device_match_driver_override(), device_has_driver_override() and
> device_set_driver_override(), which all ensure proper locking internally.
> 
> Additionally, the driver-core provides a driver_override flag in struct
> bus_type, which, once enabled, automatically registers generic sysfs callbacks,
> allowing userspace to modify the driver_override field.
> 
> SPI and AP are a bit special; both print "\n" when driver_override is not set,
> whereas all other buses (and thus the driver-core) produce "(null)\n" in this
> case.
> 
> Hence, SPI and AP do not take advantage of the driver_override flag in struct
> bus_type; AP additionally maintains a counter in its custom sysfs store().
> 
> Technically, we could support a custom fallback string when driver_override is
> unset in struct bus_type, but only SPI would benefit from this, since AP has
> additional custom logic in store() anyways.
> 
> (I'm not sure if there are userspace programs that strictly rely on this;
> driverctl seems to check for both, but I rather not break some userspace tool
> I'm not aware of. :)
> 
> This series is based on v7.0-rc5 with no additional dependencies, hence those
> patches can be picked up by subsystems individually.
> 
> [1] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.org/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=220789
> [3] https://gitlab.com/driverctl/driverctl/-/blob/0.121/driverctl?ref_type=tags#L99

vdpa bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I assume it'll all be merged together?

> Danilo Krummrich (12):
>   amba: use generic driver_override infrastructure
>   bus: fsl-mc: use generic driver_override infrastructure
>   cdx: use generic driver_override infrastructure
>   hv: vmbus: use generic driver_override infrastructure
>   PCI: use generic driver_override infrastructure
>   platform/wmi: use generic driver_override infrastructure
>   rpmsg: use generic driver_override infrastructure
>   vdpa: use generic driver_override infrastructure
>   s390/cio: use generic driver_override infrastructure
>   s390/ap: use generic driver_override infrastructure
>   spi: use generic driver_override infrastructure
>   driver core: remove driver_set_override()
> 
>  drivers/amba/bus.c                 | 37 +++------------
>  drivers/base/driver.c              | 75 ------------------------------
>  drivers/bus/fsl-mc/fsl-mc-bus.c    | 43 +++--------------
>  drivers/cdx/cdx.c                  | 40 ++--------------
>  drivers/hv/vmbus_drv.c             | 36 ++------------
>  drivers/pci/pci-driver.c           | 11 +++--
>  drivers/pci/pci-sysfs.c            | 28 -----------
>  drivers/pci/probe.c                |  1 -
>  drivers/platform/wmi/core.c        | 36 ++------------
>  drivers/rpmsg/qcom_glink_native.c  |  2 -
>  drivers/rpmsg/rpmsg_core.c         | 43 +++--------------
>  drivers/rpmsg/virtio_rpmsg_bus.c   |  1 -
>  drivers/s390/cio/cio.h             |  5 --
>  drivers/s390/cio/css.c             | 34 ++------------
>  drivers/s390/crypto/ap_bus.c       | 34 +++++++-------
>  drivers/s390/crypto/ap_bus.h       |  1 -
>  drivers/s390/crypto/ap_queue.c     | 24 +++-------
>  drivers/spi/spi.c                  | 19 +++-----
>  drivers/vdpa/vdpa.c                | 48 ++-----------------
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c  |  4 +-
>  drivers/vfio/pci/vfio_pci_core.c   |  5 +-
>  drivers/xen/xen-pciback/pci_stub.c |  6 ++-
>  include/linux/amba/bus.h           |  5 --
>  include/linux/cdx/cdx_bus.h        |  4 --
>  include/linux/device/driver.h      |  2 -
>  include/linux/fsl/mc.h             |  4 --
>  include/linux/hyperv.h             |  5 --
>  include/linux/pci.h                |  6 ---
>  include/linux/rpmsg.h              |  4 --
>  include/linux/spi/spi.h            |  5 --
>  include/linux/vdpa.h               |  4 --
>  include/linux/wmi.h                |  4 --
>  32 files changed, 88 insertions(+), 488 deletions(-)
> 
> 
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> -- 
> 2.53.0

