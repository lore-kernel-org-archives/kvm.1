Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D33DB33C
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048885; cv=pass; b=BT6zHjZRcwbsonsavEtlZEHA/TI5AEkz95Tp9x+iKGcHERmsvOvYRzMTtumDJzT2mPljfRYWHbtcGGNBX12Mz9pO62DpcqFmRLW6U/x/NMZXVbchLxuU+faC/l/wCS6ZBvZuijTwJnAl+pZHP/d4nOjw5d+J+FhSr8hOmWrCpWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048885; c=relaxed/simple;
	bh=dEpRQAN0t90RCYZ9nerVz+YCupMnTtN2MmylUSJ12DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnE/8KB3LjWPrdxzHUdZHfk68Pplo2fyNszg7zeNAFmHLXzXlKg73AeDAktFdTN+X/7zhEnqFlK+9cj6FGcBeyAr7oT266UMyF1HfQNZJV1hASAOv6J1ZysAlTfgB5Q4mFPvy2KYYGqmYGCsU+BGdAQ+M65KoqX//SRW++WfjyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPeYfxKz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sS6ZfcAC; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPeYfxKz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sS6ZfcAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787048882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W076oaTN3mZWIncnazxWsBO9fhAcOCOEX8Q2I8p5CLg=;
	b=DPeYfxKzcgLrd7cT/nTVz8PVFhkBIoc2/Fa/ckuCW68YXdMA352nZM0bsMkFvMn1d+vIPq
	nxg8qxl7eKSfEKNTNSLQbucQL8S4NOp8Jyb2/HvcGs8muVKuOnOX2Fe+6+QR14JmxRiWtv
	Ed/3kmTAWqcbndd9tEi9PYn8V3ZnL3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-GR8uzNsBNkOxiCQf7y_2sQ-1; Tue, 18 Aug 2026 06:28:00 -0400
X-MC-Unique: GR8uzNsBNkOxiCQf7y_2sQ-1
X-Mimecast-MFC-AGG-ID: GR8uzNsBNkOxiCQf7y_2sQ_1787048880
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482a5e9400eso1208041f8f.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 03:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787048879; cv=none;
        d=google.com; s=arc-20260327;
        b=g0ygKAhGc/LrOoKe4gJzIZIXyjx2X2WeGErTUv6VdG3TDKW0u7RVbQEyC+hl77nxQ0
         da4oqz/7PN3qXzjqiG0VPDttSPAngbcS3TnK5F51+dhOSEU5OMAJbUu+ZrUYj4GXZsCI
         SGd2RdR4oGako3wX7iRnyWPLUGYLxSRTIsr/1vF6R1zud/Cpeh6QgtFMzMexoFBHilS7
         e37Pegzo1w8H5/MbS6Bd/CI+SJB4fE9CSC2KcvNDCOlbkvgJSrXD3idIDCGZwogmFpCd
         nehFw8d58ZciIA6/DSz9cuOLZTqEkMrMNvZPOOA9+A0CiW7Gt87OCgosBVSTTN6zzoAY
         yIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W076oaTN3mZWIncnazxWsBO9fhAcOCOEX8Q2I8p5CLg=;
        fh=1kbcnx5uHdtXfJ3Dmt8pBCrYF1tMjndNQhnwfV7r078=;
        b=Oj/0lMYg6Ep3CBarsM2N01pUn7SajjzG2nKvHgCaSvii3u1OFf3dnziFIOcdDuULIO
         l2zt2fVRxqTBdJR+juqoYSf+eYA54vSfjsRhj63n/WsJdMT833g+HVdTdVK2jcCB2r6N
         L2LnOgSMX/H4z5O/KWd7ieBbl4w40PYhoXohs6kACLP6XlfWM/kHM4PISeGz1UirtsYm
         0JabC3v2XAlPZRED5Jm9JkKSkEaloEr9Vm0rMfi5xf4flrlI8sXp8wKAX1kXyx9IZK4D
         cHyx8m+jcIUHiYU8FV2mHrWypJGrKlaLCRPFkHvw8YfyulpRURm0U8QRuQF+zqob4uMI
         wNjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787048879; x=1787653679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W076oaTN3mZWIncnazxWsBO9fhAcOCOEX8Q2I8p5CLg=;
        b=sS6ZfcAC8zHWod8So6jx2efT3SPqCfKMmpUmRWFrnkgpsFyyMd2oTYThwWex6uPXno
         vcbK3/n8wDl60FXpjbAgMXhyUlXgU2DM4W+lav604LuAkvI4OkvgUhP7TnNvBX82s427
         tXa4K0zpyI1wQXEoVSDLo0hAhCjtAvUmiOlYOgoMu5AhFSaqY564B7IV1tq6+I31yEjw
         rBUgqR4/iHHMV2HUPKaRuzdaGcvj8p5RBzOJH6+WZmHXqyJc0gwWj0fKJ31LU3xAfMgu
         0xh+rTocfaVY3AgbQAxM11ca8M1du/yItHrne0bVuNFPnKf+oClK2BZS7mbBw3Y/XZtG
         /jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048879; x=1787653679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W076oaTN3mZWIncnazxWsBO9fhAcOCOEX8Q2I8p5CLg=;
        b=k91SAp7Y+rOAHic4S5rNg2QUSXZMDOscuip0Y895uYuLlYmE/fi6HJ60HczbwEm1nz
         LmlhNoBnHK4IpwQxjYJ2Az6OBiuDdTpqXfcB2BywrYDR8DkLPW2a+iBayemE74XkPWWW
         Md8CaMSnfuWIY+l7crk3DrvGV2pZmhYLVQWhA0GSsP4rxQk4Us6teSxCx55Goear5zMl
         z+e/tvaRDnGeqyT6aIbdmS1CMxv/SwOD6HXSKcR+ZXRWJaSa4odMiOVxPyut+AhW/CJ/
         mA/CfQXVyJcGEh/CnVb4P4UOzO/RLn+FilyM5PucImUIKq7nQPDPiio0rh2h4bUp/HRw
         a4+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9dT1C/k38pMusX9lDW1LfRoNNzHy3/qTANpyVeoKwtNtDU4XvHtuirc3mjElOYLDpcW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pqlsK2qvwkuLvXz3c/xoo7Jn6RaqkYgfCFtOAaOPzWH72/iL
	fX24bJA/8SnA4nBsX8vlZwKEkB/ISCxgsV6/p3YiK78xENVep9l9ph5Ny7+Hr5MmvTLGfP0yyBY
	eUJ3V0jANOnhT+VPWjvoo3SJBs+YX1+7O1DiNMm4dZAuIhpDjAS9LuzFGfPFN/nEi5H703mLtvW
	RRpC2f38/lYTVh8N/dkeqeFTvqlWsL
