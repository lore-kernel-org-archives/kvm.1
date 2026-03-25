Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF03EAC9C
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460169; cv=none; b=bvjxJYJIvk3EmnZQ0UsXYJ79AS2jTMYorvhArakFLHBa4pCZtesEFadCnDV1MytNY/A0DVm6eYRllV1xgpkdox/Y/WzfTKnu/z+vAkcvCBkG/hJdRKYxFf9kYKHD5Sx+iHqztAT7vxisiGS4vMZldPVo/WM6uKCjXkFzY4ZJDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460169; c=relaxed/simple;
	bh=+l0jUlugqhIlozPsvvUqrOGD8ObMwPDCrB1hnJ/l/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZQYJteWHNxu1RpRqTmbX5C5jzNtC0DbRRZHWGQMnoKEifu27URAl4Q8+JfbSJNLnAm007Of9a/9y+/DX26a8d8WSduSB2uvPl8KN2KCAkd6GCFCQUiR9awpg1QcKecy5CO6dLp/Ems4mA9KzJ7sl8cL5URQqgJYNN8gR0iSkfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVDVadCE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNA9twOx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVDVadCE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNA9twOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774460167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aknMUZi4Ykd1vZCSThVfLFs375oMsxp6htHuyPpwggE=;
	b=YVDVadCEPgRJF1aYI+39LphZ+QY+QI7uRefEdl2l41JH2r/TMP5Zf2/QLpqvjJtHngLB5R
	Hj1R1klI9lNZgeWu6lDjuTzfdexvmer4rT1aBQwX+EPZlruTP47LO3drakGxHMMoHJfIkY
	gN8zg+9XwCs1sLQY+lxYcGWt1doXiYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-0i5roUccNsW8rUdwftuENg-1; Wed, 25 Mar 2026 13:36:05 -0400
X-MC-Unique: 0i5roUccNsW8rUdwftuENg-1
X-Mimecast-MFC-AGG-ID: 0i5roUccNsW8rUdwftuENg_1774460164
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso1153075e9.3
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774460164; x=1775064964; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aknMUZi4Ykd1vZCSThVfLFs375oMsxp6htHuyPpwggE=;
        b=aNA9twOxrf/aUhL5JPMpdhUiqc32srNyG2XeadwlezAG0chai0b+kewoiW/AhbMdi8
         HdMRf1w63GO9sohMannMUvObix0Z5oylvllvnD29j0Wry+M3re+Rk+IDcWkO39oFR4o6
         1H/WC5wdG65sSOoRYspcWGvfihet+90vLhSPjp4kSVGnQ43mFuIgrQtyLjinFSMafU3w
         rFFPd3TEReZmo/hO6XngxWrjSw2cC/lRAeljw5XBAa2gMJgHkeL6nBFWP4EXTHQjAzop
         j7rln8c9Hdb0WN2Aj0pXMUvwkQcSm+sDaNzpFoxnWW/pUsZw8dZzKD7Wn06IOb90oSe3
         tu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460164; x=1775064964;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aknMUZi4Ykd1vZCSThVfLFs375oMsxp6htHuyPpwggE=;
        b=Gv+I/YFaf8xnUR2XzrmJZ5TAFb1eK5cVo4KPW6B5cgLiwigd6EgJonvLtEaGkMWGAB
         0mbNo1WD21JjWH83Nux1JY70xNpzA4RYh7sR1wTwjsClyQTeTL1kIvVcyhZBcOvMhP8e
         9hMIkhILUK4hcC9EnRPjnq6ki38zUbs1y09StV+c291Zcmo8KcOTyv74/giMUQxnm/+G
         7ORxQa+CtLxG+acSwY4YKFkHSJUDf3nSWTaUP8ZbJOrF1k/7VINbSnXbnEh+9f/VckOO
         TKq4SV28gdQ31zJQb+5YlxXVdIOUfZt6/hiy5X90uigtMISe/3mPPPSNOW3TnpXmZYuY
         V5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVtASKIXF4fNQfuTAJiz3e9rSeqUVpT8n5iETpO/JLOuq2gjMqEpVoex14j/Q0wDvXG5Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR33GWj26RFJNBuUmzxXhHoW+JYLF/2KniNGFyi6KieatZ2eKv
	xTKArTT3Gk7vkKeWkRlMCcvQZxoL3y6ZGDPF6/UBMAH/y9DyrtOU+78nX0765gQ4hiy6+YZlhUH
	2bpjI3uVQKUsFyykASTHY8+8yIwZftkc3rr2DRGwTJSOoIXau+XKpXA==
