Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B911DED42
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090317; cv=none; b=SZX6srftB31aCvTN1g9QWpDlRBtI3QUbsbvy2ycCpwnQ4bM4euNhHQrvOirfCHucSS9nL/xk3WlGOZuwXshPKc7EOeLPvaZ6kfT2lL5m3kKDGs87qqC+5hxyIgeIfSeeHcRjHj0DhpBw75ieuwkg2kppenEQZx9g7DuZm4cuYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090317; c=relaxed/simple;
	bh=pBtJYqTzwHiHhOyDzopRne4Iiz0YJJ2IFXgr6IwbK4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZZX0yNn0poGQ2C6x+nF23REZmTT+qHahenAhve+lSAEH1PvirpyKJEk/tvNHpoozs2OkGTzLrOhnREu9zUKlAHewc012sUrL1GytUAOjmChlqCGxv9wjjjfUtboH3Tw4QDT5JwItSUWkjfmP2N0fSvY6vHwxmqc+/qChRZaz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o//K1mHN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o//K1mHN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b243198058so19265ad.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775090314; x=1775695114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WXZyL+wh812/d0uUJjhnC2hkbXbKDp3qsdLK3iL7g+g=;
        b=o//K1mHNBQVR12ERcD0gFBBPTI7drEamp+zW7+FyH593t/loLS2PMq+Rdc3hZHoWT0
         Xw3zAnIytBHKruIjs2xpEI3C3yEfzQ3OkvnNYom1oJtdwA0g13o9LbdtVJPmIn7RLC0d
         TSyDU/7NLeoVuBkNpvQQLAv/OGVAE1HOTPingbj7rti3nBpW3RRXLu3V5vLuJT6crdI9
         c0N+ztyO9JgTKG2ph6Xb5F5e1A4SGfLDpFNK0A3+J7JoczTJxpo32Qp9tG39XKtp4FWt
         tQT1rulBX9yPqexweQcRHqjTneo3hpNwhOZyshDnZ85M5x9jrE46wqvoRMsLqwb7l0FK
         KoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775090314; x=1775695114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXZyL+wh812/d0uUJjhnC2hkbXbKDp3qsdLK3iL7g+g=;
        b=DXN5VwcVyYnU7CNL/UkhLpA447ZYPSMiKRjmF60t3AouyvP+G8azs11jEqQLZwdqVH
         wpRPc/tMg15gQ/amKi+XwW9mGuy9rEG/LVrHnV7k/ZZV4gEcavk+8MLUKoitqC7+gwX/
         Cw2QWEVF3Cwbrz88LlApLmwNk/PGL8Ur3JEiObXS37vY+U7Sqt0N1JVpYuv/TgOD7gVV
         hGN7EauwTcCdMKplHiwMH10Qarsjht/ljm5nXVZAqc4rig9ZLvXhAh27q8DdUCvnhLk5
         B/ro30eRnhGNCOI3exZ2eDxRgbf2xQVSbz7TZz/GPo/5FxI1fcn+9ZXXmjZWGUWrE1IX
         0iKw==
X-Forwarded-Encrypted: i=1; AJvYcCVsIEV74I8M2MlAvDfSgNzTe7+hzVF/8GQZ1HEjHFXknejU9OXq7qvbLTojvAsrZ5AzXt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQJIyNd3j5IIAOO19cLjc2A1PDev0NCFjKWTVJR+U5Xm6CvJq
	QjA6UR+8a6Bl47dqVSOeqxoWVUHuKc08yYXW+8wYA5SR9tboRB8D9hZJli50m0to
X-Gm-Gg: ATEYQzzIQwzwS/63jtTShJUArMeEYr6HHtD+f4h5IDb5itDGfI1LzE1wHWOekUJzoWY
	pfeh4gPpAZEwda020rbFCY1wBY4L4mLUhtKDBadnEm/J59Me+eTF2zcVYjjcWOAbPXOTD1sc3Xq
	q+k33ptmyZfjfQmo4/vdcCJAUEAy9zW5XV97YQUXBqAp3BaoEOlutcvBOPv5ecLWMi5v2RBSJwI
	PrVyIOfwM097y4WcZnr6eV+zqdVrIU3F7oLefNCRCxZ6Gvo8xaprSprYxcsrSmbQTVvVPL9lS6t
	WMi3FZ2R3UDMEY0SNUDFf0tm1jLSlKLAsTaWfWlmdTznaYLhxojBdWwi8yt/cUa2Ne/Qr+u4C7g
	QfdE4LSCX5tXEOB/IG8xvVmc4hVHMNWMfI5CDeyDCdYjcfWqY5pdBfFMbx6gXwZLGQy5SxoOOzh
	hMQBSkEIbxL+N6pGk3aIsWAUgZqd2wJiNOr/DHnBOi932eVGKGOaSRQhbUshv06Q==
X-Received: by 2002:a17:903:946:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2b278450383mr362625ad.8.1775090313531;
        Wed, 01 Apr 2026 17:38:33 -0700 (PDT)
