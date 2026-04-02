Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242D1DF74F
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094579; cv=pass; b=OyAOm+SPrTOGg8sMyVR5ZLzm0XtdnLwGlgVaYhXFcGzpmb9YvhhvvY/zY/Ac12v5mMlTlJ7VwrxroBupDGZyplvCzgqymxr6Xr9v6+XoEUGbT62xDwz1awd8vJLpI8XJRBgAucJc6PH6ZM5+HL61RlSpAxo2tw50thKW8WdjWs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094579; c=relaxed/simple;
	bh=wXyr8q0lg/6QndcBZyJ6JDJgfP3E9JcyNV3xC396vRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffaEkodcrZoKXGzRtwgqKrRcMAgZOxuy+e2ec3qBUXrlhIllZagczhxQ8NAZqT30lhZrAkYv9WvQ11f2AKBiEH17pDsHM8QacL0ZgijcdWSSu/E4dKxQW38LldZZh+pCa9Nt64BWFP2GH7w73m7852aiDGz2zat6zj66Rzp+cv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZY5+vH3; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZY5+vH3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5091ed02c54so164351cf.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 18:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775094577; cv=none;
        d=google.com; s=arc-20240605;
        b=N1vZCDrwidyxijKIueIqz+ggzxl7yvRAVkOXxg6UOmBONkEzGS7/Gmiam++hl+EFfJ
         g3+YgbpcLzfpMlG1wFnHtyG92P2amLWTmSq/WauXLUPxaxf24juB14jHuAYGB4U0t5LI
         H0mZRK9pMGXAUP2N+ZRVXpX2Mg3oEshYGS2X6CVbyiqT7HOOPJYWy/M/ILNOg7WBc+zA
         HzoKHqyQkHmmF1E0s80Uk7VokQSQX1wF/Jetj1IrKvp5kiXCCHN4fn+NZ+3e+jZnVhkx
         yU01HB2oleffTqD0+iS4cokchhuPOCtADXG4Np0vbSVsAK/C27SS7wIl0IUzACNqG4o/
         EU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWNbaYi2rHbjkTYm1hNM9FFoz85bxy3ZvhhbJvgSZOM=;
        fh=nK5H/YzrNtKkCkZ8HRazmCqjC2kNaDUylxzz32UV38A=;
        b=WTpLiIEoV3pO/MGU8KyZpJfdj728RX5LOwwW9MNLL6JO/9CCQOykq3+5+7PAAZO4vH
         uwXF9nQSgVICfjOuK3JFYG9yt5D9Td8gH4OkoimQl/0jetWo8QzmLwV57gIH5XuAVirq
         DII7WjZ9fynIweUhBjQO/qk1wCQHXav64ySWlvEq3yy2wnu4FMVhFcP8G8jbWsjJbPVT
         Lnn3jJmZrMliD/wPeYxlbwn5Uwq9zEKACwT14ZED49r7pKyWCPGvcofc95HQU/ET1Fck
         2Q+SgKdshpYAxwhzQ2ask+RfH/fEW8v6XsSwQNn1mSsbiIbgsJG+slAv0qVUwQO2Vz86
         DTnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775094577; x=1775699377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWNbaYi2rHbjkTYm1hNM9FFoz85bxy3ZvhhbJvgSZOM=;
        b=mZY5+vH3BTzrA67W1gbT+9CMf549D1KAeKVaNYJ+l1d0Jb5OxjpXijv/44u3SfLjuJ
         VO7x44MEy2juRptQC4OoEGnH7you7XXtY4Nd8MuDYKtpe44lyNUpT8tyfcpfiRvvSl8W
         yWkoCyQcfsVrxc1nkbwOo5SlvyFY6M8geybMAPHiq8XHLOcRPp2G+ihwmc2KOmyafGOd
         eJjQVuyzJ3vQ9Ax/gtGqYfS2Si0QhiymSjMpK3Hxvc1Km6aEX/msX1uI4ZXUNl5JJhUy
         iNagYiV3GIYxChbxIcGSXW8yfMM052Ena9WCxycmo4CB53FRVP726mz2vBTstDOjeliN
         8F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094577; x=1775699377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWNbaYi2rHbjkTYm1hNM9FFoz85bxy3ZvhhbJvgSZOM=;
        b=eI2EBLyTrkEO06TxkL7bS2XFgSmTkpdgteTGXpMBS4KRcvnCpCUt5u3An1sylEkd6p
         iaArdfU9yKJdsray6Ydjhs4+hjYKabB2nV9NB0f+YYXfmMqhpHr1OZ2E2LfFWyb3WCrk
         UTDvW9owWKHGxyasIuF0qQsy2+WRIWrTv3kdodVQltOeQpaFFd7+UZd7kKLQJKdqQxGJ
         oS+MGo+d0Oeu81rl5TmmLLRTAxYA8ukPGuRd84uMERMaJo1nfIS4CghJ8CiUlclLfLS3
         PKlbF6H9yM6DR462yUBoDExw3DdToyTp3nbyV51zaY23gcQrKNQzpbv/5iMzhclTFVPk
         6i3g==
