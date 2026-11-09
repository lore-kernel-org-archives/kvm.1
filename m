Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=1r+Y5ty5bQG8t7fWDT3w7vpBhrQKGyLoMraJQC1Hpi71N7So7z7TyUZ5Rw3/MF9N/pJI
	 oe3E1U4uEKOuu9UiwaJjp9/Qg6ZBhj8vZtnUk0MIgkejfqJLfIcZ2s61vO/wF3xQClICg
	 4G0TNKhqXmWwpfgSHkFJPvAoXkhNFJUhIyZwIJOLSAQDjy6C5ywy4m3RYW4K/Dl7bwD1R
	 gcV+t0r3b4235YMf8TPYKPmcQlqeEKhFAH3r4kSlvgMM+TdQDsTnA3BFbes+qZG1OqHGG
	 fWcFtT5/RQZh4QlUg4UUvFdBjwoWkSiNiHoZPTo1zmaIEAzW2lxbtyfQPEl7lfYp8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=OT/QKs0wsvf6qI0TnfD621/+/S2W6eRxFlyThtM/WtI=;
	b=b6TDz5RBrYgW+Ftz687j++kpuKLjt8gJ6aI+0ePzQv4ixCEhGGXW+OWwyugKGaVt18cD
	 n7PU5932tvTJVZBwPRqQJkayBrTsm/8+ZgjyHJXg66WJna0Cu8hBalLO+mzWgb2r//D4A
	 W7wsugUrH80BMYKq0StR4u962AfwF0gSxwSN1pOsH9fq733j9GNW7QxJmWUIgrIyiV0OQ
	 6Bxg7LstMu1UJlXO/WXSc2tlT7lbLX2BHTIbmfXzYCq/tvxBWstdZkQr5ffNcMiTEyYIf
	 x+VcxITxcUtf09YOautOeJu9GwoBayADHcKRdw/umA0uhAah6AbXNTkCdUfr/SlMxhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LXFhc9QY;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A994606EE8D;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A994606EE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LXFhc9QY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OT/QKs0wsvf6qI0TnfD621/+/S2W6eRxFlyThtM/WtI=; b=LXFhc9QY37K3I2psP1wVzaxpqZ
	sJ4zIa5yo6SoH4KLnnYO5R8WjQYmLr+CAY4P9CjYJrkXRcVsdJhDC02tjiSg/BreUnuMXLt+KpIEr
	S6JYARDFtYAabld2X+pLV3yJW/Ai5XdgIICWIUFbJzqhg6p63sjnf61xRoKpFZG3/PWn+bdDwfAx+
	N6P6vg1AtAElKDWHHlnYz7qW6ZOcuoKkYwcNWDmL7xAjbaXG2Jx3LbdLlKkHL0TYEIVaQE3SwDFZP
	2E6bn3OfkwJNP6OAgX1/lH/drBRIIHz5jxF2LeJf0IqRfAzoCKsSWOnjkCkK3j6W9GpBNAqFiSxim
	z44p4Waw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AYE-27yv;
	Mon, 09 Nov 2026 01:21:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4P-0000000EKUt-00ql;
	Mon, 09 Nov 2026 01:21:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v12 13/24] KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
Date: Sun,  8 Nov 2026 17:20:59 -0800
Message-ID: <20261109012112.3415328-14-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109012112.3415328-1-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
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
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that pvclock-abi.h is a UAPI header, use it in xen_shinfo_test.c
instead of locally duplicating the struct definitions.

Sync the tools/ mirror of the header to the UAPI content: the KVM
selftests include path puts tools/arch/x86/include ahead of the
installed kernel headers, so the mirror is what actually gets used.
That makes the struct fields __u64 (unsigned long long), so switch
the verbose printfs away from PRIu64, which is "lu" on 64-bit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/arch/x86/include/asm/pvclock-abi.h      | 27 +++++++++-------
 .../selftests/kvm/x86/xen_shinfo_test.c       | 31 ++++++-------------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/tools/arch/x86/include/asm/pvclock-abi.h b/tools/arch/x86/include/asm/pvclock-abi.h
