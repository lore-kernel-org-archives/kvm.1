Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD247FB16
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944231; cv=pass; b=QSf5ri+yhBKhqgXJSE8ZGgJW4DiKRIXBXuqyIs52LQLrIoVBWhW+wE1cR3PceOhefzpiTxlLD+mSIQYiOLK0FBdAhkO7tz2s/n28zS4kwgbBnp9P2UCNhkKg6LjgJzr2qgtoYNH2L1NNv8fDaUwxcsc2MHJYAn2PZtrEr0dS7Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944231; c=relaxed/simple;
	bh=VwKUYmxVxqEZjhmvBZ9dI/uOunK+7pumWVYmnPAIuds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQJWtTFhKcvuiNlNsyKjJFiOwVZxo7v1HJmmI6k9+y+ADedBFf5SI5huE7aQAbaPVUk7y8vRc1OZfLsVJGNGhB0HytXuG/t+Z7D/S8J3G/XS8OXRZ8tDfqa7sq4WGNNoXt9cA20wxJOJPpChP5Hlm3+hAW4Jeg1VHADMDTMn82g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbcTv9pa; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbcTv9pa"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so10699a12.1
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 08:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785944223; cv=none;
        d=google.com; s=arc-20260327;
        b=Ydow+IjZ0I7oqUBNYne2fUBIMMfXKsxAfWB8tUmyPGCoawq5J3nEs0f6BXDaIHZpEP
         zFWfyN2Y+LR4AFySFbii29u6jeMpOCsdGmJPDwoysyyLfWsKTmcRNd1EP8APncgOuXH5
         9gPGiTuuuig9QrBswJxnL4EkZYZJRxqgiwmQI2nvqWJtBQqxMySuBmi92Wsc5zirPvnO
         mHPl9Og2dsPEF/4GQ/rnwNKmuFFIWAKhzF9kilA7bmnHPoEIerAHJ+UszWRm3BSQmM6K
         4vCehYz2/82LXrgM7e0tFgnxdfMrkFDaMgdcwQe42U8y43JtmU8Yq4GKb3AK+afy2fNx
         Vwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VwKUYmxVxqEZjhmvBZ9dI/uOunK+7pumWVYmnPAIuds=;
        fh=HW5LeYgJ0LBdjgqakWN1Y24n3hEM/HMQD7zITLQW+Nc=;
        b=cTDXfZK4b17Ze8z1+CVfYFf1T652kafzGXIywiS0w7tA8fEFksT7rjoSvzTy9T/hxR
         er8Wr5I0etXYuYZJhnfoDg1lo5WrpKxj6BIQ3i20ZPwIbVgvYBFso0zvVitZj7GdXwVi
         FqajBGMFDCpRmsMyvSiv0PEGrbR7yOMIm9fwedcCkFJu80///KPWXrNQ6w6jo/HMBioz
         jEcQtWykQn/4LtsQcchgxW1vbUeVSf81cA6plOL0pDbx7ujim+NY/OqusBV8t45RDluu
         di48Dw2AyVo7+Ifpog5jO7W+C7WbnKWCqxxUJ+utWGIh7So8rQE1cgBuYUs8niv3MBO9
         0F8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785944223; x=1786549023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VwKUYmxVxqEZjhmvBZ9dI/uOunK+7pumWVYmnPAIuds=;
        b=jbcTv9pao3dkNkpvdWLIk0D9mF+ey05N8NqBJUE3IU0RyKINuD7kCybqSDA+71R+lU
         Zdctc6VlW7XtZJp2ZCpcbMAGCQJmm4RegoWU6vAk2D+mmQkbGKJDn0YeLR9/rwW0y8NG
         sclMOJRBpaWlvBbuxI9x0jBe1QcUipyCdtPnrVXYsngzlDaIpBKEdX5feYSTaKLdu31b
         9Mce6o5FX4NuwXSMONVIp+kwSK/Wl0jvFzC0rlTdDWx/3CCKXHmJDVWJgFrgV9CBW7E+
         nugW86K1QSpMoEbUq6+QJ74gi1JS/4FaADRIEizd8UosZYOf5SD1yZCeM4NtTuYvntrW
         +Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785944223; x=1786549023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwKUYmxVxqEZjhmvBZ9dI/uOunK+7pumWVYmnPAIuds=;
        b=TZs5xHxR7/uOe6CaTRAjVeWg61YPTMLUo7C/zFKeOiv7aLE4eeyDMaQpWPz5a/WYv8
         EvRYdcJJjE6k5vr/8qG0Ni0jIOtobM74Hq+fAy63N1fcgV9yn/PKl4TblmdBckNKSEcf
         S59DwQNxKZ7ZRuQQCSM06gc+RR3kSJIvmJsUeu6AQ6wJZnIVkhxxnvfQuueOF7iHmieT
         +icLHJ+dyNnEq4sKNX7kGVVVcYadaMZ46/yiZH5xwJJZ2pRP7o66VUCdk8LbqW+1FtUk
         0LZ9pP4nftvGCcyXxlZnbr7Rj6h7sb0u/yrpYehUp6Gf2rAJ/+JUctarGuMjKSznrkEL
         J3gA==
