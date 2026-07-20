Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2BB41166D
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584271; cv=pass; b=oZ8ZYw8WVEJt5Oa+GChTrJdL5CDFHenlubqtyo+jDhmS6LSFJ/6qQm3Rrr14tyV6uiXm4AUx8tP4ifLESx9dBtqh0Ofn1h6OP/wbtg7O90o9IwGsKMoNqEpDrOm3ikpNocpb1vDv0HpYmpOzXQpyHF5U+M9kKHgWOyzEh8E1aBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584271; c=relaxed/simple;
	bh=FWetYHTKU3plFs91yFZPvyCfOh01CzXliAvG6YxxB2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa5ydVKSC0iuQ/xDrO1t0MwpXYoW7Yt/WH0+cLqxLrGwhiQSvbYJbyJb+AaEftUszXoZR5CwJk69pX/nmH5dYNP9+9aP8+Vr+hiEM4BE0vpviWahJ/FwXrNkXrwjwnh7o1L7bgYQvPgGgiSS9Vc0rlVUsaWo5Am9BxO2CP+ip+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjawJNAd; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjawJNAd"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca7c1176317so7759822a12.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 14:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584269; cv=none;
        d=google.com; s=arc-20260327;
        b=JpWRGGMWmoQ3vcDSrJsirrQ0+PeoIy0/cq0qnGqGLHqoOruF4Mo/uWpEueLVZX37wj
         sibk1yrvVkrDOP6jFJ+Lcik1x8MHmpQzayaZOWcv855y88BTbltKxwX4Q/YPG2VFA1+D
         /RQYTLznInsH/fT+WLsMOiMQHsu9XCd8B85STbqRdvTfr5ci/Bbx+RqlOlPyW3QjPCjN
         5v5wDGNP3fhwpMsndfeY9q/AkX2b4wuVcdcKcErq4cvvrfogXxM3gBzL29aoBIZivook
         jaQF0AJF99RRXt4w92TFVh2Hdc3UVoey+DHFtu1v3ZoSjNvZS9O62aUI9gYSM2cirDdI
         Lpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
        fh=QTiwxXkDP6/wPa0lsnlhCFh1gxukHYEwilg5P5fUZIY=;
        b=eKUGQpFOMEnKIWiv5M8Ytz1NzSWrLCkGCriZ+Qm5llZLq0UM+PAKABxsaYYzPKipD7
         sIXfgRV1RUY6lEAAdwyfAhK2NsSJ9JSlJBB8u4bDP2C/4Ok/iQht/pMHoE39P++rXUQz
         SxezNjfJdGLRZ5uRLaqWjKKElmHmY9PL4D81CUtBGoZ91XSBs1cCDlfJC6x/gIX2aXFi
         klYgxDZeLOrIDeBsxT7YB/sNCTY3IaiFsgXTA4Kms+HdOtioRz4JLvzRQb57gKHFiXyd
         Lfs9dXJbS6TYXFYsE6cxxeW3fCeZMJi+Jv2GQxE5VEVA9spLdbhRwDfRs69HP4HUjeLy
         JCSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784584269; x=1785189069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
        b=WjawJNAdqcugnTKwxXUZ4ACIjQmP9/n0gIYP2U5eYHlWacJ6VaKb0aUxFhK/tGVaDQ
         Y+H78c8sMN++nrKOAHjLUhrtUFaFmZEZ0MGuTI+oL2/Dsq7d3SFT77wWuXgc2rU2vrLL
         ah05hnV9JF8EK8nSkI7ouqCVV1n1JbKWrsVh/U77bg0D+Px8row5+Oxd03HwB3XzHRkD
         73FmukO26nC/8PiSMALnHzkWMRANUK1tZnalvla6czJSQPbbdftaIx+8jFwsxNt1vwtJ
         mqGAFTykrGCDrPEwepdi6lE86WsLtmF6ygxQrG0f743qTlr+GyVbEu3YJ9/lKO4jpAP/
         mhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584269; x=1785189069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
        b=NLks5/IstkiQ3oIws2pYy401IqJrukq51rGwne1qk88RWRtas1wCwpK+8MW5K82VEd
         BwsyKxWX3O7eFiqL+HKUfCqq1fDUCZ/pCfdC3+URygkVMGhhlNsUTkmm4xHWfWdKd2JM
         2WLkVJMKIYh1jnd/wU8H2v8aCX9pI5E1Fd/uF2wXcOyk4EX3+Yww59HEO6Xy8tLm2dbd
         VJg2FNmvU9Wy9wczPYBI+KoI1oQhRscqHgfo4dgg+d7CHChOAfeEhN946awNgF3htNfh
         KXLoiQs6odbQnXGanCNqEp0x85cEgPoHk3xNSv2Ro1ZkKW4LDgiU8CG3FjRB4mu5lIUs
         cLTw==
