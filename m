Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C31A9F91
	for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776567851; cv=pass; b=QVEa8gGA/EJqKXLYL/KnYg/N7tb9Zy6xyzDd7UHnRME03j1HoPj3taQFyDHBIglnVFZQbuyZWmrcoz0fnTnA5M6KvHOwUCYhYTqn6ItPDXVs1SRIfN0V41ZI50qcYsAVCq1swbO/XCeetQpuh7ubdU+D0powmYvr81YIeTW20xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776567851; c=relaxed/simple;
	bh=HdyDQIyySEOh/2WiaeRs+yJfnYtItu3E8aov4DFDYq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpgS3iG9lRYIXFX3gY9Teos24IfzeAg30J85TT2l3LFVLhIWX0JlxySMRtoA6lC8dtOqqDzm2lN7oRJo113d1mpchujzsVUhmzfb+R9j/jAPX3oC51Z9XAB3AE2TqMcUdrszk+ZX2ptPNIvW+aFEPQe95+FQ1JFD0aWENINUdzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=DEriOsfF; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="DEriOsfF"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-797ab169454so26244697b3.3
        for <kvm@vger.kernel.org>; Sat, 18 Apr 2026 20:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776567849; cv=none;
        d=google.com; s=arc-20240605;
        b=iLfqPjeKgkWiCAWzWLacbAQhFtJzd5M56dFweL6CU0jRhIrcWXLA9tBq3hp1Qaa9dX
         ls9nPEo7yGdNXQqdaJwyOgAwzvtyuS/PBVzEvr4T0tdc4n+FEBAoi9zpYUSe8Rd8WleJ
         wug2I2Ydka3A2oHWRapN8yMOyetZ1rebTmOYcf0djvXf5BHKEph0ntVgFhLuPcQcMmzt
         QfDjvc8Vz0tVpCFdG7kMtRusIFY3z227atMxihZRWJkFJPn771KQ3Ccj+ETdY0zUnWAD
         olYa+EJ8RhykGlMI5/BpZ22tsmbsenHom102HGsab9olvmbCvjZZF3TO5doZIyzIZudK
         cxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65bhYXcjqQ9H/pug+cUDONxhs48He9JsEHWA0SafePc=;
        fh=91pHv+Y4sIZYJMAzUCSlcfwWKQ8Kzw+dWEiDndEbjKE=;
        b=Klqr8lQwNT/7I8DJsK2KNvJCHNW9785+/VdIjXplJd8g8UpNv26BzrgeGEYmuhhGRL
         +x4F90e4M1Gn+NDbN1egcie5HE3lqJNoSWyw3Z+KnaAJjgRm5Yjuv4ESwDz7CiHxqK42
         fBti/RpQFjD0mQuOuKnByA8EKqXcF3L3DaQSQ1ClzE7pgIaLuqMXQyKxqHaZYZ4KtQn9
         0eBIeRlmK56gRkiwKra5JMFwqhKIoPeIIy++6ATx978pvBeCcQzFksHq1zthhAj2lc3p
         zlGjPWC9E+TzsKwrZF05xOcG9YWnynq3TmdjYYTDY0GHOMugPnVm6TcftGY8PCViyxPv
         J1eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776567849; x=1777172649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65bhYXcjqQ9H/pug+cUDONxhs48He9JsEHWA0SafePc=;
        b=DEriOsfFnsrNoq1NHzOnz4WuM4zUt3leVENnr7g23Nja/Jdxa/14l4o34TjAZ4cxCL
         KdZ4v2GVcGpHzrJ+C7MNfeQxHdXt5RYcZYL8KQwZQnEUQZpyeTHnBmxqFvYZLOjRO3Au
         75z47mF03hGXTQ85c+YY0rb8SQs6gcx5M72qrQ3LnJJrN0AqRBObtcqGG9+TBjl1bkbg
         I3yoJEsJyBp8j4uxACp8KrxbCWnpi6KBKoym/sqsRlYvPxNqdwkzVRJtdG5vGurFaovT
         7406oLUrPpRdZySaA3OJNEJz2bY9MySxMy5+tr2rmKf/g3kbSOSStK1ElT1vR4gq0L3A
         D4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776567849; x=1777172649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65bhYXcjqQ9H/pug+cUDONxhs48He9JsEHWA0SafePc=;
        b=k03rclKN3Jqquvq4aQFQoHoxIRCmy8EiAoPUTNk90yxTumPpo4Agr+9d+1hkZL+taJ
         1VVzDhIqdEmCHCTfcD1VWv+5NJH0c9tP0Ie1Ctz1ZU4QrBgbhTtOpZV0aKDxzK27kWt/
         zqVrgTX5HTYWcWqfirIqBIla0s/dVWjKgMISM+ShGjuu1odo0REUFiIdIhl4MYZOLSYZ
         FbgHuhNdcAXMjC+g9lApyo3FgnEXHWJj8t7Feh+r8VYTyJ+rWZcLIMMy/kbOUCHYqBiq
         povpdoyuWpGbC0W4Kae0dnUM0eVS4L9ntM7jZofwlgxbihFpJCAuYNpTta+VCUr40Wjo
         qqpg==
