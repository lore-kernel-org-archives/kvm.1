Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F3B3D1713;
	Fri, 10 Apr 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839423; cv=none; b=SVr4kxCGcZF8vyLPPF08cOyLR4A/nOQtfJalD4P+sBi30/V7LK90CcSgY7oaDCQ5llF8G7tAv0LOhhQ7t1EjX+KEZOLMyFFhgj723V9oxOIrG8BX5YWZp9lvkSv/InIPVnEytpHLmCXZ+gHQreK8REPTkAB6KyCeteKHW47HVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839423; c=relaxed/simple;
	bh=q2gcLhT+Qj3dNQFbdKg6lxbocNhFEHy/sYFcU4FEeBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj2Q4WMqPmZLEgpA+abT9BxdTDRSGepcZOwnEA3NEFYJGtJXHmHZ6L5vh3PXwtdsJc4vev4HVUp28KF7DtP4LhZU2ikUeXwkf8Rg5bfInkfq2mvpn8R523kYVLWjW9gwqmQjg9idIu9H7wi7NUllS2vUvCLhBPm+6pgW31Yjd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ovDvbWKR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REO5Lvli; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ovDvbWKR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REO5Lvli"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E4551400164;
	Fri, 10 Apr 2026 12:43:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 12:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775839419;
	 x=1775925819; bh=uXCca2TKucPBQBgDxEEHcFuIsd7g74Zut3zzG7h2A1M=; b=
	ovDvbWKRzKYzt9S2AWVuK9VVWe62Pdh5YjW89HtoWBt5BQGS0tlM0qyhRrE/pjAW
	/lLuSUhWlplKaWmGMQqakagULsQ8hClWh41k0pSStysKDANOBR8+Ga8heoT5ysMG
	gc8gvjYDR3hMVrIC3p0/ffF5dSpMaMoG3mGm2uEyRS4SGgETXHeHErMpXh7nTyM8
	rEgjQcut0h3IQk0HKt9QFKPj0nF59l0yJUREZQdy03WuJuSr77HrwkC8EKUxd3pl
	S95Uo1HWbqqFy98rxZhyrAF7qAAmoVa791m9AqIEQfThktt6spGw8ZZxSDxcJjyv
	u+SW6keg2ZDK9RaiyMWmcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775839419; x=
	1775925819; bh=uXCca2TKucPBQBgDxEEHcFuIsd7g74Zut3zzG7h2A1M=; b=R
	EO5Lvli5EqUzEbtImahKUSe9TVZds7fBCXA5cn5T1wQL7YZeNbXpG/vZuSFZjJ4J
	4AzE4bAm1hahYAZ9k82FFXcucwHsqooZcanZQf06vEsGUUjnF//M6waBmtp+FJfF
	Zsm2AQk2umK6BS/2K5QbTkVEm3olAATtW+frFTwhjkv5dnz9yRMKqK642HYMavQm
	Vz+VWgM6tZziCRgRguaZeBtlI0WM28+/mQRLnuAPcwuWPFneElvX9OAu+PDFSL4y
	cB+/RQTSd+30EjkwuZUUbJXBJY3LUx2KyGOyBy5PvjksPeba45uIT0Y/O6juxdtJ
	oIdB+5j7WEs+xFW/VahCg==
X-ME-Sender: <xms:uijZaajjk-Wtuf0XOBObkiZOzza2OX53_K8L8rHwErYWb-sVzl4oBQ>
    <xme:uijZaVD8SaJLognvNf4sABd-pG2vJcwe6PO2FRy4dHJdwjNv5SwY4caHAXveIQD6C
    4S2GUM9AGy9Ml2yz5lpA9YEvK5Jrrp2I54qiXa--uzdPIH3EfHT>
X-ME-Received: <xmr:uijZaYvcLrRCCrMwnn6iKc6Mpyg9FtircK8sGdFHzQXKcatLHl6dKW-7jzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepgeduvefhjeeufeevudeiueeuieeftedtkeevkefhgfdvteefleeuhefgtdeh
    fffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghnrghnthgrsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopegumhgrthhlrggtkhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepvhhiphhinhhshhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhrhhhilhhkvgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgii
    sghothdrohhrgh
X-ME-Proxy: <xmx:uijZaRfH9IyQuR2xEAPpF9gGOEqmmvNfeHe8ni0jB9-F_em0gTUoCA>
    <xmx:uijZaV-_Du3qOMUqYdEOMgC-f1HyyJcH6UTLGHaTjw062r_fZl5yEQ>
    <xmx:uijZacS1fi_byPbuFpSlRTDOs6k_TnM8CI09t_qb72y3NgqdkpIeBg>
    <xmx:uijZaWpRDyDw-V8XR7RGMzq-a5hnPXm2pvK7hsW1-f9nUhs2vyqdhQ>
    <xmx:uyjZaWLyrgVx-rYL-Y_9Gs4vOLWlqvX1ex-GextkjDEtZsmU7o8zqM6d>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:43:37 -0400 (EDT)
