Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C98485CE6
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933208; cv=none; b=eLHsotXSzmwGpzpcknbjJ+wKEloav8G9WtF1Wyssk1MNG1ZViOID0N7DrsZHpcBGsIK5dBpM0ycdYX7u9cVP8uez26EcQuU5RHkjP0ORI3HhprFs1PpJaCR/Fz/YGh6hx2yJQspDFl0CfMgsPwx4ceUiTaWGtmELSdkTYZWYWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933208; c=relaxed/simple;
	bh=8XX+vhh2r6nDjCyL0q7Hw9+dII/UGrET28Tgyv/hoY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBo5EXkPKlNHIRTI31CiWvOiu6wxobHh0fYSkD/FH7QAQO332nAEajVAfh1i4ejQrTvbKkGCRMxjiUsLZRT+gZ+GYHzIuDb36G852Z+EjWUUl8BizsjKUCgGBiDaXkZcImIIsw9/IkUqx/KHWanX5XYVFqfeG2obczcW2BQIVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XlaUSD9T; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XlaUSD9T"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43db0c29so15951217b3.2
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933205; x=1790538005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+xCjTdloxc6nkdYmhJBIoS65cvexU8uxkyprCbgscSQ=;
        b=XlaUSD9T4SWyS9Xu5j8fW59+JCN5Mx0q/4fIj2ymPohFNap6/2IMexA75h8evXGtk+
         WQuJG5jPUwBr+9uWwGRr03+8JOAc8QMcq0AQkW2eYf+svJOviXIrC1biszMu4EPwlOYy
         3DcxZTe/jBh1dT1t/RR4PyJ4VOdcN++Y1NpTA0jw0ucp/WvA+zbnH4v1fFKSNxcRFjUP
         6vLkrrVyMbZT07/OaEdqyJRcaN1Aw3frEQwM5fl+K1Q+oLqNZ1g4R1OD6S7R1JEfUEHl
         ifeX8ueN2ggB9b+aKwNfJURL6E/j8tsB5oMtf57PuylXIoqsBY0WFEfgNt0NT5SNKOQr
         Ujdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933205; x=1790538005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+xCjTdloxc6nkdYmhJBIoS65cvexU8uxkyprCbgscSQ=;
        b=cRRWbyMDut+uuEwKQfrUVfjCbCN4SXxlemnJgFsEwGAlXs3q+dmLgHr+ey6kbQf/SV
         o3Zwbk7pGgHE0Tb/KsAYLJSjyolT2fc2+4lKUOK4rJt8rlYeXyY6n/5kwydJrojCScHE
         9sijZ+LDX0m02T+iK2DqSLrCC9Zr56hfi7bBPUfScYsW1/4sTx4Lb8Yk13WcB70HGbTz
         6Uf4ZqzhOWz3vTShL7rpPYqnhJ6cLYsTIJobeNo+ayjiIl1BeaAldqoDz5wDO1T4QGqR
         8TU3KuZykgqjU6y9dwfKEA+0hQPSWpT+5n0Q5b/ZIg6M8+U32JlVGmv0MDAxPf7or50V
         KI4w==
X-Forwarded-Encrypted: i=1; AKwUvBxuYbsfXYgVLlllxPnkL4Epp1y7Y0y5n5Xr/3c4hlN7uVzyrgNk4P3hGb+WRBabWZpbP94=@vger.kernel.org
X-Gm-Message-State: AFuF++ltQVou7F1orO1XtnDekpaupTqN63l81P5bUBfORCC3rbstjTDz
	Y7RV15K5EJ3j52lCQm+4pd+49xzRFSp+QLdQQ0uHYoO7+JJ6Ffeoe9w9y4poRApDsBc=
