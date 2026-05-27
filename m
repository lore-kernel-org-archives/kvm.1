Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2443637D;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896004; cv=none; b=LVsPBKMIDlEuht3kcgmQ/Tx56GgFUiobP7OQDJh0kKw6aMiPcVoEQ9XHdMic1s81qkDUgDsA5m2hNJubu85ZC9o5JieiJ1x6m4EnAVu7to1ucaIsK/zxILd/4Mrh5aoT1cPtMB6Ql44wBEWrjUtTQSPoAoVSyUBuJrHyJmyQllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896004; c=relaxed/simple;
	bh=bLcxXHk+CcALqz/zzbA0F0Yybtdc+uNVe0wHT/tY7BQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1a/hydnCoKRyLnAl1BHz9CUIfCRCIgnd8ghQUFF6uPb2B0zGATp5CFXW4DUH6IkCGtljG+rPugxK0n4iYwXht52lOtlC4BhwGsS2Ym6OxIKVnbkbreUy1FdzlAIpWLk1B3DrFfmnqr5Tu0cC4H90OVT7wM1/QTJhjKum+Qvzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZugAWKNo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZugAWKNo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C532EC2BCFB;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896002;
	bh=bLcxXHk+CcALqz/zzbA0F0Yybtdc+uNVe0wHT/tY7BQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZugAWKNou/3hhdk3/0CuslHwBG12FxSCoiQDLoZeTluxV075OF9MTYMvYc/B3dwQE
	 pYt4TldcdTo+0VF7VMlW8lw9NewWgyAdIWMbeWvIm80t/noX6uKVj8+YHOClMxaDVo
	 SI9Lkr34NYgh7xriAcRUxu/oNZDa6C/QUyWV/aizcmrWJh0YRhl3JQXDarb/ZgIFxK
	 lN8OjLatlFAtuSoxeVfB037tOrc4k+2l4CHZHZ13eO0wl6Db/kaaZEXq3ztR0j5H8K
	 zTFb9qQNeo1OydUTwLbFBUwUiAR2+ZYGsaBbOMbsyntsioUdV3Ua50kmUrprl1JrM7
	 +H6gFaV3R5SOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF9BCD4F54;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:18 -0700
Subject: [PATCH RFC 06/12] Documentation: KVM: Have actual headings for
 exceptions
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-6-4fe8b602ff47@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1576;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=omLCISL/Cs1+39lE29MDupCtm4WwTzGw7vDPKSySNYo=;
 b=hprWgud3QVI1IKRiPLGBIYGbG2occ7We7PsN9/HJiCR/0rZEaqlqEP39d5vxdyx0Gpkil7MJV
 OZNw5t9xeHOAhY9qTRJPjQQyqfcQdggNLhA0ARfSxEm8DrBNtkxx0PE
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Exceptions documented are described but without headings, making it hard to
identify where each exception description ended.

Use actual headings at a lower level than that of the heading used for
Exception to improve readability.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 5161636cec481..fc4537a7659a9 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -65,7 +65,8 @@ The general rule in KVM is that any modification to shadow page tables
 (and their entries (SPTEs)) must be protected by ``kvm->mmu_lock``,
 with the exceptions described below.
 
-Fast page fault:
+2.1. Fast page fault
+^^^^^^^^^^^^^^^^^^^^
 
 Fast page fault is the fast path which fixes the guest page fault out of
 the mmu-lock on x86. Currently, the page fault can be fast in one of the
@@ -217,7 +218,8 @@ Since the spte is "volatile" if it can be updated out of mmu-lock, we always
 atomically update the spte and the race caused by fast page fault can be avoided.
 See the comments in spte_needs_atomic_update() and mmu_spte_update().
 
-Lockless Access Tracking:
+2.2 Lockless Access Tracking
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 This is used for Intel CPUs that are using EPT but do not support the EPT A/D
 bits. In this case, PTEs are tagged as A/D disabled (using ignored bits), and

-- 
2.54.0.823.g6e5bcc1fc9-goog