index b9fece5fc96d..6d70cf640362 100644
--- a/tools/arch/x86/include/asm/pvclock-abi.h
+++ b/tools/arch/x86/include/asm/pvclock-abi.h
@@ -1,6 +1,9 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_X86_PVCLOCK_ABI_H
 #define _ASM_X86_PVCLOCK_ABI_H
+
+#include <linux/types.h>
+
 #ifndef __ASSEMBLER__
 
 /*
@@ -24,20 +27,20 @@
  */
 
 struct pvclock_vcpu_time_info {
-	u32   version;
-	u32   pad0;
-	u64   tsc_timestamp;
-	u64   system_time;
-	u32   tsc_to_system_mul;
-	s8    tsc_shift;
-	u8    flags;
-	u8    pad[2];
+	__u32   version;
+	__u32   pad0;
+	__u64   tsc_timestamp;
+	__u64   system_time;
+	__u32   tsc_to_system_mul;
+	__s8    tsc_shift;
+	__u8    flags;
+	__u8    pad[2];
 } __attribute__((__packed__)); /* 32 bytes */
 
 struct pvclock_wall_clock {
-	u32   version;
-	u32   sec;
-	u32   nsec;
+	__u32   version;
+	__u32   sec;
+	__u32   nsec;
 } __attribute__((__packed__));
 
 #define PVCLOCK_TSC_STABLE_BIT	(1 << 0)
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index aaa414c677ad..43548d8faa74 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -98,22 +98,7 @@ struct sched_poll {
 	u64 timeout;
 };
 
-struct pvclock_vcpu_time_info {
-	u32   version;
-	u32   pad0;
-	u64   tsc_timestamp;
-	u64   system_time;
-	u32   tsc_to_system_mul;
-	s8    tsc_shift;
-	u8    flags;
-	u8    pad[2];
-} __attribute__((__packed__)); /* 32 bytes */
-
-struct pvclock_wall_clock {
-	u32   version;
-	u32   sec;
-	u32   nsec;
-} __attribute__((__packed__));
+#include <asm/pvclock-abi.h>
 
 struct vcpu_runstate_info {
 	u32 state;
@@ -987,12 +972,14 @@ int main(int argc, char *argv[])
 
 	if (verbose) {
 		printf("Wall clock (v %d) %d.%09d\n", wc->version, wc->sec, wc->nsec);
-		printf("Time info 1: v %u tsc %" PRIu64 " time %" PRIu64 " mul %u shift %u flags %x\n",
-		       ti->version, ti->tsc_timestamp, ti->system_time, ti->tsc_to_system_mul,
-		       ti->tsc_shift, ti->flags);
-		printf("Time info 2: v %u tsc %" PRIu64 " time %" PRIu64 " mul %u shift %u flags %x\n",
-		       ti2->version, ti2->tsc_timestamp, ti2->system_time, ti2->tsc_to_system_mul,
-		       ti2->tsc_shift, ti2->flags);
+		printf("Time info 1: v %u tsc %llu time %llu mul %u shift %d flags %x\n",
+		       ti->version, (unsigned long long)ti->tsc_timestamp,
+		       (unsigned long long)ti->system_time,
+		       ti->tsc_to_system_mul, ti->tsc_shift, ti->flags);
+		printf("Time info 2: v %u tsc %llu time %llu mul %u shift %d flags %x\n",
+		       ti2->version, (unsigned long long)ti2->tsc_timestamp,
+		       (unsigned long long)ti2->system_time,
+		       ti2->tsc_to_system_mul, ti2->tsc_shift, ti2->flags);
 	}
 
 	TEST_ASSERT(wc->version && !(wc->version & 1),
-- 
2.43.0

