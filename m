Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795828589;
	b=fWPHcgx3kteFHb7d0zpKkNHEYiLLr5o8yN6AEtxBWOUQN7pHBDHZ6U1zQ95dR/jLP7fa
	 4T8U5VtS8EndVniR5xWR1IPG0KestEpBi3Ud42wEEplyKBSsgAtwidCRq50MAK+sAi8NC
	 o1M4yyCvoHuibwfuiZCdJkDWG30NmGBYTyeQeK7ZcjR0f7jRQZP2GZ+u6BkcUTCDpfmH1
	 PHp4OpF3GcKflr2ky0JVf845nLzRUhUHsy9S2vft3VoucDJMR+ZzKQhl6j6/LqwNdDfze
	 Hz/n4RnxrSyJVMcAQ+SrW62FYL5mOhtka0UtJhjiryx783DCHAAgrIJkfnehtnvvEcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795828589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=BBMBNNcvr0Pj2/ghVYvp4jkKT4rcq0bfzVoAeRYCUTU=;
	b=cFxDMlMxi+yLcTW9+45doEYrG6Y/dZqji1nzd5gmpvea9ufNEF9KA6LF9CfT5VB3HVKZ
	 igO4pgngfIqjvex9czHS6RMrAFrU9XyjYZGZkjxHAXlMqc9Fk+MlaQulJgQ73FWpG4yUz
	 igZSY7HsNzUxTHQYci7DzQ1HLoPmtCchKrekcbGuy9P871NSpKkATG/LMtitAPgBxbGMP
	 cX40XX1jUN7rEVTltzQJ55Idt7+ujy9jwrxzEy+sNmCvOouH7L+/whr+v8GrQie81HXGm
	 Df3kVIUHz7Fbrcqo6NYoVtFiUHJZE0X4sI1N++4I98qWjViVgWD2qAkalF0sFVUZj8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o86oLYeq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F2606A31E
	for <kvm@vger.kernel.org>; Sat, 28 Nov 2026 01:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB4F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o86oLYeq
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4b563403c7eso2119390fac.1
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795828587; cv=none;
        d=google.com; s=arc-20260327;
        b=d3jF1ywUjKf4mawnyZshGppn2UILdVTgs2q3OmHrZXzl3s5jPJfSk8xUJdh2+vRYG9
         PDpgcoBfPkQDCPyCNG6jmPvZX0o4Ok7xVYP0sfssarj0t19f+KSnwc/2KP+x/Dcolf18
         GVb7+7dWpDv4p3u9qKPzEqI9tUrpI6VhrjLdJJQuqZV0Uz3jom5N2Kqb6/RczMnW/QaZ
         3qrhfFHbo8TC8OQJ5ge7dDG+2z2+JbzWZCqzqpw1kCLvMVpY4UG6eh89GUKbRDI0oaIi
         10HQQo1GAHgNeXzffwaUeqvudrdq6kQQlTcKpIH/I2nhmxDGBSYxg/J/B2bk6qwv8MTR
         S3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=BBMBNNcvr0Pj2/ghVYvp4jkKT4rcq0bfzVoAeRYCUTU=;
        fh=EO6O2bjQX5kTTJTvXEuuYVFPm7rk3i3KsQto7nBlIDU=;
        b=mPJEbZDi2qZXyFDuuHsqjO60Qz8mtXH+Ocjk5UqY6eFVMGixefZ9DS83Mq+/htr7qB
         rW8sFdUHB3LrGcW15bbmQMIbRTFIbMB+I3+ESOwG+KmbkMd+4d8RzDkvMTEl3IoniVn5
         aVkImHxrOq9qQUq8jB+iSkHBPzXdEyM07G4B7iP4UbaCuC3f1pfNsXozVPF/yUNZRhN4
         i9lxwycHXCu7O3lGDrG7oQqIpD0fZoyrGW4yB8i1JcUElW1W0zOAbQqPNhdMihkvGrNZ
         JPcGD9IVDlxOeWlswYHK5PG2TSQJPO/VBQ4lIDZIl6sKscFdcjK8pfTphfZCWlafp4BS
         x9TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795828587; x=1796433387; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBMBNNcvr0Pj2/ghVYvp4jkKT4rcq0bfzVoAeRYCUTU=;
        b=o86oLYeqVzq2hq2G89nIH8n5OsHRRTqP7nbBmZvSb3mqA/vNuXrEujFGZAe1VLOTq1
         k+Tmm7ye3PH06KsM5zyMIDLMgbvXGvD+5frlR2wFVNxRC0cy/gYRneggGbFd7ap06G5a
         bV5P4G9CmVkZGQMAsoHFIciwwQoxHMNMwWjmUTfKFVbvGGOFmVrxd1WSvFLLcx9g/jn2
         nLI6F5eNcFDT7JI6O3DWaZ1OF5igEAh89s3IzYqDrWxHxvUR44So3raDi3Jdohk3gdkP
         CRfOcLoKQu5z8v0jjbcYxfvwvq7BXVoqZNIGhQyu/dFSibsKfbVVBeHJiaAHy4pBTVox
         So5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795828587; x=1796433387;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BBMBNNcvr0Pj2/ghVYvp4jkKT4rcq0bfzVoAeRYCUTU=;
        b=aDvWjB/sg8NshtptoO3c+Rh/P/KnFsX6ucIAm1fUDGPk7nN0RYuCHoSLJX4wxMTEOh
         eymINCfEDbjR0Ve60tVb4m1FRIc5QOJso7l70yjQ3Ja1mufCo86KgmQBNswOuoNbP8I9
         X8SRvd+wtarWNBE6JyZGY052n7GDyKyexIcLXuTy/q8ybcr56L30FIMzZToGuybWNFI9
         hMRUAoXAgc++BsXCYq+pTHosSrE7RnNFdiJU08/ffg3eL0n5Amm/ICAQn0hJDTDRb/Q1
         Oa9pppLgeYqtYPWSg5MoLWAZfCn0cQNAgExG3fXFY3zWBq7WT7ZXbipv23GmVz1d479d
         cy9g==
