Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C1473C6D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266810; cv=none; b=euolH9Uj8/XkMeElorIz9N2UokoPI75Np8JFDkW9PRCwhqvev+/78vsQ7eLcOWK0szr6ji938TG+lgyEOgrvC/D9WNxbRbnfsE7//hfGPjJ3HrUBqsKcury7vugMEE5NhKSKG3gsZ/+ljRI72m6tm00nPExk4y6jaUk/WAxk8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266810; c=relaxed/simple;
	bh=W4yBK5Y1F9xzsVAZdYBSgDqoHXS+UfCRZUsX2qeQAss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH3UahVM2uxX2AwVxxG/lthotoGDyXze/1xajNA7C+YcbKWRCuRf2hYWVv+wnLkJ/eBFlfiVawnt0tnnP4jNE8rz2+VhraXR0Z8xHcCEt5iviST7XI784x0SnUFgGBzgdegAy8UXtxSQB0JgOS04K+7NN2AhUhih7BVhQ4vb9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wklsD0cz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wklsD0cz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so161317a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266808; x=1785871608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
        b=wklsD0czhR1rLf76uHC/+nVNb+TlFqqQKWb6Z4CRtjSgdX/MSAKdohWJSPMsp4GoW2
         G9VkqeOjvttt6sqkAkiNNZZJysQA1TFeProq1krvROHtuf+5goAG+T08tWHM5CwD9cze
         aWxQQvDqzgous/7FkybgGxYX9FUYPoHUHc5pN5IRolATB5WUBJq89ml0VnCxCkpRj1DJ
         zwVAdfggmkQG4B8JFKOYGbyhz7I5Y8FafmVPAlp4kXpT6tKwok2bleK+SkW2wPR8qe+D
         ViBTx0+8ley5cEKtzashNdXbpgS89pNDGtQgkMVuMXJMZlVpdHoA8CqVcAjWmEVkr/UH
         QxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266808; x=1785871608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
        b=eQO9bA/NaZKBYyqKM5laSsaSCnk2yZlBZQljkb3X7wsfTQyaIuL1b+HzN1IN8WSNXK
         6piipKUo8NUhJenxltI57gxgHJm9k8ejygT27bkLa4hwiQlVIsN2OwbQKuh+eU2//j05
         IjWwLcIhZUNUP4wPoQTbHENbQHaURuOaGLgJDtDgPl5XuXqe9BSij3UntZZ/SG2osSse
         HkUahP/5wmFDWrUqZCifQMg8FcL3zNm1enqtOvMBjHws9RPJjAlcB58PzUjgJ0G8FBxZ
         fRCakuH/uQFFrJiMjdbI92DNjrKvp3ys1pvwphCKRAqel7YtROPgnJSPNvAA0S85hUdo
         RbmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcGQWTMORcDTpiqxZLVwubzLSM0Myxm8YAYU9njVP0kjfHv62GTGhoOcx9yBr/vx0U7rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK+g+jYMzEQ2ToVt50qNKXxDray90dWbynEe/Jocjg0LLKdOm
	UQuk+Mz3PnhAhMae/5uRYTEtN3P1s2hZJ2wHq+pRvUEG6MbKpJujANDPzMjbrYMW9NM=
X-Gm-Gg: AR+sD13F5qYN+/wsQkNT0GF9h2HjfcqXQ74WCjlDS84fq7oQpkWDqjvqWK8d+DhQblQ
	WryHhZG/vb3J5/LLs+S+7uh747+ICJtIFkw6jdInYwS8LpR4YiPg73DfTfKVf9h71kWdXvKRCtL
	h+tFTXZXAcwECmLtFcMB8/HffEDAJHbRGVMeDWoCaBq0tQJ7VdHIPlCOm7bQqo2w+ZQk2slJcck
	dHNCH5drWMy3Y7ma4c8ClqHKZGvGxnlswZX2L/AZiM8Qa6KEqdec/BRXpd2Tzje3/q5AfH2pbLo
	HsI19hseVnS0AdEec1cGizYvAGvFjBod+80FzzlWE1BKPo/YJhdM/u0ZY9B4dMR6Te2BgE473Xw
	dLQVfQV5FZWmRokNNcTFxg3bXuQgL1FIFt6gY4O9dWSTUzsXhcg+x4b4DTYlZ23WjJkoESP+Ho7
	YotvexF1z+U5aedhqg2CZ6eKYD1CueX2ZDbZlyRUZsVUmk1KK0rN9Hxc2Y4PdJW2z00vyeqkHTi
	2c30sOlGTZwmCE=
X-Received: by 2002:a17:90b:180c:b0:38e:5741:5173 with SMTP id 98e67ed59e1d1-38f6a4205e1mr3934859a91.29.1785266808420;
        Tue, 28 Jul 2026 12:26:48 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:47 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 07/24] target/arm/kvm: Create scratch Realm VM when requested
Date: Tue, 28 Jul 2026 13:26:13 -0600
Message-ID: <20260728192630.240375-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
index b4c6da1fb9f3..d86e66e056b9 100644
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

