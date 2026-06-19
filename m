Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45B2D2486
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865378; cv=pass; b=OKaED1g1o2cI14PNJIRzfOiNxd49Stn0Qn2ajlHbQx2eZ0NkOx1Ng/VDP3obYHqhmzzLHgG2fHH50X3dN9m65JviAcfCfxkPJlpmjyzU/e3yI6TPqwGPS3lfmEA9L6sT9sYEymOZMnf6PDAX1S4ldWNMcR+ZOaQ92TVoY3ytYQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865378; c=relaxed/simple;
	bh=g/dzKyDFHfvLjQCJh2ZSN14OK+5iBhTvwQcSsOND7uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8T68T8oDWgXWlx0PYFFj9Nbbx9TdzrLOTmW7S2HtPbvs8fLzGqcmZvMItM8IVmjTnK4oBIKOCyBQXgTtXN3o92B9KgpOrRmhLopBaQleUuQA5WsfdppKv9YckCPwh1SBHDg2ez69v34seIWsDNbSRQ/Cghy4dvxAakWviLTTcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rw8Ky+ow; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw8Ky+ow"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177d1ff061so143451cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 03:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781865376; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5UHRPwW5jCyx3kDgrGuJN3lAKgRQcxOyf0TX4qG69EjArom7g7G2PMT5Ih5c7Uyyi
         Ok6q61IFPkSaaaXM/n+3T7fIMysHzZTW/gbgaL7bTYIuHmTz8wIVbIPZbIeE0jC4odoV
         wdx3sgpGu99GUnTDcmYGUA16q365wTg+woL2Nr0FhZqhiFmRJ/xj8yNjyK2NODigPVS1
         Sb0ztghKF/V0iaiuUyxXHsD7sFtvMQBqNMhqMRRFlySAkE998BUd1uHwEj0v59QjZT7e
         wVyLkEPe62CtrCUtxG1RUm+yttB4HBsuMKv/1QXndHXEE+0WOA56odJdcdIjeC0ON05J
         O7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TCG/665pkyKrSc7+D8LkCnkhR0NtBPIcMfXzYL4JRLE=;
        fh=Zic13oQ6LxQze37R+JKGkAe7yxn9BVxMOsDyuuNg8Xs=;
        b=iDtLTrYOefCSqwTAnbd98G7c2PbxINC6M9t8zzsInfk9WMRen/09zEDmn4z6r1Ks0U
         J5ehfxLAWcPz3zBHqQ9canldaWOEt2wBiyOckdOjZitgl3XWD8y2mKAuMZYiYkovP9W4
         my9Jmob3HRwhIepB6Pc66MDngUe+WyHVnXLHlzBzzCw725f+P0ah7D+2BWGfP+ybWH8Q
         MICU7OWM4DusMsV3NzccnWr2Uzi5aOOIejQ66jtDZxKm0oM8Cf7XN0YSiVz4h7LOXAGN
         o7cdFXkH1GFHgXncMsG4Ye72uXToLTuJtZKbWsKO7PdXL+W8POs9MTznFTH5SfERcOIL
         aluQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781865376; x=1782470176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCG/665pkyKrSc7+D8LkCnkhR0NtBPIcMfXzYL4JRLE=;
        b=Rw8Ky+owvFqi1xd0NveoShGXum24sHMGeMmdnWhFOKa6aDQvgINGIhdZYBJruxo7gx
         AZRMbuRAF5zrj/AP3aqK0AkG281riZskLgEL0KM5OqMG9atGfGlgClWKrfZ7yXTHijgX
         jMIlMXyU2zBwpaz0ZCPJA799u2A+0BrYO2Zfwwsqro9T6DV194fTkhEh5TG61xmMNQ7T
         UPcikyC56uWoRDz8weEr3NRytn6in+0t997sawzUXkVOvENwRQ/DJmAiM+/ipyB0Cbe8
         Exthq0itBQqpGH7jNTKX5RC9g9WOvjFkTZUKNWKHpq+r2AFMV0kC2hBOdWXOFfDxaZiv
         FZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781865376; x=1782470176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCG/665pkyKrSc7+D8LkCnkhR0NtBPIcMfXzYL4JRLE=;
        b=doY2ZuBovi8ar49g3+y22JNF0m6p0OYryQBHouvOpj18jlkf+Y75tPooCsF1mzGR/+
         JOftgpBBmJHqoryEKoXTVHxshNjnJBOt18vlqInoh+zgfDiszhpLYmbrvFo641euMt9O
         FQqnuHEDm41PidizX719xhs8CsxgqYpTcTKFu2xTqWs606hwwQLXE4mb4yIxFhBceSXB
         nrWorgjynVf0SrZX9acQRY5sxyqHReAFjb7IGSUFt6FIuPgZMe0WunJFOIOoibJtaQFj
         iU6huSmIPOzWJjfjlTPSveEIFgo38aTRn5qyJdSrhBulsCCOBFjChdVjsjl+gyAVYK/r
         IOrw==
