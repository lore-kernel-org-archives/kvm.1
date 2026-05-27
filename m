Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3C3D3D16;
	Wed, 27 May 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896004; cv=none; b=QNhrG1KwbdLvLgk4DC3PTtYtg5Yy57ZM4++vgXuAIZ+dGB7/70QDTWkFG0x4WKRTGuYNECBydLP4FCfy8tJwSt5ewzwNcgVorX6J+QJN0A2TIcj8HAicXM63ziNMYywpuHWEQbchBI41HYTxknSGELV65mRgQLaecNeLUMwA94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896004; c=relaxed/simple;
	bh=SDxYegV3dg2hqetMhwdqeXXQOxrUizjq1F4c00wAdYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfTLjbiIpWRcbYR1Y8H3RdkiuYbjp2IcgzzXKMG8NXwzUsJqmxn4qjgOpnB+56tveIwKd5hmbEm5O3BDuYxTgTA2SWKvNSUH4aPmRnsgXrUAF9WzhjbW2KV9ET5SHJCRUT77D+83G2GkEncU5SKTssbkIeRvP5ELeVEirnGZQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfETLX8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfETLX8P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F083C2BCB4;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896003;
	bh=SDxYegV3dg2hqetMhwdqeXXQOxrUizjq1F4c00wAdYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EfETLX8PWPzNlXwhunKu2XOnMLme4YYCL6BQ7GyLGzlBVkXiHJ5p+CPHXS4Vs2/Vt
	 e0Ea2Fn9zVa/EHLEpmzVQx4lT/7PLUzrW3wg+XlBzml/BEA0zfmc8zP7IwimsC0kZa
	 zM0afIiLEyTXyl//yByWhVt4N0J3/624sMNnKQCCt+isw8BBRYsjajIKG52j5wKlYE
	 GlxmP2Pz7m9NuGtzmev9SHLjRx5YBN2eN3GI7uGp1pqH6skHwk06FRD+i3ifLFi0ZS
	 fuTBr+DSl5UDBs+g0Cm57fvpJAG1Tey44suE2iw8miMzFN0lou9WSnAAbZHsKWrHb1
	 MPhIwNSaQBmlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B67CD4F54;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:24 -0700
Subject: [PATCH RFC 12/12] Documentation: KVM: Focus acquisition order
 section on preventing deadlocks
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-12-4fe8b602ff47@google.com>
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
In-Reply-To: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
 vannapurve@google.com, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1268;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=AsaYP57e05UmB20wkvz2ac8XwGdrnAvpcLv6/4UIzSY=;
 b=/yniIvnWn4q3kTWgqqaHndF4zOmwJDCk3stxZhB8gkrHCBDyaGRJ5dgMjaI2FXpf3UqwGtqcK
 qwfmNRwB7dXCwu4GyjoIDe3TPOjN73gTHFFrxKkm4DEZmg1MiFAmPWK
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Now that the first sentence is already described in more detail in the new
section on synchronization while managing guest faults, drop the first
sentence.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 0663ccfe0633d..f26ea3acd0b70 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -26,11 +26,9 @@ The acquisition orders for mutexes are as follows:
 
 - vcpu->mutex is taken outside kvm->slots_lock and kvm->slots_arch_lock
 
-- kvm->mn_active_invalidate_count ensures that pairs of
-  invalidate_range_start() and invalidate_range_end() callbacks
-  use the same memslots array.  kvm->slots_lock and kvm->slots_arch_lock
-  are taken on the waiting side when modifying memslots, so MMU notifiers
-  must not take either kvm->slots_lock or kvm->slots_arch_lock.
+- kvm->slots_lock and kvm->slots_arch_lock are taken on the waiting side when
+  modifying memslots, so MMU notifiers must not take either kvm->slots_lock or
+  kvm->slots_arch_lock.
 
 For SRCU:
 

-- 
2.54.0.823.g6e5bcc1fc9-goog


