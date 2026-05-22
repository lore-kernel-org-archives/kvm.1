Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41002352F87;
	Fri, 22 May 2026 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489971; cv=none; b=pkT0z5eohv4uwvnwSH2cL/E1vyrZ7N2HyR89DxMkjaTgxatWNOrEagxWUzR9sIdjzn50eb8xZ5qvl0QyaU/UQ2fR9pEbwRjpCf+exE8qSBGVIwyoByeZm7IyA8kNUs8YilautJKxRwOHqcRfX6BwlUmPEAAGpV8ddCYtvyPpslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489971; c=relaxed/simple;
	bh=GQD1jANZIEUF0wkpByeG4W13XuLx6L3WkE4M7CHEPjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aj+HcAhpIEqIqtSClBoSYBt5yDydHXhMCruzvcMe4O/DXnGxT59uy0nefOh8+C8uyKfSFjqiRsJeo7ZM3Kg+rNAgubzcn0oBdZao/0rTPk+PHF6kKITDwdfaTmUm46TwE0tvQxJcGmQkKVs0frgj2qpFnhagrVTFZvt3djKA39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iThYzAxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iThYzAxu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DF4BC2BCF4;
	Fri, 22 May 2026 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779489971;
	bh=GQD1jANZIEUF0wkpByeG4W13XuLx6L3WkE4M7CHEPjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iThYzAxuPLvLXhyoySLZWIK5GekVA5X0j1kuQuMeqI5Lbjm5GyLYkNPIzUx2DblEX
	 LrqqrUTLzKEDRkhvZIN9psWJsDqiKubLpW8S7EdSO74O2BJFtMmK0Umtkmdf99+NKg
	 dsCOMEDoSUUZO8N/mqklqIDAUR+0lZjxUXEYtKarvNeeVeHsl0DRGxglsit6Gu7jIp
	 /o+DrfMhRBiMPuBM4yzSv5n2YFp914DycsKmlFfGlceXda+J0cxnwZAvFElb8AJ8W7
	 5+0Q34TUveCYie9LHjGrhqqHMaW3D9PsK/53Gspyh5CmB7KKEtNOkYSNO999NUy/yv
	 0YOAiZhmJZdZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DBCCD5BB8;
	Fri, 22 May 2026 22:46:11 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 22 May 2026 15:46:09 -0700
Subject: [PATCH v2 4/5] KVM: SNP: Fix kunmap_local() unmapping order
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-fix-sev-gmem-post-populate-v2-4-3f196bfad5a1@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779489969; l=1450;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=VX9xGFMfWmL5HGm1mHjTtC4xZdzEbomljfer0iqVaEQ=;
 b=FqRXMgrQiAATjkjhq9UmxaSoOh/KdH1pj4wJC6/RV9QZBUUylr1KVoYNH10wJ+vMYjySGY31T
 vsuLxRE2R4rB46qc+v+yCu6HlrhMPWNheqkAo+RrKYcFSmJtFBBLGKU
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Mappings created with kmap_local_page() or kmap_local_pfn() must be
unmapped in the reverse order they were acquired, following a LIFO
(last-in, first-out) stack-based approach.

In sev_gmem_post_populate(), src_vaddr is mapped first and dst_vaddr is
mapped second. The current code incorrectly calls kunmap_local() for
src_vaddr before dst_vaddr.

Swap the kunmap_local() calls to ensure the mappings are released in the
correct order.

Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2f254c447923e..dbf75326a40f4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2360,8 +2360,8 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
 
-		kunmap_local(src_vaddr);
 		kunmap_local(dst_vaddr);
+		kunmap_local(src_vaddr);
 	}
 
 	ret = rmp_make_private(pfn, gfn << PAGE_SHIFT, PG_LEVEL_4K,
@@ -2396,8 +2396,8 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
 
-		kunmap_local(src_vaddr);
 		kunmap_local(dst_vaddr);
+		kunmap_local(src_vaddr);
 	}
 
 out:

-- 
2.54.0.794.g4f17f83d09-goog


