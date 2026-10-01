Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA377538D6E
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883544; cv=none; b=fqajO3KpQ8i6f2idaddR6cIErwIt5eSRyPGkbVOp+QowpGJ26UAHUYp/19TI6sWq9uJpCPbpTBYJ8VZtlBkVDcX7g057jKYmOKNZIkCGJ5+so8hGZLdnyZEnjayCU/jFAjoDE50AgSdmXZJKkZwrQFZD+mYowajFoU8pKa5Te9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883544; c=relaxed/simple;
	bh=OmYZrXMHQ6GNkHyoPspDJgmPZLZO4fxyA+WIizMm9Pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=moeq7SGeiVUqAO7Ku1s0o4nKMiMeeXQkO3azs4/7Q8+ENKqY1GuJXOHI2tTobadz1li3rZvBXhOJAd5DJSASDsvV7Ks9SNxg8KCpUq8G7QrndVZExk7VzrNtK34fIqWUf5pYEM32CR/czuiE/Z2dUTfGYahoTVoHwowqJuMJsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnBEu6xz; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnBEu6xz"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a43fc3527so1169135b3a.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883540; x=1791488340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PMxTCtqUELQe4eKRYkBdJgosWLyHcswIgZCsHoG0ME=;
        b=UnBEu6xze0ucguVPEYZSed6mALjp/rDSYmQpdd+TrnolC4xd45y1kZG7QCBZTE5+NI
         o3+QSRbnlSoYJjKYAvdOsjQDz47V9h8VkpAwBs0P+jOTd+8dfF192oRs5HVuK/VJfX1Q
         OXjjyj4O6mW1dVkQrISPgwC7nBzC4sl396C2sf4viYMacJeoWGGhY6Jpsg8fRmaMDzje
         MVOeJF/21La2tnKcIsR0XYSD7QnYitaznbEEUgYBVioL59nbh7NJ5BPhLiuIG24+aJNF
         mV86DnuZB/4qzT+yjUsE9R4XckRX4YiNGWS5xhoRoNj/HsfMzQD3z5AUN/ptUDN1yE+9
         yavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883540; x=1791488340;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PMxTCtqUELQe4eKRYkBdJgosWLyHcswIgZCsHoG0ME=;
        b=maKXdAHbo06d08wZqICUk1PXjcP6Qpt1S9EH1p42TT6Ra9pVtaZUnPv45GigJxi6uo
         403yQlz2xGmdJHETcIl4wiEod2qt5sWaCf06MuIcCTwpytHAKGisFkdhwFOi3s4JQCtK
         /T/j3rkzQt2Dr1hDRUPebqdSHgwQF/1UsjI9ykAcLuHMSmR8OjZvZxLgs8omXwdhp/Li
         cOFQmoaXzWzQ1Xcn+QmJwenAcfQmBUqlGX6WdVwBJq2CBGLyt9MHz012+IO/oSKvFQUY
         A0QD/A8HqcLqaooyIHyziB9wMzN13FrEYggFgifRumBsp6OuwnlhJz51gWcRz3aaOHTz
         s+lA==
X-Forwarded-Encrypted: i=1; AKwUvBzUBrU/eZTZGq8qAzgWxdMrLW+3amL5qwXcPK+GX7nrDW7S6qltJjejE7YNin8J3BI4aRc=@vger.kernel.org
X-Gm-Message-State: AFuF++k4QjTPhyfmlRPqWiHdTybgfuPwwy9zc69e969sq2dtzGXm6YpR
	8yi5rFbBpfZJZqdzJM2O7f/g2MvEXtYzF+AJopJuSCeDvuaEDut3mWCSxQW/A+41+Y+i6BQZn2Z
	xJ3E2ew==
X-Received: from pgww6.prod.google.com ([2002:a05:6a02:2c86:b0:cc7:9f0d:787f])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:700d:b0:3dd:a9a9:396b
 with SMTP id adf61e73a8af0-3deacdbf75amr3057879637.47.1790883539784; Thu, 01
 Oct 2026 12:38:59 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:47 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=2963;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=1jhZF7MSEYmQ46gvcXXFj0gF9FxGyiWCS3GM6O8ekwE=; b=cCVqhBZTduk/xhTjJgvwm/ClTICdSU0FEwX9Q2XAkSN/UPg3vnXMFjPrhYwqS0SbIEuxLgkUB
 yI3hbduPE+8C3WKMNUuk75C9ugXAks5fAjUgIj/vygm+UQIsJoSLhBB
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
Subject: [PATCH v15 20/23] KVM: selftests: Add a helper to issue TDVMCALLs
 from the TDX vm
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Erdem Aktas <erdemaktas@google.com>

TDX VMs need to notify the host, e.g. ucall. Add tdvmcall() to allow VMs
to issue TDG.VP.VMCALL with a single function call instead of
open-coding TDVMCALL registers setup at every call site.

The helper makes standard GHCI TDVMCALLs: the caller passes the GHCI
sub-function and up to four arguments and returns the TDVMCALL status
from R10.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm          |  1 +
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h |  9 ++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.S     | 39 +++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9464168e361a..495de8ef8166 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -34,6 +34,7 @@ LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
+LIBKVM_x86 += lib/x86/tdx/tdx.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
new file mode 100644
index 000000000000..d41a1efc8a63
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_TDX_TDX_H
+#define SELFTEST_KVM_TDX_TDX_H
+
+#include <linux/types.h>
+
+u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15);
+
+#endif /* SELFTEST_KVM_TDX_TDX_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
new file mode 100644
index 000000000000..e3f0f7f2232b
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+.globl __tdvmcall
+/*
+ * u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+ */
+__tdvmcall:
+	push %r12
+	push %r13
+	push %r14
+	push %r15
+
+	/*
+	 * Map C ABI fast arguments to TDX GHCI payload registers
+	 * RDI=fn, RSI=r12, RDX=r13, RCX=r14, R8=r15
+	 */
+	mov %rdi, %r11
+	mov %rsi, %r12
+	mov %rdx, %r13
+	mov %rcx, %r14
+	mov %r8,  %r15
+
+	mov $0, %rax		/* TDCALL leaf 0: TDG.VP.VMCALL */
+	mov $0xFC00, %rcx	/* Expose R10-R15 */
+	mov $0, %r10		/* Standard GHCI call */
+
+	/* TDCALL instruction */
+	.byte 0x66, 0x0f, 0x01, 0xcc
+
+	/* Extract status */
+	mov %r10, %rax
+
+	pop %r15
+	pop %r14
+	pop %r13
+	pop %r12
+	ret
+
+.section .note.GNU-stack,"",%progbits

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

