Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B53DA5AB
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541632; cv=pass; b=HyrUWkaLH/FgSX6RinpkLs7Li5q9SV6fxIWY6JdNhxRtaQo2QxuG2NEQ89p0gA+bu838NE1hsRTMTI8p/GkaLCRBqN6XMnOy4jLwrvsUuH0ojyp56EIatpY+UumvKiT6gd8fkwYeM50SGjVa341+tas5MRaj3bkhdBpaOWKtkMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541632; c=relaxed/simple;
	bh=BdaaMK+iBtICxCq6a9i0L30gyCEkbvIoF4KCFr8YBlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CooiHBrJrJfsfJwxitzjH1bQa2LCdsiT9Zl4iPFkjdKaneb4r2jRqNFQv3+NvbSQnDMu9aq3rnHGoHF0HY+qvhhGf84SWqgkTjIaLALNHojekdL39K5loIHGrZndkMw+/o2BZdvYYUx7PGJqie4CMI94t1PKEDYgZidZ/MMMYoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=IaOgcPCs; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="IaOgcPCs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so11467185e9.1
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 03:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791541629; cv=none;
        d=google.com; s=arc-20260327;
        b=ljat508vXU8hOEG8EciNvOAp/hmuNoscHqRIwNCs0+gJH8VdCmnqyxOnz/duA1xT8o
         wN+J/Vi1UGMIFYrq1UmwxD2odE5XqMQ2CZ1jZ2UI89cuPdu0RJM24X43uT1N1yPLmbmE
         CrsQgMuHRwlra5a1OEmObXzknKXVuM6cbHMZs9uEpnx5XGxsLPt5l3NKlNVT2wWdrmXg
         1TCsTx8ps992pLu7yawuExIZcRcF33QW5artM2TMwfoDatkFXqtL/tyrQyrhvmL2RDHn
         +o8IdQ4iOl8ZaQ0BIFN3nKN1EdQiH/DnuHW6ndjxUcr1LGS066ew8lbrlgnxXENU8URU
         DoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+kGfL6IKmzWaR6v/xkH3Bv8Esmb1CJCtQQioJT43pkY=;
        fh=ZFXKXVjKUDKthxlF1pfEONnYvxs5ZvCNYrchZzqmq/Q=;
        b=nbO69MCOQdX3ewbWxbMDLXoJlb8JDEzD46ETAEMs8IO4+9OgNnY4msjDShb+6pjeuI
         20wB8YTRJDGj3CZRVPlrRUUImhK/zvTeyYdyDCSiqG5UEPz2J3hGwdFpvFSfgJBZNUsI
         /8C4OLW/WRseDgfIRSdxxOTIuhHk8XuFY5JcTwcpVSKkrOmPl9RjYdLJ15X4nA0S8OSF
         eW2mZFPidaFpYmFyLZ7QkWCLg/R1TuV3UT29/955p06pnuQO58o1MSzjGQptjG0SUDfD
         cybG0GE5ukk6s+gARI9lUfNGJP8353g1dBL/HkBAx33HtWnxT2jN8inLa0memVI21cQi
         f/RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791541629; x=1792146429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+kGfL6IKmzWaR6v/xkH3Bv8Esmb1CJCtQQioJT43pkY=;
        b=IaOgcPCsn+vt4J42WgryTbeTglVzrjtfbuljPdJ5t5bRPFFTesmrCBjKhFH0xiCoQq
         ANS4+/JcNJmWkF5jzBr82mv86Rk6wO53BLkg/OT++17hcMNneWiY56YnyBKnbTRxbXNL
         UUw9oP8hzJNLXAcDT2D9v3KSiUFNPW0R2WYGkYEAWhVzveodVX3K8VfC/1JH076u4bWb
         ATBVINcXZLev3i8xz9qKcXwVcOPOLFIV7Zu2Qi9CKYrzUz6FDKbBSW6AmOUUjJYZ/fk5
         UMmAHsJuuuqj8cX5i8VbJKiYUI9fgWd69L4arhrVggbjfkmMa5vU7df92CdOlwJ5yBkN
         V7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541629; x=1792146429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kGfL6IKmzWaR6v/xkH3Bv8Esmb1CJCtQQioJT43pkY=;
        b=nNG8Uja8oYQAFNo8JzEBVvqGXfYvSElc5mxl8q+T/y0FlSaDmQVxCDI4k2N1VaA5HK
         GhFwd0YXEU+2ie3AXUv/pKU8zRf/DEBd3Y2IQB2ugmyjxvGMHpqie3j3e7Ouxhs491rc
         AfHrQQRos+Q4t32LZItVX4ZNUak0fvP/07Qh4gGhY0r6lh47huqMSfC5hn5+be7ySlKt
         eUejqC4VKswzd2tLe51yhuAnkP9VTGaGy6rlw+ThanJ+lEA8lqmxGME79Iw7DokIROzp
         Q4LJvs6qiqypICnVr1KaJkqMbC5/y0xWya+z1B77aDcc7AmrPAg3SZJKlELDbUWAKCdh
         IKyA==
