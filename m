Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085B52842B;
	Wed, 30 Sep 2026 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790047; cv=none; b=pi7IxUJsZUXfW7EcNnmhxTvVikUu0OvHQpXdoRArVP5hcVXI5PqHuUzjx7pKELrRRGu8wtnEsGv2XWlXUtwRo54NhRHu/vFChxBXoeTfUFoAHbTcDv9xuEGKJQLNsxAF8/ynivj8eVFSboUF28TDV/EGF0DBHoP9fQ45cR1OmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790047; c=relaxed/simple;
	bh=UFEEaU8VSNcczL2s8tDNC/map7bcN1duSucun+XsqFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OBUkEauNNTc+YJIcughPIBlxAecDw6Do7W+XIE98wMykxhgAMbqDJf1JCsczkvNisV0C7uscqC0XpDwMSK/3RI8nCACgG9jYEdTJz8XNKAhmdK2vSqGaifYhz+4rt7AwQId53HNKxXn0O0J1Bb08+JrNmbar37i5Rbg17M2w70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8nND1KS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8nND1KS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62801F00898;
	Wed, 30 Sep 2026 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790046;
	bh=YhVZFG5in0F6n1NwsGrKsPvZtMr7DkwLGnxnIpNEZlg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=V8nND1KSs7ybLY2op+fQghxOr6z/M2H1Wx2fmTCEEARj2nS4gfLwD8IcSVzzOk25W
	 1s3c7Kv6ko5uPGyMowgWPCi7DSeYS16Kd8gjGCasAP/Q4oK9k5khN6yRZf7nCpEVnw
	 eACzrS4+Am2jJ32wBEoFAaVqjai/a3GZw7cnE9Uo3uTfK5NFjZcBqVNTlw/ZyV/J8i
	 MXTTiR40Ozy0RY745BhfMf4zLYSLyIX/dRrYLnmycyX2Bol2DIM2m6GVb8Nbt/yoFD
	 nBHvuQnycd0xqcc7x1Ge+uDfscqdUpIRGOjSArQSXUbGq9H8KErvE8XfwU6G2eeYvZ
	 1VzxMQUyWJ9Gw==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 19:40:39 +0200
Message-Id: <DLSU375MUCEM.QQ89C9WM16H5@kernel.org>
Subject: Re: [PATCH v2 1/1] vfio/pci: Remove the core dependency on driver
 data
Cc: <alex@shazbot.org>, <jgg@nvidia.com>, <acourbot@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>, "Alex
 Williamson" <alex.williamson@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260930143641.4160785-1-xinmengs@nvidia.com>
 <20260930143641.4160785-2-xinmengs@nvidia.com>
In-Reply-To: <20260930143641.4160785-2-xinmengs@nvidia.com>

On Wed Sep 30, 2026 at 4:36 PM CEST, Simon Song wrote:
> vfio-pci-core currently has runtime functions that interpret pci
> driver_data as a pointer to vfio_pci_core_device, and enforce vfio
> variant drivers must set vfio_pci_core_device to their pci driver_data.
> This constrains variant drivers' private-data layout, including the
> typed driver data used by the Rust PCI infrastructure.
>
> Added VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
> each vfio variant driver, update vfio variant drivers to store their
> private strctures in driver_data and use generated wrapper to pass the
> vfio core device to helpers.
>
> Select the vga decode callback during vfio_pci_vga_init based on if
> vfio_vga_disabled, the callback only use pci_dev and does not require
> driver_data
>
> Assisted-by: LLM
> Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
> Co-developed-by: Alex Williamson <alex.williamson@nvidia.com>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

I like that this moves the PM ops to static initialization. One nit below, =
but
either way:

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> @@ -2332,10 +2324,9 @@ void vfio_pci_core_unregister_device(struct vfio_p=
ci_core_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
> =20
> -pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
> +pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_dev=
ice *vdev,
>  						pci_channel_state_t state)

The state argument is unused. Since this is not installed as a direct PCI
callback anymore it technically doesn't need to retain its signature.
