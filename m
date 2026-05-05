Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290926159E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014881; cv=none; b=QMd+Bml7zb8q6oU9zB/ZI8uuiYw4gOxQJ5P8pjm5WX3h0o9Yz+Ml5J+8b0hmfj9NRuXDfGvOpVa/YOuGL0bYhgC5cKRWAbGbspf06sGLGPr0l99xd1zlT+4fmFr70X4iHBM83pRXT4l4DZBLV6LUyixmHFB/gde8aNByaTttJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014881; c=relaxed/simple;
	bh=DSLj9IsEl7BEDaYwRIsNyZiWuI/TChvHDkcv1LrdSOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STcfTlXg0lRWZRt/HyivKpxA0zzW7U5DD+MHQyIhI3D8NHAQ/Pv7/PDAA5gbX37VL/yRD/Gem4R5FkqLpReMtacA+cvB8+FORCmEOxTlf77+qgiIXsv/VSLaG/8r0LFqLfUaQ1Gk7CxrrXQsc04bfB6sOb5K54iPNPBy6QIbxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtPPRQjj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtPPRQjj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso9755ad.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778014879; x=1778619679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HIUqD9eRb7o7vIOdFFZnjFyDHP3jASVnHfkTJwS6bTY=;
        b=BtPPRQjjv6dMtE1J2PR6LqB0QKA4zZdN8+oDOfXs63dPufA2jnlJx6sc1g0kgVaMg0
         L2L/geYUuvxD2kiakVJgpcDkMsQk7HcBwdUgNUIY/vK4ZwY3n7wTdeEz8eG+Q6RdAc4U
         d5SxEx6zfWxqomZ1t007awwxdFGG+NshC/0rNuyx8wfFlQm+SJLp5w2J0OgvrT6fGWAk
         t/DGriun0E0V1Zd/o/hr03ZSpIk3GX2qXi2DdRPd/nWZQSQJ/xI50IyARlwTQ6a+GxAF
         cisxUT2QCZ0tC355kMWlI+jV5t7dthlLfHtOw3Rhr4Ky2ur5DiMUgeCCb0GEw36mv7rc
         ta0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014879; x=1778619679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIUqD9eRb7o7vIOdFFZnjFyDHP3jASVnHfkTJwS6bTY=;
        b=kaeu99K5Xs7CsDhEZ6k/CH703L5pH8NTkAczT9dB0Rr/nNDtSnAxm9K54exrIej3yr
         r4gGstmk3HHt+AfP/WBpnpB0/y9yIiJlRI821sv/iNt0qcvTK713aN5MBvpBnlHmkQE4
         OMGNRUw2oQxAobLZ2/FfQYi0j+R7/S8l0iMcl0qL8MR/NdNRwjAKl8RsMTit6CdEWHlZ
         oyTjgZ6RTWl8XBAuttpcGNsg4xEc3CmtxltgRDbRXRrRaDO7cXaRhTdfDnOzxtECdPcR
         N/nj2LaVgHmKQW8e3/O+zM32ql+MMDsOHava0QsWAYhU/+Vo6ZmhwuwC81HOJX7H6XdC
         XgvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VStd999sVkw4vF9dRnB6H+NK9BoBwh4oCPqIjJ6iy3DCk28gvTai0jZQatE5NYtzR2vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvVywiJ9GGqZRDDpjkwW+ASgDvRxZLvx/xQLLwjERkaA244EA
	O+0/6zA6WvaAuc7uK2hrP2sovFLJBOIlZDdEBsdlP/kRpH804d05txOH5Zto/83iO4SEugwobM/
	NJmrl6w==
X-Gm-Gg: AeBDieut+iYEfY+gtU1UWP0vigMrEdtZu03ClcbRh+tfcSLCsJUl5ZufiZc6bz+PRWb
	gQP6vnYC0f6F8uwXpxPcLuyUD62+bqq4Y0Pvg1GhZj79+K4ZQ2eYQ3Nkk/77X2Kk5anpA4YDYzf
	0aQ6znIK8/+war539LGyKVVYQDRK2FuTqgllKhJoTHANLl6lQdQNlPBrxQKYYIfmWYnp3KnfnPd
	GgiKX5IgGd3BcfBa4EyCWMkpSIiaP70Yt0M6Ikp/BO0BAyNSX1zgCoKUkB+lLwfE+OqitKGZ8D/
	BsINciUlUkDDy008OgOWh96sI6/GltZUqZDKdFx96XMeTPrCLQy43yx8gIefgFGNYJquTWu+phl
	DKLqu3qVAqFrmOBsKIekggXVz4n7IS9gQOQf3KmDg+H1awrlWj6LBic6RYKJfOVeNeN+Se3AL0Y
	eUBa9LQrFchGMzVaVOePf2QF94b6+Pas/Qj8ji2Yz/DWuf8csP3Kgd+XUeuJvkQBtHUn8+xEBlr
	h2UXnPd1KKpy5uDMg==
