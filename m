Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7D364937
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 04:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845047; cv=pass; b=nR+HUh9ySRH75lZBsegLtyBGXz3aUIDWocNWvQuQGu6yaC7lm3ScNCwXYLSXbU2lcFj843GSMq35RzZ3UxZSIhWctVXVK0XRjJ8jceYKXQGW4s6V2paqZq0dLT/VtprX70g4aH+6PYJOJGBC0PijXtxgYYyv+sW9Glrgk5jJ//0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845047; c=relaxed/simple;
	bh=u8oecMo4OnYkJuuZNs6p7Za7OHUaAgAj6yv2g+U4mqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ8q1RMwmgu824CmqneFAYGmfUoP3QnEWN++fa25t+m1ZCWQ4nlTvTeCETAF7xBd4bRSbqJB/5PYA6wuq0Uq/H62IJbCpvxwcsvKtpc6SQVyL8n0ZcQCuLWLiEEWpw6/glzUiBNGlxv9Jx5f4K1gGrCN9cCcZquECTHoPWjiHAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An7/u5xM; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An7/u5xM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso5802707a12.2
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 21:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774845044; cv=none;
        d=google.com; s=arc-20240605;
        b=X6TuqhHLU4zzSLEg0nm4NjO62E0+5a0jjvYLLQr3YX55XyJp7QST1GVJiigEoeuCBl
         XiFu7fSAhDjv12q/N7WwgFOBlW41mS6MGUbmh6g7ZrcJ5Es3ZZJUIP+ZdLYL5bu3W5/c
         j+XVeUQqAe/DEz8T2WQLDSBE5V5FVZ5Gli58A5pOWL2S7QrJA4l2Z4st05TDAnEjDLxa
         yZ6SMxgQyyQZMQnUkhRTkyMuV7NcLMVsPmt30uKpuXZnCTeXhAC3nhWkrrpMbtAdPY8n
         7D/Bv7pT2qumnHZ8r7EuzclL5fi/ja0BJ6Km8jwauSlkhyY62WG7NxGOhwi+v/c2/vlX
         JR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BPjxy6libzJadxuLmZKM8vnCdotc78+FZWvRkopsIGg=;
        fh=UDD0Hu+nBh8YmnkVjWpUlEKecp5NaOFQ7wz3RFFUeNc=;
        b=CCzvHBuff7D6shAnuSPctRiaCPjz7T1rXyHWKKAk7hf/1Uhcdz5923n2/GtpPFoQ85
         3kgg5eAbWWL/htlIeUDEZ8J2eKVRSsygUGP2DoXBc8ncrRz0s4s40jpFL4fNSK10NPQ3
         Mnf3XJ7Dj7+e9To4reYB9ySvEqXY1SZAr9OzOZjgve1+MIyu+/Mqqle4jVrueTbyReRI
         x5/GU6vh+mqFSICiqOZNDRCVAUCDUY0tWVJfMTWPiDLwVPiWTzdVWqsXi019tx97KqvQ
         WKQAoWjQSyIiQrqiZxN8biGuwRahgxT5ej5BEd+MgqxHT/hpgEhNqmVHcBhy8egMtikM
         /aWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774845044; x=1775449844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPjxy6libzJadxuLmZKM8vnCdotc78+FZWvRkopsIGg=;
        b=An7/u5xMQh5jhNuy+dcN/ios8E1CUzchcSe4d85c9zhELGM+QbcU+FMd190eo3jN42
         2SZcnDUZDXup111i6HZfzpwmu4ACN7LutNe6fDj74rFF0fbDaoGeoe4Xk1HaDLHFR2Sz
         vxI6gPYoIlbIjYdSJxL53QIyiUYLAgjFd0yBgurTEEkN9pvpou4uQNaHW4+Q+Q3Vl8Cw
         k5/ffCFkK3WCW2FLsrNnJ4++b2YzEpXwRbhpTFUg80oPPengEQ4bDwcEHi9jy3fWxR3A
         RIn1EjdJ6QDbAEeC4t8honQDlEesSQl2reti7axRbssM/iS5Bwr0cNCMfGfdyHqKBB5+
         Cu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845044; x=1775449844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPjxy6libzJadxuLmZKM8vnCdotc78+FZWvRkopsIGg=;
        b=CLU0FinvvgTCsRmwtIPfxHh8Z/W8Dkf8MXCc+SZpbVJxpMOgsIiEfXchRI9h3i19cg
         UUBMsQMEtdajZowhnS/v8Dp3V3Oora3P18vm/PPUg4KJnnqqPcNQopskX/SfM1uHlyxK
         ifm7f0rhvE1GAoJ5JbHU2tu77p+vnR1aVG7+AZUEHcQeXl+YGrPL36NjvABDMr+orgB8
         oZD8mQYNyKm4sOivIPtwJYX5gbAcajU81l+GtMpgBZn/MCN8uM9l8BV+GDnuUDX4ctDy
         bZSd6VviMWTDoj+zxk7pBXp24CJ99CTDQqak+BumqNe+wsnamHiIfC7v6MXAufpDbpCm
         mv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjXDCmnat/DsE64viXm9dXMAVbpSdoUmF4tDWpAUXzPpYrWisjtSJ1t85JRfta05b8aVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXLtMp5Uah4/UBJMeyTs/rC2N0Y6QfnDNITEHuLIRmf9YfUmI
	CHdizHYqnU2+GGaWpC5M7QSBnLGv3DE87Dgj1EjHOOjfxdyu0niRQQIWhwl7BxMLb4LwziB2YHI
	WuXIU4xy4w60wPW9e52OsLHh9zh6CX3A=
