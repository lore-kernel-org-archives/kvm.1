Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476336404D
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218131; cv=none; b=kzn7mZ8wqKO3gTO8kwV3fU8N0/iASYs/M8sAWSeKXpTrcMKpMPMj8M2BRfRl3GtigsbNBLOSfqiUXCy5zRTimFU/Qp1hl7MZGp7ycmL1zgI2bhzztLnGjKWaUqBt1aFf2kVg5HSt55X1bTDukf2d1aZHVDRvxvx2BJlxU+YSd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218131; c=relaxed/simple;
	bh=95h8LSQop+NXtAUTCY4WUxyMxHyiOTBXq32dcommAVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJMEWtUvD/DDJcMMQQugUNKmQJSGnC1e9K6J7i9/ZfBIrnT4o3RWxCAZV+kSaZMLSu17fA+miLMdsgxazzw+i4phU8k4i/I7+H9/p3RqtST62fdOJVeiKjMsAux2DFnEJwHvNiixysTOhR9CjHyXXaDRiiReJZFvim6rGWKu8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI3OzYRP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI3OzYRP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6a4eccab1so40565ad.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782218129; x=1782822929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrUGuQC1RmyduYSJ3/JT9tG3Cdq2ls0SnT0GavGxSKw=;
        b=XI3OzYRPuh+VGu5iy43ta0hsdp8r6UYasd9B0XvVRNtCos2aDIBFVhop2BvMoC4Ujt
         egW8tR1BgHtBiMdghes+V23GHd3oyy0QYNs6IUlx4Z5zvfq66y9BtoUX1eimw6k1i2oY
         Q10mPK0HZxz/mFGghr85woGDuOJGrdXVL0IjaO+12/2I64V5qwkHSzzqebCC36NKt5GO
         GLRxIucveAWo0HPDEhRcipefEyCb/jjzlodcrzAZpDlYfCizh5LT14C0KwFpTPuMvwOw
         Si/9mB2Prjft7StL9yU7ljsraDKWM7Rku88sjz/Sdb0EHEKqRiEXdQ6DTQ5OOsaJQwDJ
         Gtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782218129; x=1782822929;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrUGuQC1RmyduYSJ3/JT9tG3Cdq2ls0SnT0GavGxSKw=;
        b=rdpz355riCuXG8jrYUJeuxGC281ZQNPJb3UcVtM2Rl57YCsSdGEVIXTP6lg07ouEnx
         zA/BlMzj4VEJ+GEmUJf0nc7gYQoI0F9JFIM51VGX7NO7V0wJ3v/P4THm+SlGB/IbVnpO
         xUz8Cx1QjNlVDYRTlemoKP20X/7/I/5IhPVLkcYUI34Rm9BbXr9SErzmsnLNunLmfwbB
         RHXt++9TethwIUE7E59VFYDv3pCD2/zn3ieRtj8tVqJ7dz3B3uyyNoEmSoClEQomrjoX
         K4pipdWIklpe7iQoJLqAbTZywKxrsinSSUyWQlPwZnuYR9qlTIhGRKu548kc8t91zc6D
         j92g==
X-Forwarded-Encrypted: i=1; AHgh+RryHL54lSJ0S3rdRxm/s4tLCcqjh3WK0LLZNOn4lHwrsdWq9nD0j61DypvUX/Af+BI1Ax8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1CbWlN567orm5hrKAf1WLHYSg8LgKCO675UftrAQ0SLEgGmu
	MX6aPNnGdOL07NdMTd7k6K5V9QofTGr8pibElrBI8yleiYpVDJKi6yt/jky6uwsPXg==
X-Gm-Gg: AfdE7cnwjZBBtcF46uwNdrvY/jI/sxAU32f6s0PWeWD9juezSr/p+yqQKT8O3mWwLAW
	ZUq7xRsbSZEUgHEnDsEGyUOTzNh3UMlRFg+TL2/HIQ2pFoAh6kmOn5SqxdeQ0vmPTri15JkL8h8
	CVDmuBecvaIT2sp/hdTORNjqxG4i0yQ9TbTx0dyJAylTvEYKCZU4dh7Od+2J9yFe8yb+XwUV5z4
	2wXiLLbDcE051wTGo7jWXxV/DB/CzY1p0941X+Y4OJupiU7GgyKHdkjiMgtrf068RaaOpcpCpxn
	Gpr1G4CR8YfMMDMviRVHKsYi7TANs53Ec4PfAtRqmpIPwjqRZCr87VjYBt5bXlEBNxRiw00/nNs
	pBYdw/DQJZJQDoOk5spZAJfQug4+kpr7Gi5U6VAMMjM7OCM7br2UAB7gNbMmry4oMX+IpT91TRh
	N7j8qzESOvkhTHhLIQJWdIqS5BqMNtc3QYsy9Z5hEA/YpKpXEX7Q==
