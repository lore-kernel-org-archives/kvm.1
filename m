Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166712;
	b=W18eS6XAeqRl/butvtt/efkmLh1nX7Gq4wUVzwIFo8DqtQm/BRNpatuAhi7viXQE1/1y
	 Sf7bgMlHKpfmVmcJ6ET31fbwh35PEghFzq2PxNSds+C49s7bujvIg/jiURm2OXQCzVQJO
	 rntfiFmHalAXHyptC0gAg0CbqfRbhfJdlJlU/2E9izuK8FXNp5TYayB7/jr5uzRPFO1BM
	 QhypUIU5vOaGWE4xBJCf0+r/RMEmhgKBafGuY+r41s0ATg4UTzZfRgCZALulH2N+5hDrn
	 MiXGwp5dzSqQgkFuJtQVlh8jfyS5bIUCEmkMWf3b6s57zY5pu6FgCFXyMuRoWIGfFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166712;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8SzIHclfGO7rIjAKlxWY7h5C1tqRdUP4RNaZqN79MuM=;
	b=BKLFDbSczu3hCnb0LpEiQHCQ4qQINJ5ZWRX3nw5xbvQzNYsY7wcW0NiTwMWUad4UsPbQ
	 Yh5Z9n7083tknndTPfzWLGzpKF5RMbbWxU516lCnUyuyKUJTqvHZVtY+Ol8j8TTY1ZO40
	 Z/IBZGd5NBrK7ehroLs2jvRxQpDv8l+si0Exg3lh1iHeKoNmN1jGxqZMRg0D2kwZjXgU6
	 yxc+vRu2MJzYgOK0mn/M1goaYPnTnAFVPBhevL+6lcyW3WWYuu++dqs8odRmDDnY3N3/+
	 y/jmRSR+QtQj3eqk9GtxzKRhk1zpc2mK2ySy23k45+AKWl+M9DRv8vxj/ZJm5NXbxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5ZDMOWE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAC606A336
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5ZDMOWE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674F51F000EE
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795166712;
	bh=8SzIHclfGO7rIjAKlxWY7h5C1tqRdUP4RNaZqN79MuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B5ZDMOWEHdnhh2/umOUmDyebT2Q50s1hgR4xDpum/5dqqoMqtjXVEdU8aCG9sLmQA
	 7A6AoINlMkFawC02saPlGU/UG/hx+Ve8Q49Ae/eZlx2izAu6qkxYbT8PBExCep30Qc
	 cIKFHKeYrow0KilYBJXAu05Oo1CIxqWoGzdcAB4xOFdSnA5ipUK+6pmAZZGQKczT57
	 5U5FYX0g1tEu7APgsdhwFuInYTVpzswscUD4Z8Qs45W2nDr1nbveiYtNzYB4TrppYV
	 8pctZ+ScqMMKXovSWloMW7pcezlqSREFM6P5p3mvobzMNRf9HWvMu2KMDKw0zP2X5m
	 a5xa8vTyeJJhw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso476762e87.3
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 01:25:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEktccmy+v/PJv59TTo7kJDhvqOnQHfWEtXPqhhR0GBy7DViXQ+/3E+jY6MUtX1mQVsEo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ArLzdI4iOw8hH5hxsG/vMHOCkHMRXzpWgXKqvhb+P2PPTkvsl
	Uv1Ntqx7i/1r98HTqDhazXGaiN6fciKD9LvCuKw1AnOSV5QZJFd5V7jd3GDquJ+dAmImIXYVzaR
	oBfrPO5WV1UWqKSVjUP6AVZYoXjWJ4hU=
X-Received: by 2002:a05:6512:3e26:b0:5bf:dfb9:33db with SMTP id
 2adb3069b0e04-5c1bc894b28mr761513e87.38.1795166710840; Fri, 20 Nov 2026
 01:25:10 -0800 (PST)
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
Date: Fri, 20 Nov 2026 10:24:58 +0100
X-Gmail-Original-Message-ID: <CAD++jLnXQHkYvCO4raM8enm2NNwU5WDNE4cFhvcVUnUZVHMPLA@mail.gmail.com>
X-Gm-Features: Aa3M54qJyeIPO-XfHd9glHLeVqDiREjcacNXijYh3kod1cJY-VZmSyNAF3F7zP0
Message-ID: <CAD++jLnXQHkYvCO4raM8enm2NNwU5WDNE4cFhvcVUnUZVHMPLA@mail.gmail.com>
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

please keep me on CC for future series for an SoC perspective
on this.

On Thu, Oct 15, 2026 at 4:26=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> * The location of the driver: although most accelerators will likely be c=
ompute
>   ones, CLA is a generic MMIO interface that could handle any kind of
>   accelerator. It's currently implemented as a misc driver. accel is anot=
her
>   potential option, but given the current SVA approach, we would not use =
any of
>   the services (memory-management or otherwise) that accel provides.

Given the extremely ARM64-specific nature of the accelerator it has a
lot to do with arch/arm64 but then again it is a platform device + driver
associated with the cores and we don't want platform device drivers
under arch/*, so it kind of falls between the chairs.

My spontaneous placement would be to put this in drivers/soc/arm/*
what do you think about this option?

The argument would be that this is arm-specific, we do not expect
the code to be reused by other archs, and it is used on some specific
ARM SoCs, so it goes under drivers/soc/arm.

If a very similar feature arrives on other archs which use very similar
code we may have to rethink this but for now I believe this is the best
option.

Yours,
Linus Walleij
