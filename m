Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98A2FC00D
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277763; cv=none; b=VPl+71o55XMYok/3vVrjIM8lHlZ7bw/kUXzV0vemBaSjELsBHPmIQPHdFM4r++YBUUNazOMTp4t3WDPUtcXjgA9N5KA0p7Zk5gaj3o6uFDLCCeisNTL1YEoi0yXE2LZFClhO+lej2K5lh/NeR+BOoKInPAVdo8qFUTBBtkdIQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277763; c=relaxed/simple;
	bh=t1LMTk+m9oNtNRG5YfAumyLAJRoq18yZjfUqUDBAyso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXmqD0lMR54Hc8MTGJNLGoua/NkgoBdTJydkLx41N6HZyqSHBn7PPEOxGjNaZetlHYVq5xb2WEKkOj03qiHUraqA+OJyog4+OeUxkJUtp8SAbX4I20bvOSp88KJ61IbPJ6FkeTlMOxrI749RkGdmVMKlr9vbpakx6I5xEVqkKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoUqw7+h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoUqw7+h"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47362928f65so6806697f8f.2
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784277760; x=1784882560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1bNr8ApLUuasJ6rLo6oRgqpfU7n7a0nEcTyafySNYU=;
        b=RoUqw7+hDNY9s0TTmG9YDmrcpny9e/AlnCz3xwS6lwuk12nG3NsMCsPHlVYxVIb4iP
         o6zWxiVr5TX4mmurxtpKv7EfcXXf98WQzYdHUCC0dbV1s3Btoso+UJ+NOEKry3tT9B7K
         FMjX0b8BUEdub/kBNXIfFvRElSpEFI4wRL+GpKTm1869bRttvIYm0mBAkj4+gIQYT15i
         /7kQEto0xPDRPaAwShUYdFTaY0ckW1mjzpPq67/F6UHof/28xH2SvXJYDV96Tebe6qWL
         FkSndvFucgQiN4Ib+/t894odTymxWpas4MZigvOJt+k8L8NVsOia+9ZmLCVb6XYThzbo
         TQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784277760; x=1784882560;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1bNr8ApLUuasJ6rLo6oRgqpfU7n7a0nEcTyafySNYU=;
        b=m6xjFpl4H0lGMcX19bYu3N/Kk4nCcIhQftYW5wPcd577vEXwtaHFjwZuxuwhz9I+a0
         n5XOyEoBb0czujuryCKc3bQuypeeYXEyVdEy43VeaVDQjkN7WDbZOqUSSo5r9yoP3d4E
         wUxSxzQ+gQKgWWq1hRow2yoT707RunvT0Y4oUUfKM1/nwS+KlBgJZ7QzbunV2ekI0Aqe
         i8IaEI9jckNGcrQLni97+yM0Q6SUlG41rhob5yHTATl5gmQ5hs0tT7C5xme5Fzkd4qij
         YxDIeQZcq0wwKgIxbo6qNiu+HepRvR3rFwxI7BwbfrogPuV6W4jjVW6OVIxqVPY36JrK
         W5sA==
X-Forwarded-Encrypted: i=1; AHgh+RpauDbaKeZBwHfLGQzLaFQe6cVsiNSfULv9INYEWeiABdWCrbCpkh695oDxZytf5o2ziNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQoIK5i+xgv8bGd9X3GQrBY2Ow/rzpB/jOOmxxrJTPO4Qz+sN
	fJK8/2fw2UuTmgSHte9xkbyuyik50BWgf05gTV8V8cYjCoMt+NfrPwSL
X-Gm-Gg: AfdE7cm+IkfPDfEqVwGEuKubcdj8/out+QSSsfqURlKMn8LTgKm/cZ1nSrDF9c21DDL
	Zp6G7+sML9qDH5T4F5BWUQHF1TmepWj1kVMyWKfni5Ba75Kk2lxsqI5KEpP1MEscS0Nl0Ynu1u5
	DcBQDllIHrutCtTXOvGxn8dUuKe2WWnGKLSykdQ/DvO36eZu9WKvCG6NVOyt998JrWf8ZsxihkE
	GAwsvJ5wycJ6fFBArPdYZp5jkHFYwZEfUlHvQxyYkM+xgwiDCCQrbAa4cK4NlYpTxp6R4nkJirc
	dK5EpTHB+iTwTsvmJU8I9Wthev0XhQAG4SXLXdXaN29ZGMYy8bT9xQKTi65YQVGj/BwuklNmF21
	xAXbMcKjp60CcCKbk9v4PlsjweDZmnXPLm97E8QEj3Q853QBNVb8kRzJzaQpEOSIbExBRcrx30V
	mgf3ID7aqIoGRZYl1jeOIMwJlJDsbA7l09/9svRwg=
