Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394651DCB24;
	Tue, 28 Jul 2026 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198966; cv=none; b=chWg4yM+wRQEGOhQSZyjxLdq5Kn4t8LQ3AQAEi0QT/nbw8SPMScdu5NbHo9xmIPLlTq7T5dqx8w3k1FdVxPb79Yu3Qj6ByLuuRyhEtx2acZN4fSy7+PV1+vA0h0O0JXeu2t/8tr4FGo37ljD0Sf3GI7FovC0PAiYUOhk3YXIj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198966; c=relaxed/simple;
	bh=vprJ5RjdD0xcZoHYsFgc/pkmwPZYlg/PHn/hDrfgwB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSDqDSWPyHq+RkDL/x2HGTRmQ1x7aSarDNlINSlqLvICEa+fVQUsLIKA+ML9O9ToULWQuCxxjbqrsxVBW3/M2sxAGTT9HmfkZ5Pe6mZy1MXiUwf1rk+K/deeH1OIRrWuOahNlGLhwoBAhILM2mdJ0NtnFpi5q5MAEv2ubJFCICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyxJUMNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyxJUMNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498171F00A3E;
	Tue, 28 Jul 2026 00:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198964;
	bh=NYALPUgXkM0U+checFIYPBAfe2CoiUY+akHFZzEtLLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyxJUMNVs6NjNNus85pIJ5PCRHbKw6DNz9x05yNg0VczCk6h7FiD3VhpbqPAvKi5o
	 9cs0adIrWN1eUXBYS1DxxWDkjjvGeREmPzQYetvv0+W41fjk/uXxMDrYPKASq9Alia
	 R8XwUauMZXVz6NDfj/jRVw0jUSsmJ7ER2HEQcpsJzMnkzlVZudrBmuYV+PdlYGaUgM
	 weXSaZ/kiss0MlI2UpVkr93tUGIZQcY/MtTRjhHiOtk0C9H1uBwJ7BP+r9juWqOFua
	 W14/OhHrHcMMMV6MEg0vCrcsZiYErjyT9UZvcXGwhPZsEKgW9VYnBqhZ5n8bdEExVm
	 Az6PB3VESQODw==
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
Subject: [PATCH v1 02/28] KVM: SVM: Document number of ASIDs CPUID setting
Date: Tue, 28 Jul 2026 00:35:31 +0000
Message-ID: <20260728003557.1136583-3-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM arbitrarly advertises 8 ASIDs in KVM_GET_SUPPORTED_CPUID for
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
index a5f9ee92f43e8..2d24bf708d77e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9542,6 +9542,26 @@ the APIC ID is found in EDX for all subleaves of 0x0b and 0x1f, and in EAX
 for 0x8000001e; the latter also encodes the core id and node id in bits
 7:0 of EBX and ECX respectively.
 
+Number of ASIDs (nested SVM)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+CPUID[0x8000000A]:EBX reports the number of ASIDs supported by the processor
+on AMD CPUs. KVM's ``KVM_GET_SUPPORTED_CPUID`` hardcodes this value to 8 for
+historical reasons. This is value is arbitrary and does not represent a
+limit on the supported number of ASIDs, or even a reasonable default value.
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
index 9e9cf6538a96e..8187a58fe6736 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1839,8 +1839,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
2.55.0.229.g6434b31f56-goog

