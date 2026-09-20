Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47643DFC6A
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889108; cv=none; b=JtlljRVYLj9TBc6lU92E2cQaGSebo3JYGjkaCkJNu+kCUrWK8kPCZXHHpO0XlELY3nAzFq/r1BxQ8C0xsKLn9azzOhpaAxPfpvpN3N2qGvmxMepObZtSUPcigIXJnxFlj6M8+fJ2A0VPJ7etq0t805ZjHN2cCQIIE1P5DuOV2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889108; c=relaxed/simple;
	bh=IUta/M2tNKvfaLoq2NlbsB84SShrqK6/UdO94LXNBYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0YczZhaRo9Lsab0fzVl3F0+/rDZlrSa1yPiYZfGKOyHAkT6u8kkUxSxpxa2JL2e4Gb6+S80z09Z3bz0PBlQO5XQHnl+XNYMnDCrNGx1pOI9JANrBwUjjEofIlgYbEYo13f/s2qEkq/v7hjwhwjrX/d00iq5ZWkkv9MPxfxfqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6uNyAkm; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6uNyAkm"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so1001137f8f.0
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889104; x=1790493904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vC7mWH/mIfDgj2VP2g28i21vIin0AtG0fS/fptEVoY=;
        b=Y6uNyAkm5l2Rq2e/PZy0RG3K5WKKD+rP1RA/qBdJrN3VmEy0RXXkvQvOSHCOXrZB+3
         pEkP+nuipxO94jFFM80MKUQ413HStE4PZoiQY6/Ho6l7tfr6Ko3DA42JMkPc5KA2GLL+
         yl2d8JSXV2+dbuv7emfD5pu1DP1yn/aKs/FMZoYv/ZewU9nKJKUKhq8s+ek18oBzu/S0
         d5rJqRogiOlC/QE26FsC+LH5G9b9ux6iX7Gl2XJqDi9Vi5weokivNAPnxpzWTYdhD02F
         3e7hj8HFSF3ZfXO7hERRVMqQNNQTAyJ8ObJx/zjt/jOGMgf9EZpR2BxGfZiKc2oqWzgX
         WSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889104; x=1790493904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vC7mWH/mIfDgj2VP2g28i21vIin0AtG0fS/fptEVoY=;
        b=ld7cnnyeWdVA0UfByk7FFfiK+Y928ZJw9IcONJugSmYHHTyWfFDyem5AnENS81z/P7
         6sWf1mgu09NsjK6alyMmEM7/65jK1X2ZO02H5dZXGUMf4UMRUf7eR/f9rgiM4c1RC7CQ
         Vgkts6yVmD8NVpjs1mmb/pUKPLBZixiAHSuG42p3P1g/2zWTuSNmVUscX/VtOKaWojjl
         MqEGk50QKW135CNoP9+RiQWs3KxpE6vyx5Lskx0JN41XTV6FH9+q1A0PlViR0nW6b5Y2
         3xH6IhR2A1vOkOR66IycmULGlzXnYcwlY2CeanYvNRBZsW2a+epN+D3xDlHg0mFDEeOS
         3Vfw==
X-Forwarded-Encrypted: i=1; AKwUvBwCFbXZlWKzlbAFc3Mu2DddvbN9hm41jmI3iKLg8uniA72z2yBt7CwAB/VZsKRpnrFVIUY=@vger.kernel.org
X-Gm-Message-State: AFuF++mWJCPaKkIg8HlZqNk0pLmKY4E88AvHudRnLytinpAVA3klR/eX
	qi28H5mEHPfdIUSEvnihKOymKO5WUVJmUEGHeDlLhfhv3RHypgqIsogTkRWW3G4y
X-Gm-Gg: AYBFou1gO2Ehhqbyyd7bhtsnoTg+el60xLxBudfEM0u8FOrAnayH+GzsDyhluj+YsQB
	5WuLorrtYrf3m4SpbO7u2NCyMpe+f4QYzv/lAL7w9fVJU+Gw76L22JEiK2ZPukrrUKP7e8V6viu
	OoLY5abGhsgcpvL+zNiyAp8Msyzam6qbhKVQBtLKG496bd7xs6syRY4z7X+pv5AkJGecNzUfPqY
	QlTPFsjO3fZwvjeehZx1efqGJAi3nXy1rnhBGnqDcjf3aSeAWGdeHB42jcXzO6TMTOI0dIntALP
	8AQLjNTMs5wOPqRVcjAFkrPII30KG1oe4c4IjyHG/f8BI1RqwR4rCUzUbzD9mF1ICFA2k2s9dCw
	928iV0Oxil/7xj9Kzwoczyz3y85iwW11bNF3XQRKEZGhC+fWTAmDoY7c9/iMCZpH6DFWeq00CDe
	2mjj80LASfCmf1CCMkz+X0hhgXsylEr3u+ZRChQMF6pUqcTIT1HMUrMfbPRAh//uNgt4gs9GnoA
	++s
