Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724E18BBAE
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950718; cv=pass; b=uAISej/20dOOPnK02BQLkzeyJDhEyCJXBbmuy1cRy8S9aus6l/8n9LFm4OKHGBfkEBFAZiJFluaHpncRNdNRUJR+Hl7mn+EoETLKe4iE5c79m8GbT0DXiMIKqkW4mbXgibJ+KtBpW+SbibEHV9QpghoqIl8kKfTWDXptiEJzpVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950718; c=relaxed/simple;
	bh=9b8754IDEm0TQDjQSnxDEexYNuYd2dC6tmyRCw03JwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx2wMedGQxDEqSABrh1vefzdfhqdTAiwZo5KmtdL9plOHhrMFCw9HusIHBtOUpJKnfhalo1MBKdD5Z7DRDDsPdpHhCmMWC4igTiHG8gSTfEaPXxGnb96NP3gPwEfci1X8upYSQM1tETnrbJ4GcYK6Fkxtb1/z7xLGMENqPr09ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GYkEUMFj; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GYkEUMFj"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6540fe6a8e1so5647915d50.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 06:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776950715; cv=none;
        d=google.com; s=arc-20240605;
        b=SFr+7R4AHeA+Tg8uX2MZXMBllMBx1GI6SFvB3gohB1HhHa/m83hBeGz6zf0nfLph7S
         qenMZjxTLmwPYTfKNh8mE2OivkrpBh1Vil4Kn7CIx6UvUsRDuhXWZ3AgIywi8de5jReF
         0lEj/JrVNk06IJ1H89KNRmAF8k9PvLnHlBVQUpEIaYlk6rXTcFTJIuxbOkY3uPdwl8Vy
         ACQ0oKSTTM42DwWbtFg7LpO94et9gRde9uYzj02NYXP+70xJoOpKMCtezVYlqxxpYN9q
         j38NXgTlmG4+5KnNDtuJ3xYTh0VJvF6d0bQ9FkU8P7LUU2ks9J/gSDsP+AUBuwgJVvxf
         7Piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        fh=l76zsPiIrfXBbJSMswgDOVV+Sg0DhmUoVlQk59+vvNc=;
        b=eXkTRxgaegyqo4+7YRfJhkZRd+3MlToue4jpRSzXP4C+pQbSpgGeZ4aR9WQtUr8gMm
         AC30JcuAcq4dmua3q6b7OEYoVqIoy4+VK4QexzoyD4AYpufDYr56YKdgQzQwdM0AnVGp
         gbXNQWXWJmszMsHFwgCr1px/o3NTKbZPBsqy5uaccBWFUNWOcS6SXiTHY6XeKMG5R1LH
         HsCd0nMZp7iHtFctFRReNOf/y3ehWvL6dy9N/dcJaRRLLskozc+ngu03rU1f09LbxARy
         lytUUBtgsbubs7w8t48trv+3JlQK0BH1p4Ipl2PUFrps6HUOQnqfmbZY47WVufxWfrWS
         N3mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776950715; x=1777555515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        b=GYkEUMFjmceiNCtpVlZJN/CS/8bgBuEXGSA70ElbG0qbEzUFDWFrHaYJaoBY7t0OjU
         ATEj8yutKcRnCCKXAVFWh4G1BQtH6jTviOaUue9dC7vOtmkAM28+qSrS5Wix6cRk76kE
         +e0hJ4xxpfIllirCrxMm2ShkgcRakNWK/kKAfZKgne+3vZ1P9Qk3hEtvfiC+QLSdpoRa
         ktzq0v8+sQ0LLT9A5BpgqI6qS3xyKxfCAjktMFtxA3UV1UOCmvEkyXIID9JJGN89XbMY
         Xb54Vt8ZFs8dke3Gr/oAiZTEgO9JpXrMtN/3c+Hg5h0mwQX+owCPXn/2yUFJwYOSOZmt
         Wisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776950715; x=1777555515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhNHO9jAUIx/0udLGeS5tagccSSFrBTO/SZbGN9q6H8=;
        b=Jz0+g71RiqaFmXu3sfQO2fMZgM0GUeHT1WK/jJR79UHafNvQnRjE9C/5ZG3YJOz9P5
         puVc6258jWRrqG+Gcmt6Lrm4hZ0MvfWV7Tp/ZgeyzWiILEiFmg+PqN1i38gpAS3SCyc/
         nU0OEdAQwFKNs4LlkolVqlg+0XOl1YUhbMMZ+Z0Jr5ZYd2s3u+1VvMn5mGt11vHJ/le/
         xnadqe8JlFZtIE1JvNs95zm2uM0ugbqZFkvXik6Is9emtFguVqXkNRF6vg8m83hyD8fm
         14FncD98UoRRXtcWK/kV8olUQ/ffzYIeJfuoeBQPyevC/g0VKdPNN49qw5RMiZ+W/uuv
         d4QA==
