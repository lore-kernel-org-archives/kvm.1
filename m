Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217D27816C
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744312; cv=pass; b=g0ye4mvyAk/kRh1e5KkmvecnG5VetR37UAbIyXoEbxxEWiuVZMbTsC54GS1we5hAvPabda2HKVYEacMR+TB+9fYSwfwnRgm7A44fWxkas8utxIWyptkhucMAMfeNBzfNuJku5wz0NkuaVF1l29tUn7q9qGspldXF/hp7jr43i3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744312; c=relaxed/simple;
	bh=mg+MMU0VUBtq8wA4Sp96p2hVBPG4jgPxs3iJEKzMMJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p62boH/zH3XHKV8jIECGc93iljk/Or/xP9QrdCnjtUFuDvkWe3gqZGqYBRmLUP8xlNGh797EFSTA8Ic6e8qbflmp2hRZc96RChLbaByJeJ2Mjs1JdSSn/RAzaKTNW7dar0d+13YnLTgOW4X1BsV1BF0g2E3mAk9Bt3/+XM7mV1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com; spf=pass smtp.mailfrom=bitdeer.com; dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b=Fc/qZBQC; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b="Fc/qZBQC"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad4c229861so297358e87.2
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 17:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781744308; cv=none;
        d=google.com; s=arc-20240605;
        b=YCLFUKBWJuJDUCatBmbizP8kQ2HyHgHoxNA7FEQXemEvPdarTYCwlVFRi9Tg6NJjoj
         lKwHdrz0XIvipF0u5Q3A2CAxyM0twpLIGXzvTISnMaf6NbGgs1FzBkSkNBP4iCK+NteX
         1Nrv2RsOnuiJn86Kq5dh1PNPIJgedKth9JayEoJgZjkFE/Zga4pNVXmea2GyJkIbbjaV
         aLYLGYsqAcorIrV/PCOggMiUvk/a7NNxnUf0vEmr8VXtu76qmXpn2L0CJRlmjRs0Nn/Q
         zMQ/Y0AV2V+UTM82w3XV0d0Kgk1fojgmz6+2hE/nko+mO1NBO1lmm/xtlbnbXRtxr8dh
         KwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Kca6haeo+bA5ndGmY6EX+BgtmeyApAqd1+b+zpsD3M=;
        fh=e/CgHhUMirskYO0NVNssmgWObMdGok7jlprb5jr1kAE=;
        b=N3TwnOD5gVKGdIYdV9J2UATdMhWCdEdhplRtoQPUhUEa7+Gt5CmPhAONLlXrVOMm6D
         i3/qz8wGadcnODo5dX4X8ReqQc2CqeFhKAD8RmsNCnMWvrH6bmMCoBYlHmHgIBhyKUWF
         sVZny9IQd91QSTPKse5Ic9AVUBncB4znIwkKEO84Z8mphe4y82DwtwpphRf7jTVwfot4
         PKu0xMkWOkEEL4xyKoTigjMAqJ27pyBiGU2O8j12IobXBAr8CuV7sJxd1MKKXkOW/FwV
         DUkurvQOaWWrUoWmj2xwJWOw86q31CT42rFsWxHZ++FL81/D9vgT4plZDlQODkwJNRkN
         CO9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitdeer.com; s=google; t=1781744308; x=1782349108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Kca6haeo+bA5ndGmY6EX+BgtmeyApAqd1+b+zpsD3M=;
        b=Fc/qZBQClVSxKvqvuaQQT2w4RVNf8KdbceutVIr3ae5eWdTAcarK2BJz+6+dZOE0Ao
         iU89mdSlFwri4cMXLkYZ0enSlCp7jA5rm9vRVIJXyh9qIfyDwhAlY8LnSSt1WdbYHVco
         bGA/qlkeFUu+zQbfuhWVaghtaqSYiRt9lnrbKxn4xzBD06omvaTmw1gwSRdO8HlEasyP
         MS0fTh8j1gyyqQ+1mCU1zACl+mEkS9FcJhBtAbgmcIGhdjO30p65ZEzX9mOeFdKFk1pU
         S1LwNwO+9yhGHjObLSybm9shiHV/yAgrIBheD30mD7Unjz1yscsWBqSx/9WyNLD9CyXL
         BItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781744308; x=1782349108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Kca6haeo+bA5ndGmY6EX+BgtmeyApAqd1+b+zpsD3M=;
        b=kOaDSp3yEeVhDK0eDvjX1a1ijGGtBY3fZ+j5lz7MaGXSNxQIlsXNbnwzsrdRkumRos
         LcKuNsxxfx72lfFt4Rjt7A83e0qBGr5A5aCRxAAPotSE2hfJur1ZJpyWiAcpNK8wJ6YK
         GaFLz4xBKDTd1gyrxYIFXRgC1zlGYTy3c6zVStX+gJe3jm9bc/idIAgzIoWdFHvDYxLq
         oJIhkvbxdN96O5MOlum3OFa2O9086MMAMQJ3lsPbB/0akuYmdUJlcqMumVV9q0hPYA5T
         Wrmud6AA2hzPxBMcCRxdydC4Qg5+NqvHM4GFnhTA44jaTqavssIHWVBFMeLLMaXgvS2t
         LJDA==
