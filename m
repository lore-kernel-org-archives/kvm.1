Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D7425CD1;
	Mon, 29 Jun 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749782; cv=none; b=K5zlerop9qQYYsl2Z0IEr5xHeoAzip4IMGLfRwmfh16jAly0A3E7Qe64dlI/N2aX8hV+XsqaipoKM/shnPXmBvS0epSxKzvm5wBZJN/oFhGxnxqJcdED6Jqt+KGwNpkOtnHRnL60ug1oWzSMqmdEHN8o5RYSPCC4VS0GyNshRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749782; c=relaxed/simple;
	bh=8XOSO8u0P9cYn+FP6EJCkbTyifQ79pIloMaWrVjUykE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=OraqSpcX9Fgg0tLYvpHwzGBFMaXe6/6QhaVuCUQUvlMjpg8HxyQYgN6t/gVysPLcaNgalXiIv8zGRc86qwkx/BCn3hFLnhZm8O4/ETHefxVZFN1rePY8VrELx5WjGU119OtKLGoa2DEr0OiseqGj6dOziRLXpXCePe9RUFlcgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O7EXL4lh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7EXL4lh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GZ3Y1OlVuG9hFYE4aw6kXXB9vgDVJ/EQimwS2weTt/U=; b=O7EXL4lhXlQp2ew5u1dPXrVt11
	huPc4kEKv3a2tYWVNADZjcA3k3x85XPqswwMwEJMZbN8UhzJXXguwdMyctI2veWEeMh1EodwZn38j
	Yd2G+5eR4vlq1Cbr13HS3EjcPl4K55p2LpOfi2NMLz03PKG8TgfMJ+WCI4TrPYXzV7AJrqHItwjHK
	ut4XMVF/TwkxJHrqmrShBkoRdtlFKeCd4YIZlFBOAXn5Ly+fhdYLLW2EfNI/++kjH6LNRBz9VMhJw
	LzZ8JgEVwUEqiTHo3etrnpA1ODpgwf0HyKzMkSNN4f6HujO2MTk6GDcf6ZFyk7ym1+KWBFjGFhJt9
	nV3hIMEg==;
Received: from [2001:8b0:10b:5:6701:89d6:7740:5b29] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weEeQ-00000003VfF-306S;
	Mon, 29 Jun 2026 16:16:03 +0000
Message-ID: <a99988d6102171663aab8d62d04cc6686d467565.camel@infradead.org>
Subject: [PATCH v2] KVM: x86/xen: Add
 KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,  Borislav Petkov	 <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"	
 <hpa@zytor.com>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 29 Jun 2026 17:16:01 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-xiKBDIYp4Jh9AvnKYOsc"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa6 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-xiKBDIYp4Jh9AvnKYOsc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 3617c0ee7decb ("KVM: x86/xen: Only write Xen hypercall page for
guest writes to MSR") blocked host-initiated writes from triggering the
Xen hypercall page setup, to fix an SRCU usage violation when the
hypercall MSR index collides with a real MSR written during vCPU reset.

However, some VMMs legitimately need to intercept the hypercall MSR
write from host context, for example to track an epoch for kexec/crash
recovery, and allow the crash kernel to take over PV net/disk devices.

In such cases, the VMM then needs to trigger the effects that the guest
write to the MSR is intended to have: populating the hypercall page, and
latching the VM's "long mode". The host_initiated check breaks this use
case.

Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE as a new vcpu attribute
that triggers the same effects from host context. Move the code into a
common __kvm_xen_write_hypercall_page() function with a normal 0/-errno
return convention, and turn the existing kvm_xen_write_hypercall_page()
into a wrapper which returns the 0/1 return value for MSR write
functions.

The __kvm_xen_write_hypercall_page() function now runs with the xen_lock
held for its entire duration, which isn't strictly necessary, but this
is hardly a fast path as a guest generally does this only once while
it's starting up.

The handling of the Xen hypercall page is a bit of a historical anomaly.
It was added in commit ffde22ac53b ("KVM: Xen PV-on-HVM guest support")
in 2009 with a comment saying, "A generic mechanism to delegate MSR
writes to userspace seems overkill and risks encouraging similar MSR
abuse in the future. Thus this patch adds special support for the Xen
HVM MSR."

