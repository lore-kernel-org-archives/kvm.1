Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB90351C1F
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007133; cv=none; b=YYGkJbMqFo8cvbMgGCe/GsHGgdBAdKZVQ9xfeeXOUM44qTHv8GFdAUQ9VYdnk4gi2HFp1o68ED6RSvm+ASi5zlPJh9268tgD6F24THPxfXb2MDcY65++NzpPNK7qufPO95YIo7EPzsbBswmNG60dlp1XbP+y81WoX489UgZv6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007133; c=relaxed/simple;
	bh=Necu5iIML2CGhfY98kpt5DRUIpvMw9GIxHKd/bh17Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j07scRwFR9XPX6TI1snS1pWeTWTcD6G/UDOx5dxAqP/7kUnpgEydzJ4wfb+0gVJCnYW9Oy2vuwLAmlTbW586j/zMBvVxoCRdfuFCA7t27xBzS7Dy4PGtxS2LJjODUGYRPBotGODBU9pUtlt8D0QDzJHueaXja+ME519388e0n6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHXRyW3q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHXRyW3q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so20915ad.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778007131; x=1778611931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDKJuoKevMUOnItPfylkAbx5N1w4MZ7LpcukgnsK1jI=;
        b=jHXRyW3qxq/kVhg0uBqiwm1u66Gi80mvSwuf5YvnvVFpZp3UL+go2wB9peU8lWZoJy
         ucoLC11+gCZK0XCQSC2bOMaAnOVZmQWL86oxWMboqU4u91jedwBnyXBavBVhAWOA6bkU
         +wjp6oRNyZKK4Tv7KnbjGjKR+w8N+cLuSpYtiti9WzVUe47mzfuxTwJOjUtJcv4UwjL4
         fmKzeOaJJ48X6blClzREJWqmriy3Kahaahums6Qa3/Svwy4LalQ9jcOQXt1FqrDI+PP6
         l5KL2Yls5r8KKBGjeUFKu1Wf1ELqYoIo9aTuTY+hozG/9dJZIR5tqwUJzSo/cVa1ukAQ
         xgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778007131; x=1778611931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDKJuoKevMUOnItPfylkAbx5N1w4MZ7LpcukgnsK1jI=;
        b=bxwUhMU9/brYijP/aX1Yl3Fa9DkUhxFhq5/c/3Y0u22SWQlfGqZ3iTIUFZ3Uqun6vU
         QPc7XA5nTvNmGJkJqowfA3XLFjKyL1PYjIQ3VmOacmr8cAojxbRxToeCMPMJHSifW9Ym
         eRtUq2OQwfWmIuTVLFrn+gnf54ANVShD75dJPMLqziuHW+XlMrWUMG3KTgHLKLEvICvz
         wY5x/wGjHsM48Ux/AUIGLEGvk+UMj7hmYC1GVF1T7kXWG8I4W70RkyWAmeQrY5boQ42v
         wGMBng/GCDCH3nSEa+kCFvMbc9J2am6ANtaRCp0vQJ/6ugkjv4obDTka4ogb2tm7QZsi
         n2rA==
X-Forwarded-Encrypted: i=1; AFNElJ9FV0SrJ2UhMwhYROS5az5Bb8PQR3BFbC/QujzOlc9FrCml6Z6Wn+dpEvEOaQw036QisfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO8CjW0pxl5FQK8c77PItIJuVztiwoMCzBKfSMi7ID0ZksUlfw
	zIixwz62hmxzGBAG2kUj4iTyo1TqFxdtvKMQp1TTmFRWuquCs8SSisONygFRnEubbg==
X-Gm-Gg: AeBDievLYySAc+Ft0OzL5uIVL0UwO940bhuN3K0JrBomemNxkWHA/Gu37fRBgfjC3mh
	3zRODvmUcWF3IYQciVrdvrmHP6boegPhwIF/vuxzZAmOqpi4f4qmfXUsC4dJqXJTkoYviBlnP1Y
	LkJYxfj8DxtwWN4JU6IXuvaF9OZeeq+I7p3xWjnspKTEo4BmM+yU04LAqob6ArSpqfi1p3DUNgn
	1wZ7i8k8MP411pcPBi07j45XxRjcaw+XQnqzBAoQvEASOGsfbdbtgPWQ6i/QEfW4gNJ1I3KlUie
	NZCdeR1g6rcecce1CEtidUiBZBLFTCXvL6TgLgrnITDWcATyGqcjdoaM6IpZcxRPjTmg27vmeVG
	0iVvup9Qoyu1FNMr+VDeRC9ZsqvUlbyHH+QP66+v1+SWpNG1o5pBFF+c4g4mRA3MBWAYXMnodvD
	HgA7RELtrB3IZHkmv10vmx09SLxxLciLDBtJpj/P0HsBCSZWezZkASLXNt7wZ2QkS+MTcODJV6+
	1IBthOlNQ==
