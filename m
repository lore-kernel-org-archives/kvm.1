Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C13B6356;
	Wed,  5 Aug 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942213; cv=none; b=BmUX6jIaWdeEVJACVrSHa4lDrqLOLLDEZCG7/dTjMqnEv832F4BNmJeknFdM3skWaUyMRKHgHfq6As0M9VOmLiTW25UjGEwQZIkoMWOPrrO8TojhvoHAvQdImB7sDJe7xlJjLx87ikhYq1tXzxl3wWYOy0x5AUrJHnbFM7s793A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942213; c=relaxed/simple;
	bh=I7aePYUIG4BFdgEDFWj6xIpf4oc+PMrZ6XtBS6g8VPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loR7zaBajy/NNjpuShgXORmp9ClY7b72bDoJn4A3HyIqvDXKHl1PIAZpFA9rKqkbVVBQd6xnc9sGzE8SWni5LHfb0hPmE2/tLlf9K7aWagnkdlVUB4n7FuJWKpytBXvMbvUUodVLBiyS/4kWtnZcoL37tWsVx+SBOoxpSSh1QSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=gGm7/nu8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mpKGu/u/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="gGm7/nu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mpKGu/u/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B52F47A015C;
	Wed,  5 Aug 2026 11:03:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 11:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785942206;
	 x=1786028606; bh=TUsrbgP/JWNiomNHn14rg5Mzaihuw2O7tBE8a4VSyxM=; b=
	gGm7/nu8haPxZ0Nwvz2scE6aXlEVI+U7ZAhYOaCDNW+mgBncjnxh3egjNdgojmbp
	79tnsG9IE0qc9OVcFTNfOiOtc12SYgC5XoLJnXhUPck/K0OEEDPZM9vm8MdCKizl
	l0uZx1BdXczlZ+L7Pxl05RveoaOkD9YHIU8U0N/JfxjBiORx16KwBzpA68KHGgNZ
	vuHifwA410kry6otbTtb7d1KiQ3rmGgsPE6SWu0SFgO3tZJuwgDR7D0GFrcQh70L
	tW+9QITVtjI2IuHejVsQpB+efE7ptxf1D6Lwpam3AyvXc7NTWBRRbf7GvDDNNlM6
	9FiDgE9F3nTkU58erN9RgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785942206; x=
	1786028606; bh=TUsrbgP/JWNiomNHn14rg5Mzaihuw2O7tBE8a4VSyxM=; b=m
	pKGu/u/g2jxza9KM/bnPYZPRz/m1+IuGVLxn/brTQgApq01a0o8QuFwEQqijbroM
	YodifxUS8ZPOa/ty47IAbkLmpcajvgTM1ptrwBqREwhWahkCQIsCSPrPMHR1/FUP
	YcOLUqWXuzXVSKtkKmnCPg+jLT+rx7oyPIsi1gxGI9ZUdYgz4VSx2HqMdmzTdFsR
	3ti8d+23A1wE0KnGilRo0ANT4AsQfNGHjkhCf3JpJEv0/IPvvSR6VGfWD9ABNeSA
	DbvixaQgIgtvSG99e8ygD0zqZZeg3dDcj1seQ5wJ13TT/haiXdgbtFVrom5jhwJA
	Q379XqT2zYPbDajcMPF5A==
X-ME-Sender: <xms:vVBzatQCGyT3xf5t42Joaz-ZiDNPAEukrFq36mB4OEzBDOvON-Tzig>
    <xme:vVBzarthByV5oxBgFeOLphhRMOQWxpbJb7Itpbt3BDrrYqOFUDipy_TiE8xf459Xy
    t3mwzDocA6SosIr04RyQ3asye3KgkjThjLaFoP2fzPDmmgQdK-ayA>
X-ME-Received: <xmr:vVBzanHO1inIK4RLHyCh-KXMnsuNzAw3Py-eTSrbcY4vRK491SsIqgrmygdV6A>
X-ME-Proxy-Cause: dmFkZTF+4Ov8C+HdZnyTfQD7gDHz1fWNgkQPOeCD+wkXV3Cl6xh49Lme4GZAwDjXinHsKZ
    3gFTABlBGESg8bq2oIpwdYJK/+QpbV0vUn0O02VKW4FFBcrct2tlQA9LSodmzb5CEWMbiF
    W0UxkP6pofbBb0DjBMafDprtW/oGXIKbFs4JJGYsBPodQnT91Ics7Qor66MKBXVMcGoA08
    KTvPJbdNbqKJup44U8/mjHa1L2tDtjs1EB71VchEhbET4aV1hcJPgS12YvdubcwF/V4rSg
    5kE2Cs71swI9IksWdFLwvSkP6HijQag4sXIwYaxfu86hEKCXPJv4KAHQ1rVWfoHRgtZOag
    JBGlcbOHwSsgmxrSElAHQSL9BsdG3kL5ZB4XNEMsXPducpOlEAxM8KpRGoo/afh+Wz1T4S
    78ay0TCJDEn8XV3QIGt/3g1RkZoSnIiNdc7JUfCktpXoQ20aEaUwhfFpbiPvAZaH5TzroE
    SU9erfxGXRMRAhsLxwji6a6ThJ+c3Jn4yD8KnejM3vhxTDaS/+RLxNRQG78kQqwuhw0e8h
    RtHWx52ZVaiX72o22nc7lmaKbo0CSBea2uKeKqjOp7G5O1oMeLFU/vCUvhEPMWa/PgQQcL
    VmWLG0AucgXE3yBzsYD84fz1L09YWBicbq/IO4dsSsty7rJTc9DVmyNMxUsw
