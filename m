Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648D3F825C
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674380; cv=none; b=oIKVhIf+g+jortxlEZcSEyU3Jc+n1Mws8cCozQsxTqebWhjGO0/DHWsYxJJfOkBwtPX/ZNFfslY35grCCiMXKoVIdYGJAwGQl0iiSIygcJUX2Pp+1Gj6+DT2Okb/lI4RRkuCnVp3IuByHABojWrL4g2H9gTC7z16/A08AqqqKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674380; c=relaxed/simple;
	bh=yw4T4xIRvUCnDk702V87YEoZjjbvFmk/m73RhFS/xeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlEFoCYrgYurNBwqslkCGpxd5aDcVdF1E6C/8aqsDPRy/onNVEnnOGhunjuMkoQlYvdmc9+CcgNCf+RQ/NfZ+VLEKGAlRlBBMfitOFfa/7QFlFQsdfHB5OKx44AJMBszaUFGvkAwBQzBWN7MyRUKVZcmqtwK24d3ui/KuUrKFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiIqBPpF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiIqBPpF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso146074795ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784674378; x=1785279178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxnUiUKgz45TKm8FkoVsEhaQ0YHdYAICVOBAO5r+zvQ=;
        b=XiIqBPpF31GXB68vYBCZZ8qZdniGysyH7BWurGdw7lVo4Uc0Juk5WdsxCfKTKn5QlT
         lla5b+yonVjxFgf0KoXR9u8bOVfpKVWaRGR9wcDF9hJY4vHLzMgyJZf/wEteWcJ0YZTt
         ErfNk7VSzIpj2RSuQc0/tGMaMG9uGtCnjYF43D+apXNNyaeFvmX2x/E7ycHh7g3pIau0
         1VF1+GSqos6AyVtXQT5EjubwlkvJ5vmUb0lkd/zU5ksKKtF3cHCV8FMmCFZFGBhKBEc7
         iqz2Wdxt5V70Mh7hIiT8+Yu2ktSA5Wi0Wg5W7y9PZonSLsxMop/Hxc1uc3H8QxFHy97s
         JonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674378; x=1785279178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JxnUiUKgz45TKm8FkoVsEhaQ0YHdYAICVOBAO5r+zvQ=;
        b=FSO+HA9K49OSi0BLudWEBYwHllkOq5fC7fISgsLeMyU2xrx2JO26g/zP6vx+Cxmb/1
         gal2f6Y7RKdiU/22wawc8jWLQUIvSsRUDY9VcY5YJLJj8RkpiXQ388/90XnGp0YrH8w/
         GZrTBlZgZkkv18DAEuyP22GUAZfSlWS6MCnjftcjLn6Ar0ZGvyPCpBjWKvpIgTplAUFM
         R/1eIk2dKPJ2aa5SPiakLLpq7gpzVCGSiSf5BQNjmNoysY3AVvGHQ9fDkyBSahvuspKw
         Aa/jDTyVKYtgbTWiryFUBQtyAN8tqZmP4MjuB7ZkV73HRjP1i/6IwjMJ7+KaWXmpXCr1
         0Fcw==
X-Forwarded-Encrypted: i=1; AHgh+RpPksOqH5HI2IBL34LJZFbSCSXm+PT/GDzb2EA8l87301FTJ63ApKdwpfbEM41RxuaOLJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFzjpGxxN4K7Z/VWBw4+JLRpra+3UuV9d/Lv655KyXG/Z6NFhr
	4BXcSPYu9OslkUsYB84pHDfcZ4hA5HE9S9ZVLbfIz66VLESqZvvy1+uPEx7Oet3lmQR2GdmpPq8
	M+MWcaw==
