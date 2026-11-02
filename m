Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635152;
	b=Ii94E/CCIHHZ4XRa2YKA/ht9BMwiNQwQ/KGCFO5LQ13BZRZ/jEGHydZcXCfJa1+VHpBo
	 cBXtp76iNYgZGUAoEf4QeWleM8lh5SCp1pvKaeSjkUTbO1XiaUXbCK/3ws+RyruzKx+vZ
	 N4ve8S/AOkZVwkFf9vtDCRHURMak4LA5DtBEvBiM4Gc2SgOk5xkTkUpId5YzdluyRk/Xy
	 2Q7YCi7L7PPdCdVAF5sIVxDob8tpTWb1e5x1M4xbGnaM1Qn1LJgRAzhlgPb6EoFxfZj5L
	 8FagZw6HBc3Z6ryNnRhVx8k2T3yYkMCApIsLY3BhnwWNt23fFS4ahexG0L+qe7yKjaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8wN4X+t7gT6Mf/Mr7aPiLu7VXvH1tXt8RCsXdYlNcOE=;
	b=V/8EA5DHcKPqn7lSKgXvusG11n4UmF5sDWL+i/2JixOA7+UVttOZZ+9yP32eerOmgf41
	 lYdVzIFo5LgWvkBmBqkU1ytGTSg/sSeRHE/fZ9wJRuaeZbA/Xb/j1OYV+sRBGVqznDup5
	 Tg4Fo2Wfa5l/0uPrLh0N2esIUbm6Y8xQJ+mRYswpk8bbuGoz/j+zxCE5g6ifZui+r7RAY
	 lEkkkdGIw6J4OlE7e5KZ79CKP+dE6cGTca6P7OYdTa2AkF0OtpxUFKCv+AlENANuTe+T9
	 jGi1uUHmqs3CElMYm+2/oiWbvxfXvxSLfaIZTep881gjpzll0gJmLbpxh1WVW+EnUJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZabYMH4z;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77C606E011
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA77C606E011
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZabYMH4z
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4be28b82so3355331f8f.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635150; x=1794239950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8wN4X+t7gT6Mf/Mr7aPiLu7VXvH1tXt8RCsXdYlNcOE=;
        b=ZabYMH4zWR2RXDxlf+v51gP6xZFE5h7+cEBix9Pzj0dkUPJKI8Z5KT7jUcE5mMjvjE
         IPboBDIo7YtyfqLMNIG/zk65O0JAhgfuEajNz/viAs4yGQbqL2eflVieCKTVR0/IXWIb
         dkfSDVbiu/FBHTmQz6JuzK0OT9mONjQ7VLAR+ILGQOKK71c2blBxCSy2li4TmUVstrsB
         WVGyfSLhwQJFqj3Y4MZAwBjiS6QkUffz51bFhqzaahT2HGtrRE6MZkindEFeshnkGafp
         H57yy5+84ZaHkl/ijNdMAcTRQJxdq/tZtzglmSBfb1WvG+lOoXrJ6tZn11DMTvOKmtIa
         dB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635150; x=1794239950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wN4X+t7gT6Mf/Mr7aPiLu7VXvH1tXt8RCsXdYlNcOE=;
        b=0niOgxFd9Tfmu13mhpkEGFR7V1cAuSojJDiDZMqaL28ZM/uoq1M/gPNcPxzkOmCed+
         LkvrLPYlUTITscTY21nBVg0OgjgUf20Xbz44Cw72nXKA778Gy1B34WsEO1QVgEpLB37M
         SM7TttgCVzmhVGa65IyEvvs+Ar68SyFA9Lx2E9A7+sJQ8ZoCUSOreot4/SmluVLYRZr9
         fLk10z2l98QGrCLf1L4jaLkV3/zJSbx2a0cNbBhw6XuSpdD2KxA66o2/PpQVEwL3dLA7
         oUfv1EMp3AfoCDp1Ql7esi7aM/A5vu3uvqPmjwEFUrHb3RieXK2ii3II7tG7ic2rAsXJ
         0tjw==
X-Forwarded-Encrypted: i=1; AKwUvBwn6hBz04mBid7hmL/6GBFweLnN5i7d63qYCzvJYSK80lMT8pB7sNt7ibY2pB/FGQC82CA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q1bDJyC1QngDgyJnezK30XlTVJe4cImdQk+1OobBJqhJmfxXY
	aQwT7zsmLJMc5VeRMjarObVBG1K/xiahgSyL/idDFRLUmZhOxv+l9RY9
