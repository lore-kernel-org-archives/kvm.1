Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711675;
	b=2Av4jQ13B2P/TkLsSpklTVWnkhP4Wh5xhfZqKlBLtxDixOy+4F9Cm2qhlvNPxaxK4YYU
	 n3kLl29l01am9dse8xssOSB1H66MgEzElVaaUnrYyPjoOECu/eqyWfKWfmy3YShnH7QzQ
	 t6KYcgxbc89twU1Tc1Bgj/+B41kgWQuqK4hkVbeG3q+uhAesqX6ga0A67auAWe3nBeTxV
	 oijVBZsaaQ0Pihic/A2WErnwBvkgF27jcecKiltUkAwtDWA+DCWa+nIhBL0SHRsSfGzmk
	 61LwH2O0o0gQrFsA410GrqJeyhW6QU5AxTINVSm4zpw5jyFG2mOfKla4+MrT2PVsxGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711675;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=saSMbo648UHf2poSBhN3PUEeM9QS1/S8od9Ydjr4vT8=;
	b=ty7vtuPMn8aGOb+Qx8+K5TmoxJ9CMGMyAmLKT/auHQMOhCt3ge/tLopBwqhSxWPUI3qP
	 LYYv5HDBp826pJZ3YGeBuztErFHmkUfclFQG/uHKjqtcfvz6xvmuaX3WhrO1MwG3VtJzV
	 fia0lLWh8c+JbvtZ2Bx/Pitksvk3PRdtB3/X006hfeumVf+XFR7gZMtqUN66O06u7gLnG
	 RfttaABwG3J5GpLqSFYOMJDIbbThrmjYs7p21L5UTth0QX63+yrG367vn8SjJmmNC7UiX
	 emHvUXblGx+XYllyj/54C5MubMFpcfv4lN6rRFJ3kcIJZN6dFMXqofVqIseWE5Kt/gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O5V5sv/K";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B5606A332;
	Thu, 22 Oct 2026 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5V5sv/K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711674;
	b=Xh7BaAVcrVpeCGnVhcM6M9neSG0doDZWeop/eQkdK6lkMYDQ9ynUxabwsxn/gCrrXfiw
	 yXCiuQ3dyvjVvT2cxicBI8XZsjnZod1ckMqjZ8qVrvOL8wIXneZQPff2Z+1ypeNdi+mnH
	 RXHdjsQIY1Jfbz9USfwyivyf/ZGn4sX982e2tfhSXAInAjT+aqwKKzMszokIBQybNUyZe
	 yIRNJrc+L8DIOLUZvMMIJbx5HVHBSXaRV2x46W7puMF2jKPD3gLGMXM35AMjT9+E74uq3
	 3tUjT2bUR7Qqd/rGGer1EmSNrOUECDejnmlWPDI44l04e1N8XHB4cK+qrvi+TUNC/zA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711674;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=saSMbo648UHf2poSBhN3PUEeM9QS1/S8od9Ydjr4vT8=;
	b=EQL40GuiRiQ+Z4Zn3JgseQ0pY03cEFaftmYMPa+H/0ZzV47K8LqqcDuX5u0r0hpu8Q9I
	 1lgbgqn3Xy71JB2xp7L4KsSD4DDzKpDxt+1tMlkhtxPO/DteDDiD9PvpmTA2MwlSrdSM3
	 72/zM0fub4jpKVZA4q7dUTAVgnlkuvg0/J8hy1wHlUKGuxYjWycGVz6Vg9afMB5vi5k8L
	 oIns8TJHhJJo7M3JSSB33TyZSFasM+z8UI2xcMHMuakQ38098JIBEejk7ri4EhY4cdUzP
	 GQhiVtYU1ceFPqC9kJ8UdWMfUJ11uQZJfLeMVuhn71svXt0GCEPqsaDSaj1E7qz9P1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8D7B01F01825;
	Thu, 22 Oct 2026 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711674;
	bh=saSMbo648UHf2poSBhN3PUEeM9QS1/S8od9Ydjr4vT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O5V5sv/KZh+DLYym6rzOuT/kQE9KRDbxlpnPFnIjfAQVbIoSg0gLiZqfT0bZ4eLBQ
	 DfrboOvBg8pZgEjX8Nq12/DYcSnrdiOLrdm8US852lr/cDWK50dQi8PT39VxElFl7/
	 4XgG0rBF99vzVct1h11PnPkXribl82ZK4UjWaFHugEv5zGvT8p9scHpQzwccTWiTQK
	 3kIN+xx9iRTQ6gYN2E7niFmCghQ+xazpPCbM7Ax2e6SM4YX3N42xi/NUE9h79sDJZN
	 Ck5EnspsdmNbCLqv+bzQvzpJfjkAv8ZbTBhVL/K/33IEsXU8dQedoAm0Vhplw6SciO
	 hKcVS8n7h++QQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 76EAB42052;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:37 -0700
