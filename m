Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859A5803B7;
	Tue,  8 Sep 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884611; cv=none; b=a1YnhgRJRK05ZkgpWgcYjRyjjWUNrptlOUlr6siTaaiFsodHpxd1r/1XyPM8oVaIg8XOd61QtIscRvdsXlsbBHiZRHkOl7+vAtI++jIz4pceCSPflFgk3fPKlKyPGCXTpZrWIPgF6XK7T8wVhMqxOXtBd+YVUuuRXtzf+cFYjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884611; c=relaxed/simple;
	bh=W2yWocIjX/1lSG41m89vduKUKYOsNpQW6LsSskrDhH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ujgsk6kPswaXca8LTqBhZfp8mqLog0s9bTQwZEbeg1sv9SC7BLVny3yEQdQ6us+BlagZXneNC87F5FcaNpks9KBEeWnA94vUiWXUTbnNksSqgh45AZOMgs/UmQp8I8jczeQn53EG+MertOP357uNtM+3gSYqu2B2+mTi+rt6XcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C/02/NQ7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C/02/NQ7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2DAF1477;
	Tue,  8 Sep 2026 09:23:24 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 356B33F7B4;
	Tue,  8 Sep 2026 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788884608; bh=W2yWocIjX/1lSG41m89vduKUKYOsNpQW6LsSskrDhH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/02/NQ71e7kEfL+DYbaJceFhyRvQa7eVvAYwvfxkW3wXxUNeydtcGDoxcGzimu2b
	 f0rnHpbKFLqCBQrtJ/a7dn+aEA3mMqvBmxQcYvLKLq/7ImxMPMkj1tY4SqXkxyEMEV
	 rLo3UfobC5k9KyJtN8fQpcyleSowUCWy8shC18nw=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	oupton@kernel.org,
	gshan@redhat.com,
	joey.gouly@arm.com,
	tabba@google.com,
	yuzenghui@huawei.com,
	linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	alpergun@google.com,
	fj0570is@fujitsu.com,
	WeiLin.Chang@arm.com,
	lpieralisi@kernel.org,
	enju.kohei@fujitsu.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v17 11/20] KVM: arm64: coco: Don't handle MMIO with no ISV
Date: Tue,  8 Sep 2026 17:22:14 +0100
Message-ID: <20260908162223.1683432-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908162223.1683432-1-suzuki.poulose@arm.com>
References: <20260908162223.1683432-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize the MMIO with no ISV handling to confidential guests.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kvm/mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index d1c3a352d5a22..bbcf52f01e912 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -168,14 +168,14 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	 * No valid syndrome? Ask userspace for help if it has
 	 * volunteered to do so, and bail out otherwise.
 	 *
-	 * In the protected VM case, there isn't much userspace can do
+	 * In the protected/Realm VM case, there isn't much userspace can do
 	 * though, so directly deliver an exception to the guest.
 	 */
 	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
 		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), esr,
 				    kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
-		if (vcpu_is_protected(vcpu))
+		if (vcpu_is_confidential(vcpu))
 			return kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 
 		if (test_bit(KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER,
-- 
2.43.0

