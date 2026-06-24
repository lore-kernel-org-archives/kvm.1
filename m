Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822E2AE7A
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338719; cv=none; b=EoEffDsv2GwiamAdiAsZZZIu1bm/nAt/DGg2ece3N9rW4vIGCJsZyPJjGyBX8/iXJPj7o5lmdW5eMK1RQr0uoDIwHHlZKVOKDoXXhG7S2JJmISlS+vSRG51FswoZKIVJ1ug0b59Adp2H7VbpXFXvF755UwLEFZ7K8coWedkrwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338719; c=relaxed/simple;
	bh=UnOYW3CzBkRkM162NUrr0kPXDF6sKcxYQsT+Z1ElTLw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qr0kGQSF3zrUs4n7MuiSuvIkPaLmH/X75IqeDqDyn4s10SC+SuRCCIXPw7+75K17qo8hyysWX3wct8XtMNiIflhqwDZtq27//KDmJSA46zurrIgMqorlDa3XvXqag7/8HPPioaoAAKcxKcxXF1Cpsq45VqSb/nBTQcwusogbhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klhCUEyP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klhCUEyP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85edbb10dfso193982a12.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782338717; x=1782943517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTddlzuBDJ8y2V+QQMnebqNySfTfJombSHyMPsxfvpQ=;
        b=klhCUEyPN1BQCkFBwfY10ToJJAjG8ZG2/NTdPSm1xOvlU6dlmARgXb873hoyEyyKTP
         +0JbVKF5AjdUrgeEUVvRgz6zg9+hwkkKhDxr/4HZDC/lXYYpySWC2csCaLhBsduOknkh
         VXm7xsWEHd/Fj5bKuZqx3zHzTgZKRqjv6L2u3l+lsFRgt/C8mXJYWUTeOPI78xN50q/R
         lxTFWcsRCetzcD1T3cSdp91LXL9k9FYGHGBzJaMGdmXeLMimYex2zWA6PmgjJ/h9C0N/
         5AFexoqr5ggm54MNAX3Cunzdg9fPfUF3G7hc6hxmKXq/zhwp1wjLgzRZkeSQ1IXKGu7b
         lw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338717; x=1782943517;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTddlzuBDJ8y2V+QQMnebqNySfTfJombSHyMPsxfvpQ=;
        b=GfyWBY7YeiSY+FtWcVjeP8OwD8JeobZrVhdRmNh7jtlZL3yUAbSYvLepr+vv09YXJM
         JxGXc5IlErfIz82Y8r34Ua0mLVeWNTUQf4hy4dUBrwNAe9i25aYSUUXcHxt65YrGL2kM
         8+/wwc7na/0fyVCnYBz8Xhv2MlmGY9lzzW0BWhWf4Kix7av+e60bqqfTPg0ZfHGjqw9R
         zjJ70HtbvqMUqd0pylhEgCEHkDxlO3Z+M76l+T8QwhaABjYsvM0aFUwllPGel1WaxQb/
         KnJrwH1TshBwllYARvGuFQu6Kccz1lcWILEnQ4M2EyPAxh3UMINdUthgLcoCbinKLRGY
         +j3w==
X-Gm-Message-State: AOJu0Yy4hBmY6wycbc77fSQyNwxGpiT5VL0enPhvPJb730aQlHlZLxBr
	frqPEUIeO/SBthDZC/F9xZpI/KehJU5ZPUILb98MVDZXTCKPSYo9BkvdbFoB0o7ukLPCy3WwF/V
	u3KvUWg==
X-Received: from pfoc20.prod.google.com ([2002:aa7:8814:0:b0:845:6d68:cf12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1411:b0:842:3d30:6251
 with SMTP id d2e1a72fcca58-845ad20511amr2433608b3a.8.1782338717325; Wed, 24
 Jun 2026 15:05:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 24 Jun 2026 15:05:16 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624220516.3033391-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ignore KVM's internal "service pending PV EOI" request if the vCPU has
disabled PV EOIs since the request was made.  Asserting that PV EOIs are
enabled can fail if reading guest memory in pv_eoi_get_user() fails, i.e.
if pv_eoi_test_and_clr_pending() bails early, *and* the vCPU also disables
PV EOIs.

  kernel BUG at arch/x86/kvm/lapic.c:3338!
  Oops: invalid opcode: 0000 [#1] SMP
  CPU: 4 UID: 1000 PID: 890 Comm: pv_eoi_test Not tainted 7.0.0-d585aa5894d8-vm #337 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_lapic_sync_from_vapic+0x12b/0x140 [kvm]
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl_run+0x1075/0x1c30 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0xb40
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  Modules linked in: kvm_intel kvm irqbypass
  ---[ end trace 0000000000000000 ]---

Fixes: ae7a2a3fb6f8 ("KVM: host side for eoi optimization")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 6f30bbdddb5a..38bba9a1114c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3371,6 +3371,12 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
 					struct kvm_lapic *apic)
 {
 	int vector;
+
+	if (unlikely(!pv_eoi_enabled(vcpu))) {
+		__clear_bit(KVM_APIC_PV_EOI_PENDING, &vcpu->arch.apic_attention);
+		return;
+	}
+
 	/*
 	 * PV EOI state is derived from KVM_APIC_PV_EOI_PENDING in host
 	 * and KVM_PV_EOI_ENABLED in guest memory as follows:
@@ -3382,8 +3388,6 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
 	 * KVM_APIC_PV_EOI_PENDING is set, KVM_PV_EOI_ENABLED is unset:
 	 * 	-> host enabled PV EOI, guest executed EOI.
 	 */
-	BUG_ON(!pv_eoi_enabled(vcpu));
-
 	if (pv_eoi_test_and_clr_pending(vcpu))
 		return;
 	vector = apic_set_eoi(apic);

base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.55.0.rc0.799.gd6f94ed593-goog