X-Forwarded-Encrypted: i=1; AFNElJ9nxmfYvoTBghTWfGguCqHQGmqkJ3lCqh1TwoDU1rDssK/xeGXi80RV4R2o6Gnv/YQ5kKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBU88Q211qvenDP1on/eVDuseTnoX1AXEsj1vcsom2uZbO7cn
	I+O9GRyGeOH1bb08PMtyUTujpMWZN/5eFh9D4nRal2gy2LSCSC2D8qg3EIkFzR+ljzVGVwRwTgQ
	u8wLoizs38KUu3eSbKP+J8t8tGtZacf3n+TPECigtkNEAw40pLtQeAjIxzA==
X-Gm-Gg: AfdE7cm5mvTbW/qOUKVzhhIDJo/Ynqe2h8Xx6ise1lZk3AFyx2r3niKYqn/scu6h6T0
	AXVMr52KZ6X1l3/K0PN+eiGLtA2BvaEWcY80TGJ0EK0IptoEeuEPZ0E9u9pze5wYOndfzeDMbTE
	j4r5KYM062/N6TUCf1Gek3HdocNwVUAgf6zfM/r97cCUR8WNW/NsGQfs34hVorqF2bnjtdQFjUc
	XkQGz9ZlO+2DYsLaTdxwcM/eqG07Q8R9w9NgzTDtHOk6gGajxjbsu2zKZntq1rJCqG/nUYk
X-Received: by 2002:a05:6512:4505:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5ad4dac9004mr356478e87.41.1781744308586; Wed, 17 Jun 2026
 17:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604070029.34982-1-guobin@linux.alibaba.com> <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com>
In-Reply-To: <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 18 Jun 2026 08:58:16 +0800
X-Gm-Features: AVVi8Cfm8jUtP1ZNvxp4Kd7bFS0JLkQTUW1aXsGc10fTA5ejVxAM2Xi7bj8wZ_w
Message-ID: <CAFWXh4x7sP-r6i9n-X7-gzkNNNqE5OegYkJZ=6TQvzhtgFLPdg@mail.gmail.com>
Subject: Re: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping=E3=80=82

Hi Paolo, could you please take a look at this patch, I=E2=80=99d appreciat=
e
your feedback on this patch.

On Fri, Jun 5, 2026 at 4:22=E2=80=AFPM Hy Man <infra.ai.cloud@bitdeer.com> =
wrote:
>
> Reviewed-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
>
> On Thu, Jun 4, 2026 at 3:00=E2=80=AFPM Bin Guo <guobin@linux.alibaba.com>=
 wrote:
