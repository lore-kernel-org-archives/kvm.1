Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187287;
	b=DZTX74CXBHso9qZd9yhhMT4tSO/kD/1KVV+oZsmSBAx5eMMwAFkpTvvRzUHK5y+nvPvl
	 UJD8UyU/vU272MtV584F67HeWF18FGe0iROXhaBLTkFp8kWltZcodpv/gK1WZBitn66T5
	 28rmLQHjufcReG4gDHNUd2sfjH5Rr0f1jlcnG7KfwMKfnckgZK5V88EKfcGgyGEBfZsM2
	 zDlMWTy1jZIFa0VrGc+ATAj0U58Aqn6FyfBMHftTwZpic540P+VBOR2xQfmFWsir0SRc6
	 Lrs2xJWAX3NVixx0RGwcEb3/B49eIEPw3/LQgaEV2aBIDOZke9/RFlxeI79knGb1sLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187287;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=mKH9BxiVhD1hkWOxu0QRNvIl232YhI8uqiNY5R0UwSo=;
	b=KA2J3j9hCTTdrCmKUN/y68Rcmc98cQez0GuNrZKoyheGa8f9xTRfTP1rErZWcpxgC6Xs
	 Ocu9/9tUxsyllJ857QgJ9kQb0ulMd0YZ5fHukAIg8guzHOluUMM+8iRkLHzxkC4YBu3mV
	 +b0XNsXiGF7XfA3Kr8qntjO+jZ1MYtBmYkzohIVTuzb7o0gV9PauwGWcs8W2hebPKAwwX
	 LL1YCMF2V+WA11JNvj0Y7/Yr+waRFtmoEkWSDN5l19sxCL8/YYyFJWkWDuz7gHDmqaLY4
	 6loH156bc/qwdMGgUh07/cT2QqGlhKvvwv9ALBJw4Myp7+BPtiQnJZxQsMk8ZHEatZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=hiBv5jBk;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB3606EE8B;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FB3606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=hiBv5jBk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mKH9BxiVhD1hkWOxu0QRNvIl232YhI8uqiNY5R0UwSo=; b=hiBv5jBkYSiZPhUbCSbYAV4UiX
	HUw7iYbz4jTQZqq2mmZJB/qs6XJq24lQ4vJZ8KIi1zlm/YPI1sYsH7f1IcHL77g7ARIFuYulKhV9c
	uAXC395GnZXdnZKz5fgjlDWXM0eNlupAsEX+YCa1lRAVfhJDIDbyD0T3wcsJ7in1tABH8ejB7Iczw
	Jhab0aU50aIjniJzFhCwA9aAAxJ6oDAUt3kXCbxlRThaEPukHYw38qmyyd66ibIgqR08beDzTNuuf
	nssZomSuZ/0ThtPMevXApE/vrGgzDbYIzs2h0qKo2x3mus4SJ5ODfap1zJuDR2PVmlaHnv+3hj5Di
	A7JT6Ibw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AYD-28SP;
	Mon, 09 Nov 2026 01:21:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUp-42LY;
	Mon, 09 Nov 2026 01:21:12 +0000
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
Subject: [PATCH v12 12/24] UAPI: x86: Move pvclock-abi to UAPI for x86 platforms
Date: Sun,  8 Nov 2026 17:20:58 -0800
Message-ID: <20261109012112.3415328-13-dwmw2@infradead.org>
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

