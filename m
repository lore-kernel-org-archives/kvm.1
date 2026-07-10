Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5F223DC6
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664438; cv=pass; b=Gf1vKrp89rPYqHVdmmCTcS/GoAxoMOwUBCRkhpfKWtpb/0Lg+l4Al8D/k5duPcdumE+tgUncBx221aLEhjurya2ImRCzIN13AY5fAhsWjAlXEjKLQVQxTt+Jj3yg3vQBfmKPcvIn5wMjOvGmrRwrw0ybzrQldVZ9ajT23E2/gHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664438; c=relaxed/simple;
	bh=oZk47QZw6+QfNm6Bg5lxiTu81BqC2j0+099W21nNZ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3z1oGAlISUsYGBpzeTtHo+iAKaEHmi5cH5fOlrUu0HgwalEx31hg0LxT/Asao9y/7v0zru/KG7b8qxed1gUfAvFNtg8TTcqhW7bTAm5w9D+R9fPzZOBuMyqm62+F4gi42FlmW535h0O3JpBYxgfSTDFLHfcCyE1Pjeto8C+1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com; spf=pass smtp.mailfrom=bitdeer.com; dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b=HGKqIQa0; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b="HGKqIQa0"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso819101fa.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 23:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783664435; cv=none;
        d=google.com; s=arc-20260327;
        b=SXe66CcKoaFa69wTTcttlmQGVm5rnbi+2Y0PH+eGk3wPBtOFJCkolqZBrQk4VaFATM
         ZRGwipBjeHuIpxtGMDtX0c9R41m1XoxKzkVluNCKv8z65919XcOBCd3EBM+1fqMtKKiG
         b7mM2VgZZrvHc0q40v8TnDTPlTFABi6hxTUu7ZEoCvZVY8ZuLlir2724Zf+M8DmUpZte
         TmZ8B5V0sBwj1/4/niPqlVczXL8R8o8ipoVsPcn4y++6EplbwrF1ir5PQExgiEPu8CeK
         RlwhixLR/B8KRmXMeOIVRxCCQbPN7zBpyS70MMUNJBXlqR30dKbntdXXJ+7OiJIYO4TQ
         yz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3K2lJjNYbabdV2J8xkgif5q+aOVMgO7AsbYEYuCj8Tw=;
        fh=SEcF4JvG5rq3+pEnzFOQnpUEqRZklJm7Iy/S+cWwpUI=;
        b=Fc5YX47Zt12AYlxbQGntR2o/+9OqlbWEfI7Tp7+7ODFTf8+Q5bbaYbN+1/F8RRaq48
         baR3Yi2VWijWsl92m282AEpOlEgjDUw6Ne45psIu0TM0aWQnp5XEBBTLq/3vuXwNCzeR
         uHOYwup5D8mN54nPbhgGqLcqWzKlpD+4HGoVY2jzysmRAetEd1vinzuXyE7xAK0hRco9
         i+I5fYgb3IPpTkWRq49TosbpdDTyakSPh11vkb/DO/A9F6UEX2e2uIG49OBNyGLvQ9gv
         Q5+uMNUbSaOXdvXFG6gundYnUO+43/HTnElDJI7Dk8ZvNs3fuW9S9mDsIk1Uno/YoHPM
         o6lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitdeer.com; s=google; t=1783664435; x=1784269235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3K2lJjNYbabdV2J8xkgif5q+aOVMgO7AsbYEYuCj8Tw=;
        b=HGKqIQa0BfSMWlk0P5/79bjULpFD3dt6hgpDGyM3eSeawBat/5HkYzWBCsuHjO4GcP
         RYVdC5jIxDGqaf/fzIrbevsj0OsvP90+1QXApERdv/VY1CN0wb8orFQipwha4tDdJ9NH
         VGP7KHag2kTpowY1oi6aE7BOS2yx2dlS//zqGYSgguCSs7M6fSJK7XfQiUkxP4DZUK3d
         eSyQ67IMzOzE78MZUdwm52nXfUNxAehxyNO7agEMauqwzg0HM0Eee/BOu85+Plik8Uxx
         ZJ/Gq+2HoMQS/OqgXTSeMHenzOVWqHIiZbLPXSQJ2PCmy9H0fNHAP/JX1I/rCMsXBJdT
         ACUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783664435; x=1784269235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K2lJjNYbabdV2J8xkgif5q+aOVMgO7AsbYEYuCj8Tw=;
        b=JnSFuUWC7YDtprJpft1ZuKKH5KgLnIKkOX4kyezYBsK7fSfqnvE71d9/XGYKdKsYQy
         tp0Aa/6w/oM0gyzP77+1a8K1pGVOjYgos2FnLUIL0hcdDWjuIGfqyGp6E1QLqP+RbgRL
         zFDVcJbeGJ5FNOjLVTY3gjyZAbLj58FxFZFHn5scBOImkTjW8xNyBnD9q1PefIDGATrg
         Fo5Re6g8vJNcZBZCqgPwHWyXe5NCzzZzlEqWcVqzUT6XaBT8E5L3QQGIS/DPU/goKitC
         QQrVhzTHk9R1ooyUJwWXT8FHm/9hB3B0Eyig8zAsIZ3h07YSMxqqjkOu4WhabNxEcuTX
         1uIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzQOSfY4zrivVNpDzE/5kacCcRca5XzwFCx3f/wj/kJAZlJ3FUecfrvLkWSt9TMmCnX7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwfx7Ka+RXSgdmOWUU0Da1jMSgRD2gfbC3FeqRdAt/YlJpKuIz
	+1CnN3NFxQFV7kNbTvDUAc6Fvb6ixUWj52bBgYJzomvxMtvWeOBxUY5nojFMBfgXKjMhoMvM/Va
	3u39cmf/VgAb6UEX/2Tc5AMr/5+dKxpG/HV1Wu8t+yg2S+5cAcap6MSo=
