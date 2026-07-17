Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5742CAF4
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305861; cv=pass; b=fQefpO2juBnGrlOAV6qxKxWzRBFQygNMKAr48kER8IQvLeKMZyK9T70+GFmbLk0tLSSrDdnWqQwe4ZuJniB+9BkmgmnJylAPethZ9J1YqlDxNzAQ0rVbpY00yhU2MXXuEGy45GHJuel4u7OMyWHbJBQvRS1z44/mR5su0je4MVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305861; c=relaxed/simple;
	bh=x/TpikJydgPAR12gjRCW5tgQd0rdAPkfC74w1d+46DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkUpqJgRxfT1ClM/qpLYUTUe7RuRtPnXNpA7E2MlxePW/YyumnlX34+UbviWTwqxYEA4n4R7GDjogKrxGldx/6I+VIQYImriCW2YW3w3Hrq9aOKOJlo0iWaIZpLv3t1H5fdYvJfB6QIjsKATZVI6MNfxz1D0Mih4G2LIvKnQzqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQ5c9IGv; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQ5c9IGv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceb096e675so75618625ad.0
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 09:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784305855; cv=none;
        d=google.com; s=arc-20260327;
        b=eaGzrdkOgy663kMXhFqJVgjATqFBBtlqid7+bhcdECgRx+vgb48CuBgH6cb2XE4hLz
         Mur4vsqfIhQqDq0FcnQpfI09FKCBq9PTNsHVt+Krn9YWbI926B3++9ibZ66jbvKGG25T
         uWV/9/qA5OtAfvP5WR2JGjSkfZqmuJcCbua1tVGocyjG9aPl8+sfuVywPIq1QruIkbgN
         VRS7xxbkhJM6wIdI5hQHhN5g31vdWljE7pezYl/XnyZ3qkH/S747Kk7DP5oPcBLiFzvO
         dOCa8Rq1uizWc0jywsR1ZtKtTMevqBwPqq3ofwbk8TxoV84WiS/9C8dYIMnkwVbpXWFq
         bzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mEFacLIneOp/QmtLUJi4Z80V3TBrQh57oZzZOS5MMp4=;
        fh=ybSdqbtSzk7gLNCTKqwY2B8q0zMmc7xJsPCk2zrTD8k=;
        b=DVdmY6ejiifj+D9yt2UO9t7mK7+Y0B/28FBF2zHdrDZz9PZ8sbHUzjSQU27eB3RX2n
         OPrtyoQU+UCCVAepCKcbEW8EeYnf/ThJip6f43TWx879RYg+U4cD0lN02nS5Qn60HjzD
         biT7wysEVlhR3Ut2Vq2OA0G1udECNNOEGtsdmC3uQ1v30OJqihWrZQHtisSN5lmTyh4d
         a6duqTbrxldVVQG8a7k9Q9EbKb2zNeW85eDhdOxf5z6aGkUHuHaQjIrumLCX841ZdV8D
         dJML2pIBcCzcKe2+Dc3cFWdMEnyImw76+Is+Z5QYA5PO6zOxnnFkFaDGQwnj1kNW4Yty
         UGBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784305855; x=1784910655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mEFacLIneOp/QmtLUJi4Z80V3TBrQh57oZzZOS5MMp4=;
        b=iQ5c9IGvFLkz0xaRw5nAwEGKUVzfx1qtxWW1wL4ki/D31ldKaTVYfS/REUdnOClFAp
         bFSGlPRnARwsbo7ySwsFZkdP/l3xCwxILPqKik+Hs1JG5NhxTr7mYRqRJelDhBdSYxzz
         H3gNmymPfHecpyeYAuGmTaDJN1NtqTxPJ1HIFFAR6KHCW5aMS8aC5Ro67pnFbiQEkafl
         h55M6+/6V38K0W13XSqSlBi5118CJiV/Y1dj45sGAUjiqU2MkroSUulLnubCyO2cXmhY
         ipNnwM4ovPP1xIwxpyODFIbd9Bpcbe2qxJM6wpgXGFzkeICs5Yu8RUQrbnyaNnNtJFP3
         chHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305855; x=1784910655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEFacLIneOp/QmtLUJi4Z80V3TBrQh57oZzZOS5MMp4=;
        b=gwuIKapp3HucBN63HfPBIoYFLIW7NCp5E75kxh4OW0EX5ah6HtIMGnM/WW2egRk2oC
         0vbykrDI6XNdSvov2nP2UV72ux8jSv151anwaELaypREV6g4ZHYKFXvH6Bf6Cw+J8/kW
         ekO3lAeVqhR0FyE5/Y2vQQUoBBWRX6ZSUenggoayWW962KxwKQnA/9YYTb0H3Rp8dOc6
         qZfhcBZ8970FpVso3mFG8BK1iUdk3cM9uDL0a7sYotmnKPCqUuAPnYgam851LhN4jCau
         OgvfzkXGfuhQa85aJUKq33aJsuP5UtQ47ROIn55mkA1JKYXfZjZlP5NJy149JVYiNK3Z
         HzPA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4CUquF/vLSIr5e98rX5wy6ZNcbna1uyW4gNXkvRmefchH7r1BZgAUv6jB9dppMmYGMzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwjL/Es54aXxsXNaf1Vqwa0NkjA34hInw/thtw9JLXJ0DwLe8
	QQa2X8AZSWvTlVZsYJegHHmSIGwASGCtRaFvWJCHtKZbck4ygOkMRTFGvorqj5dtDEcR7akwXTi
	NK6S7cqGnSyn2ZQZ4qjsdV1nmXPlYnVDogpCdQUpP