X-Gm-Gg: AYBFou3sihBAfa+VuuwdLy/z8KgYnU1pnMnaPNMs+c1VqiHV2e7QEIAZHoQ5KsYGb6k
	J1b9lAlqu06YPGaI0wRxfKhsOAnaX3+OySExbb3VLGonUWc+P6KxZwcUVWxdGQxFJ9Wm2+C15w7
	VTPQHtCNNeHYI34PUUt2HB6mHz9Ol6X1+4FSdyk4mAYvK+4FpzVklALmq/Pq86UZBF8ntsdxbwR
	v9F+dkeTslvV0t9/RD+fjWWiSvNDNrylOtduvUyDa8RE/l96775wBIhg4BtPNzgwFcknuS7cYHU
	6yccehlVDlPuMn+725Pi6I0yHRf6kumk5J8ryx3phTYF1ldHXe/yVw/KNjnp9Uxfn8fV0C5YZ3t
	FO6Q4QwNlA1RBkET2I882uubvSfnXV241bpagVlGCvtvHLwU0OXycZX90El8nxGeg5Z0xkLm7bn
	NPFKd3a/QuLVyejvn9x6Amay4SIREeAVbjpZJ7dSn9GSe5ZEYOdUl6loWbXWxPJT/WrIcrWkIWs
	shyClCthYyPW45+NO5kso5F8UwqNfjiw28BxpoPWVYnahNZbNFZubS0SQHOLRBicNxNXhUJ9yWi
	Kv44KFGlDVSHtHnw0dQ=
X-Received: by 2002:a05:690c:d8b:b0:873:5c6b:a2ff with SMTP id 00721157ae682-89736f266a6mr23324237b3.45.1789933204717;
        Sun, 20 Sep 2026 12:40:04 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a45d8de3fsm18926787b3.8.2026.09.20.12.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:40:04 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 32/46] KVM: x86: Add TDP MMU KHO preservation helpers
Date: Sun, 20 Sep 2026 15:36:36 -0400
Message-ID: <20260920193650.3373435-33-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arch/x86/kvm/mmu/kho.c to preserve and adopt TDP MMU EPT/NPT
root page tables across Kexec Handover (KHO) live updates.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kvm/mmu.h     |   7 ++
 arch/x86/kvm/mmu/kho.c | 193 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 arch/x86/kvm/mmu/kho.c

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..f35948f0906c 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -410,4 +410,11 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn & kvm_gfn_direct_bits(kvm);
 }
+
+/*
+ * Declared here rather than in asm/kvm_host.h: it is internal to
+ * arch/x86/kvm and has no callers outside it.  Defined in mmu/kho.c.
+ */
+int kvm_mmu_preserve_kho(struct kvm *kvm);
+
 #endif
