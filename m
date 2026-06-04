Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D45352C2B
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551814; cv=pass; b=Buj3M2jPmC5SZydmWAHN2k7WyD3KKCcv+AUu6kY4TOtZjcmTk3dPiq4psuBHwvwAX7JLWVZjTLYp5mF1A6ieXzfK5reDprXiCEQoGz0HIOnTN6agijxMOdMhwIeS0tleY6U9HLYWqv0XnGFhi8Q/lhnoEaluHb4gwHa1iS3dl8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551814; c=relaxed/simple;
	bh=af+O8G2V2gmy7wSY6lj3Pyyjh3M9DMW3OC6yw00QZxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqT8kM3liLkn2IqGWvs/a1tvCESdo9Bklg6VmaB0pfGfjs3OlX3Q+tEMo0f/kZZ3xeeeeljPn0lpKhM0xOboz5uoYm+ek9noFB/N6E1YVU56C0VtnFElEb4kC+bTGgO5lCyaZiEyYc/lFhUUGoGGS7TaeSd/2K7ih75XD9L8Zaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Hnoe1tP2; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Hnoe1tP2"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-517654b8dc5so3127571cf.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 22:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780551810; cv=none;
        d=google.com; s=arc-20240605;
        b=HezbQvDrze3pJnYT8KFAX5zBHv4F6Rl0B3UN0ZHpydS3ZYHOQODZZjqn65Ny2suZf7
         Sj/RoU4fprm6xYgP9gXOVM59phMnMq8/HinAdAPBBpMQG47sFwrFv6kR9awbPWy1WKp+
         tNNYue0LuloR+NLac8DDTtx86Pr+Pasx6naZjWww8XUBJTifr9Km7Do1EyApi1q9TvzL
         jg6DajOw8SvoLuk34v4bnNobognr/FKympbfWiKem+AzOx4nSKBItDmJ9XhIeWijmEJw
         CrNY4ENgSm09NRhv5CzBONv2qVwAN3GoT1qIO/bRZ9JbcaX5erOoNB1lVrCOnWBAw42u
         XaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vjbEpBMrkd6U50bbMhDulG6rAcsMtJMj2QzzvisOk8=;
        fh=W6yF3SWLWSw3Bfukz/EDaY1QK5e8kngzi1Ba1/gSQuA=;
        b=NWDifpIPffJL+UkX1p9IrTuyg00xa3ldf5/RAQkFcvs/X6W3yhB9d18HMjvsp7MLHK
         6asCPUZ9+s6nds7IcSUWQTpIHWLKohpA3TkIcdTG9AM3iAr8X1HqrYof7PCTVrvUif/s
         kJ0TvVzvK4x6qTeN/rEcZ1Ve4vQNty2Ma1ibVYBihCbsWZvPxLhKzaz/VzMktF8SeBLI
         AELnUgmC8m15yt6KaKENiQLVC736qDTjpLKTany+Jm3NLuhn0z8FzLHVu3rLmPbGHv3D
         us5+1O2g7ORhAd2VsSI7XEmqMG3LPYXO7PagvIHx0RtdK6ureeqs4mPivJYRyU1yfj+D
         b/Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780551810; x=1781156610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vjbEpBMrkd6U50bbMhDulG6rAcsMtJMj2QzzvisOk8=;
        b=Hnoe1tP2tVvmQsa2Ag9pdC/xxkB4fSn8MA15TiTwdJp8JOtzaBPSq/5bklTC81Sgk8
         2fi5ILjRVr3+QlulmwEey87zIFSyM5ezMiQ1kIDnYpOyZM4oPvW88xegWn4W3skX4qrr
         rJWkzJADDvE211Zt9bwaSqfbnj8Bi2l98Tqj68loLKVwxb84f42/AcO71kkLVYaNoGl1
         wpZ5pq4o719eKSfK43kwghZfQLAVxOl6c5dyarJYtXLnuywUj5nmaaA1UCAxG16+5IJZ
         qbpy7Oo1JtcHnCCw5BRWMgtVd1VbIbPksaNspVfhAVzRrGgTBkoKUpJZG7QOsbshYGlq
         XWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780551810; x=1781156610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vjbEpBMrkd6U50bbMhDulG6rAcsMtJMj2QzzvisOk8=;
        b=HCx9ngtnSiwvwhbb0drYmFv2BF2vAvfmj4g1+iaOQR/jV1zBDt0gDIvKcrYvW/Jc0z
         2oOvlGFPLgnVdIdu4fr3Leu3N8vdG389uZeSbhkuXGmLXgggY88FVlGzZb3twVT0Ke3B
         8W6PoJl+FPXoAiaDjt9PatowxD8sbabNuBIuYO3vvG8/aI3mbWVKgcb4B53LU3PDcEHX
         YiYGFhxchZDFz14j8+c6UftNh644TZHLPId2JtmWSu54cl7Asf1/BrT6GOmtoUS1oEg1
         USmDDFIcuOHPjnAdgN6T0OWjW6ALZXdSElOnZkQoJNWd37aQ1/US7nI66u+qBi8w631B
         +uFA==
