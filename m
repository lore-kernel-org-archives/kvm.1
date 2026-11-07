Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011841;
	b=ku0XCX0xH+kqXys02a9JKgYklrsDY+k/L1Dqj8rDBpz1egfhQzAS2UF7EVUMlXhkb3PZ
	 ob8Iz7bQvvQXs14meXnmZ3JtaViDpq0P4TA8kFgjYJP0unZNHEOmDjLDjZ3BstlTsQUjk
	 Kz5JEe0j0/i3cv3/hO2b7i9J0s1ZKFO3+CkxiRdO1FCJbJoikfZ12K/srJeM5xFzs5t6h
	 y4tuRp4XmWqYRt7Mq6qMwJU6vQ6/Rn1kgHC7Lu3Ua1XTOAdMd8ks9bts8k2dDv8ec8Yxg
	 xSzwt56vXmP7EqdAtBXD/3AJe6hAX+rr4pEO4NaczBUsukNtb2jueKOVbxQ4G7T8zUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011841;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7jyih/ZWZhrRU6GcpifC/ctZB9GVVxtxj6yL2+TCX50=;
	b=IKblbz8r5hQKIPbdv7rXrzAh8rNMRqT56mbcESsAPaZIpZgMtrolDZp6hU22ZXwz2QqY
	 3I3pgsC6Avwe1GBpcA8VZ0sJy5uEd37qLABFHU13n8ZeAU0LnzfjcmXehyQ3Tk3I4XfnE
	 PWM4In1KXUsxynA+Gt1Fgz9oL2/M66UfKoFtNpU9j+ApgpOhNcqTEeV7KDI0fhe/YZYhs
	 kGLdBHjrBj68uLprzbf3GK9tu7JU5JVEywAxSzzKf+nafZDuKjI9Z93Evy/0rsrTYY4oL
	 YkojArU0w2+zBF9W6iVyWHAwDe0zcaqRPUTOFtQN910038Px7YKxI2C062UhE0A0PPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A7606D810;
	Sat,  7 Nov 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011825;
	b=ewNOAhQVaOJd4siFJzBY8GcVN2CvNpGxyYx1oe3K8DIgjLu5mI6Ee8RDetk17w4Gwidw
	 VRw3JqLHFd9RImfwmqx74zn/SyCXP5417G++gAWdtSvQf1p5VfaJS+ViLtw3W2tnhRqY2
	 NXPmafnm2p1IKHUNb75r0OCQRkdQ6cTodo4i9WxpcvfuYLO48qeMNgOIsVYF040EFk/tm
	 lpAxIWJCp9kCrimwvEJu7MNaQm/cQwLqrkjUeC/6Ot+UscAET1rFJQDvHOkBQJ5cPj00j
	 9b/LGDMBOJEYcyzay123XnizVGfcyZZRRN3DcFO1+7Qe8iTS3uIjWZjdwLFl4mooPFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011825;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7jyih/ZWZhrRU6GcpifC/ctZB9GVVxtxj6yL2+TCX50=;
	b=zxeBR7J22JNNfKUi6a/eB+wlijcGujOJT4m38NmkkI7sSZJ6N3lYxngjkbmFUFzpv2Y5
	 j5QFuoNx80SPBgfX1UY8QBxsOM68paug0LL65HVmucM7DU4LFPJnG+nQ6sXwq2ggmB6qC
	 KXeJgI/d4yf523NqvSq+A+J+eMypirNWOvtbE8DgEoxTAdmDbCQE4BaZ7r7yWfJMnBYzz
	 ujqfao2+QrM0RnVPKbx3YKJ6g31W0RBQRnf7R3XQjoSvuAf0rJ21+NHXgng6dVfmmxA4z
	 LlUhq38MzfpDgqving4vdfJgXl2obYlU+it+4Y8exTe86Pzx3jNfqTcIdHxxGmz6F9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3EC421F00935;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011825;
	bh=7jyih/ZWZhrRU6GcpifC/ctZB9GVVxtxj6yL2+TCX50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YJ0Qo6jNfTzFoj6mVl0zDhylpwBaFlD/OlOhXGoXZIsU0jUXlqchzAvJ2ATcXk8St
	 SnHAswlThfrMhrV9n9VGgu3ws0GS2y23yNtIZlrlvRt5dKDiqC5NFMcWlXhv8xuW3P
	 gDRL1FKNnZ23loSt7fupwpnkh20z4WzTOsxlj1nxofp1V+zm7mTdk13qW1kMyjFgLi
	 TgLsEUqeFHQLkABtg57RFWZlWbK94cI0xu7S4s0O1zwz27db9QbVLBNGMYQLMQkMGf
	 GtrXTV2ZqIdYNduroGKG/RBRkPj+3TaI4qP12Do6h5G4nrWajOGPPBgE+eSydU/ddt
	 auX71iruaSjCw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 049624798A;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:04 -0800
Subject: [PATCH RFC v3 30/88] KVM: guest_memfd: Refactor error handling in
 kvm_gmem_fault_user_mapping
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
Message-Id: <20261106-gmem-alternative-providers-v3-30-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1832;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=VKBzbTSyM8v25pj2OERwLhVUhvmGhWqrRwXpLizcOTo=;
 b=TNHQGkfJIKvSrJmsMJhLzh4Zf2IlSWb1GaDzeKt8ZF6I4gcbCyM3w70nbNY2BGZBmWj+BSlaL
 RGs8UwVSrcNDrzLDRtCrZvXA3lfyBNeELOimwZhBiqgNYheS6HmLA9N
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Track the status of kvm_gmem_fault_user_mapping() using an explicit error
code rather than encoding errors into the folio pointer.

This moves away from relying on the folio pointer holding error states,
such as synthesizing ERR_PTR(-EACCES) when memory is not shared only to
extract PTR_ERR afterwards, and prepares kvm_gmem_fault_user_mapping() for
PFN mode in the next commit, where no folio is returned on success.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index eedf03df12c55..180418c65a1ae 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -568,24 +568,28 @@ static bool kvm_gmem_supports_mmap(struct inode *inode)
 static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct folio *folio;
 	vm_fault_t ret = VM_FAULT_LOCKED;
+	struct folio *folio = NULL;
+	int r = 0;
 
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;
 
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	if (kvm_gmem_is_shared_mem(inode, vmf->pgoff))
+	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff)) {
+		r = -EACCES;
+	} else {
 		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
-	else
-		folio = ERR_PTR(-EACCES);
+		if (IS_ERR(folio))
+			r = PTR_ERR(folio);
+	}
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 
-	if (IS_ERR(folio)) {
-		if (PTR_ERR(folio) == -EAGAIN)
+	if (r) {
+		if (r == -EAGAIN)
 			return VM_FAULT_RETRY;
 
-		return vmf_error(PTR_ERR(folio));
+		return vmf_error(r);
 	}
 
 	if (WARN_ON_ONCE(folio_test_large(folio))) {

-- 
2.56.0.455.g6c5a503b38-goog


