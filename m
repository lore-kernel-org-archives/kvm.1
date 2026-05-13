Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741253A75AE
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712183; cv=none; b=tCSRgO4wi+DiLO2HhBxh3L2ZMyh8u8Eo94rfDD8mHjo3QnYon+XZeUoch1g1o+Hk4R28OWsuTFysqWVyeJVLcuEvtD82/uVULY7XegL3zj3PUixMN2E5oMFzovX/MFaPtV2qvaiMZ80LXjgLfujstrw72WjmBgMqgmGnwaJDlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712183; c=relaxed/simple;
	bh=CbvHdVmtLmzyOYmag/VF+OxC3FrvmW+yoxtC2Fz6tHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0rN3mDfykBkd1KUAzOX7NLLIUFC+uByOOalZBojVQvUvuuX+cYZK4Hee0LnDA7edQqRx+Mm4ZjHgWGG1yjbg5BYDgdqRQYgOxEYdAPKvCfM87244Doahg6+LvSQAZ4Dm4W7JZL6ur+0JgT6YINEc2gX5Ptbx6ALGp/J0BFsmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Use3xgIz; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Use3xgIz"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c8d0945b3so1704c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778712182; x=1779316982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tnJie4MGAhTdVxrHjidSSamJhN69/aqRYywXACZbNwg=;
        b=Use3xgIz1P1CfZlxC6+U66ye5caojrgyweuvT7Y7eF45D7beXv8OhMminEaBm0+ur2
         BGzf4QZpmDKevhb84zyDqGQlpK+7Ijagi3TJaW+u9aBQEN0pSPjy6FoYTwtSksVxMDGv
         rECIjTMtdAK5dAnYhUlf15ScqHW0YYRRQhuYKPXgS3MZrivQsYGLBbT/4lgCAEtxZi/2
         QCdtvvYvLL8+s1tHLm/AAJJKsEOzwxJu3P6XV5rZgRdDCbvpSXXCbKebSc+0BVw9uU7V
         7WV4FIw7DsUc8qXWT7FJ3Tg3yGvu9fgiLOnCqBynpzlXP/o4TooGcBzEfzh1X8ogth2x
         lDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712182; x=1779316982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnJie4MGAhTdVxrHjidSSamJhN69/aqRYywXACZbNwg=;
        b=SkW9WWXTDR+6015yyyu4mAxzkBUB/6bz5P7Gyt7c9ehkrH7sNNlJsR8R/IkrgByh58
         sIFrJQwFKu91Xyc7yBDgQEFrYkNp/M8Y4OtBiyWqfzTWmwX9ErJkbCpGj3VEOVG2UCiC
         uRBh5zWoHNcG7ho+a0E1q+tKR2oeAUPikIAACKCwXSfNoapAdRpXOp/crwGo5WsZzvGw
         6NI0X90vlNeYarASCF2MVlwC/gWiq204icUzqcOyGIVU2iS9lzCMIOScP8OME9TJjUgS
         1E4Ifrux3c+kXvLwPwM7sjB5hbZXv+Y81+FRCnjwcjAVXcAg55VYMYLXdY8blQOsl27Z
         bEVw==
X-Forwarded-Encrypted: i=1; AFNElJ+5IjmlLlNlAlJBq9YLASOY7o+LhYu8JAJsnrJK8a/nl7hhNz1DAaa541FjK0nD1vXK0tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87FPo7GrodXfz3K+MMHgc7liHU4n17rE9Gnjpb+O7SfgfIWT3
	N4Do8zhfDIL14/AUFQ7J4gu9yOca64fJmnNdZltFq0YXLLwblt8okIirYEFNWlJmwg==
