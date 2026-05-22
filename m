Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7333F8B1;
	Fri, 22 May 2026 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489971; cv=none; b=hwpOPjx3l4VZiYOAincO2t4UZSSiXARQiwWZNDY6Wbb2Sr5aQxO1jV8041SJGbB/klsaeoMRarIONnvRoMRPFHol39y4c/Ginfl3WfA4WGGkxGZQP/W3RqkQ5VJ0E2nQusWCYCqbm44aSsmOxD0a7i8Y/VlTOjlfgfW2kDoHrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489971; c=relaxed/simple;
	bh=c45Qu9zhd/kLsBjDSXT1r99pYvcHsGhiUHC17F6IgIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8ewdm3ETrB8LPWDPJ17puHp6xTWHvVOZzZ7VkDCkre6OYEDOGLAlo1oNCTjhVkhE7qdE6BpSPaJPTaBGHxXv36GqT5qd/fBjEqD6jI/VKFDTfl06FIS7pGVOgHNObop7GhjAhNySJu63+S9xKWPIUoJv0mGJjHH4atOQl3fQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQm3vKdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQm3vKdK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA9BC2BCC6;
	Fri, 22 May 2026 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779489970;
	bh=c45Qu9zhd/kLsBjDSXT1r99pYvcHsGhiUHC17F6IgIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZQm3vKdKrBlfGUsCqL5g2PmZCw/X4kc+bErykp1iUB070afeN5zDiMSJvhje3De31
	 eQYka4HUIOqlQTR45iAL+FTgAlTz+4olBOIm0KnrAmRK6evzV3Syf3dA3RTnCnzdnL
	 RI2gxZQ1MA4n88oWkxycJm7vKjbQKt5zZh8NDCHExWKAWjbGmj/qcrGyGXJeqv+PKK
	 dd2J387c4YvXI2+NJFst72EDKrq6+Qml6em8ZM0UUeVkN2m3sTU5tL4bA5q3S+uirg
	 wrrZV5Iq/eg8CQmGHrMo05uLvG6SZCLnOnOkJuUJ0+xvz7u+GxdgFdTXwZRxwficpe
	 Aujxz6dsrP3gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F07CD5BB8;
	Fri, 22 May 2026 22:46:10 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 22 May 2026 15:46:07 -0700
Subject: [PATCH v2 2/5] KVM: guest_memfd: Fix possible signed integer
 overflow
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-fix-sev-gmem-post-populate-v2-2-3f196bfad5a1@google.com>
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779489969; l=2660;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=JSPTTpIiKhOV4/yLuJbPtjKeCwvKRuWpCoRD+oLFQ+A=;
 b=AA88AAu05doKQquAzIDYtyyam8SZULnS5IFyEpEaYGxnquksBYuk/Ysn0gde/LkEL9n4skFB6
 gYqrrO2va7fCjZstWWS5+ZNBhlrAL6zj9Ybe/BcOTmeLUOE7rfGIm7D
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
 virt/kvm/kvm_mm.h      | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

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
index 9fcc5d5b7f8d0..8c2bbfba63424 100644
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
@@ -82,7 +82,7 @@ static inline int kvm_gmem_init(struct module *module)
 static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
-					 unsigned int fd, loff_t offset)
+					 unsigned int fd, u64 offset)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;

-- 
2.54.0.794.g4f17f83d09-goog


