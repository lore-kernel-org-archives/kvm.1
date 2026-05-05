Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D422F0661
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014210; cv=pass; b=YE+qdmaojhMMIQ5ShGe/4deW6otG8TypcEm1hjRIbDoGhS1YNtWQN2Zsvlc6uSn54CzVxrnWkYzt562Hp4UxzQv3cuzGe50E5vIdfOzCZU1+ZQ3jgTj5KeeCHZZOTBH0TFszEX011ZtoBzXwgAxzyoOT7F8uUA47VkLATSWOx8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014210; c=relaxed/simple;
	bh=UOcOSM0NVTp+AhHGw2v9/iHru63uilQRzg5I7GcGloA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8pu6ItzJoryutw0yOTYK4bm6cg5orNVCrveVQiDqvBp0TZExHR6H71+GpxbuqqjrIAzxxS76+oU2ppOQUke+9ql8ni3x5jS3fuSp1w9fl0mhF3i7O+zAM3U9jCWFeXOo1OKTD5pC97ujdBJi9lQRxo8xaRcZvjsj427M3yvePo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGogNPoo; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGogNPoo"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e61648f10so69071cf.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 13:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778014208; cv=none;
        d=google.com; s=arc-20240605;
        b=CR5cNI641oAFNvZ92Jm/OQsjMz+kBLfmDmo7BdhUghTGGoDysm01ZW2bQHg6A4kVMH
         WDfguk/RIf/3Hwe/GgCOlWvW/OBFDX0olmHDfUspiu5AInjlxhKRPIu4LOGGkV/OrIv4
         vPyg3pm0OILIypFzp7AZ6Yi6UjW+Jq4AhlD1WHIlPro6WSjDJFV2ZB1VGh8JLHDKm92m
         HYterRGkhTPoYnM5n5d4Gpfjy2yLuEKSXCKdJUP5SDqh/jkGy9EVCdCPCRonAWyO4R8Y
         bNn2TcUg++NdMdHcGJ6e+2pW6M/sozrYtDtz7SND2/4yDZljD4OXi7d0IdIH4XiMa3yo
         9ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZdlfzVxcZ8EbOedFXFU/5hBDrFZ+Mq+/UCaBvwRzoJM=;
        fh=FLOGviUmksfDXOGh5CJ4t52jP1oaPJZ+vaHSBpx+N1k=;
        b=Z0omv7JdAEHLEhbNiYzPa2UCjYuwPQvup2CaPgEThFe2J9Cmxh1Y9Djv+Ze+JB9oOZ
         c89qBAXurFbzq5/DWgKmzVlKneYn5CdeJLcRssWd8DIbIJVe88DFfjcE6RMwYzRVVpA/
         jXzxHvGna8d0WQdqqxaz9bg8yLIspQ21r92wSLinPo6xeNTyHzcpSLOuZ/N8fKjnhrKU
         nMcICWMX/QQGsfRMH/BHw7kVXRnXZTLmRFYyXl8+6+KxoqZj/1dMQNsNOA/BjJ8SNg9D
         I+bhk941+dT16KOHtpB1cACzmeLl24Mw2Uwwh4nWEd/X9ShrTtwJXUIC7c38d34VoE03
         zf8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778014208; x=1778619008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdlfzVxcZ8EbOedFXFU/5hBDrFZ+Mq+/UCaBvwRzoJM=;
        b=wGogNPoo2xu3ct48FIkbI2o4keVvLZ2S0B+R9NecOxy1s+RlIiOydOBtFYjkMyS4Gb
         dZKXK4QzpW01OGJhTDbOW9khMjmBQYomj5uWH3kH6WySVUSJJHYKn50ZI/iPcVJmuhnf
         HnTKmqtpHVwwPrPKIDn3wVqmht6gduyqnb0/akVBwJOnUpEcEld9R/+/M5WTFqs12x3/
         XGLxKLhuYKx94UdN5hy2OHNyIML4sYACIo3QTSD/f634aoNd8gqoQ01Hf5pV3L3E4nuc
         b954wFsKnbpFQ4m+r/vBa4lk+bsNptfFcnx3qA+mzeWBP05WISNGnS34YV1CAADHO5e/
         cGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014208; x=1778619008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdlfzVxcZ8EbOedFXFU/5hBDrFZ+Mq+/UCaBvwRzoJM=;
        b=HMOaTNxZECyEcO4pwDgnOg8CzFZIALcfUsiJ+owDVXd0FTOl4pQZ+cJ+x2M/XsSSHc
         wiIH1adGsJWupY/OmKImkV6tPVwM7TVtfk3nCJXLt0hTaZeFHkQHNzgtr5d1hqrF1j+8
         z/VX5hTWxXLpKGdt2cjeOBVjofbIOgoXJsperCskj3xjjhYwgX9IEHlWSHmc0xIgwzrL
         2yy5OXVgN3Shk0ZvKHUt3NFbOk8OgBnbIFGfCEUBS39mFk3r7HEn7NCr3uixWYwMNuxR
         yKyL/gcsiYtWssG77m9JE1c3/efRtIr3wSJtL8KFyW5kZnzYnNdqGK1k6/UZAjLurRWN
         0a/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/6ccYT0yl/sVcIfYJBNUqjSnn3+0aM3hTOG1HUWW2pMFuy2cEFUB0ukdMr2yQ0qDvjnhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZrWRaVyJscQVBSifyYR+Pber4LkpFppiRWqOLj8ZdfQGwgUN
	3tjEM4epyQIXqG62lZWijIFa+6tCXbcRv9FQeFMqpMVz6NNdAEQWp5dpkHFozw30+LyYiWiNBZg
	XULdpqX6GkztiXAk0swfLoV+g2PZR42LzVQBP5qRJ
