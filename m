Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714C47CA61
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776072; cv=pass; b=UWbJNhSwNabkUZAbHnTZc8LznnghA+3Q+XoFcVv1wx8+scI/uGGmHBTEAPd73DeHp/kyIKJIVKlRP9wqYZcPGdYwNsU+Q2vDouaUIIwo7TBvfW/TT5egBlAPr0WGcAfLCdE9FvtxSd1brTlJSkv/W6W3Lig4067iDLxflTxTzBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776072; c=relaxed/simple;
	bh=KB5Dt4NITSpAROcFBDNP6TJCJRL/uGFl7mc5zMZ6rbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7/5Of28aDhGcX6nvXpi/x4hYLIQQsb6Mwb4ZQirK3u0qt9Q/qbMIEG38fGJ2lsbJ0BQKppHzi6mFTo4pC8dvjBRH5UCIhkHqnhDX1MhY1zlWMQVC3R+IOHstMTKgw5HiKk8LktqpXMGT6jWjd6foE+mR1e7IcZZaDhET5r8UVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6oyIj26; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6oyIj26"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1677c91969so159736366b.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787776069; cv=none;
        d=google.com; s=arc-20260327;
        b=SKhqw+uq7x5G0vod2RBWw/lf+cYFAl+cXc08Oo0X9C+t2LLllBwMpWGvSWUJzn49Bj
         bdRNFS07RN4oiNkekh2itEdlM5ZdhCZV9rd1Kc8kaMx3dzuqn/qoEqu7HQtJdteg75nC
         Rgasy9V0WNk/e+Q2ltHvhl5lWbLugyK8daJJr/OAQCJCxMpzd9xck5Xi/GugsZU9uanl
         QmMapS4TqgkAs6jeUk77jNmciOxKeE01hDFRDFtupYdExviW1sjbN1FpMlYGnKIsa259
         0S26Kr64AWV0omCo+ZLFr82W7PxgSoAuuAeLmZ50ouooXGXpvwWp6QPyl2QDLi08dqB+
         KViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWGOH1354ZX/vY0l9xaAPBv85Hq+rgIf24RYb5RW08c=;
        fh=xRFR3tC69Cr5lt8zeiI8iSk3500GEnC7Fxb39igeTGc=;
        b=r9pBjpIxKj7jwIT85GR+nk+UPvsSK+1bHOz4VarJhExSolqt5L0BKtR3PtwP5iQ87O
         Z6Mh3uzK8IGqzx4Ihr+LSeqAErtjFgFFYxXmT6fWKrssawbeW+P+aiZuv6gHqlbzT5oI
         4Bh3021nTuGOB2UshcvJaw9U2Elr2aZcfoS+CN5lnBvvL5s+ZuuCvyLCzYbKE4c1KWgO
         y0MlB2tjO2ZOwGIu5XVeZWyTmIgkySQmT3DtXHSYCXRuNHQIVsNBWCTQntc2cq1n86Hx
         +3tAXgb5vxo9vfSdm5jogvnuYlXgB5fG7XEjhGqMMp5qtf+z0+3AtD7YEeQ2lhZtjAmu
         sq+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776069; x=1788380869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWGOH1354ZX/vY0l9xaAPBv85Hq+rgIf24RYb5RW08c=;
        b=h6oyIj26GbmIfCQagr/L5fQJb+1DKw/sinD4UuYVLMxXTInVgjycwM4K3xH5RlKdMH
         eNE+/FsCeFAcHDwdIb49GH6zNKF0wc4zyNYSXpPiwe0HUyhMo/jf5YYPsusQQH0PAh1n
         P2GIwWcjY/6ZD5UxT5xDVX0P7mexxlYBmlkas7MsHb/nLaTEj/GeBg6P0TM1k354aCr8
         CALtJv+9zLGAeL/d4ln4a8ipYN1ekmvMVCgGeUQ9j+fqBFFfcSLKXFl8oKxvEnMcD8kX
         VDw4eK4gQZJq5pOqrqVkVmdSgD0kAE3Y6GDLTf1aKxWk+fk/0hPffS6DfjF52efmj66p
         2dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776069; x=1788380869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWGOH1354ZX/vY0l9xaAPBv85Hq+rgIf24RYb5RW08c=;
        b=U1fGnjWKdzQosvI879DEIVqi9Z5X5WroIpJ33oNkDzCr4Y7/Vr1n6JCGKDngDV9Fgl
         0RmGaO6Iaf/sM/uCXxfuwZQnz/BfYvoItDMpinXFsaknsjxQc82+Me4eaE9uEE9mi+oh
         rb1EY3rkGsH97iSvpO1huaQ6lVRiBoplDTRhG9Uamy2vJL7lU5ZnY8jqrDbOz6N8VnOl
         2No6wKmb2lbH4tFYqdj+AYYPIFOX4iwWLf0VREgz0IMpBHZjd+Vvpd6m+IKtI6mO6WXg
         PuEjd8SCK3qRV2susvu2remv0IrfG84Rx1kIEQ7p8gew1tmKABXYoc5Yu12TSJEwcBl/
         lp4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrZ5IK0j0Sar2w0GSJZ/94tN/2RqJaBw5w4+531EQalINZUMZCB0qAdmrck2q3fqrlEELk=@vger.kernel.org