X-Gm-Gg: AYBFou2vZmHq175XlREGbRQSBqyPOBy2qi9qwBx4HaJjoCShZ7CTN4Gl3lkMOqGLavy
	xl9hDGUmrfQFNl7mc1aYWgJF0EtzQZ5bywNc/SNbjwCZBgOdZEFgahy9pTPWzs/TEF/8H8a4lCF
	aElaKsVYERsBBgMaXtWRzJH7WoxGBUqysGA9rt6In+TyxT9HIPdHZbhZgQbxLIJRq9TreIShpBo
	zrKRDQySuEGkxMaBFgOoNjcUfLItfjElgj1u4USDTStTzbITL26GWAqM8wp7DM9kNIaL+p24ngX
	qDhn7IaTNJRUqvvbJS4nDghMQPp2+V3ZHYi+HIJp2Z9d4cOOyJytehp7V14taP7ljIgP1UFRZgT
	cB2a25tHyIj5ClHT/CBLxxp2czsbMoD1jkAKVdsHe+rnhMbGqJ1ldoupUFti0EP8Tk84MUoLctE
	ta0SmuArZcB3xOWLDSIQhyq/KFIo4L1A8VWRYXMNPMd7khfm7AdVF2HtRiEPJO77Bhsc0rhh0EN
	PYAstUhniZtg0Z6XU+sj2y8lrM6bjSfHCFWZPCgcobMMITiPvR9oR5ZMpBZezg0LppAWxePY1DD
	rZUNa5eM+f5+P+Q+6r1eijpOu2SPj1+XkY3zDIyMfEXX1PoIMYj5XOknLVqWwO+92zal4AQEC1G
	3zYh1AKs=
X-Received: by 2002:adf:f707:0:b0:48e:517b:cf21 with SMTP id ffacd0b85a97d-48e6e4f5017mr18332961f8f.26.1793635149802;
        Mon, 02 Nov 2026 07:59:09 -0800 (PST)
