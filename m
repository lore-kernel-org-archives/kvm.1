Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672711;
	b=fXG+ks1h/rTpg5WFFDrlrvqHGPLiQz4/A3MAluDcnScjIFygUCxsgY54x/8WcYEELLsK
	 xZvczCDqaXwQ0k0lC4QpoRTuLHYI0BeUuZR/uil3w+v+lEnir2dSFVL7MXPE9Haz8kb45
	 gqZFsZpLz7IkdXgQwzrygR6MgqP+Lk7HeWCmx8qz+PGx6KJsJB+f9rNJ2jE2hj/HcAykW
	 +MRjyyvaX50aVP1t+Zj7Opoqc+C4qFc4CAHvv0suBvjYHf5uUISpCO/F0xuPQAdmcEti6
	 71FbIIdKdrp5nAiqBxFsiQ8LBqCzIqVtR1h0DPtsJBjIyAgy/eJLOXbOZlCL1Qw4n7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672711;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CWwu4nFmuifwtyi15MIPpVhu29b6mqsKR5ygqP1PcsE=;
	b=joJcEJsINq2qQOQF5zCQdLRv4eE3I8R6srOZ9buA7kcW+47ozyI37pk+TEn8RJgKI9fB
	 /bGjnpFtgAKgZa4dlJ7hUvcAEAncvH9GOn1EPRGQSxgfwVV7IhJzl6skx5sWEZvJQbZt+
	 GRV9KPeqU98JJsOMakDIyjAqg39xqrD6MzBbRAo9/nnvyEpl0Dn+TQgvAlZoCIXjgPM+G
	 KRc6f/YCkeGrFaznOVHxe21OB87zHlTpPBmhAqgVTSWk+zE9UR2r212VfJ2Aujx4h4Osb
	 iFjOGP0IfUl2fbeiLPVODwo8ZR1WPP55kIxQF/9APy9UCZYOrhgEjBlz67KV98XMRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T3WeYxLR;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF3606A324;
	Tue,  3 Nov 2026 02:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAF3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T3WeYxLR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CW
	wu4nFmuifwtyi15MIPpVhu29b6mqsKR5ygqP1PcsE=; b=T3WeYxLRfHANdLoLbz
	Er6loyW5qQ0nyJA9nSRtN2BzhlTYqi1WKGaK7XTXayvllUsqR/HdYbj03mr+QdM9
	pgtoOnuQS1FvIzGJeGJgdPhOPMzi+mk6xlnsFiqvVkY/fEf0hZLGGa1weeLaFOge
	42I/cgUQ3DN/BGQ9YQyoRaum4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHTc32RelqB+r1EQ--.18526S2;
	Tue, 03 Nov 2026 10:24:55 +0800 (CST)
From: Wenmei Wang <wangwenmei0618@163.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenmei Wang <wangwenmei0618@163.com>
Subject: [PATCH] KVM: coalesced_mmio: Sanity check the size of writes
Date: Tue,  3 Nov 2026 10:26:21 +0800
Message-Id: <20261103022621.39109-1-wangwenmei0618@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wCHTc32RelqB+r1EQ--.18526S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr17Gw4xJw48Kw45tw4Utwb_yoWfKwb_ur
	sYywn7AFyxGr1DtwsrA3yfXFykGw1Dua18WrsxJrZ7Ar1kZan5Xw1DJr95A3srWrsrGrsr
	trZ5Za4rKw17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjPC7UUUUUU==
X-CM-SenderInfo: 5zdqw45hqpvxaqwrmqqrwthudrp/xtbC5hejS2rpRfeoLAAA3s

Each ring entry has a fixed 8-byte data buffer, but the write path only
checks that the access falls within the zone, not that it fits in the
buffer.  All in-tree users of the MMIO bus cap accesses at 8 bytes, so
this cannot be triggered today.  Reject oversized writes anyway instead
of trusting every caller to uphold that limit.

Found by reading the code.

Signed-off-by: Wenmei Wang <wangwenmei0618@163.com>
---
 virt/kvm/coalesced_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 3b5430036cae..fce38f1c8054 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -53,6 +53,9 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
 	if (!coalesced_mmio_in_range(dev, addr, len))
 		return -EOPNOTSUPP;
 
+	if (len > sizeof_field(struct kvm_coalesced_mmio, data))
+		return -EOPNOTSUPP;
+
 	spin_lock(&dev->kvm->ring_lock);
 
 	/*
-- 
2.25.1

