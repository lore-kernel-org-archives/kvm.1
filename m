Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3D0363C59;
	Tue, 23 Jun 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206166; cv=none; b=UBlOL58wx6OhMa/AtO9yoLSHeP8sNmxNIiXXNJE75UL9q1Se43rGX7ConFF7XdQSX5G4WnHjfAt4TvOUqZX7R6Pxu8TyqhIlh0B1/nUE2BG3hXB5r4w1S7m/4MA5zBg/DG8pDoC6OyA6BpUuJ6wOTgRJljJLnX0wEMc2fyb5Zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206166; c=relaxed/simple;
	bh=SgieSUQKIZcxPKT1efnQHDrcznVjNoLVpORDYa66UsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv2uZnMv/h9P6W/acAkhok2yFc+BAuzzn3dRwFHxz4h37eAIGbi35kvjuRPCnRKJiyum/ImtLcdeWnqhGKCXIn0eFgr3i8sLzWGtpLHAij3qYZgLFj0EhiyPVSI+zM784HwS9LUHPM7sqbANkmzETl/73TaGz/E0x8fcAKhqTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af4fc500cc95bb0c16cd4e45.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cc95:bb0c:16cd:4e45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 049EA203D3F;
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
Subject: [PATCH 1/4] kvm: sev: Fix user-space triggerable WARN_ON on snp_launch_update path
Date: Tue, 23 Jun 2026 11:15:53 +0200
Message-ID: <20260623091556.1500930-2-joro@8bytes.org>
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

Sashiko reported on an unrelated patch:

  [Severity: High]
  This is a pre-existing issue, but can a host userspace process trigger a
  kernel warning by passing a NULL user address (uaddr = 0) here?

  If params.uaddr is 0, src becomes NULL and passes the PAGE_ALIGNED(src)
  check. kvm_gmem_populate() skips fetching the user page and passes
  src_page = NULL to sev_gmem_post_populate().

  That function then unconditionally evaluates:

  WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO &&
               !src_page)

  Since the type isn't ZERO, won't this allow an unprivileged user to spam
  the kernel log?

The assessment is correct, so check for this condition earlier in the
snp_launch_update() path to avoid the WARN_ON_ONCE.

Fixes: dee5a47cc7a45 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..41dcba5180ca 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2438,6 +2438,13 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!PAGE_ALIGNED(src))
 		return -EINVAL;
 
+	/*
+	 * Make sure user-mode did not pass NULL as src with
+	 * type != KVM_SEV_SNP_PAGE_TYPE_ZERO.
+	 */
+	if (src == NULL && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
+		return -EINVAL;
+
 	npages = params.len / PAGE_SIZE;
 
 	/*
-- 
2.53.0

