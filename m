Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755542;
	b=gE/jgNZfvOXaRvDsmJiOkZp729b1Qev+MPfNhLijV9h3cwl9K92eErFLKferrcVharZ1
	 j9LgWFp+LgBsZ2sVW+KAYUx09m0Kw8SH/H1CrptkIpEmhfzPe/r5K7KwqEI/TciUXEbTQ
	 /hWijXPVPejXnmRYB3kRxFMDaSsvr777CAZaGFgAhu5HEnkw3RRrhhITSLb04Xx9Zafew
	 nHch+1vBSEu7jSJZskzCS5tKmJcnSWCi4ALRSyNPqt0cHdNGur46kZrS50oclgQj/8i13
	 xk20hHJEYPX5fA3/i6eyy9RhqGJvvGXyNtC1J+bpKu0dLR+IrZtCD4kmrnALq2Q6HmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755542;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8VRnGlElQsFCv5R28x1Gbp07GlpWyV9JaiJRHuKTiKs=;
	b=c0wIPoYJzYwZ3ucLv8Cp152/JUb72Y41F7YtEziPebjn3vnaytBJZx4l3yYfF5x5z72h
	 9JZHPgDkJAveGss6NMIAUvOQuaKGwNrYIM6oUPNvJOcS44oM2iHoD86JELdktDkL5TAri
	 LeCVny1NafoN4k3mJ1vIoJr52bJo7GUqhl3YPL4G7Tf2kuySrXjd5XlS0Gf9cqFcqO12X
	 fqvSrJgn7nBum7bOeSbLTAOOsmegEitf+VCcEUGfeCcBMQiqJFf7AgnjAIdOUM6J6PTFq
	 ZkuY+7e5enaENNIg6iu8kKo9sSOAiTCt4Z/HpfyHi8kadbm3x+rRy3de2Fwg9sfyorQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WceBVUOD;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D704606A31D
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 15:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D704606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WceBVUOD
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=K1rYyVGAnrzeZXd3FlMro7kB2ZINE/qYB84gIwgS6iE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794755539; v=1; x=1795360339;
 b=WceBVUODB3nRmr1alBjCVjpgX0ecg5odOOrbQBlpafWUZp0pOBJUu+W1D7JYuLeKeT2Us6O2
 9IR5G4MyIzecU44EnVB+gFmRl9WExMaHdgq1v42RcAKoHh/o+VHPoCEsTfLtuPZhC5GbRaQqCSs
 BhGWXHdRlJo+H0PnLvktIdy4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d986cb89a3ce2d99;
	Sun, 15 Nov 2026 15:12:19 +0000
X-Mizu-Trace-ID: d986cb89a3ce2d99
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: kvm@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] LoongArch: KVM: Remove unused macros and declaration
Date: Sun, 15 Nov 2026 23:12:04 +0800
Message-ID: <20261115151204.82817-1-zenghui.yu@linux.dev>
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

The KVM_LOONGSON_IRQ_* macros and kvm_restore_fcsr() declaration are never
used anywhere, drop them.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 arch/loongarch/include/asm/kvm_vcpu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index a70a32103523..439731f715aa 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -44,14 +44,6 @@
 
 #define MNSEC_PER_SEC			(NSEC_PER_SEC >> 20)
 
-/* KVM_IRQ_LINE irq field index values */
-#define KVM_LOONGSON_IRQ_TYPE_SHIFT	24
-#define KVM_LOONGSON_IRQ_TYPE_MASK	0xff
-#define KVM_LOONGSON_IRQ_VCPU_SHIFT	16
-#define KVM_LOONGSON_IRQ_VCPU_MASK	0xff
-#define KVM_LOONGSON_IRQ_NUM_SHIFT	0
-#define KVM_LOONGSON_IRQ_NUM_MASK	0xffff
-
 typedef union loongarch_instruction  larch_inst;
 typedef int (*exit_handle_fn)(struct kvm_vcpu *, int);
 
@@ -70,7 +62,6 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu);
 void kvm_lose_fpu(struct kvm_vcpu *vcpu);
 void kvm_save_fpu(struct loongarch_fpu *fpu);
 void kvm_restore_fpu(struct loongarch_fpu *fpu);
-void kvm_restore_fcsr(struct loongarch_fpu *fpu);
 
 #ifdef CONFIG_CPU_HAS_LSX
 int kvm_own_lsx(struct kvm_vcpu *vcpu);
-- 
2.56.0

