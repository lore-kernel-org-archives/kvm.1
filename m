Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE234CFC7
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464196; cv=none; b=e3xNQDZoBHf+bWbfqR337zgfNvkyhF3oYLrXBZn+BG0rFNad8N39Q/4+SIlP3JtGT/jRicHGTGfmwyeI39yjKjjmrrSozeE/hXH8xwujsXoB9UgWmkZZIwT0KWyOTFv3ILCW4XvLhq5QBBcxn69BVtGSlnPAfJKwFirwROvhhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464196; c=relaxed/simple;
	bh=YzvWm8B9TGMeWW1VahTVcmUsbugo63tSUlDz+c90MFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQsGqXnl2hd4kH5fKsNSo1DRYWzh1f5WTOmd7hvmz3VeWxXxU1JBOc2/7xt3r1SzFSnurzzY7by8wYsmv1GRIAOaCFaxBlDvCYkSU6sK/x0HJvnZKZHGQJxKd0XsqqnpAlH9aeGKbg8wSRI3GVFnSZjoKpWBFCsveA/ZfrIhBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPYoInU6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPYoInU6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad8076b01so949665ad.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464194; x=1784068994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R71DJ1s0zDCfKOKIafJMIMtfyKJnrf0v9yatLVZyeqA=;
        b=GPYoInU65pxEpRsGtXDSYNVozOqxNHfGrObb4Jxev/0OCK/eibO6FVYqgVqIazve0n
         VzHC6Pv3j4WUcEZBW0YxUR7dZdMdkzgTF9BkCofLfLRK6RCxh2D8LKN2MOdZ5BYYHZ+J
         WJwrmUlebXHEv4Ep0qD5ekKyAcX8biPJ7wrsnQB2D4g5BzwlepjvqUUYlQwImN6/KhlZ
         OGT81jhlv6/bOn70wgC8n86WivWxBUjAvbD7Oo2tIXV1xfZUmC4NWoM7vjyMVTqjFHWt
         UNSQ3ZLWPYBHDaJdR+96fDSsDXFZvj+rt+KM8sAxQ6aX29XMyWGxeRCzZ5LCUaiSdz9l
         cpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464194; x=1784068994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R71DJ1s0zDCfKOKIafJMIMtfyKJnrf0v9yatLVZyeqA=;
        b=OE+BK+eQtZskhnneCKVX5aS3/GKkx9XdLJFyi9ZVUGvn4Zx5ucaB++EPWK4cS3ZzNH
         xul8SVx94BeaKNe38cet1g+LFY5EQYvcbpE5IJnQB5aDc9yo1Exc2R/k8PY1QQJEKSaQ
         ijzZydGewU9otTSzHcCLyZFa2n7xBqPYZk7yM/vMT0m7TRlq6m5wmhWXjsSZxikZ//Ac
         +659D5PVmIYwpz079EADOzPum+lhL5UT25yDt4KRsjAI7SgVTWGaALEypdKNpgonnNm7
         atTm9Rz+O5k9k6SwBz3NYzCJmDC5OrZ9k+FKxNcWcDfMQyq4DZnXVPNEvt67mNIsBeGu
         dkLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIg1HRjMynswhtfyBIaVQTjOaNxB4wy9tGJogtHr7D2VWAwlIt3nNBD0jW0aYvS7ani1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEA7yK3S5sb9oPXJW+WVP2ltv1rWUZAdc2H8wGFMmQ7YITecj
	brvBywc0EpCne6bqv/DTqqefW9RurcIKJgaNSDmvKXNXpgtJ0Aes1n0LyNzM/lW9VSo=
X-Gm-Gg: AfdE7cnJjGy4KbHHDahtMRwZWI0K3aBi0yXfl4HqeDlgqwiOaVBZY86AHqfZblHIvGk
	pGKMJqnVz3G7R8ueKPv6qEI+CJ0uqeT2ve3pNIN2z7vc/K8pc+ly7ERbeqPjgCXO6F+Ysc8iX63
	bSNrLyijpcY+wfEDEbF2agOoBAsm3rtkcjfivrNuW2oZ+8hKL3jWK71Cs4zh747i0bEjrqySBcW
	sFZWsL5u3ptAofMAj4wvXpSiF8HsrwxIPtyjUeLdcE4ASDGHZ6jEzrPSL08J6Nvz7bQ9gj1UIhH
	RBqGsjQ1ng8tyubNRX3lcQedKYi8rtlPAivVHfdk3YJ9T82GyzQzB1jLztNYSnmjB5YNYTPETpI
	DHB8AjVpOJl9YZZ0DedtBV/TGZHn5g7r9jdkkIjSmEdWz3n7QGaeagf37RaciPG4Kp3d3ElfzWP
	MKrXmgbPgPEndw2Vt8k4lKzGG1txrEqIM6P/kRZR8=
X-Received: by 2002:a17:902:d4d1:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2ccd19251e8mr33153885ad.34.1783464194073;
        Tue, 07 Jul 2026 15:43:14 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:12 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 02/25] target/arm/kvm: Return immediately on error in kvm_arch_init()
Date: Tue,  7 Jul 2026 16:42:43 -0600
Message-ID: <20260707224306.1202330-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Leave the `ret` variable in the function scope because it will be reused
when adding RME support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a985914..ed99be7fd80c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -640,13 +640,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -659,7 +660,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0

