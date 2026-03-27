Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBD6BB5B
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616916; cv=pass; b=MD97Fj88CUI1fT82xTk74o24D1uuKxH59W7Inob+HU4fbcr75CuIw5aNdX+v1KCiksMLwB6uoECNJrRekFc2uYMRnmN1RvBqWjJ7LjzbrlNdODtXdwULzdujOl/RWAypUgrtc6qmyOslG6BCt50LeScC3eiH2y8WXqDrwftZcks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616916; c=relaxed/simple;
	bh=jJvzAugtCSkcU1V6RJNHAWpr8JqHIq1Yhf0msWw16uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9kK4Hpf3JbuG8Tbh60B0H1xPvTYdwqNdl6gmR63NBJzO5xiGfX6mG1TanjV9C2hArC78wstne66diVfhSAsJzoANcGJgWDYeQLQNPXq+vw2Equ5s24KJOWye/nx5/lKdOJQh4WOxmOU3et+P5jkb0PGhmqbrwZ5X+BzdUdxg+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=e6oOCWiY; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="e6oOCWiY"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46726528f1cso1306264b6e.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 06:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774616914; cv=none;
        d=google.com; s=arc-20240605;
        b=kEgqb8NXQmmmGpFEY2A1/PdcVWfCuE4fMsRLZmgoo2tPBzkQtpojgIrQhEMfuu+Mwx
         BUg8G0RBGn7TKlwOswuSgFtCgVIKO00cJQAbLGAFSdaZOZLR/r0wf5QfMYuRPDdHo9ps
         ruazNNqgELZmkI4zNYSHsQ8PeveReyjjTcyzZoHQ1Er3dEENERhjFWE+CV7203kJ9gzz
         0Vz+g6taYBCo4VKxXWQCZLlYAT8xGsWHUSyNjkqNxWzovwpl2pz/Uh/+ZqLN01VHga2r
         Zch6mIg/Naj1d+CcbWUk59usC/j6yQCQlo765p9VwVNZ9FZzWR9KTfDj1MeafzIa4vj+
         /0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmbMPpAvEXl89b9DDmueCespLqdFhwnm0SegHcujUGk=;
        fh=N+Uhlc/BfJIyO/ewQbZPSNpotg76leMJxBZzRQVGKYo=;
        b=EUG8w9JylIv+yVPbf4PkuMinQ4aK7LPiKRJ8AJjCpaTxgfHnBYHlI3Nm7Eqgrt5OGm
         zsJE3pfkNqzMIV1bq4saf748f7mocob2cD1E/Awjwkj/VzAtBZDpTPbwKtfnB2JFWhWX
         fShpyhVdI/uJZoobbruicLh3SrsLlgtX7qGtjEMqWsCHdW6G2I3uAO0+PqkW9h+6D4R1
         VakRhUAUTEPRewdPNSd8CLsy4bUwHu3qP4YlzPUs4fR8v0Ivn8BgsynqYlR63Z8WJmiK
         95oFdgYzeWkQ23nINqd8AemxY5BxjfhHjQI2KH9J53Bz4NYwdaOPOV+AvOnJcayH8HYM
         bQtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774616914; x=1775221714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmbMPpAvEXl89b9DDmueCespLqdFhwnm0SegHcujUGk=;
        b=e6oOCWiYCR7wNu06hhv9zaGlMTNZ1tiH9PpvKaqUfjUYfy6a4CFKxIYbiOnVhd7MND
         q06iWlsox+uvBNVjtjjqNYT4bfbymRUl4pRPdaTAflyi4RwSmHUylEBk5L0P95OhjqJ1
         /YphhBq5qpXoyNLEPmkpGSK5kjgNzB/YIB/6pgQfypyxLat2mjDP+t8c64+bBQb6SJ1D
         m32DqKUc/SCNhieNAxgtJz5ZsjP5UG0rcu2RA3rpeE0vXAIf4sJps3p9VP3jMWptXNs6
         kFkFBLciLOK6sYIDt17XQKak3HoQVIh18B9tKU62lN1/O9ZgMlHEmfceCP2x2CO18iHg
         Rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774616914; x=1775221714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmbMPpAvEXl89b9DDmueCespLqdFhwnm0SegHcujUGk=;
        b=NDXlYxdzMQL6h7j+dFU4T83qaD9Nd3QBvHt9khscRiNO/1HiSYZezTbD1EurmJ5igL
         R4K3ogy32/TNNsTpwwc8roLHr5gG1hlXGxuFkPBwsUuBjmhHxPCKwWD20EIWP6rpMNL4
         xmDNoawKbZ+EMhfzuHRJlrWT0eSpEIaaRDK8rfCSHujuVgxMd0lFv6vtHQv13e6hxIFm
         WbhNqp0ta3w08tI9+4r/602mxwMFY1F8AbGFm6HTbmIicSHwBRKS33m8GBcKqA1L5Jxw
         rnvw1mOvwoJkjg6SGBpOh45EJgDQG2L7LK4qaeAbgJmZv3rHmJltvxbAi0vMrhmK/68v
         XcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVdEZRhvOcsVOWLUcEkD7u0uuZte1TQBcJURjWx/BrI2gTBVD930p34EGPeIz4OJJI2BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxM7zr9klqH8LEkJkZA78wQNiL2/tBj//6xrICAzQmoloTV9cA
	5XaMXJlHAK9iZU2ERuMoL6wbzSdtNQFTM0gL3bzwHosbX3tSycQRohScx1nOrAYc9Fww3a7ng3A
	6aHo49Y+97eS2dc88aWC1QrUVQ8e/kvciX33yRTE8AA==