X-Received: by 2002:a17:903:246:b0:2ba:6518:e4d8 with SMTP id d9443c01a7336-2ba77e9230dmr821305ad.20.1778014878375;
        Tue, 05 May 2026 14:01:18 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d34872sm3279369b3a.22.2026.05.05.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:01:17 -0700 (PDT)
Date: Tue, 5 May 2026 14:01:14 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <20260505205825.GA4169286.vipinsh@google.com>
References: <20260402173059.1018805-1-rananta@google.com>
 <20260402173059.1018805-9-rananta@google.com>
 <20260413165308.GA3034974.vipinsh@google.com>
 <CAJHc60yS==1ZeOPYbPNw+WC8_rZwze16_zOSxFE4o_dP8KKXUw@mail.gmail.com>
 <20260505182013.GA3901795.vipinsh@google.com>
 <CAJHc60ysfZCENvNsWSLrp=ughrgR5M3wSM4Z669ESanMPnMm6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60ysfZCENvNsWSLrp=ughrgR5M3wSM4Z669ESanMPnMm6g@mail.gmail.com>

On Tue, May 05, 2026 at 01:49:55PM -0700, Raghavendra Rao Ananta wrote:
> On Tue, May 5, 2026 at 11:52 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Mon, May 04, 2026 at 10:51:41AM -0700, Raghavendra Rao Ananta wrote:
> > > On Mon, Apr 13, 2026 at 11:08 AM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Thu, Apr 02, 2026 at 05:30:59PM +0000, Raghavendra Rao Ananta wrote:
> > > > > +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> > > > > +{
> > > > > +     struct vfio_pci_device *pf;
> > > > > +     struct vfio_pci_device *vf;
> > > > > +     struct iommu *iommu;
> > > > > +     int ret;
> > > > > +
> > > > > +     iommu = iommu_init(variant->iommu_mode);
> > > > > +
> > > > > +     pf = device_init(pf_bdf, iommu, UUID_2, &ret);
> > > >
> > > > I am assuming because of this, you cannot move device_init and
> > > > device_cleanup calls to FIXTURE_SETUP and FIXTURE_TEARDOWN respectively.
> > > >
> > > > Can we just start this test with device_cleanup(), then do init with
> > > > UUID_2? This will allow to reduce the code in all of the tests by moving
> > > > things to corresponding setup and teardown functions. WDYT?
> > > >
> > > Yes it was intentionally kept this way for the 'override_token' test.
> > > Also see the previous 'pf_early_close' test that performs a premature
> > > cleanup of the PF. To accommodate these (and any future TEST_F()s we
> > > may want to add) based on your suggestion, we'd have to create
> > > special/conditional statements across the tests and I'd like to avoid
> > > that if possible. The current setup clearly shows what each test
> > > does/requires.
> > >
> >
> > I think if you make device_cleanup() handle already cleaned up device as
> > no-op this should avoid any special handling.
> >
> 
> Having a conditional check to avoid doing the cleanup only to satisfy
> the 'pf_early_close' test was the special handling that I was
> referring to.
> No other test requires this.
> 
> > iommu_init() and device_init() with UUID_1 will be used by all three
> > tests in FIXTURE_SETUP(). Their corresponding cleanup will be in
> > FIXTURE_TEARDOWN().
> >
> 
> 'override_token' first initializes the PF with UUID_2 as the token and
> then overrides to UUID_1.
> To easily satisfy all the tests, ASSERT_COND_VF_CREATION() was built
> on the assumption that when the VF is verified, the pf token will
> always be UUID_1.
> 
> Anyway, I tried moving the PF setup into FIXTURE_SETUP() and the PF/VF
> cleanups into FIXTURE_CLEANUP(), and I adjusted
> ASSERT_COND_VF_CREATION() to accommodate any PF token for comparison.
> I'll push these changes to v8 soon. Let me know what you think.
> 

I am assuming you meant for both iommu and PF setup/cleanup in the
FIXTURE macro.  Sounds good, looking forward to v8.

Thanks
Vipin
