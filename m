Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC484389E1A;
	Mon, 27 Jul 2026 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196367; cv=none; b=iiRJD3m/msn7bAEF3w/Jo0rwE8w38urQTBxekdU9jqhvMg9NprOe5zVMyFwE1/Kd5XeCPasQFZB8m3OP7tukiDvXs8w1yPmykZQJeNkav9s2cqgUcn9e4WQUGFCU9S7cNlvbtYSOYUHekwkqhO9p39hixPbbR8tkqPd4X0Cksac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196367; c=relaxed/simple;
	bh=Y+FgRXkQvS9GCeudxYw1RIEFArNcgIz8V7fTe5acwc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RITXAmZyFK4lDR6sjgMXqr6PIPB5wO5738214tcNolZppVlT6YAylus499fsCP5lXDT+d/GQMYQw34qwg/ldNvL3DV+JwbwzRHBIkOSIAEhyXG7b9enU5JbU10eEEx/QA0tPvZIQyLFFA8mPm3ssz5KOFN+gFIXMtHgkbC8OdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6JIQ6Jj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6JIQ6Jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABED1F00A3A;
	Mon, 27 Jul 2026 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196365;
	bh=R6LpSRhMBurOKQv+scwzTO7gyzPnrrDWUN8TBYBvuf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6JIQ6Jj2J5ccr/ZerB91zBUdguz1qTciQGs5ZPKGJj/7iiCLsoAQ8eTiWQNRdpMk
	 /+U6xFAGLyoowgjZzh8UQ0FBkh4MmoCIJpm0SxmkUx9QJn91WIgGQPbLdXbfNLbRqF
	 1zKS7GpZMH7wcg1Q0KZz2i7WtyJ6reK6rL63QEzhGzcao+v6SleviVFoUnrnfDGq0n
	 f9maVvIJRxdbMLFVus4X4qhAjy5Mz/sbvJOKIJ/WpeONXfdt9pbjBHIl7YNSCk8j/w
	 2Nm3ZpDZF0eqPhTF4nW+PdbApkJPky/8FcnxOb2CamN5OIkciLtboCw2/WulJX9TBK
	 ylQ341QNzSuiw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 02/12] KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
Date: Mon, 27 Jul 2026 23:52:18 +0000
Message-ID: <20260727235228.1007324-3-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The offsets used (0x170 and 0x1f8) are offsets within vmcb_save_area,
not vmcb. The correct offsets should include the base of vmcb_save_area
within vmcb (which is 0x400 -- so 0x570 and 0x5f8).

Instead of just correcting the offsets, use vmcb->save.rax and
vmcb->save.rflags as parameters to the asm block and avoid hardcoding
offsets completely. While at it, also use guest_regs.rax directly
instead of assuming it's at offset 0 of guest_regs.

Note: "+m" must be used for vmcb_rax and vmcb_rflags, as caching those
fields in registers would be wrong as the underlying KVM will update
them in memory.

The same problem was recently fixed (differently) for kvm-unit-tests
[1].

[1]https://lore.kernel.org/all/20260521092311.86030-1-pbonzini@redhat.com/

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40kernel.org?part=1
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86/svm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 1445b890986fd..766d15f1d534a 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -164,19 +164,22 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 {
 	asm volatile (
 		"vmload %[vmcb_gpa]\n\t"
-		"mov rflags, %%r15\n\t"	// rflags
-		"mov %%r15, 0x170(%[vmcb])\n\t"
-		"mov guest_regs, %%r15\n\t"	// rax
-		"mov %%r15, 0x1f8(%[vmcb])\n\t"
+		"mov rflags, %%r15\n\t"
+		"mov %%r15, %[vmcb_rflags]\n\t"
+		"mov %[guest_regs_rax], %%r15\n\t"
+		"mov %%r15, %[vmcb_rax]\n\t"
 		LOAD_GPR_C
 		"vmrun %[vmcb_gpa]\n\t"
 		SAVE_GPR_C
-		"mov 0x170(%[vmcb]), %%r15\n\t"	// rflags
+		"mov %[vmcb_rflags], %%r15\n\t"
 		"mov %%r15, rflags\n\t"
-		"mov 0x1f8(%[vmcb]), %%r15\n\t"	// rax
-		"mov %%r15, guest_regs\n\t"
+		"mov %[vmcb_rax], %%r15\n\t"	// rax
+		"mov %%r15, %[guest_regs_rax]\n\t"
 		"vmsave %[vmcb_gpa]\n\t"
-		: : [vmcb] "r" (vmcb), [vmcb_gpa] "a" (vmcb_gpa)
+		: [vmcb_rflags] "+m" (vmcb->save.rflags),
+		  [vmcb_rax] "+m" (vmcb->save.rax),
+		  [guest_regs_rax] "+rm" (guest_regs.rax)
+		: [vmcb_gpa] "a" (vmcb_gpa)
 		: "r15", "memory");
 }
 
-- 
2.55.0.229.g6434b31f56-goog

