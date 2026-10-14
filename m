Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C74F7CBB
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979021; cv=none; b=hdz9BRsgb7QU0vdk1qYx/l+EaBjv5Qo/maXQ2zL2x3MKif3Qegzp/JzCZ9xG8IvUTg8W56VVhnhAr8dTXuutBjWJ3jE/Ddknmvz5JBCyN0v1lNjP/820+9rKNela7CHgL0x8rngfpCy8vOyja2+QK+J4Dmqde5jBAtZ+BxAem/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979021; c=relaxed/simple;
	bh=Kmj3gvNqcRWiUzi3p2e9onO7+W4cGn1ZTReiUZtg+1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r2YmMQt+8oiTrLnl/PI91Mws2osxRLfx1KVZLotUT+J5nMJXwtwqGeYuI59QIqWi95AZ+BMkrvkrW/uVbtD6gCCcMHwmhm+hJqsBnLsiy8beyLpCRdx/s6cBQ9QhD8ke2eSZPgqV9Xy2hOWeIAaN7hSL17H2+3j5baAQkE8J69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oD1RRGKo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD1RRGKo"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso172908a91.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791979015; x=1792583815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rr15BCmVfnFuCQIk5ywGtZF7ygFb9rIIxjBp0T94jf8=;
        b=oD1RRGKoj4S9g/fCe0B7WrkC6oZBtem+vavX6uCeljsCk1kYIIW/lFrEnLMTSbEtTt
         f6D4mHq+flq38jio4DYIyd9LIS5xoFQqvpXXfcW3iCUFTZHUdRU1Hq6giCojYIK2aH4W
         pj2E5wMOkUfde4Vgoi0rTQRMffXvuVvkqdAIlgpueCA1WRBVQDs6mwM6GjArAmXdvOTa
         kOuuw/zWU3jOznZvimQ1v3fM64VLhwqq/1umdv90kPLuhs24im5HSNt7z5kyzCj6XEyr
         43lAXFyMimjzc0a/WU3svcsmpCCQulTMneKqx+fZgIaJOZcEUtG5zTDT2VwWjaea8HWH
         izWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979015; x=1792583815;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rr15BCmVfnFuCQIk5ywGtZF7ygFb9rIIxjBp0T94jf8=;
        b=MW3y1+fZJBI51fDocnOyVmLx3nI3zi0vs4+w8eA8VgivvPycv4nBjWqsnToq5kF7iR
         XTf+vaaPdhBpcp5QE3JfsQLcPaTx6RL2Ya+m4VZ/8acwLp8coQtEULlUiRZEeT+D+/fO
         DddnF6qA5EPcS783WAraNGSICpushxzc4qvKMDQbPwdF94dRvDRTfovk1EPfcV43Ze2p
         feAHg/yCD/MsRU1vQTLCwXJAucQfct5F4MfqncwANPVdI9j5cimQR4hXdiXUBa03T78+
         m4a7JB/ouRxW9x5nLSGcqkDnZjVFhQFpWX5pQi9Prk0N1bhyGj0Vtxt9fZN6h6W7jxwh
         vHfg==
X-Forwarded-Encrypted: i=1; AKwUvBxgEKdM2/HMEuDRtmwml0MmMkRLk+5xo3Kf2Qi1QtFYnBaZPEhbiYjv1VFImYDrc1X7fec=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyJLUlFHc8dw5fKkJl3kYhfJNf+DFTqJg9yWicdLBtrxxnlJzj
	TNJEpJ0N9xP6cfES5dmdKtnca6+Ihy7/KkZSv7QFSI16Uc/oIeIy/pP/
