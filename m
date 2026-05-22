Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3F25A642;
	Fri, 22 May 2026 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489971; cv=none; b=Fj7eRYuGIEEgphUC79wOV/Dqk0n0xS2SL3QhF5iRexkzR91prC897tHxFv5sgyHfsuY0F+o+QxJuHtUG/lwn40nydAlMvC+VYy7Is65S9lI6rEY23gE83qFRyv+EqHKt2RJzZPTeMHkx/mL0S4KJA4V5mqggKoTwuzmIjersgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489971; c=relaxed/simple;
	bh=L5lGUM9V9NHInUfTp0WXgOv5dlcW63soO6U7JNmT904=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvDNNnMEp0Io67rGVkHLb/CUyQYeGMYqvczQgsvJ5P8x1tco5iJK82HaCxNM4pQvx3+GT9LMFz8pF+kaytHOSRASbp0Gr7YI0t8H0Rk8R8gGxIhjNOJYw/L/yFHHAQa8gNQ7TbfqTVWL6PRWBjbjz5PDBEk3QW8qk3YjbQZ2igA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9CfoA6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9CfoA6N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF84BC4AF0C;
	Fri, 22 May 2026 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779489971;
	bh=L5lGUM9V9NHInUfTp0WXgOv5dlcW63soO6U7JNmT904=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b9CfoA6NNqXEnnusnIbfbUfPTLoZLO+UUs08bkLc/uKDurUN1lsMmDk3kJ3WonkXE
	 lL3Kjds2sq4eksQcRI0xHe7CaIxXNmsYvnCMfiF14NIG9hySrOkvZJ7r03GxPqpLaK
	 DDc4UPbWRw678pYnQvaUvNS8re0kKlP1Bu0KsXh5WTVEb1P4p7YmlIUZK27QcbM2Ht
	 9FByI/4++aO4dAxxrg7qdN0DFHif/9T1mDU3EMSTgAR/0J8WuZo3sBXys8wLN2jjWY
	 XuYP2qFSDM7608Xg/7iGX3uf1DiqhG4Sg1/gK8NHY8R31K3dzHl+s2TRPOIw2cS7yg
	 NXObQEsjFTvfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E237ACD5BB0;
	Fri, 22 May 2026 22:46:10 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 22 May 2026 15:46:08 -0700
Subject: [PATCH v2 3/5] KVM: guest_memfd: Handle errors from
 xa_store_range() when binding
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-fix-sev-gmem-post-populate-v2-3-3f196bfad5a1@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779489969; l=1708;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=IUci/DrJoi/pXPstnReU0IiJiRojPWLPI0HoQxzkXfg=;
 b=Amt1w5AFQnzejoJxCw29NWfrlwfW6wOUsNMYv7ermZIU5gGfnwJSb+05ToXZTdPKj+VforE4J
 AAZgTZ0DIT/Bn4PsYTeG5+piXbBgrdlMgmGl0ENRjiDP3UlybUnTtV7
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

On error, restore the unbound state and return the error to userspace.

Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d203135969d13..5b4911ffa208a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -648,6 +648,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	struct inode *inode;
 	struct file *file;
 	int r = -EINVAL;
+	void *result;
 
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
@@ -688,7 +689,14 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	result = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	if (xa_is_err(result)) {
+		r = xa_err(result);
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+	} else {
+		r = 0;
+	}
+
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -696,7 +704,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
 err:
 	fput(file);
 	return r;

-- 
2.54.0.794.g4f17f83d09-goog