X-Forwarded-Encrypted: i=1; AFNElJ+0wMOriCHukr3Z2QBW1j+UDGGmAaz/YUFBchlxR8O6zrqnELYwzghyan/lm53T0Tco9HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqmH2UswYCEcSDIeHaRj91iqhII6gnpiyzep96joI2kr3cTrG
	jwG5TxaV9Wt5g6YZLD1pLEV0gl63gbBl3hIBS+o5zdTXB1V+sBLD8wl21rYa2YuVuF7KnJAYdrN
	DkxUq9T1I2XD+vBdNX8TL7Q+342Yz4HX39r/i4JCoCA==
X-Gm-Gg: Acq92OExDo/of78TAN5RyHY5+4/L0UM6gCjzqxlDSfmzEms5zguibbDkMgwjaOnWPT5
	k/1N1dqsDXkD9Kw1TwWosBnXH68Y6t+Zyk+b9kKogK/i8rYxcfq8/2sxafFEXy3LKEAc/VBLGIr
	DrjoaxwECSpLD6l5bbWoIWoYoANvBRSt/Ioif8FylBa3tx2HWZdsxoYrTNGqqPfBFljeIo9KhJQ
	MDD0Wo25p2kMpzD/dtWrEmIMkgHHpqMDVGyd3B20q3cZPqzh3zQ3pXKMcngOHV3BkPU7Fag+Vnq
	6Qh/4tVhQG84Mn6GXpKXHfrMCiPHpCdb19oxVzxSIta+ui8p2PVEtghpc3IyFf2Zm4MuwOBA3vx
	eyjpj5lCcRfOUUHNvl+BUqV+01cxPgwh3DWuE
X-Received: by 2002:a05:622a:1814:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-51778631404mr87800321cf.17.1780551809656; Wed, 03 Jun 2026
 22:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 4 Jun 2026 11:13:17 +0530
X-Gm-Features: AVHnY4LKdTw-t4ZyqgvR4oG_oI5TCCSH84iuLHduTqP5duPhyYA_CKeqJZ0xlus
Message-ID: <CAAhSdy0LCXF677cBuS-CUBynUqWL7d_ra8+e+uOJurLm2nZzWg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Document a TOCTOU race in SBI system
 suspend handler
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:06=E2=80=AFAM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> The SUSP handler checks that all other vCPUs are stopped before
> entering system suspend, but a concurrent HSM HART_START can start
> a vCPU after it has already passed the check.
>
> This is a known TOCTOU race. We do not fix it because:
> 1. Triggering it requires a pathological guest.
> 2. Only guest state is at risk, not host integrity.
> 3. Userspace can double-check vCPU states before suspend.
>
> Add a comment documenting the race and the rationale for not fixing it.
>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Assisted-by: YuanSheng:DeepSeek-V3.2

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
> V1 -> V2:
> - Replaced the fix with a comment.
> Link: https://lore.kernel.org/linux-riscv/20260521142030.1560861-1-xujiak=
ai2025@iscas.ac.cn/t/#u
> ---
>  arch/riscv/kvm/vcpu_sbi_system.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_s=
ystem.c
> index c6f7e609ac794..6f64a59e5d3c4 100644
> --- a/arch/riscv/kvm/vcpu_sbi_system.c
> +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> @@ -35,6 +35,20 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
>                         return 0;
>                 }
>
> +               /*
> +                * Check that all other vCPUs are stopped before entering
> +                * system suspend.
> +                *
> +                * There is a known TOCTOU race here: a concurrent HSM
> +                * HART_START on another vCPU can start a vCPU after it
> +                * has already passed this check, violating the invariant=
.
> +                *
> +                * We do not fix this because:
> +                * 1. Triggering the race requires a pathological guest.
> +                * 2. Only guest state is at risk, not host integrity.
> +                * 3. Userspace can double-check vCPU states before
> +                *    proceeding with suspend.
> +                */
>                 kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>                         if (tmp =3D=3D vcpu)
>                                 continue;
> --
> 2.34.1
>
