Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66594224F3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541161; cv=pass; b=tGXKAeao+LRuErGr6+b5nsEAGXcveVWGRamgXoyoPgpuupyApTZ8mmug1v5hU/SMawA/6nCmXnMfF1vY6bn1zcnCbvF9HjweTCBwvm8EbBbTjCkgCyufIgoGrJF+nus14zO5nLPa7kRK2NSXuE3fKcuMdI7Jbb0/Bi2QQByAUac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541161; c=relaxed/simple;
	bh=sGBik25tZABFZzB0b20JfipIiwSEFvmmFUOTa7zaecA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHO7pGLvuObN6t/BhSpaqBpKg7q4cb2BeZ5wGHKmg26//pNah2Tw4AZlw99mR7Isg22fE50kkuiUyIaW+uR8sTb6FR3oIspHlwBTVe2SAUnxNK1asgeq/5I8vjfE/cE/Cd0QJ1iFsA4RUpsHRHgnWhqkqyiYj2wbqRImTjWOx4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com; spf=pass smtp.mailfrom=bitdeer.com; dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b=UkNuZch2; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b="UkNuZch2"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396775c26e0so1428551fa.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780541158; cv=none;
        d=google.com; s=arc-20240605;
        b=GF4R8f1yq/0WSneYMeDqEBPKaQKBxZ2a3UQt+rLsW98tUNqQtcqLGiRFDzc/q8k6nU
         zX90HXZlnvyLn8wzCmugvnyZkrKgsCkL5+YknEO3EAZ540hnqU7PNd0Tvgf7e76VlI4j
         BJcUaZRI+RljxNgKBW/jt95iffhxfx49IDcYTx9DV8M2HzUdt1TQ5IOTYozvZirfKMZA
         55ZZ4/nL2mjeYbWayTf8Ndk+FN6YDrUsC6WtHOjbYo8cQfyUml8pdw+24NpTeqAS3l+5
         Pecyq1w4IbpVxVbPlWs1X3hnldZzFYsjcpxg1Ztb7LQ8br2tejuntial4228mA+YR5El
         0kEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NFP2ipEuZjDlN4mA8+0J7o2ZgbAl9Y2Nwnp0st3IxfQ=;
        fh=2dgo0MhohAiwmTjhC+ZUtp+ugSftvJS+sTyjq4DNrYI=;
        b=AyNLFFPouXp/Rx2XP2atdQ0YJgT5OinnPrGmXrzIc6zVMSzQ/kzt00H85ZPDYkZ7dP
         lnCUy4mF5lCAxaeCOrbc6PT+XDp3b21L3x980ka1Ih+bjo3rDodHQVy4EfRXx1EH/eiQ
         ylMzM7LvJgiRJhmfscMk8ugzr9uaXVxb/wIBy81yH4n3eUY5UnHEKf4wEYkUA9dBjNIn
         D8t74/Hk6VNIa0AR/GEJy8fnj7XArzvzJMgQ71u62Mk5H7dlgZk0xZEQUQ1Tg6Fay44E
         jq+ffm2Jo3YvJkufIPpEabaEVlTCj/SMsbHo7R7bawDzS4mPgGFx6OmQGfBpSub8reHb
         4QDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitdeer.com; s=google; t=1780541158; x=1781145958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFP2ipEuZjDlN4mA8+0J7o2ZgbAl9Y2Nwnp0st3IxfQ=;
        b=UkNuZch2KDUq/QasufrQZ0vxz6IAjI+TcrAEQ1cJcgE5mZQxugdyp3ij6Ulex2QzZt
         Iz4TO+UPJPp+tXKMdDgxfswd7Wq/oilI8EKsF1y/BRehTGEzQ7OM46skgn0jlpu1oGv1
         eHMd8fm2yojZVtifZu85NcW/FlbaBn3dSGR7jiFdKPpIySHbTg4fNvjkK5TWY9Zv3J2I
         Q9Vdfr6dwxuZAkeMSxz/Vu4ekcO20De6/uL6OyKyid68uv/WBqevlvkCe2K2Zkk8P+AV
         JF+Su5K2PJCjJL7ohN9dDQtanWAGJ1ZWGQxsPFXhd3tHg9kQt4S5C+Z9TfaxzhkcJG1/
         i5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780541158; x=1781145958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFP2ipEuZjDlN4mA8+0J7o2ZgbAl9Y2Nwnp0st3IxfQ=;
        b=pnSVyd1VRECYRUDXjgEY5r3UAkQadwkK4ckP23ZPOAdeIxMtQZUG5yoR6oER1gY+2+
         AD4yD5zv/myHofJzmBGJJh+zzIE4w6oAf1CFBYNFXmtJvkJAR+Yae7NsnEg8z6xA1gd5
         q9w4RhrfqVGgNfeSkOpQqhQb4qgzh8W//+pzwO/QkVKFfNTHMWbou7TW230W2Brq/rmV
         4392VGtLphSfE3c8ieROgIe1Pb1nLtLFxju6WH3giJ8KEBcBas2fV1A1/eTBSA5cOsky
         GnOOZJLa7faK1KAgWSH4dXgI1Iy/y1L30YHlX+NKe894QZpT6QhiUevmkbAmsSMC/j0A
         75Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+9aLs6wfRZMguwH+rM3Rn/i/Wafym9+EeJgGsryTzwuYiRH/Q7E3B45XfM2nXOxyooeLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qfIv3i57i5rJQQCvOnHBjeVDl/pun+ZZEvpitg+nPtMrsxL/
	bbfINRUNf1Xm2m4OFv4XosMllsqqcy21TlJJ3S9p/BKE1leoh0lVKTeb7Olimy9zNYE/jAGS1k7
	1IPNZ7Oly/OEbi2Zdt0gp1GmRAkBTVDgn/UjPGOup7Q==
