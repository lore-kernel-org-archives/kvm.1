Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91263E2763
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284736; cv=none; b=kwA9ke3ys4UlVRXmMo2acenHzyzMZco8ogWTTkepzHwO44zcTRTILwNnOHrlda0C73ame5ztaGlAKO+DAqle8EaPZmKiqPJEXsCyYI9jHOtC5XQ040MOPNLU2kaYB2yd7gqfg+w4mQcXVQ+OFF6cBo/piasu3QIzhwVGcFGo1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284736; c=relaxed/simple;
	bh=6Ig7j++nRpygjJXWN4caeOVkxAiNZBYjIFhiRbJ2pwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+CILnW0hQBEQUE6RtHwYxMo/FUCBOAusPpv8O3nd7t62q2eB3zYZVeWFNCAyNFWPtkjY3tyXiHYuk5jiRH/BmT6V5zqW+HSsVIUQxXXQc5UfbB/jfOQRUc/OOwmItRAqbIkhioNVRPTW7hKdV4Y04GEGzrYNWLg4znWog2xmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHIJ9FdI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHIJ9FdI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so13055655e9.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781284733; x=1781889533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuOtHeBbJw1YDeqbXCJ3sEezGFxNJJSYyUp7OFWdCrE=;
        b=LHIJ9FdInVnhtoUNrOz8G9s1+LSgSmzoIUSc2if5ySdAm7HlsLiXBsB3nrWAo9CMlG
         dvzOeY5I3D5hnvFTnIQidtQtDbCpy4VpNT2lfrVgkAxiURs/OQbQEchr7rXDYumCFPx0
         ZaZAyDrH8VMF5p0ARyHdALioOaONYY07Iwkyo0BXWARuDShVOKA5pJ8Rk/flWJh+kiPh
         CrSWJ3tyqZ2wAD/Cy7HaZTvqosgTFatDueX6uBPAvdKSkxK+GViZF+kObPmWSnDWw0gu
         TcAT/1FQkdNx08dpL0Di429N9EcND/PHA3S9G3CCcmsSwom5LBvzpUIEk9RUGVvBfA3G
         1QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284733; x=1781889533;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuOtHeBbJw1YDeqbXCJ3sEezGFxNJJSYyUp7OFWdCrE=;
        b=sO6meYdMHbsrhLTJ0PwFoIe9ZWzlpnJJ/yAWzrfO+7KjUW9fNLAwYn8+ejMVEjC3vU
         1p7Pbiv8TKehwWiUw9ZHnVMGadbMXxbG2gm9OAjLI2dMqOVzMHAjcWfFiRoonabDS6+g
         L2/56p6gZp8AWrcV2AJrQgys2j48Ja5ku3UHe6pLm8UwzksCkL4TxAu/VKOClCGakIIn
         nBgBeGFKHhxYpHG64uTB65Rzz04r3ejwS4LDbLKaG8xWKoX82epOu2hSdofvQ6NuWTaq
         QDp4iIZNqJlDMX1eqhXqGlcRyw648fwCbng2bG4b52DNBQHHPy7qR+QWA2R3TNuDRqh7
         9vjA==
X-Forwarded-Encrypted: i=1; AFNElJ/zNAT1sCGGPlMHyNXoJfstdsHfQv4b2LhWe/MIWRfAq7yRvyO34JF++R75Id9UlpwsbBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSKgzN4RR010W44irLr166jmkssCuOdc7H7CwsPJ9yjrJ7cvy
	BS/O+Dl5MpZUEiENg4iqrCEbt2vyYoV59/rN46Tda0SFrwvlrFoTr5c4/ZD1ElpeIgg=