X-Forwarded-Encrypted: i=1; AJvYcCXtX6qx+a+IKXBXas3y7QjUkavtMb592AU4jKN8pUjstM3bb3rQoRwyQYAAfBIMegsnvII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIowxwBwoVAmBpwIdHpolRPBwGh2PsVhgIrtqgLr/sTWp1hC0
	DCRFsvqVl+ORD5VBYZTwzpU6+ptqzCvbcEMzYg4JtzSM9F8AlZZSDdfzak2Eq+vdZmAjOH/FnXr
	BMhzCdhBw2Q6nsv8B2OsAE25B3TDTQmPMO0GokyQ=
X-Gm-Gg: ATEYQzzHh+4QL7S/oyDVqjJ4WhVHCzRNBuLGQQLMBOanDGPmnYCa5n7P3aNRK8DsrRv
	higbFw2GIYU9+9lDZNsKy/hx76oG/wFOkpULthjhqzqu6/RP1rZaR0tpaLEES9SOUBE0OYpdRUw
	1hB4y+/P6L72GV3R5RjKlPQ8w3DvAea9jPmyfSiywchtirMcOQMw3AxmCtVIzcAY0bTTZfacQPs
	gJ/HiIb6AqH5cM7laGgOFppX7QcZhaMdJu1C2P/X1a1nkqao8STB+YsOL87HQ6dKVa+YBuNzyfY
	SyIUsBNuYjWRfSrnn+dweD2zAUdq8yObz+wD
X-Received: by 2002:a05:622a:8597:b0:50d:418a:9770 with SMTP id
 d75a77b69052e-50d504aab45mr2409981cf.2.1775094576443; Wed, 01 Apr 2026
 18:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com> <ac1s55_oLEUQx8Hs@google.com>
 <ac18LHQLalPb4z0-@google.com> <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
 <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com> <ac26haU_7nXYWke1@google.com>
In-Reply-To: <ac26haU_7nXYWke1@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Wed, 1 Apr 2026 18:49:25 -0700
X-Gm-Features: AQROBzDgd0C03k6tITU-FGK4zu3Xl10Ufb7uG6WJAwPTMw-uK2oWd9RVEsW8_9k
Message-ID: <CAAdrzjvvxX3eEkCBUvSud7qyaSUdzecgAkX1=f+ZQe7Q6ws69A@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:38=E2=80=AFPM Josh Hilke <jrhilke@google.com> wrot=
e:
>
> On Wed, Apr 01, 2026 at 04:58:34PM -0700, David Matlack wrote:
> > On Wed, Apr 1, 2026 at 4:42=E2=80=AFPM Josh Hilke <jrhilke@google.com> =
wrote:
> > >
> > > On Wed, Apr 1, 2026 at 1:12=E2=80=AFPM David Matlack <dmatlack@google=
.com> wrote:
> > > >
> > > > On 2026-04-01 12:07 PM, Sean Christopherson wrote:
> > > > > On Wed, Apr 01, 2026, David Matlack wrote:
> > > > > > On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> > > > > > > On Tue, Mar 31, 2026, Josh Hilke wrote:
> > > >
> > > > > > Agree this would be nice to have. Is this a blocker for this se=
ries?
> > > > >
> > > > > Yes.  KVM selftests need to assert there's a driver before trying=
 to proceed.
