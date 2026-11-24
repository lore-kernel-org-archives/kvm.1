Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490876;
	b=aBHH34xh0f/HxekEWUZg8ssYMUBjEZn+aXTXZBDj3yq4NlGij+vTHoGaZyibJEUZBaZa
	 vxXCsIWH4Q5UVB9bMcT5tUeSMT0mwi0pJxnIbI1eeH3CARZnAbOpeS4qRItuDJOzb+Tcv
	 CMhV7FB2zYeebmaGlVjhK4Z+jpaHZQCTWDIjxp3mSpVkx/p5uFdCuVuvL8WKIqAg1Ar49
	 YOZFgXDYBTsQJ8CI13nHhSHBWdZqif2WEd4jKF2xYjwvRIWpMYvX5iPnJBN/t1apsgWGw
	 Y/533j0o0Q6lWD2UQf6avRYsFShpjg3ArsH0tz219+f/UfixMPpppXEKkaLhl7Znbgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hhfV7rDvQGkX8svztm1wWEU7DwBbew5Nukh/CQf2+fA=;
	b=a6tYa+mAD3ezogJz/mV91DSqWiCdkYezRAoRjfo8gDQufqHeU/82UDQnomdT+nxSOYjw
	 27gynuKfo3ih2QddQv/BPn2gU7LTHNJm6cjIH41Wd2l4xU82jyDLp304/Jys9p6QXW5kp
	 zpM7k1qCuACHLlqXqP07IhowMeCEf4SDPZY2CB4hOFcdTHIKN+XmvpwmzBWV+zff/lP6c
	 1qU0Sdt6uXPu5PtGDGKZkJm53I2YGpeDlTY+7zST2IlvLY6pOABqyufKSH3+6fnu8HER2
	 Um1k42L+iFcRYgxlbdywTmshbSlrB1BHIA+ioMw+n3mDG7DDP8qN2N//qpb9qqxIA5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vg4j30II;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AA606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA1AA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vg4j30II
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso1796038a91.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490875; x=1796095675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhfV7rDvQGkX8svztm1wWEU7DwBbew5Nukh/CQf2+fA=;
        b=vg4j30II83qAo21CgEp+YvJSc3iCY6B0L3MN5figp/Z8qazJdhaWBFFdUXkguA/Bev
         Ik6ZXKxLyog7KvafE4ASlOlqQkYn8tSoaWsPkXtUKyWSv6EWR5QEvMzGs5cGp75q9c2l
         MZHuaHaRRX66wjT+++hqhvwc2zoaDRAXY/U9F1SsrFKcTJg8xpbXJm5GnqKd77bYTRhW
         G5uO7X5FT94I8EAGIggAi/fUMsAz0Q1j9xdhyd/Lfuol51vKjnjptGN345vvsBtBVjZ6
         6pAQYvicZqoT8aSZ5tfC2oHkBRwKsUEPdTjDvmAcJ/V8pdSHaLietMzs4+ggAJK2Fktq
         p+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490875; x=1796095675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhfV7rDvQGkX8svztm1wWEU7DwBbew5Nukh/CQf2+fA=;
        b=TxNweCwo+CrrQ8rjGuphQ3AtkMSzpemYxaytEMahpIQiVO33/8s9JNRocXA3bhU8kM
         CtDtHVpkznWr16FpYSmQpBhnjxNsAvoCWmGyYPRhFfYUsGaA2TCNFNl3002ckBykxW0/
         xLOCCssdQKNYtczca19aTO1JmkiYnv0pntEhctiYT/zN7eRdbgByCIJhMrgvZh57OmWB
         7SsOJMTEMwBI+iRBj5SnIq9Q1cG8s0Jhg/KhxpD0VARc744/WHAuRMTCdOiznKwBIEJK
         PhMCf/oQ0JDE1G7Q2nmycHsfCaJgq1hPJ6wMzLww4R6mq4viflSq8tRY5fuwEosz3CBO
         XpHQ==
X-Gm-Message-State: APuU4Z8VAqDpYM8NUS0u5wxB18o3Erut3cfAj8mxqSJnoTS1N8AtB1Em
	AX6MTFbKfmx7Wg2BGLL93zGzcmySEcaSuzFob0UcmVMFHGix7JAKGfd6
X-Gm-Gg: AZFdTZfe8zL7/IYMom3Ai+oD8FXmSVRjYfWLLGX+/ytlf4hniHJVr4JWJMNvHAj6zm7
	AZ/Nn9mRQK1hfoi52dqfFSV/3/gxlXSb9j6MynxspuBLF3qOCg4Z+Dh9bNqkF9AIvqNgTbG6y9m
	LpHYBCT34f6CE50FCOH9AGtqIkBaklrQMcvk5u7xgYdU/9zhUXJtZVRZ/ktUhYD9HQCOBUOEg7T
	NPIohzpXZLqHKEEPhwAR8cZ4j3Amup2rRQdNOy9aBMV4eSyow+1ZKqivUkvkq1oMhnnfYgUuH3z
	w3BpeQypfHrf225CB958j0ZZ8BYQ5FyH2d/6ALrpTh53SICry68UPwMBXGS1dl8aJNkw/wJcpGZ
	+phBuU9aAP4puxl2p4+fjOLmWkQ4VLIJeVRm/KgzQ+iMrUwL8sHeXF3Lyc76AjZO34ogAFn/k0D
	yBERBd/7gqtKCn3xs3F+T40Tj+ns3Otu95/6yUPfZ72DST0gCuZnArJlFddHg1Df54xcUMuaQNL
	oGVqwugaoytI8nFiYd7heaLl7a+DxcyXPdS+YgZHZc1ihOR3jqs3xzKwza9Ft9uKLdzdIlt+mTO
	8fAYQX+rsaXQTbz7IeUFzBscl3YmJ5QhXETVBOuZ+bxeI6sZivXE/bW4DqlgUJnfDUMRsYoR2Cu
	TnNo=