X-Received: by 2002:a05:600c:3496:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49fc57226d8mr106507795e9.11.1789889103983;
        Sun, 20 Sep 2026 00:25:03 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm125191575e9.9.2026.09.20.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:25:03 -0700 (PDT)
From: mike.malyshev@gmail.com
To: seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org
Cc: amoorthy@google.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	xiaoyao.li@intel.com,
	yu.c.zhang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH v2 2/2] KVM: x86/mmu: Convert can't-happen fault path EFAULTs to KVM_BUG_ON() + -EIO
Date: Sun, 20 Sep 2026 07:24:59 +0000
Message-ID: <20260920072459.3485710-3-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920072459.3485710-1-mike.malyshev@gmail.com>
References: <20260920072459.3485710-1-mike.malyshev@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Malyshev <mike.malyshev@gmail.com>

Four -EFAULT returns in x86's page fault path are guarded by
WARN_ON_ONCE() because they describe KVM bugs, not conditions the guest
or userspace can reach:

 - direct_map() and FNAME(fetch)() completing the walk at a level other
   than the goal level, i.e. KVM's shadow page table walk disagreeing
   with the mapping level KVM itself just computed.

 - a CR2 with bits 63:32 set on 32-bit KVM, which the hardware cannot
   produce.

 - PFERR_PRIVATE_ACCESS set on a reserved-bit fault.  KVM sets that
   synthetic bit itself, and only when PFERR_RSVD_MASK is clear.

Returning -EFAULT for a KVM bug conflicts with KVM_CAP_MEMORY_FAULT_INFO,
which promises that an -EFAULT out of KVM_RUN on a guest page fault
VM-Exit is accompanied by kvm_run.memory_fault.  Describing a broken
KVM invariant as a memory fault would be actively misleading, as there
is no guest access for userspace to resolve and retry.

Convert the four sites to KVM_BUG_ON() + -EIO, the established way to
report that KVM is hosed, so that -EFAULT out of the fault path always
means "guest memory access KVM could not resolve".

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/Zr-8M9rYplgN6IS3@google.com/
Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---
 arch/x86/kvm/mmu/mmu.c         | 12 ++++++------
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 244575f576071..6529ff9e98358 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3577,8 +3577,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 					     fault->req_level >= it.level);
 	}
 
-	if (WARN_ON_ONCE(it.level != fault->goal_level))
-		return -EFAULT;
+	if (KVM_BUG_ON(it.level != fault->goal_level, vcpu->kvm))
+		return -EIO;
 
 	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
 			   base_gfn, fault->pfn, fault);
@@ -4942,8 +4942,8 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 
 #ifndef CONFIG_X86_64
 	/* A 64-bit CR2 should be impossible on 32-bit KVM. */
-	if (WARN_ON_ONCE(fault_address >> 32))
-		return -EFAULT;
+	if (KVM_BUG_ON(fault_address >> 32, vcpu->kvm))
+		return -EIO;
 #endif
 	/*
 	 * Legacy #PF exception only have a 32-bit error code.  Simply drop the
@@ -6658,8 +6658,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 
 	r = RET_PF_INVALID;
 	if (unlikely(error_code & PFERR_RSVD_MASK)) {
-		if (WARN_ON_ONCE(error_code & PFERR_PRIVATE_ACCESS))
-			return -EFAULT;
+		if (KVM_BUG_ON(error_code & PFERR_PRIVATE_ACCESS, vcpu->kvm))
+			return -EIO;
 
 		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
 		if (r == RET_PF_EMULATE)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c8ec47b09264b..8e350095508c5 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -778,8 +778,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 					     fault->req_level >= it.level);
 	}
 
-	if (WARN_ON_ONCE(it.level != fault->goal_level))
-		return -EFAULT;
+	if (KVM_BUG_ON(it.level != fault->goal_level, vcpu->kvm))
+		return -EIO;
 
 	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, gw->pte_access,
 			   base_gfn, fault->pfn, fault);
-- 
2.43.0

