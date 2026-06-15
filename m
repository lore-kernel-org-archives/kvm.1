Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5D336EF8
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515325; cv=pass; b=YyBAFAOTYrZQQEsH5vG/+VFfTKQDw7+bNo5PG+kHyDRpJ5jHoYI+CASEHrLGU8qT9Rm6tbaOeHoVHgiyhnDNmlBOGytnjdiy9k+6A6Nw5pg7GcEBIy7mCEY3YdrnfQFX7yHc+VfI/sro1JaS1ZbE/b5DQY1QGDiuyQV3j0kL2Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515325; c=relaxed/simple;
	bh=fj2RKtwy61/foTrmRDo1XCFhSD3D7/e/8vUHyHmrTRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJsWBzdb+1GXtuYzZYicYX4FikxmEPfdkx80d9spsCY738Zb9EYYXSkuihej1ViOLk45YCrj+/roRn47jWmWHe2m2KH4MFUOx7MBJIksA9yesH6ePmFU5vZbtTJbsjRLLg5bHmS4hO/hw+yFMOfNyNrVwNax2Wz++W8ieTiOot8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFx6p70W; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFx6p70W"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d234218bcso5437852a12.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 02:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781515323; cv=none;
        d=google.com; s=arc-20240605;
        b=g0oPrQxeLgwCzA5XZ7mau0Vjp3MUi/mqAz2thFtoE/XXdpNojx5VuQEguo5BrR1kil
         gpQvIhoO7onKV+OPAzoiW4tsPqMlvbYOhAyFp83gfB4p59kg7c1YMn1Vu6diFIIMloS+
         gUGuV312O7VPtEcnVSHV8C6EY8PCvg3rArokpdFAzO7S7hpXp6BhdN6A485r+OImWA6j
         wP1dSgjIZCqS/eVINEAf8yC0kP56T6Vq9E7Icg/udgYjVdjQ72eKph3rpiO/DCLHzwyG
         A79sLijgLqgXKs6v7PGEDkrTNOcBAGVf1/hAwgMi4m/uohblXb4xfjrmLK9rVdCQvauD
         iCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qrhC+X0uxdRbtxTWrYJHWpiEFrC/cSIWfOa6CAt59J4=;
        fh=Z8E4PYZViqWrB/8P0N5nCOn+m2eTPYwfelH4N0aTdW8=;
        b=Ns+ZuDMAFcBXh2ov5fhfHFj6SwxNKFzTMG7J+dvtectGHXBsxnv4uP2I6Fadq0StUu
         VRHAY33ri+96oZx+yFrwNC9LQMLTUwV6Dv0D0ZoAdKmwUUP3TCjCCtjAlT5P5kwvJ+UT
         yu1ZuEAmch+Hbe/XyQ/8Sw8bbRzuAAPj5/xims4Q2BnMzkiFcl/LoLebosk+H2dXW682
         StHrpW039OqmEXXipQQJv+tXvyEIhcldagtYe2Gn9mGmAoqgq/auv4oCHo8Qa4lupbB9
         pRivPkwroJ5ffWLB9fgpE7+chW3NHlfiDAPeB0n4ICFHHpdZRvOQTxs4QX1BL2Hubpgq
         dwqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781515323; x=1782120123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qrhC+X0uxdRbtxTWrYJHWpiEFrC/cSIWfOa6CAt59J4=;
        b=JFx6p70WleEeEANS2+3DbMr+5FA6+7KaS47pNsRxjrxXQTs6yLNLUKYE1lxETEkX5Z
         56KNa7TkNz66+c6Gg8ECyO/EXUDB+SfsPKQ5EvdNm59LACAQmBNryTA9vdDmHCFOMTCS
         ibXgzyw4aMfGOVfw/BYQBcf3u6XgunS9CSi/8/t9ZqT8vIdWlXdEfQj5wz84DZlY6we1
         UhsLoFxZYBRmGQQr2XYzUTF5jaRuhwLFwrmgEHbLg0PK3d5eGS+v7z78+6tb5VU4YLJR
         VizPrAP7y8M5gTNSKuZShSvEmOR+8u13JWyn1aZmlzJ0yUiEuUx2T8or+RLHHOZjLi1z
         1NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515323; x=1782120123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrhC+X0uxdRbtxTWrYJHWpiEFrC/cSIWfOa6CAt59J4=;
        b=YWEzEDw39F93mt9xtZdCRn5VTDj7mSh4RABx6Gzd+ePt0I1LDUrZgjaW+mxiZGXfRc
         nyg9Gn4WHroIn7uJCN470vuswshhyEfZtzyaG7N8XSeQiGIAODj9qdIWf33A1VJPgjZr
         U1NIoi1M/smaTIGAUPshvGGaeEsKZS4MTgyFJkuCGqTAi62rqFL2iqE9qb2ZxJsGCRL8
         NwV37FiU5mfix5qwJT8qKvr9ErH6nLJ0Mw2t3trsBEGi0gq/JzFyvgk36D8sMGm3jyEI
         YX6yOmRwRqB7RaeM5FNwbWXaMkAqgqtej51tAyMFzLWlYFelDgqT5ysjSuutoO4FjdJV
         ko7A==