X-Gm-Gg: ATEYQzyFc06HhrSXJSTYQ5x1eHpkEFhlAdErfWnZKWLQsRU2rlPvuuE/XkJbMwecsfg
	xW/Nf1OuEt7Pevplf6+tS+BUf+wZOfDzgYL4Go6CRmbkD0uUav7kwuzRklbjutmKLygxCFZ60BR
	bhlsSztk2pMBbUyWNQXtv5Q6sKdq2fLhmuB4v12RPdS3Fsl76do2/W7jwu0IG/AHeR8MNvmmMok
	tsBMYGcD0Vmc6Ppvga6SqcaRIOSVL/hqtHJVLrnKDutcmKWGJDrsrl5yBXhTvXb8sGdIpc/iKvJ
	LOzW8i5RAjqmNTjxWEy0jo7JMT7VTjVRRNzy/w==
X-Received: by 2002:a17:907:846:b0:b98:51d6:883b with SMTP id
 a640c23a62f3a-b9b502bee4bmr757822466b.4.1774845043511; Sun, 29 Mar 2026
 21:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-8-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-8-kkostiuk@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Mar 2026 14:30:17 +1000
X-Gm-Features: AQROBzCyc19tRu5zAga141IylI9K_Dcr-ZY9WcxhtTTde6AyEq3ClpnQjXi3SG4
Message-ID: <CAKmqyKOG3Aw=NPSTXKJj5QHwFzypRCr4Ra6A3FZBf7WrYEXPhw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] target/riscv: Use glib2 instead of strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:46=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redha=
t.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index a9d3111444..bca04a7580 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -303,7 +303,7 @@ static bool reg_is_vreg(const char *name)
>      }
>
>      for (int i =3D 0; i < 32; i++) {
> -        if (strcasecmp(name, riscv_rvv_regnames[i]) =3D=3D 0) {
> +        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) =3D=3D 0) {
>              return true;
>          }
>      }
> @@ -358,7 +358,7 @@ int target_get_monitor_def(CPUState *cs, const char *=
name, uint64_t *pval)
>              continue;
>          }
>
> -        if (strcasecmp(csr_ops[csrno].name, name) !=3D 0) {
> +        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) !=3D 0) {
>              continue;
>          }
>
> --
> 2.52.0
>
>
