Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922477;
	b=4m3Y/WTv60y/mFFJK/jhpuzzsCx6MQfD+YydOUkZMR8Xm3egbWQ7tH8Y4l0xl6vDZtV3
	 aTU54pB6IJRoJhg8Ial/mLH/YLKYsYCLVcwE1aJRiTtqvFaoue5+8d9/ld5lV5xtHEkSK
	 8Wk8yBPxcvvD1t0MHqDa90H1HdHiyVF+71kZlqD1RSb4m0hI291M/0kPyFMnoz5fkZzbf
	 Mf2Lcj7pfxpAW9NNKug4zWONxJkMb8V9vIEGIJmvwlSrY8ywbRR3dZrKpxUc+FQ3tJYs2
	 A53CtAkYvQ7zmjCC7WSyGBVFQmdoWBAN9fgVb5IuhXLBPlBI5eUCHEvnK3qk2eOr0Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uBiUoB1GQ4LQL/nXuU6yhE6GYWmPG/iDNPjaG+VzZl8=;
	b=5Yv/4NM6kB6cr2ydjCY7QUhh6uALkoHjdCBkAWCew2Up91ICxevFVAYjNJqXqlaIEo7U
	 1bua9cvdOiFHXn+3gTrKpXTAHCNCtcTF6MzQYkcCGY3QgVnTEQ9dNpYMrk0XxbQ8R7baf
	 9KWhoPT2FMm4KCJgQTDbR6SyMshGBpBC6CfCMo7ShCNCH7vcRFXApSXolvrLkZPBoyvim
	 6yVDWEHmyLuX1zcU2FOek8G2FifB7R4OjnOthG87m+VAmJ/L0Ndc8N/lKmfbVRNrVfN6N
	 kbXmyJ8FSeWj67J/zjLoD+5hwzL2b8B1BWzCq/0QcsMG5K4mk7u6R3e16WZwmb6TGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Sh4xLnrP;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6046082BF8
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6046082BF8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Sh4xLnrP
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0a9de9c2aso56945a91.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922476; x=1794527276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBiUoB1GQ4LQL/nXuU6yhE6GYWmPG/iDNPjaG+VzZl8=;
        b=Sh4xLnrPQCtkCjJNAKKgYGKKBVufKochi6YvaQF8Qf7BOz7Gk7yheW2+Sl2k5OU4Dv
         7s52UMTdVacvuKRGeFPNmVzoEfj+gVmWV0NRSTPUhVUp0EbsY8uK4t2tehYsL/m/Fuir
         iXMzwoTHs//urexz+DJxn3k53BXo2raaQwN9+4jdudlnNOR9bT4e6wgVnRpRqUF24LCm
         xETycjKqFaUlmMKRWpBObwq3PqH7U4jazIXErBcbv7cphkRY+mRmR+NP3wJZQ8QC2c1c
         BlZvivmpJzwsAJ3dvGaaOOb2dUUqbBYBtnysb8/ZDmRbVAzYloVNy4a0d2Dx8gAGOO7L
         urTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922476; x=1794527276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBiUoB1GQ4LQL/nXuU6yhE6GYWmPG/iDNPjaG+VzZl8=;
        b=gAj1JseSFFLwH0V57w9VZEqZ0GuEr/2F/rRu50WD2RoAOs0VXFvQw2PEvvf4WgFWYo
         qKMzKwKuTW3JE5L/y7I/hBjQdNAP8ksEGaqEBQ7qllPJLGHf8CrrgWlyfw7bS1nrcCKC
         JTGkHpeB5taVhAlr/dFAsTPVOefcUm8uK+ft82azIAiN14gybODvfGymEJpfOutXWG1W
         jgzMyBxpb13T/OUtwJTpJ3sQ4pRKvzUj4OPquscNbwGf7Bl/k2iASzFUrN5J/LoZu7oE
         4r+5yqf5+pI8SbbiFczgOYUkqz4D893dknZA8hToM8qhWvrJVTJHel3aXu0VXqgxlRv0
         ZRgw==
X-Forwarded-Encrypted: i=1; AKwUvBztmuSuAJ5kmHmnet3QYCuX9SYduUmEtYoUcx0euuqwkTff9rNtlMkHJVBvn74Hrbrkb3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aP7qtZg4uePXwkyIqc9U0vJxCJtDbNIzFtl6Tjl242/BWAg6O
	tza16VHmtN5vkibcPNwyl0RASQ3zCU3V3Ywn9tksIINy5AsbSHQTL13QJc+jOQvAywkaabK3bES
	DNhnSSg==
X-Received: from pgly13.prod.google.com ([2002:a63:180d:0:b0:cd6:1e1f:43b])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5390:b0:3a4:8c41:fab6
 with SMTP id 98e67ed59e1d1-3b0db700909mr672764a91.46.1793922475543; Thu, 05
 Nov 2026 15:47:55 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:58 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=3040;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=zQXICDUfkyOEjaQ9E9JzE6XP0PgFJvrAcKjCLLRv2PE=; b=++6VzU7tL+aM9iRm8j00/5V85eUN0JZ0BcvHYqocl+buUFvfNvnydmWJLpoiJC7HCuRMpkMxR
 x50Ds50F24LDNDjtcclc41/SVXvHrQHGmmELVCo9jjrlTVl90UlLMh6
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-14-2024e8fa517a@google.com>
Subject: [PATCH v16 14/20] KVM: selftests: Set entry point for TDX guest code
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

Since the rip register is inaccessible for TDX VMs, we need a different
way to set the guest entry point for TDX VMs. This is done by writing
the guest code address to a predefined location in the guest memory and
loading it into rip as part of the TDX boot code.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c        | 10 +++++++---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 10 ++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 9d951f67b3b5..1cc876891589 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -72,5 +72,6 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 void tdx_vcpu_init(struct kvm_vcpu *vcpu);
+void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 110d23e50bcc..11db6a3b0366 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -853,9 +853,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu, &regs);
-	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vcpu->vm)) {
+		tdx_vcpu_set_entry_point(vcpu, guest_code);
+	} else {
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip = (unsigned long)guest_code;
+		vcpu_regs_set(vcpu, &regs);
+	}
 }
 
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 84127618f05c..324f3c41aa61 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -118,6 +118,16 @@ void tdx_vcpu_init(struct kvm_vcpu *vcpu)
 	tdx_vcpu_load_boot_parameters(vcpu);
 }
 
+void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vcpu->vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+
+	vcpu_params->guest_code = (u64)guest_code;
+}
+
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.56.0.455.g6c5a503b38-goog

