Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628854;
	b=E3jAf0FM8Fx78ukgL4NS4U34PJ9Nvy5vhseLL8q1bNQc+n4AsM8XslezWMtH4D7n2wfv
	 Q7A7N3CLo3RKd4m5q55CYl5lm2zohbzF0LPcEdz/XNdPOodm9itEy6Y2Tz/LoHV7O7+TH
	 ga//Jdpk+SLRPfwIkj333H2hfeEjpT09PFWtWyiRDbX9RYKH4X9sR7kL8FK8QRsBic+CI
	 VISnvTy2jC7wkI43V13M71JxayRDuZvSF78w+Mbpyyop5cB+Ze6ekuwoNd+Sy+jLcTUvM
	 Na06mWiFhQZluAqR/fU43qvgxsj50ItD4OLGcERsDheGD33r5d9z9r708ZupX6hB4Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628854;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ssw5USA6kTJR2rczz2n//qjSi6PfjV55B6pl9u5yEdU=;
	b=vq5Q/K/ptb4RLsVHxdSmjRVMhArLL7v2CRI3D/ffGDBaKtXYRsA3BxifjM9oKzjQmOde
	 61BY8qqGd6Rc907ZfaC+OtAewr/opoJPx5HOEevZFb6py/hhtw8xlHQRwm34B4CM+3uj6
	 QOk7eyEkmMcjvOymWRwX6chM1mixs1iCsREgs7+p7CSogW1YWMic9E1JLUuWBYwCxiT4z
	 pmKJ1F92cMgNeO25ATJkgouOD7XkiXZPD4nNJnBNYG+nmwyyoXhHQGKPbeIHxf9eDYivr
	 MNTsPQQlByeGaV++tECukjpx+P7AlgVuiewN+pRmjlhJMki0kE9PSAh9Ck9+HVN9GeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JECrwoav;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FC60A3802;
	Mon,  2 Nov 2026 14:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8FC60A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JECrwoav
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F11D1691;
	Mon,  2 Nov 2026 06:14:10 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.58.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C8D3F59E;
	Mon,  2 Nov 2026 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793628853; bh=h6KBkcsp5DeEHH4D4E0W9F9SywHXfnWYy74THEiEa0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JECrwoavalTBUMpD5iZGLy7KhIDhV9iLSCAITQfYugg5FaFnqZsEqK7N88s7ONT6k
	 QaqgUlv/kAUKobC95yz2jAvIYsWeU7QyvXWEoy6w3fkSnL2jOTdgKnFk8V+o1duvPx
	 OjFZflVf90HEDK4mbOx81QYjdnyfGSP3q/ZFVIns=
From: Steven Price <steven.price@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>,
	linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>,
	WeiLin.Chang@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 09/11] KVM: arm64: CCA: Prevent memslot modifications after Realm creation
Date: Mon,  2 Nov 2026 14:13:00 +0000
Message-ID: <20261102141304.126883-10-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102141304.126883-1-steven.price@arm.com>
References: <20261102141304.126883-1-steven.price@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Once the Realm is created, prevent any changes to guest_memfd backed
memslots, as the private memory is provided by slots backed by gmem.
This will also be validated when we handle a fault for Realm Stage2 (in
a later commit).

Additionally, similar to pKVM, we do not support dirty logging or
read-only memslots.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/mmu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 51fda7b2ff7f..eb8c5f9e9791 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2862,13 +2862,28 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	    (new->flags & (KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)))
 		return -EPERM;
 
-	if (kvm->arch.vm_flavor == VM_PROTECTED_PKVM) {
+	switch (kvm->arch.vm_flavor) {
+	case VM_PROTECTED_PKVM:
 		/* Cannot modify memslots once a pVM has run. */
 		if (pkvm_hyp_vm_is_created(kvm) &&
-		    (change == KVM_MR_DELETE || change == KVM_MR_MOVE)) {
+		    (change == KVM_MR_DELETE || change == KVM_MR_MOVE))
 			return -EPERM;
-		}
+		break;
+	case VM_REALM:
+		/*
+		 * Once the Realm is created, we cannot modify any slots that
+		 * could be providing private memory. i.e., guest_memfd backed
+		 * slots.
+		 * TODO: Handle trusted device private memory slots
+		 */
+		if (!kvm_realm_is_created(kvm))
+			break;
 
+		if (kvm_slot_has_gmem(old) || kvm_slot_has_gmem(new))
+			return -EPERM;
+		break;
+	default:
+		break;
 	}
 
 	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE &&
-- 
2.43.0

