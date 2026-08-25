Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C926ED46
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695282; cv=none; b=KYzwANiiyOYZc04Ce7UpQivSIU/8D7WfvVOCrxP1qTzqAS7f5sEdg4h5JUvrXUYR5wmlvUwaA5FaZ5MXu7e69WKhGSQ9AndleyC8fGc7mIdx2p4Oi8hSrye9NYWe+SJUKyVv1CCLbigzzeehSqSZcNXYvtk6JD1Z/XzGcEY1i9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695282; c=relaxed/simple;
	bh=fWhvBon8VcaWp/RH58TpqL/EOOecTgooiAEpBxVJrFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH/fJVkMBpG5KqpfnhkSxZscZ/+qmAZ6uiUOW/AMNAnrX6RkaxcpZ+kvigZy9tIQAkYn/kaTcFpORDnFhcNXstB47Ww0PGA8wr6lyHYy4IFXteuVpfjWW/R+L46TRwpqIWj1LpizTt65k+i2gUWURZgUKYcVL7OdqYSnLt5MH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQ5DpRCa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQ5DpRCa"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc11a30a259so241907a12.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695280; x=1788300080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eyJsbM3B9U91rhA9XcMnnj9HbTzV3f8teoGWTnmCdi0=;
        b=nQ5DpRCa8P+LE1q8lhNUboeTnVkqRIo0gcKaOMIFjXJYg/ULmslTHbX81KCuQjC++Q
         9kvTqKl+tYlsN5jiNpflryBesVQmZUxdBLWLzdW+aqU2O3DcUK8D5jCtBzaVvlsS9Nxp
         G1ok3/Odur5eQWYdKKDw1HJmEnlGNNXGdinRRSsd4mMh4Fgi0dKGnuwaFbPkST8ej6dP
         XzpQNNs80QPsIbhlqpG3mZ//KX9+s5igDtfmTJOAFAqmyPKNlQ5cDtCEiJz2bPp+KQ8D
         XZfNTwk96s63HY/iVGspxZVh1fFoxOWuMPTkRrhIB/oka8hRNjNjwFMFfBSsIV5lqigC
         JgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695280; x=1788300080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eyJsbM3B9U91rhA9XcMnnj9HbTzV3f8teoGWTnmCdi0=;
        b=KizZ40wBEVkOhP1+HIJv+FjWgSKJlsOrvs7+isv+EY4Rz9El3A2HeT6urGVucgtlip
         pS1nvtYrkJICAnp754vqGczjXjNgMlu0t5ppzVvUlwztoaRdTXSdkOEPJg+e1LJRZdii
         qJaIB7CsE9BGA3rZ8OzuGyVpxjqrn2lFSq5Vgt1F0ZKwy4Vzr4M3E6+vqQOvbue3xa1g
         yFrwG2XaUbDqEacAI9ZTSrLWLJcGj0bKq0GE9jdi0uuMj67Z3qje/ZITAS75eL25vOQ3
         FLHu+OYKYtqQoRh8lbLXtAnprXSPNWREzuQ09JXfe5RYasZIv8C3ejwwKayXbAlklnyf
         fU6w==
X-Forwarded-Encrypted: i=1; AHgh+RogGZ75whdxI3Pwi9x4Oyt4mf5a4Nbln4wiR8IaWu8zm2lypea7s3VmIUy9kHDGKqbXsIU=@vger.kernel.org
X-Gm-Message-State: AFuF++nFeQ+KgiMOPHPTGUaiFiWgBWsy56dpSXCg9Rp41mhEeokww1Cd
	ONYaJyrL5G5uRuLDxe3KR143HTHO81C3jUDc5FNQpwPrM4tL5xSHem/7KwXZSBun7CU=
X-Gm-Gg: AR+sD10dv4/yTndnVk7E5IuKzWqYISNrGVAEyHTU66gxF94Jvz1byC35fU/WoV7c6DX
	C5cyss0KzXL7vGyVwoEjkYdqygdlt/5JbRmLtn1onI7OZIjrdSDcC93OrnHXmd3rkkBRrWj8+7t
	aIeu2WmnDw/dOgF8HFdoayvZsL/M9RnsRfKXzaBKRxZ90LHMIMLvBXiq8Hq8Mk+1fmUXQMDcyWN
	QgAshnj7pTU+VHqIlzP1Ixwtga6052OsiNhf/lOe9F/plCK+sWEVcAi9rf8G5qO5Iraz7b+p0fg
	Hc93yv9CJ+XMrDh4cc+XwJdp8SXEagOOmq5yjRnkajYGesPBrI/y/6kZ5atmrW3wT8G2mvshaa2
	5w4e54nci+MnPF9/nuoZ3S/nsvwzV/Cl/sEptTYzntI20w7cajPIUsP4MQYH3HkGIRlCYc8iZLd
	1B+L8HLISSpv8aHye69unT+8Vf0YnVdTMUe/FGbwV6xGxt
X-Received: by 2002:a17:90b:390a:b0:396:5785:843 with SMTP id 98e67ed59e1d1-3966d203a94mr3597179a91.8.1787695279952;
        Tue, 25 Aug 2026 15:01:19 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:18 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 07/24] target/arm/kvm: Create scratch Realm VM when requested
Date: Tue, 25 Aug 2026 16:00:44 -0600
Message-ID: <20260825220101.3443954-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 8
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ff179a66b821..1acbd885bf4e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.43.0