The original mode where the contents of the page were provided by
userspace is no longer used. In 2018 when the current Xen support was
added, commit 23200b7a30d ("KVM: x86/xen: intercept xen hypercalls if
enabled") said, "Since this means KVM owns the ABI, dispense with the
facility for the VMM to provide its own copy of the hypercall pages;
just fill them in directly using VMCALL/VMMCALL as we do for the Hyper-V
hypercall page."

Strictly, it would be *possible* for userspace to do all this for
itself; there is already KVM_XEN_ATTR_TYPE_LONG_MODE, and userspace
could write the hypercall page for itself. But the 2018 logic about KVM
owning the ABI, and avoiding duplication of the instruction choice made
by patch_hypercall(), still stands. So provide userspace with a simple
method which triggers all the (side) effects of the MSR write, now that
it can't just write the MSR as before.

Fixes: 3617c0ee7dec ("KVM: x86/xen: Only write Xen hypercall page for guest=
 writes to MSR")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst                | 13 +++
 arch/x86/include/uapi/asm/kvm.h               |  3 +
 arch/x86/kvm/x86.c                            |  3 +-
 arch/x86/kvm/xen.c                            | 45 ++++++---
 .../selftests/kvm/x86/xen_vmcall_test.c       | 96 +++++++++++++++++++
 5 files changed, 144 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t
index a5f9ee92f43e..3c6aee2a35bf 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5812,6 +5812,19 @@ KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR
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
+  correct alternative. As with a non-intercepted guest write to the
+  hypercall MSR, it also latches the 'long mode' for the VM, which
+  determines the layout of the shared data structures.
+
=20
 4.129 KVM_XEN_VCPU_GET_ATTR
 ---------------------------
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kv=
m.h
index 1585ec804066..7732b92a4db0 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -598,6 +598,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
+#define KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE	(1 << 9)
=20
 #define KVM_XEN_MSR_MIN_INDEX			0x40000000u
 #define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
@@ -706,6 +707,8 @@ struct kvm_xen_vcpu_attr {
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
index afcac1042947..d7f23c0bff74 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4869,7 +4869,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
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
index 694b31c1fcc9..50423df6e22d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -32,6 +32,7 @@
 static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm);
 static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr=
 *data);
 static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u6=
4 *r);
+static int __kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)=
;
=20
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
=20
@@ -1138,6 +1139,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, str=
uct kvm_xen_vcpu_attr *data)
 		}
 		break;
=20
+	case KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE:
+		r =3D __kvm_xen_write_hypercall_page(vcpu, data->u.gpa);
+		break;
+
 	default:
 		break;
 	}
@@ -1273,7 +1278,7 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, stru=
ct kvm_xen_vcpu_attr *data)
 	return r;
 }
=20
-int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
+static int __kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 {
 	struct kvm *kvm =3D vcpu->kvm;
 	u32 page_num =3D data & ~PAGE_MASK;
@@ -1281,7 +1286,6 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcp=
u, u64 data)
 	bool lm =3D is_long_mode(vcpu);
 	int r =3D 0;
=20
-	mutex_lock(&kvm->arch.xen.xen_lock);
 	if (kvm->arch.xen.long_mode !=3D lm) {
 		kvm->arch.xen.long_mode =3D lm;
=20
@@ -1289,11 +1293,9 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vc=
pu, u64 data)
 		 * Re-initialize shared_info to put the wallclock in the
 		 * correct place.
 		 */
-		if (kvm->arch.xen.shinfo_cache.active &&
-		    kvm_xen_shared_info_init(kvm))
-			r =3D 1;
+		if (kvm->arch.xen.shinfo_cache.active)
+			r =3D kvm_xen_shared_info_init(kvm);
 	}
-	mutex_unlock(&kvm->arch.xen.xen_lock);
=20
 	if (r)
 		return r;
@@ -1309,7 +1311,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcp=
u, u64 data)
 		int i;
=20
 		if (page_num)