X-Gm-Gg: Acq92OGAOl0Tw8SohwRE+onDfcJAwM8mN3M1lm6ImR3C/9+4jnLC3C096LRgfxpb293
	CEx+PgULKFtn8JqVDZ0b14N5juxb2vSqkYwsLNaGw/rdJYspdODQ5xzOezSrwfE2F7ibzBzzDRh
	f1XOsYqkL3qpRU/cxgk1zzwUp5vHqPT0tobUYUga7rcqVku7OEN+EwrgnNviLkC8v74l1QRx0Xs
	wZPCW/0+0kY/fBVJ9MjOMKDSWZ3aU7BZJzFp4lpc0pNgWy10laOEFpL91TDkvJiJdnWJp/Ao7y9
	7Oc3BGP68/7w5m9bsNcE
X-Received: by 2002:a2e:a808:0:b0:38e:98b0:3a7e with SMTP id
 38308e7fff4ca-396af4f3da9mr18741191fa.22.1780541157516; Wed, 03 Jun 2026
 19:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603031612.6173-1-guobin@linux.alibaba.com>
In-Reply-To: <20260603031612.6173-1-guobin@linux.alibaba.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 4 Jun 2026 10:45:45 +0800
X-Gm-Features: AVHnY4JwVXICSZ6pt0VBz2DLHWhyseFm8WoQ7GGgB1lZnPOIzqpHgYmM20IYoTE
Message-ID: <CAFWXh4wQZ6T77dNC8Dwy1fn57+GwGwjxs5f_2ghASe3xecNjJg@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm: event-driven wakeup for dirty ring reaper thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The patch looks good to me overall, but I encountered a compilation error
(see details below). I suspect it might have been tested on a vendor-specif=
ic
version; could you please re-verify it against the latest mainline version?
I=E2=80=99ll be happy to merge it once the build issue is resolved.

