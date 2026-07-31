Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FA3AFD1F
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515352; cv=pass; b=mK2s9ecK5c4+5ANqCOKIk543I6BY0TgW8TlRYQD7W/w8M0yMUcITauMq0BehuAjGzo7Cpf+mzBxyaixf6q3BqEEjUxn8qx7qcsuKliAq9NABJBPLGshtrig1dsqhm7wudk60T0IMrmCHerhtM6KLT1KO1zoXfKOwyavTM48xhlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515352; c=relaxed/simple;
	bh=bjIDRrRO0VH6lWxxueWImISdbELHVpWVJmc0kP3gl1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc9AiHc5ZKLFz43nxisHA90zfYygZAyYKoFwQdGSu9TX8W2iFNMGAOk1S4SSaKt37/V2jWo99NAjFS+sh7R6gZbo4nqp1n0Kw61cOep7gM3poZihtHOe8d2BBB20ZjljJy+zVM2SiqxCHXiDKJfmpb17MEI5jLjA1ne24rw6e2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPAsrFTz; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPAsrFTz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso3031045a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515349; cv=none;
        d=google.com; s=arc-20260327;
        b=qQgdqnnEB4L+2LKEchK4EzjiMmBWMco1PBckIUedhLV8eAUh5s/182b/NsNz6m9lIw
         /uaX+KmG8NCBHf0Z1BNMcsGn1QWec3N1M7AVQF1yBXkTR93mQZa4tpFHXiVENYrel/pb
         tc1x2QMwMXYp7Pp1pbCuwTSpGl7aPfu7k6xLVYIslMCsIQztLTz0U0ANGcnc1wG1dZGm
         zvzE+eadsc4yhai/CeWnyz7uLaJavrAnZbaMetj7SZ1RVSvk4bQrbhzUlcBIlZbuk9tt
         dflKQ1e2DW6wd2MeKwGwu2qGCGVvMSPFQ/QtS8Ujxs6eUr1aW5GzFp9+JwbfEqho0duy
         WppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bzxv7es/cGE32AnA7OkYihLVGuHTXsiSU2uTN1sSLTM=;
        fh=xW41DK2JGL12761Dj3zTbjaM4YhBFELKds4q0DnypVU=;
        b=mcuxvgrONOS2gS5n8Eeykrnm1vpot432dPWmx65WiNTp1LkJYhVtIo23rleAxK/U2q
         v6VwhO8M3s1Xu0wc6pg21lWQkUeWOucHtEAjE/jO27P0p5toyFdqQhP4lvDkFovsoFa8
         n95XYaTHJpbMtav5BGY78hPzBjZhtK82KUh0nnnv+/m7vM0eVRQmOnktHWq7wNA3HrFv
         g3K6wuESuDJ3JWFNJuVpgu6D9mQnnMD23wUDWWwbTcOE9yFZ81jsVktf2njX42j++4wm
         fUWHSlbEqmSYJdJAm3zojuYeHVrj+CknW17osFgYvjKrgMPPChzJ6Whq+enouSXscLu+
         n2+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785515349; x=1786120149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bzxv7es/cGE32AnA7OkYihLVGuHTXsiSU2uTN1sSLTM=;
        b=BPAsrFTzw1uTWLM51p/aUZAOPJzOxlVpIjFp8CEvwys0sFQy0ll9Octsh2QkNN3SCl
         5HB+FtIOLje3h4DZTUgyjHDYbxOgCXXGAWymlad9Nov2tPdP2ZZR1go4SFPQRggWvNGB
         /Pf4flaiFiQjvrNJvuWa90ULYJJs4Cvq4FJ8oK4kWqE4d0b8EsOQS/eZHMh9z45i8zIC
         4ZPOOWjyLTxuqg+bu8jd/KYhrXfy9vXVvqrdkqR1OVmu+ayP3YFDbSSdh2P8I7gwKog1
         5fmOWzAMF692DwFGodDjmvJI/yIlEDJZxBJ2f0DmBJhMDedouETl233mKPNTZS1/ccdZ
         Wi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515349; x=1786120149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bzxv7es/cGE32AnA7OkYihLVGuHTXsiSU2uTN1sSLTM=;
        b=gqXEmV0ukOGKgWzEmepI5F0WgdFuJhfMCDqcQpqwkX3EfrI5BLU1aOYncrqSS99wdm
         uCrR3hJUNNrh9pnJzgielJQsYqnc75IV2t/gRDVUqffNNobWM2rYuQ8CCw2KWHlsxUhO
         nqPrSk0qIel7GXrC7wuv6LTdQng2GyDOAa8Uhs82ZBWyOJhagoY0PyZ2GIWh0GDV/c1J
         MYpdY3A73MCXEt1nNfEUxYL8ELKfUxMO87o4R4ywBCsMeWk33vEcIObfTUASA+B60Yfo
         J00JMDu/EJdkHIVJepkR/ekaHw81dHJfcgGa9DXOqOSFSR2HTpTNozULh48oKP1cAd0p
         naQg==
