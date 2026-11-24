Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543610;
	b=xgYCUcha0f/eHA/hJO8oqbWhjf+rxaSx63LdczYEKQSZW3Vm0YZjokUKB/aC+1iAC8Dt
	 +lu83w1aZKe/g9fsmPNVyq9p/2qbylbiJip1fWx4IRDjtcEne7RCpsopAI3Q+jSBD/Izw
	 kJwYekdpsCBnytJD72ITDLn/L2OSuWCnEBlwZAiRGEx6DO8qZhAkzpYbwfaCAGraBB5FJ
	 +JipcPA+hfv+w2uv14uzpbKgT8aBecti9XY+7gRnWnPThoapc08Nx/p9F5sRj2A+kgVC1
	 omwtTqqrxSkJD/FhLUj6iMO6I0Aq5JTc2jseC+9UUeIW32NNOpxYkq8X3T3hs27YDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=9L7gMRdKv8Y2cgyDLpGj/+9e3iMW9OQYPvzsrWlbQUU=;
	b=OgUHivd+AZlHMpOS0R3ITjwLDi7Fzdf36hXfgtp8fYI3hUecDwdd13JY/kOd7PB38Hv9
	 I8iAKhDmazTQkJpSBAPqMPceCyyFnCwH7boWz0trR/DqvkG8Su32iGITGTVgqsm/8VXf1
	 kQgeGIjzw8RqiKXg2V0tYy/S42grMGyPQhv7sH0VUWgkp/NOf273CyDYyTUEThhJKdG/u
	 6dyVwG6fP3UA5PKHF58Dai9FoY5ZuykHcILNqppXzJDVVTnSjiTcZ88TOIpGpZFWWkqVz
	 aVMfgK0psmUMbcLts5uA3G9Aw9zRHAxFVAVQb+1d6VA/1wS0F2y7JAo/ZuMETUhEW6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=o3AIQMgr;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF5606A339;
	Tue, 24 Nov 2026 18:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CF5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=o3AIQMgr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9L7gMRdKv8Y2cgyDLpGj/+9e3iMW9OQYPvzsrWlbQUU=; b=o3AIQMgrHbjsFTrGAOQYmiElyE
	IWR82n8Dh1UZ7Ipd/onYnQ7+jHSXy2m+zwzUtT7IEf5IUKoOkGUPkQzL5Rd7RWZMULCve6Wy/1yPA
	hzBJ31s83sIJLxUqmNT67GidTRPmnYhUdtT1M4PX5GfZdo034nDseQQZP1gPzTLMxTd/zEeEb/jVe
	Iq+jWgov+CtHQox4gY6gK02Fzx/sLo7NVq/3YbFov6ZJwBoS+Vpg17lwKa+GQ+TCzMP7AguVwEQP2
	1WkpKahKPZTcmc4085hmfwYmDIgUD/n1FcsTTFuHZJQga8p5w7GLhu5LoDZl+hAYo1ice4BDc+MGz
	/g3dG9+g==;
Received: from mailer.gwdg.de ([134.76.10.26]:58477)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xVuuX-00Blg2-20;
	Tue, 24 Nov 2026 19:06:33 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xVuuX-000BlI-1w;
	Tue, 24 Nov 2026 19:06:33 +0100
Received: from localhost (10.250.9.200) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.57; Tue, 24 Nov
 2026 19:06:32 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <pawan.kumar.gupta@linux.intel.com>, <brendan.jackman@linux.dev>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>, <amirmohammadeftekhar@gmail.com>
Subject: [PATCH] KVM: VMX: Don't disable FB_CLEAR when doing the MMIO Stale Data VERW
Date: Tue, 24 Nov 2026 19:06:13 +0100
Message-ID: <20261124180613.1693632-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
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
X-ClientProxiedBy: MBX19-GWD-04.um.gwdg.de (10.108.142.57) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Don't set FB_CLEAR_DIS for a VM-Enter that does the MMIO Stale Data VERW.
VERW doesn't overwrite the fill buffers while FB_CLEAR_DIS is set, so the
buffer clear that is meant to protect the host from a guest with access
to host MMIO currently does nothing.  Keep using FB_CLEAR_DIS for vCPUs
that can't access host MMIO, which are the guests it was added for.

