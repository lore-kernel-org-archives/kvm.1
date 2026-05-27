Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C58436374;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896004; cv=none; b=XtIZURHoalEuMafUD1y79sptHM4/IL5oLd5pKZtAac6/dyQlWtJvq/qZM3EbIpKBsJFgvNVHdSrF9q07a9UwFk3TYeXj/519IQeHfC18Qrj3yoqOiFxAAxzQCt73jRb/QcvUvGXyRNYQddmrjpkNj27N/CeQIc1Ji3O57XSv0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896004; c=relaxed/simple;
	bh=nVpl3TVZQU9iG/8SJ8PbEKLaQViBegpkV2M01+wMc30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFXNkaHAYc5q3w6wfeapfT+bsiLcA5EPAU21aXmCa/WHWDCeUMfRN691bBLlnSZjJnVy9ykukOQgVKne9YwlUsRq4I0LIFVcp0+VygNcxET6bHvN4XkIEKM1pFi99BP0gpCh+rBh0hd3E9E2Ya8LJdSAXbU7wfrQVAsdAOqKfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H43ckgw1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H43ckgw1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5489C2BCF6;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896002;
	bh=nVpl3TVZQU9iG/8SJ8PbEKLaQViBegpkV2M01+wMc30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H43ckgw1K/X/LMmGirCLu6olwyKN+3u+/yP/z6bq4Ct4qvvq94RCjO4PnMuw80M68
	 8djH78hYQ/6RueZeAlOGbX/16eqZVSzD6saRHNkwrq5RgAfLSBcybMpNwVtSULUf00
	 p4iAOaCi1NFHMkYm9rAg0cDrDyfjyQVIs6FJC3oZdgg4LbiCo+7Il/17eSinXotCrL
	 jBqtiGCtO1xpXV2OxG/7eZgVCon6zt6es2Xn/VF1t1m0DG8/8cQsNzraqRvYxd0y7G
	 oziRXR42K0miODftx0GpKUUz2adWvK/lDhtgoD8kIhYjikZSvRJUdUEx5x0XEj9IFb
	 u+EENixrJHRgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8C4CD6E45;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:16 -0700
Subject: [PATCH RFC 04/12] Documentation: KVM: Turn - into bullet point
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-4-4fe8b602ff47@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=909;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=CVJlxPT0bvHHOwHsW6J5heOXwU/ZjkdVD+6fUMJnWDE=;
 b=KkPJHF+eM7NDmHDSEhDOiOBWhwesjg7rIQXxnzpWgTB9I02vfYnNi5BaXX0a183XJ1mq7TDDx
 YhG5/AGb4N7Df+nmEUADJYfEvIEoR/I+w01Jm8766xS2x9bSTAeKxa+
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

For the :Protects: section of kvm->mmu_lock, a missing space causes the -
to render as a literal - instead of a bullet point. Add space to make it
render as a bullet point.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 67dd2066f6d98..e349c2cb94943 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -283,7 +283,7 @@ time it will be set using the Dirty tracking mechanism described above.
 ^^^^^^^^^^^^^^^^^
 :Type:		spinlock_t or rwlock_t
 :Arch:		any
-:Protects:	-shadow page/shadow tlb entry
+:Protects:	- shadow page/shadow tlb entry
 :Comment:	it is a spinlock since it is used in mmu notifier.
 
 ``kvm->srcu``

-- 
2.54.0.823.g6e5bcc1fc9-goog


