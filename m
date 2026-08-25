Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC837E5D4
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702134; cv=none; b=MqiOVwQgqlUFocxc3FzorO97uhzcDMUE2DGqfFZ4NdKZI+A9IxD6nY56NLAbs7n2vX5sLVVCE9hh84UDP68DNrdUsVxfpm8VyzwR+qI8eiGyFZaZkWxbRxwCcRysWeHQPUdVVMGq8hp6XqBtl1AYdAjE+RkwmkjUBwIjvo5xRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702134; c=relaxed/simple;
	bh=nJzvKV5RdNjT20122eQS9Y8KcNlkvArWb4MBCjyIqo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXRta94fxQGq6gfXJG03fHkvX1P+KleRkD/qvhvJCYhC6GV9c4A98b4fCTxDs0mybaA0aArJB90Em2mffWcfvaLY2hwtVy6iYs9eLaiPH+QALX+opMKummu1USj5PcIseOQCerRruJIrdc7CTbbB46yT43JSfBHqcR1dEOzOEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSW4AY/F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSW4AY/F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso54685ad.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787702132; x=1788306932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ey+wn6cAebd+t1irK4HD6c3C1J4yUAwvNpjxUGDSeRU=;
        b=tSW4AY/FU02A6vEecJWgVTID0Cdv7uaqktuLSJ12zQ9tynKu3L+4ppaDLnZezhOTg6
         OIxLDdbUwjd7Bg+lVj5P0OPHM2d9izjYvn30ob2egYFNH2SSqxemsH6a0hUWJUyAzH5G
         2gxXa1ytNU2vrvlYfGfhwtG4+ffJKMRddP6TS60c5veEAVV02b2dCdxC3TnpjU9z+D4w
         xOOsWNvwS9PaefUAG9LnCNx7sovM/5ukAf9hS4g6Zjelma8BMFUXub6wHZkuD4avoZfW
         VStfrb7YuZMTqx2abPQRpyS0PowHctxra3rVaFp8KOGSnlAClS1cvr5aAvwOW3aNr+5j
         dnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702132; x=1788306932;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ey+wn6cAebd+t1irK4HD6c3C1J4yUAwvNpjxUGDSeRU=;
        b=CE/crs6nvAiXujJPn0z+Jb3G+OSGcWIlK97wt1rXrcDND/DKlMwDJuizkt39R5VNgv
         djr7irSP4Q1jz5jLPwtkbBYEATkHNUOWTAQfioZN6CmOg2Ym6y/IF6gh8GHhF4F+K3rb
         wsPqTvnHFYsV2kLJO7dNkoSXiwP5qo5ZCJ0/RYau9ACaycheQBhFZ7+LrnBO0QEvRida
         5TuDjhtqXdUOKPcTqIQNXC/X+AmJqW8/23SyDCG2lthKdYSK2JZWZxLilfBTefJkJJwc
         3FkjZbZCI3xhhSzi9LbOxQFd7rcthEmxrk0xmC0rh3XW7Hu6iCPgnx9GXYtJJ0Pq4Rd0
         I/cA==
X-Gm-Message-State: AFuF++lQlHBU+TQq2gxmgkUbIe45C+c7tfIMEs0aQ+I9JzGlu4sa4j0F
	jiOsYDaJhrVfhiznUFH4HwOPnRgO6xVTDzpc5YtkhPUQSMkHltGLGLv2vV406BcO8Q==
