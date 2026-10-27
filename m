Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=125.209.209.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060175;
	b=Fx2EAzBka0EZsZmIVBUntZLi5YvhOWkkN6UFsZ8c6jyK9qw31xDzVhfh8bde+LQX6rWF
	 Q0Yf+6qSKNWJa0WtML7nfUaxvwCY6d+eLJ6+J1Jjn8fN9BcoulIrx3dAV93Iy8OhU/oG/
	 +dtFiaqIRGjLgJk5Rmevzzpq3eLqfBUDrron9dFieffwph+yUQM3+4/gyoN5cEd04bbmR
	 938dYJtYantPlmObm/Qw66ElOF/cA5NTDTkEE83GfpCj0q2WzW2gnqixukOpS2Hi5V/da
	 Xq4UZiRkdeVnkwlSD+VSy0kA4S2UefDHrwwCZF+0jRNQNDGKiEv0L/eze6nViavjJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060175;
	h=DMARC-Filter:DKIM-Signature:X-Originating-IP:Received:DKIM-Signature:
	 X-Session-ID:X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0jnDN7Ecq7KbcW1kOD9Nf7VJh4fMZ7UiSNqsVL+0uSo=;
	b=QQ/WYXeYvIt5jBKn7ioJJJLWw3kOmh7YpVTM7xv4IeVU2goZi+LQxMj3LMqolXXsNA65
	 ZxWURdWE6tA7yVVvoOFsxQ+1hZhLGRUaYwc5s/IjcOnQphSQ12B53xgeG9rLqviLuhKOC
	 VzTHu4a/yR6eEEK+QIeFQwZ6ZJ46uduFDRWW5MPUY+dxwxbRbXFOAd9R1kGyDryEDmLvs
	 P8t1PCD0JotUHsu04Q3xTpw18DCCwUfZYms5SKxHCuJjoWsNN+8TDGEC6zxIo9TpRSY28
	 lpyVUbGK69SDgbpZ/jPJCzm2OAz+JShOTlW4ybTbQ9LCIzTW1Txh+b4y04DFgm8pByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=worksmobile.com header.i=@worksmobile.com header.a=rsa-sha256 header.s=s20171120 header.b=D43qZJHa;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=naverworks header.b=TdnWIrhf;
	arc=none smtp.remote-ip=125.209.209.78
