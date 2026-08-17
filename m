Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2A3EC699
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982416; cv=pass; b=NgAgPgiov7rYWKAKGCV0xX/EvYPSPJ089BxmU2BXadBRJA3/cmjWWl2HBhDhhImg3FUYOY+L+WroUPfZnNi8yGBBHijw+s+mVmpAKDXIY+4VSw6Kb/HN2D+vc2gSZd3h09yElzUL1e6wI1HSg/+medi59m8MvUA86dSdd0kmhvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982416; c=relaxed/simple;
	bh=1HWWPus1OiqRV3w6IosVosW32XAKJh2cM2hZfaeG4+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaYlzgR7mZ29tg76k5j2SQbwghaTWKhf2HPNl9HoF+Nw+QZmJTMFqcFDHr1OvyQ+S71DABvayUl9crfxfJ/YXZf6YhoJY6xt6iumUvz06eW8rrbS3/8i4cqxJuRhwWhUBX7IdhanY05XSKr/UwXncGAFJTbn0w96Rn78ZeZrRhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObFGZ4hN; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObFGZ4hN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-836c4474028so34925847b3.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 09:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786982413; cv=none;
        d=google.com; s=arc-20260327;
        b=IRPMTLGHdnQ3dwF/5qMBwO9PIoGQCv59d19J5hkW0e2xlx/gHka9oddbRV6OJLIddm
         EEukpA/LhayR2bw0sqQY9iDBRUYtScVlhq5cplMTz93MQoXuJLQ6KB6qaNzEFXtAJZar
         yri/UmriRdqsURm64z3Kl2h8g7NBJgAoNVOk5yr9JS+tx2ZBCN8Jzt03i1CnaPKOGDh1
         zTrxcA8SH6siSNgZUpcrJqU3TOjWzKYXy4zjaoJZnwgimq6BfGq0s6G1s/Y0j9l5M+VE
         dAq2EFDN99HY0IjHRXpXYz5ze1AXIEKcjj/5jH4I2eKXhjPLpyCkSgyiUv79g0Y3Vw3+
         O89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0v20WHATN4inOkpw4dTSEM5J6s+dmnOJCNOR4bt+A0=;
        fh=A2YD+N0cI/4aCslxDw3moKl33KwekEbTCiypaII8/EI=;
        b=qDF5G9MClxY5XmrOLOtKAssWyfJXdrgKYIv/ltKTuvzU/XZ5FN7luVOe/RCkypciRj
         gOAPZVqiwli++ewAGxqcQ7w9PJfKrKvjbPEAvbmA2kXQVdSv6IEjBJFoc+/iFJJKOazy
         pu0BXzxq3uDY1mTgU15fuGTou1lpAW1rElZq4e3dSCPPg7GPbL68fs/0pR+s4xcvsjni
         yTMGjbL2x/yLkbHB8/QTwGUVLMO+ZIozLSD889zz/+8/q5vyX4cKEpzC3T0PtG2U6tle
         4IiFMhZLBBzgQzbCOpl/03/Ikr7EzsiZXgbKSJ8HJEOeAaH69q6bKD4rD0ZHfN0i51sg
         rlEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786982413; x=1787587213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0v20WHATN4inOkpw4dTSEM5J6s+dmnOJCNOR4bt+A0=;
        b=ObFGZ4hN2BwDuzjQe4AFIkRbqej9N8b8VFLfwZKHT+K2pO/IEjFNVBkdCuPwwJ2aVg
         /qq5Ly7pRSxsKqudhXToeNmBdZbvgERMH6xHLS8zXuNh35dkSZWAIrlrYUUqkVK7hAUG
         w2TQShNkxDqYn73k2eWK+SnqDZ9rpo+sCXp7/uiD/+HRVLNrLrPuOcAbMNbubUPxPTp6
         SkcPE5NG71I3gWx39+U5hizqpgVWoncvpOUfIZ/8kBcaWmbuNLZ4Tu6cXOuji5f1Ftwh
         676rt2rUuZ6xOyQM0l6KOfTD2OpRkzW0XVeWLjMeSz31qe1BEyhbEDTwBcwr2RWRZgmZ
         DYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982413; x=1787587213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0v20WHATN4inOkpw4dTSEM5J6s+dmnOJCNOR4bt+A0=;
        b=rwG9bdN2QugQk7hRDG9jxtcUugvpJ1jTlS3wzbWqGmW3jNAq+PYTChpx/w43o7oIjW
         d75spgr5zkV9MUlIxEUFhXUutFAAqWC8Bx9H4WPmh+On1qAlw+w0AK7Xw46Fy3DYPyYr
         cxnYvn3AAX4Sl6/s3HqkX5gGo4HRl6CJCJh7Qk067+aL/h80gBN7Dq7tZodPNX6nBd0R
         6mAkVHp+shZp5s6zzraS/3z8/wXGkHOPd9v7JbX6F9NrBfE+4Bd3G2YgRoxe4GySbeIW
         bEjjJsqs8NS/PaGHnpbwj/gR97UZCiMa0em1+skZNLaqfrOPgQYDQn/JYVOlXUgRZ1pZ
         XAqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDa2z48ON46b0EwhhJs+UOul1tW9ZgQZNwc2nfDKgMSnB8HrFM6wGPaXsJM8Kl6mivtig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPYgeYwB8nMazXC69TGdt77Qahlj/z5euuP5bBH7gcR3MAO2z
	17u03BGaoFKeSkLo/XvJ+ak1UVAzhh8JGrlxoWFUfBTPwFbF+3Ob1XEmCh4o/y3O4/Bp3ZJK2p9
	k54A6UYpmDjvhkF0NGkqaRGeS2Fdmuc3sgGVQZLfoPQ==
