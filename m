Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA7426EA3
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612301; cv=pass; b=toUjZLAlrIyFd073oV3RsAJxYJ2njBZAVRJ5B9/o+txMAKIHbYblud3IJb/SLO2yLLFJEg5QiRNGEsBOkBkAUz7YjLhPBGRcdZoFRZfBYhDRws2m0HZXaMAMbtr08Bf5ZG1R+02HhDVF3IM1cx1TGc/m8vVaFYqo+AGUeivEypY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612301; c=relaxed/simple;
	bh=CnOR5RamZJxR2OSD6C6EdtUaJE3sBF8ndNgsESSRB5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA/5K8V7TWLgXPujMIH8uWd4seaQ8ypfZ5bqeyS1Oit4bIn6DYc/PidbbNWposVarJdofE1Rg5fwVb2GC5auP2JULwhNJAo0huL4htuEUJ6xmD3MGDkRrkUjEPHb9TeJ/YlECDi+OXOte7mJP+LX5e9gl6K8B3rvswvn92DrDxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMc1jOq8; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMc1jOq8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ca70925c25so28368135ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 08:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783612300; cv=none;
        d=google.com; s=arc-20260327;
        b=ltyAMdXXEBADr30NEBQj0GCMgJypweXhPnrB3wenqD0zpBHJeBfg09HBJZYBMcfSDF
         u9jAB+0lykp4Y1+MmNkqK0c82un76NIFGO0VIAp0vG5uCtH3WH2U5UDFB1JkKJvneSfO
         sXpT3n6y996zQxK2VDZz895g6dbe6HE2gtCUxDZiKidyugN7iE8VE4jLp+N8IZCr7Crb
         KYHtoP2jab4/IycWnGb14ej6/HmuCOrIOixY9iYNJIlgq5yu8D1cloPa+lhSs6Q17AzO
         afU6OnNJDYcpTEkz/yli8obogm8AbN1OpjiIcqaCD5YszA+B8fNsHqQ4PnNkO38Uh8pC
         8BGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
        fh=Nv3+7d0IViqYDGbDw4JcMrBen1nnkEE/qtpb4SYnkSY=;
        b=TK4jfMFWVfyfnFQYiudR1PC36ZkP2P83/+4xrJofWsPKAFfCryiEJfyThT9y9CjLbz
         eJmH7OJqHSl0ZcmbfIHBTQaxx6w8RkpCxPZTPZxXE5FtcTxGN0yHW4iEihWhe+4D4diL
         MJ3OsmsOT2N0ytCeaBJqHqGQL3fx50GPa9Vfgx53fz7RXjLCUzGZ5/iqcw9TCLlmG6Lg
         PHJswck02REejUqz7gpVKSVtUSnlkov91tpMMH4Fdo+K1D1TXPgjMXgK7PxlZTZ7EDDJ
         hsovXZIuyWFyFdgoAADKblacdsdJWFkx5CzVs/pKrv3GHwXVADZWR4eKa2MUiWw5iWQb
         5ZfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612300; x=1784217100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
        b=eMc1jOq8TDxaW9BjAF+TgUMtJtDglYCmQ7IIsYQ05Io9mzOebWrhexHbJd4crx3x5Q
         twQVC/+AOiFQgBJim4Txj9FQbhgAM0Fxy+at/YYVU57M6bj3CC2QDYnDB+ZS9BJ0xK1p
         sfks8SZ3ENOclIWGGcEM/m65jzIlioxc8I36xBpbpzkGgBcoDQ8qO+uIL+FBp5EH3NHF
         oclvWLrhnJLTkJa6ayUuBWexlckWddPdiLd7jDo5CVhixVXqUgbJ5AtU08clT1TuQpV1
         MYl3BN1MZCIyg0rae5RmIzh3OS88/fGcR5qktZFpkEgqMLM0wsVSZGD7Fq1g6BKt0fkZ
         KKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612300; x=1784217100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
        b=Hd3TBaacBtMaV1iMu3DFp3g2I7/rt1qqX43/MKR9h5Hh6xJyJQgovpgC72h80OVW19
         kgQd6q9ce0qq4X2F9aN+UjIrVMcO/pZ2TuZgeOSLbztdQOEe57QVT2/3Vl8jRJhFojwO
         2trxhj4wyMQEWL6J38aqaOOtNrnBq7EMClsdoMt1rD5PyX8+zuPw6ciYQqOWwe25lHCC
         YK6jIPDnJglrU/2cGAW0JexmOLzbHpzz+MAEWVqVPBc/WcEJ6LraG3moN/b3TthpX/a/
         GG+o74WzeMX/N9O5yAHXrhclNZyXA6ymu/cwYDpQMNpTCK9fH2IM9v+f3BpsD+4w4SR4
         x2yQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2hHcnx5BdM6a3uDrVsGxpk6Z7pyKVu4VHebnawOBLR3leacprKkEEg93Cleh3cmz6WKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVYIkYfIsTspsylepFCyW79pmwHSCq2X81h8NvxI0VQnJpiem
	AMCISYJ0XLoPbYdUVpiPoWq38qZnatz9Eh8z7QqxZWe6uhDaj8c8/sNI+lSxkg0hHhIEBI/nyVx
	Gg9YtZGnZHA8ZKhJ4PJ8mR5nMgUVCgas/KyYf+OjP
