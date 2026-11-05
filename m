Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836929;
	b=IMgh7jfL7uGV91V7OQGx279+/TYfs5+BX4CM7soOUYwFvp9l7L6tft0aG2adg2Ytramc
	 xiJrIYFP3eRjXVdAf0W7zze+7cXnnoXZkzYyezryctFNk3dMkr9ASgvNewU+xywirUH3Q
	 YxUtWqfp9YiDHWR86HpfBvKFHv9In7Bg8Wd6GrRVoxjJrQmxLf50nczj0B/DSaGgwds6/
	 mqXcIlXZjbeo2TTboSfVqZMy/Z5ZI1tVq6MuUFgAnZRcg45cSoonfvJ92MU0buZ3pgQL6
	 Q/JLzCPwCgQ9/F+SyvuD/+f3HKdZKruDZg60WPOUQ0Uyz/AgigJMzz9EpiXu0DVaPfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836929;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=oLJyanmstYagcI9Rv5WYzf+IYeOCfgcugYDSw4IlpLU=;
	b=jtH1xcf5p8wngdg/82jFGykX7SYQh4HnPpcoHI1TE7mmHstz4a4g9ZhDDc3nWxvZz276
	 iGjJ5GU07Ify4Hq3bhi0k4l5X4iqYXUpCRKSqlSA/JPhHZDP4eVK49SVOnTODY2LSh4w6
	 o5q/7k25/QuLKbGKryt0dp2PjhswVUVa6IbUwYZ4yUj1oOGChaht8a+kJynb9ayYzSqlf
	 rz6Sj7RG0yfSsxGbftV43c8AcL6thp7kxE7bpRVJMixn/nDWdUCDCc9Y+aqh6tgJjyFep
	 WUMt3QtfrrNzK/o6F+eo9f+IWfEZmSBmcTmoY5IpskCelo0Q5LMzeVzLzb2K+BGs5HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linuxhacker.ru;
	spf=none smtp.mailfrom=linuxhacker.ru;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B5606A326;
	Thu,  5 Nov 2026 00:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxhacker.ru
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 82E49BEE42;
	Thu,  5 Nov 2026 00:01:57 +0000 (UTC)
From: Oleg Drokin <green@linuxhacker.ru>
To: sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] vsock/virtio: bound what a peer can make the host queue
Date: Wed,  4 Nov 2026 19:01:38 -0500
Message-ID: <20261105000141.3617241-1-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
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

A virtio-vsock peer that does not consume what it is sent can make the
local side queue memory that no limit covers. On a host the peer is a
guest, and the memory is GFP_KERNEL, charged to no memory cgroup. Two
ways remain on net/main:

 - the send credit trusts the fwd_cnt the peer reports, so a peer that
   never reads but keeps acknowledging gets unlimited credit (patch 2);
 - credit updates are not bounded at all: a peer can solicit them with
   OP_CREDIT_REQUEST, or by sending small packets that a reader drains,
   while posting no rx buffers (patch 3).

Patch 1 fixes the accounting of packets that vhost drops on rx errors;
patch 2 relies on bytes_unsent being right.

Nothing changes on the wire.

Tested in an x86_64 qemu/KVM guest running the kernel under test
(net/main 03897066069f); the "guest" is a user-space program driving
/dev/vhost-vsock directly, talking to plain AF_VSOCK host sockets:

  case                                      net/main      this series
  lying fwd_cnt, no rx buffers, 2 s of      256 MiB       256 KiB
  non-blocking send() on one socket         queued        (one window)
  20000 OP_CREDIT_REQUEST, no rx buffers    +18.5 MiB     +0
  20000 1-byte packets, each read by host   +18.0 MiB     +24 KiB

vsock_test from tools/testing/vsock passes over loopback and between a
nested guest and its host. A bidirectional stress test (up to 512
connections streaming both ways, readers draining in small reads) runs
without stalls, and vsock_perf throughput stays within run-to-run noise.
With KASAN and lockdep enabled, these tests show no reports.

The reproducer (a small user-space program that drives /dev/vhost-vsock
as the guest) is available on request.

The patches, the test setup and these changelogs were prepared with an
AI coding assistant (Claude); the tests above were run as described.

Oleg Drokin (3):
  vhost/vsock: release the accounting of packets dropped on rx errors
  vsock/virtio: bound the send credit by bytes not yet consumed by the
    transport
  vsock/virtio: queue at most one credit update per socket

 drivers/vhost/vsock.c                   | 25 +++++++--
 include/linux/virtio_vsock.h            |  5 ++
 net/vmw_vsock/virtio_transport.c        |  2 +
 net/vmw_vsock/virtio_transport_common.c | 69 +++++++++++++++++++++++--
 net/vmw_vsock/vsock_loopback.c          |  1 +
 5 files changed, 95 insertions(+), 7 deletions(-)

-- 
2.56.0

