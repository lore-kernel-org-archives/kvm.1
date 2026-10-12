Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3A384CDA;
	Mon, 12 Oct 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848208; cv=none; b=rPHPYdjrJQFbcUsvAusONK2Uv/PN1WMOvJOLPTSZCuBdndE3GzeRpJXXoKk85NWw+H6fjNXEdM/q5StCYvaenXkdmvKWgBU7kIjD4GJdC8m28Yj4BuQSyEO+37wbrW+/Stu0pBPYyQ66ugkirIVoLqyivPF/Qu75kDoF5dtEWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848208; c=relaxed/simple;
	bh=3L6TRk3SfEbFEAWhF3orP3EJ2GSecVPyzNz7UyUY78I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJz1SJ5yXAqvMsbOxwNTROICulmq7pk4ucW1aBwoFk9tecMMD8p5V/i1b28uBID2RhI/Rsmt94Fr019/jN0KltGniCuYoFn9FqY8N3NTGiA5BPSYbwdmsaNOXp7gTWSKRh8ms5bEqvupLOMHtictjJbQaWE3mNtbHUSza4d836E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU5gzpN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU5gzpN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FF01F008A1;
	Mon, 12 Oct 2026 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848207;
	bh=MRfwr6re9HC5LaQZsSY80BnCdU6/9uGtmoM1+8jvwYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dU5gzpN0EUjWsbFuudLoAUp0ii9cqEV3fhSs4pgKj6kHLn9W7yc3DuPiJ4KwIpQv8
	 J7sJC8KtfpLID8oIWB95Ky2K79qO9uic2donhW3g6/vA/ez0a4N9GmY7NbmLlb7LTz
	 Bsr9GOANYiDaMVWiLYmPhX/Nl+y9Ejx15XmMB/5Yl0dXRexiCu/N05x22viIViyMAz
	 Kgzqywkf4wJ3ge2wcw2FQmtJ5oVZAHHsmVEetREbaXZnWGhNYJgucFI6oO7cp1Rj6n
	 cxu9WYoYjcgVrUUaGsd4rK4UdH7b/eDg/0RBLyQuOhuW7oQfd/eJeoaz3z3FJBlh2O
	 gRdJXCK30fSwg==
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
Subject: [PATCH v3 02/27] KVM: SVM: Document number of ASIDs CPUID setting
Date: Mon, 12 Oct 2026 23:36:13 +0000
Message-ID: <20261012233638.2546339-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM arbitrarily advertises 8 ASIDs in KVM_GET_SUPPORTED_CPUID for
historical reasons. Advertising a small number of ASIDs to L1 is
currently harmless, as KVM (L0) uses the same ASID for both L1 and L2,
and flushes that ASID on nested transitions.

However, following changes will add proper ASID emulation and a separate
ASID for L2, minimizing the TLB flushes on nested transitions. At that
point, a full TLB flush from a KVM guest (L1) would flush both L1 and L2
ASIDs, so should be avoided as much as possible by advertising more
ASIDs to L1.

Increasing the value advertised by KVM is tricky, because a VMM copying
the number of ASIDs from KVM_GET_SUPPORTED_CPUID may perceive a new VM
with a higher number of ASIDs as incompatible with older KVM (which is
not true).

Avoid changing the value advertised by KVM, but document that it is
essentially meaningless and does not represent a limit or a hint. Also,
more-or-less encourage userspace to advertise a higher value to avoid
potential unnecessary TLB flushes from an L1 hypervisor.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++++
 arch/x86/kvm/cpuid.c           |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ddc61ea36ac59..60f49b3675920 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9770,6 +9770,26 @@ the APIC ID is found in EDX for all subleaves of 0x0b and 0x1f, and in EAX
 for 0x8000001e; the latter also encodes the core id and node id in bits
 7:0 of EBX and ECX respectively.
 
+Number of ASIDs (nested SVM)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+CPUID[0x8000000A]:EBX reports the number of ASIDs supported by the processor
+on AMD CPUs. KVM's ``KVM_GET_SUPPORTED_CPUID`` hardcodes this value to 8 for
+historical reasons. This value is arbitrary and does not represent a limit
+on the supported number of ASIDs, or even a reasonable default value.
+
+KVM allows userspace to set any value (up to 0xFFFFFFFF), and emulates those
+ASIDs by multiplexing them onto hardware ASIDs. AMD CPUs have only ever
+supported 3 values: 0x40, 0x8000, and 0x1000 -- with modern CPUs advertising
+0x8000.
+
+Advertising a small number of ASIDs could lead an L1 hypervisor to perform
+unnecessary TLB flushes (e.g. older KVM would flush the entire TLB when running
+out of ASIDs). Userspace should probably set the number of ASIDs to a
+reasonably high power of 2 value to remain consistent with hardware and avoid
+any misbehavior by L1 hypervisors, ideally one of the values advertised by
+actual hardware.
+
 Obsolete ioctls and capabilities
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c542..e45c01d6faeaf 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1846,8 +1846,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			break;
 		}
 		entry->eax = 1; /* SVM revision 1 */
-		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
-				   ASID emulation to nested SVM */
+		entry->ebx = 8; /* Arbitrary value for historical reasons. KVM
+				   practically allows and ignores all values. */
 		entry->ecx = 0; /* Reserved */
 		cpuid_entry_override(entry, CPUID_8000_000A_EDX);
 		break;
-- 
2.56.0.385.gd3acb90ef8-goog

