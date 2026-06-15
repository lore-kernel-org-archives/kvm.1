Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00B407CD8
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539038; cv=pass; b=fSJ43Lu6ekBkRlYHH7mRuTGGGppuBBqFA65X+ml+cNg9Kd90PwKxv61j24fNl0AWEdRabIRnCjq+t7zvjYrVVXquWV2ndD8R8+3C+B49PgxcAcn6Zni3eoJJctGB/+3negvYTPH/rla/JJ9ThW2pk3WNScpjzXQW+reS0R109EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539038; c=relaxed/simple;
	bh=I37MB9QFZWg/iySQ+8norqI1EgSDbMtxgGAg8twF0Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhooCsVSK3dDCrgDgKv51wQhYdRmstktMQG+8x75TmNMNZ3Oz9DpCSPQXHvM9/C6Mx+fpkGYO57As21hRpGWfySMY9QsumPJb3G1YUCT3KTlrqQsrOZDyRUi1InPK7VJXKCf67/h2s/xaWPgEBwqK1o2xhL1d2jxVJw75WytuKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VD7AbqmI; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VD7AbqmI"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-135e7f4a295so1893699c88.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781539036; cv=none;
        d=google.com; s=arc-20240605;
        b=VG4CqywLBQHzt3kYvk7Mu037kFXhq/Tc3IwX91P0g2MbRS6qJpx+40jxGo8rmkEi9i
         ZUpjirlvlQmqyagpdQrlRTxXP7SWaJhW3hqehkvB5Mz+5JOWWlTnlUmcSKde3VnHK3ar
         8ULIS2qQhXPWs8+7tHvPrQ9EpysTu4mZJtD2dtfagd6Q5+Lfn51RTPGn5w9PNY6Kdkfd
         hi/DF0PGV0Ua7KzlaTkg/lWAL68v1vFSsLRmQIagXFYyPNXudz/xTL1jRv+JKjeV0s/v
         gshtwiQWN14UyR3Lf+eiYZJ7759MhybHW3R9ELMiiEwW+ZeGXN46C0AJXGWxjcYYij+g
         ZDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n14dIJ5dht73f40pb4IMJ7S3kt8QyoHAMkgZkWPngd4=;
        fh=HG2JbF2vnntTlfCpnaVfj/kRSyESDJFJyDnyOsJaVWw=;
        b=bHPu0lw4lq+lZEiLali92dZKdqyMsnv+gkWd9rKPVIMTwSZ+6t5xSVjI13tFsXGKNK
         Wqb3fTddxQJb69eWTuvT2XOfI9wasjw8stKIKEy+5AuZVyVblFvBmiPugG4nlpbPpdhL
         LJug80Suu2RWgG4rpVk0advsq8P1veCwxWrZwSXYzFGMyO7l5mqgFZWHAQnYqik/VjLB
         qTRy8RMHN146UOJze58NcwqGMxABgLvQHGHBRW57yezllH1ElYklmr6w/ShzUIHLD89Q
         G68E68HyIp52sBpN2y5ZlSILcT5qfkFyNdQOb600njtj/Hz9588qmZsY5IwvU6/TdRKX
         3VkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781539036; x=1782143836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n14dIJ5dht73f40pb4IMJ7S3kt8QyoHAMkgZkWPngd4=;
        b=VD7AbqmIFc4Idh6kIiPaqxlO7MuVLMcx78Y7iwyObz+vC1K+0eRt9bJFxuafyKQsFx
         9yk2jh2RIBsIa5mnG+gteaNDxF2oBRbWQzRQ9goRyajj7dl3fJrEv5xlRHJeYL/wAzWQ
         VIft3z/WeK2lApMiCX3E6aNe6KevzZWowpPZ3jcuFM417gyuzMjliRGyAugCyIVoKyJF
         +QdHV7rHzSttHV+xa66UAE7JUY1v+DxRPZunYxVpSuJfwcbro/O/HQ0KXb7J77QtbsPY
         f+Cxo12VoM1IRyfCLA4JzjSgNoySS0l/PnMH8ZqKG4/jECzAGTMV2clZX/QoIUMw3Ibi
         tUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781539036; x=1782143836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n14dIJ5dht73f40pb4IMJ7S3kt8QyoHAMkgZkWPngd4=;
        b=hPsg2NgCEYaKvkaU/C8OCrvfNSIvak5wrq3SpgTDJ9H8Dy433r+sepQhhD3ivSyvjP
         F+foOLkrZclmthSo6Seiv2pbnPQDUmrJe5h8lN5NYsbbp2FT/oGfN2wfekz3PKUAjupo
         ITzfofei8eWu+dMj6+EB30hF1W/U7wmQi7pojpiNW5FiP4fleXk5h83Dz8m/IU4o3Fnf
         +AjQjvQutomqlM2KUtnm3mDOJ32LtDXeJq5WODvzM3gYZ0plBDx+QD6ab5Ej0UG5j7HE
         GNsf81+A9q4EpgvMQXWmhqgNM+9z8m6hoA2oi84xYjDpd+tI5wX6wChs3RZgZk2RhBRH
         qC1w==
X-Forwarded-Encrypted: i=1; AFNElJ9V3lPqwYO8gIW1k0YtDprBQPIwvklcbelea0H2r2IS4Q+WJUv7+EUu05VeIddCCK7mcX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtN2COdJC397NVPH8z2aRSTCudzzifZbAtvFTrbO0+2pAwi9G
	GA+R4FAI/ghBEaHxXd9DmJqIrl5evJ9qFyGijwgZbgjAjuatkQkUNwUEukHH71Fs2Xy3ZMgx4bi
	0HUIFlQQ6b+Xk+/Im5XdSnXOvTIJqRPFcRH0c8ZOP
