Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF83D8901;
	Sat,  9 May 2026 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366949; cv=none; b=dpK/ADjPqhXJN+yE3Gq/y8nb+oWo2UZM6/wrgghl9hUjm23q4/w5tBdilpsQw1j5/Pe7nzl6uOOOJRcB6fKcW4amDsEpWUQM0mizTe+1s9Z7/rpd2640PMQrE2ZC/UhaJ8FhKjJmReVyXdTp1tf2JliLM4+DQO8WeKTLb/c7ts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366949; c=relaxed/simple;
	bh=2SCE0Ir5cjrBSFAUMO3FostCpEsglu4FTeHYT/wm/O8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr1qjCKKEv2aW2scSAkBbjsJOxC38yQ8GkdEQkEvu7GpVEvhd+DfpiY84PwKHsQdv2toOMwYPI4vEmKTFYDiio5dlJ58GczVCwmhIx/oVKrzy4FhMK+zlYW0oYA6mfDIx8D3rYdJB3qWR2u99HE58A3sAp9PffmVta3AKZ6KKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f1v81ARM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1v81ARM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=cy4WX+pEhq0ONnRd44jsWeJgn8jdEFwX+WNyOailsXI=; b=f1v81ARMTELtkK8Uo8Dot8XJtu
	ZPciDZdzdNb1UHVK8ThK5p7adwR8E97R+9zIyV0sMXwSSyxjd4IvQlFS1KguGP5C+dFNoPz2650YT
	vZPBfyVoT3pRwi4VvjZVlaifWMSpT8PK8VePe/zBIi4e47aMk1d9kmUFgZknxrqOXL2hEvnpa6Snd
	y4uvxo7khgiNAVT2itX+II+hxxOa7kgC788aR89gNlujoCfM6pkUPukM1rscIT6j4W8yH9v0XoPYA
	LkcLMKnb6NvFlwXfeMKBZDHIP502+a0Hxb+TlAS4PXWuTHMYVmQlYlBXe0VjTlPt4/nVgJdkX0n4H
	2lt+5C2w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wz7-0Xnk;
	Sat, 09 May 2026 22:48:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhHP-0ITl;
	Sat, 09 May 2026 23:48:26 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 03/30] UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
Date: Sat,  9 May 2026 23:46:29 +0100
Message-ID: <20260509224824.3264567-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
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
usermode and also change the type definitions to use the standard for
UAPI exports.

Signed-off-by: Jack Allister <jalliste@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 MAINTAINERS                                   |  4 +--
 arch/x86/include/{ => uapi}/asm/pvclock-abi.h | 27 ++++++++++---------
 2 files changed, 17 insertions(+), 14 deletions(-)
 rename arch/x86/include/{ => uapi}/asm/pvclock-abi.h (82%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0b307b2108c..e49676955c0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14406,7 +14406,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 F:	arch/um/include/asm/kvm_para.h
 F:	arch/x86/include/asm/kvm_para.h
-F:	arch/x86/include/asm/pvclock-abi.h
+F:	arch/x86/include/uapi/asm/pvclock-abi.h
 F:	arch/x86/include/uapi/asm/kvm_para.h
 F:	arch/x86/kernel/kvm.c
 F:	arch/x86/kernel/kvmclock.c
@@ -29087,7 +29087,7 @@ R:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/x86/configs/xen.config
-F:	arch/x86/include/asm/pvclock-abi.h
+F:	arch/x86/include/uapi/asm/pvclock-abi.h
 F:	arch/x86/include/asm/xen/
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
-- 
2.51.0

