Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF848A2CE
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122255; cv=none; b=iRGXBXt2praSwjJJd5CvYxMbLcooIaPiBiwr/cgp6bWGzw2qdMz3XF5zTtvg041RsApoLsczvpsT41m/qh/0XC2zBPxlWEs5v9SGDHEqLkpPPPncgNK8DMOBUvmYZRFk+eslrn4mRp0lownhb7H06ot65CUobTEXqbQpXJNXv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122255; c=relaxed/simple;
	bh=opLnOv8rcGGpMzk9NYT62osXVn/LxJ7Ob8lhc0zDKrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH3xfA/L9ZKqLFmYG22u97PnmCrLh/c9V0LFg7A/5GZBAf0KV2X4QPi9CHQogrj70WqcvBbKq7Ukp7QnbGvQmH7CmRM6fVLiYODBiZC1h9VIXohE2aRYsDt1buBfO7XJfkF9QUN900Q4bR3zZvrwbf0uLG1Lc7gwoQ2O9s5Lov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2Q8oU6l; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2Q8oU6l"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b46da8c48eso5065ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779122254; x=1779727054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pfGbgcaleoCc2Ifk0qdh18kJSuW5oqOcEuMwE4BYsU=;
        b=P2Q8oU6lQk05pqegx9wz2Ckm4pDXPQZea1FepjyKI/zkJrjl11E+xDSNSU3l6Hqtdc
         D1b9XotvaV/jHWJ40QukJxeJjr0ABXujWSFUNWcdOzVYen/UIIHT3n+YnpGy1FzvRfVe
         oDtCSXbsE7guueyK9OwwVN0vod9he4MfeDgN+YdZjXoxKj/EcGl1UcRQSBR+b9KKKeJG
         XoaUBpcyP2yaGieaQ3WX+yXa5Ucjh54IlLTwgQaphG4uQaZMq/QtSwKgnC4AtUcWt2WC
         Iky9yA+EOh7/FVX/JNOxUxkl545i55IxKnv2pG7wYCoEpuuhy68cNUnSHi6021Aqa1nm
         y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122254; x=1779727054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pfGbgcaleoCc2Ifk0qdh18kJSuW5oqOcEuMwE4BYsU=;
        b=Uox6fWHzheTpJHGd3ZiClQVbNhCLxUZTFpjsqogzD6ndZTzAkKQN6ngndlSYwXNg/I
         eVqV+CvtlpZr8mzN64/EfzdktlpwuoATQln/yd4LqH9DlazRMQudedGcJbLt5dN4AJPo
         5p7r7wKXpg8AWNS/loFOKvQ6hrMUWnFChMeGWEWL+Qrhe48ZE1LKLK+X/BQmGLk8GB6I
         Wbp0y/ol0Vc+XqOA7spEvAlb2Ea9RR3d5StjeLCPywtEwoVP3tWeOsun3Xx/e4DF/5Eh
         0XFp1TRTJcquOFCgPst28N9Qym97iTq54FrRvNgqVRsYq16m6an0FqPGxGtGWqtx0XJE
         ZInA==
X-Forwarded-Encrypted: i=1; AFNElJ/QcZ22u3R1D+JPUMKoGmKPzWasQLdlp2qZcSC6v4KZZuRpPQymy8d97Vcrq+c6b4O6lOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+RvqTx9PLAOok40FlYIp3gI1f8/sNr+NKj8m+crUQ7g15vhJp
	Bf+9jrbMff0GPP102poISbr5glsRgPMlICCAjh619gp+H3nocsKQiJYkmfDTJAkciA==
