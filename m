Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AD413D82
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492364; cv=pass; b=I3C1fF/OVwckGnMiXiUjN36guOEbnQoHFzHIbhENtuov4Y+k2efucf0Drs9w1rBqkXVXFS5WGWkwM+wh6XXz+F2tflFk4GpC7/jC1lNyP8IQ5c2wWtZ9/xwlSnm1MeWd6YxskALU9CFHi7QeK4/lj5i2VE3FCpjlmZW9mbYCOTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492364; c=relaxed/simple;
	bh=G5PjkpGqTE4bfKxRdpR2dRA+pOtOM/3WbhBCbX4fXfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baV4ZD52R67CaQs/VYyTtIhrLON32Pxaqy8PJUZt1DaMu38ICkRDtcu7HJhDhVrvGpk4LJSatgpG3awEumFDvUbo1UGNCBuvjPOOMd3/Bl5brKalpDi/cdP/y8Ibzuv2Es7E+r7tn/mjVJcx2E5KTnvQ/P1BI2fVxIrDhpN5qVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=qHb3U+XI; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="qHb3U+XI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5176fab2badso12201801cf.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 06:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780492362; cv=none;
        d=google.com; s=arc-20240605;
        b=LKRaYGN3I7veQMQHszHF4n4roWR+ujWTwSHWL/KI+HZLxaKDlPB49C917t7SuthFOn
         hwTkYNE4jkVLfjsX0Hl97URvoa+BW5aq+fHpgUS0ZvMtTLJsdLSriOkb/ndmk5VUQ21m
         WUGUEBkFSY1LeKCAPP9r8ig57VgxAbIolWrCn6FvcyS7HGv6pQosNulpE7qXfKvINtCu
         PHR2/Ymd/ks7WH9cVJQOOI3i5GwdnKrCd4CJN9EzxL4M5agoK+NTggCYQkanPSUBLziT
         M5nUN3uyirlPzlq5pcYX/B0F6M1eK5hHEBkSxhleBWv7JaVM6Av/b75m/t2CGoegdekh
         kohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wPKsFlEiyLRyhzwx6niYPIzW14lmqUQ9SsuDRFLQ+5U=;
        fh=jWEvecHi2xwqSI6TnN+MTRzMJ0Zaum6qhPovUCY1BP8=;
        b=Zvtd8HL11SNUw8bW7em0wHZO3uwztPj8qAdlZi0tnoGMfb1g+S4Sceb9kG7Ww1cIbU
         ogb8ayMdxrHJ3N+OeTAXmpPCuJu4Y0Nbz6dKusinQgqGs3rxU3i83Gx2vd4/W17H/sJG
         rOz33Uy10b43d1/B6Bj4vHD9Gd30H1LwI4BepPwv5ZYLzqZxNdsNVAR7sku5WkwJp73f
         E7ZbaLG/JEXZT8i/0Mz0T2as0Q196stcMKoY8lu+294lw1C8LBoVU9IslHMdAm5ZI+hb
         a7eeT1j5lB4DSEMlFOwvoxpbTnpI/TSSVsSWUcMnwq02xmklIRCzAMJJvANmlhR914ut
         SvEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780492362; x=1781097162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPKsFlEiyLRyhzwx6niYPIzW14lmqUQ9SsuDRFLQ+5U=;
        b=qHb3U+XIhUiyc9u2ka+0GunW9U4U0+KBzhwdXkTwk793mZyPbpgMG4DWb2/3163JP9
         tzwnXXQsm2+c7ejtw+H3O3C5UPcfTKp0HJjaVbdr0TAe0xI1hlOeIX1whlj/pG6/hApE
         eRFxiOwBvS50Gqat5SxFt7MMWUMmRrg5nvsBGCYnC4g7AL2cX1Ap42YMrgjIBBdn952/
         Nc2njFDJUaIz84lYelpOgYR7ohJFWashxc57q5F5UAwYc//SIn2xZZ8lLyhAv1o5P+tn
         uoPPUshPCHYbUs1S6nPE7XF6NHr4+XUuHliCanpWnLrL3ughKbtPpFlsYA0KexVPedXj
         S/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492362; x=1781097162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPKsFlEiyLRyhzwx6niYPIzW14lmqUQ9SsuDRFLQ+5U=;
        b=RiQcpfLGUgZ8rcB/8OCBy4HrEdkDMBUw+ySqaYU4Q20TOJK9MYTfgmkZHHY6UyfMMq
         yrC1WWTqvTsVkqGr7Ax+FJYg08VI7Z516J/XbdkPhPuSLJb/53a0O9zwn3f3I+vtiGZx
         nc6kofCgRs7vZ/u9+bR7OY8KS/859E101gnt7ZgOyL52ArsBmG80ZGNAUAMUC4cN1a/4
         OXanMABegmY+nDqqNfb1GT0uvEWHFbxL4EZHmK2xHaq9Qf/+rPlOoKvB7RSivLpYKeWw
         GhCu5OTShs5Y+i2FejyDZfffOSwW9PN93IDfZrNLjk+Y8KpR/kyfKZxyaJfRQ4D/04Ks
         GMRw==
