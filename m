Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA126738D;
	Thu, 23 Apr 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954947; cv=none; b=rreRF0jaVx546/QWfacjQMEMjXPjB8vP8QIIDIKXwaDaLi8DREdNBMuEV3z6A3ySJrJh4faUYpuVZrPDsjAjvXc598IsDL+iJCzvMdAklvP43ulSMu6RqNGU3BU+iFGTtFlMp63R1RLdAYTQNcj/yc5ZVEYGmguNbEBI3w0MBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954947; c=relaxed/simple;
	bh=OMGeLsgioTkHHLxeCnJhrUysV+1q3MfJxi2HDU54oXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iy53uErjxjSHSTwjV0yKz1dHWHSFE3AB/652dNSXzoI/UpiA7FbjWu7RToAtn4zoKRWB19gUihucTXfX1GcklKVFXCDeEJcsVbtgCJKLLmYuebIPIXzTboYMEJLGIoMSssFAHJ3FuadhWg80ShUM387osI/O+8tnCdIgQttZp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G0wHVras; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G0wHVras"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4YyMjBFiPOnGuBXMPVwoM9waQISBqY2z4XZ3cApzeeA=; b=G0wHVras4mwnchSfOrvmpVgbxC
	eQ7t9IPvojAF9tlN6BGG+Vk/Kd6ZLj4Tg0aDSPC41fHrGdmj8QFjUOgLikqBX5K0ttXDvLv/fDDQY
	RRnJKOdbjC66kTPWbYHmbOFm5/9Bf8Q6JRO7t0qbx8thcrQofl6eZqgB4JcqP//eX1C3vuTSrYens
	QFscedKTVFmnjTPSNPucW8WAlwv5HGdzBgndnM4wy/ea6aUF8fypG2/axldjHEwOIJ2MNaVhcWrkX
	6FKqCCiGgyNVP0YAHflWKDDgt8R+aJj7GBzVoURgdTEV+Udc+RWBTskEmDwHwthJvyTI3JdumKBR5
	YP+c4PGg==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFv9X-0000000DGxA-0BFv;
	Thu, 23 Apr 2026 14:35:39 +0000
Message-ID: <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
From: David Woodhouse <dwmw2@infradead.org>
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, Andrew Cooper
	 <andrew.cooper3@citrix.com>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Cc: pbonzini@redhat.com, seanjc@google.com, corbet@lwn.net,
 tglx@linutronix.de,  mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org,  hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com, 
 chao.gao@intel.com, hch@infradead.org, sohil.mehta@intel.com
Date: Thu, 23 Apr 2026 15:35:38 +0100
In-Reply-To: <20251026201911.505204-1-xin@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ZgEcEGZhlgYXALCCOqbZ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-ZgEcEGZhlgYXALCCOqbZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-10-26 at 13:18 -0700, Xin Li (Intel) wrote:
> This patch set enables the Intel flexible return and event delivery
> (FRED) architecture with KVM VMX to allow guests to utilize FRED.

This could do with having a *lot* of KVM selftests.

Here's one to get you started (untested as I haven't found suitable
hardware to test it on).

=46rom bd465aabebcb124e09a26fe9f4c861354febabe4 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Thu, 23 Apr 2026 15:20:11 +0100
Subject: [PATCH] KVM: selftests: Add FRED event type classification test

Test that software-generated events deliver the correct FRED event
type in the FRED stack frame.

In FRED mode, the CPU pushes event metadata including the event type
into the FRED stack frame. Different instruction types should produce
different event types:
  - ICEBP (INT1): EVENT_TYPE_PRIV_SWEVT (5)
  - INT3:         EVENT_TYPE_SWEXC (6)
  - INT n:        EVENT_TYPE_SWINT (4)

The test sets up a guest in FRED mode by enabling CR4.FRED and
configuring the FRED MSRs, with a hand-written FRED entry point that
extracts the event type from the FRED SS field. It exercises each
software event type and verifies the classification is correct.