X-Received: by 2002:a17:90b:4490:b0:3b0:a7b5:c044 with SMTP id 98e67ed59e1d1-3b41c7bbef0mr8070993a91.1.1795490874885;
        Mon, 23 Nov 2026 19:27:54 -0800 (PST)
Received: from normalone-940XGK.tailec472e.ts.net ([117.17.158.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm24008676a91.2.2026.11.23.19.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:27:54 -0800 (PST)
From: Younho Choi <gdool88@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Younho Choi <gdool88@gmail.com>
Subject: [PATCH] KVM: x86: Reject SMM on VMs with private memory
Date: Tue, 24 Nov 2026 12:27:48 +0900
Message-ID: <20261124032748.1221979-1-gdool88@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A VM created with private memory (KVM_X86_SW_PROTECTED_VM, SEV-SNP, TDX)
reports a single memslot address space, because kvm_arch_nr_memslot_as_ids()
returns 1 when kvm_arch_has_private_mem() is true.  Nothing, however, prevents
such a VM's vCPU from entering SMM, in which case kvm_arch_vcpu_memslots_id()
still selects address space 1.  The existing comment "SMM is currently
unsupported for guests with private memory" is not enforced anywhere.

Because address space 1 is initialised with generation 1 and is never swapped
for a private-memory VM, while address space 0's generation advances by
kvm_arch_nr_memslot_as_ids() (i.e. 1) per swap, after a single memslot
operation both address spaces have generation 1.  The per-vCPU last_used_slot
cache in kvm_vcpu_gfn_to_memslot() validates only on the generation number, so
a slot cached in address space 0 is reused for an in-SMM (address space 1)
lookup.  After that slot is deleted and freed, the stale per-vCPU cache is
dereferenced: a host-kernel use-after-free of struct kvm_memory_slot reachable
by an unprivileged process that can open /dev/kvm.  The same aliasing also
leaves SMM-root SPTEs that mmu_notifier invalidation never zaps (it walks only
address space 0), and can trigger a BUG() in the TDP MMU.

Enforce the documented assumption: do not support SMM on VMs with private
memory.  Stop advertising KVM_CAP_X86_SMM and emulating MSR_IA32_SMBASE for
such VMs (which also makes kvm_inject_smi() and guest-driven SMIs fail), and
reject enabling SMM via KVM_SET_VCPU_EVENTS.

Fixes: 89ea60c2c7b5 ("KVM: x86: Add support for "protected VMs" that can utilize private memory")
Signed-off-by: Younho Choi <gdool88@gmail.com>
---
 arch/x86/kvm/svm/svm.c | 8 ++++++++
 arch/x86/kvm/vmx/vmx.c | 8 ++++++++
 arch/x86/kvm/x86.c     | 9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e30ee8062..0b8cd1502 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4841,6 +4841,14 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
 		if (!IS_ENABLED(CONFIG_KVM_SMM))
 			return false;
 
+		/*
+		 * SMM uses a second (SMRAM) address space, which a VM with
+		 * private memory does not have; SMM is unsupported for such
+		 * VMs (see kvm_arch_nr_memslot_as_ids()).
+		 */
+		if (kvm && kvm_arch_has_private_mem(kvm))
+			return false;
+
 #ifdef CONFIG_KVM_AMD_SEV
 		/*
 		 * KVM can't access register state to emulate SMM for SEV-ES
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82eb891f6..b6d5b33c1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7098,6 +7098,14 @@ bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 	case MSR_IA32_SMBASE:
 		if (!IS_ENABLED(CONFIG_KVM_SMM))
 			return false;
+		/*
+		 * SMM uses a second (SMRAM) address space.  A VM with private
+		 * memory exposes only one address space (see
+		 * kvm_arch_nr_memslot_as_ids()), so SMM is not supported for
+		 * such VMs; advertising it leads to memslot aliasing.
+		 */
+		if (kvm && kvm_arch_has_private_mem(kvm))
+			return false;
 		/*
 		 * We cannot do SMM unless we can run the guest in big
 		 * real mode.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff..59565747d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3050,6 +3050,15 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
 		return -EINVAL;
 
+	/*
+	 * SMM is unsupported for VMs with private memory, which expose a single
+	 * memslot address space; entering SMM would select address space 1 and
+	 * alias it with address space 0 (see kvm_arch_nr_memslot_as_ids()).
+	 */
+	if ((events->flags & KVM_VCPUEVENT_VALID_SMM) && events->smi.smm &&
+	    kvm_arch_has_private_mem(vcpu->kvm))
+		return -EINVAL;
+
 	if (events->flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
 		if (!vcpu->kvm->arch.exception_payload_enabled)
 			return -EINVAL;
-- 
2.43.0