On Wed, Jun 3, 2026 at 11:16=E2=80=AFAM Bin Guo <guobin@linux.alibaba.com> =
wrote:
>
> The dirty ring reaper thread polls with a fixed sleep(1), which the
> code itself flags with a TODO for a smarter timeout.  Events that
> would benefit from a prompt reap must wait up to one full sleep tick
> before the reaper notices them.
>
> Replace the polling loop with an EventNotifier-based wait via
> qemu_poll_ns(), kicked by paths that have first-hand evidence that
> a reap is desirable.  A 1s fallback timeout is retained as a
> defensive backstop.
>
> Two kick sites are wired up:
>
>   * dirtylimit_change(false) -- when dirty-limit is cancelled, kick
>     the reaper so it resumes real reaping immediately instead of
>     waiting for the next sleep tick.
>
>     Measured with strace on the reaper TID (20 set/cancel cycles
>     against a stress-ng dirty-page workload), latency from the
>     cancel-vcpu-dirty-limit QMP ack to the reaper actually waking:
>
>         before: median 530ms, max 937ms
>         after:  median <1ms,  max <1ms
>
>   * kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler -- the handler
>     already reaps the exiting vCPU synchronously; the kick hints the
>     reaper to also check other vCPUs whose rings are likely filling
>     concurrently.
>
> kvm_dirty_ring_reaper_kick() is exposed as a public API; multiple
> kicks collapse into a single wake via the eventfd counter.
> kvm_dirty_ring_reaper_init() now returns int again (it was made void
> in commit 43a5e377f4) to propagate event_notifier_init() failure.
> A stub is added for non-KVM builds.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  accel/kvm/kvm-all.c      | 62 +++++++++++++++++++++++++++++++++++++---
>  accel/stubs/kvm-stub.c   |  4 +++
>  include/system/kvm.h     |  9 ++++++
>  include/system/kvm_int.h |  3 ++
>  system/dirtylimit.c      |  6 ++++
>  5 files changed, 80 insertions(+), 4 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 96f90ebb24..f964102f09 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1754,6 +1754,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      } while (size);
>  }
>
> +/* Fallback liveness timeout for the dirty ring reaper, in nanoseconds. =
*/
> +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
> +
>  static void *kvm_dirty_ring_reaper_thread(void *data)
>  {
>      KVMState *s =3D data;
> @@ -1764,12 +1767,30 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
ata)
>      trace_kvm_dirty_ring_reaper("init");
>
>      while (true) {
> +        GPollFD pfd =3D {
> +            .fd =3D event_notifier_get_fd(&r->reaper_notifier),
> +            .events =3D G_IO_IN,
> +        };
> +
>          r->reaper_state =3D KVM_DIRTY_RING_REAPER_WAIT;
>          trace_kvm_dirty_ring_reaper("wait");
> +
>          /*
> -         * TODO: provide a smarter timeout rather than a constant?
> +         * Event-driven wait: sleep until something kicks the reaper
> +         * (vCPU ring-full exit, dirtylimit disabled, ...) or until the
> +         * fallback timeout fires.  The fallback preserves the original
> +         * sleep(1) worst-case behaviour as a liveness backstop in case
> +         * a kick site is ever missed.
>           */
> -        sleep(1);
> +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> +
> +        /*
> +         * Drain the notifier whether or not the wakeup came from it --
> +         * any pending kick is satisfied by the reap we are about to
> +         * perform, so we must not leave a stale event behind that would
> +         * cause the next iteration to spin without sleeping.
> +         */
> +        event_notifier_test_and_clear(&r->reaper_notifier);
>
>          /* keep sleeping so that dirtylimit not be interfered by reaper =
*/
>          if (dirtylimit_in_service()) {
> @@ -1789,13 +1810,39 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
ata)
>      g_assert_not_reached();
>  }
>
> -static void kvm_dirty_ring_reaper_init(KVMState *s)
> +static int kvm_dirty_ring_reaper_init(KVMState *s, Error **errp)
>  {
>      struct KVMDirtyRingReaper *r =3D &s->reaper;
> +    int ret;
> +
> +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to initialize dirty ring reaper notifie=
r");
> +        return ret;
> +    }
>
>      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
>                         kvm_dirty_ring_reaper_thread,
>                         s, QEMU_THREAD_JOINABLE);
> +    return 0;
> +}
> +
> +/*
> + * Wake the dirty ring reaper thread so it performs a reap as soon as
> + * possible.  Safe to call from any thread; safe to call even when the
> + * dirty ring is not enabled (no-op in that case).  Coalescing is
> + * provided by the eventfd counter -- multiple kicks before the reaper
> + * runs collapse into a single wakeup.
> + */
> +void kvm_dirty_ring_reaper_kick(void)
> +{
> +    KVMState *s =3D kvm_state;
> +
> +    if (!s || !s->kvm_dirty_ring_size) {
> +        return;
> +    }
> +    event_notifier_set(&s->reaper.reaper_notifier);
>  }
>
>  static int kvm_dirty_ring_init(KVMState *s)
> @@ -3097,7 +3144,9 @@ static int kvm_init(AccelState *as, MachineState *m=
s)
>      }
>
>      if (s->kvm_dirty_ring_size) {
> -        kvm_dirty_ring_reaper_init(s);

Compilation error: 'errp' is undefined in this context.

> +        if (kvm_dirty_ring_reaper_init(s, errp) < 0) {
> +            goto err;
> +        }
>      }
>
>      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
> @@ -3571,6 +3620,11 @@ int kvm_cpu_exec(CPUState *cpu)
>                  kvm_dirty_ring_reap(kvm_state, NULL);
>              }
>              bql_unlock();
> +            /*
> +             * Ring-full pressure is the strongest signal that backgroun=
d
> +             * reaping should stay hot; wake the reaper unconditionally.
> +             */
> +            kvm_dirty_ring_reaper_kick();
>              dirtylimit_vcpu_execute(cpu);
>              ret =3D 0;
>              break;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index c4617caac6..b878598552 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
>      return 0;
>  }
>
> +void kvm_dirty_ring_reaper_kick(void)
> +{
> +}
> +
>  bool kvm_hwpoisoned_mem(void)
>  {
>      return false;
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fa33eddda..c42c8e0b74 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -553,6 +553,15 @@ bool kvm_dirty_ring_enabled(void);
>
>  uint32_t kvm_dirty_ring_size(void);
>
> +/**
> + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
> + *
> + * Hint that an immediate reap is desirable (e.g. ring-full pressure
> + * detected, dirtylimit disabled).  Coalesced via eventfd.  No-op when
> + * the dirty ring feature is not in use.
> + */
> +void kvm_dirty_ring_reaper_kick(void);
> +
>  void kvm_mark_guest_state_protected(void);
>
>  /**
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938..08e28d075a 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -12,6 +12,7 @@
>  #include "system/memory.h"
>  #include "qapi/qapi-types-common.h"
>  #include "qemu/accel.h"
> +#include "qemu/event_notifier.h"
>  #include "qemu/queue.h"
>  #include "system/kvm.h"
>  #include "accel/accel-ops.h"
> @@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
>      QemuThread reaper_thr;
>      volatile uint64_t reaper_iteration; /* iteration number of reaper th=
r */
>      volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr stat=
e */
> +    /* Wakeup channel: kicked by ring-full vCPU exits, dirtylimit toggle=
, ... */
> +    EventNotifier reaper_notifier;
>  };
>  struct KVMState
>  {
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index c934ceb0de..3ee9c58479 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -393,6 +393,12 @@ void dirtylimit_change(bool start)
>          qatomic_set(&dirtylimit_quit, 0);
>      } else {
>          qatomic_set(&dirtylimit_quit, 1);
> +        /*
> +         * The reaper has been short-circuiting via the
> +         * dirtylimit_in_service() branch.  Kick it so it picks up the
> +         * policy change immediately instead of after the next 1s tick.
> +         */
> +        kvm_dirty_ring_reaper_kick();
>      }
>  }
>
> --
> 2.50.1 (Apple Git-155)
>