X-Gm-Gg: AR+sD135Fpwzws6Sa15rz0F12wwdiHr1Agpg08OYiEvOFU8wDSYJso35ZGcOXiBRr6z
	gEbf8q11yr9VEfmz7d+3COLF/ZWVQUlGkkUXIPDsOzC3ZeEdJSWBmQDKQtSXfow3qm4vpjcJ4dq
	UG9V1YIY/Ah2Ud0CfOoDbdr+6qQo+R3vkm9KRlwSNocoVUlMhUAK6Ld9FSZlcEYq3fah00acJj8
	K5J2UYNkm56nQDupnt0nasfqc4swZuN9nYjIcskmz17st4tdc3bFQ80Y8T2DyBqf0c4Sh/UeFHb
	nl28APJyDSBmyDHdRK8n3N+Muin6+Ya6tPxBT8Ko+oB+gFh1H5mnHRVS5BHHZ/T3lQsgAYXrUfM
	oRo2yj7ts0l/+A9l8Mi54Xc1FO1K65gMHOoEd+ka8zAVm3iZZ8jZcH0DMieZWiJxsJ13FqOlf0I
	/Y3neFAiOWLTaWxcP1flvhoP8Bm5A+uI6DzAAOwpDt4V8PWWqg5UBuDi61OfXz1MLyiTmE+tpTj
	CFTHiHXM7Anb5Tq4cJGDXCRsEYWo3xNIIr8VGNo3qJjjWSaP62a1O1KEKoX
X-Received: by 2002:a17:902:f78e:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2d70bce23d2mr2108605ad.18.1787702131642;
        Tue, 25 Aug 2026 16:55:31 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85359cd72acsm317347b3a.2.2026.08.25.16.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 16:55:30 -0700 (PDT)
Date: Tue, 25 Aug 2026 23:55:27 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <ao4qtNRObZNNSZk4@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812045325.2733631-2-alex.williamson@nvidia.com>

On Tue, Aug 11, 2026 at 10:53:19PM -0600, Alex Williamson wrote:
>pci_reset_function() and its locked and try variants are intended to
>provide a function-scoped reset.  The bus and slot methods supporting
>this interface refuse when sibling or subordinate devices are present.
>SR-IOV VFs however, are not currently considered in this scope.
>
>Correct this oversight by testing for non-zero VF count in calls
>through the pci_reset_function() interfaces.  This test needs to occur
>under device_lock to avoid races with .sriov_configure.  It should
>also occur before pci_dev_save_and_disable() to avoid calling
>potentially destructive reset hooks.  Tests are therefore added
>to each of pci_reset_function(), pci_reset_function_locked(), and
>pci_try_reset_function().
>
>The __pci_reset_function_locked() interface remains a low-level
>primitive depending on the caller to perform such tests as necessary.
>The vfio_pci_core use case of __pci_reset_function_locked() is pulled
>through with this test.  Other use cases, such as xen-pciback, that
>don't obviously support or prevent binding to SR-IOV enabled PFs will
>need to decide whether VFs are possible and can be preserved.
>Additionally, direct callers of sriov_enable() that do not hold
>device_lock (lpfc) are considered a preexisting, non-compliance issue.
>
>Fixes: dd7cc44d0bce ("PCI: add SR-IOV API for Physical Function driver")
>Cc: stable@vger.kernel.org
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
>---
> drivers/pci/pci.c                | 19 +++++++++++++++++++
> drivers/vfio/pci/vfio_pci_core.c |  4 +++-
> 2 files changed, 22 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c

[snip]

>index 3f11a9624b9c..9757b171791c 100644
>--- a/drivers/vfio/pci/vfio_pci_core.c
>+++ b/drivers/vfio/pci/vfio_pci_core.c

nit: This probably needs to be a different patch.
>@@ -790,7 +790,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
> 		if (bridge && !pci_dev_trylock(bridge))
> 			goto out_restore_state;
> 		if (pci_dev_trylock(pdev)) {
>-			if (!__pci_reset_function_locked(pdev))
>+			/* Enforce function scope under lock for SR-IOV PFs */
>+			if (!pci_num_vf(pdev) &&
>+			    !__pci_reset_function_locked(pdev))
> 				vdev->needs_reset = false;
> 			pci_dev_unlock(pdev);
> 		}

I was worried that this would fall into pci_restore_state() and disable
sriov, but it doesn't since there is a check in pci_restore_iov_state()
that skips disabling sriov if VFs are enabled.

Do you think we should skip the pci_restore_state() in general?
>-- 
>2.53.0
>
