Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016700;
	b=BPSNJ6wLHhrDJrDTU2UM2RSJnxWc6uPd+0ckl4DUC7bnw7Mwelci6fVdLjRfJGOo4yds
	 owfmP0QPyrLaRDmYjyF54S41sJaZCufl5gqj8og8CbQOGOIfNoWmOFmUYcpiPT9ZUWiQM
	 NUdk+ouYlZNJHXJXEJ1LIJCyDBPDAtqRZ1ua5CUkeVVnduPVqfSCu4tAMvW2CdH5rFDyP
	 0C/CPKWizgrk0brZBAc8O9Nw6y+xRNvrdzB3iDH7OycGA+BuNI5zp/zzTQlwtCMNF0lBO
	 /34TgnIDvUvJxh1DVChUp5eYBfeq3vEpQ0oxsPhfqM+P/Qo6EY7OFHQobOHwgIzsa7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016700;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=qxpyj/UOl4zhAq0TdYWCYDtm8oNM24au5RWj8yaQrOc=;
	b=QULuAARdP9Yh85rsIEJxoBzOOxgFSqQXxqpWyP9i6pNhYS9QNNPii/6YFR5Pc4Vzrj6b
	 K70ldKYEKMMu+KVXUJpiL6zfl6oJOUwfbgMBDnSgUgSkpdMtr+3X8i6ceVBih/4kDJSW6
	 hP6D+nOlcWtDijVykd4qEFZce8djKK9CKdENaC88k9Oxc7IenRq7UhTX9pZ02xv+aONle
	 Dd9xdE31KrsQ/6zocSoMhaub9V218DIshLOLvPwp4llOEWR+87LHBc/aDkfJtHAfmygAg
	 uqjCLHP3k9wva2RgPppiTttDvSLsoCgBGDz2ZpNEKYEovdxCrqYf7b46r4NRN0SeDUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DynUJRMD;
	arc=none smtp.remote-ip=91.218.175.210
Received: from mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D472606A32F
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D472606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DynUJRMD
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rwvT+PKBDk6ZkkgKXEgIt+qum9rc4hzPVxm9qDPG2hA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795016697; v=1; x=1795621497;
 b=DynUJRMDgxipLuO3zCabfInslAA+/hv+MKt0e9yoQy3wkMUndfBYdgOkpVUbUwmqWDzTwNQ8
 +MtmXqtqwhObV/lm2lmW4ksigXQJwDKd+vY/b28OHMlz/MztXIeitsz/vwDlqV5CprYYW+ODakw
 xqXtA96mUNezocEAgbYKMr94=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 49611e44865ca4be;
	Wed, 18 Nov 2026 15:44:57 +0000
X-Mizu-Trace-ID: 49611e44865ca4be
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 18 Nov 2026 10:44:51 -0500
Subject: [PATCH] KVM: x86/mmu: Wait for freed TDP MMU pages only before
 destroying caches
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-feat-kvm-tdp-mmu-rcu-barrier-v1-1-24106947c616@linux.dev>
X-B4-Tracking: v=1; b=H4sIAPLH/WoC/x3MQQqAIBAAwK/EnlvQIIu+Eh3UtlrCijUjiP6ed
 JzLPBBJmCJ0xQNCF0fetwxdFuAXu82EPGZDpSqjtW5xInviegU8xwNDSCg+obOSF0HXOFNboxQ
 ZD7k4hCa+/74f3vcDp/oxD24AAAA=
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

The TDP MMU frees page table pages from RCU callbacks, so that lockless
walkers never see a freed table. kvm_mmu_uninit_tdp_mmu() ends with
rcu_barrier(), which commit 7cca2d0b7e7d ("KVM: x86/mmu: Protect TDP MMU
page table memory with RCU") added so that these callbacks run before
the VM is torn down.

The callbacks only free the page table page and return its kvm_mmu_page
to mmu_page_header_cache; they do not touch the VM. Still, destroying
any VM waits for the RCU callbacks pending on every CPU, which accounts
for most of the time it takes to destroy a small VM and limits how fast
sandboxes that run one short-lived VM per task can be recycled.

Move the barrier to mmu_destroy_caches(), the only place that needs the
callbacks to have run, before mmu_page_header_cache is destroyed.

Each thread creates VMs with a 1 MiB memslot and one vCPU that touches
eight guest pages, and destroys them by closing the vCPU and VM fds; 400
VMs per run in a 32 vCPU guest with nested KVM on AMD, median of five
runs:

             destroy time per VM             VMs per second
  threads   before (ms)  after (ms)  change   before    after   change
        1         11.9        0.76     -94%       61      509    +734%
        4         15.5        0.61     -96%      197     1105    +461%
       16         23.6        2.87     -88%      429      968    +126%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 arch/x86/kvm/mmu/mmu.c     | 5 +++++
 arch/x86/kvm/mmu/tdp_mmu.c | 7 -------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f89e9f8a6cc2f..eec12168abc13 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7769,6 +7769,11 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 
 static void mmu_destroy_caches(void)
 {
+	/*
+	 * Let the RCU callbacks that free TDP MMU pages of destroyed VMs
+	 * return their headers to mmu_page_header_cache before destroying it.
+	 */
+	rcu_barrier();
 	kmem_cache_destroy(pte_list_desc_cache);
 	pte_list_desc_cache = NULL;
 	kmem_cache_destroy(mmu_page_header_cache);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad19..7bfb84a1a2ff1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -44,13 +44,6 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
 #endif
 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
-
-	/*
-	 * Ensure that all the outstanding RCU callbacks to free shadow pages
-	 * can run before the VM is torn down.  Putting the last reference to
-	 * zapped roots will create new callbacks.
-	 */
-	rcu_barrier();
 }
 
 static void __tdp_mmu_free_sp(struct kvm_mmu_page *sp)

---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: 20261118-feat-kvm-tdp-mmu-rcu-barrier-b7b65a600e6c

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