Requires KVM guest FRED support (the FRED KVM VMX series) and
hardware FRED support. Skips if either is unavailable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/int1_fred_test.c        | 225 ++++++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/int1_fred_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 148d427ff24b..62e76617f82f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -74,6 +74,7 @@ TEST_GEN_PROGS_x86 +=3D x86/feature_msrs_test
 TEST_GEN_PROGS_x86 +=3D x86/exit_on_emulation_failure_test
 TEST_GEN_PROGS_x86 +=3D x86/fastops_test
 TEST_GEN_PROGS_x86 +=3D x86/fix_hypercall_test
+TEST_GEN_PROGS_x86 +=3D x86/int1_fred_test
 TEST_GEN_PROGS_x86 +=3D x86/hwcr_msr_test
 TEST_GEN_PROGS_x86 +=3D x86/hyperv_clock
 TEST_GEN_PROGS_x86 +=3D x86/hyperv_cpuid
diff --git a/tools/testing/selftests/kvm/x86/int1_fred_test.c b/tools/testi=
ng/selftests/kvm/x86/int1_fred_test.c
new file mode 100644
index 000000000000..7ffb54b56047
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/int1_fred_test.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test FRED event type classification for software-generated events.
+ *
+ * In FRED mode, the CPU pushes event metadata including the event type
+ * into the FRED stack frame SS field. This test verifies the correct
+ * event type for:
+ *   - ICEBP (INT1, opcode 0xF1): EVENT_TYPE_PRIV_SWEXC (5)
+ *   - INT3 (opcode 0xCC):        EVENT_TYPE_SWEXC (6)
+ *   - INT n (opcode 0xCD nn):    EVENT_TYPE_SWINT (4)
+ *
+ * The FRED stack page is evicted via MADV_DONTNEED before each test
+ * to also exercise EPT/NPT fault handling during FRED frame push.
+ *
+ * This test requires KVM guest FRED support and hardware FRED support.
+ * It will skip if either is unavailable.
+ */
+#include <stdint.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+/* FRED: CPUID.(EAX=3D7,ECX=3D1):EAX bit 17 */
+#define X86_FEATURE_FRED	KVM_X86_CPU_FEATURE(7, 1, EAX, 17)
+
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc
+#define MSR_IA32_FRED_STKLVLS	0x1d0
+#define MSR_IA32_FRED_CONFIG	0x1d4
+
+/* FRED event types (from arch/x86/include/asm/trapnr.h) */
+#define EVENT_TYPE_SWINT	4	/* INT n */
+#define EVENT_TYPE_PRIV_SWEXC	5	/* INT1 (ICEBP) */
+#define EVENT_TYPE_SWEXC	6	/* INTO, INT3 */
+
+/* FRED SS field layout */
+#define FRED_SS_TYPE_SHIFT	48
+#define FRED_SS_TYPE_MASK	(0xfULL << FRED_SS_TYPE_SHIFT)
+#define FRED_SS_VECTOR_SHIFT	32
+#define FRED_SS_VECTOR_MASK	(0xffULL << FRED_SS_VECTOR_SHIFT)
+
+/* CR4.FRED (bit 32) */
+#define X86_CR4_FRED		(1ULL << 32)
+
+/* Guest memory layout */
+#define FRED_STACK_GPA		0xc0000000ULL
+#define FRED_STACK_SIZE		PAGE_SIZE
+
+/*
+ * FRED stack frame as pushed by the CPU on event delivery.
+ * Layout from low address (RSP) to high address:
+ *
+ *   RSP+0x00: error code
+ *   RSP+0x08: RIP (return address)
+ *   RSP+0x10: CS (with auxiliary info in upper bits)
+ *   RSP+0x18: RFLAGS
+ *   RSP+0x20: RSP (original)
+ *   RSP+0x28: SS (with event type/vector in upper bits)
+ */
+struct fred_stack_frame {
+	uint64_t error_code;
+	uint64_t rip;
+	uint64_t cs;
+	uint64_t rflags;
+	uint64_t rsp;
+	uint64_t ss;
+};
+
+/* Shared result area */
+static volatile uint64_t fred_ss_value;
+static volatile uint64_t fred_saved_rip;
+static volatile bool fred_handler_called;
+
+static void __used fred_handler(struct fred_stack_frame *frame)
+{
+	fred_ss_value =3D frame->ss;
+	fred_saved_rip =3D frame->rip;
+	fred_handler_called =3D true;
+}
+
+/*
+ * FRED entry points. MSR_IA32_FRED_CONFIG points to the page-aligned
+ * base. Ring 3 events enter at base+0, ring 0 events at base+0x100.
+ * Since ICEBP executes in ring 0, the CPU enters at fred_entrypoint
+ * + 256 =3D fred_entrypoint_kernel.
+ */
+extern void fred_entrypoint(void);
+
+asm(
+	".pushsection .text\n"
+	".global fred_entrypoint\n"
+	".balign 4096\n"
+"fred_entrypoint:\n"
+	/* Ring 3 entry =E2=80=94 unused, no userspace in this test */
+	"ud2\n"
+	/* Pad to +256 for ring 0 entry */
+	".org fred_entrypoint + 256, 0xcc\n"
+"fred_entrypoint_kernel:\n"
+	"movq %rsp, %rdi\n"
+	"call fred_handler\n"
+	".byte 0xf2, 0x0f, 0x01, 0xca\n"	/* ERETS */
+	".popsection\n"
+);
+
+static void check_fred_event(uint64_t expected_rip, uint8_t expected_vecto=
r,
+			     uint8_t expected_type, const char *name)
+{
+	uint64_t event_type, event_vector;
+
+	GUEST_ASSERT(fred_handler_called);
+	GUEST_ASSERT_EQ(fred_saved_rip, expected_rip);
+
+	event_type =3D (fred_ss_value & FRED_SS_TYPE_MASK) >> FRED_SS_TYPE_SHIFT;
+	event_vector =3D (fred_ss_value & FRED_SS_VECTOR_MASK) >> FRED_SS_VECTOR_=
SHIFT;
+
+	GUEST_ASSERT_EQ(event_vector, expected_vector);
+	GUEST_ASSERT_EQ(event_type, expected_type);
+}
+
+static void guest_code(void)
+{
+	uint64_t expected_rip;
+
+	/*
+	 * Enable FRED:
+	 *  1. Set MSR_IA32_FRED_CONFIG to our entry point
+	 *  2. Set MSR_IA32_FRED_RSP0 to our FRED stack
+	 *  3. Set MSR_IA32_FRED_STKLVLS (all events use stack level 0)
+	 *  4. Set CR4.FRED
+	 */
+	wrmsr(MSR_IA32_FRED_CONFIG, (uint64_t)fred_entrypoint);
+	wrmsr(MSR_IA32_FRED_RSP0, FRED_STACK_GPA + FRED_STACK_SIZE);
+	wrmsr(MSR_IA32_FRED_STKLVLS, 0);
+
+	{
+		uint64_t cr4;
+		asm volatile("mov %%cr4, %0" : "=3Dr"(cr4));
+		cr4 |=3D X86_CR4_FRED;
+		asm volatile("mov %0, %%cr4" :: "r"(cr4));
+	}
+
+	/* Test 1: ICEBP (INT1) =E2=80=94 should be EVENT_TYPE_PRIV_SWEXC (5) */
+	fred_handler_called =3D false;
+	asm volatile("lea 1f(%%rip), %0\n\t"
+		     ".byte 0xf1\n\t"
+		     "1:" : "=3Dr"(expected_rip) :: "memory");
+	check_fred_event(expected_rip, DB_VECTOR, EVENT_TYPE_PRIV_SWEXC,
+			 "ICEBP");
+	GUEST_SYNC(0);
+
+	/* Test 2: INT3 =E2=80=94 should be EVENT_TYPE_SWEXC (6) */
+	fred_handler_called =3D false;
+	asm volatile("lea 1f(%%rip), %0\n\t"
+		     "int3\n\t"
+		     "1:" : "=3Dr"(expected_rip) :: "memory");
+	check_fred_event(expected_rip, BP_VECTOR, EVENT_TYPE_SWEXC, "INT3");
+	GUEST_SYNC(1);
+
+	/* Test 3: INT $0x20 =E2=80=94 should be EVENT_TYPE_SWINT (4) */
+	fred_handler_called =3D false;
+	asm volatile("lea 1f(%%rip), %0\n\t"
+		     "int $0x20\n\t"
+		     "1:" : "=3Dr"(expected_rip) :: "memory");
+	check_fred_event(expected_rip, 0x20, EVENT_TYPE_SWINT, "INT $0x20");
+	GUEST_SYNC(2);
+}
+
+static const char * const test_names[] =3D {
+	[0] =3D "ICEBP (EVENT_TYPE_PRIV_SWEXC)",
+	[1] =3D "INT3 (EVENT_TYPE_SWEXC)",
+	[2] =3D "INT $0x20 (EVENT_TYPE_SWINT)",
+};
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	unsigned int nr_pages;
+	void *fred_stack_hva;
+	int test;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
+
+	pr_info("Testing FRED event types with EPT fault on stack\n");
+
+	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/* Map the FRED stack page */
+	nr_pages =3D vm_calc_num_guest_pages(VM_MODE_DEFAULT, FRED_STACK_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    FRED_STACK_GPA, 1, nr_pages, 0);
+	virt_map(vm, FRED_STACK_GPA, FRED_STACK_GPA, nr_pages);
+	fred_stack_hva =3D addr_gpa2hva(vm, FRED_STACK_GPA);
+
+	for (test =3D 0; test < ARRAY_SIZE(test_names); test++) {
+		/*
+		 * Evict the FRED stack page so the CPU takes an EPT/NPT
+		 * violation when pushing the FRED frame. KVM must handle
+		 * the fault, map the page, and reinject the event.
+		 */
+		madvise(fred_stack_hva, FRED_STACK_SIZE, MADV_DONTNEED);
+
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], test);
+			pr_info("  %s: PASSED\n", test_names[test]);
+			break;
+		default:
+			TEST_FAIL("Unexpected ucall");
+		}
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
--=20
2.43.0





