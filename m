Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B342848D;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896003; cv=none; b=UULM7JffvnuNdPNnIZnC0zjTXLR02wGDItC1G439XN1+1G3/mBHY9oPGAdaonj4po2R48Rc4r8CfGrxgg9aUXS7qZ+Mc/LY+5hHM4qWyozXO/uTWLABPw7coQFGoFwOrhX4YY8IRnWRv8/ha2nfkQ86DDljPCYZNcSoEjtOw/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896003; c=relaxed/simple;
	bh=1p81ZNBxNEloWsHcf8g42JPwNVdcqsmbhHDMBs5xtuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWBxhAFGI96jn/PWynB4Q+WQQnVD2SYaF6z+w0yRIV2aT5+Ue5nbXnyl8USzgaAEUvC8UzUGPJM0A4BuD5c1RKkI+UyW61/imPwblWDtNzAn9fwYSNICuU3nBHfrn+ZO7xyYuJqG5i2VEoDWKePo9Np6GFxlbVb+vluA6KGdb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/Plho0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/Plho0y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B359C19425;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896002;
	bh=1p81ZNBxNEloWsHcf8g42JPwNVdcqsmbhHDMBs5xtuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b/Plho0yw5DWCIGekeE4FNy/iu9QxKChox6T9jgJJ6SInBA5D8AB+tei6AV0Hh1Dc
	 mVOWSlbsk0IpuLxTSg0XT2yi2Drme8jLzd1wJNo7vkiNLKDR4sAXM5+xn+BKrxd6/J
	 YO4zZRASiGJNQmJIpdG+ZRTyiD4WJbgdBHQoLIKpXY5fiaG61bBT/kov6UTKIHUpPx
	 g3l52lXZRksCvPrcWVl+xus0dU9vzPimpsWLSFoqzIL/tpUUFm7d0McRXA7iYbHN/x
	 N4rE+Fy8kP4k0DD3coI+osifn8/+Z1NbjLy8NSWOqZY3VYw+Z0/lIX8I4TMPv7+wR6
	 WeNQDE1a+c6yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C12CD6E41;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:13 -0700
Subject: [PATCH RFC 01/12] Documentation: KVM: Elaborate comment on
 kvm_usage_lock
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-1-4fe8b602ff47@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1798;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=1hH8Q0hBBnzb0IjHg5TBjPkm0Xu0Pb4r5XTBzAPfiqY=;
 b=fU+6+4GQIUI8X/J/BwojcC/g3/dZq9Cy1AdwRV6CsRk1oo420RJtTrBz08gADa92ThBWvtsKp
 1qPdl0HarVvDiP2oochMmaqZ8lzASO49loGKy3NHXUUaWuDuMpMpnn4
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

The original comment talks about cpus_read_lock() and kvm_usage_count, but
doesn't explain why they are related.

Elaborate comment on kvm_usage_lock to provide more context.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 662231e958a07..5564c8b38b9cc 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -248,8 +248,23 @@ time it will be set using the Dirty tracking mechanism described above.
 :Arch:		any
 :Protects:	- kvm_usage_count
 		- hardware virtualization enable/disable
-:Comment:	Exists to allow taking cpus_read_lock() while kvm_usage_count is
-		protected, which simplifies the virtualization enabling logic.
+:Comment:       ``kvm_usage_count`` serves to deduplicate hardware
+    virtualization enabling and disabling requests from different VMs
+    being created.
+
+    Hardware virtualization enabling/disabling requires taking
+    ``cpus_read_lock()``.
+
+    ``kvm_lock`` used to also protect ``kvm_usage_count``, but other
+    parts of the Linux kernel holding ``cpus_read_lock()`` need to
+    call into KVM to ensure that VM state remains consistent with the
+    host's state. For example, when the CPU frequency changes, KVM is
+    notified. ``kvmclock_cpufreq_notifier()`` takes ``kvm_lock`` to
+    iterate ``vm_list``.
+
+    To decouple these, use different locks, ``kvm_lock`` for
+    ``vm_list`` and ``kvm_usage_lock`` for enabling/disabling hardware
+    virtualization.
 
 ``kvm->mn_invalidate_lock``
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^

-- 
2.54.0.823.g6e5bcc1fc9-goog


