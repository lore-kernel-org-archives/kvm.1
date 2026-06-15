Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA13C37A3
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515178; cv=pass; b=BeHaWGiDcHWVnS6WMxFywk6eHaNmprC5sZWxsUvpCWKFl80ddJCnKIdtKvMMuFjaGaX9qhqCwwwUrWy36rSduWf43Aas8JGB/Z29IyNvqUVhjwDxwnLDnkKwheaF+a5hSpYlnhDkoXaMa4GlSsUyQ1+TAKxteVzr00TV3TuyqCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515178; c=relaxed/simple;
	bh=0UOyVwoEmZdu5gnMGHg4wO6JW4ZHOAN5pp9vpdIhi84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXX+gnEBhbvIrdKDPzWF3LPpwEbTP7qMTWsA/6gcZTAsr7yFtODmC2LkYKfTqJ0/37P8P2Yod7cuzu2N7yJETnPLKMPAGZ6kqNgwn1Sji84NfSskV3oG8eRi+r69LewINO1hQPn6g3fEz5fWr2VubptVsUEi7s9m2iqkEQUz7ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GehNcqdK; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GehNcqdK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso6019804a12.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 02:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781515175; cv=none;
        d=google.com; s=arc-20240605;
        b=Hs4PPe2fo4pNmuj1j4P4elZJgA78s7MQsa9cHmunCs6mJrg5V6WcwkWWJSIQgzp3o1
         L+VCBc56q4ZWSoLHpozvPD0RjczupwOP0Vc47VZ77uDzDs7eMDd98h+4I9XFt+aeuLCC
         CqYdjrzAU4db4GapRUGfB1K0SVPzjvpaXKjodBaltkveQNumjP7P/l1zEsl/xpgwm1nU
         PIHVWsO8YLXO8A1LCtNngNtEyJK1f9o3+9C7R3/cw4gwcxEOEhYyMguOAJyprqzoQk+K
         EIu2FL37MyvvsgV540Qg2bwfuetM4etCugdXdovmQ1hceMyLjGP9kig84QjfwhExqwXb
         Jn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BHxlXNZu6/Er/Lz2DwJSJW/rgaXb77NjXetmkINefZc=;
        fh=rrKi7q8MZHLhtIdwOTjP/ywJgi+duU8w1SkS9HfR+jw=;
        b=WdB1sY0lxEcin5jY0N7yrMYyx/bwN85Zb667bM2Rsj0X8k/oyxEO4LAsEhOPGZ1LsH
         8/N8oE/JsX05EQVy9YM/GiIxaLDByAJ2Rh9GXTblngy1Z2d5PMUeFefExopQmQCNFaFi
         8Aspydvme7XZM6NwMICxhkkqOFmVOU0+LvY6PkMPYz6UN6183nfAjIz54jT1VzE2NtlI
         +j01EgOHSEsl/GVJUwBd9N3sNOm5qqSwyI109N79bbGJ2q89sN/r/dpB7dvdWgaJ4u1r
         Z+f9urNqTmwKYvSlbqQ6FluvJ2uae8Pv1aaAJ4CoQIgONHxOGd8vdI6sjLs1nNi5nBak
         V7ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781515175; x=1782119975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BHxlXNZu6/Er/Lz2DwJSJW/rgaXb77NjXetmkINefZc=;
        b=GehNcqdK/z/CoEqds/C84V/SlV5vyzffOW5r/aN3Wmsu4lSwi9eLuJGy6+S8TC6u5K
         RUE2QOTs1ZhZotI1wAQTI8bL1fk9mD13DLDbwxN3qoJevHEIwgvdDFDbZ2WCfqFM8126
         +m4vmFP/WdnOIAUZ/1rlTmEn4mDmnX+3W0vz/voIMmqBQ0yfiwJpKF7lWiD+l3T7PX5g
         WOiMlsebC2Owm2euxWFYofjHL35No9z2vLKyYplGk2R3tzxtMDj2jO/qHaCkmwfRhI5V
         JUHRJ8ikntjhKFAGpFpbRLdRxBSjdqP2H+IrStpqo0HLel5b29nY9vXh8WHlz+meOp5u
         iC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515175; x=1782119975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHxlXNZu6/Er/Lz2DwJSJW/rgaXb77NjXetmkINefZc=;
        b=haco3MEmKVdxoMZQSapH9toron+u3C7zgqpuTlJkZdlDP6BCeuAVM26ikWBsIs+/QD
         RqH9KwfFxKRcs1GVHcvUTKneHwIKR59PHf8PEWPk4juWQIlKS6U4YYy7pqQIbi4y5Rkg
         BuSyacgSr4zbUm8BLWMmliPnN6Hmoz8Js9wgIZHmcc1BzQ3FQQElE0FIqFWk81WPKoX9
         3kdPiXQx125mV4VaFpuLnHHSbt8CA/L5K7Wry+bF2d9bwmkjJPmIVWVM+OUzOpxSIkMB
         IDXkriruIgtn3s5u9C5SofZdEemfsd/yuwQYWU8sgeE819+MrR/9xcT0QtkUokjc//B1
         MYjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wikLvQ3H1yirW2q8q20cGLGw2MxVGbGefDihmVFBi7lYEjKu3eZveIbeGGcb1Px+0G/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDxCZxkr/GtiKRK2+P4+0iDaxJ48fuPVi1q7BAAM81DKcTtJS
	g9KX4noXGnoaCQSen/LAQHiJIR/hz67FFXv4NIKEomnleESHSF+iUNlcMmxHPd+QSWh7kkDE57c
	oO+IBTjt8FB89qXbOuuVhDvaafBnBhX+SaAymHnwLkw==
