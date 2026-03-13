Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D632AD10;
	Fri, 13 Mar 2026 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360643; cv=none; b=uuwXxjFuXudVWfEEF2y2BxgpTpVrevnXV5otRvUrmlcwZ+HWd+wlVA3JeIUN1e+cFYKjlxypW08JHM6qYsdPHWrGGZ8Mxy2NcR4PioFPTPd5JJr9YoWMJmelnzxhB3TY12rKOH6ia92X3HDCs79YB3HB38W7RRmQfJZwMS+ezLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360643; c=relaxed/simple;
	bh=UAdyxCiUsXu1PIVRQf8EE8YdAfuHGuHlsNtjZJARHlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7wpPW9CoMFxTrT822fdSkKr5uSF/qmTHAx/oLzPCDjByxMEZ2hhovuiIuKoBHXZ3r3zAAcu9GPlcXMNDtqXhQTIUZNZk2XELtL9YueT+lBqf0weWGnQpRPs2QtnoP89rIvUTZGA6zboOgiN9TkE6fyG9H3uxtGio/tJ4c1MyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyCEH2wC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyCEH2wC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5B7C19424;
	Fri, 13 Mar 2026 00:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360643;
	bh=UAdyxCiUsXu1PIVRQf8EE8YdAfuHGuHlsNtjZJARHlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyCEH2wCrCSoWemgqEEXvmxKXbSz8H4E8JaxwGKdIYgj8PjQjgZJySMVQAnkKRktw
	 GYT5qQ2ZKhWdw+MoHSP9eL/MPabjX+qk3mPQvXYavHY4nBh8tFYDTwAqoBDP0eviPG
	 VTD9qaVKtdcn4OR+tJGQpDpJ84DkefcEOK2viPMC5H3SnfWbJH8S3MEJAK5N4pY2Hh
	 7V5NB5tu13NCOMbRWiMcy0bJC9mnobyXQWSnjPfdV7j0+fqWAjmwmxqvzSppGCxNMa
	 iHl7jQLdOz1bg1Mo3Kk95EGtjXeHM7VQoaREko7SLiEjloBZj8nryEl9drI4RKgug/
	 MDXQ5PGZSBCVg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 1/7] KVM: SVM: Drop RAX check for SVM instructions from the emulator
Date: Fri, 13 Mar 2026 00:10:18 +0000
Message-ID: <20260313001024.136619-2-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260313001024.136619-1-yosry@kernel.org>
References: <20260313001024.136619-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The check for legal GPA in RAX hardcodes a mask for 48 bits of physical
address width. This incorrectly injects a #GP for valid 52-bit GPAs.
However, instead of fixing the check, remove it completely as it is
unnecessary.

If RAX contains an illegal GPA, the CPU should inject #GP. If KVM
intercepts #GP, the emulator is only used for decoding the instruction.
Otherwise, if RAX is illegal from the guest's perspective but not the
host's (due to allow_smaller_maxphyaddr), then KVM should always
intercept the instructions (as NPT and VLS should both be disabled). The
interception path for VMRUN/VMSAVE/VMLOAD also does not invoke the
emulator either. Hence, the emulator can never be invoked with an
actually illegal RAX.

Outside of forced emulation or code stream rewriting, the emulator
should only be invoked for these instructions in cases such as RAX
having a legal GPA that lies outside guest memory, as the #NPF
interception handler will try to emulate the instruction after failing
to create a proper mapping in the NPT. In this case, the emulator's
responsibility ends with checking pre-intercept exceptions and
intercepts, it does not actually emulate these instructions.

According to the APM, #GP due to invalid op happens after the
interception check:

  Generally, instruction intercepts are checked after simple exceptions
  (such as #GP—when CPL is incorrect—or #UD) have been checked, but
  before exceptions related to memory accesses (such as page faults) and
  exceptions based on specific operand values.

Arguably, the emulator's checks for EFER.SVME and intercepts are also
unnecessary. If EFER.SVME is cleared or if L1 intercepts
VMRUN/VMSAVE/VMLOAD (for nested), then KVM should always be intercepting
these instructions anyway, and the emulator should not be invoked (see
above). Leave dealing with that for later.

Fixes: 01de8b09e606 ("KVM: SVM: Add intercept checks for SVM instructions")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/emulate.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 6145dac4a605a..a449a00555da1 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3883,17 +3883,6 @@ static int check_svme(struct x86_emulate_ctxt *ctxt)
 	return X86EMUL_CONTINUE;
 }
 
-static int check_svme_pa(struct x86_emulate_ctxt *ctxt)
-{
-	u64 rax = reg_read(ctxt, VCPU_REGS_RAX);
-
-	/* Valid physical address? */
-	if (rax & 0xffff000000000000ULL)
-		return emulate_gp(ctxt, 0);
-
-	return check_svme(ctxt);
-}
-
 static int check_rdtsc(struct x86_emulate_ctxt *ctxt)
 {
 	u64 cr4 = ctxt->ops->get_cr(ctxt, 4);
@@ -3997,10 +3986,10 @@ static const struct opcode group7_rm2[] = {
 };
 
 static const struct opcode group7_rm3[] = {
-	DIP(SrcNone | Prot | Priv,		vmrun,		check_svme_pa),
+	DIP(SrcNone | Prot | Priv,		vmrun,		check_svme),
 	II(SrcNone  | Prot | EmulateOnUD,	em_hypercall,	vmmcall),
-	DIP(SrcNone | Prot | Priv,		vmload,		check_svme_pa),
-	DIP(SrcNone | Prot | Priv,		vmsave,		check_svme_pa),
+	DIP(SrcNone | Prot | Priv,		vmload,		check_svme),
+	DIP(SrcNone | Prot | Priv,		vmsave,		check_svme),
 	DIP(SrcNone | Prot | Priv,		stgi,		check_svme),
 	DIP(SrcNone | Prot | Priv,		clgi,		check_svme),
 	DIP(SrcNone | Prot | Priv,		skinit,		check_svme),
-- 
2.53.0.851.ga537e3e6e9-goog

