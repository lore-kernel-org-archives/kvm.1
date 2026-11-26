Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703107;
	b=zFF3GYCGkjJ3qnZXBTRZlBIzrt2KG9RPk5z0VYg2+NEWjo9AzzEQZqrHaTZJRb0eRo+z
	 Pq6VF3LjnjMpVFg1tmL+YMrpzqx3rdL4owY5A0jIKpF/fR9Li+tYDu1Dz8lAHi0vxPlAI
	 QCX288JAvs2BcYfs93jguYaLozMVojrBez0qZNOK8own3KFMsT4/OPOLQ9IYnw2lfk3IH
	 LPqSnoN6sZbDHbzSX9rmJWv9EZSo0+ktM5et0kVRPiWX5k2VWZA4ZQhBtZMbAtO4TTamF
	 ghV2TF1X/c+DUutiwrdOTnYllluSy3EXWhEBIX5VfqV8sjPllblKivH9xKm9vUAcySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703107;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=urzqIBJWhB3yp5cZJ6SMEI3ey7WIN+40bKxuYnpO/4c=;
	b=GHudbQYiALQvSECpX+FRCuwf7l7BQz9vhSEFYulfEMTyW/pO/UdstBOEI5EHKU85u2oW
	 VEg81syU+I68lxb9oe8UVagp8lBJj3zkUjVaFE+6+8a2NRPFGKlvtsg6tWVdIqFrMLymw
	 pa9e4KOp952Htv9L0huv9zNkmkJsaGIzkSCUrV8n1Geoh5UqIr6wR/r4oeHC4hpxJ2Uvy
	 YTSfH19vSbULww8K+wm9uRoVQm2cgMHWCbjzAETgH1FwAmuCA2Hu3mHyiEnY4Q9RxJQ7y
	 6J7xdn6qpY0w5CJQuwcXXeSzqF5g1lXousbvPORNj68pnZFrSJipUAPkAIArUprjg3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSTtVC5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305AB606A321
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSTtVC5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1B31F000E6
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703106;
	bh=urzqIBJWhB3yp5cZJ6SMEI3ey7WIN+40bKxuYnpO/4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KSTtVC5p+dd+ataqWAVi5gHO8ZRd/RWVkYxhg/g/6O/b1O/+IcyQVPR4Ck5hWhnsj
	 GLpAIFYIBB5z2571wc7HKkORsM4fGd2pHKEKF7CrFmBUK9GHlZlvsh0hLH587a4p5w
	 6m9f+F7ygqG8eE340zHJOL51FHRno+Rd7yaTs2PQ3ubV7VgPuPyNtRzlBssWo1dJg5
	 HlxlOHtvH2LQOtja8acqQmaeadF2/6pD81nSo5FoCrVstAIZUgRNq4CiLOZr+r8Byn
	 /1dXa0dlXWgYRR1aY13eLfugSGd6HmHXAAZemCmuxbcEzHpQsdXY0KX6TNk/GEP3MF
	 m+PlAIFxLV9oQ==
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so68850125e9.0
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:25:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGKMw2yYhVIt7iisbJcLE29Gu/KkIgjxm6FHktyqOD49v8IiwscgQNOj0sx9h+aAhw2VcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PIv7I2d6ybHEpGhProrx5aMdyhrEG7AtcempCHEe5DvcEcbej
	BVkSkMFJGc8Msq/w/B48td5EXwhg5wPK1PC8sl4iclJGopT28T8RuDwCWm5TJ1QBSE38QEkzXVx
	elAKRAaVEwB6kwOfsyMm58Iu7iGqYWSQ=
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr431006395e9.10.1795703104940; Thu, 26 Nov 2026
 06:25:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924-free_bitmap_initialized-v1-1-4cfb73a0d04b@kernel.org> <CAAhSdy0cfbfufYYhVCz6Tq0_1RrS0DEi5yfKyBJr=WhUnd+QZg@mail.gmail.com>
In-Reply-To: <CAAhSdy0cfbfufYYhVCz6Tq0_1RrS0DEi5yfKyBJr=WhUnd+QZg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 26 Nov 2026 22:24:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQJO-sGxTNUoVvU4bGcqPXJb6tpiVsyEPJP25Z7wjduNQ@mail.gmail.com>
X-Gm-Features: Aa3M54qmSzszE-VR_RYTsVczrtCxMOXKk85r4dogNtwI2ZjOSGsCbY_eqm9_ZQU
Message-ID: <CAJF2gTQJO-sGxTNUoVvU4bGcqPXJb6tpiVsyEPJP25Z7wjduNQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: AIA: Initialize per-CPU HGEI free_bitmap
 only once
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Wed, Nov 25, 2026 at 11:35=E2=80=AFPM Anup Patel <anup@brainfault.org> w=
rote:
>
> On Thu, Sep 24, 2026 at 11:34=E2=80=AFAM GUO Ren (XuanTie) <guoren@kernel=
.org> wrote:
> >
> > kvm_riscv_aia_enable() may run more than once on the same CPU.  The
> > per-CPU free_bitmap only needs to be initialized once, from the HGEIE
> > width discovered on that CPU.  Perform the HGEIE probe and bitmap
> > setup only on the first call, and set free_bitmap_initialized after
> > the bitmap has been populated.
>
> The per-CPU free_bitmap for HGEI lines only one unsigned long so
> I am not sure what you are trying to save by skipping one unsigned long.
>
Thanks for the review. To clarify, the early-exit skips the entire
block below =E2=80=94 not just the bitmap assignment:
---
/* Figure-out number of bits in HGEIE */
csr_write(CSR_HGEIE, -1UL);
hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
csr_write(CSR_HGEIE, 0);
if (hgctrl->nr_hgei)
    hgctrl->nr_hgei--;

if (lc)
    hgctrl->nr_hgei =3D min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
else
    hgctrl->nr_hgei =3D 0;

aia_nr_hgei =3D atomic_read(&kvm_riscv_aia_nr_hgei);
do {
    if (aia_nr_hgei <=3D hgctrl->nr_hgei)
        break;
} while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei,
                             &aia_nr_hgei, hgctrl->nr_hgei));

raw_spin_lock_irqsave(&hgctrl->lock, flags);
if (!hgctrl->free_bitmap_initialized) {
    hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ?
        GENMASK_ULL(hgctrl->nr_hgei, 1) : 0;
    hgctrl->free_bitmap_initialized =3D true;
}
raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
---
Once a hart has been initialized, nr_hgei is a hardware property that
won't change. Re-probing CSR_HGEIE, re-running the atomic cmpxchg
loop, and re-acquiring the irqsave spinlock on every subsequent
kvm_riscv_aia_enable() is pure overhead.

The free_bitmap_initialized flag in the original code already
anticipated repeated calls. This patch simply hoists that check to
skip the redundant probe entirely.

--=20
Best Regards
 Guo Ren
