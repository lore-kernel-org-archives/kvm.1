Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36793382CF
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495039; cv=pass; b=dRqzOvK7FmV3OHObScqt5z3s1Y0bEV5QoUgVf6VjgZ4nyR6u2/JhilgzabvBMvizPKAvqDUbp6z9YUIh2BK1F8TIBmxJ+FwC4HWNWEiEiVBENGJo2z8SJnni/rhE+1EwfIPXEHrgCn11SOQjpYCv3qUT6qv0mSsRM4jSatOcGDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495039; c=relaxed/simple;
	bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgOE+DtSgELhNiDruwNQS8GFRa9raJKDzhbkXYL3B6KS8oJ1rz3SHkSUnZKJPSeobxe2CUmM25pwtEgBHT/pRZ22eqnq23YNrDnSzu4Yk4Ou17n+fUC0bXvvEn2O7TiIZGI+52AFTsymTIFGuJqRyV/0WDlreYBz9qgGKLNmrh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2F/rr/d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=drTwl0nY; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2F/rr/d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="drTwl0nY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774495037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
	b=c2F/rr/dQYUu0JJ2/2YYFuXtudfXATHa0sZVAVHuCZIiBM//okYwIeYCvYWBfwuovyEJv0
	vjvqt4nnzugkwCeE056C/nBg4cobu0n7tfVQ7dYRUrWnAz72AVtZgOdeuqpkbYrAsglwrI
	XxHV9U39Nmf3TFtygAYltnNwUZWf7lY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-N4zQ4dPZMxiJGWnIZSNIZA-1; Wed, 25 Mar 2026 23:17:15 -0400
X-MC-Unique: N4zQ4dPZMxiJGWnIZSNIZA-1
X-Mimecast-MFC-AGG-ID: N4zQ4dPZMxiJGWnIZSNIZA_1774495034
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aeb90532f6so6110465ad.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 20:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774495034; cv=none;
        d=google.com; s=arc-20240605;
        b=M1P33/dnWKZIPmUBLXoIP8A0cdn3waRfWQ1EWFicA7BWU4J9lw2NkkmnnyOICN3udR
         hfzukzoMDOZEE9hFiYvTG2O5PWAeaVOQxloZ4u8usr6JBqQ+gMYDcAmrpTo8SOmVcfiB
         UEqDh0deGfU1uA8/os/z+Z9GlTVaqQs5LpqapZz9jNWZXAWyhmQ6+fGqk0IJOJ5JXOYY
         ysF1DCejID5XyAQqbGi63L+3VxPQPdBT68UfEzRC41BYiQLIp8O8qpONcUpV5a8+kxgx
         e1N0Wwhq41mbTpA29tRpZRik/3wScTL25KFoMyH+hVjLEaIGjZVsQ3uHR/bx01rjr+nV
         CLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
        fh=kn2Cgn690xk3rQGlnrSUPA0x+Tje2RMKto1rbqkpvVI=;
        b=DBYEzTFDcTJc8GvoBIPIjRBBMCMABX1edaR8wIwnqZdM04uoZIEixIQhTXKmPKvj9i
         i9yumXi33doklu30Q+/pFyr6klprb++EsNEI46MEYmvCbcMtPYMIqpco/c9Fq7lesQHq
         3bAq48A68uZuQXqhu+VbPTfhwS+Q4nnkKsbe6OPyKtYfjcRAAnpSKFMvSQ+4IFSR0xRe
         DwibkybWtKrOPYjJKCwLxe/ZMBAaeLGpx1yQwcd0Y/3BYGH9auZp2/VwNzI1EiM4WSIP
         2CzcCPhtyTPzxx8R7l8Q7m8kipieZa6dzG5wOXNclYTj3g6zv0/W9pERh4qEuYuQp3tA
         Vkcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774495034; x=1775099834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
        b=drTwl0nY/Sg9TTmJm2Z/Q6h8WD9tprBQE+BqneWaLE1y64j5+CbVNcyM/1BR+thtYh
         QTpHovR8Iy1VjV7hrWF18abB38ejNNMFgwJlCFLjyj/ZACDgAAF17Gco2ZhL35Q1LDpW
         HzZVPlTGqVB48LCNFU+Ey0pie0gNmu0nDVkIHENPMDUiT4+3kNzRqUwfLX1QzKvdUp3z
         IXFV0hE8s7M5FQEog6qJY4HwTWnqkF015b5frV60B8ka/FLAcRfWL/GSFgnkufxINwXu
         U5w4CKtGUU/Mba9cgPgJ9RdM8SxbyA/sbPlLOLN2ZVucBtwVRQ/aoeQHdN5F2xHPvwCW
         K/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495034; x=1775099834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
        b=qV19y4cLhFdRT4pcRVECw7prFSd65i3qT3uVbOxiER/6KORe5D6OroZ5FJTkwBUrm9
         Q3ixtg9rjuZ7g5mrrvJ7EtQjNBc6GtDzCdKt0DwOy3Tjtxlzp1HYwSDrFUgGASBsOFmB
         1UuP9UldfwQrprCWT9DY+8v6xPEoPBYzKlCWbz0smdU+PweekiIjJCec5UXrNgQSRgOS
         qLkEcORoa5cU8rH8+T6Nm4dwbRGDiRK2cJiaib/a61Jzn9Gv3nmM5PJOsnybY/IWVJr4
         2kKIKqaQ2777omqBXsbN+YcVc0uqY7Mzws0l8eyLLbU+3BzrVVJHMZ5/EEVINsOo3FmM
         9sEg==