Received: from google.com (128.161.199.35.bc.googleusercontent.com. [35.199.161.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261c1sm1067585b3a.6.2026.04.01.17.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:38:33 -0700 (PDT)
Date: Thu, 2 Apr 2026 00:38:29 +0000
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib
 and test device interrupts
Message-ID: <ac26haU_7nXYWke1@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com>
 <ac1s55_oLEUQx8Hs@google.com>
 <ac18LHQLalPb4z0-@google.com>
 <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
 <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com>

On Wed, Apr 01, 2026 at 04:58:34PM -0700, David Matlack wrote:
> On Wed, Apr 1, 2026 at 4:42 PM Josh Hilke <jrhilke@google.com> wrote:
> >
> > On Wed, Apr 1, 2026 at 1:12 PM David Matlack <dmatlack@google.com> wrote:
> > >
> > > On 2026-04-01 12:07 PM, Sean Christopherson wrote:
> > > > On Wed, Apr 01, 2026, David Matlack wrote:
> > > > > On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> > > > > > On Tue, Mar 31, 2026, Josh Hilke wrote:
> > >
> > > > > Agree this would be nice to have. Is this a blocker for this series?
> > > >
> > > > Yes.  KVM selftests need to assert there's a driver before trying to proceed.
> > >
> > > That exists in the new test:
> > >
> > > static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
> > > {
> > >         const int flags = MAP_SHARED | MAP_ANONYMOUS;
> > >         const int prot = PROT_READ | PROT_WRITE;
> > >         struct dma_region *region;
> > >
> > >         if (use_device_msi) {
> > >                 /* A driver is required to generate an MSI. */
> > >                 TEST_REQUIRE(device->driver.ops);
> > >
> > > But I think you are also asking to have a helper that prints out the
> > > list of available drivers in this case. That should be trivial to add.
> > >
> > > VFIO selftests could expose add a helper that handles checking for
> > > device->driver.ops and, if null, printing an error message and list of
> > > available drivers and exiting with KSFT_SKIP.
> > >
> > > One wrinkle here is we are probably going to merge a driver soon that
> > > does not support send_msi():
> > >
> > >   https://lore.kernel.org/kvm/20260331172241.50456-1-rubind@nvidia.com/
> > >
> > > So we should also have an API for that. e.g. Add 2 helpsers:
> > >
> > >   - vfio_pci_has_driver()
> > >   - vfio_pci_has_driver_send_msi()
> > >
> > > This test would use the latter.
> >
> > Ack. I'll add a patch in the series to add these functions to the vfio
> > library in v3.
> >
> > >
> > > > > > struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> > > > > > {
> > > > > >   struct vfio_pci_device *device;
> > > > > >   struct iommu *iommu;
> > > > > >
> > > > > >   iommu = iommu_init(default_iommu_mode);
> > > > > >
> > > > > >   device = vfio_pci_device_init(bdf, iommu);
> > > > > >   if (!device) {
> > > > > >           vfio_pci_device_print_drivers(stderr);
> > > > > >           TEST_FAIL("No driver found for BDF '%s'", bdf);
> > > > > >   }
> > > > > >   return device;
> > > > > > }
> > > > > >
> > > > > > Because as is, this requires way too much a priori knowledge and magic for
> > > > > > upstream.  The user shouldn't have to dig through code just to understand what
> > > > > > devices are supported.
> > > > > >
> > > > > > Ideally, VFIO selftests would also provide a script, utility, and/or helper to
> > > > > > identify BDFs for devices it has drivers for.  In my experience, binding a device
> > > > > > to VFIO is trivial.  Finding the device in the first place is more annoying.
> > > > >
> > > > > Agree this would be nice to have. Is this a blocker for this series?
> > > >
> > > > Yes.  As I mentioned to Josh off-list, I'm not willing to accept a "we pinky-swear
> > > > we'll make this stuff user friendly".  It's not that I don't trust you and Josh
> > > > (and others), it's that for me, this level of user-friendly behavior isn't nice
> > > > to have, it's mandatory for these tests to be usable upstream.
> > > >
> > > > Internally we can squeak by with barebones, unhelpful tests, because the run
> > > > commands are often hardcoded somewhere and there is piles of documentation elsewhere.
> > > > But for upstream, none of that holds true.
> > > >
> > > > If it were weeks of effort, I would be more open to treating this as nice to have,
> > > > but AFAICT writing the code should be less than a days worth of work.
> > >
> > > Yeah that's fine, I don't think it adds too much extra work, and it's
> > > something I'd like to have anyway. I just wanted to confirm if it should
> > > be part (or merged ahead of this series) or can be separate. Thanks!
> >
> > So I need to add kvm_vfio_device_init() and it will call
> > vfio_pci_has_driver(). Then, kvm_vfio_device_init() will TEST_FAIL if
> > vfio_pci_has_driver() returns false, correct?
> >
> > Should kvm_vfio_device_init() live in
> > tools/testing/selftests/kvm/lib/kvm_util.c?
> 
> I was thinking the new test would do:
> 
>   TEST_REQUIRE(vfio_pci_has_driver_send_msi(device));
> 
> instead of:
> 
>   TEST_REQUIRE(device->driver.ops);
> 
> vfio_pci_has_driver_send_msi() would call vfio_pci_has_driver()
> internally and also check that send_msi op is non-null. Both functions
> would also log error messages if driver/send_msi is missing to help
> the user, as Sean requested.
> 
> And you'll also need to a patch to add a helper script to print the
> list of BDFs on the current host that have a VFIO selftests driver. It
> might make sense to send that as a standalone patch if Sean is ok with
> that.

That makes sense for setup_msi(). But in Sean's implementation of
kvm_vfio_device_init() above, it looks like he wants the test to fail if
there's no VFIO selftest driver for the BDF passed into the test.
