Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7465436376;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896004; cv=none; b=B4dUuwKpouLXF+MR9UHm/ParyeScgnzWEp5vxRwa0OakoO6t0CxfUsxx+wckYR1zzv1abtOsqSmWABiQ4pAXrYKBBGFWziZ/WSqwDvTEAoLVVkW1UmDYJKAejiUDc0jPcUs2RMGOCdZM1QWypUkatC9drJ6KQvgPg/soI5xGtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896004; c=relaxed/simple;
	bh=Fy7SviBXyfR5Bkm0PCeZ4kofves6M/GmlsfFUICPdbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVFMP+SFfd6MWbnqnfgkOiA5qedWbj+vO6e60BNkn+gNFjl2XDxObErmCJZDjDjaSRF2MkHWc7pBQH/8CuVbcDbdIAGVr9/xZ6QSpOxC0+pyonYjtQ95xcDG30snGyRxgFNw8Mcq3eyGrZ0VWE16CEfKrTKbBe5vVvibjDIW348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsanj2tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsanj2tq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E8DCC2BCF7;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896002;
	bh=Fy7SviBXyfR5Bkm0PCeZ4kofves6M/GmlsfFUICPdbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zsanj2tqyi0TtgslAqA7S3Uu361R8oEGT24pGgf4cov0NxluFq6sxzsaFDngAbGNN
	 Zwg41zTkvnfxV//sndSvH7qpnG2G1cFT9lca1WGhcWkPRtWTmTtJtYZywShxYWauEm
	 XCFnRLnYrUYgOb/JeAKNO5MqeXu8x666GWAxPuFjx+hxgSZL3FjzKbsVLPe2LFmOMe
	 hIVr82GfiZrQJmxHIJuZP3oOsk6DC8fFKaTq+LNoc3dqzYrKLRCYLfWn8pF0LgPye2
	 ZmYii46Bki8fZ4LClgbYLSuaG0uY0cT1h/G5nD/xHaoD+P/B72nse40Gv5AQ/v9Cvg
	 QQFhv1HkqgrVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D7CD4F54;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:15 -0700
Subject: [PATCH RFC 03/12] Documentation: KVM: Consolidate notes about
 kvm->slots_lock and irq_lock
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-3-4fe8b602ff47@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1205;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=5xqYuflg/lHRaHVhIbofzsJqCQI4L326JDxGJuO8b0U=;
 b=/bIlnjfndGdNS+ll2dxYYvqLLoNppW84HDwXhvbpWFF04ZPlHUMWp75WsSLCcKYSYWt61B5P7
 mXli/FQOdC4BvZ0ynYtyfQjBM8Q6lsysXNUKDjZXn5ui6jUMED+c4jb
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Move the detail about ordering between kvm->slots_lock and kvm->irq_lock to
where the two locks are first mentioned.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 1e8cbbe3ba706..67dd2066f6d98 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -21,12 +21,11 @@ The acquisition orders for mutexes are as follows:
 - kvm->lock is taken outside vcpu->mutex
 
 - kvm->lock is taken outside kvm->slots_lock and kvm->irq_lock
+    - kvm->slots_lock is taken outside kvm->irq_lock, though acquiring
+      them together is quite rare.
 
 - vcpu->mutex is taken outside kvm->slots_lock and kvm->slots_arch_lock
 
-- kvm->slots_lock is taken outside kvm->irq_lock, though acquiring
-  them together is quite rare.
-
 - kvm->mn_active_invalidate_count ensures that pairs of
   invalidate_range_start() and invalidate_range_end() callbacks
   use the same memslots array.  kvm->slots_lock and kvm->slots_arch_lock

-- 
2.54.0.823.g6e5bcc1fc9-goog