X-Gm-Gg: AfdE7cleotE9IFdEZByVkBFnuodKCAX21qrsTH0sll5nioNr/8os7CMfL3g7HTxjCi1
	E42VH8n+ZbuKyqaFxNOHfoBu8jPeYC1uKe8EJilQWFSRmLoVg+ke7ukOlTCiIFJTQPhjET/efXp
	+JzKdfSoFycn4Ix11C8EsP415AHSzx7J3+JAUmCatutqM9FASMqa4sJPp+glMRpCzXxxxGGPz06
	zOz5X20GMfyWRj6S7vRU89Moh1VY9p8cvilpzWbCx+YvLFF3VhIcrm4dDg4xRrnTpa10lXS
X-Received: by 2002:a05:6a20:430b:b0:398:77ae:8d8b with SMTP id
 adf61e73a8af0-3c0bcf163d7mr9590607637.10.1783612299159; Thu, 09 Jul 2026
 08:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <akwyZvbv7Fg8mfB2@google.com> <afb9bf4d-2258-4731-a28e-7f4eaa01ee0b@linux.ibm.com>
In-Reply-To: <afb9bf4d-2258-4731-a28e-7f4eaa01ee0b@linux.ibm.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 9 Jul 2026 08:51:11 -0700
X-Gm-Features: AVVi8CfpfsqwkcJZWry_SVaBgp7lq6qU6G2-M-O5llXVY_AFh-tgNmotP1cgLe8
Message-ID: <CALzav=eB5NwrHNq4bm2ooSFmTtGk3sfUk7_k+iE+Kwm+Jc9LFA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com, sbhat@linux.ibm.com, 
	harshpb@linux.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:49=E2=80=AFAM Narayana Murty N <nnmlinux@linux.ibm=
.com> wrote:

> >> Feedback is requested from the VFIO and PowerPC communities on:
> >> 1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
> >> selftest library or move into a sPAPR-specific test helper?
> > Responded in the patch. Let's move to their own file.
> Will do. v2 will have:
>
>    lib/iommu_spapr.c         =E2=80=94 all sPAPR logic, compiled only on =
powerpc
>    lib/iommu_spapr_stub.c    =E2=80=94 empty stubs returning -EOPNOTSUPP,
>                                compiled on all other architectures
>    lib/include/libvfio/iommu_spapr.h =E2=80=94 declarations

Just one small thing here: You can put all the stubs in iommu_spapr.h
as static inlines, then you don't need the extra C file. e.g.

#ifdef __powerpc__

... prototypes ...

#else

... static inline stubs ...

#endif
