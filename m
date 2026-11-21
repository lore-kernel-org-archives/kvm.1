Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294892;
	b=V+CAOZRJBDWKaDC7wUBtFXs/K7F0ljhA1E6u9pWuj5g5BmgYEW5cYsjFtMBxoHg/vE+K
	 J2dZeK7YnVzLXMHjX7jrVt3HHFf9yvWidp4U1N5v/DalHm2M73/Wu/wihcLYJuk2fC7/V
	 E0GKe17rUQ2SJ3WEr5qVwzmMmKau6ER7DBm64FiAw0oU46XMJv5+J0hYrz9HRdS9U0qRT
	 yapaiqUWyv7qPlM8xfbcCKp90vCWpFgJfq0IHWXyLxDNraUetsaFsTccfDRpN1jFNz1fn
	 8QEMLHjSetfSnKRpnorr/JTGL1E1r4Vnt2jyKMr2j58bpRm84CSxa44qCT1pTyVQrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294892;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v8vAHChTalJyPKJWjYAU8hJ9rNARiHKrkluyFMh0zh8=;
	b=u1KIvikheJVmc4ClwESnZh3Z3hgOGGJ/xpYAzKVvLUM5Cc1jQFvvG7W4183JdwbDckXc
	 nkxeUxT6bom6KNMbZgsL0JI7NEF3kJx35ITWL3N2bHIPQ6KQvM+shkRDn/clz3oN2OrkA
	 2pTuaEOWyvo3/6R5+OelTr8i0FygoXLkLRgcUURKi6BQ0XtybEMXAA1+mFWyIJaAdIanI
	 dVOVY1/8IvthmRJG2du/vZENSMqtZlHB2JzoQmCOxqYcyVFJ+5Qg3sJB3UFsoe/XrmH/H
	 3k5vy2B06DNfeWCdWcQsaUVuR+eEzKzR/1WJQBpp2yHfoXT2ro9LmSGIpaGOsW5NIKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhcIcnDa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AD606A333
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhcIcnDa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2901F000E0
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294892;
	bh=v8vAHChTalJyPKJWjYAU8hJ9rNARiHKrkluyFMh0zh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PhcIcnDahk93XHX6nhVEyhzqPt5GML6+Zl8sQA0Ax2ohQ+5IT8DChhIUmK2Pn8qZI
	 pL6vyZZfGf9NWndz/ufGc9Y1eByB3h8etOTfGTkfMSB14pW1UtngpOIf/rL3RurMv4
	 a3fppe2SppuOI0uPoRo1NIUjKgbuBrQFlp/nxdkIUd56noxL6pZIFEtO60X9maoWoW
	 73Hr4fogCGQaWM1fmV9oJJsbGa7Lyz62RAEXQH7L0uBL3cYCCAJvOvYkoQLcXZawdV
	 1pv/4CFES8fTRs0t/4hf4Zr9LAsfZZwq7PtHj8AXZ8qNoQa5KhmxDWzWoeiccEJiqf
	 58mjFX/aM/xwg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c1479a959aso1467855e87.2
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 13:01:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFEVqE9C95CLEL2pq97nsfLLoEul0mOrV7rzYj5HcD2XJNZnxEkufFHbCdfJ/MchO9Pktk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+P4bipxC9LKUorh28DI1IfFJR4Xdati5bZJxxFIPCM0LyXtF9s
	8BcmtXrF1MXpgOFzQqCtlN4f0OiiWovQ0wO+Rrjb/9S/5hG3FAfqJh2Nnw+R8N/x/8nyZnduI1L
	k1InQVbO2vy1ano+OFqHtsJm5UjoQ4gI=
X-Received: by 2002:a05:6512:31c3:b0:5c1:465b:ebe3 with SMTP id
 2adb3069b0e04-5c1bc7be4b6mr2356062e87.13.1795294890748; Sat, 21 Nov 2026
 13:01:30 -0800 (PST)
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
 <20261015142552.4128028-2-ryan.roberts@arm.com> <CAD++jLkrWojU3FeTPGOCFHHsbmTGYG0Tz3b2nrn7mMfsDssCQw@mail.gmail.com>
In-Reply-To: <CAD++jLkrWojU3FeTPGOCFHHsbmTGYG0Tz3b2nrn7mMfsDssCQw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 22:01:17 +0100
X-Gmail-Original-Message-ID: <CAD++jL=fnRBZJ-H8SMbZDr_1-F-aRbq6QRN_ZqaKw_M4cJFBOg@mail.gmail.com>
X-Gm-Features: Aa3M54rcr2uec6946c6ceFg_f82syIk8ikAg7SN-MP8cTPlIYobsjIq52BzG5Cw
Message-ID: <CAD++jL=fnRBZJ-H8SMbZDr_1-F-aRbq6QRN_ZqaKw_M4cJFBOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/15] misc/arm-cla: Add driver skeleton and documentation
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

On Fri, Nov 20, 2026 at 10:47=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
> On Thu, Oct 15, 2026 at 4:26=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:

> What the patch series needs to do is tell us how this topology is discove=
red.
> I.e. will it be discoverable from the hardware itself, or will this topol=
ogy be
> described in device tree or ACPI for example?

Hm what about I read the whole series before replying to individual pathes.
It's righ there in patch 4/15, mea culpa.

Yours,
Linus Walleij
