Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436134;
	b=XzvKuzMmEA15U3WzOG901Et2C9dmpS+dxjnuyPYVp6UUsRBzhHxEM4EoTtiCQqLGgfoe
	 ronxxGbmv1J7R1TeLU249z20ZLj0mse9iuEvHoZLqqvpRzZCVR+QcVcgKSQ7bnKEeeHm7
	 fyA27tU4TjlBgGOtODWnsosvxoEOB7vpIuThNa3Jqga1WO0DPJZ5VWW4YqY4CZuyoSS19
	 ZLI1mxhHjENOz7AJnKhjqMZ2MT+zU7P/juTQEYeF1ydS0LoFJb/rkDCqkj9mZaufn/7rX
	 FZPVnYLc2NzLMq1i46y7wWVuKiwpUJDdov6a7yKl0S9WLaXWCP2j8iJjJeRggcLbD8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436134;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=tShMXLKCMvW84MR4ySY6XES2av2t71FI1bctsItOmxw=;
	b=wMLfX8jf6G3vUV6Dgrn4oserGgZgd/dgoLywxUHdIJxtxS3g4qMMibMT6oERRjQpdt19
	 YricGSl30uUXv/25IvknBeyhFW2JjyJXX9a2OIZeg20/8FuUeNDMNZbjrYhj9gVJyjaXC
	 CdQ+enyMkYtMDDFtQKKhAs5UXDXDoHuGQHAVqygSD3dOB1XgZJbaC8KvHWrSgENqc98y4
	 VUWrlSd3s0FccNuX3PZmKmsEoU3bqWJfDLGenjZ9evplzhFwuy8uUd6m6vLQEq7/ZD0ZW
	 yjL/5I0lCS7YzH7q1fLOrlSsbqbrPyKf8b0eFi/1+SFylTjBCvwMZ/AZVUpGrEp8Rsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=R+kVdD6f;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06725606A31A;
	Sat, 31 Oct 2026 08:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06725606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=R+kVdD6f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tShMXLKCMvW84MR4ySY6XES2av2t71FI1bctsItOmxw=; b=R+kVdD6fTFVMTUfVtM2/eXJUsl
	TegM7xETbOtuK+vBJsm29UfTdgwBYIl59hPdr+juHreghUJhNK52521woxJrGrGZ55N+gtJiJM51r
	PDvtqWDAYuVlf9N1MWuLFlWm4U/vNsRKUalnFLB02FnVLlyD3MKcMgld99EgCQ61L1A4yLxXk0KNo
	8Mfk4QOzwncccBEyp0Rb//dsXMx3SNDx8tEvVzEJz/RcWjn4eWkZ5zTWAGemIMu2Cht47F0aThpjx
	ZPh3evinTEttORH49SuM/iDQ+u0XXKnYPVkSCsYs2pvkPAGePevOwz7S3s0Ak6JIpzGNgP1hejMs+
	YAqBWrTQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:37756)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN4fD-001WUA-0w;
	Sat, 31 Oct 2026 09:42:10 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN4fC-000CZT-2n;
	Sat, 31 Oct 2026 09:42:10 +0100
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 31 Oct
 2026 09:42:10 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <yosry@kernel.org>, <jmattson@google.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amirmohammad.eftekhar@cispa.de>,
	<amirmohammadeftekhar@gmail.com>
Subject: [BUG] KVM: nVMX: stale vmcs02 VPID/XSS-bitmap/MSR-counts when L1 toggles ACTIVATE_SECONDARY without dirtying vmcs12
Date: Sat, 31 Oct 2026 09:42:03 +0100
Message-ID: <20261031084203.64383-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain
X-ClientProxiedBy: mbx19-fmz-02.um.gwdg.de (10.108.142.53) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

Reporting a stale-cached-vmcs02 bug: a few vmcs02 fields that are written only on
the dirty_vmcs12 rare path are *decided* by state that can change without setting
dirty_vmcs12, so they survive stale across nested entries. This is the Intel twin
of the nSVM stale Virtual-VMLOAD/VMSAVE bit you recently took as a real bug. The
one that matters is an L2->L1 TLB isolation break via a stale VPID; there is also
a host-side KASLR disclosure on PEBS hosts (details below). Not host
memory-safety, and not reachable on the kvmCTF config (I checked; see the end).

Root cause
----------
CPU_BASED_VM_EXEC_CONTROL is a SHADOW_FIELD_RW (vmcs_shadow_fields.h:49). An L1
VMWRITE of it does not exit under hardware VMCS shadowing, and handle_vmwrite()
does not set dirty_vmcs12 for shadowed fields (nested.c:5874 only for
non-shadowed). copy_shadow_to_vmcs12() then syncs it silently at VMRESUME.

prepare_vmcs02_early_rare() (nested.c:2411) and prepare_vmcs02_rare()
(nested.c:2630) run only when dirty_vmcs12 is set. Two of their writes are gated
on nested_cpu_has2(), i.e. on the *primary* ACTIVATE_SECONDARY bit:

  - VIRTUAL_PROCESSOR_ID  = vpid02 vs vpid01		(nested.c:2431/2433)
  - XSS_EXIT_BITMAP       written only if XSAVES set	(nested.c:2691)

Everything else is re-derived from the live vmcs12 on every entry: vmcs02's
secondary controls in prepare_vmcs02_early(), and every TLB-flush target
(vmx_get_current_vpid(), nested_vmx_transition_tlb_flush(), handle_invvpid). So
after an ACTIVATE_SECONDARY toggle done with a shadowed VMWRITE and no other
non-shadowed VMWRITE before VMRESUME, hardware runs L2 on the VPID/XSS-bitmap
chosen for the *old* activate state while the rest of KVM follows the new one.