X-Gm-Gg: Acq92OFKq3xdODAG+IG0tU5SrI92P2YxOliKr9RVRQHdRJ69M5uLvmN3/rLMmBK7OiY
	E1EnrYcxNKseL0CFpiFfpEKCywYVTJKnMT4SadPcSnhqRJz55XiqLhRepmXZyxYEHzvx+kgmAHB
	D2d1SzByWG782vQv82UfKQGV9OaGMuoTWhVBBC8pTwH4nzEsUhhp+LxhhbrG6XFx1chyEWcYtva
	A9gAY4DN0jK9MCXrvBGb+hzxJcokw+ol5ECrCg91DNfz50yC71syGkoqnXN/p/+hZq8NoflY/Vv
	U6hDjV2M9P3Ge7gJ+8UPcFvZzBMLoHjXHpkyEQzMpvWAmmbxC4NzWC3b578RLchx4sm2yieiA6Z
	fsxLHAEgz+xX+hyke4XaLVmQme55GXKMlyJDKAXO2tMCW1aFj9eW4xTYrHRG46qXabOTCIW9ZW+
	c23cScE4njkKdACu8nZOWKd1E=
X-Received: by 2002:a05:600c:83c8:b0:492:1e36:d16e with SMTP id 5b1f17b1804b1-4921e36d1a9mr17505975e9.36.1781284733060;
        Fri, 12 Jun 2026 10:18:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922035b4absm3694975e9.11.2026.06.12.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:18:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 65D125F814;
	Fri, 12 Jun 2026 18:18:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
  Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
  kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
	(Peter Maydell's message of "Mon, 8 Jun 2026 14:51:24 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
	<CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 12 Jun 2026 18:18:51 +0100
Message-ID: <87h5n7ekxw.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This series fully models the behaviour of WFxT instructions. We
>> already had support for WFE for M-profile but we left off A-profile as
>> it has more potential sources of wake-ups. The main one is the event
>> stream which includes events from significant bits of the timer
>> ticking over.
>>
>> The refactoring from the previous iterations of the patch have now
>> been merged.
>>
>> I've dropped trying to fully model the global monitor in favour of
>> taking advantage of the architectural flexibility to have an IMPDEF
>> event wake up for any reason. We treat the setting of exclusive_addr
>> as such a reason because it indicates the current vCPU is in a ldstx
>> exclusive region and we don't want the guest to deadlock. This does mean
>> the system won't sleep on WFE enabled locks but people shouldn't be
>> relying on QEMU to model real world sleep patterns anyway given the
>> efficiency of emulation compared to real HW.
>>
>> I've written a test case using kvm-unit-tests:
>>
>>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>>   Date: Wed, 27 May 2026 12:18:21 +0100
>>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>
>>
>> All patches are now reviewed.
>
>
>
> Applied to target-arm.next, thanks.

Is it too late to drop them? I've a fix for 2/8:

--8<---------------cut here---------------start------------->8---
modified   =EF=83=BD include/hw/core/sysemu-cpu-ops.h
@@ -18,6 +18,9 @@
 typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
+     *
+     * This function should be idempotent (i.e. not change state) as
+     * it will likely be queried multiple times before a CPU resumes.
      */
     bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
     /**
modified   =EE=98=9E target/arm/cpu.c
@@ -158,7 +158,6 @@ static bool arm_cpu_has_work(CPUState *cs)
      * A wake-up event should only wake us if we are halted on a WFE
      */
     if (cpu->env.halt_reason =3D=3D HALT_WFE && cpu->env.event_register) {
-        cpu->env.halt_reason =3D NOT_HALTED;
         return true;
     }
=20
@@ -170,7 +169,6 @@ static bool arm_cpu_has_work(CPUState *cs)
                            | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU=
_INTERRUPT_VFNMI
                            | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU=
_INTERRUPT_VSERR
                            | CPU_INTERRUPT_EXITTB)) {
-        cpu->env.halt_reason =3D NOT_HALTED;
         return true;
     }
=20
@@ -874,6 +872,8 @@ bool arm_cpu_exec_halt(CPUState *cs)
         if (cpu->wfxt_timer) {
             timer_del(cpu->wfxt_timer);
         }
+        /* clear the halt reason */
+        cpu->env.halt_reason =3D NOT_HALTED;
     }
     return leave_halt;
 }
--8<---------------cut here---------------end--------------->8---


>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