X-Forwarded-Encrypted: i=1; AFNElJ+PYzz2vx7o+1FeE+XNtbmJ0sqyxGlOok1rkUaUwK/wlhzWbM+TGjpRA7e46xJenYP6fxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+9ECoPybG8AgAeGU6pDBcftE7NnWRGj24Hm1dPGsxs1OeHJ3
	sVlm8RO53XtDrj/zRc3ECA45cGnM1WynMdLhFRH/Jg92p2igACL8IJYFdbLjpxr+d+Bvu7CDXM2
	dNanVEdXhfSAN3of9zHV04g+FaQ5RbR6BohCGIpT2lg==
X-Gm-Gg: AeBDieug7JipWo0waZ8kp+Nx6JrVQs7/KQQMsY7ZfkI8xwlTQJDA1ToEsX1BQXUKQVV
	h0dqh+1evvM+EeJp6vyKTqsWG4i/yBXBuBX05Q4DZKADyxlkQoQ094NkAEh9Vjq43pNwFXkn/Vn
	MkfNBoewX1zkPvHJlrnx4Le004pyoIsIGwTaguYCMJaIkFtwUHoVu4c1o8VXVM40sTpDrhygUo3
	AzWpgXbmtzF2CyDiqGY4dud6ojeJ46ruNmo9DFVrC0z92S473Zdv9h+UpKJUgeMnfAbHlMmNm9B
	c5BSAxTXnin0O3sWFQ==
X-Received: by 2002:a05:690e:168b:b0:651:c37d:dba4 with SMTP id
 956f58d0204a3-6531089ae35mr8521399d50.29.1776567848680; Sat, 18 Apr 2026
 20:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87add1dc9bb95dc50bc20ce5c8fbfe2999185dd3@linux.dev> <20260417011825.158781-1-vineeth@bitbyteword.org>
In-Reply-To: <20260417011825.158781-1-vineeth@bitbyteword.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Sat, 18 Apr 2026 23:03:57 -0400
X-Gm-Features: AQROBzB3smcCRDCw0McQ0gCNdGE5f1u9PhI-HntF_e8pXJidC-JSjZYL8HsOETM
Message-ID: <CAO7JXPjEtnsk9xer+_uSPQi9DBqCe0cSnfB=ePaKntoKv=N3tQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
To: kunwu.chan@linux.dev, paulmck@kernel.org, Tejun Heo <tj@kernel.org>
Cc: dmaluka@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, rcu@vger.kernel.org, seanjc@google.com, 
	sonam.sanju@intel.com, sonam.sanju@intel.corp-partner.google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 9:18=E2=80=AFPM Vineeth Pillai <vineeth@bitbyteword=
.org> wrote:
>
> Consolidating replies into one thread.
>
> Hi Kunwu,
>
> > One thing that is still unclear is dispatch behavior:
> > `process_srcu` stays pending for a long time, while the same pwq dump s=
hows idle workers.
> >
> > So the key question is: what prevents pending work from being dispatche=
d on that pwq?
> > Is it due to:
> >   1) pwq stalled/hung state,
> >   2) worker availability/affinity constraints,
> >   3) or another dispatch-side condition?
> >
> > Also, for scope:
> > - your crash instances consistently show the shutdown path
> >   (irqfd_resampler_shutdown + synchronize_srcu),
> > - while assign-path evidence, per current thread data, appears to come
> >   from a separate stress case.
>
> > A time-aligned dump with pwq state, pending/in-flight lists, and worker=
 states
