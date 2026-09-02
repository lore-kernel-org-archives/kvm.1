Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA7495515
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378439; cv=none; b=NPOde7Q3xn2s0P7ZvV0xlfQwmLZd3cSTgw6glhiSx/xFas9UuMUt/Uiu7qmZ9lM3btpR4m0SR3OiHtL/35YrC2CMfgMWYoBUOz+1OzoAMArF3pTNk7/PS8wjwPf4bM3nod792m/okhA2sZr+ax4TJ60k62QcwAqJwS1hI0l5gok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378439; c=relaxed/simple;
	bh=X0I+aFHOnDW1nXFeqe9LLIh2Xl92y2wIRvotCjhFCQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJWBONxjN3V+rwaWJi2blFqZX1GHluIeD8eOHGjDYpZvUliS9zJTamljsDgV9+bkzTlPRKALzENOv0860JCJT/9SVh4Mwf7m6fzjA1TlGjidPEjDi8XjIjoBmC8PM8AeAfR8NA+KZmyZw/9RPGymyeZtjxioxk5NOZDoXT9tu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rTcSqMBt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rTcSqMBt"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e85499ffbso142044085a.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378425; x=1788983225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBcqkxQZqwfVczJ4Zyf97FMnYegDKAQ3ju3Ot5Bn64M=;
        b=rTcSqMBtlRahGp1rVVVaUt/Vpi0CeT61OOyPS99c398F9fqbGdfv2lCtvkhOlLyUCF
         fWvKm8FzXO4VLEa6cjYLHztENQ7hDfD5lI8KlAMR0A5AtTnwGGHF/9le0tWkdywuKSbw
         MIQ1XbX3JnZInw7RsvsDYXSHZvY9uLDowG+fKQzQ746sOQwOCDTec0JNh8lOrlqaVEbq
         Gdq9g6+3yCRnm1rnrUTrSkvZNss5V2bZmgtnuMscmsESGo1neTVTyKralUjDNsnigIXM
         wYXMdmtZBIq/NpIa39K/2lZGqVfv5XXOJVurvsL/hRV2sUpRyq5BeJm1zd/vYd5XADZ7
         uebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378425; x=1788983225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CBcqkxQZqwfVczJ4Zyf97FMnYegDKAQ3ju3Ot5Bn64M=;
        b=q3zYkoc3lWpZuAoLPAGzWZ5v6qfWU34A1RXte9LjLixHO2nv/ymFWG+Pupgkl0KBa6
         ceHZ/ruBNLUUWw27q2VoyfPayGqOvxXgQtQqiLulaIy1U7BtT0fQXuUfjsX/cDSiToDb
         7qNBrgibpJ8ZiY9byt4GHZoC+Kr3blojQqByaIL5H42t3S3z8pf0ChkDG5aUqljFt9kp
         HaLOe7ukQFy5jc/wU7xbTX7vwazkYnW877kz80yVGuUV8TchPj/SAdyY6yvjZPe5+TWO
         OWQxUF/eA2sh79RPj5vcPazgRXhFgo1yK51hrpdvkJQr9t1Z2aUlL1v0dmmBqTAy3qwu
         oukA==
X-Gm-Message-State: AFuF++nfsAc7cDpEzLPuoKq52VKTI/eNMkDh629YHNh0lYj5P3vycNKX
	nJWz6XOh3Sul2dLV4ZpEyfGldVP+GVLHnNwoL9ru6mjYFhmGcVp5T0Digh6kvlKosIs=
X-Gm-Gg: AYBFou1jY5YLxS+C0Du4TMsEzxjllmDrvTQ6Q9if19NEVvsRsSgXTJY6F5jymZWXyBJ
	4QlVuX2ksfHl3h4e16i9pTUiU9mxarFmyYVNUFlZ8nsuonFK0wTEuEcAMGEg6qCTtZSyL9sUJid
	RVAFU5T0pKYObkF2sbpZExDTmRFoAhJFP9Ce6tsCqu4carhnNdtY0JqMq7m+MMlsGAjBvhyaeWC
	A8gtnUUfUuzD53R5RHdDYn339qsFMl2VF7OM4uecPptH0SgrrUYi49cDrFtWnRR5mCogg7jd+n1
	bs26TngsGLEe6yeY1dwiFe1pXqbXWwRpcDx0QY9HemgCYFu3YeuNO/QOEJ5h8buR8EHIP4M11RV
	MSkphURyBITvIHO/+z7jqUEFDL/9JfJChEHm0mw+FKqMqyhFa60l3+ReEVSZrc6fc+Iao+HorpA
	133Ptx0sBtlaR3ZOq6Qpqmhp4iMyWcgMiVMzk0sMDFxuqSfOjuaPAcC3v+WLWYI73Iqqt3cZqZT
	oky1gRnVHIjFVHofcZ023ktTrE+6rSb/ZfMdfjD+ughXmephNqnexi5HJZq