X-Gm-Gg: AR+sD11tZku1wHIyCG24wGzc2zVRuC7itNIyzY0V7+0aBOzLVXxxsxET/P1CdiTzh1x
	mJ7U37OorEpTPSGyU1gLH0nnt5WaIe50nR2CcsVKx57uURzZ68EtmJCy0yNHQQtUKidiM05wBcI
	qa8RJX8koBC9DppIMILrekPImDtDq5QuLut+16i1ZZw1CIkRErSx9/7k9USjMtbWHN+U+3IBJ8y
	JLVnNHe7jwt2WeaTuj6DqAYPWOBygkIsbDiZLka7rkGA2BT2QhT9ofkQL3q1ySv1xENeiZxuCIn
	vDKkyP50WI2YQlbjDCc8ncUQc6xnVzBTjg6m5uI87E4zW16Mn+uNxxmcadGeZ95UGk1xk2Fg+rl
	ipTtzCP/hOIUUktBhaE1w78TTkniz
X-Received: by 2002:a05:690c:a4c8:b0:81d:a1e5:a4d7 with SMTP id
 00721157ae682-8370c93d31amr76988627b3.5.1786982413325; Mon, 17 Aug 2026
 09:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-9-philmd@oss.qualcomm.com> <0143f26e-eb64-4924-8e76-3b6ce66fe6db@redhat.com>
In-Reply-To: <0143f26e-eb64-4924-8e76-3b6ce66fe6db@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:00:01 +0100
X-Gm-Features: AcwNN1WKg9kcvA4JNKRjNxIc1m-gB0o4nyQG1KVRXlHPNyw8dOI79_GwpnDCC_k
Message-ID: <CAFEAcA9CzSeOKHiPdwUcowYhiSs2tcT0OR_j6mnyvykgMoaZLw@mail.gmail.com>
Subject: Re: [PATCH 08/16] cpus: Slightly improve *run_on_cpu() docstrings
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	qemu-devel@nongnu.org, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org, 
	qemu-riscv@nongnu.org, kvm@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
	Magnus Kulke <magnuskulke@linux.microsoft.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 at 16:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 8/13/26 20:16, Philippe Mathieu-Daud=C3=A9 wrote:
> > Be a bit more precise mentioning BQL use and blocking calls.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > ---
> >   include/hw/core/cpu.h | 36 ++++++++++++++++++++----------------
> >   1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 183ef9f4ef2..d610f87abd3 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -908,36 +908,40 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func=
 func, run_on_cpu_data data,
> >                      QemuMutex *mutex);
> >
> >   /**
> > - * run_on_cpu:
> > + * run_on_cpu - Execute a function on a vCPU and wait for completion
> >    * @cpu: The vCPU to run on.
> >    * @func: The function to be executed.
> >    * @data: Data to pass to the function.
> >    *
> > - * Schedules the function @func for execution on the vCPU @cpu.
> > + * Schedules the function @func for execution on the vCPU @cpu and
> > + * block until it completes.
> > + *
> > + * Note: The caller must hold the BQL.
> >    */
> >   void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data =
data);



> > +/**
> > + * async_safe_run_on_cpu - Queue a function to run with other vCPUs pa=
used
> > + * @cpu: The vCPU to run on.
> > + * @func: The function to be executed.
> > + * @data: Data to pass to the function.
> > + *
> > + * Schedules the function @func for execution on the vCPU @cpu asynchr=
onously.
> > + * Unlike async_run_on_cpu(), all other vCPUs are paused while @func e=
xecutes,
> > + * ensuring @cpu has exclusive access to shared state.
>
> Might as well mention that @func is run without the BQL taken and in
> fact must not take it (see comment in process_queued_cpu_work()).

We should also mention the massive bear-trap in the run_on_cpu()
function, which is that (a) you must call it with the BQL and
(b) it will *drop the BQL* during the course of execution, so the
caller must be prepared for other threads etc to be able to
reenter it, update state, etc between when it calls run_on_cpu()
and when it returns.

(cf https://gitlab.com/qemu-project/qemu/-/work_items/1109 where
we can segfault in the raspi display device, because
memory_region_snapshot_and_clear_dirty() drops the BQL and allows
the device code to be re-entered, much to its surprise.)

thanks
-- PMM