Date: Fri, 10 Apr 2026 10:43:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
 Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [RFC] Observed lockdep circular dependency in SR-IOV paths
Message-ID: <20260410104336.0159cfb6@shazbot.org>
In-Reply-To: <CAJHc60yiJEfKxyv=to+QWXxuGNyzMW9h7gqhOrC_tnT6M_D6nQ@mail.gmail.com>
References: <CAJHc60zTBn9xMksi-_UBK=W07rp2vGVZ9ToYhFyadNz4zCVHAA@mail.gmail.com>
	<20260406223428.GK2551565@ziepe.ca>
	<9eea53cd-77a7-474c-a552-92f3531f13b3@app.fastmail.com>
	<CAJHc60yiJEfKxyv=to+QWXxuGNyzMW9h7gqhOrC_tnT6M_D6nQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Apr 2026 08:46:30 -0700
Raghavendra Rao Ananta <rananta@google.com> wrote:

> On Mon, Apr 6, 2026 at 9:00=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
> >
> > On Mon, Apr 6, 2026, at 4:34 PM, Jason Gunthorpe wrote: =20
> > > On Tue, Mar 31, 2026 at 10:23:06AM -0700, Raghavendra Rao Ananta wrot=
e: =20
> > >> Hi Alex,
> > >>
> > >> While running the vfio_pci_sriov_uapi_test [1] on a CONFIG_LOCKDEP
> > >> enabled kernel (7.0-rc1), we observed the following lockdep circular
> > >> locking dependency warning: =20
> > >
> > > This loos more like a class issue, the locks used by the VF driver are
> > > different than the locks used by the PF driver, and even though the
> > > devsets are shared a devset should never have both the PF and VF.
> > >
> > > Maybe shifting memory_lock into a different lock class for VFs is
> > > enough.
> > >
> > > However, I think it is a bad idea to hold the memory_lock while
> > > probing a device, I'd prefer to revisit f4162eb1e2fc ("vfio/pci:
> > > Change the PF power state to D0 before enabling VFs") and change it's
> > > logic to rely on a private flag instead of pci_num_vf()
> > >
> > > Then we don't need to hold the lock any longer than just setting the
> > > flag. =20
> >
> > I agree, that's cleaner, only hold the write-lock on memory_lock in
> > vfio_pci_core_sriov_configure() to bring the device to D0 and to
> > set a flag on the PF vdev.  That flag would replace the
> > pci_num_vfs() test in vfio_pci_set_power_state().  The flag is
> > cleared without memory_lock if pci_enable_sriov() fails or after
> > pci_disable_sriov().
> >
> > It's a nice compartmentalized fix.  The lockdep splat is a false
> > positive, but this would eliminate the memory_lock ->
> > work_completion arc of the detection. =20
>=20
> Thanks for the suggestion. The pointer to f4162eb1e2fc helped provide
> context. Based on the suggestion, I tried this diff and we no longer
> see the lockdep warning:
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_core.c
> b/drivers/vfio/pci/vfio_pci_core.c index d43745fe4c843..f857a23c034a4
> 100644 --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -271,7 +271,7 @@ int vfio_pci_set_power_state(struct
> vfio_pci_core_device *vdev, pci_power_t stat
>         int ret;
>=20
>         /* Prevent changing power state for PFs with VFs enabled */
> -       if (pci_num_vf(pdev) && state > PCI_D0)
> +       if (vdev->sriov_pwr_active && state > PCI_D0)
>                 return -EBUSY;
>=20
>         if (vdev->needs_pm_restore) {
> @@ -2294,8 +2294,9 @@ int vfio_pci_core_sriov_configure(struct
> vfio_pci_core_device *vdev,
>=20
>                 down_write(&vdev->memory_lock);
>                 vfio_pci_set_power_state(vdev, PCI_D0);
> -               ret =3D pci_enable_sriov(pdev, nr_virtfn);
> +               vdev->sriov_pwr_active =3D true;
>                 up_write(&vdev->memory_lock);
> +               ret =3D pci_enable_sriov(pdev, nr_virtfn);
>                 if (ret) {
>                         pm_runtime_put(&pdev->dev);
>                         goto out_del;
> @@ -2309,6 +2310,7 @@ int vfio_pci_core_sriov_configure(struct
> vfio_pci_core_device *vdev,
>         }
>=20
>  out_del:
> +       vdev->sriov_pwr_active =3D false;
>         mutex_lock(&vfio_pci_sriov_pfs_mutex);
>         list_del_init(&vdev->sriov_pfs_item);
>  out_unlock:
>=20
> My only concern was clearing 'sriov_pwr_active' after disabling sriov,
> since the PF would still remain in D0. But from the f4162eb1e2fc 's
> commit description, it seems like that was intentional?

I don't see any obvious problem with that ordering, once SR-IOV is
disabled the PF is again subject to both PM and directed power
control.  Thanks,

Alex
