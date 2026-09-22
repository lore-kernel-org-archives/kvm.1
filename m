Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF0493D57
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101778; cv=none; b=oW0H5d0mkoCOsHJMmqe36nCyhJJqtuKldEN6moxOmjNh5fYKt56gCIUHhV9UcZ94sYCv3TIXj1A5NuIgwUkCvfd2P+QNElYCYeeR7tpIYe3XqoIdodyYI5BAErTyYQ7YNHLRfdsy7fU6X+ZsqXHJ5Nb3eKyZ/K/3dYcZ0Zosf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101778; c=relaxed/simple;
	bh=cfR5Tc8cPyr7CMqES84GrCGAqHdjC/kTxRxFWGkznFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dx7fbF0/m3bw7N/kKmz7VWb4OcSY6rzwx+gVqRbzPyl79SSSQR+w6IWZcBh5qLZZ5BLhiPaIxVhC4p+HnDvKqBITNB18krqA+S5mdsQVL5CP7Xd9z13/VlJKdqbu4+DiwnpjPb/WCfBgV1fhK/Ft1Rq/tuexZ3wApYyDRu7nSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J329RoNU; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J329RoNU"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c1479so66838eec.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101776; x=1790706576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjvCz/V+hHRF2vZEcQUC+5VRgYkjP2X2UGtP/7PKl2I=;
        b=J329RoNUhlNqUwcTqGTnEoInBcX98DC/NEUJ6rTNn9SvAOFN2nCwc2fENz7F5wZvpL
         tI2ir6DuSG88KukyYTKf4G+5keu4Pg+ooFnzve8h1Sg0b8PxEM5QulEx0rd2PzTQVud3
         O2KsqLVxnxMHLKU+FfloV+Yy4EN2EB619ws96oNNCN/JV54/4zyMZJcqGHOghZOnnElR
         8WMG4f4cy6zO8oO8itOanyvz6gwYRW5AHXij4B42rU2oLsDB4Dzk/WRcM9brQFVA3X1h
         hU73wGDJxwuxpqt4HfattOXWwISVSn+dqUYCjW/wNJO7//OFz/c389AkcqH5x34sMzry
         981g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101776; x=1790706576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjvCz/V+hHRF2vZEcQUC+5VRgYkjP2X2UGtP/7PKl2I=;
        b=eMAMOHd6mfbkFxE2oxCfzFZ2h8p/eJS3T9s4gToFm/1/dGBGZVHG5PhPTgOq93a+5/
         TtKGtyKzWQYVik/cHJIlJ7D7kQVvW1ltYhSTqpGkHIgzLwG5m7lgz43fzJf4xga6V5EW
         mhlp5dS7n6zDZmr8DwMeJ4UQPtgLZR0S+rkL1zNrVe4EanyM7dK/At35+xEQc15dBWqM
         9nicBeDbEq7lLChNsYorbWroLH1llMEyQScJP30QmkG31zj1e+5la920tSKmTI7kP/nY
         3jC82vk4pmcjhG6cQK8Z8v/o/MdQHzp1d9Lt119qpBBAX2/c4b9fxUWGma1hAhvXTQru
         BvNw==
X-Gm-Message-State: AFuF++nKDnadtC3nqfTmNfhV9Px1dV/9BIuYnZ47DlWkqwAIW7ryTinQ
	5PUQjRtvTqD1LMFPAJAM9dfEFb1EghCtQlFLzDZCDjaBIzY2cs5LMjTnndApeg==