X-Forwarded-Encrypted: i=1; AFNElJ/qg9dT85TNUljY+DRNuQnv3r1lrCwvFMkMvRMlTI13LbsbQOzmFSB3I03Va9VGP43Zz4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoI8bsx6g0bj7Tbbf0BrLi02Xlke1EbxKx/pZCPgNfK4QHvhGw
	SCX7QSPsCEJ4XxVVmBZ0wD/WO+mUERFuzqugK8OEAA6sLBXeM8kcn/rVVZSH8gr/FX4ahqhkU7l
	Yr86ByEHIz9d02F+9HPNEMhZZvSht0X8JgxM6w0GL+A==
X-Gm-Gg: Acq92OEu0xAw9D0HbI/8wHmnKwILGSJ5/tDYTQx1giezKMNxLiu5/Mc8m53zPiGS9Tz
	EJuu0nLvbmRKXWs3Hn100GSYNwQn8Jxb8pNNJ6czdML+wkiSm6BlMeDuLflRMFCewv9Lv47geHg
	o+9CqpJky35NkIQjG9159BG7W19sFqiAOdDyMqv1CcNoQ33ZYlLWuIhT+/P3tw3Tz7SP/XAExZK
	V115w5Lcpd1zzgvIXNPiqB79zN2b9xuT4bkava+mxcJ7DeD9lYdTE/cvockvsphfNXPIo3Cw+NX
	ZqHMl9tzrMJhe6TMBhECNXSQwUu/7tth62fqRKjah45wl0pZk7MZugLbwrV7L5nZeunCQd42CD4
	XueYRseBN3y/r1JJGngnqySWHo7Kby0ZCUA7ySQ==
X-Received: by 2002:a05:622a:151:b0:517:75d8:b960 with SMTP id
 d75a77b69052e-51778738b2cmr47091471cf.43.1780492362178; Wed, 03 Jun 2026
 06:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517153427.94889-1-tjytimi@163.com>
In-Reply-To: <20260517153427.94889-1-tjytimi@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 18:42:30 +0530
X-Gm-Features: AVHnY4KdS26v-u7MwMB2QczqM1orB0trjZ3Tze-rPeQYj-S64aX-ZARYgiMz9Fg
Message-ID: <CAAhSdy3YV9Ny4YA+26SzY_yoFrAB0GWGZQBeg0X90H9Q_GSuHA@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: riscv: Speed up dirty logging write faults
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 9:05=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> This series speeds up the common dirty logging write fault path for
> RISC-V KVM.
>
> When dirty logging is enabled, guest writes to write-protected G-stage
> 4K leaves currently go through the full fault path and take mmu_lock for
> write.  That is expensive once the leaf already exists and
> only needs its permission and dirty state updated.
>
> The series first makes the existing MMU notifier locking contract
> explicit, switches RISC-V KVM to KVM's rwlock form of mmu_lock, adds an
> atomic G-stage PTE update helper, uses it for existing permission
> updates, and finally handles dirty logging write faults under the read
> side of mmu_lock when a 4K G-stage leaf is already present.
>
> The locking and concurrency model follows existing KVM patterns from x86
> and arm64: use an rwlock mmu_lock, keep structural page-table changes on
> the write side, and use atomic PTE updates for permission-only changes
> that may race with another vCPU.
>
> The fast path marks the memslot page dirty before making the PTE writable
> again.  It also sets the PTE dirty bit, so systems that trap when D is
> clear do not fall back to the slow path for a writable-but-clean PTE.
>
> Performance was measured with KVM selftests inside a QEMU RISC-V host.
>
>   dirty_log_perf_test -m 19 -v 4 -b 1G -i 3
>     base dirty memory avg, iterations 2-3: 53.262493s
>     patch 1-4 dirty memory avg, iterations 2-3: 52.735675s
>     patch 1-5 dirty memory avg, iterations 2-3: 26.422964s
>     patch 1-5 improvement over base: 50.4%
>
>   dirty_log_perf_test -m 19 -v 4 -b 64M -i 3
>     base dirty memory avg, iterations 2-3: 3.203170s
>     patch 1-5 dirty memory avg, iterations 2-3: 1.762452s
>     improvement: 45.0%
>
> Patch 1-4 are prerequisites for the read-side fast path. The
> main speedup comes from patch 5 avoiding the full fault path
> for dirty logging write faults.
>
> Jinyu Tang (5):
>   KVM: riscv: Rely on common MMU notifier locking
>   KVM: riscv: Use an rwlock for mmu_lock
>   KVM: riscv: Add a G-stage PTE cmpxchg helper
>   KVM: riscv: Update G-stage PTE permissions atomically
>   KVM: riscv: Fast-path dirty logging write faults
>
>  arch/riscv/include/asm/kvm_gstage.h |   4 ++
>  arch/riscv/include/asm/kvm_host.h   |   2 +
>  arch/riscv/kvm/gstage.c             |  35 +++++++---
>  arch/riscv/kvm/mmu.c                | 105 +++++++++++++++++++++++-----
>  4 files changed, 122 insertions(+), 24 deletions(-)
>
> --
> 2.43.0
>

LGTM. I tried this at my end as well.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this series for Linux-7.2

Thanks,
Anup
