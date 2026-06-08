Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A53F5BEE
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932077; cv=none; b=CLrtfTTiu1anUDbwb8E8GeCeaIW5GMFDPd99HL7gVHaargI1egIu7Z5uRgOUl/traG8a5VSXZM9GK2DUeZnxCGg8CRg3q4D0jGKNKZciJ9PF18cfJognLOxRX8ZiscUPArOmqBgRB6GMEv+BC0xISkD9zLWMkBtYrDeqmH7aLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932077; c=relaxed/simple;
	bh=D71S5gdIgIwgdvO+TJqgjxMf/++V2uTPVfUO8HBbBBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLjIt8LzVySGhqqJl+xRJxgFk55kr/pxCLCgAfzTYeagXkZQjYsBX02KJjigg/KHU7bJFxn/tCNZc63ytD2vJlpiagayr5gRs9ECb+CM3EzhJ/fYMbX23QvcfjFFcfmVbtXZjFwVkTto6EgV6kR1bewQNFWt5f8cUaTm7xDbQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 48B7D202945;
	Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 04/10] accel: Add nr_planes() op
Date: Mon,  8 Jun 2026 17:21:03 +0200
Message-ID: <20260608152109.356783-5-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Add a new accelerator operation to request the highest supported plane
number of a given machine instance.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/accel-system.c      | 13 +++++++++++++
 include/accel/accel-ops.h |  3 +++
 include/qemu/accel.h      |  7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 150af05bf5bf..968473b8692a 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -75,6 +75,19 @@ void accel_pre_resume(MachineState *ms, bool step_pending)
     }
 }
 
+uint8_t accel_nr_planes(MachineState *ms)
+{
+    AccelState *accel = ms->accelerator;
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    uint8_t nr_planes = 1;
+
+    if (acc->nr_planes != NULL) {
+        nr_planes = acc->nr_planes(accel, ms);
+    }
+
+    return nr_planes;
+}
+
 /* initialize the arch-independent accel operation interfaces */
 void accel_init_ops_interfaces(AccelClass *ac)
 {
diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index f46492e3fe15..1d5decb9359b 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -36,6 +36,9 @@ struct AccelClass {
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
+    /* planes related hooks */
+    uint8_t (*nr_planes)(AccelState *as, MachineState *ms);
+
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index d3638c7bfda7..2ecf33e1fa21 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -81,4 +81,11 @@ void accel_cpu_common_unrealize(CPUState *cpu);
  */
 int accel_supported_gdbstub_sstep_flags(void);
 
+/**
+ * accel_nr_planes:
+ *
+ * Returns the number of the highest support plane of a given MachineState.
+ */
+uint8_t accel_nr_planes(MachineState *ms);
+
 #endif /* QEMU_ACCEL_H */
-- 
2.53.0

