Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D612145A1F;
	Thu,  8 Oct 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418481; cv=none; b=nN1+yCsHa6C6Z1UJWTMMYSHhfnFsQ4/RUI0QnKhhKuY1QzlJrMp3+Vkhln25uPSLeyU6guGxRzE1A8y8134kythB0HuepCuK5d+4HKa2HgBpL33fWPtDEhTmrT7FIzLeEkpDppAdsJqzv3OEFnH639hqgFqa4+cqiS9/WAPdtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418481; c=relaxed/simple;
	bh=hZrBouAdlA3/xXhrDnbYOYQSEy8/8bH0Sm+5Ww0LgKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHoJboXie/d7oJvzD2ZxjqzL+UyX0cH+TwKV201RQq0rIZO2LRtpPyHuXgBMwo+43nhpzMixG/trxtCk9g731cJMfdZcOntq4i9mMbTjM4mHZdB6n9fg1juVnvFXthPW3523UUTnzeXNl1bkCDJYvS+q3hIpGEBzb6s9J2VTBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRJW2n4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRJW2n4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56001F00893;
	Thu,  8 Oct 2026 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418480;
	bh=klkATUA6bTOyeRjlLZX4aoi+L+h57fw/38KEbHnR4Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRJW2n4soyuKM7TD5/DFyTDdDRhuTDgmb+SrryytgZrKzIHJ6GOZp7VUp+82uZ2K3
	 HluNd0A462Csf/mQg6pAzTNPmjvehVWTWQuW3lPBV6yu2TgtUcccIQxbMp33B7nT0+
	 xPCptuDZIKXxp0RoT05RL2x3ZYeAMevN9sqXk1PurF2Sgweq/gB51TnGSefz/xabd8
	 WrNez62bDmxNDkWyNRTvMGYec8XFAiZIXyNyD7/L8Up7rb2YlkcmyPHOHJsXxs0LhA
	 DcVnJ/3SJB3jUiubVrZqZc5Xn7FewL1qSoCofzaL5Boeeg9c1FkQvvrrKs1EOtpDpx
	 duMPV7dQBDgLg==
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
Subject: [PATCH v2 02/29] KVM: SVM: Document number of ASIDs CPUID setting
Date: Thu,  8 Oct 2026 00:13:58 +0000
Message-ID: <20261008001425.2458927-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
2.56.0.360.g66cac248cb-goog