X-ME-Proxy: <xmx:vVBzakwivS2ahbosZtvHlxojXSNAYliCmqBIf5dLs6krCz50PIENSA>
    <xmx:vVBzap3ebrUcOZ0VnPOZm_PWqlNz1XheXj73tHEjghrH8Hz7MsXv3Q>
    <xmx:vVBzasq9vbJlFovzakpm1mjtAMHu7KeI_BxFWqB3eUyl-TvpW8WyIw>
    <xmx:vVBzauWDKympasIXcXM9N2_ev7t_2y18XjoATvvPW9Shj0pH5xBoMQ>
    <xmx:vlBzahwRb2_CvCdJ7F2iNvKvVMrRvQO5v3rE_eaD4Ls3hVxp6dwI2Ygd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 11:03:24 -0400 (EDT)
Date: Wed, 5 Aug 2026 09:03:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, bhelgaas@google.com, Kevin Tian
 <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>,
 dmatlack@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <20260805090323.01b1a36f@shazbot.org>
In-Reply-To: <20260805003355.728299-2-skhawaja@google.com>
References: <20260805003355.728299-1-skhawaja@google.com>
	<20260805003355.728299-2-skhawaja@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 00:33:55 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> When userspace closes a VFIO device file descriptor, the vfio driver
> performs a hardware reset on the PCIe device to ensure it is returned to
> a clean state. However, if the closed device is an SR-IOV Physical
> Function (PF), it may have instantiated Virtual Functions (VFs) that are
> actively bound to host kernel drivers (or other vfio instances).

Wait, what?  We actively try to prevent VFs from a vfio-pci owned PF
from being bound to host drivers other than vfio-pci.  You need to
overwrite the imposed driver_override to make this happen and you're in
a very precarious security model to have the VF owned by a trusted
in-kernel driver while the PF is owned by userspace.
 
> When the PF is hardware-reset via VFIO, it implicitly disrupts SR-IOV
> operations at the device level. Because this reset happens without notifying
> the core PCI driver model, the kernel drivers bound to the VFs remain loaded
> and operate under the assumption that the VF hardware is still functional.

And this is a) why we actively try to prevent VFs from being bound to
native host kernel drivers and b) part of the vf_token negotiation of
trust opt-in that must be performed by userspace drivers of the VFs.
 
> This creates a state mismatch between the kernel's view of the hardware
> and the actual device state. Subsequent attempts by the host OS or bound
> drivers to interact with the VFs will fail, leading to unexpected
> errors.

The described model is not a supported use case, there are fundamental
security issues with a userspace vfio-pci driver owning the PF with VFs
bound to in-kernel drivers.

> Disable SR-IOV on the device prior to issuing the PF reset so that the
> VFs can teardown and remove at the software level also.

The below only accounts for the close reset path, not reset in general.
Also note that the SR-IOV model in vfio-pci does have a path by which a
PF can be re-opened with existing VFs.  Whether that's actually used is
a separate question, but this fundamentally disallows that design.

It's possible there are gaps that closing the PF can interrupt the VFs
and we need to defer a reset until the VFs are closed, but the behavior
here seems counter to the original design, and the use case of
in-kernel VF drivers is certainly counter to that design and guardrails
installed to prevent it.  Thanks,

Alex

> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a113c55845e1..b36c77eb3c40 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -826,6 +826,13 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #if IS_ENABLED(CONFIG_EEH)
>  	eeh_dev_release(vdev->pdev);
>  #endif
> +
> +	if (pci_num_vf(vdev->pdev)) {
> +		device_lock(&vdev->pdev->dev);
> +		vfio_pci_core_sriov_configure(vdev, 0);
> +		device_unlock(&vdev->pdev->dev);
> +	}
> +
>  	vfio_pci_dma_buf_cleanup(vdev);
>  
>  	vfio_pci_core_disable(vdev);

