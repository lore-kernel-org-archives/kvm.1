Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93184AAC4C
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636727; cv=none; b=iQUds4n5GFdG6QSKqdpu6/S1tqN0GqfAVYD20KYKUuAc7A2+V2U4/ZZM9dnBUPv0nI0bzjR0GQ3SLxj463t4DKdL9dMJN1lBJZ3FNdczz88AAVnQs6Swox1FLYb3Q0ug272HOtfYUgAIdNDpmTiyVdx32hs9JGTCnO35eqOllFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636727; c=relaxed/simple;
	bh=uv/QqzkCASpL/8RQbBzCZik975p5clqE6ezIH1NXyV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LyCvu/NmNafV91Vks0ZY45ybgmZj8zYUL5tHfVWSZ6TRWN3v6p/aPyAxk20kNvBY/KjJqfYbK8h0LQr1fJpC9YDcZbWU2qSgHJUvbQtCE+CKyTJH4+AfnuUr/VNj10fZz1OyUGMx+TZK0FQd462aop0Qidtc7XRljnihD1U0hhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5nNcqoP; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5nNcqoP"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uv/QqzkCASpL/8RQbBzCZik975p5clqE6ezIH1NXyV0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789636723; v=1; x=1790241523;
 b=c5nNcqoP5YWAKr+ihICugNGB3xouSZ4XFkDHJKmSX0/Rw5Y9yel3x9pufcYL/PsN/XWtYJwk
 iO5W6+iKPH6x3THUJNfQSSwixhYq3nJOwHun7Uu2P6iYzu2zmp94zkoRBXP5fC8gdnCyWLTIOQP
 15T45bJ5/6iRrzazSaZyAYcw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c94fbe1e4d9196cd;
	Thu, 17 Sep 2026 09:18:43 +0000
X-Mizu-Trace-ID: c94fbe1e4d9196cd
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: maz@kernel.org,
	oupton@kernel.org
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	qperret@google.com,
	vdonnefort@google.com,
	martijnbogaard@google.com,
	seiden@linux.ibm.com,
	tabba@google.com,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] KVM: arm64: selftests: Free the VM when the GIC device probe fails
Date: Thu, 17 Sep 2026 10:18:26 +0100
Message-Id: <20260917091826.2639205-5-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260917091826.2639205-1-fuad.tabba@linux.dev>
References: <20260917091826.2639205-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_kvm_device() creates a VM to probe the GIC version under test and
returns without freeing it when the probe fails, in vgic_init and in
its vgic_v5 copy. Free it on that path.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 4 +++-
 tools/testing/selftests/kvm/arm64/vgic_v5.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_init.c b/tools/testing/selftests/kvm/arm64/vgic_init.c
index 47e34b43afb29..53894d32b0fc8 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_init.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_init.c
@@ -732,8 +732,10 @@ int test_kvm_device(u32 gic_dev_type)
 
 	/* trial mode */
 	ret = __kvm_test_create_device(v.vm, gic_dev_type);
-	if (ret)
+	if (ret) {
+		kvm_vm_free(v.vm);
 		return ret;
+	}
 	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
 	ret = __kvm_create_device(v.vm, gic_dev_type);
diff --git a/tools/testing/selftests/kvm/arm64/vgic_v5.c b/tools/testing/selftests/kvm/arm64/vgic_v5.c
index 96cfd6bb32f6f..10fdfe362428b 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_v5.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_v5.c
@@ -187,8 +187,10 @@ int test_kvm_device(u32 gic_dev_type)
 
 	/* trial mode */
 	ret = __kvm_test_create_device(v.vm, gic_dev_type);
-	if (ret)
+	if (ret) {
+		kvm_vm_free(v.vm);
 		return ret;
+	}
 	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
 	ret = __kvm_create_device(v.vm, gic_dev_type);
-- 
2.39.5

