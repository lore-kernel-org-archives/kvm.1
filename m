Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661115;
	b=uyR+dbVt+pbAoAM+HdjC+5VlRWu2MBb5kLVsVw3Ht8cGhrZwX/NHw6De8M1zJM+DCPNE
	 6uNzdB5RCruyYYrHKNVNxach18Y+DReV4KcmW4+iogLR0cvepvwqEkZS46+5tScbY9tWE
	 2kA3b+FRhVXKazjtNrXp6tyW/r+Ch/mYDtq2pEJqoPCFx/9a5HKR3F/U4A4aEswlEnr7s
	 8ATAT5C8oCLHWyau0mM8zhz8nzdsrgznEcocFXWM3F4TdDbX73jUzgg5kSRSMVOHNh9nE
	 z8SC9qPg343q5ZWxQlTKV5ukQb/anp+nyQ0owDu4X6SHypsj8idRuNLNfNEWDuWy1FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
	b=uoRGvngz4YI1bdnVi2ZSiz3uUnRUPltMak3VoRtzXcqzjAa4AiPd9BMG1KKy3/o5ytnc
	 sMJ2xCs3lOPRCVAcH2owaAUPq92QfM3nLjeU030JttygZu81YavL7T6ulLer7gFGpbJTH
	 ly0uUoed1XHW6J4+wGPAJKLHLVwDPshLo/WgXZeGELkFf3EPCZ899f4p3NtZ+ZYfvnK4x
	 CaiZAk/MF87ZIrMgAToVNDriYvVBiCNkPV4eCejng659eBsvX9G8lBtXIKPfxF4YGfals
	 4ubd0ju5gKyTzDSuABoN1SbIi9iOwOHyKbZVPDDqw7k5bqB27qmOL/DrkaLE4JThDHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=D+31K0RG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B1606A32A
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 02:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1B1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=D+31K0RG
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67db5e13b0cso5960127d50.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 18:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661114; cv=none;
        d=google.com; s=arc-20260327;
        b=QIsaHjQmswAb2kOVobVCxRiusMJ0I7P08nTpO1J9FzCj5dlZM82iUZVv2Ql8HBKNjZ
         csO9hm4Er4MO7Nablf77k00cc7/vZDyTVerS9B07g0r+TMeU7LarsZN4eBN6jAXIRzWl
         2eEQo9K4sRGw0wKuvrPTVx2QbyNejcfHatr5mM4xd/Iq33ldUGF7uxi/eDAXphD39NE6
         1JeoPeadjPtXRbadHHibyUhjAqPBoDAoAJqCc8bwI8XLIZcBrBbD6JrdMlx2t287oowG
         nkvLbA2qh75OqBxPGaXpQ9qKJd+ia4NpYvotM3Pc++gJm9JCvfh/AlO6Z3FLBAwcxJ3H
         ojEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
        fh=bCaNZjnMYoLp3OThkju+x8s/Z00vUMCAekCF/5jaPIQ=;
        b=p9KANuDxZoMrSgG68/1ZFuNltE+mwfwO7gXTP3TI5rNqBI+6ZFMh1PCPV75T1Uf84x
         zcm0P9tZoLiPi0mykhG/tEJ0vBqT68UDPYNlOGOzKLlYD/BVJBc9wU02PTixtB7cBu3x
         YUXf14Gs++BBauuSSqMROo2mCrGwmma4nAPQIly2miSPljk/CvgN1BUmtsXNNaTFFNdD
         EkipMHLs+A07ZzbjHQkXozU1CgB+p3tf1L/r/Jww7PnWRmhVUy9HFTQHBuoA+6l16EYm
         vBcPDWC0AKVeSjdkpJG9Li7L63E8SjUTfPSh4l5N+MBYBSgoo47ANBzHCevz7ols+2nq
         +i+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661114; x=1796265914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
        b=D+31K0RG4yFw1XFsGQZUWFBWM3SevFmK3xxC4Q7IBjAR7YrLulY2qh+6Y4pnBL26ZN
         hMsqZOXnNSuscw85vpqCD0nU5qK8rpQrst4D7ecT0iewcZCFa6si3VyMsVOHSXrwv8Fb
         K1lT/0PurK57+zBlnwY/JtqtHQOvj/V6Ap7E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661114; x=1796265914;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
        b=qzUTf/jKmoA05T21PXnSEAo5p4yisEKGcPQkK5PMaKDID/x5aWup9T4Ur8yaKHcDrC
         sGNtsBPABxtfSDcJcAaANM76Vyv8J1Go4zuWSHVtiaKHTVOcW0NlCPtN3XCuQoneK8Lw
         neCo0SRR5NPI/QK6lCj9+Qp6IPHfzj3ZN04AdPojzFnoSyBtsZVyt0BZEm2W9JF1xyOK
         BG5EU/Z7gfCS2ANWdi0uehfmfdZc7Cip93G62gbrFLMXCtOJ75yG/9RZrDZ9VthvI67D
         WeGGOK0YY/MBl/a48epQPwN74/iJUoN0OME7gwcSP29zsti6tOK0xCzWov/ldDiY0sO8
         NXMA==