X-Gm-Gg: AYBFou2pY9HfAU3cOgV4mfFAbxdQqoMYHGNfvV+VCU/hnYMab1oTLbWUhgNZ1vCXaiA
	3kf+2l2b3QuMxEWFP+LNYRTEE663p5C7BhCmnwg1qr0IzPuQY1dD56ZLGCLCNe3KxZCQ7S5ht37
	3pR9NA2e14YJ03XpXFONFJ8U7kr/eMktgAfidHrcJ2YdGUp/IffwgOVa5aOHalMVbr1QGa9FBqe
	7DvUiXcL5e7anFJGfuCCXkC0RMaro0MV5SP1VzUx99h9BIJhjRcLjME8kNsnwFQgiOxMqoY47s4
	5bILkW/ieeT1//tALmNkUJFVE40ocjIXt7lzDfiCRYccuyYTwq46ys0ynVXyWeWs8YzBObsurJQ
	oswO3PYlLudGrPeQIJGWmyjPV7sXwbSlFwN4F/ZoKX+qJAzkUlb9g2gmpGYHPnc9ZDx1ngUmWVI
	nrYtpSn2cQnNmQW3fWd7cbIuQ7I/zZKGJ2NF6YI2qgY+mqTlAc/lma996rNW3kFBjH4jrdDA==
X-Received: by 2002:a17:90b:2d06:b0:3a4:b8dd:1447 with SMTP id 98e67ed59e1d1-3ab3ac9fb08mr11499072a91.34.1791979015001;
        Wed, 14 Oct 2026 04:56:55 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm4795691a91.7.2026.10.14.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:56:54 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@gmail.com
Subject: [PATCH net-next v4 0/4] vsock/virtio: reduce RX per-packet socket overhead
Date: Wed, 14 Oct 2026 19:56:36 +0800
Message-Id: <20261014115640.184286-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series reduces per-packet socket overhead in the virtio-vsock RX
worker.

Patch 1: separate socket lookup from locked packet processing.

Patch 2: keep one socket lock across a bounded run of established
STREAM/RW packets for the same native socket, and reuse the locked socket
for later same-flow packets.

Patch 3: coalesce default write-space notifications while that
lock is held.

Patch 4: defer the default readable callback until after the batch
unlocks.

Performance:

Tested on a single-stream vsock connection (one Guest receiver thread on
CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state, 16
balanced AB/BA pairs per payload). The host uses vhost-vsock.

For throughput, vsock_perf runs on the host as the
sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
table uses the sender's request size. The virtio-vsock IRQ/RX worker is
pinned to Guest CPU1. To normalize run times across payloads into a
bounded, deterministic window and avoid long runs being skewed by host
background noise or virtualization scheduling jitter, transfer sizes scale
proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
2G for 4K–64K. The custom receiver keeps the recv() size and count
explicit; vsock_perf's receiver uses poll()+read().

Latency uses a custom user-space vsock ping-pong tool.

The measurements below were collected for the RX batching series.

This benchmark does not run vsock_perf on both ends. Instead, it uses
vsock_perf as the sender on the host (vhost-vsock) side and a custom
blocking recv() program without poll() on the Guest side, with the receiver
thread pinned to Guest CPU0 (and the virtio-vsock RX worker pinned to Guest
CPU1). Plain blocking recv() combined with strict core pinning gives
audit-level determinism for tracing a single-threaded TID.

I think it is necessary to do further testing on the large I/O throughput
peak observed at 4K to find the root cause (and rule out anything
introduced by the measurement method). I used kprobe and temporary
trace_printk in the source for mechanism diagnostics. The diagnostic
data shows that lock wait time and contention at 4K both decrease strictly
monotonically as payload size increases;
wire-level tracing also confirms that 4K is split into two packets, and
that all sizes can reach the 64K batching limit.

The nature of the prominent 4K throughput gain most likely lies in it
sitting exactly at the end-to-end pipeline sweet spot between host and
guest:

Compared with 1K and smaller payloads: 4K halves the packet intensity, so
upstream host-side syscall and interrupt injection overhead is no longer
the bottleneck across the whole path, allowing the host to supply data
adequately.

Compared with larger 8K to 64K payloads: 4K keeps the payload size
moderate, and combined with the observed syscall reduction and cycle
improvement, the batch-draining benefit from notification coalescing is
fully realized.

As payload size increases further from 8K to 64K, the overall gain shrinks
smoothly, consistent with Amdahl's law, because system execution time
shifts toward page copying and VQ processing.

