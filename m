Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0843637C;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896004; cv=none; b=Zi3mfwwCPHjsXMqcsqhce40/JgV1JRCsSqEo6Yn402RlfWlfKTAb9qtLkjMV6BOr8JwIXD6lClC3CqH9/fmmfeOWSEMA7EXPrIULjwfu6CSBYKLVRmAjwkj7GXAhgQg4bDjfQs/Bmd8StRswKY4ZDpSFDxfLGoNk4Zc522Jqixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896004; c=relaxed/simple;
	bh=FM8Btc31o9TaR7EqiHYe618vKH3Wed7vGJFONaprfAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwanluBIJRRy5i3Yd77eGuqUnujUPvSe8OmFzCneuIupuvQxCEgK3aUJN95IXlyziUlXMsvssGbdHBjfnTH/xzeNhCZXvOSkqKV6lDbEf2S33usDw7pWHcWe8al8htUE5YhuNVjtxPY1iS+qXZ7xoe3zkA1KEJPCjvvls/KYi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb3eTT31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb3eTT31"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBD7CC2BCFD;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896003;
	bh=FM8Btc31o9TaR7EqiHYe618vKH3Wed7vGJFONaprfAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cb3eTT31zpz/nZHSvWpZi2G3lV7/PG8GuvpqDMnpCNLEzF4JhdDbcWYAJO9ca8LFT
	 ry4HSmNDiuULx9TVCwNd6zcXgHUStIrqtHO9e60u2Zo51oXI59oyjN37n1I6NvSO9n
	 LoPHBnpnJDUgkfHCNYc2Spk/35Vtda359hWUU7FP1iNUamiQU4cPcLtapxsotLmx6L
	 tGc6WfI5Jimv9MumQBURdzex37j9pDrsYXmDzX1e8cMZ3vNTfA4TLYtncjWXtRb7si
	 N5E8nkrFMiQczD73R6dPa24MkT2g2rYmePXLsJR73p8mTCsvaA4ljoHxWKdHpg4bNi
	 UFuUiRfYb4nvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0362CD6E41;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:20 -0700
Subject: [PATCH RFC 08/12] Documentation: KVM: Add example for kvm->srcu in
 relation to mutex/lock
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-8-4fe8b602ff47@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1342;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=IP6j6+0n9i5F75dc/JoOxvmpXpcBcDIU8T67NgzHpII=;
 b=iws+wuZgc1sF7u5EbOCCby1bgdlSn8bsv5rBl1ZlOezqhQaAFAgrzNaaUQz9E7paxNd7e92ji
 Xp+yzef8HISCWLzKvTmZVzrBQVHC5Z7MppBAVO69X2btpkTIfWrqhfF
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Add example of where vcpu->mutex and kvm->slots_lock are held while calling
synchronize_srcu(&kvm->srcu) to concretely show where the synchronization
primitives overlap.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 437dbfa0030b9..f12664443e913 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -35,9 +35,12 @@ The acquisition orders for mutexes are as follows:
 For SRCU:
 
 - ``synchronize_srcu(&kvm->srcu)`` is called inside critical sections
-  for vcpu->mutex and kvm->slots_lock.  These locks _cannot_ be taken
-  inside a kvm->srcu read-side critical section; that is, the
-  following is broken::
+  for vcpu->mutex and kvm->slots_lock.  (For example, when there is a
+  ``KVM_REQ_APICV_UPDATE`` request, ``vcpu->mutex`` is held in
+  ``kvm_vcpu_ioctl()``, and then when the memslots get updated,
+  ``kvm->slots_lock`` is taken.)  These locks _cannot_ be taken inside
+  a kvm->srcu read-side critical section; that is, the following is
+  broken::
 
       srcu_read_lock(&kvm->srcu);
       mutex_lock(&kvm->slots_lock);

-- 
2.54.0.823.g6e5bcc1fc9-goog


