Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D483DDAE2;
	Tue, 25 Aug 2026 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692806; cv=none; b=Y09O7O0pkhru7H+kXfS0QuUnsuYMNNCUGCwdMOnwnzHGw0fb7tLkKMe4xPVUgys9vuBbLHHgF7aLmYApfsSZUiHS3vfiXgQTD7F0UUE/lA3RQp9nDRicL5nvntYVnS8in+v0UzmL0tvp3JF3ledZjvnVZStTJZVj1CoXU8m3U0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692806; c=relaxed/simple;
	bh=70JDFubTVkBsDgJS+Q5x0sY6ZqnQo0abv+xo6mjXvqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fz9B6n+iRqD/R+Zrt2zkm4veVGXgq58rFwidIkyqrsBYNu9h+w2BgzUL287FTWzlqfEPkjpwTE75HoNaowLFYpkgkJyEywQqBulMZSwLpfz5w7dbc7vcoTNA4A2fnU/ttNO5fZzqfTtcN7093dxHc3iA3XCBpBiYs67kJJegWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=beO6AAYR; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="beO6AAYR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1787692808; x=1819228808;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=70JDFubTVkBsDgJS+Q5x0sY6ZqnQo0abv+xo6mjXvqY=;
  b=beO6AAYRCov8YWqDC+RW9ofg314O8L1K2b8ivxfvMFCCAwCbekwbvb9a
   +/L/toC7l9z40KTNH0P1/cjLqYYHlJ1JQ6NyLevs6+zNGuekc77SFUkB5
   XnDDWtKBDiLvOGGxwQGu5Rzti1uEcfKgV4Y5e6tjBWWjP1YTOaesjJx4f
   5BGnomEQsinm6vX6QNAYkWvjtjtP7n4eOL2nwXdZ3MfwbIwYPJfufY7dP
   deAz2OKKv7UAVzNel+a+KAvs17C66XJR9kY+W0R6ZDCXK71Oe3zvTPj8Z
   d5a80znLO5hGEmvRIXx7PVHqQqpWnmDxLZJsacPpGnMPGhjwyVgu2vwar
   w==;