X-Forwarded-Encrypted: i=1; AHgh+RqvmhjS154Q+Iwnap39ww+iQwIMV9/eheXZHqnMY1NebU/bTtS3sBcPTFiKJa+1T6ZiFBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGz5Pih5CgSqZRAnxytUEO2eSSOG71vMvhQsEg8Nubm809gURh
	PddzroIsJDV6QFZQIOOrrkdKnGlUFPE9f0fVmH9eBG/m22gPWYUM6BVI+PvXEeYYsdk9u1EzzXO
	73aLqiddTikUp0Qo6eEFNKimlA1/GlqmUVM/134Yo
X-Gm-Gg: AfdE7cmgAgtQMkIua0Tgo93Bv9HRpNwctHDabyj4F6EtCKSKzP5HanHOeV04WZDZ9VO
	N6rHQJ+Z065ELmOjVylJi0KvDLTCZULMKj5qNK2OgXCFOmlHGBdH3/cXBh1rYlWokJPSd7u7buS
	MYpIuWsDuwaY0ff+t7qc1AkMjCmZ/I63t194elMLJ9tFh5epEuxwkpAEkS2uAm//7D39o+XZG2q
	5Ve/gwjiTEjWCY91Gxy1FoQ047vUDIP2yiSObgXg/WHQkeM8p30R12v4FRlFdTS55VuDUkAFjvt
	62OCSEc=
X-Received: by 2002:a05:6a21:b94:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c3ad7d7fc8mr17622851637.21.1784584268526; Mon, 20 Jul 2026
 14:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org> <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org> <allLypOmtbnPrgbw@google.com>
 <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
In-Reply-To: <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 14:50:41 -0700
X-Gm-Features: AUfX_mwkLBrmrzOblowqnnWuP3v7QICLsI9pjWJDYOH2ogP4CV4E0O_pKuQFz1Y
Message-ID: <CALzav=cGtmkBBpfUA8nP7AQ3azB_Hn7_8jJL=J+E+h61CpOFrw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Fri, Jul 17, 2026 at 10:12=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote=
:
>
> Hi David,
>
> On 16/07/2026 22:23, David Matlack wrote:
> > On 2026-07-16 03:51 PM, Matt Evans wrote:
> >> Hi David,
> >>
> >> On 15/07/2026 19:12, David Matlack wrote:
> >>> On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org>=
 wrote:
