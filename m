Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFD4C6EF2
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828303; cv=none; b=gfuyMqPQadOxzxIJ/Aq88bZxyo4D4RALPZzU7TvsdnSKz3pWzaRK/mYCv3C8CGfU6KgOw/eDWopQy5f0/zcL7Sp2FaGPa2ph6ZbK9IkODIgLjvITXmWIoYouBCXKhbRRNIlk5S4TtLTN335WVJUeL0oh5D0APDMYSxkgnjrvX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828303; c=relaxed/simple;
	bh=uemRYt7gAWSU8x156vM8p6T6XKCVm9HVQss7nlzD/vM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IrN8cEaelq/AKF3meRpM4XkzLrYrucrqdQNA3H98pxGVVuq3EFGDiTkSwGAxYAko5foWBsVNehX2cnRNWBXxrSJG8BUe1ySVY/HdHJPZwTntkzViHYoQsrD8Cp4p4TQCIlaYG0QikiZhV1oXosvQcc9MQU0cYZe8WmOAYxiF628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egGhKpbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egGhKpbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019891F0089B;
	Mon, 12 Oct 2026 18:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791828302;
	bh=YF0c99xDCCkPnEmVXt+J+sZmqQs9s0vQCaM/hEUtYOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egGhKpbqGgquUvyEUPAhLoHxoyvghmByyQ7eo2OfeyNGzum9RZmZ3FK9TDhfNY240
	 Oiv2wN+LmSD25dlGRu6TT7TubIBz0x5my+qHR6drtQf2NDHquWMG2cz9kBgvNup8e9
	 ptWYP6IWnqmN3Q097xR1SOrr03C3BsCXPMzYGGcbgSDf3qHg+/3pkYamLbel1MQetv
	 PgECxItBW88e/pnz/2OdNtlt98DTZ11QQzp4x4pwByAicnNdJ1DW6hz/gNSxOsPJNo
	 g1VitY5eNi8aAIORTyXVoGYrYwZIv7Psv8IN4VSRUSxh1VERjxK5RUhqnGVWpdNg4d
	 2TC3/9/eDXHhg==
Message-ID: <sashiko-outbox-168506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] coco/tdx-host: add Kconfig description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Voytik" <voytikd@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261012175348.1256363-1-voytikd@gmail.com>
References: <20261012175348.1256363-1-voytikd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:05:01 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kbuild: commit message claims to add Kconfig description but pat=
ch does not
--

commit 424217cd6059405518820db0188355121477942b
Author: Dmitry Voytik <voytikd@gmail.com>

coco/tdx-host: add Kconfig description

This commit updates the default value of the TDX_HOST_SERVICES Kconfig opti=
on
from 'm' to 'KVM_INTEL'. It is intended to fix an issue where the driver
always compiles as a module despite the user configuration.

> coco/tdx-host: add Kconfig description

> diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-h=
ost/Kconfig
> index 57d0c01a43577..fe018e00822b3 100644
> --- a/drivers/virt/coco/tdx-host/Kconfig
> +++ b/drivers/virt/coco/tdx-host/Kconfig
> @@ -3,4 +3,4 @@ config TDX_HOST_SERVICES
>  	depends on INTEL_TDX_HOST
>  	select FW_LOADER
>  	select FW_UPLOAD
> -	default m
> +	default KVM_INTEL

[Severity: Medium]
The commit subject claims to add a Kconfig description, which typically imp=
lies
adding a prompt string (such as tristate "Intel TDX host services") to make
the symbol visible in menuconfig. However, the patch only modifies the defa=
ult
value and leaves the symbol hidden.

Was the hunk adding the description accidentally dropped from this version =
of
the patch, or should the commit subject be updated to reflect only the defa=
ult
value change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012175348.1256=
363-1-voytikd@gmail.com?part=3D1