X-Gm-Gg: AYBFou04Jysj6Q2/BVN5k3e+ft4YjBBr2y6GesQCmhGG/xlLSptJWVemkyyEJjmox5v
	1rVG56C5xcrCqVCfIjkAz/5o8MheSQ7Jv1Kxyd3q+KyBj+QkwWJDJfe/LUwnPxyeyCK16rfXTqb
	pbretjzH4WTPJpPW+p00Z0obEQ7+lTZFyIDi/zIRoyKFF5RY9/2IORCl10HwaprOzrPzLCXq5Fk
	kqFhYZT75Icq9PNMe5vEp8+1TnApfpnuD52iVq62aPmbwN+CpcFz46vu8kPEj9mUH6UCwwYNZWZ
	KVl3LvdWD5l2y5K78UqGzXYdaZJnIdjb28tLT80Ue09rl5YLPviPo50KDN3wba+gANV5vo3uy16
	/OwWpc+DRoFNOFbscFt4fGTOpAnm3GBOKtMckQDfHuhFojk9CWMJ2ox0DQrtieT20cc4NSGQbmE
	+P8RNt7Z1uAhpUG49fBXKe6Cf40l48siiVZIsnFLuC6M5mEp5BDybLeRLtzL7Cxa3Ib7vkCnypv
	kEuSVw4daggCOE8aQSK4U3vGwgcjLLhcmanPaX+1vwQSilTaDJjLPyRE6wvVwXlbe7AJhWi0H6a
	t8liwg==
X-Received: by 2002:a05:7301:d597:b0:33c:1521:89aa with SMTP id 5a478bee46e88-33e8d2ebdafmr126981eec.24.1790101775482;
        Tue, 22 Sep 2026 11:29:35 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:34 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 4/9] KVM: selftests: Split out a KVM_CREATE_VCPU helper that can fail
Date: Tue, 22 Sep 2026 23:58:48 +0530
Message-Id: <ea46f5af08bec1e6c4c3124a6a02c785983519a0.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vm_vcpu_add() currently asserts on KVM_CREATE_VCPU, which is what most
callers want. But sometimes a test may want to handle ENOMEM without
dropping all that other setup that __vm_vcpu_add() has.

This patch adds a helper __vm_vcpu_try_add() for such test cases and
make __vm_vcpu_add() a wrapper around that.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 ++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 9df16c8dc82a..aa521b383abe 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -784,6 +784,7 @@ void vm_mem_region_set_flags(struct kvm_vm *vm, u32 slot, u32 flags);
 void vm_mem_region_reload(struct kvm_vm *vm, u32 slot);
 void vm_mem_region_move(struct kvm_vm *vm, u32 slot, u64 new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, u32 slot);
+struct kvm_vcpu *__vm_vcpu_try_add(struct kvm_vm *vm, u32 vcpu_id);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id);
 void vm_populate_gva_bitmap(struct kvm_vm *vm);
 gva_t vm_unused_gva_gap(struct kvm_vm *vm, size_t sz, gva_t min_gva);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2be79c240ebf..7084ed90e4cc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1367,11 +1367,7 @@ static bool vcpu_exists(struct kvm_vm *vm, u32 vcpu_id)
 	return false;
 }
 
-/*
- * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
- * No additional vCPU setup is done.  Returns the vCPU.
- */
-struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+struct kvm_vcpu *__vm_vcpu_try_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	struct kvm_vcpu *vcpu;
 
@@ -1385,7 +1381,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
-	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
+	if (vcpu->fd < 0) {
+		int __errno = errno;
+
+		free(vcpu);
+		errno = __errno;
+		return NULL;
+	}
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
 		"smaller than expected, vcpu_mmap_sz: %zi expected_min: %zi",
@@ -1404,6 +1406,18 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	return vcpu;
 }
 
+/*
+ * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
+ * No additional vCPU setup is done.  Returns the vCPU.
+ */
+struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+{
+	struct kvm_vcpu *vcpu = __vm_vcpu_try_add(vm, vcpu_id);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(vcpu, KVM_CREATE_VCPU, -1, vm);
+	return vcpu;
+}
+
 /*
  * Within the VM specified by @vm, locates the lowest starting guest virtual
  * address >= @min_gva, that has at least @sz unallocated bytes.  A
-- 
2.39.5