diff --git a/arch/x86/kvm/mmu/kho.c b/arch/x86/kvm/mmu/kho.c
new file mode 100644
index 000000000000..a04600f0c3e0
--- /dev/null
+++ b/arch/x86/kvm/mmu/kho.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * KHO preservation of the x86 KVM MMU page tables.
+ *
+ * An orphaned vCPU keeps running its guest out of the shadow/TDP page tables
+ * while the VM is detached, so every page those tables are built from has to
+ * survive the kexec.
+ */
+
+#include <linux/kexec_handover.h>
+#include <linux/kvm_host.h>
+
+#include "mmu.h"
+#include "mmu_internal.h"
+#include "spte.h"
+#include "tdp_iter.h"
+#include "tdp_mmu.h"
+
+/*
+ * Page-pointer accumulator.
+ *
+ * kho_preserve_pages() cannot be called while holding kvm->mmu_lock: it is a
+ * rwlock_t, so the section is atomic, whereas kho_radix_add_key() below it
+ * calls might_sleep(), takes a mutex and allocates with GFP_KERNEL.  So the
+ * walk runs in two phases -- collect the pages under the lock, preserve them
+ * after dropping it.
+ *
+ * A NULL @pages simply counts, which is how the caller sizes the array.
+ */
+struct kvm_mmu_kho_pages {
+	struct page **pages;
+	unsigned long nr;
+	unsigned long capacity;
+	bool overflow;
+};
+
+static void kvm_mmu_kho_add(struct kvm_mmu_kho_pages *acc, struct page *page)
+{
+	if (!acc->pages) {
+		acc->nr++;
+		return;
+	}
+
+	if (acc->nr >= acc->capacity) {
+		acc->overflow = true;
+		return;
+	}
+
+	acc->pages[acc->nr++] = page;
+}
+
+static void kvm_tdp_mmu_collect(struct kvm *kvm,
+				struct kvm_mmu_kho_pages *acc)
+{
+	gfn_t end = kvm_mmu_max_gfn() + 1;
+	struct kvm_mmu_page *root;
+	struct tdp_iter iter;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(root, &kvm->arch.tdp_mmu_roots, link) {
+		if (root->spt)
+			kvm_mmu_kho_add(acc, virt_to_page(root->spt));
+
+		for_each_tdp_pte(iter, kvm, root, 0, end) {
+			struct page *page;
+
+			if (!is_shadow_present_pte(iter.old_spte) ||
+			    is_last_spte(iter.old_spte, iter.level))
+				continue;
+
+			page = pfn_to_page(spte_to_pfn(iter.old_spte));
+			kvm_mmu_kho_add(acc, page);
+		}
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * The per-vCPU root page tables are not linked into active_mmu_pages, so they
+ * have to be walked separately.  pae_root, pml4_root and pml5_root are each
+ * NULL unless the corresponding paging mode is in use.
+ */
+static void kvm_mmu_collect_roots(struct kvm_mmu *mmu,
+				  struct kvm_mmu_kho_pages *acc)
+{
+	void *const roots[] = { mmu->pae_root, mmu->pml4_root, mmu->pml5_root };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(roots); i++) {
+		if (roots[i])
+			kvm_mmu_kho_add(acc, virt_to_page(roots[i]));
+	}
+}
+
+/* Collect every page backing this VM's MMU.  Must be called under mmu_lock. */
+static void kvm_mmu_collect_all(struct kvm *kvm,
+				struct kvm_mmu_kho_pages *acc)
+{
+	struct kvm_mmu_page *sp;
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	acc->nr = 0;
+	acc->overflow = false;
+
+	if (tdp_mmu_enabled)
+		kvm_tdp_mmu_collect(kvm, acc);
+
+	list_for_each_entry(sp, &kvm->arch.active_mmu_pages, link) {
+		if (sp->spt)
+			kvm_mmu_kho_add(acc, virt_to_page(sp->spt));
+	}
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (vcpu->arch.mmu)
+			kvm_mmu_collect_roots(vcpu->arch.mmu, acc);
+		kvm_mmu_collect_roots(&vcpu->arch.guest_mmu, acc);
+	}
+}
+
+int kvm_mmu_preserve_kho(struct kvm *kvm)
+{
+	struct kvm_mmu_kho_pages acc = {};
+	struct kvm_kho_folios_ser *kp;
+	unsigned long i;
+	int ret = 0;
+	int attempt;
+
+	/*
+	 * Size the array, then fill it.  The guest can fault in new page
+	 * tables between the two passes, so re-check for overflow and retry
+	 * with a larger array; the slack makes repeated growth unlikely.
+	 */
+	for (attempt = 0; attempt < 5; attempt++) {
+		write_lock(&kvm->mmu_lock);
+		kvm_mmu_collect_all(kvm, &acc);
+		write_unlock(&kvm->mmu_lock);
+
+		if (acc.pages && !acc.overflow)
+			break;
+
+		acc.capacity = acc.nr + (acc.nr >> 2) + 16;
+		kvfree(acc.pages);
+		acc.pages = kvmalloc_array(acc.capacity, sizeof(*acc.pages),
+					   GFP_KERNEL);
+		if (!acc.pages)
+			return -ENOMEM;
+	}
+
+	if (acc.overflow) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	if (!acc.nr)
+		goto out;
+
+	kp = kvm_kho_folios_alloc(acc.nr);
+	if (IS_ERR(kp)) {
+		ret = PTR_ERR(kp);
+		goto out;
+	}
+
+	for (i = 0; i < acc.nr; i++) {
+		ret = kho_preserve_folio(page_folio(acc.pages[i]));
+		if (ret) {
+			/*
+			 * Undo the partial preservation: leaving pages marked
+			 * would pin them in the incoming kernel forever with
+			 * nothing owning them.
+			 */
+			while (i--)
+				kho_unpreserve_folio(page_folio(acc.pages[i]));
+			kho_unpreserve_free(kp);
+			goto out;
+		}
+		kp->folios_pa[i] = page_to_phys(acc.pages[i]);
+	}
+
+	kp->nr_folios = acc.nr;
+	kvm->kho_folios = kp;
+
+out:
+	kvfree(acc.pages);
+	return ret;
+}
-- 
2.55.0.1082.g2b9226bbc0-goog

