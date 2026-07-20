Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7247798E
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570911; cv=none; b=ME7kKLMpKUrZ93MeAvFKA63BVDJvLK97/SW/uPewsw1lNo/1CoCaoB5LPsYzR+stHE9I/aK8tkzj4k4uAgj1aWFe7ccb1nUAdtG5VV3d9Peusjz+/dkCxZ+eFIlLT/gfbFOiYWZpaxDrepVDp4zxggFrhEUtDr79KajQqsmH830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570911; c=relaxed/simple;
	bh=BKTS748h10YeslajUmtgUZCdE2Ez8AKFfhO8iHDAxM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwPEKZnuqQU3N7pGzuFeUc8etLFtuxAzeCr8yQgVSm1JIIzvjvlBflSB69X0yt3NVi2uAZqxry5kiFo/8xZIsFDjjRbtIWoNfyX+LMWEqLWb3mJ4EVq2S3EbkACnr9dPLM4y/e32YutebMyrAVde6LiygKbg7xqxkKLBVYau9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKzT2Tdx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKzT2Tdx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso404395ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784570907; x=1785175707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=syF1vyyr65A59ORY+VELdLPaqren/tK44EXfZ8Gwpow=;
        b=FKzT2TdxpAYiUGuo1IXPMwc/96ffytZC+VudzJLUSmvc1ePV3G0gfgcQuGmoBLxIxp
         QAAN4Jc6tDnArd056h6huSJLTyfz5bgZD28YkNJoTVaVF0u+SdcmZFo8DcMXfkiipYiO
         2XYUXqRjcuED3mMEmXDjbLuMQJ3Zp84e2KvAgAfRZIpWukldqZLR6xDgmlGbNg98EIBK
         Oe54O0/CzSjJYp2Cz/TFhdQG/lp9iJuVuJKuSc0dtjw99Pg9cpuwI0iwLeFmjajZ5Rdw
         u79XdbAc1EJfMOjIW9MKS4INK/zOkkGXYuaw9p0t9Zx1o/NhTtZRsSoz+Pp3jGyMUGmC
         vx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570907; x=1785175707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=syF1vyyr65A59ORY+VELdLPaqren/tK44EXfZ8Gwpow=;
        b=BgelevGw92tFYmwC02Ed2sSXEDeegYhnwNjeitMDEAN/0oJE3bxcojnSGYhj2Gy4Gx
         zhGC05xg8CIX+iSqANz8uH/g6K3XL0oizN+nffx9cte5RoA8ALyktFDPYMy+wQNOx34y
         irGCLiFLJHqTGP50ZhNx2bwMPOux93QaybpTNkiKk/Vco5/JGL+g4AvLiUB8cr4kuIM+
         328uKhrD3VqZej6ZZVSws5c1YPX3tdUDunH+mXH1gnIrdfjgsXC8faZvyaBs9I4XcKhM
         XYB7y67g1bHCVLJDvbwfIVYCQCSij2NEt1GeqYf72rMZxwz/kxnDjbcy5Gg+lES/25gE
         CiNQ==
X-Gm-Message-State: AOJu0YwSPcWWDyjQQN3u8ZvoqqGG59tavKe/Bqi9zb0tfCPbK090vjWY
	02OKqmzgrqwaHNN12qTQIQ8PI8xet1rBHb0Isel2jkO4ks0/P8yvK31ZDmOVtM08Dw==
X-Gm-Gg: AR+sD13IVZN7FLRRodecdan+dhh7kYbrFYF3l5a4KAgz5JGtun0PD0mCfAcN+toKmS7
	eJwqBPYg9ktUzST9jINLk6C2NGwLBIhpYVJilhy1h8c5Kz8SEcDWJtnKGuLUJs51LHDhCB6QG65
	m7fqBs68VbVHY0dLggDsjEszRymUCOTVYTt+EXntQhSst6TGWTNz/PUiM8UHQLadnyifsR8xJ5K
	vtVgoTBQaaWG1+kOgQt8JCdGOp5Jpk8LO95lNuaiyvmlgZnGHl9KSw/NmEo5b2MlIddYy05pAxY
	piUOD2YQoy0rKmmMiiVuciW6bYPyMs+ulbcU/sIGdnxY16zwX6IDEjqBjXUhuyZLqaAUI6VsUoY
	ULvUjGl9NeGF6VCY+83bTVpY2pyQ6PT4DOFVWgHusQnKLl/ATz4jHn9RPOMN1megTo8BnD6CY9q
	MQ1jRv7WmypvRC/usbJ0qREQpgq4Hw6jd7I2/G