Received: from cvsmtppost105.wmail.worksmobile.com (cvsmtppost105.wmail.worksmobile.com [125.209.209.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DA606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 00:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD2DA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=worksmobile.com header.i=@worksmobile.com header.a=rsa-sha256 header.s=s20171120 header.b=D43qZJHa;
	dkim=pass (1024-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=naverworks header.b=TdnWIrhf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1793060162;
	bh=nJnsI7RyJoLEvi1SS5BUbs9bPEH104dBV+WzFE5FgQE=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=D43qZJHa7SHpJehmK7ZkVP/IDYbzsyX8/zKj9qZx4uSTxb0Y1Z0VTctKn048Ws04n
	 Arx0GOaBgTnOla0IznQh7uUgOB+cSRELdKgqesql5T0vcyvbpxAUhnmXPUbCEYjPDS
	 DHaDkmNpMw2lZufIIjAxOTCSbtyFwSQERH/KGxURYohMDHbNF6Jfj2K/I1JK81OKtV
	 C0c1RFgbFto5q5QIkYx+5rtBZkGnI0ZexBkQ3D9IZVT9jwn6sSiu/neJ67+HFRvOWm
	 O2MV0/oyQFor/RVJxavZPYRYblDYi9o4ZT6I6oRXlvJUEFtGvg5dIy59sWAp7T7o+P
	 PkLUyb+7FdYIw==
Received: from cvsendbo006.wmail ([10.112.11.111])
  by cvsmtppost105.wmail.worksmobile.com with ESMTP id iCpU85iSSIqPnjY2-GZnwg
  for <kvm@vger.kernel.org>;
  Tue, 27 Oct 2026 00:16:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1793060162;
	bh=nJnsI7RyJoLEvi1SS5BUbs9bPEH104dBV+WzFE5FgQE=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=TdnWIrhfpAoacoeCyLl/KXPdljxGY5y73jNtUxbAqASPtEXHW1P07JxLY3eaV+xq5
	 ZIqw+KqgvEriIEOcG+ossJ3CyW54v+slrMUW3e3XAbO6V7zuXycAsZxBH0NsmBjz3g
	 w8/pwfZAk28FeXhm/GBIFcSMfab+b7KVN03GS4Ro=
X-Session-ID: IsJDftZQSCiHDQ8OUj+jFA
X-Works-Send-Opt: 5XK/KqgmKAKmKAFYFqMXKAK/FqMXjAumKAgmKxEmFxudKoMqKNmwjAumjAuXFxMXaAErKqpYjHmm
X-Works-Smtp-Source: rdbZKAKlFqJZ+HmwFobX+6E=
Received: from s2lab05.. ([163.152.163.130])
  by cvnsmtp103.wmail.worksmobile.com with ESMTP id IsJDftZQSCiHDQ8OUj+jFA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Tue, 27 Oct 2026 00:16:01 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH] KVM: x86: Move PIT existence checks into the PIT ioctl helpers
Date: Tue, 27 Oct 2026 09:16:00 +0900
Message-Id: <20261027001600.2742995-1-ingyujang25@korea.ac.kr>
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

kvm_vm_ioctl_get_pit() and kvm_vm_ioctl_get_pit2() always return 0,
so the error checks on their return values in kvm_arch_vm_ioctl()
never trigger.

Move the !kvm->arch.vpit checks from the callers into the PIT ioctl
helpers, so that these error checks handle the missing PIT case.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/aYFE-tGOPtKlSWhn@google.com
Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 arch/x86/kvm/i8254.c | 18 +++++++++++++++++-
 arch/x86/kvm/x86.c   | 17 -----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddda..311d0e8cde99b 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -651,8 +651,12 @@ static void pit_mask_notifier(struct kvm_irq_mask_notifier *kimn, bool mask)
 
 int kvm_vm_ioctl_get_pit(struct kvm *kvm, struct kvm_pit_state *ps)
 {
-	struct kvm_kpit_state *kps = &kvm->arch.vpit->pit_state;
+	struct kvm_kpit_state *kps;
 
+	if (!kvm->arch.vpit)
+		return -ENXIO;
+
+	kps = &kvm->arch.vpit->pit_state;
 	BUILD_BUG_ON(sizeof(*ps) != sizeof(kps->channels));
 
 	mutex_lock(&kps->lock);
@@ -666,6 +670,9 @@ int kvm_vm_ioctl_set_pit(struct kvm *kvm, struct kvm_pit_state *ps)
 	int i;
 	struct kvm_pit *pit = kvm->arch.vpit;
 
+	if (!pit)
+		return -ENXIO;
+
 	mutex_lock(&pit->pit_state.lock);
 	memcpy(&pit->pit_state.channels, ps, sizeof(*ps));
 	for (i = 0; i < 3; i++)
@@ -676,6 +683,9 @@ int kvm_vm_ioctl_set_pit(struct kvm *kvm, struct kvm_pit_state *ps)
 
 int kvm_vm_ioctl_get_pit2(struct kvm *kvm, struct kvm_pit_state2 *ps)
 {
+	if (!kvm->arch.vpit)
+		return -ENXIO;
+
 	mutex_lock(&kvm->arch.vpit->pit_state.lock);
 	memcpy(ps->channels, &kvm->arch.vpit->pit_state.channels,
 		sizeof(ps->channels));
@@ -692,6 +702,9 @@ int kvm_vm_ioctl_set_pit2(struct kvm *kvm, struct kvm_pit_state2 *ps)
 	u32 prev_legacy, cur_legacy;
 	struct kvm_pit *pit = kvm->arch.vpit;
 
+	if (!pit)
+		return -ENXIO;
+
 	mutex_lock(&pit->pit_state.lock);
 	prev_legacy = pit->pit_state.flags & KVM_PIT_FLAGS_HPET_LEGACY;
 	cur_legacy = ps->flags & KVM_PIT_FLAGS_HPET_LEGACY;
@@ -711,6 +724,9 @@ int kvm_vm_ioctl_reinject(struct kvm *kvm, struct kvm_reinject_control *control)
 {
 	struct kvm_pit *pit = kvm->arch.vpit;
 
+	if (!pit)
+		return -ENXIO;
+
 	/* pit->pit_state.lock was overloaded to prevent userspace from getting
 	 * an inconsistent state after running multiple KVM_REINJECT_CONTROL
 	 * ioctls in parallel.  Use a separate lock if that ioctl isn't rare.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba99..ac5900ba83aaf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4568,9 +4568,6 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&u.ps, argp, sizeof(struct kvm_pit_state)))
 			goto out;
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto out;
 		r = kvm_vm_ioctl_get_pit(kvm, &u.ps);
 		if (r)
 			goto out;
@@ -4585,18 +4582,11 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
 			goto out;
 		mutex_lock(&kvm->lock);
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto set_pit_out;
 		r = kvm_vm_ioctl_set_pit(kvm, &u.ps);
-set_pit_out:
 		mutex_unlock(&kvm->lock);
 		break;
 	}
 	case KVM_GET_PIT2: {
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto out;
 		r = kvm_vm_ioctl_get_pit2(kvm, &u.ps2);
 		if (r)
 			goto out;
@@ -4611,11 +4601,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (copy_from_user(&u.ps2, argp, sizeof(u.ps2)))
 			goto out;
 		mutex_lock(&kvm->lock);
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto set_pit2_out;
 		r = kvm_vm_ioctl_set_pit2(kvm, &u.ps2);
-set_pit2_out:
 		mutex_unlock(&kvm->lock);
 		break;
 	}
@@ -4624,9 +4610,6 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r =  -EFAULT;
 		if (copy_from_user(&control, argp, sizeof(control)))
 			goto out;
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto out;
 		r = kvm_vm_ioctl_reinject(kvm, &control);
 		break;
 	}
-- 
2.34.1