X-Forwarded-Encrypted: i=1; AFNElJ/R7RIIMinvIWd6SqojBqr2y5jznCbgLf/G+38WnymImXc72EvCNxIsQ2rLCvn4GM5U9LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzijn5IlYyJN2ks3sJjNb/BffaSYjkZzMeEF64yFpSwNKzpvOBJ
	jmIdoU9trINOXm0vQd87tfFPQJRs6Pjqnwwd9X+GxCQ7sCalyBABLke4C6aCv5u2hIyjdCNEvnK
	judLYR6Q6/bwHGBygGhc7SfmhCMxYEkEOH0+e1YaD9A==
X-Gm-Gg: Acq92OHeV4+urfMXm2LbZbQNzgm5SNgGqamrvq/REKqsgElejWoc37FbmKTglmfUXKv
	h3i42IT/FzoqSoudygY4kAFXA+fdJ1pZ3hBpE/jRh8XGAtVNgmWSuzaGYQi2KvBSVxbd4dIn/j6
	DaxVkJRvjkjCmj4byaJBh4VQeJ/EqmCVGJzdBYWgUd2dwArgafj8MckjeE0XcqWQArLbCn1uRS6
	lNqJWixa6z8cszCHMSHTJyH4P3vTrRVc+vCzK4/oJ0Seupx6on5eRZMjWdKlDvpg3nSh6n0W9+N
	wQe/xm7qHW2PWq7L5lwuAuPZoHO4QJ9UuiA=
X-Received: by 2002:a17:907:1c1d:b0:beb:d67:81e9 with SMTP id
 a640c23a62f3a-bff4a8fc24bmr414328766b.19.1781515322968; Mon, 15 Jun 2026
 02:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612013355.59231-1-kernellwp@gmail.com> <20260612013355.59231-4-kernellwp@gmail.com>
In-Reply-To: <20260612013355.59231-4-kernellwp@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jun 2026 11:21:50 +0200
X-Gm-Features: AVVi8CfuriF_1rWYFiuhmjXkPtFOsv0HrLXM0AdFUAUVK-zItRS8CSSofRgTqGg
Message-ID: <CAKfTPtCXSD04p3EYuGMFdPB+JKuLGsVkbS6j3NGp0tULzc7qpg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] sched/fair: Credit queued next-buddy via
 canonical requeue
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
> eevdf_credit_entity_vlag() handles cfs_rq->curr, which is off-tree. Extend
> it to a queued entity, which is the common case when yield_to() targets a
> task that is runnable but not currently executing.
>
> A queued entity's key contributes to cfs_rq->sum_w_vruntime, so its
> vruntime cannot be shifted in place. Use the canonical place_entity()-
> paired requeue pattern: snapshot vlag, make the deadline relative to
> se->vruntime, dequeue the entity, apply the credit via place_entity(), and
> enqueue it again. This keeps sum_w_vruntime consistent with entity_key(),
> preserves the slice, and shifts the deadline by the same amount as the
> off-tree current-entity path.
>
> The helper is not called in this change; there is no functional change.

Merge this patch with the 2 previous ones. I don't see the benefit of
split it in 3 different patches

>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  kernel/sched/fair.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c6502db62cd3..c28682fedb36 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9372,7 +9372,9 @@ eevdf_persistent_margin(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   * to a bounded positive-vlag margin so pick_eevdf()'s PICK_BUDDY branch
>   * keeps returning it across several picks, without exceeding entity_lag()'s
>   * legal bound. cfs_rq->curr is shifted in place (off-tree, carrying any
> - * vprot window). Queued entities are left unchanged.
> + * vprot window); a queued entity uses the canonical
> + * place_entity()-paired requeue, keeping sum_w_vruntime consistent with
> + * entity_key().
>   *
>   * Idempotent once @se holds the margin. Caller must hold
>   * rq_of(cfs_rq)->lock with rq_clock up to date.
> @@ -9422,7 +9424,22 @@ eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 return;
>         }
>
> -       /* Queued entities are left unchanged by this helper path. */
> +       /*
> +        * Canonical place_entity()-paired requeue: see dequeue_entity() and
> +        * requeue_delayed_entity(). place_entity() restores the deadline via
> +        * "se->deadline += se->vruntime", so make the deadline relative to
> +        * se->vruntime here (not avg_vruntime). This preserves the slice and
> +        * shifts the deadline by exactly -credit, mirroring the curr branch
> +        * and keeping deadline > vruntime.
> +        */
> +       se->vlag = vlag + (s64)credit;
> +       se->deadline -= se->vruntime;
> +       se->rel_deadline = 1;
> +       cfs_rq->nr_queued--;
> +       __dequeue_entity(cfs_rq, se);
> +       place_entity(cfs_rq, se, 0);
> +       __enqueue_entity(cfs_rq, se);
> +       cfs_rq->nr_queued++;
>  }
>
>  /*
> --
> 2.43.0
>
