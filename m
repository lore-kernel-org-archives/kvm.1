Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F548F83A
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786827; cv=none; b=BvXun5tw6EXVtxE2rJbKa3LM1RlE+nr91tl9XxTOWofjZN9qBbSfdiqWjdTFSXEitajv1G26AeIcUboHG7QVzO3ekQYgZV97jWduoRHXl58hIqgIXE61eDO9+bLGJTtTdYvfidrc+cWMoPjnJ9GnnnCs+JyZh3xBbFh6n1V/LYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786827; c=relaxed/simple;
	bh=bbyM8+xnMNKO6fyiNZM2V/dxEjYjP4AdG79mC8RAzeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks6/hupL2CJJ9vW72YOv6fxuybDuc/aXCpobh+L6/iCNSTONqFD7kqpClW3hCDG9Z9Tunry4sLbRcc8FBQ8xJvkX82MJ6atmbDk1+Cz+TRbn2sHbkBEH2aW+VbY5ZF4STnsig0rQK3cauDVsCmV2svXewwCGt+O4hCi0C8l3hQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHNlFA48; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy0OdkN6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHNlFA48";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy0OdkN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788786816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
	b=BHNlFA48L6Asxjk6Ul+pWL3mabZqd5KTjnSteMGdxnnZyajaCr5ADj0iKLTlFUGCEO5+WY
	YAMEizLB05z4sEZqsrsQPDfWoUgbFoV+jn7DI2SyMJWuZOgl9rx2C6l4WjjfohV8Mx7FQP
	6MDH0UD/97lsDKfJ6/Lk9lzKva4/Idg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-MO_tU5wUOFO-NkQL9VfPAg-1; Mon, 07 Sep 2026 09:13:34 -0400
X-MC-Unique: MO_tU5wUOFO-NkQL9VfPAg-1
X-Mimecast-MFC-AGG-ID: MO_tU5wUOFO-NkQL9VfPAg_1788786814
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49545071724so27732365e9.0
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788786813; x=1789391613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
        b=gy0OdkN6w26QFaOXv6fYnw8KuIo1/jlD0unXb1oGGSeoNrDrS7mYYQLaJiR6oDbzMF
         teCyJbW66P7C3M/aCB9FZfW+5GRRyDB/Rq23ykl1KB6k6eksjLwb7l90ZQy4ALCGjylK
         6ZOXfRnWwOfMy6iTBarbpaBKWoubHxdVWsuBaQu9mHs5IfpFxxQCrLk46MSzhThSPjri
         hJsPXQCudWjdBKNId+zsEFwKwQ+gw1HAGxC4t2g7VTaF85nzmkRhKfrBlJyDA26flBYq
         Qxwzw6UqsPJ8Xu/wgOVuhnlDkwpo6is8QNCtDEqp6tzuI+6LnV0tahMLVEy12wjsjcMr
         fvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786813; x=1789391613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
        b=GK4HKt54jTr2a+yJQBVVJ9E1EP+E3ZpC3ccyP3jOtrloECOQDNK5kedvgtMb7V8GSt
         FOso/C1FmcFcc4LXnR72w6xodiNlNvWy4e+tYdR8X7e6s0b052hngEkvn4F1FkgUmQ6Z
         XW7eBk+X+a1KIpgcx3IKf/RtsGu5Dh47p2nVsiWJNyGBx9R5LHV8vN09KtdE4/gR6ih1
         Z3T1Zw0OP9D/Oauy0muk6DAj/0F2bn7abkXd0i2uMy8/5MRyQxSioDtnUWMk6M4AGZ8d
         JMNP7IlCPgWtERL9NX+rMrwpmPhqzr3gcwjCyPZ3mCqJrmlg9oe0moCXXHL0qRrcQXlk
         JUQw==
X-Forwarded-Encrypted: i=1; AKwUvBzVsxxllwNYRJxjagXg2bha+DlCimVC+1SeX4j2cHVweWQl/HiPL6w89HJ4igHAjXRayFw=@vger.kernel.org
X-Gm-Message-State: AFuF++mbzSodCcaVAPkCiTNMOcSdVoUsBcOs4Y6hR46eADHm+7lKdDiH
	3FyOTSnrRivt4sPNxT3gMQq/pl0OSYA/ZKjxHuOXSGy/D/VhXfBFgeaWowu7mr0GqqSStO73VQT
	gDVGc02XXdQExlwGttrifAQwrOqsuqbb01xIQj542YxNGOzKzA2yZFQ==