X-CSE-ConnectionGUID: rrOaXi9cSk6XiNLyM/fgqw==
X-CSE-MsgGUID: P7yzCZzmQ4myUPUgsV9Jtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="252521162"
X-IronPort-AV: E=Sophos;i="6.25,243,1779116400"; 
   d="scan'208";a="252521162"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:18:58 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 5FE801C000DA;
	Tue, 25 Aug 2026 21:18:53 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (unknown [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 10B091C2FB95;
	Tue, 25 Aug 2026 21:18:53 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTP id 358C51801C03;
	Tue, 25 Aug 2026 21:18:47 +0000 (UTC)
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Date: Wed, 26 Aug 2026 06:18:35 +0900
Subject: [PATCH 2/2] KVM: selftests: arm64: Add 52-bit VA guest modes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-arm64-52bit-va-v1-2-14ec98211363@fujitsu.com>
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
In-Reply-To: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
 Takayuki Okamoto <tokamoto@fujitsu.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787692718; l=4987;
 i=itaru.kitayama@fujitsu.com; s=20260825; h=from:subject:message-id;
 bh=70JDFubTVkBsDgJS+Q5x0sY6ZqnQo0abv+xo6mjXvqY=;
 b=ZHsdORZZInAmcydx9m1zTcNgmLZVUmMpigF0GjTpwFoRUApwYAlxNWL1Iyxbgd3+bkTV5CIKA
 TM139YCgkS+Dh7GS1EiU69FwFgnlB+Z4dMFUe3eAH5TfkH6jDxrt9oy
X-Developer-Key: i=itaru.kitayama@fujitsu.com; a=ed25519;
 pk=g9bTnr9giRP7JwNSZHy+OMLQZBEUtSE9tUnXso0hH1Y=

Add P52V52 guest mode IDs for the 4K, 16K and 64K translation
granules, along with their mode descriptions and parameters.

Advertise the 4KB and 16KB modes when the corresponding granule supports
a 52-bit IPA, implying FEAT_LPA2 support. For the 64K mode, also require
52-bit VA support.

This makes the 52-bit VA configurations available to KVM selftests now
that the arm64 page-table code supports 5-level stage-1 translation.

Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Reviewed-by: Takayuki Okamoto <tokamoto@fujitsu.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h    |  3 +++
 tools/testing/selftests/kvm/lib/arm64/processor.c |  2 +-
 tools/testing/selftests/kvm/lib/guest_modes.c     |  5 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c        | 11 +++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 04a910164a29..9040281c0992 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -184,6 +184,9 @@ enum vm_guest_mode {
 	VM_MODE_P52V48_4K,
 	VM_MODE_P52V48_16K,
 	VM_MODE_P52V48_64K,
+	VM_MODE_P52V52_4K,
+	VM_MODE_P52V52_16K,
+	VM_MODE_P52V52_64K,
 	VM_MODE_P48V48_4K,
 	VM_MODE_P48V48_16K,
 	VM_MODE_P48V48_64K,
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 9108e14a9b5b..bcdf670c9eb8 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -46,7 +46,7 @@ static u64 pud_index(struct kvm_vm *vm, gva_t gva)
 	u64 mask = (1UL << (vm->page_shift - 3)) - 1;
 
 	TEST_ASSERT(vm->mmu.pgtable_levels >= 4,
-		    "Mode %d does not have at least 4 page table levels",
+		    "Mode %d does not have >= 4 page table levels",
 		    vm->mode);
 
 	return (gva >> shift) & mask;
diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
index 7a96c43b5704..4f121e2987e9 100644
--- a/tools/testing/selftests/kvm/lib/guest_modes.c
+++ b/tools/testing/selftests/kvm/lib/guest_modes.c
@@ -21,10 +21,15 @@ void guest_modes_append_default(void)
 	{
 		unsigned int limit = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
 		u32 ipa4k, ipa16k, ipa64k;
+		u32 va;
 		int i;
 
 		aarch64_get_supported_page_sizes(limit, &ipa4k, &ipa16k, &ipa64k);
+		va = aarch64_get_supported_va_size();
 
+		guest_mode_append(VM_MODE_P52V52_4K, ipa4k >= 52);
+		guest_mode_append(VM_MODE_P52V52_16K, ipa16k >= 52);
+		guest_mode_append(VM_MODE_P52V52_64K, ipa64k >= 52 && va >= 52);
 		guest_mode_append(VM_MODE_P52V48_4K, ipa4k >= 52);
 		guest_mode_append(VM_MODE_P52V48_16K, ipa16k >= 52);
 		guest_mode_append(VM_MODE_P52V48_64K, ipa64k >= 52);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fdae1e3..3fbc5b0d75ff 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -195,6 +195,9 @@ const char *vm_guest_mode_string(u32 i)
 		[VM_MODE_P52V48_4K]	= "PA-bits:52,  VA-bits:48,  4K pages",
 		[VM_MODE_P52V48_16K]	= "PA-bits:52,  VA-bits:48, 16K pages",
 		[VM_MODE_P52V48_64K]	= "PA-bits:52,  VA-bits:48, 64K pages",
+		[VM_MODE_P52V52_4K]	= "PA-bits:52,  VA-bits:52,  4K pages",
+		[VM_MODE_P52V52_16K]	= "PA-bits:52,  VA-bits:52, 16K pages",
+		[VM_MODE_P52V52_64K]	= "PA-bits:52,  VA-bits:52, 64K pages",
 		[VM_MODE_P48V48_4K]	= "PA-bits:48,  VA-bits:48,  4K pages",
 		[VM_MODE_P48V48_16K]	= "PA-bits:48,  VA-bits:48, 16K pages",
 		[VM_MODE_P48V48_64K]	= "PA-bits:48,  VA-bits:48, 64K pages",
@@ -231,6 +234,9 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P52V48_4K]	= { 52, 48,  0x1000, 12 },
 	[VM_MODE_P52V48_16K]	= { 52, 48,  0x4000, 14 },
 	[VM_MODE_P52V48_64K]	= { 52, 48, 0x10000, 16 },
+	[VM_MODE_P52V52_4K]	= { 52, 52,  0x1000, 12 },
+	[VM_MODE_P52V52_16K]	= { 52, 52,  0x4000, 14 },
+	[VM_MODE_P52V52_64K]	= { 52, 52, 0x10000, 16 },
 	[VM_MODE_P48V48_4K]	= { 48, 48,  0x1000, 12 },
 	[VM_MODE_P48V48_16K]	= { 48, 48,  0x4000, 14 },
 	[VM_MODE_P48V48_64K]	= { 48, 48, 0x10000, 16 },
@@ -298,10 +304,14 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 
 	/* Setup mode specific traits. */
 	switch (vm->mode) {
+	case VM_MODE_P52V52_4K:
+		vm->mmu.pgtable_levels = 5;
+		break;
 	case VM_MODE_P52V48_4K:
 		vm->mmu.pgtable_levels = 4;
 		break;
 	case VM_MODE_P52V48_64K:
+	case VM_MODE_P52V52_64K:
 		vm->mmu.pgtable_levels = 3;
 		break;
 	case VM_MODE_P48V48_4K:
@@ -322,6 +332,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	case VM_MODE_P48V48_16K:
 	case VM_MODE_P40V48_16K:
 	case VM_MODE_P36V48_16K:
+	case VM_MODE_P52V52_16K:
 		vm->mmu.pgtable_levels = 4;
 		break;
 	case VM_MODE_P47V47_16K:

-- 
2.43.0

