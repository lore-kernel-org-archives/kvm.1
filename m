Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEA23EAB7;
	Tue, 16 Jun 2026 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570543; cv=none; b=GpGNm/Kjsxs9jq0g4y1GuLUrDxKA4fRi/FNuZIfutRyh0btEqwAawTPIienq4WsNb2Lf0eDwd5c96235g4nRxg7fIp8cmLRCeB0r8qKa7bUeYncDceNdklKkMaGnrpOIcTuEz6i36aRh40R5Fbmb0Eieifs4PdqL2toVKvo6cpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570543; c=relaxed/simple;
	bh=8zzFmaxSHvN5NJRgNimX1V8WkM1p2Mxj8xLY9G1WSYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxxCGcBxENNczwzjNLs/2E0Z95zstve3GtO+GdSgRxfTfaqiOK0BH67vpOVNs9PGdv1Kcsf37TqeYVlSXfnu8qnfMfJDaXlokLUOR4j5Y2/mw+gt6UCNL0OTysTPYWLF9UBHQRgW42eI8pleZPF0fxadVG3xZUOIU5c/f3Iczgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/g1I8mj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/g1I8mj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308BA1F00A3F;
	Tue, 16 Jun 2026 00:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570542;
	bh=i7MNesXZHLfa7YBhbwQlOSaxF/wFQJ6m2TyqXAm/deU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/g1I8mjf1Ydhj0VbWaFc+fYAlNeir+NY+ZMEJX2C5TcrrOuzUBXIak0YH+ufCi6c
	 JDD6rVQ0jRXHjrEIhacgMjqtha+Oj/bAxRiP1T6o8sl2ADtxGUpaAHw/6y3H5FEEqD
	 XRAWBoZLlMcJGqMgT6Wxg5r0tXS/OYUazTLDiOucLP4V9XlpZ3uIzMbcWQgBJ5luEY
	 opXXk7hw18Ah3H9sGInUQ1Djs8A6BfiCnW/RcpK6rfkXsR3ts0H7PaOUu0P8B0otdv
	 nEBFaHGzD3pksHcEYvLK2TV6cJtALTvQn9Su4Ha8wqLYwVvUa8PEvIBPCKhYJKN1PK
	 EMz1zCaFXyjzQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of supported ASIDs
Date: Tue, 16 Jun 2026 00:41:31 +0000
Message-ID: <20260616004155.1435766-3-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM currently hardcodes the number of supported ASIDs in CPUID to 8. A
KVM guest (L1) would then do a full TLB flush (i.e.
TLB_CONTROL_FLUSH_ALL_ASID) every time it runs out of ASIDs on a vCPU
and updates the generation (see new_asid()).

This is currently harmless, as KVM (L0) uses the same ASID for both L1
and L2, and flushes that ASID on nested transitions. However, following
changes will add proper ASID emulation and a separate ASID for L2,
minimizing the TLB flushes on nested transitions. At that point, a full
TLB flush from a KVM guest (L1) would flush both L1 and L2 ASIDs, so
should be avoided as much as possible.

Passthrough the number of ASIDs in hardware instead of hardcoding 8, to
reduce the chances of an L1 guest flushing its own TLB entries
unnecessarily on a nested VMRUN.

In practice, there is no harm in exposing a large number of ASIDs to the
guest, even larger than what hardware supports, as KVM never actually
uses the value of ASID from vmcb12. Even with a separate L2 ASID, KVM
would allocate a (supported) ASID for L2, and just flush that same ASID
every time L1 changes the ASID in vmcb12.

That being said, avoid the temptation of just advertising the maximum
possible number of ASIDs (i.e. 0xFFFFFFFF), in case any peculiar guest
OS does not handle that properly.

Note: QEMU currently hardcodes the number of ASIDs to 16, so this change
doesn't help QEMU VMs (without making a similar change in QEMU).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/cpuid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 591d2294acd75..4486fc8d22b04 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1824,8 +1824,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			break;
 		}
 		entry->eax = 1; /* SVM revision 1 */
-		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
-				   ASID emulation to nested SVM */
 		entry->ecx = 0; /* Reserved */
 		cpuid_entry_override(entry, CPUID_8000_000A_EDX);
 		break;
-- 
2.54.0.1136.gdb2ca164c4-goog