With all patches applied:

End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B      0.1065       0.2503    +135.00% [+130.35%, +139.74%]
  256B     0.5722       1.0286     +79.76% [+75.40%, +84.23%]
  512B     1.1464       1.9779     +72.53% [+69.50%, +75.63%]
  1K       2.2714       3.6368     +60.12% [+56.92%, +63.37%]
  4K       3.9095       7.7160     +97.37% [+92.09%, +102.79%]
  8K       3.3436       5.3111     +58.84% [+53.49%, +64.38%]
  16K      3.8876       5.7456     +47.80% [+45.45%, +50.18%]
  64K      4.0056       5.3590     +33.79% [+29.37%, +38.36%]

Fixed-syscall stress test (receiver recv() size = sender write size;
Gbit/s):

  payload baseline PATCH    throughput change (95% CI)    recv()
          RX       RX                                     (base/patch)
          (Gbit/s) (Gbit/s)
  64B     0.1259   0.2651   +110.52% [+99.08%, +122.62%]  1048577/1048577
  256B    0.3790   0.9444   +149.20% [+134.70%, +164.60%] 1048577/1048577
  512B    0.7768   1.7009   +118.97% [+103.94%, +135.11%] 1048577/1048577
  1K      1.4886   2.9477   +98.02% [+84.82%, +112.17%]   1048577/1048577
  4K      2.1129   4.7331   +124.01% [+115.40%, +132.96%] 537436/525524
  8K      2.8698   5.3683   +87.06% [+80.96%, +93.37%]    276448/264109
  16K     3.5156   5.8463   +66.30% [+63.10%, +69.55%]    147849/132267
  64K     4.2459   5.8576   +37.96% [+35.26%, +40.71%]    48447/33144

Request-response latency (Ping-Pong RTT, 10,000 requests):

  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
  64B      221.968                  218.144              -1.72%
                                                        [-4.23%, +0.85%]
  256B     126.968                  124.541              -1.91%
                                                        [-3.35%, -0.45%]
  4K       130.362                  126.664              -2.84%
                                                        [-5.12%, -0.50%]

Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B      62.032            52.370          -15.58% [-17.16%, -13.96%]
  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]
  8K        1.504             1.363           -9.36% [-12.97%, -5.60%]
  16K       1.321             1.210           -8.37% [-10.61%, -6.07%]
  64K       1.342             1.227           -8.57% [-10.87%, -6.21%]

Patch-scope measurements and attribution:

The series was tested cumulatively in two ranges, using the same
single-stream setup and paired AB/BA runs. The table below shows results
from patches 1–2 only, before the notification changes in patches 3–4.

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B      0.1211       0.2534    +109.26% [+106.34%, +112.23%]
  256B     0.5671       0.9989     +76.15% [+70.63%, +81.85%]
  512B     1.1334       1.9000     +67.64% [+64.64%, +70.69%]
  1K       2.2650       3.5610     +57.22% [+50.91%, +63.79%]
  4K       3.8331       7.2888     +90.15% [+83.46%, +97.09%]
  8K       4.8244       7.6636     +58.85% [+53.71%, +64.16%]
  16K      5.4979       8.2469     +50.00% [+45.57%, +54.57%]
  64K      3.8875       4.7588     +22.41% [+17.77%, +27.24%]

Fixed-syscall stress test (receiver recv() size = sender write size;
no perf; Gbit/s):

  payload baseline PATCH    throughput change (95% CI)    recv()
          RX       RX                                     (base/patch)
          (Gbit/s) (Gbit/s)
  64B     0.1397   0.2646   +89.40% [+80.92%, +98.27%]    1048577/1048577
  256B    0.3960   0.9516   +140.34% [+117.48%, +165.60%] 1048577/1048577
  512B    0.7541   1.6496   +118.74% [+101.42%, +137.55%] 1048577/1048577
  1K      1.4903   2.8793   +93.21% [+77.06%, +110.82%]   1048577/1048577
  4K      2.9466   6.2284   +111.37% [+97.52%, +126.20%]  538192/525220
  8K      4.0043   6.9249   +72.94% [+60.18%, +86.71%]    276313/263852
  16K     4.8981   7.5599   +54.34% [+49.77%, +59.06%]    147576/131600
  64K     5.9294   7.7897   +31.37% [+27.18%, +35.70%]    50207/33014