X-Forwarded-Encrypted: i=1; AL+hErE2Tn5NxRudTTKa10VSy9aimWLMRX1Af7et3U9p5inwETFVATBKEtIclN6FBjUrvHjsZeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FoT7uoihrG2Wp9UCi8rrjMn2UC/8gpvQ8htsceT5r52VtiEFC
	MlehFoYQ5e5utu/SHzHb1+0Qfqy7wVVI4vk3d/rjIKVj5V5O0Y96/6+PNCL8yqAuTfq6TTa9XYa
	dDvkjdwGP18Q21zET0kJyim0XHuFOG1kgsUWXeeu06g==
X-Gm-Gg: AZFdTZcYNqFm87IN/sBJQ1RaGfVtcD1aZ/RnZMNyBC/SkTxusim0x0VTku5oWsXtYbG
	jYNM6Yxy5xSWbJU5ePh5h0uPQkoYnwXG4SySgHMHiUxKzejCH3cuulrz9Lu/yfa9iD97J+bl1nG
	HjrJCgLkiXNIxiL1yTG+R8SBKdcSwYZo4i7wvcpiLFp1BQM88CXQjaioACknKpCceXpYgv8nqsk
	WjixoXJyxqKP9BKpKYrbTppEPwj6veZdMg2H8oDQu/XjG2nYrvla06+4xNNNbeuqjLI/1lbzo9z
	xLJ8odcmJi6OL8r+a1ExQ+5yRhEhv0XBYPzwDX2jMjbR/uWFd+Jur4wZaMMzq7GQEH9I9YHRWN9
	Ryts7NtJ26DWOG5av8W7BuMWLKaZRXSd1Cz4wfwcT8KBxsmg4PGCo/IrJDNu47c0o4tv/EG0XIc
	8GXDa/4tz0f9C1TTbYa3x6g1KhfqEWiwsI62b85qI1jI7pArJN0x8dtvDddCmeu62DJfTG2fvjm
	A3Z6nDcROmGLeMgTm2X8KQCCTS0V6r1zpGp
X-Received: by 2002:a05:690e:134f:b0:67e:4934:63cd with SMTP id
 956f58d0204a3-67e49347c5dmr1352415d50.76.1795661114352; Wed, 25 Nov 2026
 18:45:14 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:13 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:13 -0600
X-Gm-Features: Aa3M54qdJD_NbjhkFxblgIbJ7L9Miw14_6xcHoRjRrZigzO-Yzs4ek9cUzQtaKU
Message-ID: <CAFaZ9eoOtFxAansjaUbA-CDNQLcVAVJre2R9vaTQONG9MYUEng@mail.gmail.com>
Subject: [PATCH 5.10.y] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

commit 4bcdd831d9d01e0fb64faea50732b59b2ee88da1 upstream.

Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
reads guest memory.

Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
grab it unconditionally for KVM_SET_VCPU_EVENTS.

 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
 -----------------------------
 include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by repro/1071:
  #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at:
kvm_vcpu_ioctl+0x7d/0x970 [kvm]

 stack backtrace:
 CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-vm #552
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7f/0x90
  lockdep_rcu_suspicious+0x13f/0x1a0
  kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
  kvm_vcpu_read_guest+0x3e/0x90 [kvm]
  nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
  load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
  vmx_leave_nested+0x30/0x40 [kvm_intel]
  kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
  kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
  ? mark_held_locks+0x49/0x70
  ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
  ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
  kvm_vcpu_ioctl+0x497/0x970 [kvm]
  ? lock_acquire+0xba/0x2d0
  ? find_held_lock+0x2b/0x80
  ? do_user_addr_fault+0x40c/0x6f0
  ? lock_release+0xb7/0x270
  __x64_sys_ioctl+0x82/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7ff11eb1b539
  </TASK>

Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM
state is toggled")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240723232055.3643811-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ adapted to 5.10: same as the 5.15.y backport, vcpu->srcu_idx since
kvm_vcpu_srcu_read_lock() is missing ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This is the 5.15.y backport (5f35099fa3d5 in linux-5.15.y), which
applies to 5.10.y unchanged. 5.15.y and newer already have it.

Tested on v5.10.275:
- x86_64 allmodconfig W=1 build of arch/x86/kvm/x86.o, base vs patched,
  no new warnings
- KVM-enabled defconfig boots under QEMU/KVM, and the existing
  evmcs_test and smm_test KVM selftests pass on it

One thing I noticed while there: in 5.10 (and 5.15), KVM_RUN calls
sync_regs() before taking kvm->srcu, so that path can still reach
kvm_vcpu_ioctl_x86_set_vcpu_events() without it. The upstream message
says sync_regs() already holds SRCU, which is true in mainline but not
in these branches. I left it alone to keep this identical to 5.15.y.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58660d5de141..d44c97475625 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4970,7 +4970,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
 			break;

+		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		break;
 	}
 	case KVM_GET_DEBUGREGS: {
-- 
2.43.0