X-Gm-Gg: ATEYQzw9w7QyarB0Qhd4q3FW9X34UgcZmbm7ntj7me/kRLerPTRacXkxUfv0M9XKbBJ
	txM8N9iuq/7Mu4xFQ8BlRLDqTYKbSZN7C3PW9qC0hrxmC+mNMqc4OHxq18ofZPLCZUNMol5jsKv
	+qVG+Y+qkl3BuFTQisYcjpZXKYprCYBgaWvG2Qi9D/StamACzGu/ockB+4dUSalioViOjEnHGuv
	CCcaRR3YY+xDseJxTiQNFRo3O0pywK6b4ZEEsejR2nyDRtvgtXT+eaSxkjQudUKBMktvrAG9m/H
	F4jVRJsO9qxh6wqUYwPV0xWqQYBfbrS9q7xgi4R7hO9pr354DjARPLKzYZ6+14+MXCDsr4D1vEF
	a8lc0hfnw2vR725GKj9UZTS5L+Q==
X-Received: by 2002:a05:6808:1446:b0:467:3f4:907a with SMTP id
 5614622812f47-46a8a61bfc9mr1080873b6e.52.1774616914163; Fri, 27 Mar 2026
 06:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311231833.13189-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260311231833.13189-1-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 27 Mar 2026 18:38:22 +0530
X-Gm-Features: AQROBzDaiuO8uOhM7V4GcN6kMarCQKRgIGfEl9WOxz4H4Jv6lFJN2-pYAWK-4is
Message-ID: <CAAhSdy0kGyp6APnB25v47jqNeaFj59ff15Ja-Kyj=9AXMVQSsg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:48=E2=80=AFAM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> When saddr_high !=3D 0 on RV32, the goto out was unconditional, causing
> valid 64-bit addresses to be rejected. Only goto out when the address
> is invalid (64-bit host with saddr_high !=3D 0).
>
> Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

Queued this patch for Linux-7.1

Thanks,
Anup

> ---
> v2:
> - balance braces properly
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 4d8d5e9aa53d..ec0c15726da9 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -423,11 +423,12 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kv=
m_vcpu *vcpu, unsigned long s
>         saddr =3D saddr_low;
>
>         if (saddr_high !=3D 0) {
> -               if (IS_ENABLED(CONFIG_32BIT))
> +               if (IS_ENABLED(CONFIG_32BIT)) {
>                         saddr |=3D ((gpa_t)saddr_high << 32);
> -               else
> +               } else {
>                         sbiret =3D SBI_ERR_INVALID_ADDRESS;
> -               goto out;
> +                       goto out;
> +               }
>         }
>
>         kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> --
> 2.43.0
>
