Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2A47CA68
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035019; cv=none; b=CRihuO8J7I5GVCU4TalJS6m6uekQyuqJLBi1tcHStXpgW+ntu/O9G4YfVC+huHGIX+Dmw3MpfrFicJ0DQZ6VvVb9fZlLjDPM0jfOYoAIJuvpH2/ctYulVX1j91BkqFnDKYlY0fqMB6EUT4IP2BNYJt1bFVGY5SHOIrENLs+Zt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035019; c=relaxed/simple;
	bh=Ti9Al11aFDkHr/+GZZA6MfI9Au3xncDNO3O9ju3DYVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UMNm4U3ALZvJ7W8Inq2ZQ4/HhpiEGH0nH6KKNYVyvlHt5nNKgVmQ3/Mlh2Hicn142XsIQgq5QQoDW+hk9lNtVy0QWrR47U1IY8LYs37tb+rLBjuCqSf0ntUW064xwmo12mzDuZQmtgUucJpSX/cFJLuucS6+rINCFhhMhW8QD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCrPW/6L; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCrPW/6L"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so44178485ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790035018; x=1790639818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bT4URT099tlSuoY6C/X11+mI3xpJgIcGDy2oYYWeJzc=;
        b=FCrPW/6LB7qQlNyQ7wPDZLVE6TnM9+fBqGiPLCGXlj3yQQ8iOui34QdXrtIvf19orw
         qV7GVPQSIFMNWkeaW1uQcmK5CDIJImD3SAl9OmWleXJ5wRdeXaj3Basc5RFk3d/4xkZq
         F3cprhcui3WEOx1yfylw/SfhevudDfZeT7DvMRBK6DGtKkj+HkTt3M+c3BanYZiu0exy
         bjA8CT+YZtDLvNPTR+YqffErbrwl586SArrPEYfsNrLIA4mZj1cEFA9jx1ae0NoC4+it
         3b1pcqk1NAyPlnThpsxjw8tqovTOqVbmB57Dx2XFffzk4byzr7jFRBELuHKcrXrpo3Eq
         GOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035018; x=1790639818;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bT4URT099tlSuoY6C/X11+mI3xpJgIcGDy2oYYWeJzc=;
        b=0E8rHp2/oasSko9qUzZb+xeLobfNSYt6+48pX4K/4MMFTpWmE02mooIM/vFzEDNHyf
         a1Ikctd5sn84Fa7t5P34bunf5nd94NUJepN8eZ+R1rX17DDjdsoq0+AmJatJs1zfjZ5n
         L2Pqc2eN5/ryJN1HTKsHzuqqs55OdzV7QGbMkaE+a8Cp4ln9j2uJMk9oulXDKVhvMTv+
         5Rx+JzDIVKa2tGjs6U0G1H2LQl7fVA5sejls4hD5rv4xO6NYBG7eWI/hqkGa6KejVKce
         1nwmjCxMWkYGq7NCJMxyhXLR4BhRxXWbm1SRoTIbZurVYrRBc5+1mi4i67T4GdD85t8R
         oBTA==
X-Gm-Message-State: AFuF++nz9lotyhAF1slJvYF9I8gaAeth9TXVuS0w9PmGWjxfnTmO8JCq
	Cbho65ziMQQs17P5opiPiIKvfSG7m1fe5D7u4WhR6lLimsqjUtb1ZJuxitIwC2BMi3mSyU2Nqxo
	cQg2zIg==
X-Received: from plas19.prod.google.com ([2002:a17:903:2013:b0:2df:4ca9:b013])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2990:b0:2dd:c053:82f5
 with SMTP id d9443c01a7336-2ddc0538431mr123944065ad.44.1790035017535; Mon, 21
 Sep 2026 16:56:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 16:56:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921235656.1107929-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used for
 failed VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
to stuff the exit reason on a failed VM-Enter so that the magic can be
reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
defined value (though the whole "dead" thing makes it pretty darn obvious).

Opportunistically add a compile-time assert to ensure the KVM-defined exit
reason never collides with a "real" exit reason.

No functional change intended.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h | 8 ++++++++
 arch/x86/kvm/vmx/vmx.c     | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3f1b3096ff04..e49b836c7313 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,6 +20,14 @@
 #include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
+/*
+ * UNDEFINED is a KVM-defined value used to indicate that the basic exit reason
+ * is undefined/invalid, e.g. on VM-Fail or if TDX never attempted VM-Enter.
+ * The value itself is arbitrary, it just needs to not collide with a real exit
+ * reason.
+ */
+#define EXIT_REASON_UNDEFINED			0xdead
+
 struct vmcs_hdr {
 	u32 revision_id:31;
 	u32 shadow_vmcs:1;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..c897dbf0e954 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6388,6 +6388,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
+static_assert(EXIT_REASON_UNDEFINED >= ARRAY_SIZE(kvm_vmx_exit_handlers));
+
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -7474,7 +7476,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	vmx_enable_fb_clear(vmx);
 
 	if (unlikely(vmx->fail)) {
-		vmx->vt.exit_reason.full = 0xdead;
+		vmx->vt.exit_reason.full = EXIT_REASON_UNDEFINED;
 		goto out;
 	}
 

base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.55.0.1082.g2b9226bbc0-goog