Received: from sfomberg-mac.redhat.corp ([5.28.174.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728ddsm20490375f8f.9.2026.11.02.07.59.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 07:59:09 -0800 (PST)
From: Shmuel Fomberg <shmuelfomberg@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhao1.liu@intel.com,
	mtosatti@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	kvm@vger.kernel.org,
	Shmuel Fomberg <shmuelfomberg@gmail.com>
Subject: [PATCH] Adding support for hyper-v enlightments hv-extcalls and hv-memory-hint
Date: Mon,  2 Nov 2026 17:58:04 +0200
Message-ID: <20261102155804.39426-1-shmuelfomberg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

hv-memory-hint (hypercall HvExtCallMemoryHeatHint) allow a guest to
notify host which memory pages will be needed in the near future.
This is not a replacement for the balloon functionality, but can
help the kernel make better decisions when memory is scare.

Signed-off-by: Shmuel Fomberg <shmuelfomberg@gmail.com>
---
 docs/system/i386/hyperv.rst      |  14 +++
 hw/hyperv/hyperv.c               | 158 +++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  25 +++++
 include/hw/hyperv/hyperv.h       |  13 +++
 include/qemu/madvise.h           |   7 ++
 target/i386/cpu.c                |   3 +
 target/i386/cpu.h                |   2 +
 target/i386/kvm/hyperv-proto.h   |   1 +
 target/i386/kvm/hyperv.c         |  24 +++++
 target/i386/kvm/kvm.c            |   7 ++
 10 files changed, 254 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index e1babffb0f..1e164f1863 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -259,6 +259,15 @@ Existing enlightenments
 
   Recommended: ``hv-evmcs`` (Intel)
 
+``hv-extcalls``
+  Advertises extended Hyper-V hypercalls (call codes 0x8000 and above) to
+  the guest.
+
+``hv-memory-hint``
+  Enables guest memory heat hints (HvExtCallMemoryHeatHint).
+
+  Requires: ``hv-extcalls``
+
 Supplementary features
 ----------------------
 
@@ -276,6 +285,11 @@ Supplementary features
   Windows guests from booting when used without proper configuration. If needed,
   ``hv-syndbg`` can be enabled additionally.
 
+  Note: ``hv-passthrough`` enables ``hv-extcalls`` when the host KVM advertises
+  it. It does not enable ``hv-memory-hint``, which is implemented in QEMU and
+  has no KVM CPUID bit. Enable ``hv-memory-hint`` explicitly when guest heat
+  hints should reach the host.
+
   Note: ``hv-passthrough`` effectively prevents migration as the list of enabled
   enlightenments may differ between target and destination hosts.
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 900ff80213..b3fce7b563 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -20,7 +20,9 @@
 #include "system/physmem.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/int128.h"
 #include "qemu/lockable.h"
+#include "qemu/madvise.h"
 #include "qemu/queue.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
@@ -646,6 +648,162 @@ unmap:
     return ret;
 }
 
+uint16_t hyperv_hcall_ext_capabilities(uint64_t outgpa, bool fast,
+                                       bool memory_hint)
+{
+    uint16_t ret;
+    hwaddr len;
+    uint64_t *caps = NULL;
+
+    if (fast) {
+        return HV_STATUS_INVALID_HYPERCALL_CODE;
+    }
+    if (outgpa & (__alignof__(*caps) - 1)) {
+        return HV_STATUS_INVALID_ALIGNMENT;
+    }
+
+    len = sizeof(*caps);
+    caps = physical_memory_map(outgpa, &len, 1);
+    if (!caps || len < sizeof(*caps)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto unmap;
+    }
+
+    *caps = 0;
+    if (memory_hint) {
+        *caps = HV_EXT_CAP_MEMORY_HEAT_HINT;
+        if (QEMU_MADV_COLD != QEMU_MADV_INVALID) {
+            *caps |= HV_EXT_CAP_MEMORY_HEAT_HINT_COLD;
+        }
+    }
+    ret = HV_STATUS_SUCCESS;
+
+unmap:
+    if (caps) {
+        physical_memory_unmap(caps, len, 1, ret == HV_STATUS_SUCCESS ? len : 0);
+    }
+    return ret;
+}
+
+static bool hv_decode_gpa_page_range(uint64_t raw, hwaddr *gpa, hwaddr *len)
+{
+    uint64_t pages = (raw & HV_GPA_PAGE_RANGE_ADDITIONAL_MASK) + 1;
+
+    if (raw & HV_GPA_PAGE_RANGE_LARGEPAGE) {
+        if (raw & HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB) {
+            *gpa = raw & HV_GPA_PAGE_RANGE_1G_GPA_MASK;
+            *len = pages << 30;
+        } else {
+            *gpa = raw & HV_GPA_PAGE_RANGE_2M_GPA_MASK;
+            *len = pages << 21;
+        }
+    } else {
+        *gpa = raw & HV_GPA_PAGE_RANGE_4K_GPA_MASK;
+        *len = pages << 12;
+    }
+
+    return *len != 0;
+}
+
+static void hv_madvise_gpa_range(hwaddr gpa, hwaddr len, int advice)
+{
+    while (len) {
+        MemoryRegionSection section;
+        hwaddr chunk, start, skip;
+        void *host;
+
+        section = memory_region_find(get_system_memory(), gpa, len);
+        if (!section.mr) {
+            break;
+        }
+
+        start = section.offset_within_address_space;
+        chunk = int128_get64(section.size);
+
+        if (!chunk || start < gpa) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        skip = start - gpa;
+        if (skip >= len || chunk > len - skip) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        gpa = start + chunk;
+        len -= skip + chunk;
+
+        if (memory_region_is_ram(section.mr) &&
+            !memory_region_is_rom(section.mr) &&
+            !memory_region_is_romd(section.mr)) {
+            host = memory_region_get_ram_ptr(section.mr) +
+                   section.offset_within_region;
+            qemu_madvise(host, chunk, advice);
+        }
+        memory_region_unref(section.mr);
+    }
+}
+
+uint16_t hyperv_hcall_memory_hint(uint64_t in_gpa, uint16_t rep_count,
+                                  bool fast)
+{
+    uint16_t ret = HV_STATUS_SUCCESS;
+    hwaddr in_len, needed;
+    struct hyperv_memory_heat_hint *in = NULL;
+    unsigned int i;
+    uint64_t heat_type;
+    int advice;
+
+    if (fast) {
+        return HV_STATUS_INVALID_HYPERCALL_CODE;
+    }
+    if (rep_count < 1 || rep_count > HV_EXT_MEMORY_HEAT_HINT_MAX_RANGES) {
+        return HV_STATUS_INVALID_HYPERCALL_INPUT;
+    }
+    if (in_gpa & (__alignof__(*in) - 1)) {
+        return HV_STATUS_INVALID_ALIGNMENT;
+    }
+
+    needed = sizeof(in->heat_type) + sizeof(in->ranges[0]) * rep_count;
+    in_len = TARGET_PAGE_SIZE;
+    in = physical_memory_map(in_gpa, &in_len, 0);
+    if (!in || in_len < needed) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto unmap;
+    }
+
+    heat_type = in->heat_type & 3;
+    switch (heat_type) {
+    case HV_EXTMEM_HEAT_HINT_HOT:
+        advice = QEMU_MADV_WILLNEED;
+        break;
+    case HV_EXTMEM_HEAT_HINT_COLD:
+    case HV_EXTMEM_HEAT_HINT_COLD_DISCARD:
+        advice = QEMU_MADV_COLD;
+        break;
+    default:
+        ret = HV_STATUS_INVALID_PARAMETER;
+        goto unmap;
+    }
+
+    for (i = 0; i < rep_count; i++) {
+        hwaddr gpa, len;
+        uint64_t raw = in->ranges[i];
+
+        if (!hv_decode_gpa_page_range(raw, &gpa, &len)) {
+            continue;
+        }
+        hv_madvise_gpa_range(gpa, len, advice);
+    }
+
+unmap:
+    if (in) {
+        physical_memory_unmap(in, in_len, 0, 0);
+    }
+    return ret;
+}
+
 static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
 {
     int ret;
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index fffc5ce342..67e6f72a90 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -35,7 +35,32 @@
 #define HV_POST_DEBUG_DATA                    0x0069
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
+#define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
+#define HV_EXT_CALL_MEMORY_HEAT_HINT          0x8003
 #define HV_HYPERCALL_FAST                     (1u << 16)
+#define HV_HYPERCALL_REP_COMP_OFFSET          32
+#define HV_HYPERCALL_REP_COMP_MASK            0xfff
+
+#define HV_EXT_CAP_MEMORY_HEAT_HINT           (1ull << 1)
+#define HV_EXT_CAP_MEMORY_HEAT_HINT_COLD      (1ull << 2)
+#define HV_EXT_MEMORY_HEAT_HINT_MAX_RANGES    511
+
+#define HV_EXTMEM_HEAT_HINT_COLD              0
+#define HV_EXTMEM_HEAT_HINT_HOT               1
+#define HV_EXTMEM_HEAT_HINT_COLD_DISCARD      2
+
+struct hyperv_memory_heat_hint {
+    uint64_t heat_type;
+    uint64_t ranges[HV_EXT_MEMORY_HEAT_HINT_MAX_RANGES];
+};
+
+/* HV_GPA_PAGE_RANGE in each heat-hint range qword */
+#define HV_GPA_PAGE_RANGE_ADDITIONAL_MASK     0x7ffull
+#define HV_GPA_PAGE_RANGE_LARGEPAGE           (1ull << 11)
+#define HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB       (1ull << 12)
+#define HV_GPA_PAGE_RANGE_4K_GPA_MASK         (~0xfffull)
+#define HV_GPA_PAGE_RANGE_2M_GPA_MASK         (~0x1fffffull)
+#define HV_GPA_PAGE_RANGE_1G_GPA_MASK         (~0x3fffffffull)
 
 /*
  * Message size
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 23091301d0..8cccbb91ba 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -70,6 +70,19 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast);
  * the connection as specified in @param.
  */
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast);
+/*
+ * Process HV_EXT_CALL_QUERY_CAPABILITIES hypercall: list supported ext hcall
+ * fill the capabilities bit array in @outgpa.
+ */
+uint16_t hyperv_hcall_ext_capabilities(uint64_t outgpa, bool fast,
+                                       bool memory_hint);
+/*
+ * Process HV_EXT_CALL_MEMORY_HEAT_HINT hypercall: receive a list of hot/cold
+ * pages and call madvice on them.
+ */
+uint16_t hyperv_hcall_memory_hint(uint64_t in_gpa, uint16_t rep_count,
+                                  bool fast);
+
 
 static inline uint32_t hyperv_vp_index(CPUState *cs)
 {
diff --git a/include/qemu/madvise.h b/include/qemu/madvise.h
index e155f59a0d..fd638c2254 100644
--- a/include/qemu/madvise.h
+++ b/include/qemu/madvise.h
@@ -59,6 +59,11 @@
 #else
 #define QEMU_MADV_POPULATE_WRITE QEMU_MADV_INVALID
 #endif
+#ifdef MADV_COLD
+#define QEMU_MADV_COLD MADV_COLD
+#else
+#define QEMU_MADV_COLD QEMU_MADV_INVALID
+#endif
 
 #elif defined(CONFIG_POSIX_MADVISE)
 
@@ -73,6 +78,7 @@
 #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
 #define QEMU_MADV_REMOVE QEMU_MADV_DONTNEED
 #define QEMU_MADV_POPULATE_WRITE QEMU_MADV_INVALID
+#define QEMU_MADV_COLD QEMU_MADV_INVALID
 
 #else /* no-op */
 
@@ -87,6 +93,7 @@
 #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
 #define QEMU_MADV_REMOVE QEMU_MADV_INVALID
 #define QEMU_MADV_POPULATE_WRITE QEMU_MADV_INVALID
+#define QEMU_MADV_COLD QEMU_MADV_INVALID
 
 #endif
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e65eca0459..263523d052 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10824,6 +10824,9 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_EXT, 0),
     DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-extcalls", X86CPU, hyperv_features,
