Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06F383329;
	Fri, 22 May 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482721; cv=none; b=n4I+Mon/O4iLtCF/C224WyYpilPRsqprTENpxkJnu11u//Q3oNdmJ+IeHh0O3ZiMrJhnQBeLPa/NrcTKMj1DtNEJME9IyTvar/VW4bBryI4pa4WZWWq5BgYUuvVnYkCH4G4hJvDbLAgzlfOUJAIwlpMyRSMvte03hyU/IU37YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482721; c=relaxed/simple;
	bh=VjzCzd1nFC0V+VspHRSm811yDhk2SVg8NJFOEp8BNQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJLZD6ZAhc56VwxCxFH6i7Zidu6Y5NFsVg16V6Gap87G4qN5emkqEga+XU8/tkuiTLWruRIF6VVVviaulVkdu8SBGeLH5jqBZAAyF16oF5wTcyFi4ym2XEO53X2aZeJESgFZXGnr2A/ZxmXBMXxVI1ampJYLAJ/0ZT1TPJXTT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRFyQShk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRFyQShk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F13CAC2BCC6;
	Fri, 22 May 2026 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779482721;
	bh=VjzCzd1nFC0V+VspHRSm811yDhk2SVg8NJFOEp8BNQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uRFyQShklzep8NxZ2OAADVrGtvknLWCj6uIgDGig54xBvGhyhrJp209JlmBmVLms7
	 IMISFyZYvoq+kRQutKSH+180AeZEAQCev3R5K/LhTVjJuEVya2UcJeT8bICwbILgvb
	 6UdPkVYaCpc/Ckik5lg9PqDlHxywzcd5Mpl7Mf9cA/5CnOS8yjlX/QB9H6iKtoUBIR
	 qnMs/Dbf7YaHhPxbbjh2YoxoRQLIU0XcrKjQ74fAdTs+lQciDLwbGTnGaT6cWWSOs/
	 fQ1BsFXnj0APT1qgIjDHCmbJwIqR+El6AEBfkrqFEmk9hLaR5vaLTm6s6qb/ukIW+j
	 s+LxmmLfLvQoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14ECCD5BB7;
	Fri, 22 May 2026 20:45:20 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 22 May 2026 13:45:09 -0700
Subject: [PATCH 3/3] KVM: guest_memfd: Handle errors from xa_store_range()
 when binding
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-fix-sev-gmem-post-populate-v1-3-9fc8d6437b65@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779482720; l=1599;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ppXZ9n7Px9sWPfCeSXJF2Jv5JKohLthkttbhOhgzju8=;
 b=umbtB2eulJGonqQIEnj0i8tfpFY/JDZfh8iROfUqls2ag7+sahhvKQjHe1YuUZhxnsbzOG+Pg
 BRTn7AR84LPBWKSpCfIJoEkcbhsFvmOeRkHiyYN2FQYa0Jjf3STwOTj
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Unhandled errors from xa_store_range() means kvm_gmem_bind() might falsely
reporting success, leading to false assumptions in guest_memfd's lifecycle
later.

Handle these errors by checking and returning the error to the userspace.

Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d203135969d13..104f0f3d6a0b3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -648,6 +648,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	struct inode *inode;
 	struct file *file;
 	int r = -EINVAL;
+	void *result;
 
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
@@ -688,7 +689,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	result = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -696,7 +697,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
+	r = xa_is_err(result) ? xa_err(result) : 0;
 err:
 	fput(file);
 	return r;

-- 
2.54.0.794.g4f17f83d09-goog