X-Gm-Message-State: AFuF++nvR3unXKbz03y4L1QfzXcXArLKriSMWwqlusjcP+NXCjO3MsE7
	3LbojSu+RpU2kTHAiuG3EheHHB6LA/5RPHCCOrCbfxl68svU/qzbGL1knT370OKlOx7SVT4doBx
	x9Jf5Fr4ZIs9VyNRghGszADNSeJ3w1b8817/YRaHZBYBvlUc85u8p60l1
X-Gm-Gg: AR+sD100ulG0lnk0vGnIJsNFnktx9tLKtWlUEyi26qLEbK3Xzom1zG7wP59oOmIR/fR
	XbbZoeOioyvxkxbm1/ooHiUeK23YryVVSNiYrpItJ6cBSu+HSEIBqTOf09Gjdh4ebXL68jymxCW
	gyklr20a+708NJgWKDSy5y71vkchuLkYO5HQF5tmGOcg39T8xLChp3AvjLEsy1AdgXNG55KxzsW
	kz4Qt0XhtI2AK8t0Y++jRJkqv/EEe2MtWNrBsDH598VQToXRRhbMR/50f/su2JZv20RaGo4fQth
	+eushkpjJyIcLN86s5c0OikYWHDrj5yl0ztNER3J3qdNKg==
X-Received: by 2002:a17:906:2081:b0:c25:2e93:28a6 with SMTP id
 a640c23a62f3a-c252e932fe8mr551532366b.3.1787776068231; Wed, 26 Aug 2026
 13:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com> <ao3nr1-t0DxANAyC@google.com>
In-Reply-To: <ao3nr1-t0DxANAyC@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 26 Aug 2026 13:27:20 -0700
X-Gm-Features: AcwNN1VJZs9sa1bllRivEAYyBKhodHBefcR6pQ8bKeL_D0Ssy2tWvugwTys94zA
Message-ID: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio: circular locking dependency in pci_dev_reset_iommu_prepare()
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-08-21 12:35 PM, Vipin Sharma wrote:
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > Potential Solutions Suggested by AI
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/io=
mmu.c:
> >    iommu_setup_dma_ops() only requires struct device * and the domain p=
ointer
> >    (group->default_domain); it does not mutate any fields in struct iom=
mu_group.
> >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->mu=
tex) in
> >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_type(=
) breaks
> >    the initial &group->mutex -> cpu_hotplug_lock dependency.
>
> Are there any other code paths that rely on group->mutex -->
> mm->mmap_lock ordering? If so fixing this one case wouldn't help.
>
> > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_fu=
nction()
> >    in VFIO:
> >    vfio-pci could zap active BAR mappings under memory_lock and set a s=
tate
> >    flag / disable memory decoding, drop memory_lock before calling
> >    pci_try_reset_function(), and then re-acquire memory_lock to re-enab=
le
> >    memory. While resetting, any concurrent user fault will see the memo=
ry
> >    disabled condition and return VM_FAULT_SIGBUS safely.
>
> This would change the userspace-visible behavior of faulting on a VFIO
> device BAR from "block until reset is done and the succeed" to "fail
> with SIGBUS". And it would allow VFIO to access VFIO device BARs during
> the reset through vfio_pci_core_iowrite*().
>
> But I think we can extend this idea to solve those problems by
> introducing a wait queue for tasks to sit on while a device is being
> reset.
>
> e.g. Something like this (completely untested and partially written by AI=
):
>
> From: David Matlack <dmatlack@google.com>
> Date: Tue, 25 Aug 2026 18:37:52 +0000
> Subject: [PATCH] vfio/pci: Avoid circular locking dependency during devic=
e reset
>
> Avoid a circular locking dependency during VFIO device reset by dropping
> vdev->memory_lock prior to calling PCI reset functions
> (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit res=
et
> state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to stal=
l
> concurrent BAR page faults and MMIO accesses during reset without holding
> vdev->memory_lock across PCI reset operations.
...

This approach does not look ideal. The implementation has a bug where
concurrent resets can lead to vdev->resetting being cleared too early.
And from a maintainability perspective, there are more call sites that
currently take memory_lock that would probably also have to be updated
to wait for vdev->resetting to become false.

> >
> > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
> >    Evaluate if attaching to the blocking domain and pausing ATS during =
device
> >    reset can be protected using more fine-grained locking or atomic sta=
te
> >    flags without holding the coarse &group->mutex.
>
> I don't know enough about this part of the kernel to say, but this would
> directly address the new lock ordering dependency vdev->memory_lock -->
> group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu funct=
ion
> prior to resetting a device"), which is what led to this lockdep error.
