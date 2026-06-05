Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA33C8C52
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647753; cv=pass; b=ZETqC4hCseZgzueGXJADCZbCS6HdzCWPtNmwGEQEIUX7HpTeKgWHzqj9d0LoIFUja+BMI6TMqXSUpbLBwMjQCeFzkIW4FHQ2z7AwxehW5mShHgMFglkg4kvjE7s+LklePMhwzrx/sGTARhk7xdsNFPVSG/DOIHONLWksPpeeqCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647753; c=relaxed/simple;
	bh=8b9XxNf9St3BzwW/NLcbUdWkrVeQWSc6jX8af0VFRck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMjCpk+gv28WykLYvY2fLoPN/wxr9xiGXmBKS7HL6kiJJkb9luwS6wbMSuDfTDaad9u8p6KUTDYxomijvdnsG0bDHokVHkYu6QWkPG8rG46WNXlf/88/RGPUOU2+F2uumV85wWoOQeHKuazEKroN2X7yL6bSfpJBDTHwKVWpJYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com; spf=pass smtp.mailfrom=bitdeer.com; dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b=DtRQ9Fnn; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitdeer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitdeer.com header.i=@bitdeer.com header.b="DtRQ9Fnn"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa63628d26so1420251e87.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 01:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647749; cv=none;
        d=google.com; s=arc-20240605;
        b=BUMKez6fHguPCP+niwwsMbq0VcZKZDyWhR5sATtr5/daerm1wo0YKzi5BDLn4LAQpd
         epPoPHi6KSCBcTFLz8bbR/21/wVg9K1PbDVi/knbCEFsjdAIZd6eC43fQ/gwJLgSbebQ
         PDCe4vg0qBb/1Dmi+EHPdENYDb3DauE1rktSXb66evUptMpkYD05LjE84zbJRCBVU0Ko
         4xyX7fsU+Jb27QgjFrWSHlspLoqtppNjAkRD8SXWiV3kob36w0uZT+TEv3pybwluhDef
         q5R5PrtTKQDbOmmjTiTDgpIwvksmjRFI12NPU3KTpMPxVpO6GVgjn5u5hIkUF+uW9a5y
         ecwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GpEHuE5kPK7Pr7bmO5Kq29IlE/AYkLhUV+YgYWTUjog=;
        fh=iudupu1BXlnKrxqDq5o8+3H04i6po4T+824HpgoYHWk=;
        b=Kv4xgODPxsunZXgniHbu0/EKvwr/gkKo+oe1WLvu8U3txSNpXj/EO8hknohiBo3jCr
         VEith5NQ76i3ydsxPHINpPxsPzRSUYnKO0j4ImWw558/JllhmDrJR+uAURP72muhdvJ4
         Ilj4uRoq6DnvAESEt+6XoprxzM0GO5pBMizGZrnyZo/rUTI15DqZ/A1sRhu8o4ADFH+X
         SxrdaDXl8b//CAvLiAoJTEJtUcn1ALib57b+TE1KxZwSvvNRmDpirlPapSya8Q1dNHdU
         KY07bacuk85hD0LC/FIVAQh/6CduBfciZf9/k/eMweZI7NggbpbC2ud3ta05VulBRu0X
         Bnkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitdeer.com; s=google; t=1780647749; x=1781252549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpEHuE5kPK7Pr7bmO5Kq29IlE/AYkLhUV+YgYWTUjog=;
        b=DtRQ9Fnndhih0RW0lxG4xsro3nj1kdipinv8/uDM2488nKTPCTBhgKdZK9ciE19RGb
         vvgvtlF7VpR2PFA07JgwnI9FDcPmK8ECTZ0saiEEO3IV7mT2ntcVOzCKGmWl9iptQQXA
         MiCuJhAmG9+erIuB2gkWi97l8qVFv+z2X1AYfT2TiCLqKqdu8INUtU/mo/XpzJxTHbrN
         pPlxrbqesQ/hScZEpdUsmOecGorPChOvmfFQoa8Ys0e/bggcfgmPeqVwxQNHfqIttoW4
         HnFd+KO16/ScC9xqcY+HKO8ey4XOtZeDqiQ9Qs9vxXIVET+1h4yEMEV40qrcUDxR50pi
         vQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647749; x=1781252549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpEHuE5kPK7Pr7bmO5Kq29IlE/AYkLhUV+YgYWTUjog=;
        b=XgHVD9GyK75dV1xuGN5Osi0YRbioZ2wpMf0ZFlj22Ewsmk8CQXQy7O/gm7qnhSUrgU
         Xj+kcWTKf7Sf7DodoAKkJL4C4Sf7ANMWDFdQiiK/n0lAWSGm++Zc2uYLbNXyD3QRiH1+
         XwX33nOqOgL8gSp37EDWVfbghrWB8TeJnoBbsOFM5ulLXJxA1LWJ0jZflS/jap3ikUm1
         lFIorsUupwQA+aoJB6nl7GtexkQH2hB1cdBPErxqYVRthPNBP6oTqbQJ/rdxRLyaiC6H
         yan6VKbwcxTn0XI4kzi/45XtXJBzom+mGmhKbLlLXxJ10uNMlugth+OB5J5FSdD95paN
         NotQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rb7NtBlSymwUY/XKVLbR1EhBvBIs+Rwr0hsGBKjy0i55Rx/2jJAY64diF/B4rchhtwBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1/zui1kG7/XXdz4rwulBw4hFYTsHJmwuXjsTN/R9YbscXxgT
	jGdg7nMWpKxjWRKhvOrT+RXuIaADNYnzGgzljXEI7x8E4dQfdss4uZaKGDjBAInRb3t1sGWuPAa
	kr4vOb9Djcbv16AOQPQbvPKLV/LIOVBw6F8RLtlfYaw==