Commit e6ff1d61de51 ("KVM: VMX: Handle MMIO Stale Data in VM-Enter
assembly via ALTERNATIVES_2") moved the MMIO Stale Data VERW from
vmx_vcpu_enter_exit(), where it ran before vmx_disable_fb_clear(), into
__vmx_vcpu_run(), which is called after it.  When commit 43fb862de8f6
("KVM/VMX: Move VERW closer to VMentry for MDS mitigation") moved the
unconditional VERW into the asm, vmx_update_fb_clear_dis() was taught to
leave FB_CLEAR alone if X86_FEATURE_CLEAR_CPU_BUF is set, but there is no
such check for X86_FEATURE_CLEAR_CPU_BUF_VM_MMIO.

Both end up enabled on the same hosts.  A CPU that is affected by MMIO
Stale Data but not by MDS or TAA mitigates it with
X86_FEATURE_CLEAR_CPU_BUF_VM_MMIO (unless another VERW based mitigation,
such as the one for RFDS, is enabled), and if the CPU enumerates
FB_CLEAR_CTRL, KVM disables FB_CLEAR for vCPUs whose ARCH_CAPABILITIES
enumerate neither FB_CLEAR nor immunity, e.g. QEMU CPU models that expose
arch-capabilities without fb-clear.  On those hosts, every VM-Enter of
such a vCPU with host MMIO mapped does the VERW with FB_CLEAR_DIS=1, while
sysfs still reports "Mitigation: Clear CPU buffers".

Fixes: e6ff1d61de51 ("KVM: VMX: Handle MMIO Stale Data in VM-Enter assembly via ALTERNATIVES_2")
Cc: stable@vger.kernel.org
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
I don't have access to a CPU that enumerates FB_CLEAR_CTRL, so this isn't
tested on affected hardware.  Instead I ran it as L1 on a vCPU that looks
like an MMIO Stale Data affected Ice Lake-SP (MDS_NO, TAA_NO, FB_CLEAR and
FB_CLEAR_CTRL), with an L2 guest that has a PCI BAR in a memslot and
ARCH_CAPABILITIES without FB_CLEAR.  L1's MCU_OPT_CTRL writes #GP, but L0
still sees the values L1 tries to write, and a watchpoint on L1's
x86_verw_sel shows where the VERW happens.  Without the patch, all 2576
MMIO VERWs came right after the write that sets FB_CLEAR_DIS; with the
patch, none of the 4478 did, and a guest without host MMIO still gets
FB_CLEAR_DIS on every entry.  Same result with QEMU running the L2 guest
with -cpu Icelake-Server-v5.

KVM selftests and kvm-unit-tests (including the vmx tests) gave the same
results with and without the patch in that setup (a few fail or time out
there either way), and it builds cleanly with KVM_INTEL=m, KVM_AMD=m and
KVM_WERROR=y.  I can share the test scripts if that helps.

6.19.y to 7.1.y still call the flag VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO,
so the backport needs that rename.

 arch/x86/kvm/vmx/vmx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 68fa251dda60..490cad070c13 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -482,11 +482,24 @@ static const struct kernel_param_ops vmentry_l1d_flush_ops = {
 };
 module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, 0644);
 
-static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
+/*
+ * VERW doesn't overwrite the fill buffers if FB_CLEAR_DIS is set, so leave
+ * FB_CLEAR enabled for a VM-Enter that does the MMIO Stale Data VERW.  The
+ * unconditional VERW is already handled by vmx_update_fb_clear_dis().
+ */
+static __always_inline bool vmx_should_disable_fb_clear(struct vcpu_vmx *vmx,
+							unsigned int flags)
+{
+	return vmx->disable_fb_clear &&
+	       !(flags & KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO);
+}
+
+static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx,
+						 unsigned int flags)
 {
 	u64 msr;
 
-	if (!vmx->disable_fb_clear)
+	if (!vmx_should_disable_fb_clear(vmx, flags))
 		return;
 
 	msr = native_rdmsrq(MSR_IA32_MCU_OPT_CTRL);
@@ -496,9 +509,10 @@ static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
 	vmx->msr_ia32_mcu_opt_ctrl = msr;
 }
 
-static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
+static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx,
+						unsigned int flags)
 {
-	if (!vmx->disable_fb_clear)
+	if (!vmx_should_disable_fb_clear(vmx, flags))
 		return;
 
 	vmx->msr_ia32_mcu_opt_ctrl &= ~FB_CLEAR_DIS;
@@ -7323,7 +7337,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vmx_l1d_flush(vcpu);
 
-	vmx_disable_fb_clear(vmx);
+	vmx_disable_fb_clear(vmx, flags);
 
 	if (vcpu->arch.cr2 != native_read_cr2())
 		native_write_cr2(vcpu->arch.cr2);
@@ -7335,7 +7349,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vmx->idt_vectoring_info = 0;
 
-	vmx_enable_fb_clear(vmx);
+	vmx_enable_fb_clear(vmx, flags);
 
 	if (unlikely(vmx->fail)) {
 		vmx->vt.exit_reason.full = EXIT_REASON_UNDEFINED;

base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.34.1

