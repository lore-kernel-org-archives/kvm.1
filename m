Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0B3AB272
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553883; cv=pass; b=K7Za8xOFiQs7S5mfrq+Ddx6XDO28/+iGlO2aWq1NaJxcTiQqwtQyVWJ+MNz+/xP/lOeWGyTFoQYV3AW63E9wXErVKJWCpIbZE7h9dYrtWdjI3Jx1mBsGkNrGWm7gJ+eXVYUspH1tP8Cdzay1xAirPfkPS58BmG+C7DIIAiwGWuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553883; c=relaxed/simple;
	bh=owPIg6ubh/DQddddT9GGtMkMgKnfwbpYGJjt+//AIJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JH5RSIE2hs4qVqsArckKYuwpECGNwPBF+9g3aKmUh2lB/XvEub5y7XRJuyIMsAGfJYEluHZnj0pQ5+6SnoUaDFcLZ6PzRjy6jnVBX5sr9khEJTk1rPJp41hSzSgu+JIkJHVvrP6Gxa/53Hrb18VmCCb1v/zZ7CmTQv1VCIG3FI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQ9th0dP; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQ9th0dP"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1384eb94d20so6478954c88.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 13:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781553881; cv=none;
        d=google.com; s=arc-20240605;
        b=g8iT9NiAEqZvMPMPqh1vSMAyEKtBmim2+T4FpKJfuN4BDKbE8bB6sWWawPg5dIHG1j
         FmynaWymTQ4nIJ6J/dwn+2CXuefL4YGcOjuYz30xroI+P5trjxXP7kSvbbah+MMkyC5T
         y9Rwh9y01XScB9/fDG+tkIBFCqoQd9fylEOX1z0MFRh3d9FkAiptV8IXg8pT4pGuuTFV
         CK4tGY+bFXumhfGdTpofPwS3Il5iJ7+MGWQxximmUA7S4xSb5Sdnk62MFQdy5qPZda7k
         PYfXCWP6aCkGc+s7EppCeH6Zx9R5YmNxUaIdPW+7kDdIxIweDDaZErPVclXTWmNTQYtt
         D4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3cAuZhgye1IsU1gMrp56etonTXBcaPhEeVfCnENr6Q=;
        fh=SYYHd0rDUGyyxTR990/K4YUjsyWIV+D4F2LUP+ELZUo=;
        b=VHYqnzJ7leaISbH02xsh3/f4XXjThRySPbFyZ+l35Lr05NScw+sXUeOoZpGGRPgW6C
         D7Z+ELns6MFbQ+ZIA/zDjKx7Nj0bpV08SpUUG2HB681mC4amGkEqoR9HpnKNTgUNPUMJ
         Ld8UzRdfRPByEcxc7Lcc2N4gZyqg6GFsW27lck8rSyh2A5ie2LZPZkzSfaPx5K3/raRy
         Qv3VU6jwtoueALTeWWooAGAYuwcZ7daCopI9/lwb0K2kaOJkuU/MyrG7fnUsguL5rthQ
         28BfnEwRR2nIcvUvpy6610Zyt/GZ9l1WPslTTTX51qzsP63ABz+OsJ+RS2QP84W8Ty4i
         LkFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781553881; x=1782158681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3cAuZhgye1IsU1gMrp56etonTXBcaPhEeVfCnENr6Q=;
        b=FQ9th0dPCZ1euvtZjSKSOsud2d4asOiV/KvJ8cU69+0c8Px4UpH56FI93211d8MG0U
         fi95l6k6odeL17dq/a7YjVnQhcJQ1O2dl6ZvUYwTwVpEAIJdaBcbfFjBpJt7FZTetKtk
         5qTAsXb5lFcl7bJxlgcpILpWPVPgnVkW63OlGwjCKx8RMrynEkUVoC1ib+7Z5OiBxPgt
         fr4CV6YpNfTs+l/0ArdM2JEaWS7omf6kIESm/t9rALgQn4YI/9vkI0jydANw0tzzkZQl
         4b9iBgekjb7Oy7kDlBukmqKEc88w5mZXtoRk63ucc4aL++P6xcpxiMTzaPCVRzXJw5Cf
         cU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553881; x=1782158681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3cAuZhgye1IsU1gMrp56etonTXBcaPhEeVfCnENr6Q=;
        b=rn3U+mQ1quXjhvXvurcPYlrqLhnD/teeeaiyGwY2Sa9e72VQt8mroGy3H8d9KQT1qw
         tex5VNIqxeMOkgJFGYHiOE4eCwDLtqFhRp/ERxbovW0UMv9e7XynclrCzSv710WWvYBd
         EfXR5BkEa58WqLfwrqvYqU3bCrpuUAxGRFyj64zrtnMALbGFcITWDIDfhH3nKQmGDwD4
         hLqBDVrlmdbKSDo/QsfDd/4Bkmd8HaAGTQPiOiFCrcLcow3T8QnUxBtt5v1/r+RhVczx
         Sj+8JUQvJFTTN9WtleKLYGdstZXpmVRI0gpldIl3nz0FTjoqabu3Qu48uk6YrN20W+yT
         fxbg==
X-Forwarded-Encrypted: i=1; AFNElJ9wjDoHEZFxlbW0TBXakoc5PkCfQ3nACYVT7tdCxagzL0OMgH7NbAyPZQsNLjbkW2Xdn88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcf2yYpWVTS/JGdRs4/u23PVn5EfIlYCgQG8HyjDt97osFVmRo
	o5US60eT6C7vtI8o1ZPGswYpvHAg890738saCTMp71S92hMbcrDnUGzoZfC8+iJOpSSFp6b1qUd
	u8h/46INZQqrHwA4icr0Szu0RCs/h5Q2EfJShSXaS