X-Received: by 2002:a05:620a:bd4:b0:939:3a8c:28f4 with SMTP id af79cd13be357-93960de25e9mr874489085a.10.1788378425144;
        Wed, 02 Sep 2026 12:47:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm299300585a.16.2026.09.02.12.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:47:04 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	shuah@kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 3/5] KVM: guest_memfd: bind backing memory to a NUMA node at creation
Date: Wed,  2 Sep 2026 15:46:55 -0400
Message-ID: <20260902194657.79075-4-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194657.79075-1-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guest_memfd presently allocates its page-cache folios through a
per-inode shared mempolicy (kvm_gmem_get_folio()).

Today that policy can only be set after the fact, via mbind() on
a host mmap of the fd. This requires the fd to be mmap-able and
cannot reach folios that are only ever guest-faulted (no host VMA).

Neither holds for a non-mappable (confidential) guest_memfd.

Add GUEST_MEMFD_FLAG_BIND_NODE.

When set, KVM builds an MPOL_BIND policy for the requested node and
installs it over the whole inode's shared policy, so every folio
is allocated on the requested node with no userspace mbind().

The flag is advertised through KVM_CAP_GUEST_MEMFD_FLAGS only when
CONFIG_NUMA is enabled.

Two user-visible behaviors worth noting:

- mempolicy_create() constrains the request against the calling task's
  cpuset. Requesting a node outside the cpuset mems_allowed results
  in the ioctl failing with -EINVAL. Binding is essentially subject
  to the same cpuset constraint as mbind().

  This behavior is correct - a task cannot grant a guest_memfd access
  to a node it cannot access itself.

- The policy hangs off the inode, and nothing rebinds an inode's
  shared policy on a later cpuset change.

    mpol_rebind_task() walks tsk->mempolicy
    mpol_rebind_mm() walks vma->vm_policy

  Neither walker reaches a struct shared_policy.

  The binding is therefore fixed for the life of the fd. That matches
  shmem, whose inode policy behaves the same way, and is the intent
  here: the node is a property of the guest's backing memory, not of
  whoever happens to hold the fd.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-8
---
 include/linux/kvm_host.h |  3 +++
 include/uapi/linux/kvm.h |  5 ++++-
 virt/kvm/guest_memfd.c   | 44 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6e..738e276633c1e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -739,6 +739,9 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
 		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
 
+	if (IS_ENABLED(CONFIG_NUMA))
+		flags |= GUEST_MEMFD_FLAG_BIND_NODE;
+
 	return flags;
 }
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ac2d77d149635..8d3ae7e2ead8e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1658,11 +1658,14 @@ struct kvm_memory_attributes {
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
+#define GUEST_MEMFD_FLAG_BIND_NODE	(1ULL << 2)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
-	__u64 reserved[6];
+	__u32 node;
+	__u32 pad;
+	__u64 reserved[5];
 };
 
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a0318..dc9f071dd969b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -423,6 +423,31 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
 	 */
 	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
 }
+
+static int kvm_gmem_bind_node(struct inode *inode, int node)
+{
+	struct mempolicy *pol;
+	nodemask_t nodes;
+	int err;
+
+	if ((unsigned int)node >= MAX_NUMNODES)
+		return -EINVAL;
+
+	init_nodemask_of_node(&nodes, node);
+	pol = mempolicy_create(MPOL_BIND, 0, &nodes);
+	if (IS_ERR(pol))
+		return PTR_ERR(pol);
+
+	err = mpol_set_shared_policy_range(&GMEM_I(inode)->policy, 0,
+					  MAX_LFS_FILESIZE >> PAGE_SHIFT, pol);
+	mpol_put(pol);
+	return err;
+}
+#else
+static int kvm_gmem_bind_node(struct inode *inode, int node)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_NUMA */
 
 static const struct vm_operations_struct kvm_gmem_vm_ops = {
@@ -520,7 +545,7 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags, int node)
 {
 	static const char *name = "[kvm-gmem]";
 	struct gmem_file *f;
@@ -561,6 +586,12 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 
 	GMEM_I(inode)->flags = flags;
 
+	if (flags & GUEST_MEMFD_FLAG_BIND_NODE) {
+		err = kvm_gmem_bind_node(inode, node);
+		if (err)
+			goto err_inode;
+	}
+
 	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
@@ -593,6 +624,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
 	u64 flags = args->flags;
+	int node = NUMA_NO_NODE;
 
 	if (flags & ~kvm_gmem_get_supported_flags(kvm))
 		return -EINVAL;
@@ -600,7 +632,15 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (size <= 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-	return __kvm_gmem_create(kvm, size, flags);
+	if (flags & GUEST_MEMFD_FLAG_BIND_NODE) {
+		if (args->pad || args->node >= MAX_NUMNODES)
+			return -EINVAL;
+		node = args->node;
+	} else if (args->node || args->pad) {
+		return -EINVAL;
+	}
+
+	return __kvm_gmem_create(kvm, size, flags, node);
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-- 
2.53.0-Meta

