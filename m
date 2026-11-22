Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795305798;
	b=h4lyMVOTBcOC0OkjBYCSP69YWMHKxbbSmoRHc6k9mS9yPEfv84O/55311swLIdlyuSLA
	 zfVHxMsxcmscdkcXTwa1Yf3Sn5pgt+cGh87DMoZgxGuTw+EUN2fxFwjL+I1RtnIzQ0cBi
	 LM9ljIRryXaeawTePh5Lmbeyuu7g6HfXRyCFLiVkw2b6dCFT/rUvhAa7m5dU8Hme/AyCo
	 GLgF26KZ3PvaVXNoiXSesFyRm0FEuwv0cusXoHB9i714VD7rKpDghpjNgfhSjKFnxHshs
	 PKF0kHsm3wUuaoO8xog4hwx3IsBpT1pkYz2xdFleSuRsMMa+bAxIZbRZe9Iium1eyFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305798;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rYwFnnQpoq8LFGaav+MzPqD+Y6qhmYWK6HkRe9C2QeM=;
	b=cTt4/ZXwmQhm46gSsX8vxSgFRideElMFru5olSt7oRfa/Be5Ls/kwgCKiLNeecFTGcAt
	 GWU90F9G20ZiN7lkDjqHblbr5lYChB2Unv7T6fqRamCfjYRUExffVnTeKqQ/Kxn+eL7qD
	 /qaxAzB9OfPtaZ/Vdd4I/7Sxl9ey5uXlmzn+RjcgIV6NDJiRH71cXviNRLz8gl+Ou9/pg
	 WHe/sxXPN9pb1pVofZlq1mkXFmeY/25Ad5DA4FHigBJWPqWdJpKPZKnHJ7oPGm+nWQhxl
	 1W4SoPwpILsP7u5ZHxpJAAvUA9O1yrXmT2KVItbivnXPy0z09uShnSUjqIjqFktcGCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEtJ0Z3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028F606A332
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEtJ0Z3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9BD1F000EE
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 00:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795305797;
	bh=rYwFnnQpoq8LFGaav+MzPqD+Y6qhmYWK6HkRe9C2QeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VEtJ0Z3RFtXNNE2efuwBF9CxDfb5B95yqKPcNQxO+t6NQf2t7QVUT+e83OzRKAMas
	 Et0FX6zr/HpTXZ5u0nCFgtAJcbM3xmt+CdbOTavu7JuGUwlLBBCzSXWSBMUHF60mot
	 W1ZNteOFWWRkKFzRoukBOv18VzqXbm1bdBQSQZ+YkPx6etZg5GiT4lxSLMQVjMSGJm
	 N93oZS9RYlL4Rhdrjy/c6vsZybDkDHQd4i/Kc7D6X/edXWGCsEA7YjMzk/e3TGl26A
	 yJFtqNMD3FGLZ8qKwWBx8sP5O3wXEbjRHI9lzpGMrneITPKqXsS1KiLBXvZ7Uf1BQ/
	 74VNAmNGVNzbg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso16493611fa.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 16:03:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGzV5lUpq1TztU8/SEWLLkuQTyXlgaj854SNfUAsXzqK3/Czw4o4EhTGRw3yp9i2xeio64=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lgCaI8wRW96naDieca8/7Bt4iLv2KJRxC1KY+6QErfR4g92WG
	KcA1WRByUijd1xnVVkBrNwXcBrNAkJhqGeCyYXTld5zq05powFZnpfvjInOow4+QFlnM5+LYoiX
	wtmhH4k91dG62OBvE1fQYre9kmjwkfR4=
X-Received: by 2002:a05:6512:238a:b0:5c1:4bd9:d696 with SMTP id
 2adb3069b0e04-5c1bc6803dfmr2119235e87.8.1795305796393; Sat, 21 Nov 2026
 16:03:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-1-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 22 Nov 2026 01:03:03 +0100
X-Gmail-Original-Message-ID: <CAD++jLmd=+v0c+zZwLVafR0aFRnt95weQ=_oaOaYdHUbXktvdA@mail.gmail.com>
X-Gm-Features: Aa3M54r3uff-3u27-GWxVyER9ELrI4OraGs3jCVFrFZTcTH5Wtzi-qad91fCkZY
Message-ID: <CAD++jLmd=+v0c+zZwLVafR0aFRnt95weQ=_oaOaYdHUbXktvdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/15] Arm Core Local Accelerator Driver
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Thu, Oct 15, 2026 at 4:26=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> * Driver interaction with architectural support: I've opted to treat the =
CLA as
>   a device rather than a CPU extension, so it's implemented as a (mostly)
>   self-contained driver.

What the current proposal does is to create nodes in the base of the device
tree, which makes the device tree parser instantiate those into
platform_device:s,
then each cla_device piggy-backs that platform device.

I don't think this is a good idea, I wouldn't use platform_device for this
since you can just look up the nodes and instantiate the cla_device:s
with a proper struct device inside all of them.

I think it's a better idea to put these inside the CPU nodes themselves,
they are there after all, intuitive right? Init code can loop over the
CPUs and instantiate a cla_device for each CPU directly without
having to detour over an opaque platform_device.

Devices inside CPU nodes will not (I think??) be populated
automatically, so you can add code to loop over the CPU nodes
at device_initcall level or any time during the boot process deemed
helpful. This also saves you from adding devices for CPU cores
that are flagged with status =3D "disabled"; which could happen.

Yours,
Linus Walleij
