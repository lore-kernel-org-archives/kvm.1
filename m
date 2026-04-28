Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD496441041;
	Tue, 28 Apr 2026 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403581; cv=none; b=fsqdnJYxqE5UPRC80hxHX9BQ038xeauW+L1Ck6qAKrgSkI15NkFVmrgiJKtOE3yNEQE10qxm5s0gMQuYhUX4C+VdIk1r5HM2doLAY7fp3+jmbJXdxt2DzTqz8xkUMbaLUqi2pYrPSjw3NBfxI5VNwpdvE1Phn08xJG8cBgz575Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403581; c=relaxed/simple;
	bh=LW20oK5gep1O4hCoBzhzlxKkVMKP6dTyYEq1aE0qMrY=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Nvg0Ni4x8QD/IMS0TAwZVL3PgZtmOPKsP/Bt0Ti3asf5lPwbmEuXibO6/OfLuDAn+y5tph8FPSuDaL8pBhjdZXyW5XWg7E7ipyBV9+RQT3GlpohuWdqW84sVHuheDtRb7k9k0SVj0pi4wZyrqbg2A5EYNXShJ9XJSuCey9HUuPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QzCop7WT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QzCop7WT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:Date:To:From
	:Subject:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MPtT6lfJ1mcwWUBwYq4nwnM8SAjUYS9/wvh+pAM9QBQ=; b=QzCop7WT76dYs8lHjFox/z5pi5
	R/WerepPftvIOiSnWseweT2aFCqbL3YXqbb0HoxJwICUxJZkN3mBUgdjz5VXbCx4dQn0C3Ny+c5Av
	wvicGj1j3F3oN1q2p6M7ZRoDez/KA4zBNEh0JmYsLzL8NW4sIdsP+iiPzefwggJ5Laq6s/d5B/7X/
	UwntkUsPR8A6/F5+yyblwbRYn/CS2n+rQWLcE+AV6FPwzaZoAJU/BdIo+igL1m9UHCOURAnoz4y5b
	qdqVYN9X+qN83xYyBZRkxHsXy/szqKtSW52NAHqanu+v4TSzBHkyHYAegAnm9NqwDKbbtvcAXh+fa
	u7qAvCtA==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHnrL-00000003uCl-1xdv;
	Tue, 28 Apr 2026 19:12:40 +0000
Message-ID: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
Subject: [PATCH] KVM: x86/xen: Add
 KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant
 <paul@xen.org>, kvm@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Tue, 28 Apr 2026 20:12:39 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-qmv3LylIXMZ8XL1hvURK"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-qmv3LylIXMZ8XL1hvURK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 3617c0ee7decb ("KVM: x86/xen: Only write Xen hypercall page for
guest writes to MSR") blocked host-initiated writes from triggering the
Xen hypercall page setup, to fix an SRCU usage violation when the
hypercall MSR index collides with a real MSR written during vCPU reset.

However, some VMMs legitimately need to trigger hypercall page setup
from host context. For example, a VMM may intercept the guest's MSR
write to track an epoch (for kexec/crash recovery), and then replay the
write as a host-initiated KVM_SET_MSRS to populate the hypercall page.
The host_initiated check breaks this use case.

Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE as a new vcpu attribute
that explicitly invokes kvm_xen_write_hypercall_page() under proper
locking. This gives userspace a safe interface to trigger hypercall page
setup without going through the MSR write path, preserving the
host_initiated defence in depth while restoring the lost functionality.

