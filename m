Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760844;
	b=YzCEb+pLbDpOZJ/GwQgmvTUPFwENa1agdfP+R7bo19bb6IVy5ZtaXBUyAGyYei4XXKGG
	 fOPijVrTauBWgRX+cOOfWHBndKqfWQz2bf5b8leNbF1h6jOt0HAQe5SRtZSmW8p2OrbVD
	 DbS9wGHr2mCzhPWmP5q5AMG7r+3eGqs+boAfqvTDpT9msw1LLSoRBewmYyf2w9wJ8w+Yt
	 0dHtdNBR4sUmOq/F/0m9viI2rg11PxyGt6x3UbNg5lNPq2VOM+VKBP1sZVb2IEIAnpQA6
	 aWWld9aXoAKynD2XAGmrBltQUKBgU3mDy2xD9VuchZ6seJgIZDRxK4S85R/Gxprj4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r8lJaPpRGy7TrFULAZGwfuDH5/Bcxre2ZiVQp9kvtDA=;
	b=JqK2iTCulfkpxqRNyzDrNyBTesginBJ26R9AiD51A9IzvN5MyrdkIM2MgZ8Y0rQPaL/T
	 H8JSLYO6aKJWBx/bCsZS4ItQ8SptxERlr2N8c66snPtzt5JWQzPBHEjNLHk3MFt84Z4uw
	 IB0VOoNnb3tGzHpuNv5wXjKBw1wdsIHjm9UJfhV65K6tEfhC0rqn7uU7GX0bhi00hheWt
	 GrNd2C6QFoWtyEthlPaENFkyfFr0xus/QXN+TQkRi9vrNjs0iSDHJjEhh1o0xRWtX0RlK
	 rhF0rEQcsoQxO89y2etxfR80UNWn/uwvYQHaZW7euZRM75mpPPmE8bPxavLlpB/Jfdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2wcE6NG;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C0606A323
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 06:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 096C0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2wcE6NG
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb9f760337so4238714a12.0
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 22:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795760843; x=1796365643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r8lJaPpRGy7TrFULAZGwfuDH5/Bcxre2ZiVQp9kvtDA=;
        b=h2wcE6NGOT6lcpof0NQ3QQvjDAEV3HVb/OX7qUM07T6ClyUGjfqItQxVv6xJuKfqma
         mcKXupf4E5BluokYklLLjO1QFIAfLuQAosn3HuE46o+gvByTEYnMUEwEBN56nwTqJvJd
         yyyjYNmLR03MvyoAq0uCgSSdLwxGbNVzfv9M46uEiZ61KRm2NCvcz/3VAoKD/t4SlJKM
         uhE+lRu9b0myEQU602QkaSVBVYC+AhYNrJ26X/KtKsKtDiXGdyRy+vn807/zkkzrQTKQ
         +g/5m+MWju2+hA5vVenvFiry/02T/yKbAiYYuUENPJIv8qZ9BhAXwjARpGuqu5w+I74i
         5+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795760843; x=1796365643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8lJaPpRGy7TrFULAZGwfuDH5/Bcxre2ZiVQp9kvtDA=;
        b=pnRX9wWFONbjaLw3XrtUbuSRD6GKm5Lf+HGjUN7YK38PuBy+AX3LiXuUtZDu1GbTOX
         rtTgVKng1UVLdaXIPXG5/zKxn2LXqbgdqGPqW3gANQB7tPOE0yTcUjglH5+i01VSS6gW
         AcSxlssPjUmb8bfsBFMT6wKOTvsZ3/ChEgaR1RbN1vMIQrxZxD4yfI8yeX6Oss8azNqb
         fHQU4UwBQDwBRw6nRlJUDbB7aW0uQ+iIfppuSzz/vva9HwYAYWUv4DeWFGcnfPNzJA9n
         jwueQ1O2V+mEB/GhG6rC5fYwmSLoj8j/oADh3w4HgidwiwV1jdFZrfcy41NL4lrsML91
         VbmA==
X-Forwarded-Encrypted: i=1; AL+hErEF7EL4ZRoXhbdExGd0Yi2aPVLzCUwWgxOA2rJou9ePvlx0AqFsm8Z4ILrTd+5H22NRIRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C1LkAzhlbqnsIV/JwGtx6dBM6gu4V7Eru+rGECKi0l6OuRNVH
	oB8locb8whCZUSXAEzPWbozRDWvtcR5L0szzB37wzxZaGkGcRDv7guI+
X-Gm-Gg: AZFdTZckh+i2AlU+WxDfOEU79RspBzWG2sznyoKe8HcDpwkA/C2hkMVg9MkXhCjn4px
	5zG9OWXOVNc90ajg6To3GYSNLrqu8h3bTVwxtgdiBahaU9hDMog8EVjFHhKOK1dTdgnBxHL1yG4
	A4PFm3QtLjlopUQDIbpDprEqat0eBZbqVlDUo6eM1WrKCKXo3tYKftC97CLaXVtSJvobR2Yz0iC
	6MUvA7jj08VnQgpyk7VSx+su47+j2RD9PswAi1/FOTLBz1kgmiaVnCOxGTSyf/5OhXJBBic96Ii
	BFTkHEgYB9mtKhgwSdbuegCMkuzZRmf+A4qsrlXJe/AdMPkx++e1MyYnKUBAfCvtAnV8hdDYF1V
	/TmGtONyCPGn6a/TWIgtLGJ1RRXOZJ5h9HjLj9JiT5BP14bTTvnbKs/SiYXXoQgBhn7DEzGgFn3
	i6tjoEG4oRByHt+mhwp/Qs8SD4DFjP9D3oI7n5MYpfVBZJlymuYjedLfa+CF0YWjXqfllSoEI+J
	d7aMrVoifj9pbzRmBrFwv2u9wBCOupqyTACcvEmQad19PPJlc9xeXiP6gqQUGMNbq1IOeMN8XmN
	GhxttRSyif0Oc39iEpQ434v3aJHM