X-Gm-Gg: AfdE7clZWa6Ink095qfvukAIgzxgyBDGySKb4wYkktfxs7qT5XQ9NqFs1SseGipOVg1
	Hee/IwZ3yiluzKyqbwYCzOzriYe35Ur3gBdWDh759Dh7EBlrIKjt2/Ej5Wf8JAfGbWzwqCZpczG
	V89VigtJs0rAKY06AkO4vt5Jz1SEAuIIdJpA/tGTvLd6ZTIuXSd5xY0IZOq1QA5yVTEWDoVlN2n
	MvERXDauXrkt9DYgNfXnMnwAx0/89UyKCKRzmzVmN33w00OEBZewTQykzU95w==
X-Received: by 2002:a17:903:19cc:b0:2cc:db71:4db5 with SMTP id
 d9443c01a7336-2cf349d3ee3mr39097735ad.37.1784305853798; Fri, 17 Jul 2026
 09:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org> <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org> <allLypOmtbnPrgbw@google.com>
 <20260717094230.21829508@pumpkin>
In-Reply-To: <20260717094230.21829508@pumpkin>
From: David Matlack <dmatlack@google.com>
Date: Fri, 17 Jul 2026 09:30:25 -0700
X-Gm-Features: AUfX_mwhrL8yyMXeQp2wwPQntVuYsbostLm0_QgQevpUJ-QTbHpefGc5UhWYaLU
Message-ID: <CALzav=fx2i1ONLjBTheHpdOQqQJJ05OP9b4-D3HkK6NumKi=pg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: David Laight <david.laight.linux@gmail.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
	Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:42=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 16 Jul 2026 21:23:22 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > On 2026-07-16 03:51 PM, Matt Evans wrote:
