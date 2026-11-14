Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663345;
	b=eu8pBCwFOhmfKLD1gKQzrMSZDdlmbHCofl3lD6iPloJSeP6a5j6s9CZwy0Lb1Scg1zsL
	 R+7KOgiGZx76zodHe75yAS/et9ZuIy5I1J0NSmOAsBEWwAF9hgANJhGUW1xAu6aWv2ysh
	 C1ooEtVYYbnLF4gYCJPt3tkKjrFM1rXIIItWUAi7CmV055T8nApY5NnRe+bvHW+cCYOU0
	 8haef6qmIpJOPRAT4EU98HKhpLa3U6s1ucMAfVMDoN1IW/zqL4OUh8NeUTjzbDXS+acw5
	 +pONu0ADfpxeHdwmKJHTCS4QEOWjc5+19FJpNNM5iVnh2POAf3/92jAmDqzpRT4g1vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B7nxs2ziyKSXajCogouyEEECBltRg0HZJSOSZE1z6bs=;
	b=GKs/5dcRXmOEljyIHug87jG1UNuizcbyOIxWaVSBRBx2QTk1vqw6VQ97S1edlzPj13TZ
	 p+zwyIF2/WG5pPgjcyH297NokGOLxw+QjmULw6XQZ8kmos7rzsVb7lQNdKvazBkbatHtv
	 i9uQPvYgzyxJlmVW5RZP9Yde4ACTZbcNYwuXNW5R2kH08EpRnzTvucPkgAswlKoDeq8e6
	 hHLoa7sGR2x2BVFCKQoRhcxI2CsVNzXC18Mqe5GgTpMxbK3MGvS0c5g4q4/TaCBRbFTy8
	 AlU8jm+6HZR8llaYOmAtvRo/4Fq8+wxc0eNmuLWz1VeJfdmV5CBaH3n4MPsgKTfZvgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=L3eX69Mo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365A606A323
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7365A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=L3eX69Mo
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14470729eso1931894e87.2
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 05:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794663342; cv=none;
        d=google.com; s=arc-20260327;
        b=kJ4+jAgtX3Sw3RdapiVR95Yz+0JNJRQR6S68j+i+7PlZ8/PvzqbAT4nMei8yDFrWc1
         OPUR/L7A7jh2mCtsKkdvDQXzjhEyB24mL2sDNeGHnuRnIRAT/5xVwi2El+uPN5P58DyB
         ZoKG5t0duV8bM6v1yXvB5SMIEwVcaoV10SN7ZJeZUDELm/EceAZzasmqdMwiuPUekjwD
         lb18MdjLJBmM9+Fktt51kUJmRXcsmYrQENBfMvAc7Oo4KeTm45X25a2rypGZURgirXKF
         Rd2b720a6q+k6+HAu+pgyfT7uh0U7P3NeVMPo0M8cXDbuYG0wcRblvi3eVHJQJuL1anz
         2mCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B7nxs2ziyKSXajCogouyEEECBltRg0HZJSOSZE1z6bs=;
        fh=T/EaQqiSH6XmOObuoP19/00HyzWz4P15VUoduKH2iUk=;
        b=MnAD/AE/4OCGdJ8ZGVd9kFwHNtzvbvPzRZJ6COvG2Dgxihqw1ps2O9k24YDPFDNQvb
         gpWY9WQZLO+TwvUabVUaXHabDZ9yBQTXSNykzzMoFbGF0KB34bCM0I/ZiOaD3CWiDC/2
         aduBMGmGnQ3sqfBRi5dyQl2tBlQDEMs1/phCRK05MLrTeWILhtdq3Wz+NPL2Z9iJkVh2
         ilroZ9rhQEKwaJC2ZY6K5joxvRnkM0z00ImDbA+H7kkxNshBaBUrY43KZk7kJKPK4Fc7
         CQfGOprrMkLTz2Zt/ZUGfz0lNCarX9i/j2UvUN31LJ0pg3fAcYvJLRhBupzE4rl/Q2zK
         yO1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794663342; x=1795268142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B7nxs2ziyKSXajCogouyEEECBltRg0HZJSOSZE1z6bs=;
        b=L3eX69MojesZqcpGizRiPTiM/QZx0402ABXzBhG+bHN7zui+JzLQU+9MZigCpAdWrk
         EgGX3VS2MRMf2W84gAiALbfPQUIdSqNWXdU5gcNaim13cTnnnnIuxUegF8uHRcvn9pix
         GFe3p5BdPR+ZPhYWdXR/1FcTTU7Pyx/RUrZiK1wBUTLijMvtOXnhqi5vwOaj6oCUrWRy
         duQGbxkWTdSXMu1fpkvGLIqf3PIcyeQf7cvoXnmQ6zj4zrJaf7GlMn/LLl2q0Z+ncdWd
         zWTA7Mol/2x/L5whXj7aPV5zexLHGcQtD6wPo4aQ0VVMU+QMTi8TWVIhJgUncEM0sJWo
         tp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663342; x=1795268142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7nxs2ziyKSXajCogouyEEECBltRg0HZJSOSZE1z6bs=;
        b=DWBY3Z6LNg21Vxixb/kjGJslcbjbd86hEeKUQfWoQDoxvSt2zShDM4dM/d0h9mAavf
         Do8mQxTO8p3F4bn2Xlp+wFm5TA4imNYo9DBoZlQLC277B2PZRIOiJt08SNnQZb4vFiUO
         gIz33lryMV32Vyzhc1Pg+Sku71Io4hxosepgbiouzaRDnVBv4faxdHEFCasb2djEjKvo
         dYLgrusuBSyaVvq3f766dShLqI4yogMFdxXTGFiewGluoSSvVvKnVPpIZq3sRzrcYLsX
         F9dHG9BjaxHS+qsQdnt1X1GE/EHEwPvDemCaEBlgP0DFr6gXd2JTVqfdixgcMvP/wlgr
         +dcg==