X-Gm-Gg: Acq92OFSN5/58n3U+s5C7Q8fi9245A9qkG0SeG8GCM2bY0W7qjKkEfzFpVLu+KdEcyT
	c5DsM0u9zTCYn/fSMWdVOVL6ob0F9dN2omTfRTv5v6e9AgwzjfuSdRoIH47SvKUDPE4APo4xrLS
	8gnlyZM+2ZfXX3iUBRmOH9aUIEI8TI6dQSPZWd2RXTiNnhiVNHR6BJh4fyKM1k9Rr938J6sUoiJ
	ed3vAz6HsYCtzOS3BpfLpdpMsUKSJxI/QlFOXr2N+RLNeBjkVGs10nKnoUzmBPECqyvlY/6lLeQ
	rh8hgDSBOOlg4XmtttQC
X-Received: by 2002:a05:6512:3503:b0:5aa:7363:8219 with SMTP id
 2adb3069b0e04-5aa87bbc36dmr719979e87.17.1780647749283; Fri, 05 Jun 2026
 01:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604070029.34982-1-guobin@linux.alibaba.com>
In-Reply-To: <20260604070029.34982-1-guobin@linux.alibaba.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Fri, 5 Jun 2026 16:22:18 +0800
X-Gm-Features: AVVi8CehWLP43yLhYl0QqKHuUEMtibp5cV8zT-_XbebMEoocv3nCz5FputHBJj8
Message-ID: <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com>
Subject: Re: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Hyman Huang <infra.ai.cloud@bitdeer.com>

