Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539954;
	b=fL72/SoK9yDYhAH4hrbh5pgWtfdjbqpoj6n/AeaigNFJFXv5VepiwOqVvcwjplDQuvPr
	 pGhQuQV4Q/uBeIPKrO8GDeYD7iO3LXVPfVJZKiIDujCLLkYO/wYDlA8OeVcVCqPdyZHNF
	 WzrRnfHmv5vLCHI/gCwHx8BxwanLRfQTSQettTisT3AdYX/f0Mapxsa8/fFsQyTTYRlEa
	 xZ6TkaiCB1qmX5FA46PVsBheDdnc51+j2Ws95hTU6mrS16sqV3dAipxkQMPugPPLciqPq
	 eQZ6SKJOxdKP3hjgvFfzSTmSK8C/9z5+W2DH+2r3iyujz91lx/ogWnRzyF0r2OCw9mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2tu+6V9vneXzOz6t4C0cOOOQWfAw1n5xSutLbHlCswQ=;
	b=tR3HWqdy+Wpf39+RaYWgsDWpjJjOjV5NxRXnBnpZXMnKV5+GJRfgIx8nPvpyBqKIYfsB
	 7iGxD9NtahnXSishIQdbwaV+IrKehRwoguO2E+WgsSh1qXh/HE2Ic7XXABvQG5sD+pxUT
	 SFH9Nz6BrQtKZ81iaKOUiEbKu12U9iOk02mQfUdSZ39q4QIVTm3H9nqdXVnCPNhkS9chY
	 OG6SPnhKpHWUSYEQx5mopmN2aa353Gwh/a1NO6uOu37qWUP6fFBWB6l0PWUwFx0gdbUyk
	 US1DZODnFTtW6IgDRUSIpyMeGnSnPaZtbjaxS8Bah2+D7+KSSleFS67akjy38MHfytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CHPy0JzQ;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317F606A326
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 23:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B317F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CHPy0JzQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so532860a91.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792539948; x=1793144748; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2tu+6V9vneXzOz6t4C0cOOOQWfAw1n5xSutLbHlCswQ=;
        b=CHPy0JzQEmD+Zao/pNexvKSe24CWoOuQUeYVORXnncfaLOPqZEL0Ge/FG0j40u9A5v
         VTEK6M1SZbj56NVp90sQRydI4OqgQH+/YT2Zb04YPLhPBDLWQHPPFmOC0O0r4KzGONUU
         mGdidV4H/h6VWrnG+f5aSbtUtOqX4PpHDl0jCxd2x8dKxw3IQ8ZbiuLyRne8PlDTAJDQ
         cMz6VudylOCWtUxqA7eEMCEWn7JL1RcATtTGnV5m0+EuaEN9VH8vnHKCQL47h0VIaBIf
         v5D3EyZ0LoJPWZ+HPWq+qaqL/jHCA8FjNowTA4sc4gtteUlZ/YcYZ8AI0l3D7+poIcTe
         NxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539948; x=1793144748;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tu+6V9vneXzOz6t4C0cOOOQWfAw1n5xSutLbHlCswQ=;
        b=ntmFHXOFP1m681YcKHbs8U3xHidSJXHTUiUmHC+pC1ndSHNNkNWuFBXAGsoNV+gww8
         fjZDK+nTdMINTuwpo/1TOmNPd2+lIzvsAoSLYrL/iJRWl3+hEwZP7QDtXWaYAHNjG3Oe
         3RmREvIZefGCylJZ/xrlNKTtQtOaKvfiuyOnBIXy3PlhReDHCzzsdC32onLcrSIVN+w0
         +C6WQi0zCqDh46y0ywW+CJrqEWEj4sPuPrdKRf5cBhxMEF8PCeWiKmECCzzP3MBFLpBB
         Pmkfs4s2h1oLli700W/SCzonEz5+rPy93tvaIPFUrsFAqpvMBTtdS3aVoWlKDrG6HSTs
         OYyA==
X-Forwarded-Encrypted: i=1; AKwUvBxk+hrwXmWvyDZtwZWFyQcm/pAQ55wz5rh+coIzYVQM4Yqg15jADY9v08t+xCIP/XMhG4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYILf4Mza+PRdZgrhEJgYXNxHR3yZhO8n+TiYEfNHOeGPOIRWCx3
	jpZ8DIIU+m9y0rYyxKPIGK1/kZNZqXSG5qZp639wguKixJBH1M9cCdA00zFkswfZ5z711mV2/cG
	bhnOhweQJZnTTtg==
X-Received: from pjqd21.prod.google.com ([2002:a17:90a:a695:b0:3ad:850b:6f1c])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5243:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3ad86f3da39mr344522a91.43.1792539947865;
 Tue, 20 Oct 2026 16:45:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:45:29 -0700
