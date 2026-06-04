Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236653C6A5F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605083; cv=pass; b=oy3SRV8dS5WVhdy6hn7T4nSscIekexPoBZntkCtzUtpFQOcxx9QAW1ZVq5LiueMuGuNdm23eRQtuqxhuxB+gSLDkrzevITySI+UJ3wRLz0zzIc2TjJyxjXPFGj4CIBlz0aqBNld14UAtLqZMsOQDvAOOlerh1AJ0ogt7DFrSK5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605083; c=relaxed/simple;
	bh=9kpC2nHMHfrFBBDbEImWKZiBaD4bqcBEfsrz4mjibt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DraXI96h6pLEqANZFn3SCYV3mUpi8nf5iJOgJaf8jOrwQHHVXi4t8Z5zxAdlCdBf64bNHj2lfpClnf/G3TrFLIMvCzcwaAFj0p0YSd2/du3A6CZBmQ0jBadVcx6naVLtAvl6JHLSS7kXJfo6Bby6tPHBjyVe20T8QBTpAcRH/I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFw677m1; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFw677m1"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-135e7f4a295so750046c88.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 13:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780605081; cv=none;
        d=google.com; s=arc-20240605;
        b=XJopt2uQbX0j+Qt9QdZheBM6Gb8g796NWi/4+/XmfidPsPA/eQEtHaO7KJfZcY52QJ
         2e2m/yDfNq9XEgGfLNFwCrzBo7Adg+WyDWQj0eGGBSWoUBIBvq1XE0QFgHnWHLFulBij
         QWuF9z+c6AmPDj0WNYWkIVzmwx23kMo9lvIOiVr/3/doDvp0A7RNN+vIupLBShjBTQfT
         arMPuD3LF7e/O3sIAG/mzQcDxOOjX9jW0SUdcKxJCjoMTFKZBXJaV9hsVMqRs9SqjrUn
         jQgoMAAwq8wr02P3eb7jvOetur+5lZBeu30AO6M2YBd1Ww5FoLcFzrk2sB9q+gY7JSnd
         VWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5eqxDNwMgXWFT6618jLIGF8ZKS5nIiFhwgYUzrXYF84=;
        fh=KefFXkzf2XUeEXlaAXTi5ft4+xMqBvon9MyR4IegZdI=;
        b=kN5OxW2GGEfFlHMi3O2tREgC7CN2cJbXCK5F8RGDvh2XGTgb+11GuuATPSDlIPHubD
         e+UwwwrCnVyzLCitng5ASFMBxa1LAHr9QYcB+d7hecrIGvhT8v3Op0ZgRAoSgWypP1oR
         pKUXUlY8eVkNuE1raYdkCqYQk5h9mv7VMooOGf5FoPgoK/KjZ4LV5rOtKFZMONw3h69m
         1k0x4wi/h8Qs0sKBX9NAdWLp9AULV8cnLNH27v9GePh/jOuiFio+YmlY9MkINftQ+zFB
         SCQvB1eMja6ofzBUFF196ZdNUEjHDmJNCWX2d/lA29777Uu+GaDQVeDQFxdxUiRQ04qG
         7FzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780605081; x=1781209881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eqxDNwMgXWFT6618jLIGF8ZKS5nIiFhwgYUzrXYF84=;
        b=pFw677m1NksCLNCvmMLmc0N1IaYFudlMVBg6Ww0K27XytdArxFl3sPSvMkhrHMpmHh
         UYrQ1+cbXlFyIo2wRbsLlB7pTdZ7IEKDcKot0DsFSuvytH0z+u5etQEPhPczqG9ocmk2
         yH3s49gMwm7dgrzk1GRFGsDFNvLqgLDU9MnYHO+lyuDeYEM3/FU3cihH5aeKmNTEUM63
         SxAf0k//vTLqomUDvwC7lA5gdimOPcXFxHfby3IZWEoA9Ew7tAZ7G7SLZXyfYR0WMBHc
         xDhcVJZ84f+bbMz6yciRRF6GqyXUvbaJtJLgV+ATqFCHJ2E74G1OiDLW001IOV1eqHx5
         nEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780605081; x=1781209881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5eqxDNwMgXWFT6618jLIGF8ZKS5nIiFhwgYUzrXYF84=;
        b=JU/6bm+2jgJAkFj13x1/cmt+gdkav8GPHiPGHW3UowfYgIMX1nOFvkRUDZ17T53wGs
         HMLyDQBKWwMymkYtT+/qQe0zwq7Jt/PVMQvjHxkN9okc5+jqIQdreK1Fw02+Ql6ZcP9o
         KwGJSsW2+pozatGWYeoWEvy/pnf62A7gUeVsiLf/WABs1jEPvNlKxq4Hl1Dh98YThYDX
         0ljtZ8zBh427SHdKrxDMAa8N9ntBYmNLBWXPradcnMd5cswZqwdZGBbWB1fhQNd9DVZ5
         3RG1+hMOC4O9oSP9NJgXWdaJlkcSEId/HYia8WiIO1mmPGF/wTmc0Ig7LTqalRKzlYW/
         Kvug==
