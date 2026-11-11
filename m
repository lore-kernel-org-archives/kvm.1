Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409102;
	b=JjXZE9TjwprZx6lQcKAbuGLrsb2nG8UvJZbxNGzJ9WQ4PKDoDkrncJL6DIkNQQQ1XE/T
	 rxN9xFLm4y8jc5DMKA2O8m4CIP9bgb0RHS8zBRKkLdzMfC2VMZuZqVFhseY6VVr8JfO3V
	 e/jrvnlYsJtre+gQlxzngVBCc4qGcVDSt73d5IAM8fynpIqQNUDKV5N2WkrNxaymVTWhs
	 6m+yNpunzBKMppJtJX68Ofq304tNISOa4l60LfF7x0msQ0+qKwEAigUg0YLxHn1S6wMVK
	 XTc0TIwFc1utKQ89J8rjodnR9pGES9wasago/qLsmaiS5NkVduabdsfEeQtrfBznqeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409102;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Ka4B54p4sbNSrKWCL5vmxStgm56wKqIdQXQP7NpVRo=;
	b=u2FOFaeRZ+/Y3pPBdF4WMAZqR0xVl17lRD/XwdtO07uFRLCZ14GgZzKjQHS1SOK+Ty6F
	 pfSs3/s6flLnI1P4WawVVRDx+5YU7AHg2/sgjMoDzuTv0eboNNWZM/iCaT0gb1kCptv9r
	 mJny9SlX8k9ljOoDEManYDFIft2A8Xd8AWsGYKjsDkf40LoczdVjP0Lc6Uuf0ymD3VckA
	 XvBhai5iT3ZxbfnxK14m3akPnX3UmLEGIre0Ry/MjlHyeYknXPJ1JY85Qo5jVg5tivtcG
	 +hpBQ+eotarjbIftNik4BZOtq8LRAGG+d+NNJU8ws+XGOT+rYaBibXevS9xn5TGdcvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="X3e0Wc1/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136B606A332;
	Wed, 11 Nov 2026 14:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D136B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X3e0Wc1/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4451576;
	Wed, 11 Nov 2026 06:58:18 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15E543F632;
	Wed, 11 Nov 2026 06:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794409101; bh=NjxaS8I7MBNoFlMkwcao+kYJE29WlG8theUiJeEC/vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3e0Wc1/bN5bK9Ydsdu6zV09TsnIebWg/y9m0yQFn3yRev5oCDqWrAmOpJ6HKTQSC
	 k8rj8D0X02zItqh4PirYbFj9NweU0t+5nvq2tL2tUMQbEWfnaNHvzLfNu+rm6XtPfc
	 cGk64C6WI0FBVFg4aJuvdty3QPE5KKaTdwThiEJg=
From: Steven Price <steven.price@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>,
	linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>,
	WeiLin.Chang@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>
Subject: [PATCH v2 02/12] KVM: arm64: guest_memfd: Check mmap support when preparing memslot
Date: Wed, 11 Nov 2026 14:57:46 +0000
Message-ID: <20261111145758.217946-3-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111145758.217946-1-steven.price@arm.com>
References: <20261111145758.217946-1-steven.price@arm.com>
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

Check the guest_memfd backing file when deciding whether an arm64
memslot has mappable memory rather than checking whether the slot is
gmem only. A public helper function is added to be able to reuse the
static kvm_gmem_supports_mmap() function.

Signed-off-by: Steven Price <steven.price@arm.com>

---
Changes since v1:
- New patch in v2. Check the guest_memfd backing file rather than the
  memslot flag when deciding whether arm64 can map the backing memory.
---
 arch/arm64/kvm/mmu.c     | 7 ++++---
 include/linux/kvm_host.h | 1 +
 virt/kvm/guest_memfd.c   | 6 ++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1db10d8d6db7..a146f6cde3d0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2839,10 +2839,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		return -EFAULT;
 
 	/*
-	 * Only support guest_memfd backed memslots with mappable memory, since
-	 * there aren't any CoCo VMs that support only private memory on arm64.
+	 * Protected VMs currently require guest_memfd backed memslots with
+	 * mappable memory to support shared mappings.
 	 */
-	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
+	if (kvm_arch_has_private_mem(kvm) && kvm_slot_has_gmem(new) &&
+	    !kvm_gmem_slot_supports_mmap(new))
 		return -EINVAL;
 
 	/* guest_memfd is incompatible with MTE. */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..f65728a713ec 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2614,6 +2614,7 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
+bool kvm_gmem_slot_supports_mmap(const struct kvm_memory_slot *slot);
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
 
 static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8c97a69b16dc..3dd8d227bebb 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -442,6 +442,12 @@ static bool kvm_gmem_supports_mmap(struct inode *inode)
 	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
 }
 
+bool kvm_gmem_slot_supports_mmap(const struct kvm_memory_slot *slot)
+{
+	/* The guest_memfd file is pinned while preparing a new memslot. */
+	return kvm_gmem_supports_mmap(file_inode(slot->gmem.file));
+}
+
 static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-- 
2.43.0