X-Gm-Gg: AfdE7ckEs72BGKUqJUfbk/lRUwl5x8Otn3RmMdlrB6nNQehPH3Xmtn4TWIDtiblpshT
	PWRZqM708F8WdQIEyEXNF7e/5Q4mqZB3IUTed1SoUMn4t7ZIBkHnBztFb7w/jeVsc0lz88uSFzN
	TNTXb/fVlOGLdHiHN3Pb8Gzg6uTGvn+pRtX6ecRUiQru9a0yqbA68W5aWifa1USWJ8TnzU+m9Zt
	66GIuNZhTnH9D0jfzSeQ7SWAVykJMHU50BkIK7rBojHzBCEu4F3ADCf3ovJjAhrAlnatrjF
X-Received: by 2002:a2e:ab06:0:b0:39c:94d4:fb51 with SMTP id
 38308e7fff4ca-39c94d4ffb1mr4235191fa.34.1783664434683; Thu, 09 Jul 2026
 23:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604070029.34982-1-guobin@linux.alibaba.com>
 <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com> <CAFWXh4x7sP-r6i9n-X7-gzkNNNqE5OegYkJZ=6TQvzhtgFLPdg@mail.gmail.com>
In-Reply-To: <CAFWXh4x7sP-r6i9n-X7-gzkNNNqE5OegYkJZ=6TQvzhtgFLPdg@mail.gmail.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Fri, 10 Jul 2026 14:20:21 +0800
X-Gm-Features: AUfX_mxYHxQzrHIxMXLyAf7SNCY_YI6Wsl4UBQr6JmzU6bogb79UW2SFlnaUTxs
Message-ID: <CAFWXh4w4K9FabNoSECdrvce7cXZBcC=CYpgxR_3VvyK+hfny-Q@mail.gmail.com>
Subject: Re: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

In case this patch gets overlooked as time goes on.

