Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45344395242;
	Thu, 26 Mar 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494753; cv=none; b=fNJNZ3vkK7RwMWf3vJWAGsKVMrCwVweKMu/UGWU2k+dkvxKGodfXlRr5flgndPSXmJc303cP3g3fhup7PIk8OCxl/ABWU3129Dm0D7WyCKTACEiTgKYoBU8S8axpQTrEF4OXdFApcW/ybLk4MAKZQpYEV/yd+0FA99TGz9+SrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494753; c=relaxed/simple;
	bh=CoszQ3TdgQ1r2712RQT7zIQRT8HfDyPtetdGGniT0sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+hHryPr0mcDUsjWTRUC6SbBOqIdcsG4Eg8VZh8gg4AFoKCLjBZGNGGS1YJVv7Hh8nLk14u0S93UcUNuDeRZ0Z8Es0rg3jNXA5zVZfSe0p0UlH3BpoDOmV34WkIkLkyeqlCLXdyhOh9BCZTnXSDePvwIx24R8FyDPgCknpcPlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWbe+oxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWbe+oxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2DDC2BC9E;
	Thu, 26 Mar 2026 03:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494753;
	bh=CoszQ3TdgQ1r2712RQT7zIQRT8HfDyPtetdGGniT0sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWbe+oxJKd86xyipvXFq2hagY0Xrq+T2h6VlUm+kvdKZ2jEhwTYe2LQZMw5vgicXC
	 i073RQcDQHyvyx1Gsclt1/pI2ufv5lDhn8aa1eMrn+aAymnBI7hT85KKS7EwIHt/ee
	 t9Q0QOw3uhb035AuuC/kXUGl1r8Lt+RDzTDeGOCHizlMOAbC8tG70RYTL9jFd9lBiK
	 7h73gHuHh/NcnFDh2n8tUo3tWzeorcyv9E+s+3uCI781ddIknTdME3JnCqR/kJDMj+
	 i62Fqfjx5ABFX7WUGLSmcIhWkX+5Cl4LaM8E/G+38MSJ4WlHyIWhKidBjbOQBwGcbl
	 u2y8yAhsCFDNw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 5/6] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU
Date: Thu, 26 Mar 2026 03:11:49 +0000
Message-ID: <20260326031150.3774017-6-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326031150.3774017-1-yosry@kernel.org>
References: <20260326031150.3774017-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Mattson <jmattson@google.com>

Now that KVM correctly handles Host-Only and Guest-Only bits in the
event selector MSRs, allow the guest to set them if the vCPU advertises
SVM and uses the mediated PMU.

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index cc1eabb0ad15f..3c04e8da24d33 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -207,7 +207,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
+
 	pmu->reserved_bits = 0xfffffff000280000ull;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
+		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
+
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-- 
2.53.0.1018.g2bb0e51243-goog

