Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAD21257E
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574709; cv=pass; b=iA2ghwPvIcwbnX+ElHtXnY0FLrOedwt0Dy+q3ltzWir5AOxZcO4BS3lb7ZODR/HDC6LEk0drYlV+0YRu52lFT68d3Op8oiADd3OLrTlpoCwATGe0XG8rjoJ8WTI/y29KRGsqVJMYujMLDMaw9zzqL9ivitc8y8B+Q9Q4xC6lYrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574709; c=relaxed/simple;
	bh=bb701Q8teJSTMHcxmolgthmZiSRCIlhdxDfPwwPhAnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHetbhw7fx1HJkNlFIBy2RChRgp1Rp1pN1In6C2zLUvgPS7ZKuVCOnEkxE1DFzT5jRbXvptIX/0H/m3DfKhnM29zR1bwGFgkxZbBwhPHjXhB5nDdp0Lu+ztS7UtPHFHg8dZVvJxT1z5oEk5A7NFjMiwXnGLF5nB5yxFBELBD8H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=gn3mE+3o; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="gn3mE+3o"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2236728e87.0
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 01:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785574706; cv=none;
        d=google.com; s=arc-20260327;
        b=AZG8wKsHVlPjposmKQW+c6ExK+ivbo7xjub3ExobFmovDeNj4VG1xwqygfSimU3nqR
         8MvJXMD9MN/AmEj6Wh+Ql8qhb51ZUAFLbGM4FOcmG2lZeT7oHJ3D++TDHAw5IadvZyAD
         SkGTFVv5VvX9D4aDIUtsFeWjO/50PjUKZ1hzA9L3mDkGN+rLtdMG6DawRQkmbrd/I6he
         pPgE/AXR/6WxUhvghNB8dj9ziW3Q1hsIDJQOq6fTMZTtd3HvkayVcEndbFmGfYIeh70i
         DwpqYahGXljk1mvj4IOvJOr5jMUU6jjD3Hi6G/tVi8b28OhUtmv+XJDEhflruDyN38I2
         LyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ot7Bn3ZEURQrk42Oh0sapiZcIWCpwwKzFXd66di2HQw=;
        fh=X/lstyDC47p7PJSTGoeNF1VYdMhZUmmIvQPPqFOsHDY=;
        b=DTNvgPIJCHGrkZsJf3g/VfZpWvqs8mqOS91vlKLFAqUTWqm4TfrNyb//XOXKH2kTn3
         QBmxvJHO02CxmbVnI+1kff/fe0/BkWS8T7HGG2GmViXDvAFAws4DDqRjdLmU8SKkGHG2
         QSQrHfcaDJc+7xmHgQwSk8gMSchIUxmWWx+FSoEEJ+3Bh6EhIUMlLOI/5KYNiRCCCGVP
         fj7fIwnY612HDrdayu7C+7Xr6y4G2EUXebRlXjXCjBuoxF8XJxLE7UqzVHK+0namXHeP
         fU0vzk3wanwc1KxBgRT374tm91OntziLgdsjpvbcO7rsc/j1SYmswn7eh+CXPem+q0rd
         RlNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785574706; x=1786179506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ot7Bn3ZEURQrk42Oh0sapiZcIWCpwwKzFXd66di2HQw=;
        b=gn3mE+3ogq9CGZ/njFH2J/loPwBqRPnXD/B1RpncSx95f/EIukFSYvWFYGe/4/kKUZ
         RLXiOhB59JvhkrC8UGh4lfEFv7fs0gs4BTrHFrNCtBjmklkSTJPF8r7gAiXoDtwg8Abs
         QOFjzqkeZ4tNQwU+8pFd4k0pa9plDISZsU3uHEcAKU+xQsIPi2cmBhKqqXKBeMltBU/H
         BUQAYYI5UxVBfE9hQQqST3UFBo38z01cp4SmMgP08Z0bmJEmiq549I2jYkqsD/QMlq2f
         nXOZCDXJkmjjOpzw0gomaN2sUFJ31bEJV8yBgx/LuRKDHhQrIhOSqNDWAllbrmBtR5lB
         u9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785574706; x=1786179506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ot7Bn3ZEURQrk42Oh0sapiZcIWCpwwKzFXd66di2HQw=;
        b=FfiRT+g0ONuC4clmzSKSyvgtgpBEXT4Phcdb38wZE4BRrId0Sj3vX7ieLL2Yt0l53f
         N0PvJ1ZURchtnsrIYJFTsY1QenB6ia9sOTSjZyj9xz5OEF5iK/YDOL3Vx1REEKyEy6jv
         bD663WrLqMfcwGOMws2n4bOl+iQSQOCZ017KGzzFyXFGELNNzhrYZfEKKh9qJCSZyTGg
         VQrd3eyRVYE51TMT8RXC1uL7XUdpxeAw/Z9PhhCkqzLZwQaVfjlx6p3kSIsCSjIpG0r6
         i0mwUsAaC6/HxTCiD2cQWrwgpqOgmOXzZW8ocMC2JVJ6HW+kgYyOzhA6W6bSDu/KfKzZ
         mE/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqnyujZgjXReUJG5F5QI4mpUxkr1VKkpjP6Vf4aqI7uANDY3BwoQTSUuusVWXh4fsV5l80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNL2nrySmJCr465c/KWsK3MlyJ4hjS+uwaSiHLzpf+GhcFjSV
	lLrIVy6epoYwqkfxGX/jrKGSUnBUcIxtuEfipNvzDSkK38sG85k6ncSpJaXf9/KYanmzUJjR2qS
	erEeVS1C9Dep8lUutTYlkWb51D2lGLZkIQCfYo242Qg==