X-Forwarded-Encrypted: i=1; AL+hErGGfquxyP3nMNcQnaRLoSilz1UW/G1nK29yRLG0Bl5E5DkmwPkpJcedEw42EFOWJAkCRQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9m4KWPIHeGciVzCxe9oAhKVJOIJ7qB1difH1r5uF0J6zoUawGm
	TotpjDE+bysZJ8HaI/6VB1XUnAvzPzh2x8wbWneBCH9EWpnJ2QoF8QitBoeIO8DYzoFlfgczTga
	Bckvu6nIwJxssS72WEyGJ3VLWuGhZef0=
X-Gm-Gg: AZFdTZfiGA13sDkGRbw8lzvslnBRA/6PBqLvc+5PLph85FL2FVGhfFBCH/Q0FjQgDaT
	2oWXRoZh4YuyfUSfcjLgIr7Ye9XktdBggGFERbCF4UbLlMNFvPnHLpejOBIp+at7GomyX+qlUZf
	r1hKA9C70QjM9pB9wVmRzYlLZ7OJoinZQoScM6Tm+eqjAhnMllQb2hDDPe/Yhx2wFKub2B8SrDN
	km7vdA1dCF4MtrlbfUV9NlQiO4CToExicb2BIL9TxSxixOtB1tqXqQa1I1jc1A1E6Un/giqDVkx
	CBVQ/tItJxi/P6OJIxOy14PFLbvphtPQnFcPFg9F8Iajw+lohIyIOL6vQP89fdxjJIA7Ei4oG9s
	j0492fkUXVQGUBibUivZh1WD/HpVvj67i5LCoqYpccQmVR5w/1GxOSaAQ4Q==
X-Received: by 2002:a05:6808:2224:b0:572:d0fb:ae56 with SMTP id
 5614622812f47-57a0ab2d70fmr29848553b6e.34.1795828587269; Fri, 27 Nov 2026
 17:16:27 -0800 (PST)
Received: from 968777710935 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Nov 2026 20:16:26 -0500
From: Chenyang Yu <yuqwerty123a@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 27 Nov 2026 20:16:26 -0500
X-Gm-Features: Aa3M54qrHo6Jaw9Cpb-IZQafwPQlp-SvlrLs2D75RZWuMCPZGNxcGUVQM_cbxKU
Message-ID: <CAGV7iNjs2oYKh0eGrp=7XP+__c2XjjDQMd5gHmUcm=86uzCuCg@mail.gmail.com>
Subject: [BUG] virt: geniezone: unimplemented GZVM_IRQFD_FLAG_RESAMPLE and
 dropped GZVM_IOEVENTFD MMIO notifications stall SMP Linux guests on mt6991
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang <ze-yu.wang@mediatek.com>, 
	Liju Chen <liju-clr.chen@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, crosvm-dev@chromium.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Yingshiuan, Ze-Yu, Liju, MediaTek GenieZone and Android/crosvm teams,

