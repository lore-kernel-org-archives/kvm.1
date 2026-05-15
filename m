Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F43890F7
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827741; cv=pass; b=SivKdD61PmIEAWokFo73/ZgODExQKvcehlK8vMqicVr9IQjDK9BP0p5XV55ZqBe2QVPsTY1Fh5p7ySrIgUpSk2JeUEdEekVXVAcbdONPgL6iHsjkO6CqCZTizzbyk5OoLlAy9OtAGwDvcrk/FNziqe5S1KseY5sot1VeBWRLaVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827741; c=relaxed/simple;
	bh=E9V+J9hi7Arb7De8BmQ9YEa/mNzSRMFI2i3CqjTC1XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqwewq016Z5oRTLEcT7BL+P1hWDgzPGvV/msJfOKIxC6DG5SnDi9YoufXxDJCt1VCIt7U2Oipl8zfRR+UrtdY2coKf0RYUl/p6n9TW6zAhaCkJPiZ9Jd/8jzMQXmIvzDrbOteyQhuDIq3xf2su+liUjC0Szs+WXExPlCKScCBdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=koHsNHUM; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="koHsNHUM"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dca4debedaso8445015a34.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 23:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778827739; cv=none;
        d=google.com; s=arc-20240605;
        b=Y5KAHZCbXD3P7Y+VhPguPnMdnL1K6xR2HgDcsmrvWn3ozNTLDL3ersOTBihZSUA79x
         eHHbgjbmpa9jjXj7d9X4pIj8/mi4koAHUshGPlYztLaxKUv14i885/iSD/L7rpJOAery
         PEAAqE+hAfR4P/xLqA6w5HqyJdSlMhCeRKy78rchy0ftnWw3eW8us5SWBCz59w2a41lL
         3CbHOsG4NBL6la9MPgbdCwbZEq7WHhLHx++Dd31JpqLVJz3EzTiiehlKq575bujwvDlZ
         moEMMlE5AkuFYoIa0j/dS1IUyXi8cy3PtlsXSsi0AA3fKot7BTEfjp39yonQ0wA7UnM3
         hmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJZeZoi3lwfWnxM/Nl8ZViqM1Fkj9v9XGZB4s5D/a8M=;
        fh=qlr0zq4qiQ/8a3g2EgeSrz8hUPrn8tKkTC2blItW0Ag=;
        b=FCdLkF0Oq2HFj486aZccvYR48uhd7Y3G6mCK7p/QbxnFlPj1VvHrNe/7qJwKG+sajH
         w2MABVrrE2+TXy9Y+4z47/snZ734LPlqHrFuQ1aR6WzNYo4PBOL/5F331+OYUyT/0+Bg
         S37dgWtQcwkKTSpXPydxRGpfAkn0H6XfY5twab6C1fbz1kOlhhexN7EKmDPboOiGWNCP
         VX6jzP40QHIdnSrp+0SAlXSsH+TGy/R5tJ2v2NT5jMjyK4Pr0ikmolYOzCbNV1l023de
         SExttaISSKHWiFhliLZOhvpxSNaNTW44SxjBvdHNA2x2Af4X+3eFR6zXbBY4L358jMjZ
         y8zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778827739; x=1779432539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJZeZoi3lwfWnxM/Nl8ZViqM1Fkj9v9XGZB4s5D/a8M=;
        b=koHsNHUMGgkk8JaCgt/Gul9wYhDvrT6uOoY8hVOustGCMDXeoRtJTXDc3zR4g0cyK/
         DkQtitzRvt7BrsYx+q4mqHoexyaliGHUbbuMl+h79r1gFh+AdXU7sOW6Hk7ZuMSL35u0
         yI9nRDlHYQBCx2IgnhssitWiqaLv4gUZ6jGxdPdXvYeWcrHWOdd7D/vfsCbmUnl9tGu7
         JKLc82WJswAL2JY3s23ky7Q71ydhWwdJSUz754loBX/xeC8bZ/k8TIRY4NZPXmIKtwyH
         7p2lzTqBuPeFJl+omF2/L62nIDbVWo+t3SWzziwHnUCmdVWv/LGs3Rr8Tbnt7yKvrqnd
         ZF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827739; x=1779432539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJZeZoi3lwfWnxM/Nl8ZViqM1Fkj9v9XGZB4s5D/a8M=;
        b=ZzZTqmvw0VvG01voEuNzXdg6CN8QPEWT0imGPQ/AiDa8IUK6Mpw3TYGDEKMPoT1FJQ
         FM4TdUCz3KxWL+Nv5EloM0kZnaAxYlnANHRrkz7mOagAPpG6PE1+x39+ywKdeMhXdB8R
         MGIMAKWkSzUXfbzb/NTSYp7H+MbbRjborJ87QduKeDG633LStpRoUS8elGvniyQf0oqF
         ZVHPsEHXJOh5Ms/QGDDFVC3GRdUjwAeG6ZI5xE5B6Re/23JjZGTtUrLjmYG5yREMXKj0
         L69n3IYcj2EN959+pGmQfopuKuJ+BrsKSFd0ajLOeo89WHTU1C1FD7HM1BB5NstHTHPJ
         YTMw==
