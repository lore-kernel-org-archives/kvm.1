Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963C53B5EC
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080247; cv=none; b=P8DGSd9tMfEy8zDszdGFEUNihUFBQO3MIR95iplnwv+B4UIbXvsx9N/MZDF3TZfApKUmzUWUMA6wbNXOgiGbZGNncaXBZWYsi7HfVC3eBrgzIA0NSRYAOXZaALwGj9T/x0ePC2cM+XyEShyMt1+3KcUK5BIICwdj+v4oe5aIgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080247; c=relaxed/simple;
	bh=lIFtPDefGN4pZKmx1LcIKtuSPr3sotoJH/LTeXaKqYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwL56Y3Qr7k1WEvYRFLxoFtDdQbLwMvZ74ZPcf+JwQRv6cEl1x6jXBd7hbhz/hg9G98X/cCA1VHq+abwIIdZ2DeFQzW/Rw20FDcE1h7hufnaoHHLlGQpBclZ1Ko4gfohoXh3i441JLHkZFxhXi3G+m6+9TtOSA3LXCM6nHi7ap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uq29H1YR; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uq29H1YR"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso8567936eec.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080235; x=1792685035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Gya7QDSttHHSh0N+pmuAtqEl5ohukr8BqBh3CqW+rU=;
        b=uq29H1YRxYT2IC9FG80vA0Ygh8bA7sc4Pt+21gfzuEe5RfLYDUeOdxAnox2H85JyW8
         uaSzB4hkYXKrpTgah6g20OvDrDr/vpcqnWCIpdwpZnBUKZO6Yd5u0xqvlvnrcsk2ggrO
         cX+AxAf+v1It4/TBpm3ayi3kwpVSDH0q/IWpUUnZ/2ZzJWOfBdiabzq/qQqLLcml1AJJ
         PO1BeRZYGFJ8OC6bbmIZGjkWsUBIEYiw0vFnnbxOJYNkuNaf9RzwQ3rKYh97yLcnHRsm
         wr80b85YHofLv83+wiDIaLEa18+8adOm1QJO+vea1EjQFeDVnfDwnGewX+MaFXpgKbIL
         aI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080235; x=1792685035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Gya7QDSttHHSh0N+pmuAtqEl5ohukr8BqBh3CqW+rU=;
        b=voZCYL2VohnhnpCfzjQeeXRlWacL0P9MLOYI7XZi32i0/XmrBccixlt9OC+YTITA2L
         xEiCoCnTUlDUEN/+s37eziwW1wfZtApq1/1lSvVm7wbRIefL+/uXT0pUZCtW+wUh+zMw
         4vSKHVAcUdjvK9uSTxFYm5h46ISwUaG1dUaN6xv1TLruYkPCiaRg3gdyrgSPbT5d7Hg2
         QyWZ1Y/K/bqnoeGmIBlu+yek1edaF7avGECYwxmwBZWxJ+nOngh1Q9vpRk9eA6KoeHQY
         N9lWOvekx5N8tLbR1sJIRBBbT8VcapRAeHjWuvpZl/BQD2fDyJ21ah7DYz3e3E42BqE+
         WfCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxX9GdbMVdl9GLbtaWbzgT/gxLgzqSusbkm6jqnPooABVu06mF+bu1L3ri5jW9QYM7cqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuLQ6uH41n2nBd9RLJQ1q/gUws0r3308rLwXizkIHkdSAY7Blx
	Fx2CV8lqL0DZZY/z56HG8XvbAqxNGLN9P+ufQDx9oa7v6bgo7eqLRCH/ylEiVeRTMZ3QcRhJupG
	toklQYmVB3zMNOQ==
X-Received: from dlcip5.prod.google.com ([2002:a05:7023:c085:b0:16b:e65c:ee1b])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2705:b0:168:3243:c937 with SMTP id a92af1059eb24-16a5fc9167bmr25038120c88.16.1792080234771;
 Thu, 15 Oct 2026 09:03:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:46 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-7-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 6/6] KVM: selftests: Update hwcr_msr_test for CPUID
 faulting bit
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit b16c2aca369d180dc94275343b34966194317528 upstream.

Add BIT_ULL(35) (CpuidUserDis) to the valid mask in hwcr_msr_test, now that
KVM accepts writes to this bit when the guest CPUID advertises
CpuidUserDis.

Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260527174347.2356165-6-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ 6.18 KVM selftests still use uint64_t rather than u64 ]
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 1 +
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c     | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 51cd84b9ca66..64e57cbbd6d7 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -206,6 +206,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define X86_FEATURE_SEV_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
+#define	X86_FEATURE_GP_ON_USER_CPUID	KVM_X86_CPU_FEATURE(0x80000021, 0, EAX, 17)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 #define	X86_FEATURE_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
 
diff --git a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
index 10b1b0ba374e..a9ae72279582 100644
--- a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
+++ b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
@@ -11,12 +11,17 @@
 void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
 {
 	const uint64_t ignored = BIT_ULL(3) | BIT_ULL(6) | BIT_ULL(8);
-	const uint64_t valid = BIT_ULL(18) | BIT_ULL(24);
-	const uint64_t legal = ignored | valid;
+	uint64_t valid = BIT_ULL(18) | BIT_ULL(24);
 	uint64_t val = BIT_ULL(bit);
 	uint64_t actual;
+	uint64_t legal;
 	int r;
 
+	if (kvm_cpu_has(X86_FEATURE_GP_ON_USER_CPUID))
+		valid |= BIT_ULL(35);
+
+	legal = ignored | valid;
+
 	r = _vcpu_set_msr(vcpu, MSR_K7_HWCR, val);
 	TEST_ASSERT(val & ~legal ? !r : r == 1,
 		    "Expected KVM_SET_MSRS(MSR_K7_HWCR) = 0x%lx to %s",
-- 
2.56.0.385.gd3acb90ef8-goog

