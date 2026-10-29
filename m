Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304138;
	b=Y4FsJHJUVYt7kXw8+JcfjXYGL2ptLJAdJZWkmSBgjF1yyIXvylEomUmHRaZ7OHtbvdPM
	 N/Sy1yeyLj9+kdL8+P9GmZPaf6La6XNQJ8jsyJ+NdTEkKaInsJsQAEVbASXzwGv2Kf6Pc
	 vA7RxVvK/o/+R9NsbGBkoEKyNbJDdS4l9R523eIfhlwizqvrGGojaZ0JBc9Mg15ohzX+v
	 iMJWXepvOATJnSob/XZ8vrxJBF8A24aHnQg2h2Va1ReLvtG81TbDiM8iHoiztwy8vniLQ
	 ZgRndgmVyv5HYQd51ApRlhLNpJIq6JjIN6cx+WTK6gQcQTrf10J1NcEgQJwyoZyLSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0xa+qYExfQ0UvwWONtjWQ1/DLGi51X3UeuFAKNtiYWI=;
	b=SIxo4eEctLeBiMhHASTG5fIR81H77tz7SIbsgbztgUPa78xqme4673ke4Fy0JAh5S79Z
	 ztTd/7tmOE8aitxONEIE6ttRBMN10bV+i81EwG5fRPLepzzhht4JW/UyJLJujTSgDW/4B
	 pFI1U/Y7jScRZYjrCHvQ8gpW+zmWOu7YDXt4wgRG958LyHKezGtmtjGal8lCrq4CROCgM
	 kimsIcKtyZb0j6qT+vSGxe7AiD7qtxe42sOd/pcKTIrVpc6SPBkTi3J70uTZtjhcC+onw
	 BIT9VZH+9fyd2V9/FQrVWo4Jw4UbUETTRYz+9NNAf/FeWj4uEwxeN1OUniep0rJgFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=kJW8rxTe;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC7606A322
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67DC7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=kJW8rxTe
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so17434785e9.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1793304137; x=1793908937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0xa+qYExfQ0UvwWONtjWQ1/DLGi51X3UeuFAKNtiYWI=;
        b=kJW8rxTeS96EEQz9gpOxtTRYoskJr5/yzh8w8yWmhPe+VXJ3QXtL6gCVLSXOnvXKTh
         ds8LtiL0Wq5W61DvbGIRIGuRd9kxSQgzMcIL9POhPBJUane09ffwCAGpItRwulsjaAi2
         vOHJ1Buf1EJ9OEIjwOgJYuFY8mkNkN9pT+goQZ/5ubUmLnLDuuZnqVTFyaxnONCA+5Yj
         koumPWohFZoDAno7o8h/YT23hLOgZLd+yjY3rW16NyUyZ+7ETBwxh22nOHuajncsdswd
         dm91ULV64ud1Eq8ItIU/DkXNCJL3qNJeqEoQdA+0JdrEn+5AgqNhU0sQYuNmDY1bLOBl
         BvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304137; x=1793908937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0xa+qYExfQ0UvwWONtjWQ1/DLGi51X3UeuFAKNtiYWI=;
        b=L3TjNUygRiap3sEcja9dpYf+Uf1pQYHiOaeRmZSoBIpXvk3adAGTAOPx2tRemkMeFu
         +5UPI5N9Io+grZqpiIBiATkdELjzWqtyVJ0m1LXrF8thD37ZhH3WQ84sergFfXAbxQPe
         /UmUZ5lUXM2uPj+2begpD9688GIgrRqjq5QIycEZp1yWZF06/R3id+zTm5A3sA6GODjs
         efkSpUnEKwnV/0JXzh1pE+O+KnnCj4677tMHrKwbqrtj5Li4XWvHLpYUVSXozrBeaFJJ
         28uUxx/XI/AFpLWxlns9rPpoFpuzMCPZ58aXnF58aKFI/U7lBmrIPAnANXis27WN8IO5
         6iRA==
X-Gm-Message-State: AFq9FYKIJDASSKwxHLLAJKSw21WqWHPufol9wd3uCAzo3DcRQ2K94VYB
	FuF6EWXazgvznwklbKAzj1xnoT1PIZUl0h+QHLTQBe6MGlzVMKL2FG6AuAls6fmZH3o=