X-Gm-Gg: AeBDieuuEBwwsflOLdQfPLaTg/EfxTMclMjuGiQzE60rSxepRyoqw8FNsvPzbw9tnXt
	bERUc6uwdvSDuOW30HlVx5tMc646na3o03cF5Dc6JkzicbQAa7B27WKCF8GLwAqNQOt68lGQXCz
	ZSbq0NuM3XhZtguxP7hsTeRq+T49E1Qd9lVBY5wRJYUzHMYxFp5Z79sicbeLAGZlsGw0FJ53nNX
	nxO/pXgXry4No2xJQLvi3ORiXs5Z07wPLwvdJX/mwCjUbi6f7sQAKjEKXSqXMk9tOu7xEBKgYrQ
	r2YaKfWfR+xQv1lype+SQ6HwKOG9Yg==
X-Received: by 2002:ac8:584f:0:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-514632cb431mr917981cf.13.1778014207794; Tue, 05 May 2026
 13:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com> <20260402173059.1018805-9-rananta@google.com>
 <20260413165308.GA3034974.vipinsh@google.com> <CAJHc60yS==1ZeOPYbPNw+WC8_rZwze16_zOSxFE4o_dP8KKXUw@mail.gmail.com>
 <20260505182013.GA3901795.vipinsh@google.com>
In-Reply-To: <20260505182013.GA3901795.vipinsh@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 5 May 2026 13:49:55 -0700
X-Gm-Features: AVHnY4K6PAoBfr1_XmT9VnlV68fcFC3Tnjry_PmMy_eFsV9ZZIR3PSYcoij8Ry4
Message-ID: <CAJHc60ysfZCENvNsWSLrp=ughrgR5M3wSM4Z669ESanMPnMm6g@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 11:52=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Mon, May 04, 2026 at 10:51:41AM -0700, Raghavendra Rao Ananta wrote:
> > On Mon, Apr 13, 2026 at 11:08=E2=80=AFAM Vipin Sharma <vipinsh@google.c=
om> wrote:
> > >
> > > On Thu, Apr 02, 2026 at 05:30:59PM +0000, Raghavendra Rao Ananta wrot=
e:
> > > > +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> > > > +{
> > > > +     struct vfio_pci_device *pf;
> > > > +     struct vfio_pci_device *vf;
> > > > +     struct iommu *iommu;
> > > > +     int ret;
> > > > +
> > > > +     iommu =3D iommu_init(variant->iommu_mode);
> > > > +
> > > > +     pf =3D device_init(pf_bdf, iommu, UUID_2, &ret);
> > >
> > > I am assuming because of this, you cannot move device_init and
> > > device_cleanup calls to FIXTURE_SETUP and FIXTURE_TEARDOWN respective=
ly.
> > >
> > > Can we just start this test with device_cleanup(), then do init with
> > > UUID_2? This will allow to reduce the code in all of the tests by mov=
ing
> > > things to corresponding setup and teardown functions. WDYT?
> > >
> > Yes it was intentionally kept this way for the 'override_token' test.
> > Also see the previous 'pf_early_close' test that performs a premature
> > cleanup of the PF. To accommodate these (and any future TEST_F()s we
> > may want to add) based on your suggestion, we'd have to create
> > special/conditional statements across the tests and I'd like to avoid
> > that if possible. The current setup clearly shows what each test
> > does/requires.
> >
>
> I think if you make device_cleanup() handle already cleaned up device as
> no-op this should avoid any special handling.
>

Having a conditional check to avoid doing the cleanup only to satisfy
the 'pf_early_close' test was the special handling that I was
referring to.
No other test requires this.

> iommu_init() and device_init() with UUID_1 will be used by all three
> tests in FIXTURE_SETUP(). Their corresponding cleanup will be in
> FIXTURE_TEARDOWN().
>

'override_token' first initializes the PF with UUID_2 as the token and
then overrides to UUID_1.
To easily satisfy all the tests, ASSERT_COND_VF_CREATION() was built
on the assumption that when the VF is verified, the pf token will
always be UUID_1.

Anyway, I tried moving the PF setup into FIXTURE_SETUP() and the PF/VF
cleanups into FIXTURE_CLEANUP(), and I adjusted
ASSERT_COND_VF_CREATION() to accommodate any PF token for comparison.
I'll push these changes to v8 soon. Let me know what you think.

> If we are running a test harness, and one test failed without clearing
> up VFs then all the following tests will pay penalty this way. As this
> is a selftest code, device assigned to it is for testing not for some
> production work at the same time, I am not able to see why it will be a
> unsafe.
>
> My recommendation will be to reset and not skip, I don't think there are
> any practical risks here. I will leave it to you to make a final
> decision on this.

Not just selftests, it's possible that the VF devices were created for
use by actual vfio users. Hence, I'd like to avoid that assumption and
skip touching the devices altogether.

Thank you.
Raghavendra
