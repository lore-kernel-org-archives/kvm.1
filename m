Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CD478869
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573801; cv=pass; b=idtTSboWcLIzqPDMFl1js7Df45Crfp2jhPY8Kj4vxwFhWV6K0WdQN1DJGD6tgCdVTYGQSID2LjcMBhqN/BtEvGKIrEfOZZaDpT68ICYTU+dSCXJjGRGPKSqaw8zZwwjBwZwJwKtadEiaSeaM9TK9fuOExvB6qJxQJVDA7IbWvac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573801; c=relaxed/simple;
	bh=6074mthRigfzCqj8EUBUDZuPgxpsUrNJXIQzDxBC4eU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlgiSX7a+cmNVfJ9j/bV7yYn5X6AI9RThxIcoz7E6Lbe81O7NNr2e2E3jmYsa/l6ErJ4ZclT+X/oJ2+qC2UTphgdmPcghfPNFxmb0pvRVIPDm2mO+XZrS0JxIKGuSyOiCX1n9KmQuV3bA71WnwzIWIb+ziGuIMfrIwzEokeLozI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caJ2Sq43; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caJ2Sq43"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso460827241.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573799; cv=none;
        d=google.com; s=arc-20240605;
        b=LvOUUKXIaAFKs1D7925DEQl4GvMnIB4PFI6k/KqnhtXf3qBbQama7lzXlKejsRbbi/
         PZrNVGAzdXJJAPZ4byyNGVJth8FgsD7orR1FV9fdi0QI1jht2VIw+GdIXDTL9eDQWZ+y
         m1uGOsW0aLbaPZThN2XHSTSF8if9al8/FCXNPHGlpQCCyiQvzqGb9LNPJ8EFaijQzYAB
         4A5VSu2MpcDTfmQgRQp8vXjBepZenOYED3CYQRA7uwd5IkHdgvHu/2G7LtLqWd7hWtZH
         gLjdHxi9kEc0XPbLYokXU9ez2usIGwQ5JElN90d46iRWFRQx8/a3iOiRUY3Om/4b28PD
         0TuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6074mthRigfzCqj8EUBUDZuPgxpsUrNJXIQzDxBC4eU=;
        fh=rbQTgOo39G0BN94YIWy69/yS/Zbta5k/xH3Magd56iY=;
        b=T4T+VvbCgHQ/H+bfGA48+X1LhXIVoM5MAyftuNYzF3zhnNB069lVn/Dh5ZgX6HAFvP
         w9TYpL+fp5tB5zvC5YwocZP/YnpNJdui1IkpLrNwtrjUve8wB7xZs+ewlmbKb6asZg/z
         Bmb0CIZoh6eA2eG7tldWWhkZNNLILMniijupC1ofR3Bt02MCDkab7r1N3xa4ecooJMZx
         ErQfgnP4wxUcKV4xflpSLw83pirtwJVg9tT8YmrNlloHmkDByn6cgHV5wnLBbvFG3i4K
         1XcDez/NEUBjF8+dlPAO0FbigdoQR0ir0oHS8aFtRr1bJhUzYOgJr36rQEGtuiBBdnhe
         P5HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777573799; x=1778178599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6074mthRigfzCqj8EUBUDZuPgxpsUrNJXIQzDxBC4eU=;
        b=caJ2Sq4370xYulrrMnp6bVfvZJq2hhObulsRhuc90BrE18FzzsWBMz/7GI9+kyH5AG
         MErbqpH/QKsysKiVxdZgCdHnmngfWAsm25nDDJ54hSIrEuFXQB+3o5LeW6qyc27V/jh7
         c98fOmyIttvpykwa6QsrlZyCRS/M1riT4Td/pvaC4RS8oJbh8ACWWV17CY8Bw7mJfxPl
         C84qg2gNPyMpX6YrjSPFIdYNze2c8YutTK8wJwUyQPmjikXxX47HmBWPjIcCZFcxBU9g
         g7GBNr3hdrw1zi0ZfFmc/KEbi/P8yioirGJhb/Hd3pUuFYq0Sw96M1D6kgehC058HmyX
         pjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573799; x=1778178599;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6074mthRigfzCqj8EUBUDZuPgxpsUrNJXIQzDxBC4eU=;
        b=ajOgFr2p5WkW3414j0uDxhapKfjMXaTX1zLUrP9fMWja5SIRBjhShYoQFxRvcUOFtl
         z+JtwX5dsrPDo0oFNPN/Q7oBokW4LepGD6/UnTJbqyQNgVSL2WVPy4ZYJxolxr3pEyrb
         UprYLaUhPhvx0Abnk95c0y5fphAaRstlerR8/KkHLDs+CVGtAz43G6Qr+E8rprjdxLqa
         FFzGhTpzpHUbHEcnX+Qpx9IkUkUy2NmO5lcReijef7Na3ML+ZW6UBeh0OFWms9qUMC1o
         60acBcS2mSlUdk3ZZpBxdLIUn97K/dbbJ5aAviLYK4GGMTtqdIuHsqFeXqQONSgoYu5j
         Z7gQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g0767NCasqIEIvFPBzLbBLC7nHxGy/cwSDomaeous2jqisrCCEiXkEb30+psElfeEfF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdlgl29XuKrDE2C4HimSt93PfLXbrPjVuK30Zgp30+4RIUDHlo
	VTzPn0cPdcqYBMSMO1MlkWF70yvOBK9jA38AVHrIlTi3ubyPqDZDc400AKUXYIu1MUPcklmvZFT
	h8drtfTIbHBocwYGbDyHTQQrL3kOgsNQ86rFN1VII