X-Gm-Gg: AYBFou3Z3jY2CX/TifsY7ELBtKHWsLdPzPYaH44N3x+m/wCQ4esYvf4c82041j4BOrK
	nsf7snw1hm4yb2OttIaKTiPx3DzW2Q0QnKAvtYk+h603Bm4I/Hqg+07zMZQ0Ho76s5CoQtK+R78
	8GNkUlUpN7UVSSVY+CMw0jhHoJWFwE11G2uaF0kZdYb6UK/RE0KG0H83LnmGTij3OSSKfcJFqzZ
	U9UwUrs0hnTrkbG9dVxW7YfUnNKRc+RzYaE3lJWJSTuGPlrKARzJmEjc5qrVPF1SVilNQk7ie3o
	S0YIxrUdtAoKnPlfsYpZzpkv8yy9EB9VcRdt6eoYfBR4/+nLSWxb+bAoVB4fegnIzv5NTX1NYRw
	V78KytPQeskhGD3Cf3Eb4VE+QJ8AYrBqstpDSdwakAV9lSpN9c1aMEp/Z1OEgyFhpyjMqVhtnMj
	YUmFQHqdY7h9KavwAyb83arhH6NDbt2jOB+3YswrgCEAyYgP11dywdmdq58zYPBRmKYAzS6ob71
	WKYbbgr0O2SWyC8q+snMguMqBX1/Ek7k9PwSIx9GXvihsGIm7A603g04lG08a2mlbZOJvn89oDS
	PvJ+qm66IhJ07+YSP9vJUuqo4g==
X-Received: by 2002:a05:600c:46d2:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4ac187a6a38mr817625e9.19.1793304136818;
        Thu, 29 Oct 2026 13:02:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm7417635e9.5.2026.10.29.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:02:16 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	den@openvz.org
Subject: [kvm-unit-tests PATCH] x86: add ioapic_eoi_race test for unmasking a pending level pin
Date: Thu, 29 Oct 2026 21:02:14 +0100
Message-ID: <20261029200214.1241130-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029-kvm-ioapic-eoi-v1-den@openvz.org>
References: <20261029-kvm-ioapic-eoi-v1-den@openvz.org>
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

Raise a level line while its I/O APIC pin is masked, then switch the pin
to a new vector and unmask it, either in one write or with a masked
write followed by an unmask. The destination vCPU EOIs with the line
still high and checks that the I/O APIC redelivered the interrupt, which
proves the EOI cleared Remote IRR.

KVM's in-kernel I/O APIC injects the pending interrupt before the
destination vCPUs rescan ioapic_handled_vectors, so a single-write
unmask loses the EOI and leaves the pin dead. Windows programs its
redirection entries this way.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
The KVM fix is "[PATCH] KVM: x86: Fix lost EOI when unmasking a pending
level IOAPIC pin", posted separately. Without it the single-write case
fails on a nested Intel host with APICv; with it, and with
kernel_irqchip=split, both cases pass.

 x86/Makefile.x86_64   |   2 +-
 x86/ioapic_eoi_race.c | 150 ++++++++++++++++++++++++++++++++++++++++++
 x86/unittests.cfg     |   5 ++
 3 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 x86/ioapic_eoi_race.c

diff --git a/x86/Makefile.x86_64 b/x86/Makefile.x86_64
index 8134952..16aa362 100644
--- a/x86/Makefile.x86_64
+++ b/x86/Makefile.x86_64
@@ -13,7 +13,7 @@ tests = $(TEST_DIR)/access.flat $(TEST_DIR)/apic.flat \
 	  $(TEST_DIR)/emulator.flat $(TEST_DIR)/idt_test.flat \
 	  $(TEST_DIR)/xsave.flat $(TEST_DIR)/rmap_chain.flat \
 	  $(TEST_DIR)/pcid.flat $(TEST_DIR)/debug.flat \
-	  $(TEST_DIR)/ioapic.flat $(TEST_DIR)/memory.flat \
+	  $(TEST_DIR)/ioapic.flat $(TEST_DIR)/ioapic_eoi_race.flat $(TEST_DIR)/memory.flat \
 	  $(TEST_DIR)/pku.flat $(TEST_DIR)/hyperv_clock.flat
 tests += $(TEST_DIR)/syscall.flat
 tests += $(TEST_DIR)/svm.flat