> > > Hi David,
> > >
> > > On 15/07/2026 19:12, David Matlack wrote:
> > > > On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.or=
g> wrote:
> > > >
> > > >> This is based on v7.2-rc3.
> > > >>
> > > >> These commits are on GitHub for easier browsing, along with
> > > >> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test"=
:
> > > >>
> > > >> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-d=
mabuf-mmap-v5
> > > >
> > > > It'd be great to have this test upstream. I'm happy to review it wh=
en
> > > > you're ready. Looks like it just needs to be redone to use the VFIO
> > > > selftests library and kselftests harness. AI could probably do the
> > > > conversion pretty quick :)
> > >
> > > For sure, I'd intended to catch up with you on best approach here. :)
> > >
> > > Aside from the organic structure of the test (the open-coded VFIO
> > > device/group setup/init needs to go), the main issue is that it relie=
s
> > > on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> > > (containing freely read-writable memory).  A subset of tests run with
> > > the in-tree EDU device, but coverage is too low.
> > >
> > > The desirable properties are:
> > >
> > >  - Having a BAR that is pure memory (all locations present, writable
> > > without disruptive side-effects) so that mapping aliases can be
> > > constructed and detected.  This is good to test things like non-zero
> > > vm_pgoffs and VA space presentation of physically-discontiguous DMABU=
Fs.
> > >
> > >  - BAR >> hugepage size so we can eyeball huge mappings work (or bett=
er,
> > >  mechanically test for them).  At least 32MB would tick this box for =
4K,
> > > 16K page systems.
> > >
> > >  - Something QEMU supports*, so one can run the test in a VM/TCG syst=
em.
> > >
> > > There were some real device models in QEMU that could be used this wa=
y,
> > > but needed a fair bit of setup;  I didn't want to rathole
> > > vfio_dmabuf_mmap_test on including a ton of device-specific code for
> > > some video card or similar.
> > >
> > > I'll dig more for a simple target that provides these properties --
> > > obviously it would be better to point this test at an off-the-shelf
> > > device (including silicon!).  And, proposing EDU extensions to the QE=
MU
> > > folks may be useful (there're uses for a better EDU in other contexts=
 too).
> > >
> > > Since this test uses MMIO for a specific [class of] function, my firs=
t
> > > thought is it should be another VFIO driver-type test sibling of
> > > vfio_pci_driver_test.  For example, we could extend the driver-type
> > > tests' backend struct vfio_pci_driver_ops for functions capable of
> > > providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> > > could also support vfio_pci_driver_test.
> > >
> > > The spirit of the device backends hiding setup of a complex device is
> > > handy, and it's plausible that several backends could provide this "b=
ig
> > > memory BAR" service.  What do you think, any concerns with extending
> > > vfio_pci_driver_ops like that?
> >
> > I wouldn't recommend leveraging the driver framework unless absolutely
> > necessary. It makes the test harder to run.
> >
> > The biggest issue I see with the proposed properties is being able to
> > treat the BAR as memory. That obviously will depend on the device and
> > may require device-specific setup. If we decide that treating the BAR a=
s
> > memory is truly required then using the driver framework is the way to
> > go. But I'm hoping we can avoid that requirement.
>
> Could you run a test where only a known part of the BAR can be treated
> as memory?
> A large BAR is likely to have some areas that can be accessed as memory.

Yeah. But then the test can only run against devices the test knows
about. So we have to update the test every time someone needs to use a
new device.

We could support a command line option to specify the BAR subregion.
But then the user has to figure out what to pass there.

So if we can find a way to get equivalent test coverage with "any
device with a large enough BAR", that would be ideal. Then it's just
matter of the user picking a device, and it's easy enough to look at
BAR sizes via lspci.

> >
> > Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> > to determine if the mmap() set things up correctly, without actually
> > accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> > PAGEMAP_SCAN to detect huge pages.
> >
> > With that requirement gone, then all you really need is a device with a
> > large enough BAR. And even that it not a hard requirement. I'm sure
> > there are plenty of test cases that could work with smaller BARs. The
> > few tests that want to exercise huge mappings can inspect the device BA=
R
> > sizes first, and if they're all too small, SKIP() the test.
> >
> > If you structure the test this way, then it's easy for the test to be
> > used. It can be run against any device for the basic functional
> > coverage, and can be run against a device with a larger BAR for full
> > coverage of huge mappings.
> >
> > Does QEMU emulate any devices that have 32MB or larger BARs?
> >
>
