Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869218A6CF
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216903; cv=none; b=DD46XQQajUMav418UVxxtnYmGJVIi4AKdPAjUC+2ttmzDh3w5yhdFNQ4SUrc01+dKQxgBRXtC1WIPzk2Ubh3K1c5n0yu8WH0YtOf/yxXTIc82l56VU20HnPAoJSu2AkmSFgZ7RmTe7MaTbNz02rPhIqXs1Jr/VQ/OniuJ3mFl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216903; c=relaxed/simple;
	bh=cKul/h3IPZbb9VFh4rdMOhK1Ffwwx65anMjRAzvkQPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2QE+SzRaf0DNPtpp+UQdj/qDfNfC15hOt8FgEKoHCd2FyB4Pyf0S2lp0l6ArwSMMYug4823nqRDvR95zX7eSVro/96sNV5h5ZtB8oqhiNLsJ1Qi10z3+5EM2VuaBnO5IX9uAJFoYGlrg9v1guUokNwjcIddgeKGkHzlMrAJKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUsSB54v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUsSB54v"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso75315ad.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785216902; x=1785821702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSd0Snni0h0/tE0vaFb4D1at9rHpTmqJbpcAV8DTvqQ=;
        b=hUsSB54vDmVzqOA0mnOa/npPR5ww6YDRYBtrOXFO0TPvHnrcTW8h0/JKanQujsNwGZ
         h5tyqxaMawyQLgUiGBtv7Rs7yGU+jG3hZFPVu8TBxkuwaHRnwupVKn3y42eQFSuE9jP0
         9cEbSMWUj0WqmEgNZv+qzsIeshz8R1X1vVGBQUIBxqBCVn8zKt9nu/vHFq8snnbg/IKK
         OGlAkekcm3B9d2ogyyG2bGXU1MbDjqX56h4K33zB0MO7GtlApL3VghgUXO7PMjw1Jmkf
         TAMq+ssNbo1Wx0ScMrEGH2xpIEfSbDQChkpjHMlVyj1GK/cgulVCIqmZVHf3gtggCrHa
         5aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785216902; x=1785821702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NSd0Snni0h0/tE0vaFb4D1at9rHpTmqJbpcAV8DTvqQ=;
        b=SvFt/fE6F5NS1uUJset3zCKS+megGCja+kEVscMZUXYmTNbwylz+HRZFMXKkqMgizY
         bJVU03G5vf29ZXnG7r5ro7LbTgCchB7L4Az70RikSOxeaYzgTSWuwduhQFY+0Wo5/2RR
         g4Wc4Ipo2TIOXgAHTNp7i5Z/X+85Lih96ETcw6L0z6Yavnt9WcpqIMAnkoI7G9eLDbC+
         Kk2nvAVrpUerVUeo/n+CbWeeU9bR9rPAXMqO355mLdQKRVuBS9vyD1BL5EtqAQtIjOBK
         JwUfR5Mq4bBManYC+RmIBAqWNVyoev7mCmK1nuudNQF/gV/teWcCeS2IFxgxpgPf5E6q
         KOQg==
X-Forwarded-Encrypted: i=1; AHgh+RrAZAMIqRZr8eN0hGkCkye34E7alIeOF8E963qsxXlazNXXlBPDp25FZsl+bVdO/Rxc/Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4hbUJNAU7W8d9kBn+uh5uF/jYMHnWjChHcudaLuu9UHpv3wC
	72UR6DTg2CK2CSDC7EURa9uQ6mw/gEqK8JOLfPSNPKopp77RwWoMEdfvi0cEwBXn2A==
X-Gm-Gg: AR+sD12K1lUmvkdyNYb5qZm2ifbG0/NYJUctmRgQzZurIjJj6xUqqe+cDIro8Pwp001
	K5OP+MVUvsOaUktpHC+GeHkwLznrmONEXItmes0UJWeqlostxXKfE+mtwHv0WJNzOEGZxUsZY5R
	EzTYIxQZ5qTgg1JPvLvtqYXAesSwvmwrfNb2+VUdRpBAJ5P1YfSLF3KfG6h3+2Q8sJKzFSauutb
	2P1OHhh6BgCnjS1F2qNvPyz6uW8yiP4mMmG+jdKvhD/t+SBrqs90GAc2HVRc8SEidIDTubizcXL
	18aXRRCw9vnpXn1jX91BHiVUbFWkeCGJ2C4MqnlhVDItP47lMhDOxzfaQktHwg2IeGqAWtmHvCU
	LasiK3urGfYJsANrDcHbER8b/JVZE2lHFOGoQUdExLjjl6/q+FdmaUh6TtRSXGRuakya2gTLsF9
	XPDVVAbHPMHnJ5/TGHD2+l527jhnEQ2m6SYE7cqdvDvZMPFtEH1A==