diff --git a/x86/ioapic_eoi_race.c b/x86/ioapic_eoi_race.c
new file mode 100644
index 0000000..5e848ac
--- /dev/null
+++ b/x86/ioapic_eoi_race.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "libcflat.h"
+#include "bitops.h"
+#include "apic.h"
+#include "isr.h"
+#include "processor.h"
+#include "smp.h"
+
+#define LINE	0x0e
+#define VEC	0xb2
+#define REDIR_LO	(0x10 + LINE * 2)
+#define REDIR_HI	(REDIR_LO + 1)
+
+#define LO_MASKED	BIT(16)
+#define LO_LEVEL	BIT(15)
+#define LO_EDGE_PARK	(0xff | LO_MASKED)
+#define LO_LEVEL_PARK	(0xff | LO_LEVEL | LO_MASKED)
+#define LO_LIVE		(VEC | LO_LEVEL)
+
+#define TIMEOUT	100000000L
+
+static volatile int g_done;
+static volatile bool g_redelivered;
+static volatile bool g_second;
+static volatile bool g_stop;
+static volatile bool g_spin_ready;
+
+/*
+ * The first run EOIs with the line still high. If the EOI reaches the
+ * I/O APIC, KVM redelivers the interrupt to this vCPU while handling the
+ * EOI, so it is pending in IRR by the time eoi() returns. The second run
+ * drops the line.
+ */
+static void isr(isr_regs_t *regs)
+{
+	if (!g_second) {
+		eoi();
+		g_redelivered = apic_read_bit(APIC_IRR, VEC);
+		g_second = g_redelivered;
+	} else {
+		g_second = false;
+		set_irq_line(LINE, 0);
+		eoi();
+	}
+	++g_done;
+}
+
+static void receiver(void *data)
+{
+	irq_enable();
+	g_spin_ready = true;
+	while (!g_stop)
+		pause();
+	irq_disable();
+}
+
+static bool remote_irr_set(void)
+{
+	return ioapic_read_reg(REDIR_LO) & BIT(14);
+}
+
+static bool wait_done(int target)
+{
+	long spin;
+
+	for (spin = 0; g_done < target; spin++) {
+		if (spin > TIMEOUT)
+			return false;
+		pause();
+	}
+	return true;
+}
+
+/*
+ * The pin is parked masked on vector 0xff, so VEC is absent from the
+ * receiver's ioapic_handled_vectors. It is parked level-triggered, as an
+ * I/O APIC may ignore an edge request on a masked pin. The line goes high
+ * and the pin is then switched to VEC and unmasked either in one write,
+ * as Windows does, or with VEC written masked first and a second write to
+ * unmask, as Linux does.
+ */
+static int iteration(bool one_write)
+{
+	int before = g_done;
+
+	ioapic_write_reg(REDIR_LO, LO_LEVEL_PARK);
+	set_irq_line(LINE, 1);
+
+	if (!one_write)
+		ioapic_write_reg(REDIR_LO, LO_LIVE | LO_MASKED);
+	ioapic_write_reg(REDIR_LO, LO_LIVE);
+
+	if (!wait_done(before + 1))
+		return -1;
+
+	if (!g_redelivered) {
+		/* switching to edge clears Remote IRR */
+		ioapic_write_reg(REDIR_LO, LO_EDGE_PARK);
+		return 1;
+	}
+
+	if (!wait_done(before + 2) || remote_irr_set())
+		return -1;
+	return 0;
+}
+
+static void run(bool one_write, int n)
+{
+	int i, r, lost = 0, errors = 0;
+
+	for (i = 0; i < n; i++) {
+		r = iteration(one_write);
+		if (r > 0)
+			lost++;
+		else if (r < 0)
+			errors++;
+		set_irq_line(LINE, 0);
+	}
+	report(!lost && !errors, "%s: %d iterations, %d lost EOIs, %d errors",
+	       one_write ? "vector and unmask in one write" :
+			   "masked write, then unmask",
+	       n, lost, errors);
+}
+
+int main(int argc, char **argv)
+{
+	int n = argc > 1 ? atol(argv[1]) : 1000;
+
+	setup_vm();
+	mask_pic_interrupts();
+
+	if (cpu_count() < 2) {
+		report_skip("ioapic EOI race needs 2 cpus");
+		return report_summary();
+	}
+
+	handle_irq(VEC, isr);
+	ioapic_write_reg(REDIR_LO, LO_EDGE_PARK);
+	ioapic_write_reg(REDIR_HI, (u32)id_map[1] << 24);
+
+	on_cpu_async(1, receiver, NULL);
+	while (!g_spin_ready)
+		pause();
+
+	run(false, n);
+	run(true, n);
+
+	g_stop = true;
+	return report_summary();
+}
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index d5efab0..c07afe2 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -49,6 +49,11 @@ smp = 4
 extra_params = -cpu qemu64,+x2apic
 arch = x86_64
 
+[ioapic_eoi_race]
+file = ioapic_eoi_race.flat
+smp = 2
+arch = x86_64
+
 [cmpxchg8b]
 file = cmpxchg8b.flat
 arch = i386
-- 
2.53.0

