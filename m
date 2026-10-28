Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214182;
	b=PWohJynoSANNrFJP6s3WD8yISa515NbLs3qVE9EBqYHvd286u7QFzGb09NoUaKaIXkV/
	 jz7LCiwLcCN3OSIPDu/YrWyFggg+itHMUJ059n1Gtv8HT8tIhhmKxfWCG5+19vc2xBZAY
	 4w3EXAlOyhDK2Lj4AImIgdfBLZ2G8PadeBkcu4FBjQI9+204O2z+M/7mXMV1WQ6iwqqo8
	 M3y5Q+ZPMeXY1wBw0o1Fy2mD/6ijJDW6lVNlidIpp/0sLC1ypPT0HIyImAc1ScuC6uLVy
	 os/V/B4UV7b3taz5FrP1YrbFSMkwSbphAuyRMYYi8oUaF5bPxo60I3DJpc+kxKDYDkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HbuVr5an123e2WdNsh7qTkraPx2QUzUAuDpOvbvX5g4=;
	b=fDFWQ6HYtTSInBXXyY5Ks/kC4GmxUAR+ErufEohHlmeadZnaDCX+zjBVGe1X9ND8sOmx
	 k+AsRh6i9KDTkg+tdGceik2llo0H0rvNeM9q0uFSIdwaIUrXEexdw270moo+EARTevtdl
	 eGQQIBvAPGoAmq6uxEueXKvqPd+LeIz3yp886NBHoWTmGH9w9nvQEZq7Xd3oS6j/3rcm8
	 yUkEmBKdtd6RRS76WGsqmgtE1yrIvTKIoOgSGsNHOJTssBr1r/za9kuXVjMmJlZu3n9ge
	 0coo2FiRY4ztQHtCgcjwjIudSraiYAijMo3glO6LaOw/zKss8VC3igBuW7z4dFlLChg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oazk4ysR;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC33606A32C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC33606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oazk4ysR
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so902397b3a.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214182; x=1793818982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbuVr5an123e2WdNsh7qTkraPx2QUzUAuDpOvbvX5g4=;
        b=oazk4ysRjdwfkIurL2Hux4Kh/9Lmhp3O4to7NmvuC48V/8/s1Tvy84hkvcMbPTXCCd
         0hrgfiNjdcVVh6RFnnKijtunaeGCSbJ/7pT7Bq2dQuesfeUkdVrexYiSwysCQatEGkre
         g+F8Da800Cic2G5Y1xA+3dVNa56bEgy4+mluJlVbhiE/zWiK39P+ZwQFlToRiupyikih
         dACSL8Ti6LkiEcBU/6AIGe/SSAKgWblIWdj39QcU6IEByfG+neiGgyUNYHFf9FaJpxAz
         d6Ulecj/CBNT2ReIVzU1K32hqGy/e/zJcwmRNAz4sEtQDf3yDc0mDnP8EIqaTR+BWjMJ
         chpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214182; x=1793818982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HbuVr5an123e2WdNsh7qTkraPx2QUzUAuDpOvbvX5g4=;
        b=rYGfVvXuCgya99eCDKcKihWk4RErOk6iaDx3lm2eR8vAYLm/cVeJqteWOz6ufWi4+P
         TZLR34wxcP8hE2RPC7XB0+CziFbFREPKsdlefhjyaU+QfqsT2XYGzFX0WxXsi7/kfLE0
         g5bGrgSAYFC+/vt7Ljm/55QiBjFtXzv+SGnoaU/cxIBnKHrjwgtIdolHhLwqSdX/u61z
         Zt2L9PanQSRRyplYdr/5E3Sw0bKpuB2tBvzFqxXatfhMchn4YnzzCzhnR2q3JhuJHKRH
         13+L+aNePDphoLGmw3A5F6gxpwDiyG5v4sj2Mf+WrQS/VOOgCKb1IoBienGPjh5GUOE+
         Ez5A==
X-Forwarded-Encrypted: i=1; AKwUvBx1n6PLvIkkVIXYvfbH8X+kxDa5GOoY9/PA2Ubdriw3cR6ZpiXIRMJ+fQqBOa+krVjlX9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+WJADUzS06yHmfahtylD0yqRFCjaXn+Mx5AU2r0SgNjQ3LQSJ
	UpYIiEy1lX5WTxWBKFIhEOgbu9qXIn4GUus8venLCSYu1i6VzvyudINoNX8kVXhb+Z/PY4L4L7g
	hK6IFKA==
X-Received: from pfog22.prod.google.com ([2002:aa7:8756:0:b0:8a0:7e84:9992])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:18a8:b0:899:55e9:880b
 with SMTP id d2e1a72fcca58-8a6e72dc7admr2727923b3a.14.1793214181492; Wed, 28
 Oct 2026 12:03:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:52 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: Ensure WAIT requests actually wait
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug in where kvm_make_request_and_kick() won't actually wait if the
kick races without another non-waiting kick.  The issue is that all of the
conditional kvm_arch_vcpu_should_kick() implementations are missing this code:

	if (req & KVM_REQUEST_WAIT)
		return mode != OUTSIDE_GUEST_MODE;

Thankfully, kvm_request_needs_ipi() does the right thing, so this doesn't
affect kvm_make_all_cpus_request() or kvm_make_vcpus_request_mask(), i.e. it's
limited to x86 SNP's used of kvm_make_request_and_kick().

To fix, address this TODO:

  /* TODO: merge with kvm_arch_vcpu_should_kick */

and purge kvm_arch_vcpu_should_kick().  As usual, PPC makes that difficult
because it has wonky code that is poorly documented.  For reasons unknown,
kvm_vcpu_kick() unconditionally returns true on (most flavors of) PPC.  To
preserve that behavior, add a compatibility wrapper in PPC, along with a
@force param to __kvm_vcpu_kick().

This series would ideally go into 7.4, even though it's obviously not small,
as guest_memfd in-place conversion massively widens the window where a missed
kick+wait can lead to the host trying to reclaim an in-use VMSA page, which
is generally fatal to the host.

Sean Christopherson (7):
  KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
  KVM: Add a @force param to __kvm_vcpu_kick() for PPC backwards
    compatibility
  KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
  KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use standard
    implementation
  KVM: Move kvm_arch_vcpu_should_kick() to common code as
    kvm_vcpu_should_kick()
  KVM: Plumb the full request into __kvm_vcpu_kick()
  KVM: Drop kvm_vcpu_should_kick() and use kvm_request_needs_ipi()

 arch/arm64/kvm/arm.c               |  5 -----
 arch/loongarch/kvm/vcpu.c          |  5 -----
 arch/mips/kvm/mips.c               |  5 -----
 arch/powerpc/include/asm/kvm_ppc.h | 13 ++++++++++++-
 arch/powerpc/kvm/book3s.c          |  4 ++--
 arch/powerpc/kvm/book3s_pr.c       |  2 +-
 arch/powerpc/kvm/booke.c           |  6 +++---
 arch/powerpc/kvm/e500_emulate.c    |  2 +-
 arch/powerpc/kvm/powerpc.c         |  7 +------
 arch/riscv/kvm/vcpu.c              |  5 -----
 arch/s390/kvm/s390/s390.c          |  7 -------
 arch/x86/kvm/x86.c                 |  5 -----
 include/linux/kvm_host.h           |  7 +++----
 virt/kvm/kvm_main.c                | 28 ++++++++++++++++------------
 14 files changed, 39 insertions(+), 62 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.313.g2479322e68-goog