Subject: [PATCH RFC v2 05/50] KVM: guest_memfd: Support using resource
 provider
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
Message-Id: <20261022-gmem-alternative-providers-v2-5-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
To: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Connor Williamson <connordw@amazon.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
 David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
 Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, Fred Griffoul <griffoul@gmail.com>, 
 Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, 
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, 
 James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jianxiong Gao <jxgao@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
 John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Vishal Annapurve <vannapurve@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=7993;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=0G7kXeyhGqB7exCu+HDsg+EnEsp2/ypWTk3DC39+hvE=;
 b=fQD6dtNNlL2hF2L5aYCiKcASOb4iN3nVdhq4xDq+Zmvair/KrTP0zAbDvn3S8sRn6+9LtRAod
 l8RrBkymPLDCxtRQo3LbuNT74+rp+rPgvnx2NCD/ZHhrjzMflUcb60w
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

A refcount on the resource_fd is taken only to keep the reference stable
for guest_memfd to figure out the existence of a provider. The provider is
responsible for pinning anything required to keep the provider's ops and
the actual provided resource alive.

.release() is called when this guest_memfd inode is destroyed to allow the
provider to clean up.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst | 28 +++++++++++++++++----------
 include/linux/kvm_host.h       |  2 +-
 include/uapi/linux/kvm.h       |  5 ++++-
 virt/kvm/guest_memfd.c         | 44 ++++++++++++++++++++++++++++++++++--------
 4 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d9..9f5313d405d9c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6486,7 +6486,9 @@ and cannot be resized  (guest_memfd files do however support PUNCH_HOLE).
   struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
-	__u64 reserved[6];
+	__s32 resource_fd;
+	__u32 pad;
+	__u64 reserved[5];
   };
 
 Conceptually, the inode backing a guest_memfd file represents physical memory,
@@ -6508,15 +6510,21 @@ a single guest_memfd file, but the bound ranges must not overlap).
 The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can be
 specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
 