X-Forwarded-Encrypted: i=1; AL+hErGNPbL6elTWlyAWJzwaR/mWRTocX8z1ozRdbgXCGWZ6uS86zIvzxvWTmAuheQRLDF0pCa8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ybS3HQ4vWNhar4Dnws0Vk4rRCNGaHaBZPBdbAjzLogaa6gi8X
	LUOM3TQYB/6CTCq/V1KM3CbSELc0AahDQDttV+DcNCRxa9I6mHqydgGN3MOjfMjw6ka2rWoBGBl
	2Mg6t1uU9GELnNmm4W9zRpTGTM9+klOHwYfCIPyKVwg==
X-Gm-Gg: AYBFou02n60Qx+M8pVncR2HH+MGVB+cLjBS6HpHq+qW2c3eKIUvMCg8fvlwK5QRUakR
	NHowRJ445LRBZQ/70D5xNCLcCxJA2wu9WX0iaFKVn47VVPB4i42YYtV0EkDanm/lrILllzdzXWr
	DW7mvBqEtRhb7zcV2e703y1g68vCHpmXVM16oklowFnKrsmgGeGJvlu7tH76lwvKwHHYMgEKHxe
	CPqOgVQEsyMtcL0v0CeXCA1dXFuMFSYxvXd2Vo43BEQl8sXW2EMyH+FRbTpIVoswXAhym/gU18q
	LVKTWP0M7X/TBf4GlvPdjUv/8t6l8iMBF92NtDtRR5uWKzzJAySTW+LyZHpZC1R3EOU6qUHundc
	TI2199nNhtAzNS+ai0VMqhb4522LLWocPfSzf7G+sPDJY74P2hT3HdnnDIMPNL5Cz9UVYue+FKZ
	qa5NTlZd13RsS05gY66V/0Gr3HsP9eR1jVvV1aYpWDXGng6EyhH66yCw==
X-Received: by 2002:a05:6512:a84:b0:5c1:5171:4ad7 with SMTP id
 2adb3069b0e04-5c170b383ddmr2080350e87.33.1794663341999; Sat, 14 Nov 2026
 05:35:41 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023142550.148604-1-oleksii.kurochko@gmail.com>
 <CABBgwmuBBbyBytwRBTeAqF=0c1m+TFK8E3yPopGNQAsrMFO2vg@mail.gmail.com> <7e634bef-6d23-4a57-b3e6-b5585045ca19@gmail.com>