X-Forwarded-Encrypted: i=1; AKwUvBwUW1O3HFhFwL28Lwb0pmSHwsPER1dfq1Ykk1Kn66HdjbQ1ASWFOGHcFjGSVWQUc/CYMkw=@vger.kernel.org
X-Gm-Message-State: AFuF++mxKXTl8ByFJM9QEIx0sOMm1XiascuUVXH36Hh6pz6d2L1MUPsq
	gpMPMJenNNdes3Veu3s0oREkw9iuCbaOF5eQHMjS95mZoiLfr0rGp7b0EPXKis6jU3+/s555wVY
	tKcOTB63qFxu9If3APP1Ole4ptjEYj5jNx1hdM7ngvA==
X-Gm-Gg: AYBFou3WqWol6o66I83D0FTjqOe5rxCLuun7gXnlrkuWM1s3cwYHY4M9L8/kRiDBDeO
	/KWSh93Gr9zfbn9CsqXJpCoK6nPZuWU4dB3OqFvQrgstHM2IgwKPNpysVCzo0/dF0T3g/CbHsl+
	nrgWAAFvltOpzCbQN0RAP5eOTESZZ3uxrRUfZgV/U4XLjGo3t1bBTVITH2yiMcZlq4OdGzRJaK8
	7q3EnYE9m9URz6GK8B+O5srJ7b6yhGXSYIqdDyuYguiG2RvLJh/NMm3wR9F2JYoMdoEdTqkFU7L
	Ym1YcOYrU6tdLXpOY3Pl59cJQRgGKNErGnix2ZDHdv/+4cqx0rk5/Ngo6aPqfTxYwAxXSp1kU1V
	H1p0GcUisORxNuX0M76pUBjKQVL7BNeGN80JKyGT3JAMTsR810y4ovpaQcEGdh5kwqO3qRltTEg
	==
X-Received: by 2002:a05:600c:4f46:b0:49f:cbf1:e77b with SMTP id
 5b1f17b1804b1-4a18e4a5355mr31129155e9.10.1791541629095; Fri, 09 Oct 2026
 03:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925160300.467884-1-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260925160300.467884-1-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 12:26:57 +0200
X-Gm-Features: AclHuK-pEq92e8PF3NtgM83whKL9xC8DLhFEcuppkWWmzGxqa0y5mveDAWbf6kU
Message-ID: <CAAhSdy2xu2MAKwOfPNRPG68XbtQsa-CT66phvTZe_XD_3Rk3Qg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Reject vCPU creation after AIA initialization
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:03=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> AIA initialization sets up per-vCPU IMSIC state by iterating over all
> online vCPUs. Creating another vCPU afterwards leaves it without
> initialized IMSIC state, but KVM currently permits that sequence.
>
> Reject KVM_CREATE_VCPU once AIA initialization succeeds. Both paths are
> serialized by kvm->lock, so checking the initialized state from
> kvm_arch_vcpu_precreate() freezes the vCPU set used by AIA.
>
> Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irq=
chip")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index e062ca19f9d8..ccf2def834f1 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -138,6 +138,9 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcp=
u, bool kvm_sbi_reset)
>
>  int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  {
> +       if (kvm_riscv_aia_initialized(kvm))
> +               return -EBUSY;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