X-Received: by 2002:a17:903:2c06:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2c7c5030b6emr2113265ad.8.1782218128496;
        Tue, 23 Jun 2026 05:35:28 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad83sm105841775ad.79.2026.06.23.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:35:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:35:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
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
Message-ID: <ajp9hwIw657qxji5@google.com>
References: <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <ajGbRE3WWJxNxcrg@google.com>
 <BYAPR11MB3687AE280241C9E00B46FCF98CE42@BYAPR11MB3687.namprd11.prod.outlook.com>
 <24f34e59-7c3b-4b56-83bf-cb07e3f369a6@ozlabs.org>
 <20260619133116.GB278945@nvidia.com>
 <55ea7422-08d8-4c92-aa59-8ff6f9e9d781@ozlabs.org>
 <20260622171336.7d13f548@shazbot.org>
 <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>

On Tue, Jun 23, 2026 at 12:08:30PM +0100, Matt Evans wrote:
> Hi Alex,
> 
> On 23/06/2026 00:13, Alex Williamson wrote:
> > On Fri, 19 Jun 2026 16:13:17 +0100
> > Matt Evans <matt@ozlabs.org> wrote:
> > 
> >> Hi Jason,
> >>
> >> On 19/06/2026 14:31, Jason Gunthorpe wrote:
> >>> On Thu, Jun 18, 2026 at 05:02:58PM +0100, Matt Evans wrote:
> >>>   
> >>>> My understanding is that the sequences above wake a device that happens
> >>>> to have previously been put into D3, and AFAICT it could only have got
> >>>> there because of a previous vfio_pci_set_power_state().  Seems its only
> >>>> caller is from the emulation of PCI_PM_CTRL using
> >>>> vfio_lock_and_set_power_state(), and this zaps/revokes BAR access before
> >>>> a transition to D3.  Similarly, an attempt to access a BAR via an
> >>>> ioctl/through vfio_pci_core_do_io_rw() fails the D3 check in
> >>>> __vfio_pci_memory_enabled(), and besides will try to take the memory_lock.  
> >>>
> >>> I thought the general design was the bars were made inaccessible
> >>> before going to a low power state, and remain inaccessible while it is
> >>> in low power?
> >>>
> >>> So the order of D0 doesn't matter. If it is not in D0 then there is no
> >>> mappings and zap/revoke is a NOP.
> >>>
> >>> If is it in D0 then it doesn't matter because D0 is a nop.  
> >> Yes, that's what I'm getting at. :)  If it's in D3 then BARs are
> >> inaccessible, so as long as we go into D0 before the DMABUF move, the
> >> order of the zap relative to the "go to D0" doesn't matter.
> > 
> > I believe this is correct as well, but importantly we cannot assume
> > that a stray read or write just returns -1 or gets dropped.  This is
> > exactly why we have such hard protections against the user accessing
> > the device while it's disabled.  Not all platforms, even within
> > architectures that might otherwise be considered lenient of such
> > accesses, consider this benign and might escalate to system level
> > faults.
> 
> We are in enthusiastic agreement here.
> 
> > Let's be careful not to frame this as "the access doesn't matter
> > anyway", the answer is instead that non-D0 devices already lack any
> > mappings to access the device.  Thanks,
> 
> I agree that is not the right thing to say, for exactly that reason.
> (For avoidance of any doubt, I didn't say that :) )
> 
> Thanks for confirming the behaviour.  I hope Praan and Kevin are
> satisfied that this patch doesn't cause the issues they first worried
> about (the changed order of the zap relative to the D0 transition
> doesn't have a detrimental effect because of the existing inaccessibility).
> 
> Alex, I'll post v4 soon, but if you have any comments in the pipeline
> please shout and I'll hold off awhile.

I think the discussion addresses my concerns. I'm in agreement as well.

Thanks,
Praan
