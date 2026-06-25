Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AB3BAD94
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426993; cv=none; b=KRadnger2HC1V+9Pj+a0hPNzMYOvJTpRYaVZp8QGgrbxUR5UyeZ5C0EcOS5NS8+M0Js760GikQ06nWVQjWtZyUWSrjIuM3//4z4M5HJIkKTI7y2UtIaYIxe6zsOfufvkvwb6Hk3UdprksMMyXW8SbOnIJyJUaBOsQRqBvJEbBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426993; c=relaxed/simple;
	bh=kL83qZkJZi4Aj2Er+eHbDD6C37v6WYXWwKerURyzRrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEukfEmsHb/L9kR3a5SrLzlPYkBFhRpf/e4Gm3eh6gOFiK25G0sdaw6r0OvNwQmlFcafKr7Dj+/smiefOkcCxIeM8W7+4Tn9A8169iayaUV8Oo4//9d0avQJl0mZ6iOK0GE3wTv0unTB05iL0/otuV7v9cCxymwqe4/3U3Os+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlGXV6um; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlGXV6um"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso183525a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426989; x=1783031789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nYe2f5ROlk+rOZAgZLHnz85wyy4NST3pKojrwpDQPdM=;
        b=OlGXV6umzbN5Ek/RJ6USetBIRekCG3u9/LQa+SQN3Sa5CwzrDfPGj9du4hACKkVylQ
         IopKRQmelpUjSALyR3XaRVE2x78DlwjuHaVkSAvbFHg7V0V/nCL9W5Gan+Ao3CfM0VK1
         5cVohgzZvs1TJf0s16yUqwB343jcaPKF/MyQkKX6M1as39VmsjoJ43OqBOEtE//L2crI
         JRFlxbqGnx9QHL2qynP41C3pHCRpUdq+nvZ+BUz59bJDYLdi/EhY0u3FcjDuxIIek4yo
         716A+a1CbTxG4opxdR2shfYami9F6NfhK7xnnpOd/gRHev0acKteICl+FkFs2DBzGrJy
         4s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426989; x=1783031789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYe2f5ROlk+rOZAgZLHnz85wyy4NST3pKojrwpDQPdM=;
        b=YwrtrqSBzn7qUKkCAosuNdp/zgSf0x15994uaBpKqTmS42z11ZJsosQ1w9bKO2IXLG
         N+TE6iGgdjviAyUjv8y/7Th3Zvs7Nlw873sOF3eVrSk+sZvLIte7/tY+pcpalG3Hj6nn
         xmf5wvtRedeR2Rk99Cgft/e+EoLXTBTKswfymgZY2AtKRuz0QShx48bRiHuyNmNVhDK0
         3CHAsa9gilSIrkC689D90Bu+ih+EeBO3TeCySoZWdwYy/mNWf2IVxFM3HlYJX5S2pzo4
         h4guX2QRLrNTzncr5LE6x48kBDrJJp7tHJidQr+qmaBopMAP44myzbS0/7wFkJ+1g3SR
         42ZA==
X-Gm-Message-State: AOJu0Ywi8NSyRu8+Ht6lpuZU4JDs9jBr9E6bwVd5v5TWOReX544h7EaK
	irwnNA3iDqIhGtUteJFz9SKE11Pv8nZaQ2ZmFVLfJ4Kz1Pgb8rJHJQffiuyvHoUgmR3q41AXHNs
	sKoT3Fw==
X-Received: from pgbgf14.prod.google.com ([2002:a05:6a02:2cce:b0:c92:3cad:b6c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:404c:b0:3b3:4406:202c
 with SMTP id adf61e73a8af0-3bd4ac79687mr5015657637.10.1782426989277; Thu, 25
 Jun 2026 15:36:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:17 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-5-seanjc@google.com>
Subject: [PATCH v3 04/10] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
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
KVM_MAX_VCPUS, so there's no chance of a valid ID colliding with -1u.

Link: https://lore.kernel.org/all/20260612233017.1F9771F000E9@smtp.kernel.org
Suggested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 694b31c1fcc9..27c1aeeab8af 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -22,6 +22,7 @@
 #include <xen/interface/version.h>
 #include <xen/interface/event_channel.h>
 #include <xen/interface/sched.h>
+#include <xen/xen-ops.h>
 
 #include <asm/xen/cpuid.h>
 #include <asm/pvclock.h>
@@ -1610,6 +1611,9 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 	if (!kvm_xen_timer_enabled(vcpu))
 		return false;
 
+	if (vcpu->arch.xen.vcpu_id == XEN_VCPU_ID_INVALID)
+		return false;
+
 	switch (cmd) {
 	case VCPUOP_set_singleshot_timer:
 		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
@@ -2299,7 +2303,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 
 void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.xen.vcpu_id = vcpu->vcpu_idx;
+	vcpu->arch.xen.vcpu_id = XEN_VCPU_ID_INVALID;
 	vcpu->arch.xen.poll_evtchn = 0;
 
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

