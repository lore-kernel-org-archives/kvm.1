Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953644A99C3
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004376; cv=none; b=QajTcEN+40Ihn4F/Y5kpPNYGyZL3HYp4l7i5rZwz5AfrQGI2QdxXOe0eSrpMr4rrMU3XYWrfB8ZcF2uNHLQ1AeiJc++xnVfQUm/Pc/lJhmq5VaE3jXSEjlzLPac4u2+kKfupixuV/01da6eKptCMo2xUZJT6KsCum4IDHu47xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004376; c=relaxed/simple;
	bh=/8RGZVQWUyzs19cUu3Y//9Vj+1op9fq9/ZosbH4mY4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQDlklb3Sb/4zm13rMyDxSiF8Cupb0sJleLCDGSAnkKheoa6n0e81BGEmYHj1GMrcAB6gr9SveUtY49aAZDJsHIxyaLsvRo3b5U78J0tD7Q4xbSydGKMmNEk8wl+beyhEQj0opIzdhEAY/cYGpkJed15rKzz1oC3lq4Pa3B/NlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fx/R2cHP; arc=none smtp.client-ip=95.215.58.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fx/R2cHP"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/8RGZVQWUyzs19cUu3Y//9Vj+1op9fq9/ZosbH4mY4I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790004372; v=1; x=1790609172;
 b=fx/R2cHP+0L8ALvPMfPkydjlvDM3sjVE+zypPRDCAPzPz2pCCwACtrCjfOAu9skjBZKobSNL
 uNZoGl+PzMLE5lWgol1lrOBF4lqAu9gf+Mv2cc9Q7WM5DdJB/rORhoJTBHG0Y6U1iJNJz+vcqlo
 4xWT+3DtcBzjxJI5i7CI+DG4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3ea6149d8565f925;
	Mon, 21 Sep 2026 15:26:12 +0000
X-Mizu-Trace-ID: 3ea6149d8565f925
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b8c42da963so11607e87.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 08:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwANw9Jj42l87UZorSSy90vD7mbutxajM87Y5SuxvuGpgTvf3cPAgsGC1llTDMQxI5F+9w=@vger.kernel.org
X-Gm-Message-State: AFuF++m0BsgQbM6eXF4kTn/lZ6+x7oqiTnl30VjC0X54rSjsceBM7W6Q
	eJjNvU+xq5vom5cC6BzfR61CrY0resLd0ohi4Ur5kt2F1ehKN/CRWsJEk9hCnZIFCkbcsBlB3si
	83LyI3BlnRac7iCu/mre7Q9C5hVzkC9m8LUUBCYdm
X-Received: by 2002:a05:6512:3c86:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5b8c7eaa535mr194108e87.9.1790004367252; Mon, 21 Sep 2026
 08:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921140427.2211373-1-fuad.tabba@linux.dev>
 <20260921140427.2211373-4-fuad.tabba@linux.dev> <20260921141701.33CFD1F000FF@smtp.kernel.org>
In-Reply-To: <20260921141701.33CFD1F000FF@smtp.kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 21 Sep 2026 16:25:31 +0100
X-Gmail-Original-Message-ID: <CA+EHjTweK4XJZNaeKKzizReQrP+25jDT08hDkc9+zQoxWu+iYg@mail.gmail.com>
X-Gm-Features: AcwNN1UdQ0NUVS431o0imISYD8tq6CTjYnZ7u83ldsAQHh0Mec-JjbiaaUqj-84
Message-ID: <CA+EHjTweK4XJZNaeKKzizReQrP+25jDT08hDkc9+zQoxWu+iYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: arm64: selftests: Test a timer set past the
 counter's wrap
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 15:17, <sashiko-bot@kernel.org> wrote:
[...]
>
> > +/*
> > + * With the counter at wait_ms, a tval of -(wait_ms + long_wait_ms) puts cval
> > + * within long_wait_ms of the counter's wrap: a deadline further away than the
> > + * counter can reach. Unmasked, so an early ISTATUS shows up as an IRQ.
> > + */
> > +static void test_timers_past_counter_wrap(enum arch_timer timer)
> > +{
> > +     s32 tval = -(s32)msec_to_cycles(test_args.wait_ms + test_args.long_wait_ms);
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(sleep_method); i++) {
> > +             sleep_method_t sm = sleep_method[i];
> > +
> > +             local_irq_disable();
> > +             set_counter(timer, msec_to_cycles(test_args.wait_ms));
> > +             set_tval_irq(timer, tval, CTL_ENABLE);
>
> [Severity: Medium]
> Could this sequence lead to a flaky test on a loaded host system?

Yes, a stall of more than long_wait_ms between the counter write and
the TVAL write leaves cval below the counter. This should sort it out:

-        s32 tval = -(s32)msec_to_cycles(test_args.wait_ms +
test_args.long_wait_ms);
+        u64 cval = -msec_to_cycles(test_args.long_wait_ms);
[...]
-                set_tval_irq(timer, tval, CTL_ENABLE);
+                set_cval_irq(timer, cval, CTL_ENABLE);

Cheers,
/fuad