We are reporting two critical virtualization bugs in MediaTek's GenieZone
driver (drivers/virt/geniezone/) and EL2 hypervisor observed on production
mt6991 (Dimensity 9400) hardware running Android 16 / ACK 6.6.118 with AVF
crosvm and an unmodified Debian 13 ARM64 guest (Linux 6.12.118, 8 vCPUs).

Hardware & Software Versions:
- SoC / Device : MediaTek Dimensity 9400 (mt6991), OPPO Find X8 (PKB110)
- Android Build: Android 16 (API 36), PKB110_16.0.8.300(CN01)
- Host Kernel  : 6.6.118-android15-8-gebdfad32d749-ab15099304-4k SMP PREEMPT
- VMM          : Android 16 com.android.virt crosvm (ab13197479)
- Guest Kernel : Debian 6.12.118+deb13-cloud-arm64 (8 vCPUs, 4 GiB RAM)

========================================================================
Bug 1: GZVM_IRQFD_FLAG_RESAMPLE is accepted by gzvm_irqfd() but never
       implemented, stalling level-triggered virtio-pci INTx queues
========================================================================

In drivers/virt/geniezone/gzvm_irqfd.c:

1. gzvm_irqfd() explicitly accepts GZVM_IRQFD_FLAG_RESAMPLE:

       if (args->flags &
           ~(GZVM_IRQFD_FLAG_DEASSIGN | GZVM_IRQFD_FLAG_RESAMPLE))
           return -EINVAL;

2. However, gzvm_irqfd_assign() completely ignores args->flags and
   args->resamplefd. No resample eventfd_ctx is acquired, no
   gzvm_irq_ack_notifier is registered, and gzvm_notify_acked_irq() is
   not wired to guest VGIC EOI from EL2.

Impact on VMMs (crosvm):
Because GenieZone does not provide virtual GICv3 ITS (no MSI-X), crosvm
falls back to legacy PCI INTx (IRQ_TYPE_LEVEL_HIGH on GICv3 SPIs 36..41)
and registers GZVM_IRQFD with GZVM_IRQFD_FLAG_RESAMPLE. When register_irqfd
succeeds, crosvm assumes level resampling works (async_intr_status = false
in devices/src/virtio/interrupt.rs) and suppresses further irqfd triggers
whenever interrupt_status.fetch_or(mask) != 0, relying on resamplefd to
re-inject if interrupt_status != 0 upon guest EOI.

Whenever a host virtqueue completion races with the guest window between
reading/clearing the VirtIO PCI ISR byte and writing ICC_EOIR1_EL1,
interrupt_status transitions back to 1, no resample event ever arrives
after EOI, and all subsequent interrupts for that PCI device are
permanently suppressed.

Workaround confirmation:
Rewriting /pci/interrupt-map SPI trigger flags in the UEFI FDT from 0x4
(level-high) to 0x1 (edge-rising) prior to booting Linux completely
prevents this stall class.

Expected fix:
Either wire args->resamplefd end-to-end with EL2 VGIC EOI resampling (and
deassert the virtual SPI line prior to signaling resamplefd), or reject
GZVM_IRQFD_FLAG_RESAMPLE with -EINVAL until EL2 support is present (and
avoid pairing IRQ_TYPE_LEVEL_HIGH INTx with async_intr_status = false in
crosvm when resampling is unavailable).

(Note: while inspecting gzvm_vcpu.c and gzvm_irqchip_inject_irq(), we also
noticed gzvm_vcpu_wakeup_all() unconditionally wakes all GZVM_MAX_VCPUS
threads on every SPI injection and per-vCPU gzvm_vtimer expiry rather than
waking only the target vCPU(s), causing 7x redundant host context switches.)

========================================================================
Bug 2: Dropped GZVM_IOEVENTFD MMIO doorbell writes permanently wedge
       VIRTIO_RING_F_EVENT_IDX virtqueues
========================================================================

Even with PCI SPIs patched to edge-triggered, guests intermittently hang
due to lost Guest-to-Host ioeventfd notifications when executing
vp_notify():

    dmb  oshst
    strh w0, [x1]   // 16-bit MMIO store to VirtIO-PCI Notify BAR