X-Gm-Gg: Acq92OFpGLQ595/s+PWzJCEefUOAE5+TjVa70y1zqg64u7QiNXrnnGPuemiQ8HpicMU
	sYJKRefUxgnX9Oti0s+LSLHhAQRb81roSwIsdRYCEx6xrLcmTKi/teczEMTfB5fzrUjQRpNa4ey
	RvO6j6heRDlqdc3OIo4Uor7Bww34P/vXbbprRuCfNoiPqZWZo2OfLEPxlHBwebR2B/B+pNns16x
	kjrwt+2hO0jfD8vhYNCuVdoj3Q6CS/DKn5qeeTh0WT3Oz3/BsE3wzVUgcmHrHkg6t/haLYmqv97
	GZ2QrY7VvRHLUqwX1/cWCWlcVgmcsZfKmt3ilSujOmdKSAYbEqcfnL7MafkKmklXWq5gPF36GCc
	0MJhSbmC4/pvR31eYtcRT6FNesHhPKxKq4kAncKdJfDKL5KnmrvbQrEkgdISMR1S0gTpx+7cwVy
	B7Ru3BLyHut4yLLlLnL2Y9PjAFurhKKAG/BCng32PfrRlNCP5saqVyIPaSYi0/G416VSX6Yw==
X-Received: by 2002:a05:7022:128b:b0:12b:ff98:1ed9 with SMTP id a92af1059eb24-134cb8274dfmr82086c88.12.1778712180853;
        Wed, 13 May 2026 15:43:00 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e3c0sm939009eec.3.2026.05.13.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:43:00 -0700 (PDT)
Date: Wed, 13 May 2026 22:42:56 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	skhan@linuxfoundation.org, vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <agT9bYpXskVwW0E_@google.com>
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-3-vipinsh@google.com>
 <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
 <20260512211412.GA2819150.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512211412.GA2819150.vipinsh@google.com>

On Tue, May 12, 2026 at 02:29:19PM -0700, Vipin Sharma wrote:
>On Tue, May 12, 2026 at 01:59:51PM -0700, David Matlack wrote:
>> On Mon, May 11, 2026 at 4:48 PM Vipin Sharma <vipinsh@google.com> wrote:
>>
>> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>> > index c12d614fc6c4..019de053f116 100644
>> > --- a/drivers/vfio/pci/Kconfig
>> > +++ b/drivers/vfio/pci/Kconfig
>> > @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
>> >
>> >  config VFIO_PCI_LIVEUPDATE
>> >         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
>> > -       depends on PCI_LIVEUPDATE
>> > +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
>> >         help
>> >           Support for preserving devices bound to vfio-pci across a Live
>> >           Update. This option should only be enabled by developers working on
>> >           implementing this support. Once enough support has landed in the
>> >           kernel, this option will no longer be marked EXPERIMENTAL.
>> >
>> > +         Enabling this will disable support for VFIO PCI DMA buffer.
>> > +
>> >           If you don't know what to do here, say N.
>> >
>> >  endif
>> > @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
>> >           To enable s390x KVM vfio-pci extensions, say Y.
>> >
>> >  config VFIO_PCI_DMABUF
>> > -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
>> > +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER && !VFIO_PCI_LIVEUPDATE
>>
>> Why does enabling VFIO_PCI_LIVEUPDATE require disabling
>> VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
>> but what specific problem does this solve or simplify?
>
>I should have provided more details there.
>
>When device is getting reset in vfio_pci_liveupdate_freeze(), we are
>zapping userspace mapped bars, we also need to use
>vfio_pci_dma_buf_move() to revoke dma buffer access or
>vfio_pci_dma_buf_cleanup() combination. Cleanup takes the memory lock
>which freeze already takes, and there are some refcounts which are
>managed in both of these APIs. This was causing complexities with code
>flow based on result of pci_load_saved_state(). All this was adding more
>refactoring than I wanted in the series.

Maybe we can return -EOPNOTSUPP if any dmabufs for this vfio cdev are
exported during preserve?
>
>I decided to just drop the change and disable the support of DMA Buffer for
>now to keep number of patches less in the series. This will go away once
>we remove reset condition in freeze.
