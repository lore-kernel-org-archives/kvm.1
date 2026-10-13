Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE54E020E
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934573; cv=none; b=WyVfQCcTS2x+59dtZZ2xy30XUd0J/JAhXEFgTWd85t0GGXWdCLZ0OTz7aei9cC3D3lGwayAm70itcMGPd5VevoMT8hWiCTT1a95cggSyMmLBm1GdUaZOwUS8mw9rjjARYthFpe/k9Wlo+j91E9P2M/EHa7HxKa8aVNqYyA1ZwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934573; c=relaxed/simple;
	bh=gADedZsKcRbfxkB4gErajHcDd5G1aD0r+yZulXMWstA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AWe0zE6BC/iH3MIGQ2A2GkZwaHxsyGXVfh98dmQzr4y2pisOh0Qp0hb3bCoSZiNl6NU2yE7XzARb1Sz572pCSqgN4hXXSvWuokXnxOv7QGK8Olu3NgCn7h91lTQihkpx/MTBFf/zho9brHQ97dqkPk3nKnhaaVWTjwNcPfMHX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq2+IOJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq2+IOJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFC81F000FF;
	Tue, 13 Oct 2026 23:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791934566;
	bh=Zw7IQDy8VgW6NisTbEcXTF2QGSePVuoEg2HJIeuxmso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aq2+IOJI1np3GPxjPmAZ8upgUtPYCeOvCuSIU/2e/jIwnOSIGK/pOFXP+VUGpgjiQ
	 a22IeXj+kBKDSP1MnqjIKZf82FEzNVyjM6wghjtsc6qBtw+oHoGQk1c/nhO1v4svth
	 oDjJd1Y+d4YcYtZ7jcRJw74CXij2/AnbVUVrqoYdroRWXr+aQgrKJf5Dg3WaymHJED
	 Z/HmM85LFhkHSsSH5fBDyz40BRqIq/Mj+EKkye1ucxn/aHyCfVwtjfFwCuRw6CMvtg
	 7EaD2GoHhjJpE4SBekRLh4G8vwMMIv/b+S3XnHKwGIOFPpF0XJ8KvxsNyHeyOo3/hi
	 +7PyU9rxyov1w==
Message-ID: <sashiko-outbox-170641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/pci: read ROM via ACPI _ROM when hardware ROM is
 unreadable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com>
References: <31aa2fb273d7ff7ea535c74e0780e279aa9a119c.1791933554.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:36:05 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] vfio/pci: O(N^2) overhead in ACPI ROM read via recalculating size
- [High] vfio/pci: infinite loop in ACPI ROM size calculation
- [High] pci: NULL pointer dereference in vfio_pci_acpi_rom_read() when _RO=
M returns no object
- [Medium] vfio/pci: ACPI ROM reads truncated by unreadable physical BAR si=
ze
- [Medium] vfio/pci: ACPI ROM reads missing 0xFF padding
--

commit ef01db8fb34fde6cd15f6043dd6655f51df61bf4
Author: Michael S. Tsirkin <mst@redhat.com>

vfio/pci: read ROM via ACPI _ROM when hardware ROM is unreadable

Some GPUs (e.g. NVIDIA Quadro P2000 Mobile in a laptop) have a ROM
BAR that exists but is unreadable because the GPU was never POSTed
by the system BIOS. On these systems the VBIOS is available via the
ACPI _ROM method provided by the platform firmware.

> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci=
_rdwr.c
> index df88480876815..9bc0a7df4fd69 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
[ ... ]
> @@ -198,6 +199,112 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core=
_device *vdev, bool test_mem,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
> =20
> +#ifdef CONFIG_ACPI
> +static int vfio_pci_acpi_rom_read(struct pci_dev *pdev, void *buf,
> +				  loff_t offset, size_t length)
> +{
[ ... ]
> +	status =3D acpi_evaluate_object(rom_handle, NULL, &rom_args, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj =3D buffer.pointer;
> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {

[Severity: High]
If a system's ACPI BIOS is flawed and the _ROM method executes successfully
but returns no object, acpi_evaluate_object() returns AE_OK but leaves
buffer.pointer as NULL.

Will this unconditionally assign and dereference a NULL pointer via
obj->type, crashing the kernel when vfio_pci_acpi_rom_size() is called
during region info ioctl?

> +		kfree(buffer.pointer);
> +		return -EIO;
> +	}
[ ... ]
> +size_t vfio_pci_acpi_rom_size(struct pci_dev *pdev)
> +{
> +	void *buf;
> +	size_t size =3D 0;
> +	int ret;
> +
> +	buf =3D kmalloc(0x1000, GFP_KERNEL);
> +	if (!buf)
> +		return 0;
> +
> +	do {
> +		ret =3D vfio_pci_acpi_rom_read(pdev, buf, size, 0x1000);
> +		if (ret > 0)
> +			size +=3D ret;
> +	} while (ret =3D=3D 0x1000);

[Severity: High]
Does this un-bounded loop rely entirely on firmware behavior to terminate?
If a buggy or malicious ACPI _ROM method ignores the offset parameter and
always returns a full 4KB buffer, will this cause an infinite loop and a
kernel soft lockup?

Additionally, this loop evaluates the ACPI method repeatedly in 4KB chunks
to read the entire ROM just to determine its total size.  Since
vfio_pci_acpi_rom_size() is called in vfio_pci_bar_rw() on every read,
will this cause severe performance degradation?  For example, reading a
128KB ROM in 4-byte chunks would execute the full ROM reading loop
via ACPI 32,768 times.

> +
> +	kfree(buf);
> +	return size;
> +}
> +#endif /* CONFIG_ACPI */
> +
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *=
buf,
>  			size_t count, loff_t *ppos, bool iswrite)
>  {
> @@ -215,6 +322,14 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device =
*vdev, char __user *buf,
>  		end =3D pci_resource_len(pdev, bar);

[Severity: Medium]
This sets the hard limit for reads based on the physical PCI resource lengt=
h.

If pci_map_rom() fails later in this function, we fallback to ACPI ROM.
However, if the ACPI ROM is larger than the unreadable physical ROM BAR siz=
e,
will reads beyond the physical BAR size be improperly rejected with -EINVAL,
even though vfio_pci_ioctl_get_region_info() correctly reported the larger
acpi_size?

>  	else if (bar =3D=3D PCI_ROM_RESOURCE && pdev->rom && pdev->romlen)
>  		end =3D roundup_pow_of_two(pdev->romlen);
> +#ifdef CONFIG_ACPI
> +	else if (bar =3D=3D PCI_ROM_RESOURCE) {
> +		end =3D vfio_pci_acpi_rom_size(pdev);

[Severity: High]
As mentioned above, is it too expensive to invoke this size calculation
for every user read?  Should the ROM size be cached during region
initialization instead?

> +		if (!end)
> +			return -EINVAL;
> +		end =3D roundup_pow_of_two(end);
> +	}
> +#endif
>  	else
>  		return -EINVAL;
> =20
[ ... ]
> @@ -235,6 +350,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device =
*vdev, char __user *buf,
>  			io =3D ioremap(pdev->rom, pdev->romlen);
>  			x_start =3D pdev->romlen;
>  		}
> +#ifdef CONFIG_ACPI
> +		if (!io) {
> +			done =3D vfio_pci_acpi_rom_rw(vdev, buf, count,
> +						    pos, iswrite);
> +			if (done >=3D 0)
> +				*ppos +=3D done;
> +			return done;
> +		}
> +#endif

[Severity: Medium]
When reading past the actual size of the ACPI ROM but within the reported
roundup_pow_of_two region size, does this bypass the standard VFIO
padding logic?

If vfio_pci_acpi_rom_rw() returns a short read or 0 (EOF), will this skip
the vfio_pci_core_do_io_rw() logic that safely pads remaining space with
0xFF, potentially breaking virtualization software expecting standard
hardware behavior?

>  		if (!io)
>  			return -ENOMEM;
>  		x_end =3D end;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/31aa2fb273d7ff7ea53=
5c74e0780e279aa9a119c.1791933554.git.mst@redhat.com?part=3D1