X-Gm-Gg: AR+sD12egAz8CLxFrbrw0FwFelgjIGe7EQH7RKI6Scr55fdAmwVVQ7kHCO78gKteLo1
	6zDSL+FiWBrJWXvCTzpoBLeCki4bzq+yp1cW6CDcmXenU7MIxqU5zJHCK7MJRCoP6G5ibLTcfnc
	o8APwCbidLZ3rV/saw528+4POZM0dSdpRy2F+Lf4IQ927TV1lPsGfVdCFp9byLO4Tk4ZyNy0l7F
	w0CfrH/OynHNwH3Ir+VF9ufL3xo+ldVM39x+NY+2MlIOSdKUSVebs6wDq90V7C5TI2i46F+q2p1
	/9zC7QuNo+HVtPMGa2RcduxgTQ4iFSBaDDFmSihsHMmftpeebBSw8sCHLUKLnp2wt5bSC+4NVqP
	KL7/YnjBP0klnNQOEpbPozbumMMGwoc/XIhBbGia1n+Pax/wEyzg1uG4VseQFMQkl
X-Received: by 2002:a05:6512:1093:b0:5b0:1df9:2adf with SMTP id
 2adb3069b0e04-5b2e4f3cf51mr582135e87.28.1785574706057; Sat, 01 Aug 2026
 01:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716073756.44153-1-min_halo@163.com>
In-Reply-To: <20260716073756.44153-1-min_halo@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 14:28:13 +0530
X-Gm-Features: AUfX_my5qj7P0Pupl53QfIIfW1LsY1looLvmcDl2m-c-rMFrzQ4zMY72aHpKZiA
Message-ID: <CAAhSdy2eTsxG=aoXb=LqG6+=mthMcwTY6cZOi+NSvzHJ0s7r=w@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Fix infinite loop in NACL hfence entry allocation
To: Zongmin Zhou <min_halo@163.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:08=E2=80=AFPM Zongmin Zhou <min_halo@163.com> wro=
te:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> try_count is initialized to 5 but never decremented in the retry path,
> making the `if (try_count)` check always true. If all NACL shared memory
> hfence entries remain in the pending state after sync, the function loops
> forever, causing a soft lockup. Decrement try_count on each retry so the
> fallback warning and return become reachable.
>
> Fixes: d466c19cead5 ("RISC-V: KVM: Add common nested acceleration support=
")
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/kvm/nacl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 6f9f8963e9dd..9aff03c4f667 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -33,7 +33,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>         }
>
>         if (ent < 0) {
> -               if (try_count) {
> +               if (try_count--) {
>                         nacl_sync_hfence(-1UL);
>                         goto again;
>                 } else {
> --
> 2.34.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