In-Reply-To: <7e634bef-6d23-4a57-b3e6-b5585045ca19@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 14 Nov 2026 19:05:28 +0530
X-Gm-Features: AclHuK9nWY20qy2LdzPDWoj5LiIWjiiPX9NCcLCEPiqITYBgVdXOX7JbUWJZ-OQ
Message-ID: <CAAhSdy2cL6u_pAinYFU64nfqespQU+2x3GTeiqvjFUbJyYLLMA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Order IMSIC VS-file write before releasing vsfile_lock
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 11:49=E2=80=AFPM Oleksii Kurochko
<oleksii.kurochko@gmail.com> wrote:
>
>
>
> On 11/13/26 9:00 AM, Anup Patel wrote:
> > On Fri, Oct 23, 2026 at 7:56=E2=80=AFPM Oleksii Kurochko
> > <oleksii.kurochko@gmail.com> wrote:
> >>
> >> kvm_riscv_vcpu_aia_imsic_inject() writes the interrupt identity to the
> >> SETIPNUM register of the vCPU's IMSIC VS-file while holding vsfile_loc=
k
> >> for reading. The lock keeps the VS-file from being switched under the
> >> injector: kvm_riscv_vcpu_aia_imsic_update() and
> >> kvm_riscv_vcpu_aia_imsic_release() take it for writing to move the vCP=
U
> >> to a new VS-file or to the SW-file, then read and clear the old VS-fil=
e
> >> and free its HGEI line.
> >>
> >> On RISC-V, writel() is followed only by mmiowb_set_pending(). The
> >> trailing "fence o,w" is deferred to spin_unlock() by the mmiowb()
> >> tracking, and rwlocks don't take part in that tracking:
> >> queued_read_unlock() issues just "fence rw,w" before the AMO, which
> >> doesn't order device output. So the SETIPNUM write can still be in
> >> flight after another hart has observed vsfile_lock being released. If
> >> the old VS-file is read and cleared before the write lands, the
> >> interrupt is lost. If the HGEI line has already been handed out
> >> again, the interrupt ends up in another vCPU's VS-file.
> >>
> >> Add an explicit RISCV_FENCE(o, w) after the write to the VS-file, whic=
h
> >> is what spin_unlock() would issue via mmiowb().
> >>
> >> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA=
 IMSIC")
