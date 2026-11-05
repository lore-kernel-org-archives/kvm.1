Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893804;
	b=ip3Db4ssZppVzjd4jcwmRYtipYDYdOP3PQLJdgBSUjjcD9eZTZSDVQ3kYCn2Yj7T87zi
	 T0eTGP5j/qkli9A3q+JeYECMn3Ro4h05hM2sbyGyZfmiM6wf2xtciMUeNsjO18W0r8fAG
	 UkSdC8LCZvLOo4iFNk1rWHWzc+sY1y9n8cNZnBlu+eYscdnRr9D7t2QDLAcueosrePLlE
	 b+RPAJEdij8hoTx4TOhtOcep+XHI9k2wMo1ZsVe0FNMZREa3ZEArUERH01AzXn8CrK45J
	 Mws1Bu7Pa2dvNoxU0Nv6mJ9BNRhi7LlTTilq/NRTKyCgLeY8WnagWv7Tc1qF3100SuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893804;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=mKH9BxiVhD1hkWOxu0QRNvIl232YhI8uqiNY5R0UwSo=;
	b=PeWD2Z5LnHmxvQqImyEchLh7tL1qFXfoRB+ZtI37ky3mAMx1Bk1/arbXedX+sNkQJ5lr
	 xOyqMdV31xsvknswRtSpNCxbvykzlvqF/gAAIXgwUXep2gbIA6tuwM14gA68H/W8hkubA
	 WLrxCrD9gnMobF2fYVyFtYXcibzKzJm54OMxuSccx7QGobZ8ufrHU4e7k+NHYxQwxPbIm
	 72BE/rEkVnH3NWZP0+Hk60vfjPkfFNAGdD0s5rM9LdEbFAbPeCSmV8B1xPAYeMDkM3HhS
	 Tfr5n+ujCKWaxZQIrUwhOvwfPpb7aT7NtR3eGdw9I9AiQt6U9NKLdE20vBXDWhTwkVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PS8heR5U;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5D606A32D;
	Thu,  5 Nov 2026 15:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F5D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PS8heR5U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mKH9BxiVhD1hkWOxu0QRNvIl232YhI8uqiNY5R0UwSo=; b=PS8heR5UfpzNGppFEyFnViA2DL
	FRWZk3qRLQOMGVQFWIw5D/XcdpEnJVkMbTkQfVXe4hAXq0CqByd46FPAhCF/k4oM5IGvQPzLmQe0k
	ajTJabtgEAwXls17arD8PDPJxchbIETuZhSsekBzV0Ps6XZc0/Qx3Obg7iISMggAf2QoIZWilTLzi
	uYxiWORF261bI3SEiPfDd1loNVLFSa7d3eRwGRbfKgHQRbNNOVEomunG2rLQt8RGvscUb1SCb21mb
	h42wQ9/0PEFxFJKniq3Xy+Unj6QBuN+m9Meb3YOhW5jbXXWURJp1UoA6k8aImvZ7GX6oP8q3A8aRT
	xHYCUTxw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziw-00000003Bo1-28cY;
	Thu, 05 Nov 2026 15:49:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOziu-0000000AazW-0O4I;
	Thu, 05 Nov 2026 15:49:56 +0000
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
Subject: [PATCH v11 12/23] UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
Date: Thu,  5 Nov 2026 07:49:43 -0800
Message-ID: <20261105154955.2525419-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105154955.2525419-1-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
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

From: Jack Allister <jalliste@amazon.com>

A subsequent commit will provide a new KVM interface for performing a
fixup/correction of the KVM clock against the reference TSC. The
KVM_[GS]ET_CLOCK_GUEST API requires a pvclock_vcpu_time_info, as such
the caller must know about this definition.

Move the definition to the UAPI folder so that it is exported to
usermode, change the type definitions to use the standard for UAPI
exports, and add the Linux-syscall-note exception to the SPDX licence
identifier as is conventional for exported headers.

Define __KERNEL__ in scripts/xen-hypercalls.sh: the UAPI header now
pulls in linux/types.h, and the script's raw $CPP invocation with
$LINUXINCLUDE does not define it, which would trigger the "attempt to
use kernel headers from user space" warning from the UAPI type
headers.

Signed-off-by: Jack Allister <jalliste@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 MAINTAINERS                                   |  4 +--
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h | 27 ++++++++++---------
 scripts/xen-hypercalls.sh                     |  2 +-
 3 files changed, 18 insertions(+), 15 deletions(-)
 rename arch/x86/include/{ => uapi}/asm/pvclock-abi.h (82%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fadc98d3c49..773f7c800f6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14663,8 +14663,8 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 F:	arch/um/include/asm/kvm_para.h
 F:	arch/x86/include/asm/kvm_para.h
-F:	arch/x86/include/asm/pvclock-abi.h
 F:	arch/x86/include/uapi/asm/kvm_para.h
+F:	arch/x86/include/uapi/asm/pvclock-abi.h
 F:	arch/x86/kernel/kvm.c
 F:	arch/x86/kernel/kvmclock.c
 F:	include/asm-generic/kvm_para.h
@@ -29780,8 +29780,8 @@ R:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/x86/configs/xen.config
-F:	arch/x86/include/asm/pvclock-abi.h
 F:	arch/x86/include/asm/xen/
+F:	arch/x86/include/uapi/asm/pvclock-abi.h
 F:	arch/x86/platform/pvh/
 F:	arch/x86/xen/
 
diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/uapi/asm/pvclock-abi.h
similarity index 82%
rename from arch/x86/include/asm/pvclock-abi.h
rename to arch/x86/include/uapi/asm/pvclock-abi.h
index b9fece5fc96d..6d70cf640362 100644
--- a/arch/x86/include/asm/pvclock-abi.h
+++ b/arch/x86/include/uapi/asm/pvclock-abi.h
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
diff --git a/scripts/xen-hypercalls.sh b/scripts/xen-hypercalls.sh
index f18b00843df3..51a722198997 100755
--- a/scripts/xen-hypercalls.sh
+++ b/scripts/xen-hypercalls.sh
@@ -5,7 +5,7 @@ shift
 in="$@"
 
 for i in $in; do
-	eval $CPP $LINUXINCLUDE -dD -imacros "$i" -x c /dev/null
+	eval $CPP -D__KERNEL__ $LINUXINCLUDE -dD -imacros "$i" -x c /dev/null
 done | \
 awk '$1 == "#define" && $2 ~ /__HYPERVISOR_[a-z][a-z_0-9]*/ { v[$3] = $2 }
 	END {   print "/* auto-generated by scripts/xen-hypercall.sh */"
-- 
2.43.0

