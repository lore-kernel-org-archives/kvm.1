Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289C471276
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852217; cv=pass; b=lt3vrxMs+b3j5lS7SQwfu8oWOUL0YWII+Ab+kfGIUjZ6bt3VO4KJCe+LQ6SzI9otdPc70TvpF+Ni/6FDDtLp0jZ0ySDT5Qoag5BzLdhkVwl3mlEVIdLxQumZnpenQA+k+Zf+4pejlECxaMjxFkemevb2eQ13LxKACQVWZfLiinQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852217; c=relaxed/simple;
	bh=zx9m3UJWLQKbi0/pNDNNX6lZqJj4z+ajiJa/RVGEIzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQRDTf5VB8+g1rWMpWumU/EWhmaflS+RFoBvXuYCoqnpZ6pXmfRrxsOewr84Svohb5U1zE7a0Hbir4DtKbS8nj6sStRi6jUEd7E54yMOibwE0AeQZ6N6kBJk8YHItpAB4NPcVa4VrtLFrt6AOmTBw7Aj4gXvWYuH4SYxYGd3YbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+xla7h8; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+xla7h8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1c26d7e951so22980066b.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852214; cv=none;
        d=google.com; s=arc-20260327;
        b=NnfHtwtZJo4z/1kZVyYdlj7V3rG57gRW1BeTLMQgf7dD+cUZFWVCfwFxH1KlaIec/l
         WMMwNstMZ0nfD5H8iKw5XfxnDEvhF9T7DDZnBQHqm0AFikfoPpxvQl+YN4Q520+Cr3N2
         5NWyjE8txxePQtJ83z3S9IuS4gzNzRvWv8IPnTSz/SGBVdzWjS5dBhRivW7Onm2jdDs9
         8HBunvlfl0ybZzUvNfap8aGxLmNLWKUXD5oPcnorMNRb9UBmfMyuv286IEC95r1QPKsN
         qVHw4YeebkSr4nxE6G5k0CbyiFCkIk/G3hd1jEooDAs4WcoEk533vCkPuVOHyBD4r006
         G2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        fh=KRbn5ot5ynLJ6qQ09+Or5aFU0q4RTk0hjtJ20m5NngI=;
        b=hslE4uSk50iVuu7RZUbpuHI+YOA0l10EiXPK7QjYzLieK0sf4QX/TqhmnwfBXhthxb
         dGg3PSEvKCmLFQzHA96H/A/pOHlcHPuzSWfcU2WlFG+CD26AOopEUqDUbEmpgPTw2waI
         ZzIPisdJXlpsjaPNVgD6QwgegoLO8jeXAqvmQmCbNC8b6fSx8SGESCJw9+4bp2TqkOwV
         op8+D3e1ejBJBqom4diu0sc53O/DCHJD8N9ZVfcj/3weyQKsCSOcQLnF15FFnVw0Vpcf
         kELAEXYXloOl6kUyhTDZKah7RNplxuqDbjvBtN/0IzMwVagRPhoFOguZuxoGNggWINhJ
         FTMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787852214; x=1788457014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        b=U+xla7h8Ps5Awr0Q4pOzTefLwg0sL6LhPl5rt1akFAS1W5K2Mr66/1cW9oZ63whvHF
         /oFsZbExUUJjfkPTrmY3LjtatTvOBH0B0enpey5hQEkpv++yw4fbLUk7V+Dk3inzOP1w
         0QX1MjO3ITThr8PJg3SZ9Aoh3kPlnGM11iICYIVu7rDnuGkGQau2mn6Mxp0J1A+t6D0o
         Vklsj4LR+LqXoTPtJG5nPlGDlmwDDniLu8YfX532ZeS0XlIiiJXicDjHiII5A0G68dU6
         uqXv0+SDPg2sageLB/Sf3QnMTjfwLV6TTuKBYDC9sw+Qbr48LL5hYMpMJK9SteXlMyjK
         Hd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852214; x=1788457014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        b=Gjw7W9i/6VyGG3z/uSfdqc5bOOxC6MrON9E5JjGi/nlxCNE+/JMhCkceXZV/VsxsuH
         H9i8mu8GXeoVHwqNirW3ey1An7Pj32UQWN7bKM2Ay/k9Yz0vB3f9xy9/QS3auHfTI0RX
         kZ9TAyUCrX2m+Di2kh3m67H4gpQZkZjUm25zfDx8yhfH3DfDy+8Np3cbqsk37Qn6X7bt
         rutAvzIj9xCovTR2kcLONf7r1FDonChXbReZBverSickhICm2BT3WPXHcTh5ElA+4HM8
         MnlmufR9UZTsiuLn/WVpUt931Rt165Nl9PMY/SlQny08sTSsXgP+/fDvvyzSG/f5Yaie
         Ay4g==
