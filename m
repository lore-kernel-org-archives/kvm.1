Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817E223708
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310045; cv=none; b=j+CHSk+41IzoAW0mqTge1AE4dt8v7W4d9wqGZaHixZ6g0+5W01OeaTmKI56hOW+zjqKM1oSEhhi+fsQTTGCO6KgXcnwkMFXGUz5aR9xifeBcIrkFCtgK2wTpInJghyLWg2ZZX8XEHBbRTIMm1ZCFbMVu6PjyQ26LdOHCvzNfN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310045; c=relaxed/simple;
	bh=JV1d9mTxVyznuvXEHzHbiL6DP5o6g8Jk2shnAwWUw40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ahDQ/H0Ki5a5nawdIyhYCWBrDiGpi5p3tQeJJ1/8oHERn+XzUU6/sEwtJGOMfx/Kw9ZGsc7lk/uySas4J75zuH0hW7GFt52itufeqePPUjEMj3Ovrew+YX5UuX1cSm6pmlhvgLREHMVQlQQdb+OG0schv9+oQ0V3jiSCEYv2iUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzwFjX9G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzwFjX9G"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beff6b6e74so20147675ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310039; x=1781914839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=O+I565ELukpP/rjfHIhv+TORYO3S6R2jcA7ns197jWA=;
        b=dzwFjX9GY0CSkCBXRt/58WrcYLpeiLuHg9QoPiD33dU/zLbtS1UHo9/qa+OgFBZz/q
         T+vlISLH6h55IZf12nxNjvdPKQ75S6dvNXhy1UczUOB0UvIsBZbnUbe65IdXrpEDZ2qP
         2lyTuDrd0t1J/0uB8TOuBYw4LVtxeACHc9OFeJnmR1yJNGMSfEvVZocpllGiwTEzF/Di
         OPd1XkFptI35D/zAI7wbeLlXMkoX2s+BHkgMqFluEa5KwT9UNkUYBRApU/IMHDGOPEwO
         mlu0jdeCCRcXrFDRkojlq0cxjfDPC6yKHMLwzHcY5Z+J3VcLyhK08Mmo/Z9kdlVDNXF5
         y2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310039; x=1781914839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+I565ELukpP/rjfHIhv+TORYO3S6R2jcA7ns197jWA=;
        b=p5xcH2pCRPbu5VFvHGjCKLvozDIBflXZDI4jEIAxO2SDAD2PYifoGoZtl8qdc7kgwF
         NT/GWoUxT9GIYkGa+M2yV1ByPKhrfR64P+oZs//O3IkmXCWDUYndeuIwEtc94vDtPbiS
         zMD9nQ1lPQA2AjtiNsdBegEJ96ArhUHQ6sSyT198vtJ3wF74uzIO4W8gIc6nFfvskY+k
         ca8o7cFUm6tWH7kmxeshwoXoqPubsE0ZwC62n+X55CvLCz4aSyeqFRW1CrAA0ShdlKV3
         ZdD7nGSRCAgU6raYkRXk8MtuECSMZurI2LZkFLDAN79BiTjR9oaaaS36ziDIY5uBgiTF
         2OYg==
X-Forwarded-Encrypted: i=1; AFNElJ+lRfs3VNbgKaZAWLx+Pct2LhBckxRI1ZB1vW0Vj9zWIBhbYnMSGxCKK4yabEiSygHLft4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2C9QXft8Gr3371untKJ2FGqIfA2rei8Gr7jznZMHRk7p0EYM
	IrT4phBVPmpI26jsieoy7+yxKnrcuMn+8qFo6IUl4X7Cb0+lfdVN87akM75Tk44QD0fkx7g6Mbm
	yD5Kv/g==
X-Received: from plbjb12.prod.google.com ([2002:a17:903:258c:b0:2b2:425f:b4f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1248:b0:2c1:69cb:4423
 with SMTP id d9443c01a7336-2c4111b8e7cmr56455115ad.14.1781310038540; Fri, 12
 Jun 2026 17:20:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:15 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-5-seanjc@google.com>
Subject: [PATCH v7 04/20] KVM: selftests: Initialize the default/global pRNG
 during kvm_selftest_init()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Initialize the default kvm_rng during selftest initialization so that the
pRNG can be used by tests before creating a VM.  As pointed out by Sashiko,
failure to actually initialize the generate makes it decidedly not random.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 875030c22d07..1016865d3f7a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -24,6 +24,13 @@ u32 kvm_random_seed;
 struct kvm_random_state kvm_rng;
 static u32 last_kvm_seed;
 
+static void kvm_seed_rng(u32 seed)
+{
+	kvm_random_seed = last_kvm_seed = seed;
+	pr_info("Random seed: 0x%x\n", kvm_random_seed);
+	kvm_rng = new_kvm_random_state(kvm_random_seed);
+}
+
 static size_t vcpu_mmap_sz(void);
 
 int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
@@ -515,11 +522,9 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 	slot0 = memslot2region(vm, 0);
 	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
 
-	if (kvm_random_seed != last_kvm_seed) {
-		pr_info("Random seed: 0x%x\n", kvm_random_seed);
-		last_kvm_seed = kvm_random_seed;
-	}
-	kvm_rng = new_kvm_random_state(kvm_random_seed);
+	if (kvm_random_seed != last_kvm_seed)
+		kvm_seed_rng(kvm_random_seed);
+
 	sync_global_to_guest(vm, kvm_rng);
 
 	kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
@@ -2279,8 +2284,7 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	sigaction(SIGILL, &sig_sa, NULL);
 	sigaction(SIGFPE, &sig_sa, NULL);
 
-	kvm_random_seed = last_kvm_seed = random();
-	pr_info("Random seed: 0x%x\n", kvm_random_seed);
+	kvm_seed_rng(random());
 
 	kvm_selftest_arch_init();
 }
-- 
2.54.0.1136.gdb2ca164c4-goog