On Thu, Jun 18, 2026 at 8:58=E2=80=AFAM Hy Man <infra.ai.cloud@bitdeer.com>=
 wrote:
>
> Ping=E3=80=82
>
> Hi Paolo, could you please take a look at this patch, I=E2=80=99d appreci=
ate
> your feedback on this patch.
>
> On Fri, Jun 5, 2026 at 4:22=E2=80=AFPM Hy Man <infra.ai.cloud@bitdeer.com=
> wrote:
> >
> > Reviewed-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
> >
> > On Thu, Jun 4, 2026 at 3:00=E2=80=AFPM Bin Guo <guobin@linux.alibaba.co=
m> wrote:
> > >
> > > The reaper polls with sleep(1) (TODO in the code) and only notices
> > > dirty-limit teardown at the next 1s tick.
> > >
> > > Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
> > > from dirtylimit_state_finalize() after dirtylimit_state has been
> > > cleared.  The kick must follow the NULL assignment: kicking earlier
> > > wakes the reaper while dirtylimit_in_service() still returns true,
> > > so it just loops back to wait.  A 1s fallback timeout remains as a
> > > liveness backstop.
> > >
> > > 20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
> > > cancel-ack| measured with strace on the reaper TID:
> > >
> > >     before: median 255 ms, max 502 ms
> > >     after:  median 0.6 ms, max  27 ms
> > >
> > > kvm_dirty_ring_reaper_init() returns int again (was made void in
> > > commit 43a5e377f4) to propagate event_notifier_init() failure.
> > >
> > > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> > > ---
> > > Changes in v2:
> > > - Fix compilation error: kvm_init() has no Error **errp parameter, so
> > >   kvm_dirty_ring_reaper_init() now uses error_report() directly and
> > >   no longer accepts an errp argument.
> > > - Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handle=
r:
> > >   it already reaps synchronously (all vCPUs or the ring-full one), so
> > >   a background reaper kick would only be redundant or a no-op.
> > > - Move kick site from dirtylimit_change(false) to
> > >   dirtylimit_state_finalize() after dirtylimit_state =3D NULL, ensuri=
ng
> > >   the reaper actually proceeds past the dirtylimit_in_service() check=
.
> > >
> > >  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++----=
--
> > >  accel/stubs/kvm-stub.c   |  4 ++++
> > >  include/system/kvm.h     |  7 +++++++
> > >  include/system/kvm_int.h |  3 +++
> > >  system/dirtylimit.c      |  2 ++
> > >  5 files changed, 52 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > > index 96f90ebb24..be005832bc 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener =
*kml,
> > >      } while (size);
> > >  }
> > >
> > > +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECO=
ND)
> > > +
> > >  static void *kvm_dirty_ring_reaper_thread(void *data)
> > >  {
> > >      KVMState *s =3D data;
> > > @@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(voi=
d *data)
> > >      trace_kvm_dirty_ring_reaper("init");
> > >
> > >      while (true) {
> > > +        GPollFD pfd =3D {
> > > +            .fd =3D event_notifier_get_fd(&r->reaper_notifier),
> > > +            .events =3D G_IO_IN,
> > > +        };
> > > +
> > >          r->reaper_state =3D KVM_DIRTY_RING_REAPER_WAIT;
> > >          trace_kvm_dirty_ring_reaper("wait");
> > > -        /*
> > > -         * TODO: provide a smarter timeout rather than a constant?
> > > -         */
> > > -        sleep(1);
> > > +
> > > +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> > > +
> > > +        /* Drain unconditionally so a stale event can't spin the nex=
t loop. */
> > > +        event_notifier_test_and_clear(&r->reaper_notifier);
> > >
> > >          /* keep sleeping so that dirtylimit not be interfered by rea=
per */
> > >          if (dirtylimit_in_service()) {
> > > @@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(voi=
d *data)
> > >      g_assert_not_reached();
> > >  }
> > >
> > > -static void kvm_dirty_ring_reaper_init(KVMState *s)
> > > +static int kvm_dirty_ring_reaper_init(KVMState *s)
> > >  {
> > >      struct KVMDirtyRingReaper *r =3D &s->reaper;
> > > +    int ret;
> > > +
> > > +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> > > +    if (ret < 0) {
> > > +        error_report("Failed to initialize dirty ring reaper notifie=
r: %s",
> > > +                     strerror(-ret));
> > > +        return ret;
> > > +    }
> > >
> > >      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
> > >                         kvm_dirty_ring_reaper_thread,
> > >                         s, QEMU_THREAD_JOINABLE);
> > > +    return 0;
> > > +}
> > > +
> > > +void kvm_dirty_ring_reaper_kick(void)
> > > +{
> > > +    KVMState *s =3D kvm_state;
> > > +
> > > +    if (!s || !s->kvm_dirty_ring_size) {
> > > +        return;
> > > +    }
> > > +    event_notifier_set(&s->reaper.reaper_notifier);
> > >  }
> > >
> > >  static int kvm_dirty_ring_init(KVMState *s)
> > > @@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineSta=
te *ms)
> > >      }
> > >
> > >      if (s->kvm_dirty_ring_size) {
> > > -        kvm_dirty_ring_reaper_init(s);
> > > +        ret =3D kvm_dirty_ring_reaper_init(s);
> > > +        if (ret < 0) {
> > > +            goto err;
> > > +        }
> > >      }
> > >
> > >      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
> > > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > > index c4617caac6..b878598552 100644
> > > --- a/accel/stubs/kvm-stub.c
> > > +++ b/accel/stubs/kvm-stub.c
> > > @@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
> > >      return 0;
> > >  }
> > >
> > > +void kvm_dirty_ring_reaper_kick(void)
> > > +{
> > > +}
> > > +
> > >  bool kvm_hwpoisoned_mem(void)
> > >  {
> > >      return false;
> > > diff --git a/include/system/kvm.h b/include/system/kvm.h
> > > index 5fa33eddda..e127a5eb37 100644
> > > --- a/include/system/kvm.h
> > > +++ b/include/system/kvm.h
> > > @@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
> > >
> > >  uint32_t kvm_dirty_ring_size(void);
> > >
> > > +/**
> > > + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reape=
r.
> > > + *
> > > + * Safe from any thread; no-op when the dirty ring is not in use.
> > > + */
> > > +void kvm_dirty_ring_reaper_kick(void);
> > > +
> > >  void kvm_mark_guest_state_protected(void);
> > >
> > >  /**
> > > diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> > > index 0876aac938..c14ebc927f 100644
> > > --- a/include/system/kvm_int.h
> > > +++ b/include/system/kvm_int.h
> > > @@ -12,6 +12,7 @@
> > >  #include "system/memory.h"
> > >  #include "qapi/qapi-types-common.h"
> > >  #include "qemu/accel.h"
> > > +#include "qemu/event_notifier.h"
> > >  #include "qemu/queue.h"
> > >  #include "system/kvm.h"
> > >  #include "accel/accel-ops.h"
> > > @@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
> > >      QemuThread reaper_thr;
> > >      volatile uint64_t reaper_iteration; /* iteration number of reape=
r thr */
> > >      volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr =
state */
> > > +    /* Wakeup channel: kicked when dirty-limit is torn down. */
> > > +    EventNotifier reaper_notifier;
> > >  };
> > >  struct KVMState
> > >  {
> > > diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> > > index c934ceb0de..a33256ade7 100644
> > > --- a/system/dirtylimit.c
> > > +++ b/system/dirtylimit.c
> > > @@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
> > >      g_free(dirtylimit_state);
> > >      dirtylimit_state =3D NULL;
> > >
> > > +    kvm_dirty_ring_reaper_kick();
> > > +
> > >      trace_dirtylimit_state_finalize();
> > >  }
> > >
> > > --
> > > 2.50.1 (Apple Git-155)
> > >
