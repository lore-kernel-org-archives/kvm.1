Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865376;
	b=hCF3oyJdhin3NQg8wDOIY9cCI09U3loRqlkGzgTs7YwxXGLv2AXYohAZhkpLe3VIxLFE
	 VJmpqwySrKjyHpFLluI2QfiIDstEcsUF5lYWU4p+3te633kl5ptX1OcWY8jOe2zWbS/8c
	 6437amAxdDUQB4yyu/qEKWDWt/jaZUEqNrkiQVKAsQz5vv88mKzIBAinJAT+3vl0KUlt8
	 6EpzKdEFUYJdxkgn2el9WmYDp3vBVo7Heh25NztGst7S/OpC5qS/6Tr84T5r/huTk4pgF
	 qmceKVTYay71tE+AsPwfzf8e4ud4+0TrQ+lPrWemqanbxomow3J7VQuzQQlZP/9yrlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865376;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tr8NkJMHl3FHlQcbzwhDnYMo8FYHNDVW44KQY09vbOs=;
	b=GivC8Yp0YfXJq8lrhKFoE+AJCZ0nz65hPVCFbqdPSLUEuAivJGHZ1zP/7W5zgibT5QPk
	 oaFqTh93ivUKYKpimGhpeJ51RYw3AEuV6BByKUfdl7Z6jIgrZrVgAlIH4VrBz9iEyPz+i
	 2xyJejjQgp9H9rhi81t5mveY69R7rE135rmnW9PEnxUAOwgq2PxGbeNf98SEIonrqgjNz
	 ai+0291Ckcqe8YAvI9K6lVp/k3WEQJU8DEw95dQmJ7xF7L84o/mN/JitY30xu9mqsTQI/
	 RpFL86ubh2iz/u4O7qF+dRcGOqgXs6/x8Odk9Xih2Y44hzdfHjOMKU1hO3p8tiedJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qE+S37o+;
	arc=none smtp.remote-ip=95.215.58.129
Received: from mta1.migadu.com (out-129.mta1.migadu.com [95.215.58.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF0606A334
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 07:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47DF0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qE+S37o+
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NufnUWPoeGRDltZSqqytUAf9Oe1HKZ1J1ChJkjlHQ68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793865372; v=1; x=1794470172;
 b=qE+S37o+Msp/zZhIA4Bb/q5Ng+r9nVyAXNl+njlYlfoSYJrWMRglD1RoYHcILTA/195rBZqi
 n6up0Xisgq9OBp8yThEG0d/u7qJF3beICgrksYLt5TdCjhyCgISRL1acd7oFjzhGh1Y+nKJt9pV
 o0RN2zNX0trx/b92v7eUg8KI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cccae0cd339b3153;
	Thu, 05 Nov 2026 07:56:12 +0000
X-Mizu-Trace-ID: cccae0cd339b3153
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Martijn Bogaard <martijnbogaard@google.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] KVM: arm64: Check PGD alignment when creating a pVM
Date: Thu,  5 Nov 2026 07:56:04 +0000
Message-ID: <20261105075606.367005-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105075606.367005-1-fuad.tabba@linux.dev>
References: <20261105075606.367005-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quentin Perret <qperret@google.com>

Martijn reported a hypervisor crash when providing pKVM with an
undersized PGD allocation. Indeed, although the size of the PGD
allocation at EL2 is not under host control, a smaller host-side
allocation can lead to providing pKVM with a misaligned PGD, which will
cause the guest stage-2 init to fail in a bad way. Specifically,
guest_s2_zalloc_pages_exact() expects a successful allocation from
hyp_alloc_pages(), which can only happen if the pool has been pre-filled
with a physically aligned high-order page.

In order to guarantee allocation success in this path, check the
host-provided PGD alignment early on.

Fixes: 60dfe093ec13 ("KVM: arm64: Instantiate guest stage-2 page-tables at EL2")
Reported-by: Martijn Bogaard <martijnbogaard@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
[Fuad: Returned -EINVAL and moved the check ahead of hyp_alloc(), with
 the other input checks in __pkvm_init_vm(). Cast pgd_hva for its __kern
 type, updated the comment, and pointed Fixes: at the commit that
 initialises the guest's pool from the PGD.]
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c        | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d4c332a918035..5b624b1ab32e8 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -186,7 +186,7 @@ static void *guest_s2_zalloc_pages_exact(size_t size)
 {
 	void *addr = hyp_alloc_pages(&current_vm->pool, get_order(size));
 
-	WARN_ON(size != (PAGE_SIZE << get_order(size)));
+	WARN_ON(!addr || size != (PAGE_SIZE << get_order(size)));
 	hyp_split_page(hyp_virt_to_page(addr));
 
 	return addr;
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index fc0475f0877d1..03e530e15b4a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -892,8 +892,8 @@ void teardown_selftest_vm(void)
  *
  * host_kvm: A pointer to the host's struct kvm.
  * pgd_hva: The host va of the area being donated for the stage-2 PGD for
- *	    the VM. Must be page aligned. Its size is implied by the VM's
- *	    VTCR.
+ *	    the VM. Must be aligned to its size, which is implied by the
+ *	    VM's VTCR.
  *
  * Return 0 success, negative error code on failure.
  */
@@ -924,6 +924,10 @@ int __pkvm_init_vm(struct kvm *host_kvm, void __kern *pgd_hva)
 
 	vm_size = pkvm_get_hyp_vm_size(nr_vcpus);
 	pgd_size = kvm_pgtable_stage2_pgd_size(host_mmu.arch.mmu.vtcr);
+	if (!IS_ALIGNED((unsigned long)pgd_hva, pgd_size)) {
+		ret = -EINVAL;
+		goto err_unpin_kvm;
+	}
 
 	hyp_vm = hyp_alloc(vm_size);
 	if (!hyp_vm) {
-- 
2.47.3