Ping-Pong RTT (10,000 requests; no perf):

  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
  64B      119.688                  119.739              +0.04%
                                                        [-2.61%, +2.77%]
  256B     120.603                  124.485              +3.22%
                                                        [-0.44%, +7.01%]
  4K       121.921                  122.491              +0.47%
                                                        [-3.51%, +4.61%]

Guest CPU1 system-wide aggregate cycles (fixed-64K receiver, with perf;
cycles/byte):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B      66.838             60.012           -10.21% [-13.03%, -7.30%]
  256B     13.446             12.305            -8.49% [-11.23%, -5.66%]
  512B      6.833              6.317            -7.54% [ -9.52%, -5.52%]
  1K        3.558              3.434            -3.48% [ -6.02%, -0.87%]
  4K        1.806              1.686            -6.64% [ -8.69%, -4.54%]
  8K        1.457              1.403            -3.73% [ -5.64%, -1.78%]
  16K       1.295              1.279            -1.24% [ -5.21%, +2.89%]
  64K       1.214              1.198            -1.30% [ -4.06%, +1.53%]

The split-patch tests show that PATCH 2 mainly contributes to the
improvement in I/O Throughput, while PATCH 3 and PATCH 4 mainly contribute
to the improvements in cycles and RTT latency (although PATCH 2 shows no
obvious regression here).

---
v4:
  - use only the connected socket lookup for batch admission and return
    misses to the normal receive path
  - read packet-specific addresses from the skb in the locked receive
    helper and use the matched socket namespace for reset replies
  - remove the extra address and network namespace arguments from the
    locked receive helper
v3:
  - restrict RX batching to sockets using the original protocol and
    data-ready/write-space callbacks
  - exclude sockets carrying the psock marker published before sockmap
    protocol/callback replacement, and recheck it at each packet boundary
  - preserve existing sockmap update return values; an attach racing a
    native batch makes the next packet end the batch without queued-skb
    handoff
  - remove a leftover blank line after an opening brace
  - remove callback handoff work and attach/detach kicks, preserving the
    existing per-packet behavior for sockmap and other non-native sockets
  - avoid making this series drain queued or partially consumed skbs when a
    socket is added to or removed from a sockmap
  - clarify that Patch 1 prepares for batching and intends no functional
    change
  - inline address decoding and receive tracing, simplify the socket lookup
    helper, and pass locked receive arguments directly
  - fold same-flow lookup reuse into Patch 2 and match packets against the
    locked socket state, reducing the series from five patches to four
v2:
  - stop a batch after it consumes the last skb metadata slot, sharing the
    admission predicate with virtio_transport_inc_rx_pkt()
  - move replacement-callback handoff into vsock, process queued skbs one
    at a time, and trigger the handoff from vsock_bpf_update_proto() on
    attach and detach
  - reduce the packet-context diff in the locked receive helper
  - keep RX batch counters in the batch state and reset them in the finish
    path
  - use the vsock/virtio subject prefix and add the requested measurements
v1: https://lore.kernel.org/virtualization/20261002074551.318789-1-physicalmtea@gmail.com/

Jia Jia (4):
  vsock/virtio: split socket lookup from locked RX processing
  vsock/virtio: amortize RX socket locking for stream packets
  vsock/virtio: coalesce RX write-space notifications in lock batches
  vsock/virtio: defer RX notifications until batch unlock

 include/linux/virtio_vsock.h            |  13 ++
 include/net/af_vsock.h                  |   6 +
 net/vmw_vsock/af_vsock.c                |   2 +
 net/vmw_vsock/virtio_transport.c        |  29 ++-
 net/vmw_vsock/virtio_transport_common.c | 353 ++++++++++++++++++++++++++------
 5 files changed, 341 insertions(+), 62 deletions(-)

base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.53.0
