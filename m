Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EE43636B;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896003; cv=none; b=doP5rFdUWsptRpfDUsMptXiKI8NudCsN1HLZUBZdDKSTVx4kSTTYksOOONzuxjbeRodKtXy/T0eLISEe2X5Pr7qW1J0LqgIJy5FdPBhYDFIojjAshEBioOGvpQdk/kkkovvjdSGPRcnUuxdMVPgdp3ccnW0qLFUYAZOBKCut/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896003; c=relaxed/simple;
	bh=vV27adI3mRPVfr/4KYQaQlitiyDAtNqd/scHlo4erV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuv/UHelnuqkSLtyz5m8TnZQKXnU5kBb5Vo/s8aHIivuxrh2DfPNjAMG6B+A34DYETld50nM2KAtsJSdHJQSFINYNCI4WoCQpKv1tfBDjlpw9mbA0sku7XCXgUzSrXIe6lD89wse7HotqW5RIYXpHdpeIZhh76uGH/LFWNQbf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoxBHs0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoxBHs0I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B40DC2BCC9;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896003;
	bh=vV27adI3mRPVfr/4KYQaQlitiyDAtNqd/scHlo4erV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QoxBHs0I37EAn5nmfw28S+JbCmuHQCWJ+Trqa0V+r5G43t3SX/+IjftyWzp+5EWzH
	 1yE5K0yZaoAP38uxNdtsy6zbDNJ1zFP0iOscUFxy/t0Uz1nV6GWydGMKUs1xwI7lA4
	 IQQ1YYlAJDWi3JILliRZ2ge63nXRJknnH6/aN/F7UzfQZYAJhI/NjG/AZOYuuJN661
	 iDDwExYioGUoePVC+fdoadJlS0xZbGhyZQ8E+u6qQ12zFW0r+irKQlbSGTnMfho+tO
	 OmrlMiLziHdh3A+8owGmvPmw6kqtsomkUAlFDXvTAb1Xfxxt7X5xn3QuJBujcY08Ea
	 54GGiEcgsMPLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132AFCD5BD0;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:22 -0700
Subject: [PATCH RFC 10/12] KVM: guest_memfd: Clarify comment about
 gmem.file vs kvm->srcu
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-10-4fe8b602ff47@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1303;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Tom9j4Egg9w53w5LFUq+AuZPef+PZPDtSajFqVBtT2Y=;
 b=zmWHHdOBn2VUHo/3MFGM+UFpeHWLnLuk5bbX+cVcR6fbgTn96QkVjabkLihMX7tye0SnmS6Tj
 4yHcgDc5PfsADjhgoYLEkOnUJTwyvLLyJX53hXSzWi5YZ0QcGrBfAyn
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Clarify the existing comment about synchronize_srcu() and
kvm_gmem_get_pfn() to provide further context. Explain which
synchronize_srcu() prevents races with how kvm_gmem_get_pfn() is used.

Also point reader to documentation for better understanding.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b28..f2218db0af980 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -711,8 +711,13 @@ static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
 	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
 
 	/*
-	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
-	 * cannot see this memslot.
+	 * This is called when memslots are updated, after the old
+	 * memslot container is no longer in
+	 * use. synchronize_srcu(&kvm->srcu) was called there, so
+	 * kvm_gmem_get_pfn() from KVM's guest fault handling cannot
+	 * see this memslot. See Documentation/virt/kvm/locking.rst
+	 * for more information about kvm->srcu and the memslots
+	 * container.
 	 */
 	WRITE_ONCE(slot->gmem.file, NULL);
 }

-- 
2.54.0.823.g6e5bcc1fc9-goog


