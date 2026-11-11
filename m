Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420579;
	b=TwNdNS8yCSqfCDMfcgN3jVpGRPEBVwIxaoaTJMxiXNuB8Xl/suKD7sRaQhCzfe8XQ5FJ
	 7VshseTH5yZobZWxf3DD6x7S0aoiz641QUSp26GS56o8d52W8PZ011rqzx88FsJmUHLwg
	 AHBrCf54MiQeo6Io63tFCHET2OieW61/PMU8HUIoPlAoISgFUjfEkevYu7CQDX+gD4gQz
	 YHf5y11ysbBUtpTF+7MBhZ+mZS64DJJtT9sU+KGbTkPaYMVKsAS+7G7iIQYMA4n4rh9GR
	 Hkyan4G5cAI+ySP6OVYOlU1m6JpTcNU8KgcEA9SyjTjMr3aCRuyjLxEVFf418VzGNbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420579;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=l4f9wq8L35XMCLh4CbxRCOQU8IQcsqUENU27urpKImE=;
	b=E+5THTOiGA+ICIr8Wc5CwhTQGPLgOYYcUb09B+TukuaI8C0xSCdqDfVZGSWNjmLKeUf1
	 pD/WyQtHbqz9e2HhelKGml4OqAlPqlsYFQOmaRq6zQCLeGdDy2HXe6fuFY5kAAXhZOWMF
	 bQL8WqmnQo/UB4u5M3unN5I5HdVPNWpZw7HpxZ6j5TTRJcdsrOrEvKc1MWNv4a6Mq7CLf
	 y0vTcC40yBjQ++7tPfVZH7RkUw6f3MMD81yPN4w1+5WsztpYgTVgJn1w9Nd2Rqj9xPVxw
	 cK6U4fG/YWSbDqLHPBY4aboaU4CCWkc53N94mQlAx8QNTCZpdXCONGddpx/pzDhrg4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MLIRKEfJ;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678D606B783;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3678D606B783
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MLIRKEfJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=l4f9wq8L35XMCLh4CbxRCOQU8IQcsqUENU27urpKImE=; b=MLIRKEfJnxB1TwIx2VDrYem/wp
	undiT0kHlpJcWxk+VWy2xCYVhkMIsyIMAeWxh24FBhEBIu2lMKywZKPnja1HKQSXwF/Y33gO6kyca
	WXlwL0Kq2DLQPV/YG9oI+XBli/8o+pL1qjq1pTy1CmTH1iYC0IiV8Zcz79IA+SV/tj3zrJ9ojvvxa
	PUzzewE/ObZUtcPnZG40e4AA81blUuHAGumU2yxf6eF8IZ+s5UHRJdfcL2I6cFeWkUEYjKHpN8e3w
	d4pr64l14Bkg9YAmgovORiUwuas//gC12prVUdRMYaY0yYL5Etlf5fdNVQsB1r/o/fwcngzj45wP1
	/sMvnE6w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvP-3E2k;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWsz-1fIP;
	Wed, 11 Nov 2026 18:09:23 +0000
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
Subject: [PATCH v13 15/26] KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
Date: Wed, 11 Nov 2026 10:09:11 -0800
Message-ID: <20261111180922.4177927-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that pvclock-abi.h is a UAPI header, use it in xen_shinfo_test.c
instead of locally duplicating the struct definitions.

Drop the tools/ mirror of the header: with the kernel copy now UAPI,
the selftests resolve <asm/pvclock-abi.h> from the installed kernel
headers, which they already depend on, and nothing else in tools/
builds against the mirror — keeping it would only be a file for
check-headers.sh to police with no consumer. The UAPI struct fields
are __u64 (unsigned long long), so switch the verbose printfs away
from PRIu64, which is "lu" on 64-bit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/arch/x86/include/asm/pvclock-abi.h      | 48 -------------------
 .../selftests/kvm/x86/xen_shinfo_test.c       | 33 ++++---------
 2 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 tools/arch/x86/include/asm/pvclock-abi.h

diff --git a/tools/arch/x86/include/asm/pvclock-abi.h b/tools/arch/x86/include/asm/pvclock-abi.h
deleted file mode 100644
index b9fece5fc96d..000000000000
--- a/tools/arch/x86/include/asm/pvclock-abi.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_PVCLOCK_ABI_H
-#define _ASM_X86_PVCLOCK_ABI_H
-#ifndef __ASSEMBLER__
-
-/*
- * These structs MUST NOT be changed.
- * They are the ABI between hypervisor and guest OS.
- * Both Xen and KVM are using this.
- *
- * pvclock_vcpu_time_info holds the system time and the tsc timestamp
- * of the last update. So the guest can use the tsc delta to get a
- * more precise system time.  There is one per virtual cpu.
- *
- * pvclock_wall_clock references the point in time when the system
- * time was zero (usually boot time), thus the guest calculates the
- * current wall clock by adding the system time.
- *
- * Protocol for the "version" fields is: hypervisor raises it (making
- * it uneven) before it starts updating the fields and raises it again
- * (making it even) when it is done.  Thus the guest can make sure the
- * time values it got are consistent by checking the version before
- * and after reading them.
- */
-
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
-
-#define PVCLOCK_TSC_STABLE_BIT	(1 << 0)
-#define PVCLOCK_GUEST_STOPPED	(1 << 1)
-/* PVCLOCK_COUNTS_FROM_ZERO broke ABI and can't be used anymore. */
-#define PVCLOCK_COUNTS_FROM_ZERO (1 << 2)
-#endif /* __ASSEMBLER__ */
-#endif /* _ASM_X86_PVCLOCK_ABI_H */
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index aaa414c677ad..9045f03cf2d3 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -15,6 +15,8 @@
 
 #include <sys/eventfd.h>
 
+#include <asm/pvclock-abi.h>
+
 #define SHINFO_REGION_GVA	0xc0000000ULL
 #define SHINFO_REGION_GPA	0xc0000000ULL
 #define SHINFO_REGION_SLOT	10
@@ -98,23 +100,6 @@ struct sched_poll {
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
-
 struct vcpu_runstate_info {
 	u32 state;
 	u64 state_entry_time;
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

