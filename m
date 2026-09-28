Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90A2E5B2A
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618580; cv=none; b=kb8ZOxed/H08YYx/vfmOU1PhS67g9VdVvgs+giXTUZz3oA/9PXiADTJ0wR/WNTUUkZ1VTo28kJtmdFdDS7IVJPc1yZPyUbIaYI11RfKpXzX6Z/ToXgImTjObA8JKfgZKEpruA0wldb0S4iVUKiKHHRFVKVicmjCfzDP92mEqNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618580; c=relaxed/simple;
	bh=5xYGMo09j8DZ3zwpsrj/HROYrKtCfUoYkDBxNdkxwZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AC66OjSYtVpJxDh3Do2n7CJZiCfWiKobyHhUA57ut2rbA0LLyths9FgkfP/E0i97JSw0uZVkV8IJSAOuV6+TwgZAehlypi2tiH5J2o6F7FqGkgfY2/Zqm7XJv7l9XXn7gIiorCOPMDn3hVH4RvkWt+L0iMDaBkqh+GzslEmkMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jsaqtp0/; arc=none smtp.client-ip=91.218.175.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jsaqtp0/"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5xYGMo09j8DZ3zwpsrj/HROYrKtCfUoYkDBxNdkxwZc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790618574; v=1; x=1791223374;
 b=Jsaqtp0/d29zfEjKzF32iLNsiYBCjQyaWNhX9FprhoXvJToYaqp/leYRJNq1ZfviTX26I2I/
 ifRLbms/3miHhw+Q/JR6TcQ1pmrZIuppS0tdC918Dyf0HpXlEouX2sAJuW+Uisq+e9oItvmdx83
 6mkaRAqC0RF8V2X8mLo3zQ4M=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e67d825b48e09194;
	Mon, 28 Sep 2026 18:02:54 +0000
X-Mizu-Trace-ID: e67d825b48e09194
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH] KVM: guest_memfd: Fix the in-place conversion documentation
Date: Mon, 28 Sep 2026 19:02:50 +0100
Message-Id: <20260928180250.3075584-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dcde2f853ff46 ("KVM: guest_memfd: Ensure pages are not in use
before conversion") added error_offset to struct kvm_memory_attributes2,
written back on failure, and a -EAGAIN return. The
KVM_SET_MEMORY_ATTRIBUTES2 section of api.rst still lists the old
struct, marks it input-only and leaves EAGAIN out of the Errors table.
It also refers to KVM_CAP_GUEST_MEMFD_MMAP, which had become
KVM_CAP_GUEST_MEMFD_FLAGS before this ioctl was added.

kvm.gmem_in_place_conversion's entry says in-place conversion is
unconditionally enabled without CONFIG_KVM_VM_MEMORY_ATTRIBUTES, but a
build without kvm_arch_has_private_mem has it disabled: arm64 always,
and x86 without CONFIG_KVM_SW_PROTECTED_VM, CONFIG_KVM_INTEL_TDX or
CONFIG_KVM_AMD_SEV.

Bring both in line with the code, replacing the stale capability with
GUEST_MEMFD_FLAG_MMAP, and describe
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES the way the KVM_CREATE_GUEST_MEMFD
section describes KVM_CAP_GUEST_MEMFD_FLAGS.

Fixes: 799c9fadc6399 ("KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2")
Fixes: dcde2f853ff46 ("KVM: guest_memfd: Ensure pages are not in use before conversion")
Fixes: 537ec2b15fdd7 ("KVM: Let userspace disable per-VM mem attributes, enable per-gmem attributes")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---

Notes:
    This applies on kvm-x86/coco (37e0791600e5f); the three Fixes: commits
    are in kvm-x86/next and not yet in mainline.

 Documentation/admin-guide/kernel-parameters.txt |  3 ++-
 Documentation/virt/kvm/api.rst                  | 14 ++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 49560b1b54c48..f478ec2097438 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3177,7 +3177,8 @@ Kernel parameters
 			Note, this parameter is only available when
 			CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
 			CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
-			conversion is unconditionally enabled.
+			conversion is enabled if KVM is built with private
+			memory support.
 
 			Default is N (off).
 
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 67f0f290797ab..3d6a4bf01c700 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6690,7 +6690,7 @@ significant bit):
 :Capability: KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
 :Architectures: all
 :Type: guest_memfd ioctl
-:Parameters: struct kvm_memory_attributes2 (in)
+:Parameters: struct kvm_memory_attributes2 (in/out)
 :Returns: 0 on success, <0 on error
 
 Errors:
@@ -6700,6 +6700,8 @@ Errors:
              page aligned, causes an overflow, or size is zero).
   EFAULT     The parameter address was invalid.
   ENOMEM     Ran out of memory trying to track private/shared state
+  EAGAIN     Pages in the range have outstanding references, see
+             ``error_offset`` below.
   ========== ===============================================================
 
 KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
@@ -6719,15 +6721,19 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[12];
+	__u64 error_offset;
+	__u64 reserved[11];
   };
 
   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
+The capability KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES enumerates the attributes
+that can be set via KVM_SET_MEMORY_ATTRIBUTES2.
+
 Set attributes for a range of offsets within a guest_memfd to
 KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
-memory range for guest use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
-supported, after a successful call to set
+memory range for guest use. Even if the guest_memfd was created with
+GUEST_MEMFD_FLAG_MMAP, after a successful call to set
 KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
 into host userspace and will only be mappable by the guest.
 

base-commit: 37e0791600e5f1e2837a270c885296a172f5825e
-- 
2.39.5