> > > >
> > > > That exists in the new test:
> > > >
> > > > static int setup_msi(struct vfio_pci_device *device, bool use_devic=
e_msi)
> > > > {
> > > >         const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> > > >         const int prot =3D PROT_READ | PROT_WRITE;
> > > >         struct dma_region *region;
> > > >
> > > >         if (use_device_msi) {
> > > >                 /* A driver is required to generate an MSI. */
> > > >                 TEST_REQUIRE(device->driver.ops);
> > > >
> > > > But I think you are also asking to have a helper that prints out th=
e
> > > > list of available drivers in this case. That should be trivial to a=
dd.
> > > >
> > > > VFIO selftests could expose add a helper that handles checking for
> > > > device->driver.ops and, if null, printing an error message and list=
 of
> > > > available drivers and exiting with KSFT_SKIP.
> > > >
> > > > One wrinkle here is we are probably going to merge a driver soon th=
at
> > > > does not support send_msi():
> > > >
> > > >   https://lore.kernel.org/kvm/20260331172241.50456-1-rubind@nvidia.=
com/
> > > >
> > > > So we should also have an API for that. e.g. Add 2 helpsers:
> > > >
> > > >   - vfio_pci_has_driver()
> > > >   - vfio_pci_has_driver_send_msi()
> > > >
> > > > This test would use the latter.
> > >
> > > Ack. I'll add a patch in the series to add these functions to the vfi=
o
> > > library in v3.
> > >
> > > >
> > > > > > > struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> > > > > > > {
> > > > > > >   struct vfio_pci_device *device;
> > > > > > >   struct iommu *iommu;
> > > > > > >
> > > > > > >   iommu =3D iommu_init(default_iommu_mode);
> > > > > > >
> > > > > > >   device =3D vfio_pci_device_init(bdf, iommu);
> > > > > > >   if (!device) {
> > > > > > >           vfio_pci_device_print_drivers(stderr);
> > > > > > >           TEST_FAIL("No driver found for BDF '%s'", bdf);
> > > > > > >   }
> > > > > > >   return device;
> > > > > > > }
> > > > > > >
> > > > > > > Because as is, this requires way too much a priori knowledge =
and magic for
> > > > > > > upstream.  The user shouldn't have to dig through code just t=
o understand what
> > > > > > > devices are supported.
> > > > > > >
> > > > > > > Ideally, VFIO selftests would also provide a script, utility,=
 and/or helper to
> > > > > > > identify BDFs for devices it has drivers for.  In my experien=
ce, binding a device
> > > > > > > to VFIO is trivial.  Finding the device in the first place is=
 more annoying.
> > > > > >
> > > > > > Agree this would be nice to have. Is this a blocker for this se=
ries?
> > > > >
> > > > > Yes.  As I mentioned to Josh off-list, I'm not willing to accept =
a "we pinky-swear
> > > > > we'll make this stuff user friendly".  It's not that I don't trus=
t you and Josh
> > > > > (and others), it's that for me, this level of user-friendly behav=
ior isn't nice
> > > > > to have, it's mandatory for these tests to be usable upstream.
> > > > >
> > > > > Internally we can squeak by with barebones, unhelpful tests, beca=
use the run
> > > > > commands are often hardcoded somewhere and there is piles of docu=
mentation elsewhere.
> > > > > But for upstream, none of that holds true.
> > > > >
> > > > > If it were weeks of effort, I would be more open to treating this=
 as nice to have,
> > > > > but AFAICT writing the code should be less than a days worth of w=
ork.
> > > >
> > > > Yeah that's fine, I don't think it adds too much extra work, and it=
's
> > > > something I'd like to have anyway. I just wanted to confirm if it s=
hould
> > > > be part (or merged ahead of this series) or can be separate. Thanks=
!
> > >
> > > So I need to add kvm_vfio_device_init() and it will call
> > > vfio_pci_has_driver(). Then, kvm_vfio_device_init() will TEST_FAIL if
> > > vfio_pci_has_driver() returns false, correct?
> > >
> > > Should kvm_vfio_device_init() live in
> > > tools/testing/selftests/kvm/lib/kvm_util.c?
> >
> > I was thinking the new test would do:
> >
> >   TEST_REQUIRE(vfio_pci_has_driver_send_msi(device));
> >
> > instead of:
> >
> >   TEST_REQUIRE(device->driver.ops);
> >
> > vfio_pci_has_driver_send_msi() would call vfio_pci_has_driver()
> > internally and also check that send_msi op is non-null. Both functions
> > would also log error messages if driver/send_msi is missing to help
> > the user, as Sean requested.
> >
> > And you'll also need to a patch to add a helper script to print the
> > list of BDFs on the current host that have a VFIO selftests driver. It
> > might make sense to send that as a standalone patch if Sean is ok with
> > that.
>
> That makes sense for setup_msi(). But in Sean's implementation of
> kvm_vfio_device_init() above, it looks like he wants the test to fail if
> there's no VFIO selftest driver for the BDF passed into the test.

Whoops, never mind. I missed part of the discussion above. We're only
requiring a VFIO selftest driver if we're using device MSIs, correct?