X-Forwarded-Encrypted: i=1; AHgh+Rrw3Xn6rMPJCM90sM9koQFltjXW7ovbGY6VDROusH1KVko4z82CYmMQh6mzAGfaevgPPJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSzaWCsn5jyuP19fS2AHXxAYo7NVYU9aFnEw/osPf4rjL5/Xr
	pZOcmI1JW4p21DhMElK1cto9Z6qfvTX54Sf7txvoGKlGbJzFaKk445E6kYRU5inOZcuPVyhJl9z
	NyDIDmgj1aj1iHU1uekVwqKWOVvw/Kkp+Jfg74KHj
X-Gm-Gg: AR+sD12eclOqe6PXg9zymdIxQdD9uDnAW+HkzJroLfSdsQUBRNEQP7VnhxaIEVavFYK
	bk9mu2jq8i0RgXwtQeV7rRbOC9Ewr76psqyNekHs7f6QdZtMSfHR70As0Wqmvba0x7zt+2UXLbo
	hpVm23ScjvdeUACN8L5UDuMu0RN/bbdDnGjKItoTpkNZrkNHBOMndS6cz/NnlyBVG//QY0R1yJ3
	9eidZAKryUYCwmG6AU+6RQHw8O/wMkPdgl/k3vt9m0DVmwukySgYxwkBgJ1UiEqoGTCMLiuHg+p
	JtNfxmqpGOihaRvyMcFCSB6c5jqB2zuiPQjkJtMmLN1b
X-Received: by 2002:aa7:d406:0:b0:69f:d4ca:3c8c with SMTP id
 4fb4d7f45d1cf-6a14fc679dfmr64188a12.6.1785944222437; Wed, 05 Aug 2026
 08:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804232344.2976694-2-yiranirenewang@gmail.com>
In-Reply-To: <20260804232344.2976694-2-yiranirenewang@gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 5 Aug 2026 08:36:49 -0700
X-Gm-Features: AUfX_mzBi7KGm9KuY-5Bkr6iTz2mUOM8G4OdCp2sFdezDb4zX4ATJ8wCzBteZfo
Message-ID: <CALMp9eQyRbAa-YO06uVmFGp5T8AcG8+U9XmAr4Uoq1yNxwn=Hw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2] x86: pci: Support unaligned register
 access in PCI config read/write
To: Irene Wang <yiranirenewang@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:28=E2=80=AFPM Irene Wang <yiranirenewang@gmail.com=
> wrote:
>
> Per the PCI Local Bus Specification (Section 3.2.2.3.2, "Configuration
> Mechanism #1"), port 0xCF8 (CONFIG_ADDRESS) requires a DWORD-aligned
> register offset (bits [1:0] =3D 00b), while byte and word offsets within
> the DWORD must be selected via data port 0xCFC + (reg & 3).
>
> Previously, PCI_CONF1_ADDRESS did not clear bits [1:0], and 8-bit /
> 16-bit helpers always accessed base port 0xCFC directly. This worked
> in QEMU because its PCI host bridge emulation preserves unaligned bits
> in CONFIG_ADDRESS and uses them during CONFIG_DATA accesses. However,
> in strictly spec-compliant VMMs (and potentially real hardware), bits
> [1:0] of 0xCF8 are ignored, causing non-aligned reads/writes at port
> 0xCFC to erroneously target byte 0 of the DWORD. In practice, this
> causes pci_find_dev() to read the vendor ID twice instead of reading
> the vendor ID and device ID.
>
> Fix this by masking `reg` with `~3` in PCI_CONF1_ADDRESS and adding
> the `(reg & 3)` offset to the CONFIG_DATA port for 8-bit and 16-bit
> accessors, ensuring compatibility across QEMU and other VMMs. Additionall=
y,
> assert that 16-bit accesses do not use an offset of 3, as reading/writing=
 a
> word across DWORD boundaries (port 0xCFC + 3) is invalid per spec.
>
> Assisted-by: Gemini:gemini-3.6-flash
> Signed-off-by: Irene Wang <yiranirenewang@gmail.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