> > should help clarify this.
>
> I have a dmesg log showing this issue. This is from an automated stress
> reboot test. The log is very similar to what Sonam shared.
>
> <0>[  434.338427] BUG: workqueue lockup - pool cpus=3D5 node=3D0 flags=3D=
0x0 nice=3D0 stuck for 293s!
> <6>[  434.339037] Showing busy workqueues and worker pools:
> <6>[  434.339387] workqueue events: flags=3D0x100
>  ...
> <6>[  434.350853]   pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=
=3D3 refcnt=3D4
> <6>[  434.350857]     pending: 3*process_srcu
> ...
> <6>[  434.356980] workqueue kvm-irqfd-cleanup: flags=3D0x0
> <6>[  434.357582]   pwq 22: cpus=3D5 node=3D0 flags=3D0x0 nice=3D0 active=
=3D3 refcnt=3D4
> <6>[  434.357586]     in-flight: 51:irqfd_shutdown ,3453:irqfd_shutdown ,=
3449:irqfd_shutdown
>
> The relevant pwq is pwq 22. All three irqfd_shutdown workers are in-fligh=
t
> but in D state. rcu_gp's process_srcu items are stuck pending.
>
> Worker 51 (kworker/5:0) =E2=80=94 blocked acquiring resampler_lock:
> <6>[  440.576612] task:kworker/5:0     state:D stack:0     pid:51    tgid=
:51    ppid:2      task_flags:0x4208060 flags:0x00080000
> <6>[  440.577379] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
> <6>[  440.578085]  <TASK>
> <6>[  440.578337]  preempt_schedule_irq+0x4a/0x90
> <6>[  440.583712]  __mutex_lock+0x413/0xe40
> <6>[  440.583969]  irqfd_resampler_shutdown+0x23/0x150
> <6>[  440.584288]  irqfd_shutdown+0x66/0xc0
> <6>[  440.584546]  process_scheduled_works+0x219/0x450
> <6>[  440.584864]  worker_thread+0x2a7/0x3b0
> <6>[  440.585421]  kthread+0x230/0x270
>
> Worker 3449 (kworker/5:4) =E2=80=94 same, blocked acquiring resampler_loc=
k:
> <6>[  440.671294] task:kworker/5:4     state:D stack:0     pid:3449  tgid=
:3449  ppid:2      task_flags:0x4208060 flags:0x00080000
> <6>[  440.672088] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
> <6>[  440.672662]  <TASK>
> <6>[  440.673069]  schedule+0x5e/0xe0
> <6>[  440.673708]  __mutex_lock+0x413/0xe40
> <6>[  440.674059]  irqfd_resampler_shutdown+0x23/0x150
> <6>[  440.674381]  irqfd_shutdown+0x66/0xc0
> <6>[  440.674638]  process_scheduled_works+0x219/0x450
> <6>[  440.674956]  worker_thread+0x2a7/0x3b0
> <6>[  440.675308]  kthread+0x230/0x270
>
> Worker 3453 (kworker/5:8) =E2=80=94 holds resampler_lock, blocked waiting=
 for SRCU GP:
> <6>[  440.677368] task:kworker/5:8     state:D stack:0     pid:3453  tgid=
:3453  ppid:2      task_flags:0x4208060 flags:0x00080000
> <6>[  440.678185] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
> <6>[  440.678720]  <TASK>
> <6>[  440.679127]  schedule+0x5e/0xe0
> <6>[  440.679354]  schedule_timeout+0x2e/0x130
> <6>[  440.680084]  wait_for_common+0xf7/0x1f0
> <6>[  440.680355]  synchronize_srcu_expedited+0x109/0x140
> <6>[  440.681164]  irqfd_resampler_shutdown+0xf0/0x150
> <6>[  440.681481]  irqfd_shutdown+0x66/0xc0
> <6>[  440.681738]  process_scheduled_works+0x219/0x450
> <6>[  440.682055]  worker_thread+0x2a7/0x3b0
> <6>[  440.682403]  kthread+0x230/0x270
>
> The sequence is: worker 3453 acquires resampler_lock, and calls
> synchronize_srcu_expedited() while holding the lock. This queues
> process_srcu on rcu_gp, then blocks waiting for the GP to complete.
> Workers 51 and 3449 are blocked trying to acquire the same resampler_lock=
.
>
> Regarding your dispatch question: all three workers are in D state, so
> they have all called schedule() and wq_worker_sleeping() should have
> decremented pool->nr_running to zero. With nr_running =3D=3D 0 and
> process_srcu in the worklist, needs_more_worker() should be true and an
> idle worker should be woken via kick_pool() when process_srcu is enqueued=
.
> Why none of the 8 idle workers end up dispatching process_srcu is not
> entirely clear to me.
>
> Moving the synchronize_srcu_expedited() does solve this issue, but it
> is not exactly sure why the deadlock between irqfd-shutdown workers is
> causing the work queue to stall.
>

