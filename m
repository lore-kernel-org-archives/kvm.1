Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6ADDA9
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393807; cv=none; b=XgAJanYbWgNAyCLdvhsJXe+t5RBpoOYbWaGoor1fzrmng6v7Fi6whSKWKSYO2WOGqj/yAhA+5gTD1+bi833yAq+uL9Qr55JT5sFg2HephLllwjcLUOh+ls5G5lKCMguGlkKuZp6DKrEuIWCa6+EDsNNt2kh95EGmgmqJU0lYvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393807; c=relaxed/simple;
	bh=Rm0MpogzC+jXOnzF/zJxPCsyY2HzByKGsk/j5//WocE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AwHK0PmxAtlZLDgVtY0LurvUNxRXGj9tlZljaJJ73u6iC4z30wCdr9tQOUFQ1bSCM4SU1OrBsJe1QKGQsycgs5X/bmUzpeTH3R4Pj0arDNWM7BnPzwx7LiU0WOIVCiYSY6/qVNusVt/RLgTahs3cTI3x/xdkTby5E59ThvXonZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1VJoHs6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1VJoHs6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7ba03ecdc6so6783792a12.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777393805; x=1777998605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkDZaHJzEhdfVFXfzNbzmpch/bWf5rXBs9VH5x/fe3w=;
        b=l1VJoHs6G05KCuQMpFNkPUOdWpHQNHrSeFwnkUewCrv6nCkiZuW5GdLosUVAuWC0rc
         hQSIm+OrCkqy4s5PsF7Bxl3ox/tq6xS+iBSkikIPztLWGLgK6op5CVV8ig35ndRscT8n
         7IkyVHUU2Rlnj1jKKyQBq+xKtL6xrLFGV81yS1hG558a7ZNKeYvD7SFezkTeLyvz9MkB
         2uPEI96hey/w9lZsOeScCs+GyKLcRAusb+I4T7BtGli+wuMLkjqsWTNiCnMNHs8YB6Wa
         EF/VuTpwjDk9sHddgo4uKuQt3Fv34okJuZWpqbQKq+dOQ9GHcVTHcomJjYQzINRUire6
         y49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393805; x=1777998605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkDZaHJzEhdfVFXfzNbzmpch/bWf5rXBs9VH5x/fe3w=;
        b=O2g9tY++kawRr6GSYlwbw1qUrGi8hLXYWzQGDhHByP0HrTR3Un3UZVaCxyzQOAX4WU
         I1RrDLGaILnwsAaI0mUKAnIhaNAwqR8PulCrlUwxvWbju8fD1ssLN/b3NElmSKCrv6Es
         TASfSH/O6TQURMamqz4LkYnhycRD9jSgyA5d98Dipe+4+/YdD12tfuBhF8QzT0l3cmL1
         Pf8dac+yNc5rsWxa1wLK4Co1lM8Q+lG2wqAZD3mSx/C2gi+HTNWrej2BeWRi9z4N0G48
         mR85FpsBI/VBSEn30fCOVQk3BIyoX4Gsirjbhfi+LDdBHE6WxzRNIi+vmqao813+Ipw0
         ZTYA==
X-Forwarded-Encrypted: i=1; AFNElJ9Iil5egGsGsoVd90Vi2VzkuT9+4wkwiGi01/5jtn2CvSTe1Ii72KK8PIXNg52bPiyMBAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDebiOGmPzLZExUZt4bt+xrTMmXwYhCvdN0RIgDe4XZ+tDpgBg
	2iWjGFgesRXPHEfasNqa2zwt+JJjvOVTFeAAt23SDXcXruHDchGfz/OMsYQfGeZenR6Ul6QSU8Z
	oSIYqWA==
X-Received: from pfcp5.prod.google.com ([2002:a05:6a00:a245:b0:82a:5ddb:b051])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e1:b0:82f:5571:1a8d
 with SMTP id d2e1a72fcca58-834ddaca2d9mr4265031b3a.2.1777393804590; Tue, 28
 Apr 2026 09:30:04 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:30:03 -0700
In-Reply-To: <afCdoufK0D+1hKAR@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-2-binbin.wu@linux.intel.com> <afCdoufK0D+1hKAR@intel.com>
Message-ID: <afDgiz38tARlIQNr@google.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	dave.hansen@intel.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	vishal.l.verma@intel.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 28, 2026, Chao Gao wrote:
> On Tue, Apr 28, 2026 at 10:47:45AM +0800, Binbin Wu wrote:
> >Add MSR_IA32_PLATFORM_ID to tdx_has_emulated_msr() so that TDs can read
> >it.
> >
> >Linux kernel reads MSR_IA32_PLATFORM_ID during init since commit
> >d8630b67ca1e ("x86/cpu: Add platform ID to CPU info structure").  KVM
> >already supports this MSR on read for normal VMs by returning 0.
> >Without support for this MSR, TDs get unchecked MSR access errors.
> >
> >    unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
> >    Call Trace:
> >     <TASK>
> >     ? early_init_intel+0x28/0x2c0
> >     ? early_cpu_init+0x9b/0x930
> >     ? setup_arch+0xbf/0xbb0
> >     ? _printk+0x6b/0x90
> >     ? start_kernel+0x7f/0xaa0
> >     ? x86_64_start_reservations+0x24/0x30
> >     ? x86_64_start_kernel+0xda/0xe0
> >     ? common_startup_64+0x13e/0x141
> >     </TASK>
> >
> >Add MSR_IA32_PLATFORM_ID in tdx_has_emulated_msr() to allow TDs to read
> >the MSR.  MSR_IA32_PLATFORM_ID is read-only by hardware definition, i.e.
> >KVM should never add it as writable, no need to add it in
> >tdx_is_read_only_msr().
> >
> >Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
> >Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> >Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> >---
> > arch/x86/kvm/vmx/tdx.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >index 04ce321ebdf3..812ad99b11e5 100644
> >--- a/arch/x86/kvm/vmx/tdx.c
> >+++ b/arch/x86/kvm/vmx/tdx.c
> >@@ -2094,6 +2094,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> > bool tdx_has_emulated_msr(u32 index)
> > {
> > 	switch (index) {
> >+	case MSR_IA32_PLATFORM_ID:
> > 	case MSR_IA32_UCODE_REV:
> > 	case MSR_IA32_ARCH_CAPABILITIES:
> > 	case MSR_IA32_POWER_CTL:
> 
> This patch looks good to me. But the rule for which MSRs should be emulated
> by KVM for TDX is not very clear to me.

I would strongly prefer to not take this patch, and instead fix the guest.  This
isn't some latent/pre-existing guest behavior, it's brand new functionality.
I.e. Linux-as-a-TDX-guest broke itself.

More importantly from a guest security perspective, consuming MSR_IA32_PLATFORM_ID
is actively dangerous.  E.g. it could allow the untrusted host to steer the guest's
behavior with respect to feature detection and enablement.

And once KVM allows reads from MSR_IA32_PLATFORM_ID, there's no going back.  E.g.
if the TDX-Module wants to emulate MSR_IA32_PLATFORM_ID, because there's an actual
*need* to do so, then we're going to have a (minor) mess with KVM's ABI.

> Maybe we can document the rule here, if there is one. That would make it
> much easier to tell whether future issues like this are guest regressions
> or missing KVM handling.