X-Forwarded-Encrypted: i=1; AHgh+Rp2NbrCpDQMVxEnPy/038ymh+ZSu4Kchwcr1CoqAnPNmO0g+CWvryY8JuFU2wp5ZjuY8t4=@vger.kernel.org
X-Gm-Message-State: AFuF++mTrZEnoZ+oa/+hmLG1Dsf+IUt/fEGYCptBnEou6QlK/Ogj00GJ
	vn3aiwjUgFszBOK4w3M9NEMYXDGFlT6/j51uYdz2HGdRarVYN7FJ/+kppREqnBsOaTm47gwRceM
	epHVhlVyWvU3ENY3QWZ2rfFPc6tqovgu7WpQIOaSy
X-Gm-Gg: AR+sD12oRGyckPOCaGIodG1fbx0F8xCbpHCXC2Laydc/FSJI2ipPyGuiHqZpzw/3yNL
	Ko9Av5pTYayrZ7T0YKcZW2TO8JargFH8I/VhH6r3x86jwNA4OzfqJf3Eexv6e78wnhsOfmpDeWh
	5sHzf9LtFhUZpOuGwz0zj/ERUSoGxuxTNUHncC3IKHjqydqWeI23NXLuC3rsj1Xp0UG8Z2c/IAZ
	f7j1LITX+z7iOFDL0r94bKnEY0/RRuDWKYunGAETXF61sGJi9NgGRWRemT9zj6TvUhUZtMEkK64
	594nS3H/TY3wWf8Y7hinopw+bDpkhNlp86eBvv5q9m5XHg==
X-Received: by 2002:a17:906:628b:b0:c1f:8021:deef with SMTP id
 a640c23a62f3a-c2556c61defmr29002166b.10.1787852213404; Thu, 27 Aug 2026
 10:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com> <ao3nr1-t0DxANAyC@google.com>
 <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
In-Reply-To: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 27 Aug 2026 10:36:25 -0700
X-Gm-Features: AcwNN1XNPft5Ueou-qlSyAtHB2c_Ktuq8wp3SGgI-T0tZ93zrinbZgmtLF9T5Xs
Message-ID: <CALzav=cEmjnYAZDS8Le_FkaZW1xE+pP1B+mks0Of85YWG-3_vg@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 1:27=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2026-08-21 12:35 PM, Vipin Sharma wrote:
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > Potential Solutions Suggested by AI
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/=
iommu.c:
> > >    iommu_setup_dma_ops() only requires struct device * and the domain=
 pointer
> > >    (group->default_domain); it does not mutate any fields in struct i=
ommu_group.
> > >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->=
mutex) in
> > >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_typ=
e() breaks
> > >    the initial &group->mutex -> cpu_hotplug_lock dependency.
> >
> > Are there any other code paths that rely on group->mutex -->
> > mm->mmap_lock ordering? If so fixing this one case wouldn't help.
> >
> > > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_=
function()
> > >    in VFIO:
> > >    vfio-pci could zap active BAR mappings under memory_lock and set a=
 state
> > >    flag / disable memory decoding, drop memory_lock before calling
> > >    pci_try_reset_function(), and then re-acquire memory_lock to re-en=
able
> > >    memory. While resetting, any concurrent user fault will see the me=
mory
> > >    disabled condition and return VM_FAULT_SIGBUS safely.
> >
> > This would change the userspace-visible behavior of faulting on a VFIO
> > device BAR from "block until reset is done and the succeed" to "fail
> > with SIGBUS". And it would allow VFIO to access VFIO device BARs during
> > the reset through vfio_pci_core_iowrite*().
> >
> > But I think we can extend this idea to solve those problems by
> > introducing a wait queue for tasks to sit on while a device is being
> > reset.
> >
> > e.g. Something like this (completely untested and partially written by =
AI):
> >
> > From: David Matlack <dmatlack@google.com>
> > Date: Tue, 25 Aug 2026 18:37:52 +0000
> > Subject: [PATCH] vfio/pci: Avoid circular locking dependency during dev=
ice reset
> >
> > Avoid a circular locking dependency during VFIO device reset by droppin=
g
> > vdev->memory_lock prior to calling PCI reset functions
> > (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit r=
eset
> > state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to st=
all
> > concurrent BAR page faults and MMIO accesses during reset without holdi=
ng
> > vdev->memory_lock across PCI reset operations.
> ...
>
> This approach does not look ideal. The implementation has a bug where
> concurrent resets can lead to vdev->resetting being cleared too early.
> And from a maintainability perspective, there are more call sites that
> currently take memory_lock that would probably also have to be updated
> to wait for vdev->resetting to become false.
>
> > >
> > > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
> > >    Evaluate if attaching to the blocking domain and pausing ATS durin=
g device
> > >    reset can be protected using more fine-grained locking or atomic s=
tate
> > >    flags without holding the coarse &group->mutex.
> >
> > I don't know enough about this part of the kernel to say, but this woul=
d
> > directly address the new lock ordering dependency vdev->memory_lock -->
> > group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu fun=
ction
> > prior to resetting a device"), which is what led to this lockdep error.

I sent a proposed fix that takes this approach here:

  https://lore.kernel.org/linux-iommu/20260827173511.2322549-1-dmatlack@goo=
gle.com/