X-Forwarded-Encrypted: i=1; AFNElJ/rG8fs1DBEZU7zzaymnrCaOGfNddeWJIyWEYEJX+itqtJ+IyZQgX/uWAanGgwSPiRS+mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jr1N2c7HnWtBkR6mGHvi1E/pACwwTQMQll97ygXO9pVR7KX/
	11QKAnIgyMux94qpCTmajW1i6L8b1C7ovNsbI7nMA8hc63ochqjRaDPIryheYoQRCkbN2C3BcqG
	TPOk9Nstk+lGNxdW1vpMIvZcc2MN8meegWJOyzXvD
X-Gm-Gg: Acq92OHdnbAZGucREGCeAB/OUQgyhSkfinj/Qc9FB7jdXPjOeaimezLdh4RpTOUskn4
	/7yDNMJrAD/jlpkHdF193fIYP/htQnHLOXj70J9U5qTH1A9nx9EB3Wri1vbCdEUQ6msoT1iHdu4
	odNlgRK/vCB+JTz2LX7MjlaufugHuye/uZ7B3SZKCJdRBVHyYdW1s2UGNIFvN5zINleoNtxfqaf
	+++x0YtH8yAAQGR2use4KrH/ixx7HetyY07inH7XTjofVjEGzZvlNlzGAsdLuc5dLkbD6h8ChfH
	4OOBiL0QhZAeJEQkXg==
X-Received: by 2002:a05:7022:6725:b0:12c:1288:ce63 with SMTP id
 a92af1059eb24-137fdf48f79mr2155784c88.13.1780605080783; Thu, 04 Jun 2026
 13:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602222941.3133236-1-jrhilke@google.com> <aiHW_1vBrukpuaW2@google.com>
In-Reply-To: <aiHW_1vBrukpuaW2@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 4 Jun 2026 13:30:53 -0700
X-Gm-Features: AVHnY4KdT1r0GEFqRf1PcrTfObBktJcqyYjPXAeMt1dMh7yCC5NlZ2zlsiBQr98
Message-ID: <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:50=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jun 02, 2026, Josh Hilke wrote:
> > Add a new script, list_supported_devices.sh, which prints out the
> > segment:bus:device.function (SBDF) numbers and names of devices on a
> > machine that have a VFIO selftest driver. This makes it easier to
> > determine if the system is capable of running VFIO selftests.
> >
> > Includes a -q (quiet) argument which prints just the SBDFs so that the
> > output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
> > (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests.
> >
> > Examples:
> >
> > $ ./list_supported_devices.sh
> > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> >
> > $ ./list_supported_devices.sh -q
> > 0000:6a:01.0
> > 0000:6f:01.0
> > 0000:74:01.0
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Josh Hilke <jrhilke@google.com>
>
> NAK, until this stuff is fixed and properly documented.
>
> This script needs to (a) communicate that some of the devices may be on V=
FIO's
> denylist, (b) NOT report them by default, (c) let the user report denylis=
ted
> devices, (d) make it *very* clear in the output that a device, and (e) id=
eally
> provide the user with a hint of how that might be able to test a denied d=
evice,
> e.g. by reloading vfio-pci with disable_denylist=3D1.
>
> Nothing in here so much as mentions that these "supported" devices may be
> disallowed by the kernel, including the devices that's USED AS THE EXAMPL=
E.
>
> The DSA SPR devices has been on the naughty list since commit 95feb3160ee=
f ("VFIO:
> Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I hav=
e a
> very hard time believing y'all weren't aware of this.  And if you really =
truly
> weren't aware of this quirk, than what exactly are you even testing!?!?
>
> C'mon.

Yeah vfio_pci.disable_denylist=3DY is required to use the Intel DSA SPR
device. This script is a great place to capture that previously hidden
requirement.

Your proposed (a)-(e) sound good to me.