where crosvm registered the queue's notify address via GZVM_IOEVENTFD
with len = 0 (wildcard length/datamatch).

Case A - Live /proc/kcore proof on virtio-blk (guest IRQs enabled):
During normal multi-process file I/O over SSH, fdatasync/fsync/writeback
tasks hung in TASK_UNINTERRUPTIBLE (rq_qos_wait <- wbt_wait), while
hctx0..6 were idle (active = 0) and virtio-vsock (SSH) remained live.
/sys/kernel/debug/block/vda/hctx7/busy showed 2 requests stuck in_flight
(tag=54 READ, tag=55 WRITE) on vCPU 7.

Reading struct vring_virtqueue for virtio3 vq[7] live from /proc/kcore:

    vring.num               = 256
    event (F_EVENT_IDX)     = 1
    num_added               = 0
    avail_idx_shadow        = 561
    vring.avail->idx        = 561
    vring.avail->used_event = 558
    vring.used->idx         = 558
    vring.used->avail_event = 558
    last_used_idx           = 558

1. last_used_idx == used->idx == 558: the guest processed all completions
   written by the host; no host->guest interrupt was lost.
2. used->avail_event == 558: the host [virtio_blk] worker last consumed
   entry 557, published avail_event = 558, and slept on epoll_wait.
3. On submission 558 -> 559 (num_added = 1), virtqueue_kick_prepare()
   computed (u16)(559 - 558 - 1) < 1 (true), cleared num_added = 0, and
   executed vp_notify() (strh of 7 to GPA 0x2c01b01c) in normal task
   context with guest IRQs enabled, advancing guest PC past strh. However,
   the host eventfd was never signaled.
4. Subsequent submissions 559 -> 560 and 560 -> 561 observed
   avail_event == 558, evaluated vring_need_event() == false, and did not
   re-notify, leaving vq[7] permanently wedged.

Case B - 4-vCPU hard lockup on virtio-console hvc0 (guest IRQs disabled):
The same dropped GZVM_IOEVENTFD write hits virtio-console (hvc0, out_vq
GPA 0x2c003004) during boot log floods or interactive console echo.
Because Linux's put_chars() -> __send_to_port(..., in_nonblock=false)
submits 1 buffer at a time (needs_kick is unconditionally true) and spins
with local IRQs disabled at:

    while (!virtqueue_get_buf(out_vq, &len) && !virtqueue_is_broken(out_vq))
        cpu_relax();

while holding port->outvq_lock, a single lost 0x2c003004 kick locks up
4 vCPUs at 100% host stime (outvq_lock holder + hp->lock waiter + RCU
stall console_owner + hardlockup detector console_waiter), while host
[v_console] remains asleep in WaitContext::wait() (verified live: sending
RX input 15 minutes after the hang still woke [v_console] on in_avail_evt,
incrementing voluntary_ctxt_switches from 844 to 847, proving the worker
was not blocked on host pipe output and never received transmitq's
ioeventfd signal).

Suspected EL2 / gzvm_vcpu_run() boundary to audit:
In drivers/virt/geniezone/gzvm_vcpu.c:

    while (!need_userspace && !signal_pending(current)) {
        gzvm_arch_vcpu_run(vcpu, &exit_reason);
        switch (exit_reason) {
        case GZVM_EXIT_MMIO:
            if (!gzvm_vcpu_handle_mmio(vcpu))
                need_userspace = true;
            break;
        ...
        case GZVM_EXIT_IRQ:
        case GZVM_EXIT_GZ:
            break;

If gzvm_vcpu_handle_mmio() had returned false, need_userspace = true would
have exited to crosvm, where VirtioPciDevice::write_bar() has a userspace
fallback (evt.event.signal()). Because neither gzvm_ioevent_write() nor
the userspace fallback signaled the eventfd while guest ELR_EL1 advanced
past strh w0, [x1], please audit EL2's Stage-2 MMIO abort handling under
concurrent physical IRQ / MT_HVC_GZVM_IRQ_LINE exits to ensure an in-flight
MMIO trap that has already incremented ELR_EL1 cannot have its exit_reason
overwritten by GZVM_EXIT_IRQ / GZVM_EXIT_GZ before EL1 processes
GZVM_EXIT_MMIO.

Best regards,
Chenyang Yu