X-Gm-Gg: Acq92OH0CykhjK3h07CiyYMkTBLhHQT/D82eEh5gsRNGVUv9yXTQCBmf2zCmfX2o3qK
	zKKjbmok4wVY1ZCWKPZk82j51VDHRylZFzaMwXnQoYYrvqawCZVU8SXEXxta4KDNfBvlwOnR7/O
	f5nCfSKuvTGM6sL2iHHxubLc6AAAL7lyXfDSknw5/9/4Me6os6aDxCe8ixqCNOLf9bH9VIWydb7
	6SQo5SzGR0fb+JiPYUOJH4W1idWijaTe/bXGvV5arUsjCUyLgUO3vDGXE2W3Mm4t/O2YBkF8xgV
	+twczAc=
X-Received: by 2002:a05:7022:4a7:b0:12a:6abf:ab1c with SMTP id
 a92af1059eb24-139857e5543mr28154c88.11.1781539035442; Mon, 15 Jun 2026
 08:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613002031.745413-10-seanjc@google.com> <20260613003501.DD5951F000E9@smtp.kernel.org>
In-Reply-To: <20260613003501.DD5951F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 15 Jun 2026 08:56:48 -0700
X-Gm-Features: AVVi8CekucRmafRLaV5f36SS8Dg8ifzasU0WhAhm20QRKJwpK2-KPAIj-ny6Jk8
Message-ID: <CALzav=fsuDxGViwyFmhR1RmQKugR_tcj70gmq-492thdxJTDPg@mail.gmail.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
To: sashiko-reviews@lists.linux.dev
Cc: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 5:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] probe_iommu_type() incorrectly probes the /dev/vfio directory =
instead of the /dev/vfio/vfio legacy container character device, bypassing =
the framework's intended skip behavior for unprivileged users.
> - [Medium] vfio_setup_msi() hardcodes the device's DMA region IOVA to 0, =
which can cause IOMMU mapping failures on platforms that reserve or restric=
t IOVA 0.
> --
>
> commit 2bdd8160743775c8d18e4004e72e7ff0898fbd70
> Author: David Matlack <dmatlack@google.com>
>
> KVM: selftests: Add VFIO device support to eventfd IRQ test
>
> This commit extends the eventfd IRQ test to support triggering interrupts
> using a VFIO device instead of manually signaling the eventfd. It also
> probes for IOMMUFD vs legacy VFIO availability.
>
> Link: https://lore.kernel.org/all/20260602222941.3133236-1-jrhilke%40goog=
le.com [1]
>
> > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/sel=
ftests/kvm/irq_test.c
> > index 9f8895b898214..6888be54ee4a9 100644
> > --- a/tools/testing/selftests/kvm/irq_test.c
> > +++ b/tools/testing/selftests/kvm/irq_test.c
> [ ... ]
> > @@ -55,6 +58,36 @@ static void *vcpu_thread_main(void *arg)
> >       return NULL;
> >  }
> >
> > +static int vfio_setup_msi(struct vfio_pci_device *device)
> > +{
> > +     const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> > +     const int prot =3D PROT_READ | PROT_WRITE;
> > +     struct dma_region *region;
> > +
> > +     /* A driver is required to generate an MSI. */
> > +     TEST_REQUIRE(device->driver.ops);
> > +
> > +     /* Set up a DMA-able region for the driver to use. */
> > +     region =3D &device->driver.region;
> > +     region->iova =3D 0;
>
> [Severity: Medium]
> Does hardcoding the DMA region's IOVA to 0 cause IOMMU mapping failures o=
n
> platforms that reserve or restrict IOVA 0?
>
> If IOVA 0 is unsupported, it seems like iommu_map() will fail and trigger=
 a
> test assertion crash instead of running.

This is probably fine for now given the test is only for x86_64. But
if you are going to send a v8 you can use the VFIO selftests
iova_allocator to fix this, instead of hard-coding.

>
> > +     region->size =3D SZ_2M;
> > +     region->vaddr =3D kvm_mmap(region->size, prot, flags, -1);
> > +     TEST_ASSERT(region->vaddr !=3D MAP_FAILED, "mmap() failed\n");
> > +     iommu_map(device->iommu, region);
> > +
> > +     vfio_pci_driver_init(device);
> > +     return device->driver.msi;
> > +}
> [ ... ]
> > @@ -74,11 +107,29 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 g=
si, struct kvm_vcpu *vcpu,
> >       vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
> >  }
> >
> > +static const char *probe_iommu_type(void)
> > +{
> > +     int io_fd;
> > +
> > +     io_fd =3D open("/dev/iommu", O_RDONLY);
> > +     if (io_fd >=3D 0) {
> > +             close(io_fd);
> > +             return MODE_IOMMUFD;
> > +     }
> > +
> > +     io_fd =3D __open_path_or_exit("/dev/vfio", O_RDONLY,
>
> [Severity: Medium]
> Because /dev/vfio is a directory, will this open() call succeed for any u=
ser
> with read and execute permissions to the directory, bypassing the intende=
d skip
> behavior?
>
> Should this probe the /dev/vfio/vfio legacy container character device in=
stead
> so the test can skip gracefully for unprivileged users rather than crashi=
ng
> later in iommu_init() due to lack of device permissions?

I agree with Sashiko here.

>
> > +                                 "Is VFIO (or IOMMUFD) loaded and enab=
led?");
> > +     close(io_fd);
> > +     return MODE_VFIO_TYPE1_IOMMU;
> > +}
> > +
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613002031.74=
5413-1-seanjc@google.com?part=3D9
>