On Thu, Jun 4, 2026 at 3:00=E2=80=AFPM Bin Guo <guobin@linux.alibaba.com> w=
rote:
>
> The reaper polls with sleep(1) (TODO in the code) and only notices
> dirty-limit teardown at the next 1s tick.
>
> Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
> from dirtylimit_state_finalize() after dirtylimit_state has been
> cleared.  The kick must follow the NULL assignment: kicking earlier
> wakes the reaper while dirtylimit_in_service() still returns true,
> so it just loops back to wait.  A 1s fallback timeout remains as a
> liveness backstop.
>
> 20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
> cancel-ack| measured with strace on the reaper TID:
>
>     before: median 255 ms, max 502 ms
>     after:  median 0.6 ms, max  27 ms
>
> kvm_dirty_ring_reaper_init() returns int again (was made void in
> commit 43a5e377f4) to propagate event_notifier_init() failure.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
> Changes in v2:
> - Fix compilation error: kvm_init() has no Error **errp parameter, so
>   kvm_dirty_ring_reaper_init() now uses error_report() directly and
>   no longer accepts an errp argument.
> - Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler:
>   it already reaps synchronously (all vCPUs or the ring-full one), so
>   a background reaper kick would only be redundant or a no-op.
> - Move kick site from dirtylimit_change(false) to
>   dirtylimit_state_finalize() after dirtylimit_state =3D NULL, ensuring
>   the reaper actually proceeds past the dirtylimit_in_service() check.
>
>  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
>  accel/stubs/kvm-stub.c   |  4 ++++
>  include/system/kvm.h     |  7 +++++++
>  include/system/kvm_int.h |  3 +++
>  system/dirtylimit.c      |  2 ++
>  5 files changed, 52 insertions(+), 6 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 96f90ebb24..be005832bc 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      } while (size);
>  }
>
> +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
> +
>  static void *kvm_dirty_ring_reaper_thread(void *data)
>  {
>      KVMState *s =3D data;
> @@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
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
> -        /*
> -         * TODO: provide a smarter timeout rather than a constant?
> -         */
> -        sleep(1);
> +
> +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> +
> +        /* Drain unconditionally so a stale event can't spin the next lo=
op. */
> +        event_notifier_test_and_clear(&r->reaper_notifier);
>
>          /* keep sleeping so that dirtylimit not be interfered by reaper =
*/
>          if (dirtylimit_in_service()) {
> @@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
ata)
>      g_assert_not_reached();
>  }
>
> -static void kvm_dirty_ring_reaper_init(KVMState *s)
> +static int kvm_dirty_ring_reaper_init(KVMState *s)
>  {
>      struct KVMDirtyRingReaper *r =3D &s->reaper;
> +    int ret;
> +
> +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> +    if (ret < 0) {
> +        error_report("Failed to initialize dirty ring reaper notifier: %=
s",
> +                     strerror(-ret));
> +        return ret;
> +    }
>
>      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
>                         kvm_dirty_ring_reaper_thread,
>                         s, QEMU_THREAD_JOINABLE);
> +    return 0;
> +}
> +
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
> @@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState *=
ms)
>      }
>
>      if (s->kvm_dirty_ring_size) {
> -        kvm_dirty_ring_reaper_init(s);
> +        ret =3D kvm_dirty_ring_reaper_init(s);
> +        if (ret < 0) {
> +            goto err;
> +        }
>      }
>
>      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
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
> index 5fa33eddda..e127a5eb37 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
>
>  uint32_t kvm_dirty_ring_size(void);
>
> +/**
> + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
> + *
> + * Safe from any thread; no-op when the dirty ring is not in use.
> + */
> +void kvm_dirty_ring_reaper_kick(void);
> +
>  void kvm_mark_guest_state_protected(void);
>
>  /**
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938..c14ebc927f 100644
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
> +    /* Wakeup channel: kicked when dirty-limit is torn down. */
> +    EventNotifier reaper_notifier;
>  };
>  struct KVMState
>  {
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index c934ceb0de..a33256ade7 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
>      g_free(dirtylimit_state);
>      dirtylimit_state =3D NULL;
>
> +    kvm_dirty_ring_reaper_kick();
> +
>      trace_dirtylimit_state_finalize();
>  }
>
> --
> 2.50.1 (Apple Git-155)
>