X-Gm-Gg: ATEYQzyFPqWnDbW7Zrw5rqdvAZ83WDvHGhboTJzSZ43q2Hcte14iblGLzXQix6NmB1o
	8p4FQmKaDXcvlbx9ueyt7NM8UOqiFDdNlR+esOdgE/kMXwh44kmjAcH4MqP3rMfW4724yHFBQ+V
	YCih0zjUwwhml+lQ2P4DCusvlBtYH8PSuqfOVsn/Yug532NHOZKa6VVvsuNGboRprU+fEW4FfvX
	U6drcMxPxs1WgstrE3njgdAR681lxgbOHDcIEfFyNgQJLIKGEOLyNWLCe0im3DNOsVLOcKqtzFj
	lDsukoZJyrcjPGWaPGcAe4+y4cyIUa8FmQTZJC/W/7M3MJRHAZ+kxkUhiNi9HmKY8LZBxq+QT9P
	YtP+2HC6fKGmfF/s1
X-Received: by 2002:a05:600c:3b12:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-4871606dc4fmr68223405e9.26.1774460164111;
        Wed, 25 Mar 2026 10:36:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3b12:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-4871606dc4fmr68222725e9.26.1774460163566;
        Wed, 25 Mar 2026 10:36:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487166064fasm27148915e9.7.2026.03.25.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:36:03 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:36:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org, Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 net] ptr_ring: disable KCSAN warnings
Message-ID: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Eric Dumazet reported KCSAN warnings:

BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
__ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
__ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
__ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
__skb_array_consume include/linux/skb_array.h:98 [inline]
pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
dequeue_skb net/sched/sch_generic.c:297 [inline]
qdisc_restart net/sched/sch_generic.c:402 [inline]
__qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
qdisc_run include/net/pkt_sched.h:120 [inline]
net_tx_action+0x379/0x590 net/core/dev.c:5793
handle_softirqs+0xb9/0x280 kernel/softirq.c:622
do_softirq+0x45/0x60 kernel/softirq.c:523
__local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
local_bh_enable include/linux/bottom_half.h:33 [inline]
bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
__ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
skb_array_produce include/linux/skb_array.h:44 [inline]
pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
dev_qdisc_enqueue net/core/dev.c:4144 [inline]
__dev_xmit_skb net/core/dev.c:4188 [inline]
__dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
dev_queue_xmit include/linux/netdevice.h:3384 [inline]
__bpf_tx_skb net/core/filter.c:2153 [inline]
__bpf_redirect_common net/core/filter.c:2197 [inline]
__bpf_redirect+0x862/0x990 net/core/filter.c:2204
____bpf_clone_redirect net/core/filter.c:2487 [inline]
bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
bpf_prog_53f18857bc887b09+0x22/0x2a
bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
__bpf_prog_run include/linux/filter.h:723 [inline]
bpf_prog_run include/linux/filter.h:730 [inline]
bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
PREEMPT(full)
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/24/2026

There is no race on ring accesses: reading/writing a partial pointer
would be fine, because the reading is done by the producer
which merely cares about NULL/non NULL.
Document and disable the warnings using data_race().

Tested-by: Opus Sonnet 4.6 1M window.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	two more places, commit log tweak

 include/linux/ptr_ring.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 534531807d95..d2c3629bbe45 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -48,7 +48,7 @@ struct ptr_ring {
  */
 static inline bool __ptr_ring_full(struct ptr_ring *r)
 {
-	return r->queue[r->producer];
+	return data_race(r->queue[r->producer]);
 }
 
 static inline bool ptr_ring_full(struct ptr_ring *r)
@@ -103,7 +103,7 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
+	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
 		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
@@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
 static inline bool __ptr_ring_empty(struct ptr_ring *r)
 {
 	if (likely(r->size))
-		return !r->queue[READ_ONCE(r->consumer_head)];
+		return !data_race(r->queue[READ_ONCE(r->consumer_head)]);
 	return true;
 }
 
@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
 	 * besides the first one until we write out all entries.
 	 */
 	while (likely(head > r->consumer_tail))
-		r->queue[--head] = NULL;
+		data_race(r->queue[--head] = NULL);
 
 	r->consumer_tail = consumer_head;
 }
-- 
MST

