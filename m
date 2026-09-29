Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E42AEEB;
	Tue, 29 Sep 2026 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715747; cv=none; b=VLSmo+IMqMv0Gd6BOzUL2Valj5fouOkWkbsslfCjZBPARHvM/dhPwpXUVG6DV/oClyARFnkBHn2x8kwHTfmFr/RPGoHt7/5JUFvC6CCj1AvKrNuE6jbpOG34p/6hegxrCrBADSW9rHM1UnchSnUAFDfC+xpFQtW5E0llTGuxfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715747; c=relaxed/simple;
	bh=Gw+VYLAmlQAZddkxEzQGMbl16HV5wYlSmNe4U6q44YQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=OyPcICEogHw17DV2huTM+KiWxwoXM0FlkxAj2zLsZM39VPg7b1r4rpF67fnuwKBZvTT9k6FueeXonYpB1kON4Zio0koFSf0JRxIMMyILxMrUyARBi3fvctrOaiuduhAa9lWcwjo4Mfh1DPSduYwP2qqq285mz0XpfOzOz4mpSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg9EG/mg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg9EG/mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E0D1F000FF;
	Tue, 29 Sep 2026 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790715746;
	bh=yJ1Prm4o30A6dyQoypDghGqyDKkYztK0VpsBl0CsL8U=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=Gg9EG/mgi63bAEnBgJoP5DIo5uyn5c6nk1HAQKnyues0BezsZlLgbZuO3usqvESm3
	 7PpSa/h1iOt0e3frTS13wmSj17kWlSJgbIz2tnHLeJMPGYOQ2irHsi6B7a43SArT1x
	 yCIRJTChsyyJXkmykLzit109HZAw+LpdohuXGbrCIdypuQemtkB96F35E2rXKMg301
	 +HotrcdkVG8+YXQn11ZdV1KRcQl4Jt8WYO7kIZfdFrkvZ99YdqamoXcOyaiHPoyzB+
	 9Zzfr7yttLq8gJoQYAjverfvOp6ZdsS8J7pDtHX1KCgB2UAKuVXftrTjc9sfdr8KJ2
	 QRTNqSLyGB98A==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 23:02:20 +0200
Message-Id: <DLS3R2DXNZLC.32236MQO2JOTJ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/1] vfio/pci: Remove the core dependency on driver data
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Simon Song" <xinmengs@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <zhiwang@kernel.org>, <zhiw@nvidia.com>
To: "Alex Williamson" <alex.williamson@nvidia.com>
References: <20260929173102.3544151-1-xinmengs@nvidia.com>
 <20260929173102.3544151-2-xinmengs@nvidia.com>
 <20260929194325.GP1616761@nvidia.com> <20260929144243.5cb913a0@nvidia.com>
In-Reply-To: <20260929144243.5cb913a0@nvidia.com>

On Tue Sep 29, 2026 at 10:42 PM CEST, Alex Williamson wrote:
> @@ -552,13 +560,16 @@ static int xe_vfio_pci_probe(struct pci_dev *pdev, =
const struct pci_device_id *i
> =20
>  	dev_set_drvdata(&pdev->dev, &xe_vdev->core_device);
> =20
> -	ret =3D vfio_pci_core_register_device(&xe_vdev->core_device);
> -	if (ret) {
> -		vfio_put_device(&xe_vdev->core_device.vdev);
> -		return ret;
> -	}
> +	ret =3D vfio_pci_core_register_device(&xe_vdev->core_device,
> +					    xe_vfio_vga_set_decode);
> +	if (ret)
> +		goto out_put_vdev;
> =20
>  	return 0;
> +
> +out_put_vdev:
> +	vfio_put_device(&xe_vdev->core_device.vdev);
> +	return ret;
>  }

NIT: Except for the new function argument this change seems unrelated; I su=
ppose
the clanker did this following the cleanup pattern used by most of the othe=
r
drivers.
