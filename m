Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01B34E744;
	Mon, 11 May 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506109; cv=none; b=MjmvS7TzeDWhucO8QCuKp8U5hgiqxQmRnTSFeQufWk+khvhj/3xPXMO1MFUqhfrjcpJWrCjcyTIRphCYbJq+U4Xnf55AkRPzgTjMZESSFDLWbhu1DfBramxRgtsIvPj5fXCTF6RX6t0x6BXNshLcOvfkhlwuQLYojQgYUokP8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506109; c=relaxed/simple;
	bh=fkIkL2AdbjI+wE5CqpAoB3RwQlcVxKSD+TtMf0pW6x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pI5ovfJw9DFzhe4GJIgzYWTilj3CVwzjgPzEiYlxH1z1Yczf6xVOYr8AJFFqA3UKjFU/csDtvRibL4Bnejx1I29g6KVzm3wHle0j3ygTBOpE+m8ZlC21xouRG7m4TzqsS4BS+iabLTPAo1fNu9kwObXZ9xFFK8rqDSqL5RN96Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEdgBKrn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEdgBKrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778506109; x=1810042109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fkIkL2AdbjI+wE5CqpAoB3RwQlcVxKSD+TtMf0pW6x0=;
  b=CEdgBKrnR0IL+nGYaiLAcWVWphto3g9mNAnEXizwnm/alDT9dn4ehChX
   s7+9Iihvh+0U304ftDPsclNRUm+iVrtk5Wp/kuCFKkRZPah4fYU/b4sW3
   kmMz7F+XGGCa+cFewvooNq+0KyY8cMO0WQBvJ7cuqgN9nZzHv7IaQFbIe
   RRyGVuAecJN2MXIWFYG2igk2gn4V4t4299HmP0Bk2L13UYCdd46HnJX+V
   ArblZIgbyrvsJPrTUfot70Q2xKLRzvvrwXCTURe2lQ6rKxPL7s9Jidj7v
   VlDA1uGbutKyhTMnXNe0OP5Qso8DuYxQRMon/RAXYrYtqQqz1UrZncO47
   g==;
X-CSE-ConnectionGUID: qc7qgkbzSJSzbtF+DnT8rg==
X-CSE-MsgGUID: GIGHjv2EQBeVLUoJqrYFIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79286935"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79286935"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:28:29 -0700
X-CSE-ConnectionGUID: y+22Dg5/SzyFElCTSt54xw==
X-CSE-MsgGUID: LfeY5j7oRTSgcssufAaZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="239265548"
Received: from unknown (HELO CannotLeaveINTEL.bj.intel.com) ([172.16.114.75])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2026 06:28:26 -0700
From: Jun Miao <jun.miao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jun.miao@intel.com
Subject: [PATCH] KVM: x86: Block TSC multiplier writes for protected guest TSC
Date: Tue, 12 May 2026 07:18:30 -0400
Message-ID: <20260512111830.1295437-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d5a4e408e69b ("KVM: x86: Add infrastructure for secure TSC")
added the guest_tsc_protected flag to prevent KVM from changing the
TSC offset/multiplier of vCPUs whose TSC is managed by a confidential
computing module (e.g. TDX, SEV-SNP Secure TSC).  However only the TSC
offset write path was guarded; kvm_vcpu_write_tsc_multiplier() was
left unprotected.

As a result, userspace can still change the TSC scaling ratio of a
TDX vCPU via the KVM_SET_TSC_KHZ ioctl path:

  KVM_SET_TSC_KHZ
    -> kvm_arch_vcpu_ioctl()
    -> kvm_set_tsc_khz()
    -> set_tsc_khz()
    -> kvm_vcpu_write_tsc_multiplier()   <-- not guarded

and similarly during kvm_arch_vcpu_create() -> kvm_set_tsc_khz()
which can reset the multiplier to default_tsc_scaling_ratio.

Make kvm_vcpu_write_tsc_multiplier() symmetric with
kvm_vcpu_write_tsc_offset() by skipping the update when
guest_tsc_protected is set.  This single chokepoint covers all
existing callers (set_tsc_khz() in both ioctl and vCPU create paths).

Fixes: d5a4e408e69b ("KVM: x86: Add infrastructure for secure TSC")
Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..e935fe33d9c2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2736,6 +2736,9 @@ static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 
 static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier)
 {
+	if (vcpu->arch.guest_tsc_protected)
+		return;
+
 	vcpu->arch.l1_tsc_scaling_ratio = l1_multiplier;
 
 	/* Userspace is changing the multiplier while L2 is active */
-- 
2.43.0

