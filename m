Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660251;
	b=2WgDOJ3XEA6YEUoZvUyXxeSf8MC7aIdXRVOf4NFRDvmSJqlD0pgHqXyEFzkto+4JjBec
	 snALjTIMaQJCvzmI1mXtm5hFPr3XUwGL+9b/oEbZV77FKanh7RIpamTwoH1Krs/n3KFRw
	 7bXagMspmIIhmRRHl0+LCTeoYpXCIUd9BhA9sTU+YqG9L+94J43NOypsV1sMs2lRz8MiC
	 88iN3lugxmh47cU/87c89XC+n5DikEiM/t2vrsEpafEaOb4qKwJXjMBTrJ4Eon4c1Ve2B
	 5ULz4Te1EwQRasJduVhkziYiAjKQyzP7EQyfoyO2xRn0NH8q/LQldVJzAxjRxa7LB/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pNo7FC/nRbL7LkGJ5TcZupw/29f4Jh2KwXeVR7Yj4BY=;
	b=gnG73L+1pn87pGhxD5fQ6CY9TW3kDPYkkXJXYpbTNxeaW67UlPmiF3jtH3eoDcCrxIVn
	 0vaX6hoOYhu3BoFPDDR6riSwwcBfpP47alv5u7FO/mpgQsKSv5XT6AFEt33+zjaJPKRAO
	 hSm1niTZHrIbeI4JwU4V7TAo5Z1PIxdPRvOUp3RoJREZamFch6S7rWIqvD0wEpabTHiaK
	 VPdXTQDkCQVArhSl1g25v71ROSMdGaIqeKpcT49XfF3UZv/pCUaz610dVQ3KXxmZjE6Rd
	 tYk6nvXqQ9NAJwSQYUQGT47v/pNMWHzdoGjkPwWYuTiGt5RphYmLdgcpiUtrPivXyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UNsE7VL7;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9884606A32D;
	Thu, 26 Nov 2026 02:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9884606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UNsE7VL7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795660251; x=1827196251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prY11NS/UJ0OpUeEsduHH5UymKEof/BwDENNeLSNI7k=;
  b=UNsE7VL7FjtqyoWRc7B7BT86gwmfLkc43Li71qtz/5lXg8W3q0Tul4eH
   tsYHdTJODZBRyqplcgj+4VZmRpR8qfKQzfJoXd8hS+0R2RIOYWt8FK8nf
   HrUCq/+RqexNEs+5PIbr4gLPxljVVe71VYKZOABmewAHw6ZPwWsv8aOhI
   aybBtTf4gIj/gdm3D0zQsCFrNvwbsDh6tiCrmwvtYqoma99uc5fLSkV5n
   DO1yNeJEeKGPhhFu3chrXZvj4tudyxHDlTfmB7+wroCmQttAeTkchiG+L
   7lTr6ipAjWcHgCemSALHmKFqMbtNddX6zAHPtnUb5iEgrntU6vTbQNx1h
   g==;
X-CSE-ConnectionGUID: f1rU7zdJQ/SSKuvqqCzhYg==
X-CSE-MsgGUID: XBlNsuPST6SvmJvym5Xr1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4642537"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4642537"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:30:50 -0800
X-CSE-ConnectionGUID: EP+NvuEjSHWoLVc5NVD9PQ==
X-CSE-MsgGUID: 1fNS23aNTMOwIoV+zoRiqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12044182"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 18:30:49 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Jon Kohler <jon@nutanix.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: VMX: Dump the secondary VM-exit controls in dump_vmcs()
Date: Wed, 25 Nov 2026 18:27:43 -0800
Message-ID: <20261126022743.4082392-4-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126022743.4082392-1-sohil.mehta@intel.com>
References: <20261126022743.4082392-1-sohil.mehta@intel.com>
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

From: "Xin Li (Intel)" <xin@zytor.com>

KVM now activates the secondary VM-exit controls whenever hardware
supports them. Print them next to the primary VM-exit controls in the
VMCS dump to help debug failed VM-entries.

While at it, give the entry and exit controls the 0x prefix that the
execution control fields already have.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v1:
 - New patch, split out of FRED KVM v10 series so that the dump covers
   the field this series adds.
---
 arch/x86/kvm/vmx/vmx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d35bad8b29a7..7291c2916ff6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6493,7 +6493,7 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 vmentry_ctl, vmexit_ctl;
 	u32 cpu_based_exec_ctrl, pin_based_exec_ctrl, secondary_exec_control;
-	u64 tertiary_exec_control;
+	u64 tertiary_exec_control, secondary_vmexit_ctl;
 	unsigned long cr4;
 	int efer_slot;
 
@@ -6518,6 +6518,11 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 	else
 		tertiary_exec_control = 0;
 
+	if (cpu_has_secondary_vmexit_ctrls())
+		secondary_vmexit_ctl = vmcs_read64(SECONDARY_VM_EXIT_CONTROLS);
+	else
+		secondary_vmexit_ctl = 0;
+
 	pr_err("VMCS %p, last attempted VM-entry on CPU %d\n",
 	       vmx->loaded_vmcs->vmcs, vcpu->arch.last_vmentry_cpu);
 	pr_err("*** Guest State ***\n");
@@ -6626,8 +6631,10 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 	pr_err("*** Control State ***\n");
 	pr_err("CPUBased=0x%08x SecondaryExec=0x%08x TertiaryExec=0x%016llx\n",
 	       cpu_based_exec_ctrl, secondary_exec_control, tertiary_exec_control);
-	pr_err("PinBased=0x%08x EntryControls=%08x ExitControls=%08x\n",
-	       pin_based_exec_ctrl, vmentry_ctl, vmexit_ctl);
+	pr_err("PinBased=0x%08x EntryControls=0x%08x\n",
+	       pin_based_exec_ctrl, vmentry_ctl);
+	pr_err("ExitControls=0x%08x SecondaryExitControls=0x%016llx\n",
+	       vmexit_ctl, secondary_vmexit_ctl);
 	pr_err("ExceptionBitmap=%08x PFECmask=%08x PFECmatch=%08x\n",
 	       vmcs_read32(EXCEPTION_BITMAP),
 	       vmcs_read32(PAGE_FAULT_ERROR_CODE_MASK),
-- 
2.43.0