X-Gm-Gg: Acq92OG7poTAjjwVyxVrQhLIlO5nYDaEsxbVbbQEmKQY5/tKySMsP4+kNVpVExpJm9M
	qv/VUrKz/SOYaeF5CPQ1rox9eDM24oyNffzvNF3NjXA0OgaKerr2cWOZ1E61NZ4ybiUjU0oR8Nh
	kx+VjbuO0Tf/wXzdjZYJyMd2q3TCiNe1RTOcfT639dIlIMSiUBnZw/PhdMm32ne/qHLss/IPjUM
	TxGLzfot0t4RXZRl9ynVUh9BaVk6f+0XBLI9lsMOeIhLfvAOdYBSyp7V8E9x+N8id7qHRzo9KbA
	t6muPl7Z1MKk9ARo1orbx2bWB7cA6AB7h1XILQq4C4IJDqKUjeCnxB/jlA+vasw8U+H9yWj2zaK
	cWDo/GPAgOQRqTn338rUiDquKrh5JO92On2zFT8lie5mY+hmMqhEE2zcDt9+UQOEGXUj029Gfb2
	NYsOJ/iuNXfSqQqcJ4dWSvM5ZXbnmgXntGPSDycI24gxOLYjCf0HqHZEPa2C5Ra3u7jX1P4GI=
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr2960365ad.0.1779122253168;
        Mon, 18 May 2026 09:37:33 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121cd6sm14018626a12.30.2026.05.18.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:37:32 -0700 (PDT)
Date: Mon, 18 May 2026 09:37:28 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, 
	lukas@wunner.de, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, rananta@google.com, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20260518152420.GA3281683.vipinsh@google.com>
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-3-vipinsh@google.com>
 <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
 <20260512211412.GA2819150.vipinsh@google.com>
 <agT9bYpXskVwW0E_@google.com>
 <2vxzcxyy9fpd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzcxyy9fpd.fsf@kernel.org>

On Thu, May 14, 2026 at 05:24:46PM +0200, Pratyush Yadav wrote:
> On Wed, May 13 2026, Samiullah Khawaja wrote:
> 
> > On Tue, May 12, 2026 at 02:29:19PM -0700, Vipin Sharma wrote:
> >>On Tue, May 12, 2026 at 01:59:51PM -0700, David Matlack wrote:
> >>> On Mon, May 11, 2026 at 4:48 PM Vipin Sharma <vipinsh@google.com> wrote:
> >>>
> >>> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> >>> > index c12d614fc6c4..019de053f116 100644
> >>> > --- a/drivers/vfio/pci/Kconfig
> >>> > +++ b/drivers/vfio/pci/Kconfig
> >>> > @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
> >>> >
> >>> >  config VFIO_PCI_LIVEUPDATE
> >>> >         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> >>> > -       depends on PCI_LIVEUPDATE
> >>> > +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
> >>> >         help
> >>> >           Support for preserving devices bound to vfio-pci across a Live
> >>> >           Update. This option should only be enabled by developers working on
> >>> >           implementing this support. Once enough support has landed in the
> >>> >           kernel, this option will no longer be marked EXPERIMENTAL.
> >>> >
> >>> > +         Enabling this will disable support for VFIO PCI DMA buffer.
> >>> > +
> >>> >           If you don't know what to do here, say N.
> >>> >
> >>> >  endif
> >>> > @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
> >>> >           To enable s390x KVM vfio-pci extensions, say Y.
> >>> >
> >>> >  config VFIO_PCI_DMABUF
> >>> > -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> >>> > +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER && !VFIO_PCI_LIVEUPDATE
> >>>
> >>> Why does enabling VFIO_PCI_LIVEUPDATE require disabling
> >>> VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
> >>> but what specific problem does this solve or simplify?
> >>
> >>I should have provided more details there.
> >>
> >>When device is getting reset in vfio_pci_liveupdate_freeze(), we are
> >>zapping userspace mapped bars, we also need to use
> >>vfio_pci_dma_buf_move() to revoke dma buffer access or
> >>vfio_pci_dma_buf_cleanup() combination. Cleanup takes the memory lock
> >>which freeze already takes, and there are some refcounts which are
> >>managed in both of these APIs. This was causing complexities with code
> >>flow based on result of pci_load_saved_state(). All this was adding more
> >>refactoring than I wanted in the series.
> >
> > Maybe we can return -EOPNOTSUPP if any dmabufs for this vfio cdev are
> > exported during preserve?

Currently, no APIs are present to fetch if dmabufs are exported or not.
I will add one patch to this series to return EOPNOTSUPP and remove
condition from the config.

> 
> Whichever way you go with, a TODO/comment would be nice to have so
> someone (including future you) looking at this code knows why this
> restriction exists.
> 

I will add comment in the next version.
