Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473805;
	b=QQfJUGQQ9gkfdRJyctVm1ddKmKCsepJUczozXsculMjB5BfhqOYg3wOvNaPk+TvLnRF3
	 mxGfc0iOMyPtU2LHDjax5SpOCZ1jbuel54uHd6ZFCtCpxz5Q0pGUD2JtGoKURyQZK75ae
	 4LnfxIPthsH/iSxGoZXKENS+OPpJig1/0UBgX7mV/GAECYTHLe6rmVpW9xKN/Pkxe90oa
	 h/bd4mP4M2V1HhyRhqtMPqiejdJdbQ0Fd/tkrFLAvrEcJRC6WOgW3YEBPLCZPHplrPgke
	 FuzAk/elIHlpLkbYYxWV3E/pz1yBL+yipTOo92oEg2D3V6naUSCdMiwW6xleYu2rhzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473805;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LxcEEAoCt6n89bCpZ37twcsUB6ZoqztAQdy/4BmRnjc=;
	b=gJF8KAGePhzwzsbTakESBINYw2FEKlQG9fn7aYZUc26w0HwpHdDR18fOKbPB5VJ18yaS
	 wynl3uYPZRV16vx/jdI7+nNZXu2oVALA5X1RO11eZZduzj74esjMVD5keFAguTyvDamhc
	 OhRSbfGxC9pNhG1lx3DJtbUPtEV/Ybge84W+fCKxxmxyNy+lrDOa0tEfGKQD799yyqiHq
	 3WuTgmNnKqcknEeMEngcQf/MIcLOy+WLZfVgfPQpbqVD/1E3lyHsr1RH0g4y60iG68AZn
	 3jRStHq3ypl1TwGn8RyyYtvQYSmJzzjfKmS/SxPiU4MgS5IgTuIZ+e34KGpSbGYASLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF9606A323;
	Thu, 12 Nov 2026 08:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FF9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f805aa50de7611f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e5d3c368-e4ec-46dd-b66a-e06561e210f7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:92feb5b01784c7e2b70c8a08b12f3392,BulkI
	D:nil,BulkQuantity:0,SF:102|123|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f805aa50de7611f19a56ed5b684f684d-20261112
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1107669512; Thu, 12 Nov 2026 16:56:37 +0800
From: zhaoguohan@kylinos.cn
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vhost: set dirty log bits without pinning pages on x86
Date: Thu, 12 Nov 2026 16:56:29 +0800
Message-ID: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

From: Khan Zhao <zhaoguohan@kylinos.cn>

We use vhost-net with live migration in our product. While dirty
logging is enabled, every used ring update and every logged write goes
through set_bit_to_user(), which pins the log page, maps it, sets a
single bit and unpins it again. The TODO above that function has noted
for a long time that a direct user access would be better.

Patch 1 does that on x86: it tries a byte-sized cmpxchg on the user
address with page faults disabled, and falls back to the existing
pin/kmap path if the access faults or keeps losing to concurrent
updates of the same byte. Other architectures are unchanged, since
unsafe_try_cmpxchg_user() is only implemented on x86.

Patch 2 adds a userspace test in tools/virtio that drives used-ring
logging through vhost_test and checks the bitmap, including fault,
COW, shared-file and concurrent cases, plus a small benchmark mode.

On an x86_64 KVM guest (i7-12800HX host), the benchmark with logging
enabled went from 243.60 to 171.11 ns per descriptor, averaged over
five alternating runs. This is the per-descriptor cost in the vhost
worker; I have not measured the effect on total migration time.

Tool usage: the test, its documentation and the benchmark in patch 2
were largely generated with OpenAI Codex (gpt-6.1-sol) from a request
to exercise vhost used-ring dirty logging, and Codex helped run the
build and VM tests. The changelogs were edited with help from an AI
assistant. I have reviewed all of the code and take responsibility
for it.

Testing: x86_64 with SMAP under QEMU/KVM, running the test from
patch 2 against both the unmodified and patched vhost modules. i386
and arm64 are build-tested only; non-x86 has not been runtime tested.

Khan Zhao (2):
  vhost: set dirty log bits without pinning pages on x86
  tools/virtio: add a vhost dirty log test

 drivers/vhost/vhost.c           |  50 +++-
 tools/virtio/.gitignore         |   1 +
 tools/virtio/Makefile           |   7 +-
 tools/virtio/vhost_log_test.c   | 393 ++++++++++++++++++++++++++++++++
 tools/virtio/vhost_log_test.rst |  53 +++++
 5 files changed, 497 insertions(+), 7 deletions(-)
 create mode 100644 tools/virtio/vhost_log_test.c
 create mode 100644 tools/virtio/vhost_log_test.rst


base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
-- 
2.43.0