+                      HYPERV_FEAT_EXT_HYPERCALLS, 0),
+    DEFINE_PROP_BOOL("hv-memory-hint", X86CPU, hyperv_memory_hint, false),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e90371..3c9da61e17 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1489,6 +1489,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_XMM_INPUT           18
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
+#define HYPERV_FEAT_EXT_HYPERCALLS      21
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
@@ -2374,6 +2375,7 @@ struct ArchCPU {
     uint32_t hyperv_spinlock_attempts;
     char *hyperv_vendor;
     uint64_t hyperv_features;
+    bool hyperv_memory_hint;
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
     uint32_t hyperv_vendor_id[3];
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..e88913fd37 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -66,6 +66,7 @@
  * HV_CPUID_FEATURES.EBX bits
  */
 #define HV_PARTITION_DEBUGGING_ALLOWED          (1u << 12)
+#define HV_ENABLE_EXTENDED_HYPERCALLS           (1u << 20)
 
 /*
  * HV_CPUID_ENLIGHTMENT_INFO.EAX bits
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 420c76b5ff..9d97f5cb4e 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -97,6 +97,13 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
         uint64_t in_param = exit->u.hcall.params[0];
         uint64_t out_param = exit->u.hcall.params[1];
+        uint64_t rep_count = (exit->u.hcall.input >> 32) & 0xFFF;
+
+        if ((code & 0x8000) &&
+            !hyperv_feat_enabled(cpu, HYPERV_FEAT_EXT_HYPERCALLS)) {
+            exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
+            return 0;
+        }
 
         switch (code) {
         case HV_POST_MESSAGE:
@@ -117,6 +124,23 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
             exit->u.hcall.result =
                 hyperv_hcall_reset_dbg_session(out_param);
             break;
+        case HV_EXT_CALL_QUERY_CAPABILITIES:
+            exit->u.hcall.result = hyperv_hcall_ext_capabilities(
+                out_param, fast, cpu->hyperv_memory_hint);
+            break;
+        case HV_EXT_CALL_MEMORY_HEAT_HINT:
+            if (!cpu->hyperv_memory_hint) {
+                exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
+                break;
+            }
+            exit->u.hcall.result =
+                hyperv_hcall_memory_hint(in_param, rep_count, fast);
+            if (exit->u.hcall.result == HV_STATUS_SUCCESS) {
+                exit->u.hcall.result |=
+                    (rep_count & HV_HYPERCALL_REP_COMP_MASK) <<
+                    HV_HYPERCALL_REP_COMP_OFFSET;
+            }
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 072da8b9f1..46c983f963 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1137,6 +1137,13 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_VAPIC)
     },
+    [HYPERV_FEAT_EXT_HYPERCALLS] = {
+        .desc = "enable extended hypercalls (hv-extcalls)",
+        .flags = {
+            {.func = HV_CPUID_FEATURES, .reg = R_EBX,
+             .bits = HV_ENABLE_EXTENDED_HYPERCALLS}
+        }
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
-- 
2.54.0 (Apple Git-157)