-  ============================ ================================================
-  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
-                               descriptor.
-  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during
-                               KVM_CREATE_GUEST_MEMFD (memory files created
-                               without INIT_SHARED will be marked private).
-                               Shared memory can be faulted into host userspace
-                               page tables. Private memory cannot.
-  ============================ ================================================
+  ============================= ================================================
+  GUEST_MEMFD_FLAG_MMAP         Enable using mmap() on the guest_memfd file
+                                descriptor.
+  GUEST_MEMFD_FLAG_INIT_SHARED  Make all memory in the file shared during
+                                KVM_CREATE_GUEST_MEMFD (memory files created
+                                without INIT_SHARED will be marked private).
+                                Shared memory can be faulted into host userspace
+                                page tables. Private memory cannot.
+  GUEST_MEMFD_FLAG_USE_RESOURCE Consume resource_fd as an external memory
+                                provider or resource pool. When not set,
+                                resource_fd must be '0'. When set, the provider
+                                must be a supported resource (e.g. tmpfs mount
+                                root directory). Currently, tmpfs resource pools
+                                require noswap and huge=never mount options.
+  ============================= ================================================
 
 When the KVM MMU performs a PFN lookup to service a guest fault, the fault will
 always be consumed from guest_memfd, regardless of whether it is a shared or a
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a8..d820afac49252 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2618,7 +2618,7 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
 
 static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 {
-	u64 flags = GUEST_MEMFD_FLAG_MMAP;
+	u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_USE_RESOURCE;
 
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
 		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e9..f4108bf7e3192 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1674,11 +1674,14 @@ struct kvm_memory_attributes2 {
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
+#define GUEST_MEMFD_FLAG_USE_RESOURCE	(1ULL << 2)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
-	__u64 reserved[6];
+	__s32 resource_fd;
+	__u32 pad;
+	__u64 reserved[5];
 };
 
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ee823f2ef0368..84877beed6701 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -85,15 +85,26 @@ static const struct guest_memfd_provider_operations gmem_native_provider_ops = {
 static int kvm_gmem_attach_resource(struct inode *inode, int resource_fd)
 {
 	const struct guest_memfd_provider_operations *ops = NULL;
+	void *provider = ERR_PTR(-EOPNOTSUPP);
 	struct file *resource_file = NULL;
-	void *provider;
 
-	if (resource_fd == GMEM_RESOURCE_FD_NATIVE)
+	if (resource_fd == GMEM_RESOURCE_FD_NATIVE) {
 		ops = &gmem_native_provider_ops;
-	else
-		return -EOPNOTSUPP;
+	} else {
+		resource_file = fget_raw(resource_fd);
+		if (!resource_file)
+			return -EBADF;
+
+		if (resource_file->f_op)
+			ops = resource_file->f_op->gmem_provider_ops;
+	}
+
+	if (ops && ops->attach && ops->alloc_folio)
+		provider = ops->attach(inode, resource_file);
+
+	if (resource_file)
+		fput(resource_file);
 
-	provider = ops->attach(inode, resource_file);
 	if (IS_ERR(provider))
 		return PTR_ERR(provider);
 
@@ -120,6 +131,12 @@ static void gmem_provider_invalidate_folio(struct gmem_inode *gi,
 		gi->provider_ops->invalidate_folio(gi->provider, folio);
 }
 
+static void gmem_provider_release(struct gmem_inode *gi)
+{
+	if (gi->provider_ops && gi->provider_ops->release)
+		gi->provider_ops->release(gi->provider);
+}
+
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
 
@@ -1033,7 +1050,7 @@ static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
 	return r;
 }
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags, int resource_fd)
 {
 	static const char *name = "[kvm-gmem]";
 	struct gmem_file *f;
@@ -1088,7 +1105,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	 */
 	smp_wmb();
 
-	err = kvm_gmem_attach_resource(inode, GMEM_RESOURCE_FD_NATIVE);
+	err = kvm_gmem_attach_resource(inode, resource_fd);
 	if (err) {
 		fput(file);
 		put_unused_fd(fd);
@@ -1111,6 +1128,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
+	int resource_fd = GMEM_RESOURCE_FD_NATIVE;
 	loff_t size = args->size;
 	u64 flags = args->flags;
 
@@ -1120,7 +1138,15 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (size <= 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-	return __kvm_gmem_create(kvm, size, flags);
+	if (flags & GUEST_MEMFD_FLAG_USE_RESOURCE) {
+		if (args->resource_fd < 0)
+			return -EBADF;
+		resource_fd = args->resource_fd;
+	} else if (args->resource_fd) {
+		return -EINVAL;
+	}
+
+	return __kvm_gmem_create(kvm, size, flags, resource_fd);
 }
 
 int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
@@ -1464,6 +1490,8 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 {
 	struct gmem_inode *gi = GMEM_I(inode);
 
+	gmem_provider_release(gi);
+
 	mpol_free_shared_policy(&gi->policy);
 
 	/*

-- 
2.56.0.257.gf7497c7d27-goog