X-Gm-Gg: AYBFou3JLRHyon1gRO4Cgv386eflgf15bhJVxIc34hXcVqqtyQilNAODu9xU4YJQxBN
	HUZn+VL7peJYNnsMAxAkRecvo8NYmcVdi5q3NAKifiYqrQ5HYIBTD/BFXMSKkk7xlmRaqUaUogo
	bKq9/1QThOlgFb2wYQkiZVUYxRRHkl5ESS6Fmj1tzzvkhMN1n99qe0WrXw68nr8LZZFhjOCEEMo
	34u1mA//S9rmJ4eeexzcK+zGBAO1TU+uTXMoRENNa2RE7Cl68rjCv9ZQ0cDPJgI6hMPB7AwjiTN
	Ap42eWndzHQZsUpCdX9AeqSVN6ZcSynZtNT9wq9MMaAIzhLCxGjPbo6CAZEttXHGhGULLdbVsuf
	bpugxQ7FMcDLdi6vCJCeoQJM=
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr197561185e9.26.1788786813428;
        Mon, 07 Sep 2026 06:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr197560545e9.26.1788786812906;
        Mon, 07 Sep 2026 06:13:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm270920615e9.3.2026.09.07.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:13:32 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:13:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907091033-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:56PM +0200, Karl Mehltretter wrote:
> A virtqueue callback can outlive virtio_reset_device() and race with a
> driver freeing the state it uses. The reset helper documents that no
> callbacks remain in progress, but that depends on the transport:
> virtio-pci waits in vp_reset(), while virtio-mmio does not.
> 
> virtio_input has a related ordering problem: it unregisters the input
> device before resetting the virtio device, while an event callback may
> still be using the input device.
> 
> Patch 1 moves the callback wait into the core, using the existing
> virtio_synchronize_cbs() operation. Patch 2 fixes the virtio_input teardown
> order. Patch 3 adds the missing synchronize_cbs hooks for UML, TmFIFO,
> remoteproc and virtio-vdpa. Remoteproc uses one SRCU domain per processor.
> 
> The new hooks wait for callbacks already running. UML, TmFIFO and
> remoteproc still allow new callbacks after reset; fixing that is separate
> work. The event-virtqueue DMA mapping issue is also separate.
> 
> Changes in v2:
> - Patch 1: move the wait into the core instead of fixing only MMIO, as
>   Michael suggested. Remove the duplicate PCI wait, preserve its shutdown
>   wait, and fix CCW callback locking. Drop the MMIO polling: reset polling
>   for v3 and newer is already in fa8833c085b6 ("virtio-mmio: add support
>   for transport version 3").
> - Patch 2: keep draining completed events when ready becomes false,
>   instead of breaking out, so teardown does not truncate an input packet.
> - Patch 3 is new, at Michael's request.

got all 3 patches now. it's a good start, thanks, but they need
a bit more work, in particular addressing sashiko comments.
I'd also prefer patch 1 to be split: moving code from pci to core
is separate from ccw fixes.

Pls write or at least edit commit log messages yourself,
after reviewing Documentation/process/coding-assistants.rst

Thanks a lot!


> I reran the 120-cycle unbind/rebind test in an arm64 KASAN guest with four
> vCPUs and a 5 ms busy delay per event. With patch 2 alone over virtio-mmio,
> reset returned with the callback still running in all 84 overlapping
> cycles. With the series, it waited in all 103. Over PCI with per-queue
> MSI-X, it waited in all 66, including runs with threadirqs. No KASAN or
> lockdep reports. These runs predate the per-rproc change, which leaves
> the tested MMIO and PCI paths unchanged. They confirmed the missing wait,
> but did not reproduce a use-after-free: with evdev attached,
> input_unregister_device() waits for an RCU grace period that the IRQ
> callback blocks.
> 
> That version also passed QEMU input, rebind and shutdown checks on arm64
> MMIO and x86-64 PCI, including arm64 RT, KASAN and KCSAN builds, and x86
> UP/Tiny SRCU. A legacy INTx NIC was present for an additional x86
> shutdown check. The changed objects built with W=1 without warnings on
> arm64, x86-64, s390 and SMP UML. The per-rproc version built with W=1
> on arm64 KASAN and x86 Tiny SRCU, and passed six remoteproc callback and
> lifetime KUnit tests on each, using mock remoteproc devices.
> 
> Link: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (3):
>   virtio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
>   virtio: implement synchronize_cbs for remaining transports
> 
>  arch/um/drivers/virtio_uml.c             | 10 ++++++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
>  drivers/s390/virtio/virtio_ccw.c         |  6 +-----
>  drivers/virtio/virtio.c                  |  2 ++
>  drivers/virtio/virtio_input.c            |  8 ++++++--
>  drivers/virtio/virtio_pci_legacy.c       |  2 --
>  drivers/virtio/virtio_pci_modern.c       |  3 ---
>  drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
>  include/linux/remoteproc.h               |  3 +++
>  include/linux/virtio_config.h            |  6 +++---
>  12 files changed, 86 insertions(+), 19 deletions(-)
> 
> base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
> -- 
> 2.39.5 (Apple Git-154)