X-Gm-Gg: AR+sD11/XrwmYRnMZxcARasElryZAsHkGujLuKdN/kNseSZxIBHgbtaJaV96CpYFsQL
	c49xBXfwzF6NxqOZ7Oo41kymxzl68lM8KJsmM9820ABm/PYamDqp/1wJT3jPm/d730v1sKLng6E
	6VxC6iQcZBPUJz53w8itvun04kVFv/Ap3ZDh002sB2qTbMgfgntv29jNcei5jfXVd3xyNjS+B6m
	88T8YdaL1acrzN4oBo3v60YCP4DsrK2R7mBmX2/6U3S2VsxzC21KkVyy0k/k8+QSafoAepirdc6
	kXCu+QP//mxSQ+iyiodYCJdK53ZYPEjWOlF2fJSj6wBAFyS8c9OaITlG+3nWkF7Oe9/UQZ1QNSE
	Dgn5gJHtn/nzUYYusaB93HlwSuYgN80KETU0+T4egWb6bznxItyw+kQrsuasw4yTaE1B65Ld5F4
	MeGoc9sKRhlaUdE4MkpY3sQrupExKlzm8u/27LwdlT
X-Received: by 2002:a17:903:2350:b0:2ce:d5e4:2fcf with SMTP id d9443c01a7336-2cf34a18da5mr220018435ad.42.1784674377389;
        Tue, 21 Jul 2026 15:52:57 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f313287sm3748645ad.58.2026.07.21.15.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:52:56 -0700 (PDT)
Date: Tue, 21 Jul 2026 22:52:53 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Josh Hilke <jrhilke@google.com>, sashiko-reviews@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read
 faults
Message-ID: <al_4RXwK0IeV1n7D@google.com>
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
 <20260714-igb_v3_b4-v5-5-91503eddb98b@google.com>
 <20260714211204.437281F000E9@smtp.kernel.org>
 <CAAdrzjsNJfkFjwK4Nwendph60=FFhYCbXkXzTXO354roK3GoTQ@mail.gmail.com>
 <20260720154227.1f727abe@nvidia.com>
 <20260720155120.2815e269@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720155120.2815e269@shazbot.org>

