Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AE4E77F0
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609144; cv=none; b=qtuFzaS1AtvK1JyUP8e7d4pBi/Jk0xd7KGtZ+vibmIpF3Qr3/pgDiDAx1GA6+JAebx0v0SIm2LTu1Vz2hQV38KjivGBcBWQ8FVz4blLOTSBv3pyf6e0ZA9Gn5WYB0St85txqC0701ThWxp7nhEnPcLY/zwsCRmmyuQRFgon0vH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609144; c=relaxed/simple;
	bh=4/J0Nyoe1OYgfmPuqQeHxdHnDki4Fb0pleDZiROcdZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3b9Z/rsrmdaOgkBqxha2wYbAQKABKsjNjlZoEBPfcdNYdgSHmzLDkD1QjhKUjCVCpJlXWgG+eNBg1MRdUItYewZNRp8tKj4ODUCswyuOrvQuyT04YbaQEbxyaFMglLnvQ6baglu81R1cfBG90HIssYV5sVjAx32DvidgIP8T1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SsvceiRJ; arc=none smtp.client-ip=95.215.58.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SsvceiRJ"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4/J0Nyoe1OYgfmPuqQeHxdHnDki4Fb0pleDZiROcdZs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790609141; v=1; x=1791213941;
 b=SsvceiRJbFyX6mPSL0oOeT56sEHwbENj2tjz7Agj89GXhKICj5deuP+EJ7D+ucln/cWl0MIF
 HhBneBYyTdjTtjUNE+mwDIPzr7LFKBgWHLVbCv2cmpjvSdvwze6quNlxhHKCoqkRI7Nj1g7n2ie
 XlpsJJA6YzLMNrLtzR3VcyLc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de1ed31cb70c73c5;
	Mon, 28 Sep 2026 15:25:40 +0000
X-Mizu-Trace-ID: de1ed31cb70c73c5
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jing Zhang <jingzhangos@google.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/10] KVM: arm64: nv: Return a failed stage-2 descriptor read as a fault
Date: Mon, 28 Sep 2026 16:25:01 +0100
Message-Id: <20260928152507.2116110-5-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260928152507.2116110-1-fuad.tabba@linux.dev>
References: <20260928152507.2116110-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KVM walks an L1 guest's stage-2 tables and can't read a
descriptor, for example because the guest points a table at an IPA with
no memslot, it sets a synchronous external abort on the walk but
returns the -EFAULT from kvm_read_guest(). As with an invalid
VTCR_EL2, KVM then leaves AT S12E{0,1}{R,W} unretired, so the guest
retries it forever. On an L2 abort, KVM injects the abort and
returns -EFAULT from KVM_RUN.

Return 1, as the walk already does when it can't update a descriptor,
leaving -EAGAIN from a descriptor race as its only negative return.
The AT then retires with the external abort in PAR_EL1, which is what a
stage-1 walk records for a descriptor it can't read.

Fixes: fd276e71d1e7b ("KVM: arm64: nv: Handle shadow stage 2 page faults")
Fixes: 92c6443222ca4 ("KVM: arm64: Propagate PTW errors up to AT emulation")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index a67be19e73250..f9a2e50c0b567 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -304,7 +304,7 @@ static int walk_nested_s2_pgd(struct kvm_vcpu *vcpu, phys_addr_t ipa,
 		ret = read_guest_s2_desc(vcpu, paddr, &desc, wi);
 		if (ret < 0) {
 			out->esr = ESR_ELx_FSC_SEA_TTW(level);
-			return ret;
+			return 1;
 		}
 
 		new_desc = desc;
-- 
2.39.5