X-Received: by 2002:a17:902:f1d3:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2cfdb75acb4mr15516765ad.12.1785216900834;
        Mon, 27 Jul 2026 22:35:00 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08ae3079sm3822540a91.3.2026.07.27.22.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:34:59 -0700 (PDT)
Date: Mon, 27 Jul 2026 22:34:54 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, 
	parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
Message-ID: <20260728052011.GA736369.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
 <c3440ed3-0fc2-44e5-a05a-922344eb34d1@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3440ed3-0fc2-44e5-a05a-922344eb34d1@linux.dev>

On Sun, Jul 26, 2026 at 05:40:54PM -0700, Zhu Yanjun wrote:
> 
> 在 2026/7/14 8:15, Vipin Sharma 写道:
> > Add a selftest to exercise preserving a vfio-pci device across a Live
> > Update. For now the test is extremely simple and just verifies that the
> > device file can be preserved and retrieved. In the future this test will
> > be extended to verify more parts about device preservation as they are
> > implemented.
> > 
> > This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
> > manually along with a kexec.
> > 
> > To run this test manually:
> > 
> >   $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
> >   $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0
> # ls /dev
> autofs           disk       iommu         mem     rtc0      tty10 tty21 
> tty32  tty43  tty54  tty8    ttyS18  ttyS29   uinput  vcs6   vcsu4       
> virtio-ports
> block            dma_heap   kmsg          mqueue  sg0       tty11 tty22 
> tty33  tty44  tty55  tty9    ttyS19  ttyS3    urandom vcsa   vcsu5       
> vport2p1
> bsg              dri        kvm           net     shm       tty12 tty23 
> tty34  tty45  tty56  ttyS0   ttyS2   ttyS30   usbmon0 vcsa1  vcsu6       
> vsock
> btrfs-control    fd         liveupdate    null    snapshot  tty13 tty24 
> tty35  tty46  tty57  ttyS1   ttyS20  ttyS31   usbmon1 vcsa2  vda         
> watchdog
> bus              full       log           nvram   snd       tty14 tty25 
> tty36  tty47  tty58  ttyS10  ttyS21  ttyS4    usbmon2 vcsa3  vda1       
>  watchdog0
> cdrom            fuse       loop-control  port    sr0       tty15 tty26 
> tty37  tty48  tty59  ttyS11  ttyS22  ttyS5    userfaultfd vcsa4  vda2       
>  zero
> char             hidraw0    lp0           ppp     stderr    tty16 tty27 
> tty38  tty49  tty6   ttyS12  ttyS23  ttyS6    vcs vcsa5  vda3         zram0
> console          hpet       lp1           ptmx    stdin     tty17 tty28 
> tty39  tty5   tty60  ttyS13  ttyS24  ttyS7    vcs1  vcsa6  vfio
> core             hugepages  lp2           pts     stdout    tty18 tty29 
> tty4   tty50  tty61  ttyS14  ttyS25  ttyS8    vcs2  vcsu   vga_arbiter
> cpu              hwrng      lp3           random  tty       tty19 tty3 
>  tty40  tty51  tty62  ttyS15  ttyS26  ttyS9    vcs3  vcsu1  vhci
> cpu_dma_latency  i2c-0      mapper        rfkill  tty0      tty2  tty30 
> tty41  tty52  tty63  ttyS16  ttyS27  udmabuf  vcs4  vcsu2  vhost-net
> cuse             input      mcelog        rtc     tty1      tty20 tty31 
> tty42  tty53  tty7   ttyS17  ttyS28  uhid     vcs5  vcsu3  vhost-vsock
> 
> 
> # tools/testing/selftests/vfio/scripts/setup.sh 0000:00:08.0
> 
> + echo "vfio-pci" > /sys/bus/pci/devices/0000:00:08.0/driver_override
> + echo "0000:00:08.0" > /sys/bus/pci/drivers/vfio-pci/bind
> tools/testing/selftests/vfio/scripts/lib.sh: line 9: echo: write error:
> Invalid argument    <--- the error is here.
> 
> 
> # lspci -vvv -s 0000:00:08.0
> 
> 00:08.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
>         Subsystem: Red Hat, Inc. QEMU Virtual Machine
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Region 0: Memory at fea1f000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at c000 [size=256]
> 
> Hi, Vipin
> 
> I worked with QEMU PCI Test Device. But the following error occur.
> 
> "tools/testing/selftests/vfio/scripts/lib.sh: line 9: echo: write error:
> Invalid argument"
> 
> Is this a known problem?
> 

Can you please check if you have passed iommu device in your QEMU
command? This is what I pass to my QEMU command

 -device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on

Also, add the following to your guest kernel commandline

 intel_iommu=on

This should fix the issue you are seeing.

Alternatively, you can also enable noiommu mode in VFIO by executing:

  echo Y > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode 

This should allow device to be bound to VFIO.

If none of the above approach works can you please share your QEMU
command and your guest VM /proc/cmdline.

Thanks
Vipin