X-Received: by 2002:a17:90b:2e8c:b0:3ac:a6a5:5757 with SMTP id 98e67ed59e1d1-3b41c8df55amr15467243a91.11.1795760843097;
        Thu, 26 Nov 2026 22:27:23 -0800 (PST)
Received: from dbg-srv ([111.194.74.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm15986522a91.4.2026.11.26.22.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:27:22 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/2] vsock/virtio: reduce RX per-packet socket overhead
Date: Fri, 27 Nov 2026 06:26:58 +0000
Message-ID: <20261127062700.29387-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reduces per-packet socket overhead in the virtio-vsock RX
worker.

Patch 1 separates socket lookup from processing under the socket lock.

Patch 2 retains one socket lookup reference and socket lock across a
bounded run of established STREAM/RW packets for the same native socket.

Performance:

The measurements below cover both patches. Throughput uses vsock_perf as
the host sender and a custom single-threaded blocking receiver in the
Guest, with the receiver on CPU0 and the virtio-vsock IRQ/RX worker on
CPU1. Each row has 16 accepted, balanced AB/BA pairs and a fresh Guest per
state. The fixed-syscall campaign was collected separately; each table
compares paired baseline and series runs from its own campaign. The host
uses vhost-vsock.

Accepted runs also passed byte-integrity, CPU-affinity/migration,
IRQ-activity, host/Guest steal, I/O-wait and swap, sentinel,
kernel-diagnostic, and applicable perf-validity checks.

End-to-end RX throughput
(64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  baseline RX  series RX  throughput change (95% CI)
           (Gbit/s)     (Gbit/s)
  64B          0.1212      0.2555  +110.81% [+106.99%, +114.70%]
  256B         0.5551      1.0212  +83.95% [+79.94%, +88.06%]
  512B         1.0568      1.8761  +77.53% [+73.02%, +82.15%]
  1K           1.9260      3.1453  +63.31% [+58.58%, +68.17%]
  4K           3.5175      6.3239  +79.78% [+72.79%, +87.06%]
  8K           4.1183      5.6867  +38.08% [+31.06%, +45.48%]
  16K          5.0155      6.8346  +36.27% [+31.12%, +41.62%]
  64K          5.0541      5.8403  +15.56% [+11.12%, +20.17%]

Fixed-syscall stress test
(receiver recv() size = sender write size; Gbit/s):

  payload  baseline RX  series RX  throughput change (95% CI)
           (Gbit/s)     (Gbit/s)
  64B          0.1435      0.2750  +91.60% [+82.19%, +101.50%]
       recv() calls (baseline/series): 1048577/1048577
  256B         0.4218      0.9659  +129.00% [+110.65%, +148.95%]
       recv() calls (baseline/series): 1048577/1048577
  512B         0.8062      1.6979  +110.60% [+94.49%, +128.04%]
       recv() calls (baseline/series): 1048577/1048577
  1K           1.5116      2.9585  +95.72% [+85.22%, +106.82%]
       recv() calls (baseline/series): 1048577/1048577
  4K           2.9234      6.3365  +116.75% [+110.78%, +122.89%]
       recv() calls (baseline/series): 538537/525565
  8K           4.0430      7.1193  +76.09% [+69.04%, +83.44%]
       recv() calls (baseline/series): 276901/264412
  16K          4.9182      7.7688  +57.96% [+54.40%, +61.60%]
       recv() calls (baseline/series): 147674/132088
  64K          5.6683      7.1636  +26.38% [+20.49%, +32.56%]
       recv() calls (baseline/series): 50615/33343

Request-response latency
(ping-pong RTT, 10,000 requests per state):

  payload  baseline mean RTT  series mean RTT  change (95% CI)
           (us)               (us)
  64B               121.067           120.977  -0.07% [-2.45%, +2.36%]
  256B              120.733           120.809  +0.06% [-1.69%, +1.85%]
  4K                123.161           121.525  -1.33% [-2.87%, +0.24%]

---
Compared with v5, the performance suite was rerun with stricter validity
gates, including host/Guest scheduling, steal, I/O-wait and swap
monitoring, plus QEMU affinity and migration checks. Runs affected by these
sources of noise were rejected, so the current results better isolate the
RX batching improvement.

Changes since v5:

- keep patch 1 unchanged apart from Stefano's blank-line nit, and add his
  Reviewed-by tag
- drop the metadata-budget helper and the rx_buf_full() batch boundary
- apply Bobby's receive tracepoint refactor in the batching patch
- remove the locked helper's batch-specific parameters; return packet
  validation status and keep the continuation check in the batch caller
- keep sockmap eligibility checks at packet boundaries without taking
  sk_callback_lock
- move notification coalescing and deferral to a separate follow-up series
- update the performance measurements and add fixed-syscall stress results

v5: https://lore.kernel.org/netdev/20261103041134.33310-1-physicalmtea@gmail.com/

Jia Jia (2):
  vsock/virtio: split socket lookup from locked RX processing
  vsock/virtio: amortize RX socket locking for stream packets

 include/linux/virtio_vsock.h                  |  23 ++
 .../events/vsock_virtio_transport_common.h    |  40 +-
 net/vmw_vsock/virtio_transport.c              |   7 +-
 net/vmw_vsock/virtio_transport_common.c       | 368 +++++++++++++++---
 4 files changed, 359 insertions(+), 79 deletions(-)


base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.53.0