In-Reply-To: <20261020234535.3182385-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020234535.3182385-4-jmattson@google.com>
Subject: [PATCH 3/4] KVM: selftests: Add a helper to request XSAVE permission
 without skipping
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Split the core of __vm_xsave_require_permission() into a new helper,
vm_xsave_request_permission(), which returns false instead of skipping
the test if KVM doesn't support the requested dynamic XSAVE feature, or
if the request for permission is denied.  This allows tests to opt into
dynamic features opportunistically, e.g. to exercise additional KVM
paths when AMX is available, while retaining the sanity check that the
request is made before KVM_GET_SUPPORTED_CPUID is first queried.

Like vm_xsave_require_permission(), wrap the new helper in a macro that
stringifies the feature mask for use in assertion messages.

Use __kvm_device_attr_get() instead of open-coding KVM_GET_DEVICE_ATTR.

No functional change intended for existing users, other than collapsing
the reasons for skipping into a single message.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  4 +++
 .../testing/selftests/kvm/lib/x86/processor.c | 33 ++++++++++++-------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..6e9db81187c3 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1530,8 +1530,12 @@ static inline void cli(void)
 	asm volatile ("cli");
 }
 
+bool __vm_xsave_request_permission(u64 xfeature, const char *name);
 void __vm_xsave_require_permission(u64 xfeature, const char *name);
 
+#define vm_xsave_request_permission(xfeature)	\
+	__vm_xsave_request_permission(xfeature, #xfeature)
+
 #define vm_xsave_require_permission(xfeature)	\
 	__vm_xsave_require_permission(xfeature, #xfeature)
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d31fa81ea075..12092e59b390 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -975,16 +975,18 @@ u64 kvm_get_feature_msr(u64 msr_index)
 	return buffer.entry.data;
 }
 
-void __vm_xsave_require_permission(u64 xfeature, const char *name)
+/*
+ * Request permission for guests to use the dynamic XSAVE feature @xfeature.
+ * Returns false, without skipping the test, if KVM doesn't support the
+ * feature or if the request is denied.  Must be called before
+ * KVM_GET_SUPPORTED_CPUID is first queried, as KVM enumerates dynamic
+ * features only if userspace has permission to use them.
+ */
+bool __vm_xsave_request_permission(u64 xfeature, const char *name)
 {
 	int kvm_fd;
 	u64 bitmask;
 	long rc;
-	struct kvm_device_attr attr = {
-		.group = 0,
-		.attr = KVM_X86_XCOMP_GUEST_SUPP,
-		.addr = (unsigned long) &bitmask,
-	};
 
 	TEST_ASSERT(!kvm_supported_cpuid,
 		    "kvm_get_supported_cpuid() cannot be used before ARCH_REQ_XCOMP_GUEST_PERM");
@@ -993,24 +995,33 @@ void __vm_xsave_require_permission(u64 xfeature, const char *name)
 		    "Dynamic XFeatures must be enabled one at a time");
 
 	kvm_fd = open_kvm_dev_path_or_exit();
-	rc = __kvm_ioctl(kvm_fd, KVM_GET_DEVICE_ATTR, &attr);
+	rc = __kvm_device_attr_get(kvm_fd, 0, KVM_X86_XCOMP_GUEST_SUPP, &bitmask);
 	close(kvm_fd);
 
 	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
-		__TEST_REQUIRE(0, "KVM_X86_XCOMP_GUEST_SUPP not supported");
+		return false;
 
 	TEST_ASSERT(rc == 0, "KVM_GET_DEVICE_ATTR(0, KVM_X86_XCOMP_GUEST_SUPP) error: %ld", rc);
 
-	__TEST_REQUIRE(bitmask & xfeature,
-		       "Required XSAVE feature '%s' not supported", name);
+	if (!(bitmask & xfeature))
+		return false;
 
-	TEST_REQUIRE(!syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM, ilog2(xfeature)));
+	if (syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM, ilog2(xfeature)))
+		return false;
 
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_GUEST_PERM, &bitmask);
 	TEST_ASSERT(rc == 0, "prctl(ARCH_GET_XCOMP_GUEST_PERM) error: %ld", rc);
 	TEST_ASSERT(bitmask & xfeature,
 		    "'%s' (0x%lx) not permitted after prctl(ARCH_REQ_XCOMP_GUEST_PERM) permitted=0x%lx",
 		    name, xfeature, bitmask);
+	return true;
+}
+
+void __vm_xsave_require_permission(u64 xfeature, const char *name)
+{
+	__TEST_REQUIRE(__vm_xsave_request_permission(xfeature, name),
+		       "Dynamic XSAVE feature '%s' not supported or not permitted",
+		       name);
 }
 
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid)
-- 
2.56.0.212.g129ede20d9-goog