-			return 1;
+			return -EINVAL;
=20
 		/* mov imm32, %eax */
 		instructions[0] =3D 0xb8;
@@ -1325,10 +1327,11 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *v=
cpu, u64 data)
=20
 		for (i =3D 0; i < PAGE_SIZE / sizeof(instructions); i++) {
 			*(u32 *)&instructions[1] =3D i;
-			if (kvm_vcpu_write_guest(vcpu,
+			r =3D kvm_vcpu_write_guest(vcpu,
 						 page_addr + (i * sizeof(instructions)),
-						 instructions, sizeof(instructions)))
-				return 1;
+						 instructions, sizeof(instructions));
+			if (r)
+				return r;
 		}
 	} else {
 		/*
@@ -1340,10 +1343,9 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vc=
pu, u64 data)
 		u8 blob_size =3D lm ? kvm->arch.xen.hvm_config.blob_size_64
 				  : kvm->arch.xen.hvm_config.blob_size_32;
 		u8 *page;
-		int ret;
=20
 		if (page_num >=3D blob_size)
-			return 1;
+			return -EINVAL;
=20
 		blob_addr +=3D page_num * PAGE_SIZE;
=20
@@ -1351,14 +1353,27 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *v=
cpu, u64 data)
 		if (IS_ERR(page))
 			return PTR_ERR(page);
=20
-		ret =3D kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
+		r =3D kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
 		kfree(page);
-		if (ret)
-			return 1;
+		if (r)
+			return r;
 	}
 	return 0;
 }
=20
+int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
+{
+	guard(mutex)(&vcpu->kvm->arch.xen.xen_lock);
+
+	/*
+	 * The MSR write path expects a 0/1 return; convert the errno from
+	 * the shared helper accordingly. Callers that want the real error
+	 * (e.g. the KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE attribute)
+	 * invoke __kvm_xen_write_hypercall_page() directly.
+	 */
+	return __kvm_xen_write_hypercall_page(vcpu, data) ? 1 : 0;
+}
+
 int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 {
 	/* Only some feature flags need to be *enabled* by userspace */
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


--=-xiKBDIYp4Jh9AvnKYOsc
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyOTE2MTYw
MVowLwYJKoZIhvcNAQkEMSIEIAapbbrRRpGBL2slysgaY1h3aqtyyx/HJHT9VKGhIP/RMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAIqqukp7gxu/C
ip7OY8ngmuTMESvsx9H87zXf/GBLzQDCqvTnZy5Z1CkX8I702b6e4q4ShEEzY+RpVfXaoAXcGc1D
DhBXHYukkl3+HFsmuWqKIc++zNC0sOLc66tGib7JaHIPv4+7T+bDV0t1HvdfsRcq9oGrQvmFbyia
nzE0Sybp28K8XXBJyUNAbGnTVfqj7Eb2JrO4SJ51Kp2nomrMDDTDu6fpPyMNDQBoLu23nLs+Ewvt
NHoBxcJd6DNpCeZ9IoYu51sk4Clip5BY91H32LE/TLUK0liVE+zNiKHGRBM9kd1xWmnte6B5TSeS
0ZXCnQsGpu0sNG1Ccmfj2R8w6bZWukbOWJIIR0cL+1fxFK7uasIpSO8zi6Q2R7jfqDwMpXkxms1M
RIeCRCnIowP0uoGU1XFMw6kTMTzB181i+2WC9kBSKccgVrkqe4vf86e2gA6KYPGjduP8J/Ntx4Oj
eRbS6KE8qm3yNhNGUcaHH6c49AMKd4S8cEyYanr2S6p6YzE22dkEqOmZHxJZqxO0AbiswKQtkalc
p0M+HZw1tw1MtVCY4TLbDLwh8J9/e4DEG+UMDMvrZqFIX2RuyVkgnjSfnyd8B1CPMpdMOqZNYTqK
HmtejNWUH5rU1OWsh9lbmuSzmBwgN5p+V+mOHlpsFA701Q4oPTeQzLsPLpDjDSAAAAAAAAA=


--=-xiKBDIYp4Jh9AvnKYOsc--