Manifestation 1 (VPID): L2->L1 TLB isolation break
--------------------------------------------------
ACTIVATE 0->1 (VPID turned on): vmcs02 keeps vpid01, but handle_invvpid() and the
KVM_REQ_TLB_FLUSH_GUEST emulation target vpid02, so L1's INVVPID for L2 never
reaches the entries L2 actually holds. L2 keeps a stale translation after L1
remapped the page. The 1->0 direction is the mirror (a missed architectural entry
flush). On 6.1.74 the 0->1 / missed-INVVPID case is the live one.

Dynamic, host 7.1.2, pinned (a pCPU migration does a global flush). L2 maps GVA
0x80_0000_0000 -> page X, reads it; L1 flips ACTIVATE 0->1 by a shadowed VMWRITE,
remaps the PTE to Y, issues single-context INVVPID for vpid12=1, VMRESUMEs; L2
reads again:

  U1 (control, VPID on from launch) INVVPID rflags=0x2, read#3 = Y (fresh)   as architected
  U2 (ACTIVATE 0->1 by shadow VMWRITE) INVVPID rflags=0x2, read#3 = X        DEVIATION: translation survived L1's INVVPID
  U3 (U2 + one non-shadow VMWRITE) read#3 = Y                                 as architected

5/5 rounds, host dmesg clean. U2's INVVPID VMsucceeds (rflags 0x2) yet the stale
translation is still observable.

Manifestation 2 (XSS): ACTIVATE 0->1 with XSAVES set leaves vmcs02 with the old
(often empty) XSS_EXIT_BITMAP, so L2's XSAVES/XRSTORS of components L1 asked to
intercept (e.g. CET_S, loading L1-owned IA32_PL0..2_SSP) run without the exit.
Observable only where the guest can set IA32_XSS bits (a CET CPU). Measured on
7.1.2.

Member 3 (MSR auto-load/store counts): host-side effect
-------------------------------------------------------
prepare_vmcs02_rare() is also the only entry-side writer of the vmcs02
VM_{EXIT,ENTRY}_MSR_*_COUNT fields (nested.c:2740-2746). The exit side resyncs
vmcs01 unconditionally ("The tracking is per-vCPU, not per-VMCS", nested.c:5172-5176),
but the entry side does not. add_atomic_switch_msr()/clear_atomic_switch_msr()
write the count only into the current VMCS and only on a membership change, so if
the perf MSR list changes while vmcs01 is current (L1 running) and the next
VMRESUME does not dirty vmcs12, vmcs02's counts are stale.

On pebs_ept CPUs (Ice Lake server and later) with guest PEBS, a stale-smaller
count leaves the guest IA32_DS_AREA unloaded on the stale entry, so while L2's
PEBS counter runs the hardware keeps the *host's* IA32_DS_AREA (a page in the
per-CPU randomized cpu_entry_area). The PEBS assist treats that host linear
address as an L2 linear address; the walk goes through L2 paging and EPT, so no
host memory is read or written, but it marks L2's own paging structures, which
discloses the host cpu_entry_area base to the nested guest. Confirmed on Sapphire
Rapids (Xeon Gold 6430): the decoded address matched the host rdmsr 0x600 exactly,
dmesg clean, no KASAN report. This is a host KASLR disclosure to a nested guest,
not host memory-safety.

Fixes / precedent / suggested direction
---------------------------------------
Fixes: 25a2e4fe8ef7 ("KVM: nVMX: initialize more non-shadowed fields in
prepare_vmcs02_full"), which moved the nested_cpu_has*-gated VPID/XSS writes and
the MSR counts into the dirty-gated path. Its own changelog states the rule it
left incomplete ("we copy them always ... because the corresponding execution
control might be one of the shadowed fields"). 2abb25273c82 ("KVM: nVMX: Force
MSR bitmap refresh if runtime eVMCS controls are modified") is the same
"derived state not refreshed when a shadowed control changes" class, treated as a
real bug.

I would suggest either treating a change of the effective ACTIVATE_SECONDARY bit
as dirtying on both entry paths (VMLAUNCH and RSM), recorded where the rare paths
run, or the point fixes: decide VIRTUAL_PROCESSOR_ID per entry in
prepare_vmcs02_early(), write XSS_EXIT_BITMAP unconditionally under
cpu_has_vmx_xsaves(), and move the three MSR-count writes into prepare_vmcs02()
to mirror the exit side; plus extending the vmcs_shadow_fields.h rule to "a
shadowed field must not gate anything in the rare paths". I am happy to send and
test a patch.

kvmCTF / scope note: on the Cascade Lake-Server kvmCTF config this is
guest-contained. Manifestation 1 is L2<->L1 only (attacker and victim are both the
guest), 2 needs guest XSAVES (xsaves=off there), and member 3 needs guest PEBS
(pdcm=off there, and Cascade Lake keeps the perf generic MSR list empty anyway).
I verified the EPT/MMU context and every host-physical vmcs02 field are re-derived
every entry, so no stale-pointer-to-host-memory path exists; a 200k-round
multi-vCPU KASAN churn of the nested-EPT lifecycle under the toggle stayed clean.
So this is an upstream correctness / isolation report, not a kvmCTF submission.

Reproducers (standalone probes with small L1/L2 blobs) for all three members are
available; happy to share or adapt them to a selftest.

Thanks,
Amirmohammad
