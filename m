Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922481;
	b=TN7uleZF1JThZjSfCrBtb/FWsxtOzImwQ49kuqvT/2fFUoU2A5/wqyrKa7rs39WHYNm6
	 J7HIMFM8tdP1DjeAIG95YKDJ4FG4g/H+2GhJrsLDbyjxvtrHaqlj18B51YJuzLBNOK+0Q
	 qu6UOEr/9KeXPFDcGWQ21BJJlpMXh/Kz0/65Yeznc3JrfBzqVIzcpkz9e5ZGc+qa497V3
	 2udbldnHOgFDCvcdauodexef6jJrMavKiF0aSzLfzlBrpNzR2dQZkCgGC0Bd78RNZ+og6
	 GzA2P9LW1usmRGonE9fVpytn3t1/3Wc5wivKvM3rhu8s5sYDTb1YaMxvSbjTfqDhtcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=a1QLD2xcyGVhLJbNzuWXPP2Gml3MYrb+er2GK1r6mD4=;
	b=QhA2Re0Y/Y0ETDVjaAXfrTCtkNj27D9g/q9VBPziWarVxv6WHkJ/5QoUoS3+GTWP3GBK
	 wkbDPMmSS7i1jfCdqfq/NsnfnaSsPfOi5el2DkjZyKfRTSPFwkDCFVeTwTb3rkkt+gc+m
	 +4g5mSYp9RKaGYJitoGkgH9k3iM7irF0+Mfbm6flAvq8AT1AES6CXDe3gNlLcGzDYQwjh
	 T4+YKAL1sJaM/ZhFT1yv59GPHghLkGpD4F98YfMT5fhZ8nBbW3CRX7oD0zz1Qe13C4aGK
	 SUU99KljeVfqtplQaCYRY6exoyBYoCkAwZH4keuGjRL9iRGVZ3rYHbSA7/Ao+dNvzuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hKoXHZop;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3660A2633
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A3660A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hKoXHZop
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a064f294cbso36644b3a.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922475; x=1794527275; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1QLD2xcyGVhLJbNzuWXPP2Gml3MYrb+er2GK1r6mD4=;
        b=hKoXHZopodYJnsDJh88vcJpXxG8Df4fZkqMzTlT70bq9ex4uH6PcQ/j/4I3pIjvyWp
         sDsSccY2IKZ7VIMQLkbuvqHaYfpmrBZ9pDgi5d7maI/QKrSG10QAG88KFpb1mrpVzxTI
         UDTuDjQicNqCbTbVExb2wlF9/zytZbHiIiiJRaz6mvE+4m8qYUahepJYv0fOzthirzWx
         HgMaSnQ+C7QxIh67yTewGa0YKBP7+m40AQLq5Esgm59zm+Eo1+dCwM098HtnUTpTu8m/
         85t0fHtTkwDI2u1KTq/JEDMcCiFMDdD5fB7ABkr3wRPDf8195YElApWftrVPe8Ig+Phq
         akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922475; x=1794527275;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1QLD2xcyGVhLJbNzuWXPP2Gml3MYrb+er2GK1r6mD4=;
        b=OF36/KdZhgAtWNqVbXYzipxFjb4NEqcaLu3/CtctYEsGUlO2nlDOMfxFnhCbhIrkpf
         1T3Uv7gSg10ZPj4goe+Vrrrv1x5VCR0QXR/1pp74/Ak31Cjic1Qa2LrttWda/RM70Wjh
         3RzMj6ln3nwRe77KY18a4gXJoJ03mnWDgDgdPho6ol/IvYs2KVstlEuyvR6tNUoVQH0T
         h/1JdYzbOEJVmErYCP31CxJ9AC0gGufdjZgcr4BNyUdQqIaMRVOgfzvhhUEEQJMdG+TO
         qVVV28KthkC5JNzNsd2YpiYXOFjBszbpVLkqIoWVysXIs7I87JAGGCWOSAUodc2nQJXE
         I+DA==
X-Forwarded-Encrypted: i=1; AKwUvByZ9A4hO2SFrA6EYb72jxrsfJ0iSZM4UKIwwIKRq43Nt7EQtkN9E67kjU6ZDreuWdqPVjY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R3pvQyimDvkebDX1xQj1XTWHFak1TQgtJev9Czk6dDs1uv35x
	2Z28GewQxULFPCwZ0/mJ4auMFyOzfEBC1qgrSgjBe/MGt0df4Lkb+wC6GZBafYeLeAXrnL/G89D
	TGTYigg==
X-Received: from pfjx4.prod.google.com ([2002:aa7:9a44:0:b0:891:63bf:32])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9a8:b0:89c:6036:c63
 with SMTP id d2e1a72fcca58-8b37b862efcmr575019b3a.32.1793922474556; Thu, 05
 Nov 2026 15:47:54 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:57 +0000
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=1858;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=NM6v7ONAFm4dNOExo6KcnYRESswxRmJRZoN0Wgy5vKo=; b=rxaC7zWae+B+wvnUQ6WsS8EzDvG4JDUhu9mkJ8j0pMZd6hTfMyQSdNAu+OQERPGWCU9V6tAHa
 SdL98gWfLccB0vNbP/TFPIBxbhYs/6mQh+jYJKA0Ph6k8zpPzB7saQw
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-13-2024e8fa517a@google.com>
Subject: [PATCH v16 13/20] KVM: selftests: Load per-vCPU guest stack in TDX
 boot parameters
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

From: Sagi Shahar <sagis@google.com>

Allocate a guest stack for each vCPU and record the GVA in the TDX boot
parameters region to allow proper vCPU initialization.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 1719dc1bb060..84127618f05c 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -91,6 +91,20 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
 	params->gdtr.limit = kvm_get_default_gdt_limit();
 }
 
+static void tdx_vcpu_load_boot_parameters(struct kvm_vcpu *vcpu)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vcpu->vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+	gva_t esp_gva;
+
+	esp_gva = vm_alloc_stack(vcpu->vm, DEFAULT_STACK_PGS);
+	TEST_ASSERT(esp_gva < (1ULL << 32),
+		    "ESP GVA must be within 32-bit address space for 32-bit boot code");
+	vcpu_params->esp_gva = esp_gva;
+}
+
 void tdx_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid2 *cpuid;
@@ -100,6 +114,8 @@ void tdx_vcpu_init(struct kvm_vcpu *vcpu)
 	vcpu_init_cpuid(vcpu, cpuid);
 	free(cpuid);
 	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+
+	tdx_vcpu_load_boot_parameters(vcpu);
 }
 
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)

-- 
2.56.0.455.g6c5a503b38-goog

