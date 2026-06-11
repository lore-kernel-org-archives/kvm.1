Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1F3F0774;
	Thu, 11 Jun 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181364; cv=none; b=fWgN8VvCHKQFpUXp9q65L8LKBDRL9QqlKGEHttODtoSgTZtTjBHZTgDVwY6onugqAC9xxVGdtQ+Y5azbN4rmHCdnT4ow3yC0oUDoXJzwmtOOOZ8bgp9GOen/14Yo8jaMS/WCvMOCjrPurLjjjEgLo5Zk8hzn8k+Xd2P0fmeXvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181364; c=relaxed/simple;
	bh=jMaQ6RJAlSqQT0KLwTVXvhwEfFdMimwOxBl9VsKCxIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSQB7+33q+Pw+cDOmq5DOdNXgEpKsvmFbrbTzk59qWnh/ETSBDAJ3aSRjvOENO81CaqfBXK+8PJslWkV/kwTWrM40DYqmHNt31056pi7VC7+RH3iv4J1atZaYpAdtYPBMJZBT41JyyMkKec5dvE5hDxyPbykruBu0izbDYsWyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 796E61C0ED1;
	Thu, 11 Jun 2026 14:36:00 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 0/4] KVM: SEV: Support direct setting of VMSA for SEV-SNP guests
Date: Thu, 11 Jun 2026 14:35:24 +0200
Message-ID: <20260611123528.572255-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Hi,

Here is a set of patches to support the VMM to provide a VMSA directly
to KVM which will then be used by the BSP of the SEV-SNP VM. The
use-case is IGVM loading, where the IGVM file contains a VMSA image
which must be loaded into the initial memory image of the VM as-is to
guarantee the expected launch measurement.

The first patch re-works guest-VMSA handling and streamlines the state
handling to make it more clear and maintainable. That patch accounts
for the biggest part if the changes.

I have tested these changes together with the planes patches and
COCONUT-SVSM and can confirm that the launch measurment is correct
again with these changes.

The changes are based on previous work by Roy Hopkins[1].

Please review.

Thanks,

	Joerg

[1] https://github.com/torvalds/linux/commit/e00e081276b2cd9f1400ec5b1a9cd97f8b5c4d58

Joerg Roedel (4):
  kvm: svm: Streamline VMSA setting for VCPUs
  kvm: svm: Defer VMSA allocation to LAUNCH_FINISH stage
  kvm: svm: Support guest-provided VMSA for launching
  kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE

 arch/x86/include/uapi/asm/kvm.h |   1 +
 arch/x86/kvm/svm/sev.c          | 419 +++++++++++++++++++++++---------
 arch/x86/kvm/svm/svm.h          |  32 ++-
 arch/x86/kvm/x86.c              |   1 +
 include/uapi/linux/kvm.h        |   1 +
 5 files changed, 337 insertions(+), 117 deletions(-)

-- 
2.53.0