> >
> > The reaper polls with sleep(1) (TODO in the code) and only notices
> > dirty-limit teardown at the next 1s tick.
> >
> > Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
> > from dirtylimit_state_finalize() after dirtylimit_state has been
> > cleared.  The kick must follow the NULL assignment: kicking earlier
> > wakes the reaper while dirtylimit_in_service() still returns true,
> > so it just loops back to wait.  A 1s fallback timeout remains as a
> > liveness backstop.
> >
> > 20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
> > cancel-ack| measured with strace on the reaper TID:
> >
> >     before: median 255 ms, max 502 ms
> >     after:  median 0.6 ms, max  27 ms
> >
> > kvm_dirty_ring_reaper_init() returns int again (was made void in
> > commit 43a5e377f4) to propagate event_notifier_init() failure.
> >
> > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> > ---
> > Changes in v2:
> > - Fix compilation error: kvm_init() has no Error **errp parameter, so
> >   kvm_dirty_ring_reaper_init() now uses error_report() directly and
> >   no longer accepts an errp argument.
> > - Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler:
> >   it already reaps synchronously (all vCPUs or the ring-full one), so
> >   a background reaper kick would only be redundant or a no-op.
> > - Move kick site from dirtylimit_change(false) to
> >   dirtylimit_state_finalize() after dirtylimit_state =3D NULL, ensuring
> >   the reaper actually proceeds past the dirtylimit_in_service() check.
> >
> >  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
> >  accel/stubs/kvm-stub.c   |  4 ++++
> >  include/system/kvm.h     |  7 +++++++
> >  include/system/kvm_int.h |  3 +++
> >  system/dirtylimit.c      |  2 ++
> >  5 files changed, 52 insertions(+), 6 deletions(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 96f90ebb24..be005832bc 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *k=
ml,
> >      } while (size);
> >  }
> >
> > +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND=
)
> > +
> >  static void *kvm_dirty_ring_reaper_thread(void *data)
> >  {
> >      KVMState *s =3D data;
> > @@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void =
*data)
> >      trace_kvm_dirty_ring_reaper("init");
> >
> >      while (true) {
> > +        GPollFD pfd =3D {
> > +            .fd =3D event_notifier_get_fd(&r->reaper_notifier),
> > +            .events =3D G_IO_IN,
> > +        };
> > +
> >          r->reaper_state =3D KVM_DIRTY_RING_REAPER_WAIT;
> >          trace_kvm_dirty_ring_reaper("wait");
> > -        /*
> > -         * TODO: provide a smarter timeout rather than a constant?
> > -         */
> > -        sleep(1);
> > +
> > +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> > +
> > +        /* Drain unconditionally so a stale event can't spin the next =
loop. */
> > +        event_notifier_test_and_clear(&r->reaper_notifier);
> >
> >          /* keep sleeping so that dirtylimit not be interfered by reape=
r */
> >          if (dirtylimit_in_service()) {
> > @@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void =
*data)
> >      g_assert_not_reached();
> >  }
> >
> > -static void kvm_dirty_ring_reaper_init(KVMState *s)
> > +static int kvm_dirty_ring_reaper_init(KVMState *s)
> >  {
> >      struct KVMDirtyRingReaper *r =3D &s->reaper;
> > +    int ret;
> > +
> > +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> > +    if (ret < 0) {
> > +        error_report("Failed to initialize dirty ring reaper notifier:=
 %s",
> > +                     strerror(-ret));
> > +        return ret;
> > +    }
> >
> >      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
> >                         kvm_dirty_ring_reaper_thread,
> >                         s, QEMU_THREAD_JOINABLE);
> > +    return 0;
> > +}
> > +
> > +void kvm_dirty_ring_reaper_kick(void)
> > +{
> > +    KVMState *s =3D kvm_state;
> > +
> > +    if (!s || !s->kvm_dirty_ring_size) {
> > +        return;
> > +    }
> > +    event_notifier_set(&s->reaper.reaper_notifier);
> >  }
> >
> >  static int kvm_dirty_ring_init(KVMState *s)
> > @@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState=
 *ms)
> >      }
> >
> >      if (s->kvm_dirty_ring_size) {
> > -        kvm_dirty_ring_reaper_init(s);
> > +        ret =3D kvm_dirty_ring_reaper_init(s);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> >      }
> >
> >      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
> > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > index c4617caac6..b878598552 100644
> > --- a/accel/stubs/kvm-stub.c
> > +++ b/accel/stubs/kvm-stub.c
> > @@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
> >      return 0;
> >  }
> >
> > +void kvm_dirty_ring_reaper_kick(void)
> > +{
> > +}
> > +
> >  bool kvm_hwpoisoned_mem(void)
> >  {
> >      return false;
> > diff --git a/include/system/kvm.h b/include/system/kvm.h
> > index 5fa33eddda..e127a5eb37 100644
> > --- a/include/system/kvm.h
> > +++ b/include/system/kvm.h
> > @@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
> >
> >  uint32_t kvm_dirty_ring_size(void);
> >
> > +/**
> > + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
> > + *
> > + * Safe from any thread; no-op when the dirty ring is not in use.
> > + */
> > +void kvm_dirty_ring_reaper_kick(void);
> > +
> >  void kvm_mark_guest_state_protected(void);
> >
> >  /**
> > diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> > index 0876aac938..c14ebc927f 100644
> > --- a/include/system/kvm_int.h
> > +++ b/include/system/kvm_int.h
> > @@ -12,6 +12,7 @@
> >  #include "system/memory.h"
> >  #include "qapi/qapi-types-common.h"
> >  #include "qemu/accel.h"
> > +#include "qemu/event_notifier.h"
> >  #include "qemu/queue.h"
> >  #include "system/kvm.h"
> >  #include "accel/accel-ops.h"
> > @@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
> >      QemuThread reaper_thr;
> >      volatile uint64_t reaper_iteration; /* iteration number of reaper =
thr */
> >      volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr st=
ate */
> > +    /* Wakeup channel: kicked when dirty-limit is torn down. */
> > +    EventNotifier reaper_notifier;
> >  };
> >  struct KVMState
> >  {
> > diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> > index c934ceb0de..a33256ade7 100644
> > --- a/system/dirtylimit.c
> > +++ b/system/dirtylimit.c
> > @@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
> >      g_free(dirtylimit_state);
> >      dirtylimit_state =3D NULL;
> >
> > +    kvm_dirty_ring_reaper_kick();
> > +
> >      trace_dirtylimit_state_finalize();
> >  }
> >
> > --
> > 2.50.1 (Apple Git-155)
> >
