Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588236F90D
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621367; cv=none; b=cKAWf19QgRq5YBvVv79f6ja3xWowvHuuq6ieasDTdCV5wcI72RjK9RHdmJCVl4AibE+A51ZEXpqZD6gcfGQSUpy1JLHmd3P141Idb54c271mrxbc2Q9DOo9U6zfyuLJInaX17Hjzc0TrTm/SBcfWXxepqYn4Uh8PL3ekBtx+4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621367; c=relaxed/simple;
	bh=PVEZ6lDsqfrkheYFwj2coqzGfYHxktZ0uXkER3yjEWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG50KcMaMw3mwJ09xFdCFH72Q++3jiGRn9/qm3cIq11dwCXTDX+yA+2Wl3jkMdtza4gsgRkp0jF/WgOl7RQS8SI2rAUUJFiSKfxAaz5AtDPnuXcRFUOXUm/2bv0mgvcn+aLgwnV9YLCVYM88ZWrAcGyp/wuRpW3hKtIqFbL31vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2TqEeYx; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2TqEeYx"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1336742714fso103c88.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778621366; x=1779226166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9as17r1aSDL1/IjkeK3rxFdLzhg/o+IZ2HDHZMfPp0s=;
        b=O2TqEeYxQ++uEzCuAjSrp9S4rZXfnp3qCMLVHPDxioCo48GoTxdEgkrstQufcqRGl2
         5ugnERzU6ErV4dQjNB2XQbZVFCBoI62CIUqgsheQA3GuF8LNEuQIQHObJ48N1rW5bxBn
         p1VUyj9oN/kW8j7kutMQ2q/PtDM1bSRSErzS5XBXPs/J3JALkHzf7dFwE59NTSfuZQZ8
         BvDqmSJMaPdZ7+EqH+kSF0Q/I5Yuuc3X8tw4JhqU9w5umF1bPiJC8sq+Yxs10c8zEm/j
         2HzL7yJ/A4DOrx2RS3k1dt1nwUg6KaO9RE10N46u7bVIHJmPnql+qBD8hqmRPrOBP8ZW
         WHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621366; x=1779226166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9as17r1aSDL1/IjkeK3rxFdLzhg/o+IZ2HDHZMfPp0s=;
        b=VVA8kvyWXMKdLmnobkACn8yXjtRb8vYkI33k78xxdsFxSDE96KBiyyny5KkyFLBUVe
         yp1UGuJpek14frNxOQADEqgTnR4BkacAuOPyuRWm4mSpwYrXWxqpKt2/V4zvPq39SODI
         i7VM4tGzQyWo1Abqcvhof6WPL3OdMhwvnTugj5sAzDxMe0mwiluGwnkitepHmdI0Nra6
         DhDOpywDETzQkC2Fz0J9W0UuyXOuckDPyCSj0It69mxFTziq/PWPuLoFTVxCpEbmzMHe
         nZJQ+KBXxiOyiVUVXnjbl7hFndd+pco1Rp5pWESZHYQLixmOXzXbRf729eaQ9rBCg4/D
         p/DA==
X-Gm-Message-State: AOJu0Yw860Nt/CRlxVuqrE3IIcPzArnOeQtt4D63Xn9DsCMmZf3AmXC8
	HjjSLB1+gPc9//Bi1UctZxYxe4ntM91TvQyCr+TmcWv1/sZpxibcV3bM54FkHkkuwg==
X-Gm-Gg: Acq92OEeIdZdZvcYlVM319UE2hQ83mrJUN/iWdfHrHDDdIMvnzy49/lgwu1fOPB7xv+
	CGYZCJq0HOr+n1q9lWx8EyRqEP+n7fIsYhFo0cGeGdSFPmxzq58sH4iGZYlC+086PlavV8gjtPo
	fc8SKwZybQKyNRxJ2N+CWmKT+S5ghdH0MgSxYafHbN/X3lDt9e35Otrs76H8nojBWfzlJ2oQj53
	qX2FvmFWwbha2uPw9zgfeEiQgEnN1HvlPZrcXFAyI4ER9ISUdQvEWjr2BNU5IrU9n1A8haiYQd4
	ZGNmiDcC41OpJRodfqR8tQPBDpD2e8JcD2d7pe1lRJTQ9bn4/EylYIyNHH+IIWE8m6dpquk2RMF
	DcBvRKCn+kzA4YGxN9a2s7s0mrzGrSvYCMFBsijHEAGT7CimeV/ZccxGFB9BUXZGKaA2twIknX0
	4iVpJumOpSjj5jhvU9ofmHCC8P4+hJYT7Lteme/XuJdFyI5XWxTb+ha7GbLSlESAP6FWbg/MJE
X-Received: by 2002:a05:7022:699a:b0:132:1e01:2d6d with SMTP id a92af1059eb24-13401ba684emr108868c88.2.1778621364956;
        Tue, 12 May 2026 14:29:24 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm23087120c88.7.2026.05.12.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:29:24 -0700 (PDT)
Date: Tue, 12 May 2026 14:29:19 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, 
	lukas@wunner.de, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20260512211412.GA2819150.vipinsh@google.com>
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-3-vipinsh@google.com>
 <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>

On Tue, May 12, 2026 at 01:59:51PM -0700, David Matlack wrote:
> On Mon, May 11, 2026 at 4:48 PM Vipin Sharma <vipinsh@google.com> wrote:
> 
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index c12d614fc6c4..019de053f116 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
> >
> >  config VFIO_PCI_LIVEUPDATE
> >         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > -       depends on PCI_LIVEUPDATE
> > +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
> >         help
> >           Support for preserving devices bound to vfio-pci across a Live
> >           Update. This option should only be enabled by developers working on
> >           implementing this support. Once enough support has landed in the
> >           kernel, this option will no longer be marked EXPERIMENTAL.
> >
> > +         Enabling this will disable support for VFIO PCI DMA buffer.
> > +
> >           If you don't know what to do here, say N.
> >
> >  endif
> > @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
> >           To enable s390x KVM vfio-pci extensions, say Y.
> >
> >  config VFIO_PCI_DMABUF
> > -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> > +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER && !VFIO_PCI_LIVEUPDATE
> 
> Why does enabling VFIO_PCI_LIVEUPDATE require disabling
> VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
> but what specific problem does this solve or simplify?

I should have provided more details there.

When device is getting reset in vfio_pci_liveupdate_freeze(), we are
zapping userspace mapped bars, we also need to use
vfio_pci_dma_buf_move() to revoke dma buffer access or
vfio_pci_dma_buf_cleanup() combination. Cleanup takes the memory lock
which freeze already takes, and there are some refcounts which are
managed in both of these APIs. This was causing complexities with code
flow based on result of pci_load_saved_state(). All this was adding more
refactoring than I wanted in the series.

I decided to just drop the change and disable the support of DMA Buffer for
now to keep number of patches less in the series. This will go away once
we remove reset condition in freeze.