X-Gm-Gg: AR+sD125Hv628858RItdF+BqXZi5l8o1wOCsh5ooHnI9xavt9WB2DERmiZYr+OYsMpK
	T/ma4aiSSB31sOco5Eca2TNZQor0+YS+KCH0iGgHv4CtoFeUTvL1SLgRllr77i7mKAJNiYw7E0+
	TeqWvVAG6YyafY6hWmVFd4H2MK4PA8KNJJNTHxnrCkL19bq3cWLKczv8wH6gHv+9032dJSm3dWM
	DI6oY/rI3WaRaPY0sbpHAii56gHyOvI8o7VTR0qk4LRlreyoKkFPhXzeSI=
X-Received: by 2002:a05:6000:615:b0:47f:d0fb:ea40 with SMTP id ffacd0b85a97d-482a90d8d18mr10830316f8f.21.1787048879538;
        Tue, 18 Aug 2026 03:27:59 -0700 (PDT)
X-Received: by 2002:a05:6000:615:b0:47f:d0fb:ea40 with SMTP id
 ffacd0b85a97d-482a90d8d18mr10830231f8f.21.1787048879091; Tue, 18 Aug 2026
 03:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-3-philmd@oss.qualcomm.com> <13c02cbb-79db-4ebd-9fa1-63ffeb0b43f4@redhat.com>
 <32b54253-a109-44b2-bbdf-ab6440814522@oss.qualcomm.com>
In-Reply-To: <32b54253-a109-44b2-bbdf-ab6440814522@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 12:27:46 +0200
X-Gm-Features: AcwNN1VFiSjMiuQJ71eW-xkX8E_0sDDKU1gt8oWaanCnXolW3nB6r0igM4GL6Ss
Message-ID: <CABgObfbw7wO1s2jcMoiT6ZCZei1KBTETTW-3vzffmao615dP3Q@mail.gmail.com>
Subject: Re: [PATCH 02/16] cpus: Improve qemu_cpu_kick_self() docstring
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org, 
	qemu-riscv@nongnu.org, kvm@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
	Magnus Kulke <magnuskulke@linux.microsoft.com>, Peter Maydell <peter.maydell@linaro.org>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 5:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> >> -/* Unblock cpu */
> >> +/**
> >> + * qemu_cpu_kick_self - Force vCPU to re-enter to its inner main loop
> >> + *
> >> + * Signal the current vCPU thread to exit any blocking operations and
> >> + * re-enter its inner execution loop to process pending requests,
> >> + * possibly returning to its outer execution loop.
> >> + *
> >> + * Must be called from within the vCPU thread itself.
> >> + */
> >
> > Neither is correct.

Right, the first of the two in "neither" referred to the existing
"unblock CPU" comment (it's clearly unblocked if it's calling
qemu_cpu_kick_self!).  The requirement to call from the vCPU thread is
correct, sorry about the imprecise reference.

> I got confused by this comment in accel/mshv/mshv-all.c and interpreted
> too much:

Yes, that code is broken and there is a patch queued to make it go away.

Paolo

> /*
>   * The signal handler is triggered when QEMU's main thread receives a
> SIG_IPI
>   * (SIGUSR1). This signal causes the current CPU thread to be kicked,
> forcing a
>   * VM exit on the CPU. The VM exit generates an exit reason that breaks
> the loop
>   * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the
> system
>   * will shut down. For other cases, the system will continue running.
>   */
> static void sa_ipi_handler(int sig)
> {
>      /* TODO: call IOCTL to set_immediate_exit, once implemented. */
>
>      qemu_cpu_kick_self();
> }
> >
> > I'd rather have something like:
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 83cbd120a84..e5d068e341f 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -3292,7 +3292,7 @@ static void kvm_cpu_kick_self(void)
> >       if (kvm_immediate_exit) {
> >           kvm_cpu_kick(current_cpu);
> >       } else {
> > -        qemu_cpu_kick_self();
> > +        cpus_kick_thread(current_cpu);
> >       }
> >   }
> >
> > diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> > index 8a1af35ed32..b9b1ee39850 100644
> > --- a/target/i386/nvmm/nvmm-all.c
> > +++ b/target/i386/nvmm/nvmm-all.c
> > @@ -753,7 +753,7 @@ nvmm_vcpu_loop(CPUState *cpu)
> >   #if NVMM_USER_VERSION >=3D 2
> >               nvmm_vcpu_stop(vcpu);
> >   #else
> > -            qemu_cpu_kick_self();
> > +            cpus_kick_thread(current_cpu);
> >   #endif
> >           }
> >
> > and get rid of qemu_cpu_kick_self() completely.
>
> OK I'll take that route.
>