I think I know what is happening now. After adding some more debug
prints, I see that worker->sleeping is 0 for one of the workers
waiting for the mutex(pid 51) in the example above, and
pool->nr_running is 1. This prevents the pool from dispatching idle
workers.

This time I got a more descriptive stack trace as well:

<6>[18433.604285][T10987] Workqueue: kvm-irqfd-cleanup irqfd_shutdown
<6>[18433.611204][T10987] Call Trace:
<6>[18433.615001][T10987]  <TASK>
<6>[18433.618414][T10987]  __schedule+0x8cf/0xdb0
<6>[18433.623372][T10987]  preempt_schedule_irq+0x4a/0x90
<6>[18433.629112][T10987]  asm_sysvec_reschedule_ipi+0x1a/0x20
<6>[18433.635340][T10987] RIP: 0010:kthread_data+0x15/0x30
<6>[18433.715343][T10987]  wq_worker_sleeping+0xc/0x90
<6>[18433.720806][T10987]  schedule+0x30/0xe0
<6>[18433.725379][T10987]  schedule_preempt_disabled+0x10/0x20
<6>[18433.731604][T10987]  __mutex_lock+0x413/0xe40
<6>[18433.736763][T10987]  irqfd_resampler_shutdown+0x23/0x150
<6>[18433.742989][T10987]  irqfd_shutdown+0x66/0xc0
<6>[18433.748145][T10987]  process_scheduled_works+0x219/0x450
<6>[18433.754370][T10987]  worker_thread+0x30b/0x450
<6>[18433.765460][T10987]  kthread+0x227/0x2a0
<6>[18433.775383][T10987]  ret_from_fork+0xfe/0x1b0

If I am reading the stack correctly, an IPI was serviced while at
wq_worker_sleeping() (which is responsible for setting
worker->sleeping to zero and decrementing nr_running). I guess the
process was interrupted before it could update nr_running and
sleeping. After IPI was serviced, preempt_schedule_irq() was called
and then __schedule() which schedules out the task before it could
decrement nr_running. And it is never woken up because the mutex
holder is waiting for the GP to complete. But process_srcu cannot
proceed because the workqueue pool is not kicking idle workers as
nr_running is 1. Effectively deadlocking.

So, basically what happens is (based on above example):
- srcu gp worker and irqfd workers(3453, 51) on the same per-cpu Pool
- worker 3453 acquires resampler_lock, and calls
synchronize_srcu_expedited() while holding the lock.
- worker 51 waits on the lock, but is unable to update critical
workqueue counters(nr_running and sleeping) before it schedules out.
- Workqueue pool is stalled and thereby preventing srcu GP progress.

This also explains why the issue is not seen when the
synchronize_srcu_expedited is called outside the lock.

Going directly to __schedule() after servicing IPI is the main problem
as  wq_worker_sleeping() could not complete. Without the IPI in
picture, schedule out would be:
_mutex_lock
 schedule()
    sched_submit_work()
        wq_worker_sleeping()
    __schedule_loop()
        __schedule()

WIth IPI in picture, it would be:
_mutex_lock
 schedule()
    sched_submit_work()
        wq_worker_sleeping() <-- half way through
              IPI
           preempt_schedule_irq()
              __schedule()

Moving `sched_submit_work()` to __schedule might solve this issue, but
I'm not sure if it would cause other issues. Adding Tejun for an
expert opinion on the workqueue side :-)

Thanks,
Vineeth
