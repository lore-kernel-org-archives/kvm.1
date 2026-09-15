Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD4496D48
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461893; cv=none; b=sfg4pkUy1uyEB0fQD3oHwmFFnefMJf95SPXCWEQjwk9XNxegSu6z6AIyqdKNT8ycDADkpO3n2lkTertr84fL8L57PhNTn6M/EjE5ctK9PdLNbVnlEBazOMSMn4k1h7EeSI7vW+5qLvjpKWllezVxROnKZaxGvoMINQ9DdW57UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461893; c=relaxed/simple;
	bh=cfJHLD9q9zHmMljo9vPmqqbTUt1+su2cEdMIw8eDGo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeOrnH1YCNWqSGZJ2PUilwKls8KPjUCJmY9Ksb7yfRuJ8UdbFRKQZuP0/ZgdZermfbIVwOooShW9c13bmjvOI5B2XdbRfjeNVy0QrvRbjtbiBGYSY0A7PZgP8fE5NDkDsgjMFdWN/Dkg8YjIYQyxt2J3v1+eggxPncPmrDrhPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wWIoWV5c; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wWIoWV5c"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cfJHLD9q9zHmMljo9vPmqqbTUt1+su2cEdMIw8eDGo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789461887; v=1; x=1790066687;
 b=wWIoWV5cpeF748EZKF4qUjmySh+AeOazXhk3ZpzY9g4wi78jsEF6B7/+HQb3FJKrpDn30guD
 Jbh65kcGcmxMcaRUxAxNVQUNgX09uNekzmWpiofDl1xfyETXnYybGmTVNM500yHhsrX6RnhjhcD
 9J2Bcb3uhcqMz7YIJAgT33SI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 53447c2444ce877a;
	Tue, 15 Sep 2026 08:44:46 +0000
X-Mizu-Trace-ID: 53447c2444ce877a
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: Fix comments that refer to the non-existent VCPU_RUN ioctl
Date: Tue, 15 Sep 2026 09:44:39 +0100
Message-Id: <20260915084441.3846947-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260915084441.3846947-1-fuad.tabba@linux.dev>
References: <20260915084441.3846947-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neither the VCPU_RUN in kvm_main.c nor the VCPU RUN in kvm_host.h names
an ioctl that exists. The one that enters the guest is KVM_RUN, so refer
to it by that name.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6e..acae5a61e7f8f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -562,7 +562,7 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 	/*
 	 * The memory barrier ensures a previous write to vcpu->requests cannot
 	 * be reordered with the read of vcpu->mode.  It pairs with the general
-	 * memory barrier following the write of vcpu->mode in VCPU RUN.
+	 * memory barrier following the write of vcpu->mode in KVM_RUN.
 	 */
 	smp_mb__before_atomic();
 	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d8..cc391b0666a6d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -470,7 +470,7 @@ static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 
 	/*
-	 * No need for rcu_read_lock as VCPU_RUN is the only place that changes
+	 * No need for rcu_read_lock as KVM_RUN is the only place that changes
 	 * the vcpu->pid pointer, and at destruction time all file descriptors
 	 * are already gone.
 	 */
-- 
2.39.5