On 2026-07-20 03:51 PM, Alex Williamson wrote:
> On Mon, 20 Jul 2026 15:42:27 -0600
> Alex Williamson <alex.williamson@nvidia.com> wrote:
> 
> > On Mon, 20 Jul 2026 14:27:12 -0700
> > Josh Hilke <jrhilke@google.com> wrote:
> > 
> > > On Tue, Jul 14, 2026 at 2:12 PM <sashiko-bot@kernel.org> wrote:  
> > > >
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [Medium] Test flakiness due to fixed heuristic delay instead of polling on EAGAIN during VFIO_DEVICE_RESET
> > > > --
> > > >
> > > > --- Patch [5]: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read faults ---
> > > > commit a631c99ce1be37dbbdda0314b730b2c6bd947b50
> > > > Author: Alex Williamson <alex.williamson@nvidia.com>
> > > >
> > > > vfio: selftests: igb: Recover after DMA-read faults
> > > >
> > > > This commit adds recovery logic to the igb selftest when an intentional DMA
> > > > read fault causes the device to hang. It introduces a reset and re-init
> > > > sequence using VFIO_DEVICE_RESET, including a 10ms delay to allow kernel
> > > > error handlers to release the device lock.
> > > >    
> > > > > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c    
> > > >
> > > > [ ... ]
> > > >    
> > > > > @@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
> > > > >
> > > > >       igb_irq_enable(igb);
> > > > >
> > > > > -     return (status & 1) ? 0 : -ETIMEDOUT;
> > > > > +     if (status & 1)
> > > > > +             return 0;
> > > > > +
> > > > > +     /*
> > > > > +      * The descriptor never completed.  On real 82576 hardware this
> > > > > +      * typically follows a DMA-read fault from one of the intentional
> > > > > +      * unmapped-IOVA tests; the fault leaves the descriptor engine
> > > > > +      * unable to service subsequent valid descriptors.  CTRL.RST alone
> > > > > +      * reinitializes the queue registers but leaves the engine wedged
> > > > > +      * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
> > > > > +      * is required.
> > > > > +      *
> > > > > +      * Delay before requesting reset so PCIe/IOMMU/AER error handling
> > > > > +      * triggered by the just-observed DMA fault can release the device
> > > > > +      * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
> > > > > +      * heuristic.  The current memcpy still fails with -ETIMEDOUT;
> > > > > +      * recovery only ensures the next memcpy starts from a usable state.
> > > > > +      */
> > > > > +     usleep(10000);
> > > > > +     igb_error_reset_and_reinit(device);    
> > > >
> > > > [Severity: Medium]
> > > > Will this fixed heuristic delay cause test flakiness under heavy load?
> > > >
> > > > If the kernel's PCIe/IOMMU/AER error handling takes longer than 10ms to
> > > > complete (for example, when KASAN or other heavy debugging options are
> > > > enabled), the device lock might still be held.
> > > >
> > > > Looking at the kernel side in drivers/vfio/pci/vfio_pci_core.c:
> > > > vfio_pci_ioctl_reset(), lock contention causes pci_try_reset_function() to
> > > > return -EAGAIN:
> > > >
> > > >         ret = pci_try_reset_function(vdev->pdev);
> > > >         if (__vfio_pci_memory_enabled(vdev))
> > > >                 vfio_pci_dma_buf_move(vdev, false);
> > > >         up_write(&vdev->memory_lock);
> > > >
> > > >         return ret;
> > > >
> > > > Since igb_error_reset_and_reinit() calls vfio_pci_device_reset(), which
> > > > asserts that the ioctl returns 0, would this lock contention cause an
> > > > immediate test suite failure?
> > > >
> > > > Should this code explicitly poll for -EAGAIN from the ioctl instead of
> > > > relying entirely on a fixed sleep?
> > > >    
> > > > > +     return -ETIMEDOUT;    
> > > 
> > > Alex, I'm guessing 10ms is what worked for you when testing with the
> > > physical hardware? If it's working fine, I don't think it needs to be
> > > changed.  
> > 
> > Yes, the delay was found empirically and indeed we could make this more
> > robust if we retried on -EAGAIN.  I'd be in favor of doing that as a
> > follow-up.  Thanks,
> 
> Oh, some further context, vfio_pci_device_reset() asserts the return is
> zero, which IIRC, is why I accepted the heuristic delay rather than
> expand the scope with a new reset callback within the framework.

Let's fix vfio_pci_device_reset() to retry on -EAGAIN. Josh can you apply
something like this on top in v6?

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index f50d450d3e94..25cac663de1d 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -533,14 +533,7 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
         * reinitializes the queue registers but leaves the engine wedged
         * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
         * is required.
-        *
-        * Delay before requesting reset so PCIe/IOMMU/AER error handling
-        * triggered by the just-observed DMA fault can release the device
-        * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
-        * heuristic.  The current memcpy still fails with -ETIMEDOUT;
-        * recovery only ensures the next memcpy starts from a usable state.
         */
-       usleep(10000);
        igb_error_reset_and_reinit(device);

        return -ETIMEDOUT;
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2e67afc0d580..27bdf561925f 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -41,6 +41,7 @@ struct vfio_pci_device {
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);

+int __vfio_pci_device_reset(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);

 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 7b8394d0ac50..45704a2c9485 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -221,9 +221,23 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
                       write ? "write to" : "read from", config);
 }

+int __vfio_pci_device_reset(struct vfio_pci_device *device)
+{
+       if (ioctl(device->fd, VFIO_DEVICE_RESET))
+               return -errno;
+
+       return 0;
+}
+
 void vfio_pci_device_reset(struct vfio_pci_device *device)
 {
-       ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
+       int r;
+
+       do {
+               r = __vfio_pci_device_reset(device);
+       } while (r == -EAGAIN);
+
+       VFIO_ASSERT_EQ(r, 0, "ioctl(device->fd, VFIO_DEVICE_RESET) failed\n");
 }

 static unsigned int vfio_pci_get_group_from_dev(const char *bdf)