X-Forwarded-Encrypted: i=1; AJvYcCUbDm0nLTL1qZHYwO43oBwBYMfh1qNbAbBIuotw6KRzLrmPIMPymO9k5NWeFwM/cJwZUic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSAitQMD0m26Z5UoUdw2QvgTkCjQzoVxpuZN/R2xf4wqfh4yJ
	lk4nH+MJToYXMV74pKc57PNUo+ypwwtBppdW+Wg+Q1z6cJYwUCrPg8gUb5EtXmwP5t+S23A3CaX
	E5VfSTnu+1NZ+3v/EF5rAoGiR93zWtk4F0L24yOEnmwUJISg9mgnIeS/UoGGoafegP4dPkE8kgx
	odPBhQI/1gZbVv7QW+9Qn5BYQsFzx0
X-Gm-Gg: ATEYQzyspeMLC07ydeJvadof7VHclvzIG1jmyUaV4txDQKX0fqNkF/f358JAsJ7cqk1
	G78TN8CLlB8Ik67BdKmVny/bZt0yu1e5BpDyFXNSZa5ngEVHauhIIrdzJnsxDr2RRPg0l2S251u
	SjESo4KC7YxPn16ZWmY6le6v8QtXVXrkJcj9J17wIDd4ALXJfK6es8qcIuEUSPlQ2wCo9F0hAjF
	7tU
X-Received: by 2002:a05:6a21:998a:b0:39b:f9f5:7a4a with SMTP id adf61e73a8af0-39c4ae08a84mr6464209637.50.1774495034100;
        Wed, 25 Mar 2026 20:17:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:998a:b0:39b:f9f5:7a4a with SMTP id
 adf61e73a8af0-39c4ae08a84mr6464185637.50.1774495033612; Wed, 25 Mar 2026
 20:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
In-Reply-To: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 11:17:02 +0800
X-Gm-Features: AQROBzAarNEtZJEoyFy_DkMNrrDU5KBdW2pr9F5lbth0WTjJwR9jg3tFeGnbKuI
Message-ID: <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Eric Dumazet reported KCSAN warnings:
>
> BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue
>
> write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
> __ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
> __ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
> __ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
> __skb_array_consume include/linux/skb_array.h:98 [inline]
> pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
> dequeue_skb net/sched/sch_generic.c:297 [inline]
> qdisc_restart net/sched/sch_generic.c:402 [inline]
> __qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
> qdisc_run include/net/pkt_sched.h:120 [inline]
> net_tx_action+0x379/0x590 net/core/dev.c:5793
> handle_softirqs+0xb9/0x280 kernel/softirq.c:622
> do_softirq+0x45/0x60 kernel/softirq.c:523
> __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
> local_bh_enable include/linux/bottom_half.h:33 [inline]
> bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:3=
22
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
> __ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
> ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
> skb_array_produce include/linux/skb_array.h:44 [inline]
> pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
> dev_qdisc_enqueue net/core/dev.c:4144 [inline]
> __dev_xmit_skb net/core/dev.c:4188 [inline]
> __dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
> dev_queue_xmit include/linux/netdevice.h:3384 [inline]
> __bpf_tx_skb net/core/filter.c:2153 [inline]
> __bpf_redirect_common net/core/filter.c:2197 [inline]
> __bpf_redirect+0x862/0x990 net/core/filter.c:2204
> ____bpf_clone_redirect net/core/filter.c:2487 [inline]
> bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
> bpf_prog_53f18857bc887b09+0x22/0x2a
> bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
> __bpf_prog_run include/linux/filter.h:723 [inline]
> bpf_prog_run include/linux/filter.h:730 [inline]
> bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:3=
22
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff888104a93a00 -> 0x0000000000000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
> PREEMPT(full)
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/24/2026
>
> There is no race on ring accesses: reading/writing a partial pointer
> would be fine, because the reading is done by the producer
> which merely cares about NULL/non NULL.
> Document and disable the warnings using data_race().
>
> Tested-by: Opus Sonnet 4.6 1M window.
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

