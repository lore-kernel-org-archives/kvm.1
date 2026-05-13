Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0A289E13
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676547; cv=none; b=govSUwPquLRbh81zP3B2uej4Neh7jRbpO+GEVNOZURv4icNucWCDXxVda5GOcgCha907ViTdi3MVJZBueI05MmFyfxbu65uatlayM+pY3ZBnKQKUO47ytI2SbT761XSx0qKJLBxRq7eO0NE3+tjyOLeA/CPpFSdhsmlUXGkPhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676547; c=relaxed/simple;
	bh=jRvKpxoAIl60/V1P+VTJHEK99Z/0YiaHhUBAFANty0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfiJBLyRxSDt00tZZkExqSedE+QMDElZH26/EqG5az3KoNlPaDuke16Xz6yGYQIGHYHvP4IxaufSL1D0V9eSf9pHbCjyGn0pVoNfPyTGCsHuhARLxUPM0EWqS/9O+T9EGQh3fG/ZMLCvoaAfVoyuMtS5cLkgiuSs0tIBz5a2ZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc2jiWDc; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc2jiWDc"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c1a170a50so9163973c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676544; x=1779281344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtWmrYOKzZ6UotIe01yj+lYhNEkXI+QSLpIqgQNFL98=;
        b=Yc2jiWDckooVMN+B5kNeu7FEdv1hUApLztH7fLQHUWgmQMSE2UAJd82NAZNIFv16H7
         zmcKpmLlf2s5Y4uWFetTFr74RI/EsWpd32xLcs5xuHpmS9fk9Ak0puAnB4BXoXa2XlGr
         UAh1VpkJyT2w35tXfxJctbbyJjyRqtSYT3e3gH65wU+PjQD7WbTBaQRlMVAmyCt9yR6h
         IV0HnyTV+zbAWT1mPXawLYve9HXCbTc7hac9Jf+Jwv1UIubet9JNPr7F32VAsMuw9t7x
         ZNemkzbJ/OgozE2yRXWFUl8KsnnZ+ESH6c6i9E0nsK4Ghb0uVUKlM/I5DIU62Y07F0jt
         4sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676544; x=1779281344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LtWmrYOKzZ6UotIe01yj+lYhNEkXI+QSLpIqgQNFL98=;
        b=J2umaZiPRS4tG1VlZwlS5DrTYNJGai66i/NsIqSwIroQnlCXa8R4UzMf3oayLVuTxB
         X9i7EZ+awfvPftjw4VlOk641xFYuAY8TpNmgYwuIdR3Mz7A7ZUAXSimlpU2ZArdYJu+V
         SIbIM/PfWiIIOQbhem8AUk79+2jXF7ZTOYEIN4JhaCitLNxAgcy9SKr8HfW+U4tcVDSe
         hOVIfdRcMMfuhoIgo/pQP16a2j2vU9r6MHpcD1MFh6qneV6pb2J59iIhPaNGIzko5nmZ
         p7QF3FytoR+bMtAO+zh7EhWnL1i0i0c6RdyUoC1RqfJAPkp9lgok+MHe51WqfQdY/EO+
         h9jA==
X-Forwarded-Encrypted: i=1; AFNElJ/KC/rM8rML8Ss6wWp/Rs/U8rVtg4aHIzsuXlQEhtTstOO4cAppSh9b/gqnq4i4GbLJPDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSYNqmGOn1eH1zwQHVoSvGeDeE+pde9qHOwgSOM6qKwm+stJg
	UFOeDWkzk4wgknPHybAVjhwSQxIp67tm57kVeepc4rKT+VsWNvpgV5uIn/gRr1eM6qg=
X-Gm-Gg: Acq92OGtfj0BJ+nSfMZclhUyj8ATdlAP2z6B62gfMMteipMOUYrGylvqZO/BL1uPlLY
	8jdzf8uoL0u9kO0Uaj0hU+tolP8y458foAFWoGjlSfdFDFyeZ4wneeKchRyxvLNnAJZoW4qClqe
	8W2Q+rhV+mDtKp8SX/nrXdqD5r8vZiJrOTgQeo7B/qt1wP5YY3Pd618I/yUmKEXXTA5QMc1xnZX
	NZMOfy81eO3SkpERPyXhfE+4tdZ74STXXv2xekmIqkF4IBQuNemVmKYxJTJEE/qo1XzDJq41hiO
	/ti0pcHzNbgSht0m9Nnh3Kd+KUaA+GBG4bZOUxYceGLcUGFwQzmOXvwsg6mqbO4NCvRCDt3N70s
	zKnubFNnLcfAeI+ttsGn2mAu1msLsb6WslpTL6qaEL1jP3ceywiDt5gNC8dQoX4DcUODD6bqAy7
	k1ov8QZlXL/+Uy45Db39Pdm8Z51xTGRxzrRJsMJYXN
X-Received: by 2002:a05:7022:ead3:b0:133:3bb1:8e43 with SMTP id a92af1059eb24-1349a938025mr1465669c88.19.1778676543906;
        Wed, 13 May 2026 05:49:03 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm1066142c88.12.2026.05.13.05.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:49:03 -0700 (PDT)
From: Ewan Hai <ewandevelop@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH v1 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Date: Wed, 13 May 2026 20:48:45 +0800
Message-Id: <20260513124846.1622462-5-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513124846.1622462-1-ewandevelop@gmail.com>
References: <20260513124846.1622462-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise the Zhaoxin PadLock Hash Engine v2 to guests via CPUID
0xC0000001 EDX bits 25 (PHE2) and 26 (PHE2_EN). PHE2 extends the
PadLock hash family with SHA-384 and SHA-512 support per FIPS 180-3,
complementing the existing PHE feature (SHA-1 and SHA-256).

Two user-mode instructions are exposed, documented in the Zhaoxin
PadLock Instruction Reference, chapter 3 ("Hash Engine"):

  - REP XSHA384 (encoding F3 0F A6 D8, subsection 3.3)
  - REP XSHA512 (encoding F3 0F A6 E0, subsection 3.4)

Both consume software-padded 128-byte blocks (RCX = block count, RSI =
input, RDI = state) and produce hash output in the state buffer.

Both instructions are user-mode and available in all CPU modes, with no
associated MSR control. The PHE2 and PHE2_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for PHE2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 087c41341240..3fb81f7a6107 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1288,6 +1288,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PMM_EN),
 		F(RNG2),
 		F(RNG2_EN),
+		F(PHE2),
+		F(PHE2_EN),
 	);
 
 	/*
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 859ba43126d8..f28300c2d5e0 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -83,6 +83,8 @@
 #define X86_FEATURE_CCS_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 5)
 #define X86_FEATURE_RNG2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 22)
 #define X86_FEATURE_RNG2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 23)
+#define X86_FEATURE_PHE2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 25)
+#define X86_FEATURE_PHE2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 26)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1