X-Gm-Gg: Acq92OFT6LegjX7gxAvrtSK4hkj0oNIxJM5SZiND0F7gb3Ltf6B/MqGx7H1+e6uI+Co
	hLd9igaJQAbJEpHkcStsrpvuMQeKCikBluz5s9c6cKajFLlXjhiRn2DQuUu1+eg0mxQ992I6+4r
	DoTdxGkm/8/NcY8SOFaVOSyw/2FVjFt8S296kahoONH65hRDx6WpAx/bHY3Z3Gl08bWwiLA18Sf
	r6e5b4w2dbvNQnG7G25Emufhldr3ZikO/o7cJyJuEm3oKpXXHw6LZh1C5lmWAJaa7LUsWVkcvnp
	+uPIoHRyryViOSnw/A==
X-Received: by 2002:a05:7022:30d:b0:136:d421:9efa with SMTP id
 a92af1059eb24-1386f38f398mr6171219c88.32.1781553879982; Mon, 15 Jun 2026
 13:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613002031.745413-10-seanjc@google.com> <20260613003501.DD5951F000E9@smtp.kernel.org>
 <CALzav=fsuDxGViwyFmhR1RmQKugR_tcj70gmq-492thdxJTDPg@mail.gmail.com>
 <ajA-5IQ3R5ZO1rSi@google.com> <CALzav=fQ5FENWgGNEqQrmb-i_9fWTRhLXj2-jZKC_zjM3Kg6PA@mail.gmail.com>
 <ajBQ3YEAMyKnJWYb@google.com>
In-Reply-To: <ajBQ3YEAMyKnJWYb@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 15 Jun 2026 13:04:13 -0700
X-Gm-Features: AVVi8Cd_8D6rihsAKEHaL9-XhAcm___nO2rBi-Wv8z6QEvOUnZocWEMFIMLJIV4
Message-ID: <CALzav=efwGdF+q1-_kMREvshbYTqWT4P_+U6Vs_brktvWub09g@mail.gmail.com>
Subject: Re: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:22=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Jun 15, 2026, David Matlack wrote:
> > On Mon, Jun 15, 2026 at 11:05=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Mon, Jun 15, 2026, David Matlack wrote:
> > > > On Fri, Jun 12, 2026 at 5:35=E2=80=AFPM <sashiko-bot@kernel.org> wr=
ote:
> > > > > > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/tes=
ting/selftests/kvm/irq_test.c
> > > > > > index 9f8895b898214..6888be54ee4a9 100644
> > > > > > --- a/tools/testing/selftests/kvm/irq_test.c
> > > > > > +++ b/tools/testing/selftests/kvm/irq_test.c
> > > > > [ ... ]
> > > > > > @@ -55,6 +58,36 @@ static void *vcpu_thread_main(void *arg)
> > > > > >       return NULL;
> > > > > >  }
> > > > > >
> > > > > > +static int vfio_setup_msi(struct vfio_pci_device *device)
> > > > > > +{
> > > > > > +     const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> > > > > > +     const int prot =3D PROT_READ | PROT_WRITE;
> > > > > > +     struct dma_region *region;
> > > > > > +
> > > > > > +     /* A driver is required to generate an MSI. */
> > > > > > +     TEST_REQUIRE(device->driver.ops);
> > > > > > +
> > > > > > +     /* Set up a DMA-able region for the driver to use. */
> > > > > > +     region =3D &device->driver.region;
> > > > > > +     region->iova =3D 0;
> > > > >
> > > > > [Severity: Medium]
> > > > > Does hardcoding the DMA region's IOVA to 0 cause IOMMU mapping fa=
ilures on
> > > > > platforms that reserve or restrict IOVA 0?
> > > > >
> > > > > If IOVA 0 is unsupported, it seems like iommu_map() will fail and=
 trigger a
> > > > > test assertion crash instead of running.
> > > >
> > > > This is probably fine for now given the test is only for x86_64. Bu=
t
> > > > if you are going to send a v8 you can use the VFIO selftests
> > > > iova_allocator to fix this, instead of hard-coding.
> > >
> > > I'm confused, why is this test setting up a DMA-able region in the fi=
rst place?
> >
> > There might be some devices with which you can trigger an MSI with
> > pure MMIO. But most devices you need to at least set up some
> > descriptors in memory that describe what action you want the device to
> > take and then use MMIO to poke the device to read the desriptor and
> > perform the action. Reading those descriptors is DMA.
> >
> > For Intel DSA specifically, send_msi() works by telling the device to
> > perform an 8-byte memcpy and send an interrupt when it's done. The
> > driver region contains the descriptor for that memcpy, as well as the
> > 8-byte source/destination buffers the device should use.
>
> Ah, gotcha.  For a comment, how's this look?

That looks great!

>
> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 6888be54ee4a..9a495fdb52f5 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
> @@ -67,7 +67,12 @@ static int vfio_setup_msi(struct vfio_pci_device *devi=
ce)
>         /* A driver is required to generate an MSI. */
>         TEST_REQUIRE(device->driver.ops);
>
> -       /* Set up a DMA-able region for the driver to use. */
> +       /*
> +        * Set up a DMA-able region for the driver to use.   Very few dev=
ices
> +        * provide a way to arbitrarily send interrupts (MSIs), e.g. by w=
riting
> +        * an MMIO register.  Instead, most devices send MSIs when an act=
ion is
> +        * completed, and practically all actions involve DMA of some for=
m.
> +        */
>         region =3D &device->driver.region;
>         region->iova =3D 0;
>         region->size =3D SZ_2M;