X-Forwarded-Encrypted: i=1; AHgh+RqhRC1j0N/SIPx1Bt+ACLDZ3SPJ4Mpaogb2//3Nq/zWKj7OtTEwSTbq4a/zfjOhrBhwlF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUSKIFRmqF9Rejd2eMoALVQYzUjaDqw2mR+j6WTgarAXjueOf
	pwx7YJrWzP8/Eejcs9Aobf323nddUhRjUZYAnCmM2qxtH3POzn9aacvqD+xfwcLBb+PNfxGeSiV
	6kAD/DyHgSJvg46azI+mzLbE88ThLkg==
X-Gm-Gg: AR+sD13eCOSav+QgCNODvygbW3CN+ExXvXuorwJy2N4VR8Sc2avd6ZRL82fEVUxhagO
	5/gcUWts2DvR6lGxIzL1gUeVIji/pCmXkw+5IAh/y+1ZrMvTSuDzCylV+j8Tr8j2kaEly3TjPxE
	RwLTorZZ4bkt187u50VYwKPuPB1FyYeBF+Yk0tRzfwk0DK4ucVgqyLVjNG1mICo3Mc7e7V83GHt
	OJwQupmyeCkr81ol5y19Eb6nxcCsDRRzP58G8iWevPTprDI3++ZS81hPKyriBB2V4r2pC4q4Dxb
	fDjTEBQQAR03FwdNJHHF/FLE4okEiZVnkTBa9zZyTY4vXPXQ7VWmxH+WEAEepWvv5ekyss4dQWo
	QtS8RnV2zg0q22VIBmrfOjKOECCLjwAva/2Yl3SiloJlkq/JkQs3ipVY=
X-Received: by 2002:a17:907:3e95:b0:c1f:ba1d:805c with SMTP id
 a640c23a62f3a-c1fe7bdb22cmr26721166b.19.1785515348552; Fri, 31 Jul 2026
 09:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
 <2026072959-penpal-petroleum-bf6e@gregkh>
In-Reply-To: <2026072959-penpal-petroleum-bf6e@gregkh>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 1 Aug 2026 01:28:56 +0900
X-Gm-Features: AUfX_mwKhraFu6PfYqhOTJLGLuJFa6rmB6-o56Tiq_IBsdm3mhBeyxgy96LLjrQ
Message-ID: <CAGEsz8EzBqC=0A_DgRCMQCfmAp8iKysAyzccJ1sDrQE9OaZY2g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Synchronize hrtimer callback during teardown
To: Greg KH <gregkh@linuxfoundation.org>
Cc: anup@brainfault.org, atish.patra@linux.dev, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right. I'll add an Assisted-by trailer and drop
security@kernel.org from the recipients in v2.

Thanks,
Myeonghun

2026=EB=85=84 7=EC=9B=94 29=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:45, G=
reg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Jul 29, 2026 at 01:42:24AM +0900, Myeonghun Pak wrote:
> > The non-Sstc hrtimer callback clears next_set before its final uses of
> > the enclosing vCPU.  If teardown observes next_set as false while the
> > callback is still running, kvm_riscv_vcpu_timer_cancel() skips
> > hrtimer_cancel() and kvm_destroy_vcpus() can free the vCPU before the
> > callback enters kvm_riscv_vcpu_set_interrupt().
> >
> > A guest can arm the timer with SBI TIME and request shutdown with SBI
> > legacy shutdown or SRST.  A VMM that honors KVM_EXIT_SYSTEM_EVENT and
> > destroys the VM supplies the teardown side of the race; no post-launch
> > host ioctl is needed to arm or request teardown.
> >
> > On upstream master 62cc90241548, generic KASAN reported:
> >
> >   BUG: KASAN: slab-use-after-free in do_raw_spin_lock
> >   Write of size 4 at addr ff60000005e58898
> >
> >   kvm_riscv_vcpu_set_interrupt
> >   kvm_riscv_vcpu_hrtimer_expired
> >   __hrtimer_run_queues
> >   hrtimer_interrupt
> >
> > The object was allocated by KVM_CREATE_VCPU and freed concurrently by:
> >
> >   kvm_destroy_vcpus
> >   kvm_arch_destroy_vm
> >   kvm_destroy_vm
> >   __fput
> >
> > For deterministic validation, I added mdelay(1000) immediately after
> > the existing next_set =3D false assignment.  This only widens the
> > existing post-clear callback window.  A no-delay trace build naturally
> > reached the callback-after-teardown-start/before-deinit ordering in 12
> > of 200 runs, but 1,500 stock-kernel stress iterations did not produce a
> > KASAN report, so natural reproduction is timing-sensitive.
> >
> > Always invoke hrtimer_cancel() for an initialized timer.  Preserve the
> > existing -EINVAL result when the timer is no longer set, but only after
> > synchronizing with a running callback.
> >
> > With this patch, hrtimer_cancel() blocked for the full widened callback
> > window before vCPU destruction.  KASAN reported no error in 100
> > fixed-and-widened runs or 200 fix-only timing-sweep runs.
> >
> > Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  arch/riscv/kvm/vcpu_timer.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > AI disclosure: I used AI assistance during the audit and am treating th=
e
> > issue as public as required by Documentation/process/security-bugs.rst.
> > The reproducer and full KASAN trace have not been posted publicly and
> > are available on request.
>
> Then don't you need to add an "Assisted-by:" line to your patch?
>
> And as you posted this publicly, no need to cc: security@kernel.org.
>
> thanks,
>
> greg k-h