X-Received: by 2002:a05:600c:3107:b0:493:d305:b8f3 with SMTP id 5b1f17b1804b1-4954a3d6462mr20532115e9.3.1784277759663;
        Fri, 17 Jul 2026 01:42:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm28806635e9.0.2026.07.17.01.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:42:39 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:42:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Matlack <dmatlack@google.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>, Leon
 Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro
 <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal
 <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <20260717094230.21829508@pumpkin>
In-Reply-To: <allLypOmtbnPrgbw@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
	<65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
	<allLypOmtbnPrgbw@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 21:23:22 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-07-16 03:51 PM, Matt Evans wrote:
> > Hi David,
> >=20
> > On 15/07/2026 19:12, David Matlack wrote: =20
> > > On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org>=
 wrote:
> > >  =20
> > >> This is based on v7.2-rc3.
> > >>
> > >> These commits are on GitHub for easier browsing, along with
> > >> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
> > >>
> > >> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dma=
buf-mmap-v5 =20
> > >=20
> > > It'd be great to have this test upstream. I'm happy to review it when
> > > you're ready. Looks like it just needs to be redone to use the VFIO
> > > selftests library and kselftests harness. AI could probably do the
> > > conversion pretty quick :) =20
> >=20
> > For sure, I'd intended to catch up with you on best approach here. :)
> >=20
> > Aside from the organic structure of the test (the open-coded VFIO
> > device/group setup/init needs to go), the main issue is that it relies
> > on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> > (containing freely read-writable memory).  A subset of tests run with
> > the in-tree EDU device, but coverage is too low.
> >=20
> > The desirable properties are:
> >=20
> >  - Having a BAR that is pure memory (all locations present, writable
> > without disruptive side-effects) so that mapping aliases can be
> > constructed and detected.  This is good to test things like non-zero
> > vm_pgoffs and VA space presentation of physically-discontiguous DMABUFs.
> >=20
> >  - BAR >> hugepage size so we can eyeball huge mappings work (or better,
> >  mechanically test for them).  At least 32MB would tick this box for 4K,
> > 16K page systems.
> >=20
> >  - Something QEMU supports*, so one can run the test in a VM/TCG system.
> >=20
> > There were some real device models in QEMU that could be used this way,
> > but needed a fair bit of setup;  I didn't want to rathole
> > vfio_dmabuf_mmap_test on including a ton of device-specific code for
> > some video card or similar.
> >=20
> > I'll dig more for a simple target that provides these properties --
> > obviously it would be better to point this test at an off-the-shelf
> > device (including silicon!).  And, proposing EDU extensions to the QEMU
> > folks may be useful (there're uses for a better EDU in other contexts t=
oo).
> >=20
> > Since this test uses MMIO for a specific [class of] function, my first
> > thought is it should be another VFIO driver-type test sibling of
> > vfio_pci_driver_test.  For example, we could extend the driver-type
> > tests' backend struct vfio_pci_driver_ops for functions capable of
> > providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> > could also support vfio_pci_driver_test.
> >=20
> > The spirit of the device backends hiding setup of a complex device is
> > handy, and it's plausible that several backends could provide this "big
> > memory BAR" service.  What do you think, any concerns with extending
> > vfio_pci_driver_ops like that? =20
>=20
> I wouldn't recommend leveraging the driver framework unless absolutely
> necessary. It makes the test harder to run.
>=20
> The biggest issue I see with the proposed properties is being able to
> treat the BAR as memory. That obviously will depend on the device and
> may require device-specific setup. If we decide that treating the BAR as
> memory is truly required then using the driver framework is the way to
> go. But I'm hoping we can avoid that requirement.

Could you run a test where only a known part of the BAR can be treated
as memory?
A large BAR is likely to have some areas that can be accessed as memory.

	David

>=20
> Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> to determine if the mmap() set things up correctly, without actually
> accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> PAGEMAP_SCAN to detect huge pages.
>=20
> With that requirement gone, then all you really need is a device with a
> large enough BAR. And even that it not a hard requirement. I'm sure
> there are plenty of test cases that could work with smaller BARs. The
> few tests that want to exercise huge mappings can inspect the device BAR
> sizes first, and if they're all too small, SKIP() the test.
>=20
> If you structure the test this way, then it's easy for the test to be
> used. It can be run against any device for the basic functional
> coverage, and can be run against a device with a larger BAR for full
> coverage of huge mappings.
>=20
> Does QEMU emulate any devices that have 32MB or larger BARs?
>=20

