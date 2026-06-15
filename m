Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A32E7631
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515006; cv=pass; b=u/USjUw5xq3f1rfDptm62BQQguukuiha92b2YVRvuJxiwKOv96V9HzzUzS0ZHeW80y+QZyB9RS5+BTRO5NTpNSL2HVURR94I9mdYpoevW2eqSaVIuvWAgUPE2lNZalmS00pPUSAe2EejPx7jyrmNGlKGNLpL8dHM8nqztbZvE0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515006; c=relaxed/simple;
	bh=Y04jxsPlJgdbEAbgGH2RCtL768VHrZGI0Tt3a/Slr/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwrIMu1vmTz9QlmI9yW5gdYw5GsX5wTkY6QgVpwGcegcPPBJCOa70j0TDQ4ys1FHuJJFzNfrqS50w3uzt5n+O7f4CBGE1rLdbiFDcjDynmcUmZdU2JiLkNHIL2zymo6eY4V9qW/6gYmKZ6AHxubXM91I+oGR/oNKfjK5nhYeeLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrrMkl6A; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrrMkl6A"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bef47b1ac01so410785266b.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 02:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781515003; cv=none;
        d=google.com; s=arc-20240605;
        b=gLX8QPIKqQXWG8uYPVMqchynphxMeX9QyuMJiw3UF89Xl1d4oM7IptneolUCt+YFKX
         NiAa/fG2LRW5DW7GARKtqAWTQBcvSo4aSqa2bMEy+CJT96wxiNlkUHwzyYWR7uXDz3cz
         PCosXxkLJC+6PutslbA4jwJFWVFd+HJIMjDXiuOuD53dauucTmwPNKeyphvckrjD0BJ1
         51MkAYym/v+8yv5lRRzq4XL8soEOA64DDVGRwIiskmHfVNgGMSZ39JJpjqcdFvuEkXwg
         UO9Xw0KBQ4MnV53b7c8v+nHkTK64ymmbgldT5efKXQzjrDmOUVwOuuPHvMVNitVR2fzp
         nbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O63CCaOLzOAWUgmqnULKdbQ9UA+U+M0wOlZFtezF3dY=;
        fh=kQTC9Ts86+ah5xGh69dhrUH9NfuUQyVIm1xXQUdZE/k=;
        b=RMq4qJ3sdhsKnMW278yj7ULPw6T8ZD+ieSe1YzZRbBPXRUHijYWOqa99jPRUpaCf4P
         dgekq0Op7aD0r/dnDABqYNOgh3sxFKuM+txdYirbpvDLxK2Cwy/wJEqxINE1AXdaL1Cv
         +bzqe8hXG7qnEX7TkPLgVYFF1PiY0gdH7BeV9PvXxt4BwVMY/MdA0T2lsje1/MNEzxAY
         8RSkOohs8p36xeS6et7UThD0Blgd0SZIb5fl+sqBTuocU+fu6LRiUR8h/S/voR2lLykZ
         jOj7PNLP7JiBGERbcvHX0kG/i1H19Jyv7Rd7hQiVBBD/Ivggi5COIUAX35KxXy7Vzk42
         Uydw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781515003; x=1782119803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O63CCaOLzOAWUgmqnULKdbQ9UA+U+M0wOlZFtezF3dY=;
        b=rrrMkl6AH7doG9+lrFMQsdRJu/B4i1yx+oQf2ti8Xz6LAmW+96lDIqOWlFWwKANr5T
         sSE0O+sG64eIxO6d49DQ9HiYyW96kqV6Yrxh36QNu1pqb03chzqmkRfkkIT7MHkV1z0j
         dRyo10Ba1z7cCUSJoHQNOJh6uwhc0SRUb8mgEkw9T0IdfQWvYejs7nwnCuCLSEFGIwFp
         5duiUViHLp5Wj3d1ljvQF38ABVKECKNY6dulOV0cAazRSKudB7TUPB5ZpFBw0k1RpiEx
         0YU1GiRm9VDYZJgoea1jsxlYCKZ4c7OKGBjzZ6v6tv4713jjTKoVUItfTrAG+akVumHN
         P7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515003; x=1782119803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O63CCaOLzOAWUgmqnULKdbQ9UA+U+M0wOlZFtezF3dY=;
        b=blaMFydZ21SLbSaLsy8WEq48kMBEThQFPdG6NpIfr9CxA4PMVPGHnF7V33VzHAiXUu
         zps7tDaVWpFUL5yQDNsjLsKISBDqPyxQaj60VgGGqBw1OQrHoVQzoLXg/GLTBUUw/RqW
         OrPeoRT2u4ErEMZLKZo/8tpcXV04caGTeyrnvPQJTuLV/ya8vSf3eU8Rx0ZMxo93tWCx
         eu8jFzYU8cAHP5ZLqboDreQYFuJUOw/PvTSDU8r3/lRf2z9QBjhczuYE57DPZVFIGa1i
         unLl0cbOw2X/QKek1zJzEJG0jWktanYg7Tvc/0y5huQTCHMvoaSQ7s6kzmrG5ie/SltU
         ch8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mf1sWts/ONR1tpYoGAR4ogETjzghA/W/smRh2+uR8K8QYLKLPaT0XE1MXlRGLEU9hqv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiQ+xeXmzq8kmDW9sbhG/eaospgzsLqnplZxz2VV242hdILc+
	T1BXjdq5vU07msTnHtxYqrrSG72RmxA/Ol+HrTw6kurpZzPOKO89FncDclQqL+kweIMSM6iYGZs
	H3ztE2ztjunGNjFGTydjmV3t5FZMwJdZrz2i/Psm5JQ==