X-Forwarded-Encrypted: i=1; AFNElJ/bDksaMdRoGJeTrS5Ei0vEQjACSHV0V1+vx+squWrkQlKdiZVWBkeqlsK8sbbn09zT4aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiDyK+9UPzaagqGi/cjdonadB4tdULc3Skq5vjz1jnOTlvMBs
	NGwFr3BlEPwZVpXf/9D4LNWwNDSD6z37n+xQbr/LGp67WpO9Iz7uJLddwrFu1SJ7iuVKZwCxBZI
	BMz7kEEKOSQhbn5lx8UUhBhDE1ES+ns5Zc3aAqQApjg==
X-Gm-Gg: AeBDiet2bq84SOIdfJnF9ocJaGkwJXETh2E0oRs8iLvdhZfnDFK9ND1rWYSJftP6iVs
	Xzh5DEn6HRrrv5nIeUZh0IOr9ijVO94JwkBn5KKMlwjoZmAdQx3yDnfR3rA6bKW761fgqZqZr13
	qADhiVFwS0u6uICklAnDLTV9rp6ZiONYJDJLIprpt+nUd4iBS8F/Wb/wqOeyUzYhcVBfXtGlZ5p
	zov07Pu73s0FPbEPaq+tobGJpNlDo33F0h3EbNCe9gEoIH6dRhFMk8Rvv0vFCEKy/5ZesEcOYLq
	JcDSBrrp1YYr5HkA3CnBeLRnREz2+HSiDO7miY+MA6W053Lt
X-Received: by 2002:a05:690e:1913:b0:64f:fa9a:9017 with SMTP id
 956f58d0204a3-653108846afmr26025810d50.28.1776950715337; Thu, 23 Apr 2026
 06:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aefAWGcAQHeRYbs8@slm.duckdns.org> <20260423090100.3231633-1-sonam.sanju@intel.com>
In-Reply-To: <20260423090100.3231633-1-sonam.sanju@intel.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 23 Apr 2026 09:25:04 -0400
X-Gm-Features: AQROBzDuqnoAWQ0x4UMQxhwITFSDzgrxL0fOr-O37WxBma-Xso9IsfXUvAQZ01s
Message-ID: <CAO7JXPgf-PQah9XCq-KD+FimQATkxy4HpvWy6r6LDT52Jv0sdA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
To: Sonam Sanju <sonam.sanju@intel.com>
Cc: tj@kernel.org, dmaluka@chromium.org, kunwu.chan@linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	pbonzini@redhat.com, rcu@vger.kernel.org, seanjc@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:05=E2=80=AFAM Sonam Sanju <sonam.sanju@intel.com>=
 wrote:
>
> Hello Tejun,
>
> Thank you for the detailed analysis.
>
> On Wed, Apr 23, 2026, Tejun Heo wrote:
> > The problem with this theory is that this kworker, while preempted, is =
still
> > runnable and should be dispatched to its CPU once it becomes available
> > again. Workqueue doesn't care whether the task gets preempted or when i=
t
> > gets the CPU back. It only cares about whether the task enters blocking
> > state (!runnable). A task which is preempted, even on the way to blocki=
ng,
> > still is runnable and should get put back on the CPU by the scheduler.
> >
> > If you can take a crashdump of the deadlocked state, can you see whethe=
r the
> > task is still on the scheduler's runqueue?
>
> I instrumented show_one_worker_pool() to dump scheduler state for each bu=
sy worker
> when the pool has been hung for >30 seconds.
>
> All workers show on_rq=3D0.
>
> =3D=3D Pool state =3D=3D
>
>   pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D47s
>   workers=3D13 nr_running=3D1 nr_idle=3D7
>
> =3D=3D Per-worker scheduler state (first dump at t=3D62.5s) =3D=3D
>
>   PID  | state | on_rq | se.on_rq | sched_delayed | sleeping | blocked_on
>   -----|-------|-------|----------|---------------|----------|-----------=
--------
>   4819 | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4823 | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4818 | 0x2   | 0     | 0        | 0             | 0        | ffff953608=
205210 type=3D1
>   11   | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   9    | 0x2   | 0     | 0        | 0             | 1        | ffff953608=
205210 type=3D1
>   4814 | 0x2   | 0     | 0        | 0             | 1        | (mutex hol=
der)
>
>
> All 6 workers are in kvm-irqfd-cleanup, calling irqfd_shutdown =E2=86=92
> irqfd_resampler_shutdown. They contend on the same resampler->lock
> mutex (ffff953608205210).
>

Sorry for the late disclosure; I was running the 6.18 Android kernel
and missed this relevant detail because the bug discussion initially
started with KVM and I had verified the irqfd related code was the
same as the vanilla kernel. Now, after going through Tejun's response
and reviewing the __schedule() code regarding SM_PREEMPT, I realized
the Android kernel has extra logic related to proxy execution that
might be triggering this issue. I tested on vanilla 6.18.23 kernel and
was not able to reproduce this.

Sonam, just checking if you are able to reproduce this issue with the
vanilla 6.18 kernel?

Thanks,
Vineeth
