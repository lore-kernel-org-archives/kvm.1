Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F63F6C33
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932080; cv=none; b=DO+p3AW1TqRWVTszJEE/+QidPmp8CKI2hD90fK0oX02h3egD4LfkdArurlh3VqfiVIoT5uts0ImFtz8ynopIheeNk7NZCtfySd4TQ2rbSsw7110qyiYRAUHQ/S02XPh+wwPgLUziL1kzUgKC6VeSGEjtzmDm8v+77dNTU26keaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932080; c=relaxed/simple;
	bh=9q78hu6B8GVAfGu6Apodj5/jehFVFAY9WR/8j4rs9IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2dpZ7s7s4OpeXTE1+rcIEjyD/Jvef9i9iOomoq8jeReKvrd8rpM0vOgJ5hu1SifpBkPHC+a3DpeRQZq/gFpXjTaf8ti+sl3O7u5ueRYG42dZl91uSTM+KLVSTH2UimIWihwyEGs8X67XDu5OqPW02FLtJSQZebutX8hr177SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 72292202946;
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
Subject: [RFC PATCH 05/10] accel/kvm: Support nr_planes call-back
Date: Mon,  8 Jun 2026 17:21:04 +0200
Message-ID: <20260608152109.356783-6-joro@8bytes.org>
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

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c | 19 +++++++++++++++++++
 dtc                 |  1 +
 ui/keycodemapdb     |  1 +
 3 files changed, 21 insertions(+)
 create mode 160000 dtc
 create mode 160000 ui/keycodemapdb

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7429e2be8ba9..dbfef63a84b0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4247,6 +4247,24 @@ static bool kvm_accel_has_memory(AccelState *accel, AddressSpace *as,
     return false;
 }
 
+static uint8_t kvm_nr_planes(AccelState *accel, MachineState *ms)
+{
+    uint8_t nr_planes = 1;
+
+    // Planes are only supported with in-kernel APIC
+    if (kvm_irqchip_in_kernel()) {
+	    int ret;
+        KVMState *kvm = KVM_STATE(accel);
+
+        ret = kvm_vm_ioctl(kvm, KVM_CHECK_EXTENSION, KVM_CAP_PLANES);
+        if (ret > 0) {
+            nr_planes = ret;
+        }
+    }
+
+    return nr_planes;
+}
+
 static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
@@ -4437,6 +4455,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = kvm_init;
     ac->rebuild_guest = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
+    ac->nr_planes = kvm_nr_planes;
     ac->allowed = &kvm_allowed;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
 
diff --git a/dtc b/dtc
new file mode 160000
index 000000000000..b6910bec1161
--- /dev/null
+++ b/dtc
@@ -0,0 +1 @@
+Subproject commit b6910bec11614980a21e46fbccc35934b671bd81
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 000000000000..d21009b1c9f9
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit d21009b1c9f94b740ea66be8e48a1d8ad8124023
-- 
2.53.0