> >> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> >> ---
> >> Why RISCV_FENCE(o, w) and not mmiowb():
> >>
> >> - Since the mmiowb() rework in v5.2 (e.g. commit 60ca1e5a200c
> >>    ("mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O
> >>    accessors")), mmiowb() is an implementation detail of the spinlock
> >>    code. Explicit invocations were removed from drivers by commit
> >>    fb24ea52f78e ("drivers: Remove explicit invocations of mmiowb()") a=
nd
> >>    from the documentation by commit 915530396c78 ("Documentation: Kill
> >>    all references to mmiowb()"), so adding a new direct caller would g=
o
> >>    against that.
> >>
> >> - RISCV_FENCE(o, w) states exactly the ordering needed here (device
> >>    output before the store that releases the lock), which is fine for
> >>    arch-specific code, and it is the same instruction mmiowb() expands=
 to
> >>    on RISC-V. wmb() ("fence ow,ow") would also work but is stronger th=
an
> >>    required.
> >>
> >> Scope: this only orders the write before the lock release. Whether a
> >> write that is already in global memory order is guaranteed to have
> >> taken effect in the old VS-file before kvm_riscv_vcpu_aia_imsic_update=
()
> >> or kvm_riscv_vcpu_aia_imsic_release() reads and clears it is a separat=
e
> >> question, see https://github.com/riscv/riscv-aia/issues/172. If it
> >> isn't, these paths will also need to drain the old VS-file, and such a
> >> drain depends on the ordering added here.
> >> ---
> >>   arch/riscv/kvm/aia_imsic.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> >> index f17dc559a709..807bb73a129a 100644
> >> --- a/arch/riscv/kvm/aia_imsic.c
> >> +++ b/arch/riscv/kvm/aia_imsic.c
> >> @@ -1056,6 +1056,13 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_=
vcpu *vcpu,
> >>
> >>          if (imsic->vsfile_cpu >=3D 0) {
> >>                  writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE=
);
> >> +               /*
> >> +                * rwlocks don't participate in mmiowb() tracking, so =
order
> >> +                * the write to the VS-file before releasing vsfile_lo=
ck,
> >> +                * i.e. before the vCPU can be moved off this VS-file =
and
> >> +                * the VS-file read and cleared.
> >> +                */
> >> +               RISCV_FENCE(o, w);
> >
> > Another fence after every writel() is a big hammer in the path.
> >
> > If the intention is to have correct contents when VS-file is read then
> > better place to add a fence is at the start of imsic_vsfile_local_read(=
).
> Thanks for the review.
>
> I don't think a fence in imsic_vsfile_local_read() helps here. The
> problem is on the writer's side, and imsic_vsfile_local_read() runs on
> a different hart.
>
> The SETIPNUM write is done by whichever hart calls
> kvm_riscv_vcpu_aia_imsic_inject(), which can be any CPU (irqfd,
> ioctl, ...). imsic_vsfile_local_read() runs on the old vsfile_cpu, via
> the IPI from imsic_vsfile_read(). A fence only orders the accesses of
> the hart that executes it, so a fence on the reading hart can't make
> another hart's MMIO store land.
>
> Without the fence, this can happen:
>
>    hart A (inject)            hart B (update/release)    hart C (old
> vsfile_cpu)
>    read_lock()
>    writel(SETIPNUM)
>      (store still in flight)

Over here the MMIO write targets hart C IMSIC

>    read_unlock()
>                               write_lock()
>                               switch VS-file
>                               write_unlock()
>                               IPI ------------------->
>                                                         fence  <-proposed
>                                                         read+clear VSfile
>                               free HGEI
>    SETIPNUM lands: the interrupt
>    is lost, or ends up in another
>    vCPU's VS-file if the HGEI was
>    already reused
>
> Hart A's unlock can become visible before its SETIPNUM write has
> reached the IMSIC, because read_unlock() doesn't order device output.
> Nothing that hart B or hart C does afterwards can wait for that write.
> Only hart A can hold back its unlock until the write is ordered, and
> that is what the fence o,w after writel() does.
>
> With the fence:
>
>    hart A (inject)            hart B (update/release)    hart C (old
> vsfile_cpu)
>    read_lock()
>    writel(SETIPNUM)
>    fence o,w
>    read_unlock()
>                               write_lock()
>                               switch VS-file
>                               write_unlock()
>                               IPI ------------------->
>                                                        read+clear VS-file
>                               free HGEI
>
> The SETIPNUM write is now ordered before the unlock, so it is also
> ordered before everything hart B does after taking the lock, and,
> through the IPI, before hart C reads the old VS-file. It can no longer
> arrive after the read or after the HGEI is freed.
>
> About the cost: this is the same fence that every writel() under a
> spinlock already gets. On RISC-V, writel() only sets mmiowb pending and
> spin_unlock() then issues "fence o,w". We need it explicitly here only
> because vsfile_lock is an rwlock. It runs once per injected MSI, and
> only when the vCPU has a VS-file.

I am still not on-board adding a barrier in hot-path. Also, any barrier
we add must be paired with a barrier else where with proper comments
so this single barrier anyways does not satify this requirement.

Instead of this, I think a much cleaner approach is to convert vsfile_lock
to raw_spinlock_t. The current vsfile_lock being a rwlock_t is create other
issues as well [1]. This will also allow us to use writel_relaxed() in the
kvm_riscv_vcpu_aia_imsic_inject() since raw_spin_unlock() will take
care of draining the write buffer.

I will post something along these lines.

Regards,
Anup

[1] https://lore.kernel.org/r/20260925155116.465203-1-andrew.jones@oss.qual=
comm.com
