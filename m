Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FB383338;
	Fri, 22 May 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482721; cv=none; b=AiBs7Tck/pUlb4cnDdiYHqUZyZEP/AnN/3h7rezJKvPkRqEIAQPcLuIYkMvdyfD/oD0/3AU2RfOy9zaNzYJgZR5z6PGqtMkoPeTKsAyY7Wn4djToHsURg4VOL2wSKH0Q/XdsHKy9X/rM3jqrXHcLDvaYcenFT4JtkJLIFmBuXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482721; c=relaxed/simple;
	bh=TVMOILIkybDF4ZAoPGUr1TGPQPrSGZYxBbN5yDurWpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSzpmZe5h/y3OcTtoMjFrQT/oS+92b5Zw1Mms1HK1hqj+BGSmGiP6NvnBhuX0YoaiDxLn3lF/6YR+OhA8SMQ10KGxXWCI8DZZfEHRhPrq1qxxyLiv2acuTe/M4pehHLt0GehwD3E6a5SsxdAjPtR8REUWL2b042jl5PkU4rABj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzJl5n6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzJl5n6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5A6AC2BCC4;
	Fri, 22 May 2026 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779482721;
	bh=TVMOILIkybDF4ZAoPGUr1TGPQPrSGZYxBbN5yDurWpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RzJl5n6ZhwXUoD4/Yi6W12D8sD2WeCO2cyOqm/81jVCYjFdB6ZbmnefTKfBPBF36Y
	 hNZG8sTkJuknwqijXQkeXM6YE1aNZz8lVD1+LgznNQC5kC7OFIf+nhb0cQ7squ9kBb
	 ZRYkBKzhLvhpXiF22XjlG21ZBc1wEcQVENc98fSdL01X++lEbmcss/3DZymZ4CfFND
	 RqvNom9MmNRwpfGR67bfdd1DFc2FlzmINT/0sgZXTx6H2ER/LTlqgx3Wa22tzWI5PJ
	 yaczHVgiRRTobIzqP2Oh2O6ItWfCxa/5qV/XpGgbwyT5EeEak7jYUMboZ9aT+9HVMT
	 V/OIbArCY2ibw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2207CD5BAC;
	Fri, 22 May 2026 20:45:20 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 22 May 2026 13:45:08 -0700
Subject: [PATCH 2/3] KVM: guest_memfd: Fix possible signed integer overflow
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-fix-sev-gmem-post-populate-v1-2-9fc8d6437b65@google.com>
References: <20260522-fix-sev-gmem-post-populate-v1-0-9fc8d6437b65@google.com>
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v1-0-9fc8d6437b65@google.com>
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Vishal Annapurve <vannapurve@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Isaku Yamahata <isaku.yamahata@intel.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-coco@lists.linux.dev, Yu Zhang <yu.c.zhang@linux.intel.com>, 
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779482720; l=2333;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ofKqXIIrcexdOcp4E1N06pRFNz3oEbe3m6kkux6/laU=;
 b=SG32xTxrOUR3hqoEwkOB131em+YX++oBZh5F0nl7lNjx0k0vZB4nM12YJ7TKtw9JPbxVUT7fz
 b3RmdI6J4DRDbcJJPReO/gjYv5R8oRJ6WED/y7s+F1VstD5Q+HllT8r
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Sean Christopherson <seanjc@google.com>

The caller, kvm_set_memory_region(), checks for an overflow in an unsigned
u64 guest_memfd_offset. When guest_memfd_offset is passed to kvm_gmem_bind,
it is cast into a signed 64-bit integer.

Hence, a large 64-bit offset could result in a negative loff_t, which could
result in the overflow checks failing.

Make kvm_gmem_bind() take u64 instead of loff_t to consistently deal with
unsigned values to avoid this issue.

Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
[Use size_t for size instead of u64]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 7 +++----
 virt/kvm/kvm_mm.h      | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 07d8db344872b..d203135969d13 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -640,9 +640,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset)
+		  unsigned int fd, u64 offset)
 {
-	loff_t size = slot->npages << PAGE_SHIFT;
+	size_t size = slot->npages << PAGE_SHIFT;
 	unsigned long start, end;
 	struct gmem_file *f;
 	struct inode *inode;
@@ -664,8 +664,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	inode = file_inode(file);
 
-	if (offset < 0 || !PAGE_ALIGNED(offset) ||
-	    offset + size > i_size_read(inode))
+	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
 	filemap_invalidate_lock(inode->i_mapping);
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d0..23813d74ce709 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -72,7 +72,7 @@ int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset);
+		  unsigned int fd, u64 offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)

-- 
2.54.0.794.g4f17f83d09-goog