X-Forwarded-Encrypted: i=1; AFNElJ+umCb3nz/q4jZeWKgxn7pCtVs89/KqHLR31RVqRNQuMkIEH3GtuzrBTqM+eiBHquiY4/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlSI62ojll5rmKYsybrnXefyqr8Nq9WhiPC95UwZH4u8sG2DV
	WH7NeLUqf04m3oRFH7iMC8CrXjEmQpVBI/WgWf+A61gerl+8g5EwGRafj6/CmUDlM56PBhyxlPB
	HBVz8bSA4BuL9TQzGG0EP498ojr0L+txYN6wOw77Ygy5cCA6szIVWJGCq0Go=
X-Gm-Gg: AfdE7clfi1ru+YvAeO5DrStC/5xlmlxN36Kfgz1VUS9emQtlryXVVtvzmSE7IcvmIER
	qajmuFnxh797OYJVdbUe+SgwIHlytPoxD7TlRAcEu5ndo/9qVz1Gjg9LMdLGNEaRLpYiWX+U2pq
	TRHECeYyu1fc3KLjLKP4WOnPCDtqu53W2fULAm70OGU4o9pf+5DHDmCsfmWXXWvCmEl23qOtEQ8
	X4aoIvixvq1WrA7sfsA7OequPomZuT4fxTaTBtde3OB0GpsAczPkp7pKL7AryNtMRu5xWpsgg==
X-Received: by 2002:a05:622a:98d:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-519e891275dmr6576121cf.5.1781865375238; Fri, 19 Jun 2026
 03:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com> <20260619005320.51A8F1F000E9@smtp.kernel.org>
In-Reply-To: <20260619005320.51A8F1F000E9@smtp.kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 11:35:38 +0100
X-Gm-Features: AVVi8CfYEvsMjwMgKNKidWJDSAVnQ8t5EZFvVCHXxAi-8QxaaQZdnuZZQW_VEW0
Message-ID: <CA+EHjTzQhOi-qeiNGpn50o_ko2Cp05qzuKwhiZCgLPCyiwWhrw@mail.gmail.com>
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2
 ioctl
To: sashiko-reviews@lists.linux.dev
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 at 01:53, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing compat_ioctl handler for guest_memfd file operations c=
auses KVM_SET_MEMORY_ATTRIBUTES2 to fail with -ENOTTY for 32-bit userspace.

guest_memfd is gated on 64-bit: x86 selects KVM_GUEST_MEMFD only under
X86_64 (arch/x86/kvm/Kconfig:50), and arm64 is 64-bit only. Is 32-bit
userspace with guest_memfd a supported configuration?

/fuad

> --
>
> commit d35a6816bc0c5b6e6650f6f4fcbbef3d9b3e3590
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2 ioctl
>
> Introduce KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES to advertise the
> availability of the KVM_SET_MEMORY_ATTRIBUTES2 ioctl. This ioctl allows
> userspace to manage memory attributes, such as KVM_MEMORY_ATTRIBUTE_PRIVA=
TE,
> directly on a guest_memfd file descriptor. It also adds an error_offset
> field to handle EAGAIN results during transient page reference counts.
>
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 876c0429f9d4e..129d6f6303251 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> [ ... ]
> > @@ -1649,6 +1650,7 @@ struct kvm_memory_attributes {
> >       __u64 flags;
> >  };
> >
> > +/* Available with KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES */
> >  #define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, st=
ruct kvm_memory_attributes2)
>
> [Severity: Medium]
> Since this is a new ioctl on the guest_memfd file descriptor, will 32-bit
> userspace VMMs running on 64-bit kernels fail with -ENOTTY?
>
> Looking at virt/kvm/guest_memfd.c, kvm_gmem_fops lacks a .compat_ioctl
> handler. Because KVM_SET_MEMORY_ATTRIBUTES2 is not in the generic compati=
ble
> ioctl list, the VFS layer falls back to returning -ENOTTY instead of call=
ing
> .unlocked_ioctl for 32-bit processes.
>
> Since struct kvm_memory_attributes2 is fully 64-bit aligned, it requires
> no translation. Should kvm_gmem_fops wire up .compat_ioctl (e.g., to
> compat_ptr_ioctl) so 32-bit VMMs can successfully use this capability?
>
> >
> >  struct kvm_memory_attributes2 {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inp=
lace-conversion-v8-0-9d2959357853@google.com?part=3D17
>
