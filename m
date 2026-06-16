Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355232E13B
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635920; cv=none; b=hRbKwPtEKQV2xf/mc1ivKI83shcxZcNXPwxN5wsOdnQvwIZAhlpHvQ50LeZFIgEcm4IBvWvMxKTHAj9WJ8DAmucb06mh9rG0dTJfdmdkOV1ETthD0e0w4YTlReSWl87kdUjwsxxfNDJ3B6hI/hH/5SVufqg5rWZ/TdThhe1Ho34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635920; c=relaxed/simple;
	bh=sZ7UNLwehwopPc6t3eGTeaf90dQl3G+H2ei/ClIX/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzSY5NMFf+9tQNLLFKQlfvSSlT0UbqpeP0lDNwcWcfunYGXYfutOjy42aeXRcdNgaFXUy0RgfeSAMHM5ufyfR54V7t6SI9Ezmt+kfS0cXlaOXo42gioA+A/4NTKwN3zpYnSfKghW1hHc5AsGwyWlyUV+DfKjErY38XKyGebjG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boKy3whj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boKy3whj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6a4eccab1so8745ad.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781635918; x=1782240718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvE0aCg+gv1l26GtSCjQQyNi/5Rf7OW5qgPEji4d+Bg=;
        b=boKy3whjYEJJm0rGPxoZsPFUXrYLfkE0KmCJKkJGtvZJWHAYiy9k3W7FxK9E35C+vv
         hnHOopHaPVWpMvT3JvtiIAaz97js7EBwzLbLdZJnxdhhTDubshQ/A0yd28nc7FViBqno
         W4ARWojYwqvib6My3+4Qon6aiOLWJd1HvcT87W6wgDn2An5yPZLt/7v10PAvQda79Fpc
         ySQy9XhVcZ+4HLhF2pka7k834a2GQUTRVpW7DiGQx2dUFNzVBtIOcFFua96S3nh0V+BJ
         +Ec/Zzgk1Gjm2C8VE+Ftn6lircTYtMvlkxqHzH1NHIHLI/kzqmWGJMNw9k9ZZu3OHU+Y
         5/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635918; x=1782240718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvE0aCg+gv1l26GtSCjQQyNi/5Rf7OW5qgPEji4d+Bg=;
        b=i/Ap5s7421VmquDvn/58tGh6U6de/Trk3aoyunS1EcZBZ5rYIdURwwsK7iOAuCamwc
         qb1k8xdMDbXLZ1ywn1XWWdXfWHtE7ixzlY2IdrwInvj+BvLneqGHciMOyXtLbmt3+Tc1
         i71S0e9qFJP+FWWLramLTJh0GqiXcxJAO8DVEyohf51I1w0KSfs/0E2kuSPmbJSqDDy0
         2uIEnXQcfsanKKP4g5B5aXG8iK/f7ypLOP5NXeQvD/BKrrSFsi+cHpEbkKy6q+Mye4ew
         evUHaA3gbLRSi6Boyr216P9sATQwW3xQpqo2eP+Rip9VZUnSOMZA7ocZbuqaoD/IeRjn
         uFXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R1leriRtAUQPPykMG7IWRE8J4QEcX/ZhUz4RT+Cpo9hd1nZxi6uqH7Y/G7aThPWPRRd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1l5TTOQb0cjwaAasQv3o395WpypkQ/Ikz6gJPWVT1528Rc8+
	HgA0QJVdwe1oKSrhbG5I/kgCmofbb9GR/QguI1nZrgXC9tgrSEDLmtSDVnguDVpUtA==
