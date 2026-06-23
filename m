Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3337C364049;
	Tue, 23 Jun 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206166; cv=none; b=D8N1uOB9iSkGRaxSzGeXSKwgbSOrX1sIHA9bs6unsiwB0DzGFOTyv8hq402ncCrMjYdu0/BlVKkxpBu1jw0e8Ljaionusyqik4E5L03lFIzwsQVxpHUpYQ6Y51w8Jrxg6u361pce1Iv9m2RYb1oeXDDtwUmFhSZ/YwXAClPKhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206166; c=relaxed/simple;
	bh=aOIiXKA/SFm7+njc7xkF99K3wosAUWatMCuT5f/7i50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZWCjEmrZd4ZC1kYUIYer5fu53QfSLbSOKCxyWerE7kZGcU3lZG4l+3EJqhF5ixNm1cMA1WNlwheiQWgaMMPrcf6vpD36dWBvrqw7GXD0VLPxqM+m2L7AAU1mtaNC8H+zl/gnUx1A1Z909aJsliyCCuM/yFF1kCN343IW0JP65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af4fc500cc95bb0c16cd4e45.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cc95:bb0c:16cd:4e45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6B06F203D42;
	Tue, 23 Jun 2026 11:16:03 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 4/4] kvm: sev: Acquire a writeable page reference for CPUID pages
Date: Tue, 23 Jun 2026 11:15:56 +0200
Message-ID: <20260623091556.1500930-5-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623091556.1500930-1-joro@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

When the PSP checks on a user-provided CPUID page fail KVM will write
back the detailed error information to the user-provided buffer.

Make sure this buffer is actually writable to not write the errors to
a read-only page.

Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dab8109edf26..5fd08d34be3f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2415,6 +2415,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	struct kvm_memory_slot *memslot;
 	long npages, count;
 	void __user *src;
+	int write;
 
 	if (!sev_snp_guest(kvm) || !sev->snp_context)
 		return -EINVAL;
@@ -2475,7 +2476,10 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	sev_populate_args.sev_fd = argp->sev_fd;
 	sev_populate_args.type = params.type;
 
-	count = kvm_gmem_populate(kvm, params.gfn_start, src, npages, 0,
+	/* Acquire a write-reference for CPUID pages as kernel might write to it */
+	write = params.type == KVM_SEV_SNP_PAGE_TYPE_CPUID;
+
+	count = kvm_gmem_populate(kvm, params.gfn_start, src, npages, write,
 				  sev_gmem_post_populate, &sev_populate_args);
 	if (count < 0) {
 		argp->error = sev_populate_args.fw_error;
-- 
2.53.0