X-Forwarded-Encrypted: i=1; AFNElJ/bt+S+doCsapGFuxwTm9VOz0SCCjov2PVpTJvb657dKKTyV0WIc1gFo5Hjm16UeH+Bf8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YytaGgQ3TznTgmcuwmzISsMI04lFqAO4q0hpKcnZxLUl+eX2u5S
	gAL9+SZfHfEjS3eMxvDXEjxZ/MtSLvFRWVX3t3OHg1JfgnrLBPTYOZxjLy8vvfbVkIRqNtsNgYO
	Z6cDvIshMda2leISXxiC0fcKLjs5w+wcV/QxCe8eBm0yFc6aGE2vx
X-Gm-Gg: Acq92OFxPwzhtAbU5WqvBz9d1OuwInu8YvuxvuoKR9eeNMlhRU5N3n+Y7OHg9NYxk+Z
	GhvIPY8cuzmiDBy4Hn7hq4nxqLDrEeSzlOeiqcTeqndSatdMPrlk/wbMu8ONiQ0w726SESXjKZB
	G3c7YVyJUDauw7N2C3KqB/4flgTx4zB/OzQ4BuKYbcA7WonJRqIJEnAs0G3wQrzCNKQDeb/jWdR
	mT6UYAFYLvsj/amf+pmqnJy6qk5S+sib6wT8wU2aheNd5+DKQeFbSoZ9mUZEHb+l7uSkhIMlnkW
	lI64RNku/A1mIXMzGLyrHNZh3co6SlPNcPhBesKDvLs/HVi+P/HpA5MYuxnLrXL2FaKNOELshsZ
	WknipYtgAQigwCK8tz4+imgbf22c=
X-Received: by 2002:a05:6820:174b:b0:696:29cd:bf4b with SMTP id
 006d021491bc7-69c94b454admr1633046eaf.51.1778827738723; Thu, 14 May 2026
 23:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514173642.41448-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260514173642.41448-1-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 May 2026 12:18:45 +0530
X-Gm-Features: AVHnY4K8xzqoM5FY20mXX1nYOkYmhUWalyMOR_lK2NDzbN1JIwAiJwlW_5f4ndQ
Message-ID: <CAAhSdy1W_cQW0NfA6b3hX8CGtShZPgwbk1hhRB0jns6Dm+b9gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: kvm: return SBI_ERR_FAILURE for
 pmu_snapshot_set_shmem OOM
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:06=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> kvm_riscv_vcpu_pmu_snapshot_set_shmem() returned -ENOMEM from the
> SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall() to
> abort KVM_RUN and surface the error to userspace instead of
> ompleting the ECALL with a negative SBI error in a0.
> Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> handlers and kvm_sbi_ext_pmu_handler comment.
>
> Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as fix for Linux-7.1-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index a935ed96bc17..91aa0155a420 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -453,8 +453,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm=
_vcpu *vcpu, unsigned long s
>         }
>
>         kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> -       if (!kvpmu->sdata)
> -               return -ENOMEM;
> +       if (!kvpmu->sdata) {
> +               sbiret =3D SBI_ERR_FAILURE;
> +               goto out;
> +       }
>
>         /* No need to check writable slot explicitly as kvm_vcpu_write_gu=
est does it internally */
>         if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area=
_size)) {
> --
> 2.43.0
>