X-Gm-Gg: AfdE7clT7gu5vPdWsECjLaoSIaqmMS7kWQE9/oOli/7E5/aOn0HkI2FJR4GnXnKXi2L
	TJdFV7VPsLQe1lXxPH5wNMw2nNgxHRA3pvBFhWzwqYAHo11OEuAuynfLMPzeUX5yeG/mRv27UoF
	mgwy3GlqgoGRfzGVBVKhzKcGVV9pww1sOL1icL0kzJSG+ZBH5RZo9P0jlR6ZUQnA6D6niMZ0Y1D
	e9zR3HkGmzv9i/e15veP6vwvpof/XReAHL45Hcebk+yCx+Y3UvbOsAyAgJybuaGeSKaHIpNyoJF
	mUx7FL2pd99SGuP/r57FXuFDIusNCMl8R/U7BNA4Jiv+MZiFtwRSdJkUIM9UuDX51bGUX6qdQi1
	l5Mi9j9Lrr5kbx1n2gN0Cxn2asEcAkwttT6TTnOTyHVaA12w81j0vK5SMQSseOK7X7wRtevCoCd
	6ccPKcDmhgNKax9z0mBiy+bhSzRfcptpG+fC3Po4gnhrxahfW+PEpaDFXGEh1T
X-Received: by 2002:a17:903:2f84:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2c6bbc5d4eemr256505ad.19.1781635917134;
        Tue, 16 Jun 2026 11:51:57 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm13472996b3a.24.2026.06.16.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:51:56 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:51:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <ajGbRE3WWJxNxcrg@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>

On Tue, Jun 16, 2026 at 09:48:14AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Saturday, June 13, 2026 3:39 AM
> > 
> > On Wed, Jun 10, 2026 at 04:43:20PM +0100, Matt Evans wrote:
> > > @@ -1264,7 +1265,7 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> > >  	if (!vdev->reset_works)
> > >  		return -EINVAL;
> > >
> > > -	vfio_pci_zap_and_down_write_memory_lock(vdev);
> > > +	down_write(&vdev->memory_lock);
> > >
> > >  	/*
> > >  	 * This function can be invoked while the power state is non-D0. If
> > > @@ -1277,10 +1278,11 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> > >  	 */
> > >  	vfio_pci_set_power_state(vdev, PCI_D0);
> > >
> > > -	vfio_pci_dma_buf_move(vdev, true);
> > > +	vfio_pci_zap_revoke_bars(vdev);
> > 
> > I'm wondering if this change in behavior is correct?
> > BEFORE this patch the sequence was:
> > 
> > 1. zap vma mappings
> > 2. Enter D0
> > 
> > After this patch the sequence becomes
> > 
> > 1. Take the lock
> > 2. Enter D0
> > 3. zap vma mappings
> > 
> > My worry is if user-space accesses a BAR *during* the transition to D0,
> > it could crash since the mappings still exist during the transition?
> 
> not 'crash' as you also noted later with all Fs on read and dropped writes.

Ack, "crash" is definitely a strong word, I just meant that the
user-space program isn't expecting to see all Fs today. Since today any
access during reset is faulted, however with this all apps may have to
lookout for all Fs during a read. Could this change cause existing apps
to crash?

> 
> > 
> > The old code is immune to it because it removed user-mappings first.
> > 
> > Following the discussion from v1 regarding the ordering of
> > vfio_pci_dma_buf_move() and the D0 transition.. while it makes sense to
> > perform the DMABUF revocation/move after the hardware is in D0.. I'm not
> > too confident about moving zap after D0 :/
> 
> probably add a comment to remind that ordering requirement for dma
> 

+1. That'd be helpful.

> > 
> > I mean, sure, the user would just see all Fs on a read and writes will
> > be dropped silently until we are in D0.. but the behaviour before this
> > change was that the user access will fault and hang on the memory_lock
> > instead which ensures that the user observes a consistent dev state..
> > 
> 
> I see this more consistent from another angle.
> 
> Old code only removes/blocks cpu access but not for device. DMAs
> are allowed to this device while it's transitioning between D0/D3.
> 
> New code at least make this part consistent - both cpu/p2p are allowed
> in the transition window.
> 
> Ideally a sane userspace shouldn't rely on the content read back when
> it has initiated a reset in parallel. So this behavior change sounds ok?

I agree on the CPU / P2P consistency part. However, my concern is for a
shared reset scenario where a reset triggered by one process (I guess it
was vfio_assign_device_set?) can affect multiple devices in a dev_set
that are owned by different, unrelated processes. 

In the old code, these peer processes are protected because their BAR
mappings are zapped immediately. Their MMIO threads simply stall in
a page fault until the reset is complete.

I agree for a single-reset scenario, sane user-space should never access
regions during a self-triggered reset.

Am I missing something?

Thanks,
Praan