X-Gm-Gg: Acq92OEgaZBVFruMtTu3mYV1NzqAqcjXKdUc9BrlYKgDAXMxKGA+icrdw5eUQO1oY8k
	I/jn0a57vINXIaHVL1TD+GmiOY9OZ5vf1+SUWT8ecVnvJzJn2fNJBr6v5qzuQd2wvHRNvBieNcv
	mHj1UTNHyec72Y12mWhP/s6/yhhSxmK7Y4EbkmHM7PmbOdlSAWFwvB//BcnpXolhB9RkGe26zxH
	m55Mqt02WuX3S7tXakqDnkBAb4ERbZ1lYd2RocoWQbKxAiqhzKQpufE+B3MA4Gs4wei6zsIrtBD
	WTe/zADmlepVbmOVhO7IYfzaNpIL3MvsFbU=
X-Received: by 2002:a05:6402:380e:b0:692:4758:f56 with SMTP id
 4fb4d7f45d1cf-69378ffca29mr4852685a12.10.1781515174933; Mon, 15 Jun 2026
 02:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612013355.59231-1-kernellwp@gmail.com> <20260612013355.59231-2-kernellwp@gmail.com>
In-Reply-To: <20260612013355.59231-2-kernellwp@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jun 2026 11:19:21 +0200
X-Gm-Features: AVVi8CecBsEOVQeqtJD5T_Sa2T0yUfdh5fZuRu9w1OOqLvGq_ryhFlXBmIIEU7I
Message-ID: <CAKfTPtB=QJTpmWOeuYY3RWxR8kT2FkhW098CKhN_F-Dvf5=WUQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] sched/fair: Add EEVDF lag credit primitive for
 nominated next-buddy
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>, Richie Buturla <richie@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 at 03:34, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> pick_eevdf()'s PICK_BUDDY path only returns cfs_rq->next when the
> entity is eligible. A yield_to() target that is behind avg_vruntime at
> any level of its sched_entity hierarchy is skipped, and the
> set_next_buddy() hint is lost.
>
> Add eevdf_credit_entity_vlag(), which can credit a nominated entity up to
> the eligibility boundary so that pick_eevdf() can honor the buddy hint.
> The helper handles cfs_rq->curr, which is off-tree and can be shifted in
> place while carrying any active vprot window.
>
> Gate the helper behind SCHED_FEAT(YIELD_TO_LAG_CREDIT). The helper has no
> caller in this change, so mark it __maybe_unused; there is no functional
> change.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  kernel/sched/fair.c     | 48 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  9 ++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3ebec186f982..e7f5ea25fdae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9341,6 +9341,54 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>         }
>  }
>
> +/*
> + * eevdf_credit_entity_vlag - credit a nominated next-buddy to eligibility
> + *
> + * Advance @se (already nominated by set_next_buddy(), so cfs_rq->next == se)
> + * just enough negative vlag to reach the eligibility boundary (vlag = 0) so
> + * pick_eevdf()'s PICK_BUDDY branch returns it. cfs_rq->curr is shifted in
> + * place (off-tree, carrying any vprot window). Queued entities are left
> + * unchanged.
> + *
> + * Idempotent: a no-op once @se is already eligible. Caller must hold
> + * rq_of(cfs_rq)->lock with rq_clock up to date.
> + */
> +static void __maybe_unused
> +eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +       u64 avruntime, credit;
> +       s64 vlag;
> +
> +       /* Callers gate this helper with YIELD_TO_LAG_CREDIT. */
> +       if (cfs_rq->nr_queued < 2)
> +               return;
> +       if (throttled_hierarchy(cfs_rq))
> +               return;
> +       if (WARN_ON_ONCE(!se->on_rq) || se->sched_delayed)
> +               return;
> +
> +       update_curr(cfs_rq);
> +       avruntime = avg_vruntime(cfs_rq);
> +       vlag = entity_lag(cfs_rq, se, avruntime);
> +
> +       /* Already eligible: nothing to do. */
> +       if (vlag >= 0)
> +               return;
> +
> +       credit = (u64)(-vlag);

Please merge patch 1 and 2 because the current function is incomplete
on its own.

> +
> +       if (cfs_rq->curr == se) {
> +               /* curr is off-tree: in-place shift, carrying any vprot window. */
> +               if (protect_slice(se))
> +                       se->vprot -= credit;
> +               se->vruntime -= credit;
> +               se->deadline -= credit;
> +               return;
> +       }
> +
> +       /* Queued entities are left unchanged by this helper path. */
> +}
> +
>  /*
>   * sched_yield() is very simple
>   */
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 84c4fe3abd74..65c511c9ca28 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -40,6 +40,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
>   */
>  SCHED_FEAT(PICK_BUDDY, true)
>
> +/*
> + * Let yield_to_task_fair() credit bounded EEVDF lag to the nominated
> + * next-buddy so pick_eevdf() honors the hint even when the target has
> + * negative vlag at some level of its ancestor chain. The credit is bounded
> + * by a queue-depth-scaled margin within entity_lag()'s legal range, so
> + * fairness is preserved.
> + */
> +SCHED_FEAT(YIELD_TO_LAG_CREDIT, true)
> +
>  /*
>   * Consider buddies to be cache hot, decreases the likeliness of a
>   * cache buddy being migrated away, increases cache locality.
> --
> 2.43.0
>