--=-ZgEcEGZhlgYXALCCOqbZ
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQyMzE0MzUz
OFowLwYJKoZIhvcNAQkEMSIEIKCMxXv1FMF2aLHr1t8lQ5LjlBbqKS4+Xo+NzsE27EzsMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAkGC9UzuM6wo5
AKL/nAh9NOrKBZNIu9mJ2hl1rnR/khdry7TzY454xK8PMh+Ofb95blsp/pV8UVipmm4nNQ98cSEa
D0AkgANReYuRXZmO9G30h59gvinyqGJALGvflqqkgOgZnZFFFpb2fWnu5MpyJHsq7h8joJ8z+AtG
Rlx9r8QJkZ4+6B3Y5VObH1HEO4ieI6eD3csl3v71ecfGX9W7YqK/hc8VyRi9Rf6ctf2/W9NlI3D9
ZN4FuEXzRmZvcHZgpy3plqkRB5ar1ZeJwFz3nwb/R3o4z/qj7LQy4Lb0MU0l5lOEZQTjooMqZ0pv
ojYp5jwAm+sIAwPCirkfuMT+U4fNjosMq5ssX6icbAX0LGN2te7WwHXOBlshN93GeQevU1KVtpsb
P9TaVyibf+O1cXl5fW68hf7P0auIxwXqZg7F3QHfRV8cCxZGU1FMALcE9S1AqX/7xzZd3WX6XP8/
P5kMK5z4IphQ8ZcgSum41UwxZbsPmaiF96kdbBLcp4+zS+FT6+ooQq7SNGwPu8vK9mwHOQQ0Pt06
FKkNZ5Qu3sV8fX81/xH7bjGyPjPEommlQopxKTpDTeDa7kw/wxeyv6nbfnnFTLF6f93MHbQdo9DI
aYrLvCBt1BXaWKaErXMQoRocps+tomPhbwtCixqqsTgorzAO9o1N+VuCcyyqYy8AAAAAAAA=


--=-ZgEcEGZhlgYXALCCOqbZ--