X-Received: by 2002:a17:902:e5c9:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2cf7b6c4a23mr1916405ad.21.1784570906870;
        Mon, 20 Jul 2026 11:08:26 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b879sm6016416b3a.7.2026.07.20.11.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:08:26 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:08:21 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 06/20] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20260720175721.GB1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-7-vipinsh@google.com>
 <20260714153628.CAADD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714153628.CAADD1F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:36:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Lockless checks of `vfio_pci_dev_is_frozen()` in IOCTL and read/write handlers allow userspace to bypass the freeze state, breaking kexec handoff guarantees.
> - [Medium] `vdev->liveupdate_frozen` is never cleared and `unfreeze` is unimplemented, permanently bricking the VFIO device if a kexec aborts.
> --
> 
> --- Patch [6]: [PATCH v5 06/20] vfio/pci: Preserve vfio-pci device files across Live Update ---
> commit 03e42ce3ade0f06aa286a1a8cacc4d3f5d2537c0
> Author: Vipin Sharma <vipinsh@google.com>
> vfio/pci: Preserve vfio-pci device files across Live Update
> 
> This commit implements the Live Update file handler callbacks to preserve a
> vfio-pci device across a Live Update. It serializes device state into
> vfio_pci_core_device_ser and resets the device during the freeze phase.
> 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index f31e59e5badb4..c312b0eaf7d00 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> [ ... ]
> > @@ -1513,6 +1516,9 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
> >  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> >  	void __user *uarg = (void __user *)arg;
> >  
> > +	if (vfio_pci_dev_is_frozen(vdev))
> > +		return -EIO;
> > +
> 
> [Severity: High]
> Can a userspace thread race with the freeze operation here?
> 
> If a thread locklessly evaluates vfio_pci_dev_is_frozen() as false and then
> blocks waiting for vdev->igate or vdev->memory_lock, couldn't
> vfio_pci_liveupdate_freeze() concurrently acquire those locks, freeze the
> device, set liveupdate_frozen to true, and release the locks?
> 
> The ioctl thread would then wake up, acquire the lock, and modify the frozen
> device's state.
> 

Userspace VM and hypervisor is expected to be stopped before initiating
Live Update kexec. So, we should not see this issue. However, from
correctness point of view this is a valid concern.

Considering, this is a temporary code where device is reset during
kexec freeze, I am more inclined to leave it as it is. Future versions
will add support for not freezing the device and let it continue DMA, we
will remove the restrictions added here.

> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > index 803528c9f1b27..e6eb7f6b53d7f 100644
> > --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> [ ... ]
> > @@ -6,28 +6,221 @@
> > +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> > +{
> [ ... ]
> > +	/*
> > +	 * Userspace cannot use the FD correctly now irrespective of liveupdate
> > +	 * freeze failing or succeeding. They will have to reinitialize the VFIO
> > +	 * device to continue using it as reset might have loaded default PCI
> > +	 * state. Disable ioctl, read, write and mmap access to the device.
> > +	 */
> > +	smp_store_release(&vdev->liveupdate_frozen, true);
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> Does this permanently brick the VFIO device if a kexec aborts?
> 
> The liveupdate_frozen flag is set to true here, but it looks like there is
> no corresponding clear on device close/open or kexec abort.
> 
> Because the unfreeze operation callback in vfio_pci_liveupdate_file_ops is
> unimplemented, the flag would remain set. Userspace attempting to recover
> by closing and reopening the FD would continue to receive -EIO until the
> driver is unbound.

Yes, this should be fixed. We should reset the state in unfreeze and
when device FD is closed/opened. I will add the fix in next version.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=6