Fixes: 3617c0ee7dec ("KVM: x86/xen: Only write Xen hypercall page for guest=
 writes to MSR")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst                | 11 +++
 arch/x86/include/uapi/asm/kvm.h               |  3 +
 arch/x86/kvm/x86.c                            |  3 +-
 arch/x86/kvm/xen.c                            |  7 ++
 .../selftests/kvm/x86/xen_vmcall_test.c       | 96 +++++++++++++++++++
 5 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t
index 52bbbb553ce1..63423c375a78 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5800,6 +5800,17 @@ KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR
   vector configured with HVM_PARAM_CALLBACK_IRQ. It is disabled by
   setting the vector to zero.
=20
+KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
+  This attribute is available when the KVM_CAP_XEN_HVM ioctl indicates
+  support for KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE. It triggers
+  population of the Xen hypercall page at the guest physical address
+  specified in ``gpa``, just as if the guest had written to the
+  hypercall MSR. This is intended for VMMs that intercept the guest's
+  MSR write (e.g. to track an epoch for kexec/crash recovery) and need
+  to replay the write from host context. Direct host-initiated writes
+  via KVM_SET_MSRS are blocked for safety; this attribute provides the
+  correct alternative.
+
=20
 4.129 KVM_XEN_VCPU_GET_ATTR
 ---------------------------
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kv=
m.h
index 5f2b30d0405c..977f3aa66c18 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -596,6 +596,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
+#define KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE	(1 << 9)
=20
 #define KVM_XEN_MSR_MIN_INDEX			0x40000000u
 #define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
@@ -704,6 +705,8 @@ struct kvm_xen_vcpu_attr {
 #define KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR	0x8
 /* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA */
 #define KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA	0x9
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAG=
E */
+#define KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE 0xa
=20
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..3facf0429c0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4891,7 +4891,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
 		    KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL |
 		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
 		    KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE |
-		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA;
+		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA |
+		    KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE;
 		if (sched_info_on())
 			r |=3D KVM_XEN_HVM_CONFIG_RUNSTATE |
 			     KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..c16b4560c9e7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -907,6 +907,13 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struc=
t kvm_xen_vcpu_attr *data)
 {
 	int idx, r =3D -ENOENT;
=20
+	/*
+	 * kvm_xen_write_hypercall_page() manages its own locking.
+	 * Handle it before taking xen_lock to avoid a deadlock.
+	 */
+	if (data->type =3D=3D KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE)
+		return kvm_xen_write_hypercall_page(vcpu, data->u.gpa) ? -EIO : 0;
+
 	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
 	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
=20
diff --git a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c b/tools/test=
ing/selftests/kvm/x86/xen_vmcall_test.c
index 2585087cdf5c..1536d510ab30 100644
--- a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
@@ -12,6 +12,8 @@
 #include "processor.h"
 #include "hyperv.h"
=20
+#include <string.h>
+
 #define HCALL_REGION_GPA	0xc0000000ULL
 #define HCALL_REGION_SLOT	10
=20
@@ -26,6 +28,10 @@
 #define HVCALL_SIGNAL_EVENT		0x005d
 #define HV_STATUS_INVALID_ALIGNMENT	4
=20
+enum {
+	TEST_WRITE_HYPERCALL_PAGE =3D 1,
+};
+
 static void guest_code(void)
 {
 	unsigned long rax =3D INPUTVALUE;
@@ -76,17 +82,65 @@ static void guest_code(void)
 			     "r"(r8));
 	GUEST_ASSERT(rax =3D=3D HV_STATUS_INVALID_ALIGNMENT);
=20
+	/*
+	 * Test KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE: ask userspace
+	 * to set up MSR filtering, then write the MSR. The WRMSR will exit
+	 * to userspace (not populate the page). Userspace verifies the page
+	 * is empty, uses the attr to populate it, then resumes us.
+	 */
+	GUEST_SYNC(TEST_WRITE_HYPERCALL_PAGE);
+
+	__asm__ __volatile__("wrmsr" : : "c" (XEN_HYPERCALL_MSR),
+			     "a" (HCALL_REGION_GPA & 0xffffffff),
+			     "d" (HCALL_REGION_GPA >> 32));
+
+	/* Userspace populated the page via the attr =E2=80=94 verify it works */
+	rax =3D INPUTVALUE;
+	rdi =3D ARGVALUE(1);
+	rsi =3D ARGVALUE(2);
+	rdx =3D ARGVALUE(3);
+	r10 =3D ARGVALUE(4);
+	r8 =3D ARGVALUE(5);
+	r9 =3D ARGVALUE(6);
+	__asm__ __volatile__("call *%1" : "=3Da"(rax) :
+			     "r"(HCALL_REGION_GPA + INPUTVALUE * 32),
+			     "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
+			     "r"(r10), "r"(r8), "r"(r9));
+	GUEST_ASSERT(rax =3D=3D RETVALUE);
+
 	GUEST_DONE();
 }
=20
+static void setup_msr_filter(struct kvm_vm *vm)
+{
+	uint64_t deny_bits =3D 0;
+	struct kvm_msr_filter filter =3D {
+		.flags =3D KVM_MSR_FILTER_DEFAULT_ALLOW,
+		.ranges =3D {
+			{
+				.flags =3D KVM_MSR_FILTER_WRITE,
+				.nmsrs =3D 1,
+				.base =3D XEN_HYPERCALL_MSR,
+				.bitmap =3D (uint8_t *)&deny_bits,
+			},
+		},
+	};
+
+	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned int xen_caps;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
+	bool msr_filter_ready =3D false;
=20
 	xen_caps =3D kvm_check_cap(KVM_CAP_XEN_HVM);
 	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL);
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE);
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_X86_MSR_FILTER));
=20
 	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
 	vcpu_set_hv_cpuid(vcpu);