> >>>
> >>>> This is based on v7.2-rc3.
> >>>>
> >>>> These commits are on GitHub for easier browsing, along with
> >>>> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
> >>>>
> >>>> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dma=
buf-mmap-v5
> >>>
> >>> It'd be great to have this test upstream. I'm happy to review it when
> >>> you're ready. Looks like it just needs to be redone to use the VFIO
> >>> selftests library and kselftests harness. AI could probably do the
> >>> conversion pretty quick :)
> >>
> >> For sure, I'd intended to catch up with you on best approach here. :)
> >>
> >> Aside from the organic structure of the test (the open-coded VFIO
> >> device/group setup/init needs to go), the main issue is that it relies
> >> on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> >> (containing freely read-writable memory).  A subset of tests run with
> >> the in-tree EDU device, but coverage is too low.
> >>
> >> The desirable properties are:
> >>
> >>  - Having a BAR that is pure memory (all locations present, writable
> >> without disruptive side-effects) so that mapping aliases can be
> >> constructed and detected.  This is good to test things like non-zero
> >> vm_pgoffs and VA space presentation of physically-discontiguous DMABUF=
s.
> >>
> >>  - BAR >> hugepage size so we can eyeball huge mappings work (or bette=
r,
> >>  mechanically test for them).  At least 32MB would tick this box for 4=
K,
> >> 16K page systems.
> >>
> >>  - Something QEMU supports*, so one can run the test in a VM/TCG syste=
m.
> >>
> >> There were some real device models in QEMU that could be used this way=
,
> >> but needed a fair bit of setup;  I didn't want to rathole
> >> vfio_dmabuf_mmap_test on including a ton of device-specific code for
> >> some video card or similar.
> >>
> >> I'll dig more for a simple target that provides these properties --
> >> obviously it would be better to point this test at an off-the-shelf
> >> device (including silicon!).  And, proposing EDU extensions to the QEM=
U
> >> folks may be useful (there're uses for a better EDU in other contexts =
too).
> >>
> >> Since this test uses MMIO for a specific [class of] function, my first
> >> thought is it should be another VFIO driver-type test sibling of
> >> vfio_pci_driver_test.  For example, we could extend the driver-type
> >> tests' backend struct vfio_pci_driver_ops for functions capable of
> >> providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> >> could also support vfio_pci_driver_test.
> >>
> >> The spirit of the device backends hiding setup of a complex device is
> >> handy, and it's plausible that several backends could provide this "bi=
g
> >> memory BAR" service.  What do you think, any concerns with extending
> >> vfio_pci_driver_ops like that?
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
> >
> > Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> > to determine if the mmap() set things up correctly, without actually
> > accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> > PAGEMAP_SCAN to detect huge pages.
>
> Hmm, possible, although that's quite a different test at that point.  I
> agree never touching the device has advantages, but it's harder to test
> certain things if we _never_ do MMIO.  The mitigation effort to get
> coverage may not be the right tradeoff vs easier running.  I can think
> of some "easy" VFIO bugs that would be challenging to properly verify in
> userspace (e.g. PFNs all having some undesired offset).  The current
> test method is harder to fool per unit effort in writing it.
>
> Though, I will have a think about this no-touch flavour of test.
>
> What were you picturing regarding populating the VMA PTEs in order to
> inspect the result via /proc/pid/pagemap, whilst still upholding the
> principle of not touching the device?  For example,
> madvise(MADV_POPULATE_WRITE) won't work on the VFIO BAR regions because
> they're VM_PFNMAP/VM_IO.

You're right it looks like it's not possible to fault in the VMA
without reading or writing to the mapping. We could use reads, but I'm
not sure that's safe for all devices.

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
>
> Yep, looks like `-device pci-testdev,membar=3D64M,membar-backed=3Don` or
> even `-device bochs-display,vgamem=3D64M` would be suitable.
>
> So I'll also try moving the existing test over to one of these to at
> least remove the EDU++ device dependency.  (bochs-display has >1 BAR,
> and some MMIO regs which are nice for a quick kick-the-tyres access test.=
)

This seems like a good compromise.

I would suggest making the test as device-agnostic as possible so
other devices can be more easily added in the future. For example, add
a helper function to detect known "pure memory" BARs, so all
device-specific detection and setup logic can live there. We can put
that in the test .c file for now and move it to the library
if-and-when another test wants to use it. It probably makes sense to
merge this with the driver framework but I think I need to see more of
what's involved to really make a call.