X-Received: by 2002:a17:903:2b0e:b0:2ba:743d:259a with SMTP id d9443c01a7336-2ba77d84073mr595445ad.16.1778007130971;
        Tue, 05 May 2026 11:52:10 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f127sm3174151b3a.5.2026.05.05.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:52:10 -0700 (PDT)
Date: Tue, 5 May 2026 11:52:06 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <20260505182013.GA3901795.vipinsh@google.com>
References: <20260402173059.1018805-1-rananta@google.com>
 <20260402173059.1018805-9-rananta@google.com>
 <20260413165308.GA3034974.vipinsh@google.com>
 <CAJHc60yS==1ZeOPYbPNw+WC8_rZwze16_zOSxFE4o_dP8KKXUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60yS==1ZeOPYbPNw+WC8_rZwze16_zOSxFE4o_dP8KKXUw@mail.gmail.com>

On Mon, May 04, 2026 at 10:51:41AM -0700, Raghavendra Rao Ananta wrote:
> On Mon, Apr 13, 2026 at 11:08 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Apr 02, 2026 at 05:30:59PM +0000, Raghavendra Rao Ananta wrote:
> > > +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> > > +{
> > > +     struct vfio_pci_device *pf;
> > > +     struct vfio_pci_device *vf;
> > > +     struct iommu *iommu;
> > > +     int ret;
> > > +
> > > +     iommu = iommu_init(variant->iommu_mode);
> > > +
> > > +     pf = device_init(pf_bdf, iommu, UUID_2, &ret);
> >
> > I am assuming because of this, you cannot move device_init and
> > device_cleanup calls to FIXTURE_SETUP and FIXTURE_TEARDOWN respectively.
> >
> > Can we just start this test with device_cleanup(), then do init with
> > UUID_2? This will allow to reduce the code in all of the tests by moving
> > things to corresponding setup and teardown functions. WDYT?
> >
> Yes it was intentionally kept this way for the 'override_token' test.
> Also see the previous 'pf_early_close' test that performs a premature
> cleanup of the PF. To accommodate these (and any future TEST_F()s we
> may want to add) based on your suggestion, we'd have to create
> special/conditional statements across the tests and I'd like to avoid
> that if possible. The current setup clearly shows what each test
> does/requires.
> 

I think if you make device_cleanup() handle already cleaned up device as
no-op this should avoid any special handling.

iommu_init() and device_init() with UUID_1 will be used by all three
tests in FIXTURE_SETUP(). Their corresponding cleanup will be in
FIXTURE_TEARDOWN().

This way only pf_early_close() will have extra call of
device_cleanup(pf).

Can you tell more about special/conditional statements which each test
will have to write? Currently, we don't have any tests like that, we can
revisit it when we see that kind of issue.


> > > +
> > > +static void vf_setup(void)
> > > +{
> > > +     char *vf_driver;
> > > +     int nr_vfs;
> > > +
> > > +     nr_vfs = sysfs_sriov_totalvfs_get(pf_bdf);
> > > +     if (nr_vfs <= 0)
> > > +             ksft_exit_skip("SR-IOV may not be supported by the PF: %s\n", pf_bdf);
> > > +
> > > +     nr_vfs = sysfs_sriov_numvfs_get(pf_bdf);
> > > +     if (nr_vfs != 0)
> > > +             ksft_exit_skip("SR-IOV already configured for the PF: %s\n", pf_bdf);
> >
> > Why would we want to skip if VFs are already enabled. Just
> > set it to 0 if it is already there and set it to 1 unconditionally after
> > that.
> >
> This actually goes back to a previous discussion with David where we
> agreed to avoid such situations. For instance, what if the device is
> already in use elsewhere.
> 

I think this is what you are referring to:
https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.com
--------
	> > > +     snprintf(path, PATH_MAX, "%s/%s/sriov_numvfs", PCI_SYSFS_PATH, pf_dev_bdf);
	> > > +     ASSERT_GT(fd = open(path, O_RDWR), 0);
	> > > +     ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
	> > > +     nr_vfs = strtoul(buf, NULL, 0);
	> > > +     if (nr_vfs == 0)
	> >
	> > If VFs are already enabled, shouldn't the test fail or skip?
	> >
	> My idea was to simply "steal" the device that was already created and
	> use it. Do we want to skip it, as you suggested?

	If a VF already exists it might be bound to a different driver, and may
	be in use by something else. I think the only safe thing to do is to
	bail if a VF already exists. If the test creates the VF, then it knows
	that it owns it.
--------

If we are running a test harness, and one test failed without clearing
up VFs then all the following tests will pay penalty this way. As this
is a selftest code, device assigned to it is for testing not for some
production work at the same time, I am not able to see why it will be a
unsafe.

My recommendation will be to reset and not skip, I don't think there are
any practical risks here. I will leave it to you to make a final
decision on this.