@@ -123,6 +177,36 @@ int main(int argc, char *argv[])
 			continue;
 		}
=20
+		if (run->exit_reason =3D=3D KVM_EXIT_X86_WRMSR) {
+			/* MSR filter caught the Xen hypercall MSR write */
+			TEST_ASSERT(msr_filter_ready,
+				    "Unexpected WRMSR exit before filter setup");
+			TEST_ASSERT_EQ(run->msr.index, XEN_HYPERCALL_MSR);
+
+			/*
+			 * The host_initiated check should have prevented
+			 * KVM from populating the page. Verify it's empty.
+			 */
+			uint8_t *hcall_page =3D addr_gpa2hva(vm, HCALL_REGION_GPA);
+			TEST_ASSERT_EQ(hcall_page[0], 0);
+
+			/*
+			 * Now use the attr to populate the page, as a
+			 * VMM would after intercepting the MSR write.
+			 */
+			struct kvm_xen_vcpu_attr attr =3D {
+				.type =3D KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE,
+				.u.gpa =3D HCALL_REGION_GPA,
+			};
+			vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &attr);
+
+			/* Verify the page is now populated */
+			TEST_ASSERT_EQ(hcall_page[0], 0xb8);
+
+			run->msr.error =3D 0;
+			continue;
+		}
+
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
=20
 		switch (get_ucall(vcpu, &uc)) {
@@ -130,6 +214,18 @@ int main(int argc, char *argv[])
 			REPORT_GUEST_ASSERT(uc);
 			/* NOT REACHED */
 		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], TEST_WRITE_HYPERCALL_PAGE);
+
+			/*
+			 * Guest is about to write the Xen MSR. Clear the
+			 * hypercall page, install MSR filter to intercept
+			 * the write, and enable userspace MSR exits.
+			 */
+			memset(addr_gpa2hva(vm, HCALL_REGION_GPA), 0, PAGE_SIZE);
+			vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR,
+				      KVM_MSR_EXIT_REASON_FILTER);
+			setup_msr_filter(vm);
+			msr_filter_ready =3D true;
 			break;
 		case UCALL_DONE:
 			goto done;
--=20
2.43.0



--=-qmv3LylIXMZ8XL1hvURK
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQyODE5MTIz
OVowLwYJKoZIhvcNAQkEMSIEIImG4sMDYjKah80fUuFCttF325WRQ8f/LLhJSPNNgn29MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIApc6evEHGRqmA
xBiM2DalKAlcV7w79taOYftme7vPq8KtYBksf+wUL478GPbMce1y9v1u62dehIOvJA4h9zUY8ClM
Wm9ClDCc6Jn+bpZcK/G6PnBXTc6Gti6x+1evU7VG8IOttz0ONd1Wbe2ha9YEE/CO5HQ0jCVb7ACe
Cas5xCkYsCAFj4SnbQDblS7DuJpssPIqFT6KL7e0UbKScfbpHhSit4QBDdy80oQ6EBI6CT6wLwtC
Ybjo2H3034FxdGaiS77A/HYZFHdt6r1MloMhmFK3kGgIWSZfbo92WmNRl30bN+Zfo6+G7jgi03f6
sfAv3urozTIi9bf3pLpwwKyraHX7LtEV/9/CZVEoLwBfDaclXyyUDGSSYH+3/6DiLNEF+Ey7mNKp
sEetCOnfZ2fvbhpVfb+slVe8gg+nOPOhchzvsi0Rsl8ElaFojsXRJnQPLRRhLvbr+TXy8rAKoRFD
ih5S0GuTKTgQrO5dNahFaCPGDFaOHd+t5mi4/aXuWjMT7fm8Bh8gTvxVcwHTwET3IClg8/3TSOO6
TCFKnkjYoMjcvbtfTFhbwGOTACVKtKkad/0qxyG1SjnkGXilOIMB8W5ePshLHurwcSIigKy+z99r
Kuw5d/o6C6MLq6oNkmRhjfolmjS768rPvAI9+dozb9plgnyH14az/p/50GhM30UAAAAAAAA=


--=-qmv3LylIXMZ8XL1hvURK--