X-Gm-Gg: AeBDies9FNQBa+WdgFRj5fIOcCmjo6QjdQPthwSNWHZrsaLSHg8vrmv/CzEGKJ1rPtv
	dCecKi8emHRFRooo0HatDBLmUjZan51LiCKbmIhYQ7hX+T3amK48lMELIoJ2usEOY3w9QyUWjDW
	ml1bcrzp6YqRYbhu2LcfBsgJlkp66R/g4UgTx9i2CkOlCSmjGzuYiU8DrsfNiqUx9VYZ9arIkrM
	+oNT8ytTlY8vRzj6OxcfBNB12thDzHS2VC3T+GjR1vXDm+Lu4SsAXSdy91fEKASMwACVvXl0x9V
	gxYvB26rjemy9THt64Gv3o4GUTsqpmqh3A83aufKEpan28TOlX64fR81B1ptwBHtp14LQ7oy4gd
	965WN4MLKCm5Ita4=
X-Received: by 2002:a05:6102:c48:b0:606:545:aaec with SMTP id
 ada2fe7eead31-62ad4faaa0emr2260227137.27.1777573798837; Thu, 30 Apr 2026
 11:29:58 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 11:29:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 11:29:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260430015001.24242-1-yan.y.zhao@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430015001.24242-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 11:29:58 -0700
X-Gm-Features: AVHnY4IeaCzTmZjx-CnnzxAtYMnqjJZEzghoo63nZAtk-UoM-nu70gF3ZuOCUaM
Message-ID: <CAEvNRgFP9KJpWkZX-Of2mK9J57yiJ5bwMaQw-DsON-RkhvaMqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86/tdx: Drop exported function tdx_quirk_reset_page()
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> KVM invokes tdx_quirk_reset_page() to reset TDX control pages (including
> S-EPT pages, TDR page, etc.), as all those pages are allocated by KVM TDX
> and thus always have struct page.
>
> However, it's also reasonable for KVM to reset those TDX control pages via
> tdx_quirk_reset_paddr() directly, eliminating the need to export two
> parallel APIs. Keeping tdx_quirk_reset_page() as a one-line helper in the
> header file is also unnecessary.
>
> No functional change intended.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Thanks for the cleanup!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