X-Gm-Gg: Acq92OEW7o7rALVUMMODg7WzweHwiA9eeJ6i6nTrihg36jBYQ/Yci0QQjoqF6VwU9N1
	4tqdanxS5gfp6Y/Be/3yv+BN7hK7W1C4eTuR7cEwCVF7mLPswcgOu2OI3FC2lifAfhPfo5p8ukt
	s7VQjJV8T+EZve7BuxJ8UuNF+xJX3HwNXRzNj01KY9pflgVWztRfXtpNiW8atp4BBlJu+vnZu8R
	RM7NTTzZwJerS+cFrYoPC5T6nKNqpkuwya04bMolZiccLlRfKzrLrpsGuw7PFzxwPlzqGGRdx0T
	CgUdqMH3ZFvta7B9IDrGnFg2u5eXw3RI+3Q=
X-Received: by 2002:a17:907:c510:b0:beb:f459:718d with SMTP id
 a640c23a62f3a-bfe2a71b5e5mr562367966b.34.1781515003490; Mon, 15 Jun 2026
 02:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612013355.59231-1-kernellwp@gmail.com> <20260612013355.59231-3-kernellwp@gmail.com>
 <380d53e2-3671-4327-a613-cf35c58b55d9@amd.com>
In-Reply-To: <380d53e2-3671-4327-a613-cf35c58b55d9@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jun 2026 11:16:32 +0200
X-Gm-Features: AVVi8CcI8pHP1D8lYtN0LBzU4m9tBcY9Bwt4wQor-4CNTETO1JiSsCN7hfNR8SM
Message-ID: <CAKfTPtCQjYecO4z7VmUJKBTJ_2ZnJqL9Yh-+RsP1i2w0MkeKBw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] sched/fair: Credit a persistent,
 queue-depth-scaled vlag margin
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>, Richie Buturla <richie@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 at 08:07, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Wanpeng,
>
> On 6/12/2026 7:03 AM, Wanpeng Li wrote:
> > -     /* Already eligible: nothing to do. */
> > -     if (vlag >= 0)
> > -             return;
> > +     /* Clamp the margin to entity_lag()'s bound so place_entity() keeps it. */
> > +     max_slice = cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
> > +     lag_limit = calc_delta_fair(max_slice, se);
> > +     margin = eevdf_persistent_margin(cfs_rq, se);
> > +     if (lag_limit && margin > lag_limit)
> > +             margin = lag_limit;
> > +     if (vlag >= 0) {
> > +             if ((u64)vlag >= margin)
> > +                     return;
> > +             want = margin - (u64)vlag;
>
> And we are making an eligible task more eligible but *where* is this
> credit coming from? Someone should be paying the price right?
>
> Just adding an arbitrary credit and then moving the task doing the
> yield_to() 0-lag point is simply not fair IMO.

I agree, you can't arbitrarily add some lag to an entity just because
you want it to run.

>
> > +     } else {
> > +             want = margin + (u64)(-vlag);
> > +     }
>
> --
> Thanks and Regards,
> Prateek
>
