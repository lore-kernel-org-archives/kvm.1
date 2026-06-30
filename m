Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75333B6D0
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860203; cv=none; b=hnThPndhHq9nliLWiF/hbz0yUPVls4nQ0Sn6fytF+PwhI7YbI/U6l4+sP2j3xrBzRIxn+PMgo8HMFwpx08Vp5L2MR9lB3Kk3wJvRXaAIumkZ50TnUDr1lxw1loymjAv5ETy3PoMrDjhUsErT2OdnSIZQfI+PVFx4d/kxRVH5nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860203; c=relaxed/simple;
	bh=aFSs9Q8+e/pr9i4DU49iyo/EgqSuHAAL/+8UT3Q2WM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bx0GphWzpmpvBb+q2RwMg2YR3CsMUwTXq+45P9RxmT9lgPfQjNaZjKdt1sNykSp4FewzH0Bwz95b5bsVMrndsEfXa8kqxGTlEb7+WoQpsIdN10Oaxrp1pu5zUUhmgGOELzsfWOUPLQ2V4kiU/mH0eV0XsITkInKmWzC43AqENxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKDGfH5/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKDGfH5/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b3141a6so396295ad.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860187; x=1783464987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QmYBghqHUKPoeMw22kA+ghFmoINHnkT1ApDfr27UyD8=;
        b=cKDGfH5/Eis4WQutVIu4XUfEzFmdo30ROPbhewh5/BCiluX/V1ceSQzJXwJTqli0jC
         XfLYnbljhSORrVvXwSRBLMqCeCDQyRIMCHT0dk4UIKIr63V9o69O5dZIcsfRiLwP52cb
         ph2FjNf0yl/AQQtDpYVbfvgIEW8hGOlXG25BUR5MEO3auAuZvXjvF4dtb6fMAl2Tlgwx
         orFTHELIrPI+zfZSCLDVIHMFLMkgCFRemOkDGwiLsEbJLAt5K76DopLePJYMVuXeDMuf
         Oxndp1tIz4OAxo7YMlg9IWWbQWLM/vZVoFpAI0OXJPmHdMiJd9SiO/wZCgYzePvgN1ql
         4wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860187; x=1783464987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmYBghqHUKPoeMw22kA+ghFmoINHnkT1ApDfr27UyD8=;
        b=JmZbWraqQNLOOUE1RxeqoYzrpeYAHLVRBoYVRL8mxvlkvrCRENUaLUbiYLYP0yiYCx
         TtjqMY1LaKOGwOIdykFaiquzd/CBLL4N0SSCUzZXhlSNqZdnTUypgfAtA5ri9YigtBRW
         77c8PUCZ2VmyW64x4FntQencDXD6Zi/v4tfik9ZiNF0XH9prv8CMKmu3ED1cXfbeKZTx
         JM+Sib34Pot2REWwRj1i/JujXpF3d4cJc3hZMASIrvZnpdOQ7iw/d4MUrY30eAXQo34X
         nvCN6Mek9d458DfJwGSuLY/7dz82GTYOMMsuo79z4nNR6gYy5CdwBX/O30/mLeuaMdZ9
         /ECA==
X-Gm-Message-State: AOJu0YwH1/BXRNvWGhwK/8CyjqkjhoQ1XKmyOWL+xL2DQMfeKOIv+tFF
	BsrQOsiRR9CJVZNkX3k7uiTgqIiDRcVoNkYQWQ5ms9CcWvmqifQaC8pHx49ppSapWXA782gTe0W
	l2La3Bw==
X-Received: from plbiy8.prod.google.com ([2002:a17:903:1308:b0:2c1:220c:ccc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c7:b0:2c2:bd0d:3cf0
 with SMTP id d9443c01a7336-2ca5a5f0676mr20575585ad.25.1782860187196; Tue, 30
 Jun 2026 15:56:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:13 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-7-seanjc@google.com>
Subject: [PATCH v4 06/11] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Explicitly invalidate KVM's internal Xen vCPU ID during vCPU creation
instead of *trying* to set the Xen ID to the vCPU index by default, and
forward singleshot timer hypercalls to userspace if the VMM hasn't set the
Xen ID via KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID.  Using the vCPU's index as its
default Xen ID is reasonable in concept, but in practice is horribly flawed
as the index is left as '0' until after vCPU initialization completes, i.e.
every vCPU gets a Xen ID of '0' by default.

Forward hypercalls to userspace instead of trying to salvage any kind of
default behavior, as all userspace implementations that support multiple
vCPUs either don't enable the timer, are guaranteed to set Xen ID, or work
only because *all* guests also screw up the singleshot timer hypercalls.
The last scenarios is extremely unlikely given that Linux-as-a-guest uses
the actual Xen vCPU ID when making timer hypercalls.  In other words, for
all intents and purposes, KVM's ABI is already that userspace must set the
Xen vCPU ID, so just commit to that ABI.

Note, KVM's handling of KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID restricts the ID to
KVM_MAX_VCPUS, so there's no chance of a valid ID colliding with U32_MAX.
Add a compile-time assertion to ensure this holds true in the future (KVM
doesn't care what value is used for "invalid", only that there can't be a
collision).

Link: https://lore.kernel.org/all/20260612233017.1F9771F000E9@smtp.kernel.org
Suggested-by: David Woodhouse <dwmw2@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 7a0d89faca85..eef378d0bb45 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -22,6 +22,7 @@
 #include <xen/interface/version.h>
 #include <xen/interface/event_channel.h>
 #include <xen/interface/sched.h>
+#include <xen/xen-ops.h>
 
 #include <asm/xen/cpuid.h>
 #include <asm/pvclock.h>
@@ -1103,6 +1104,8 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		break;
 
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID:
+		BUILD_BUG_ON(XEN_VCPU_ID_INVALID < KVM_MAX_VCPUS);
+
 		if (data->u.vcpu_id >= KVM_MAX_VCPUS)
 			r = -EINVAL;
 		else {
@@ -1614,6 +1617,9 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 	if (!kvm_xen_timer_enabled(vcpu))
 		return false;
 
+	if (vcpu->arch.xen.vcpu_id == XEN_VCPU_ID_INVALID)
+		return false;
+
 	/*
 	 * Reject the hypercall if the guest is trying to start/stop the timer
 	 * for a different vCPU.  Xen per-vCPU hypercalls take a target vCPU as
@@ -2300,7 +2306,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 
 void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.xen.vcpu_id = vcpu->vcpu_idx;
+	vcpu->arch.xen.vcpu_id = XEN_VCPU_ID_INVALID;
 	vcpu->arch.xen.poll_evtchn = 0;
 
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

