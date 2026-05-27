Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00540271464
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903847; cv=none; b=kyoZcsrELborj8Zqbuje5kMFUTWr1aBxiDfYIzGR5Q9SMHnxWdzl22qeZjGQHHXUewGTYBAmxZQ2LO039N/pkf/ewxmZkmPOHjDhOGXHNMIylp8TMjU/ht+BsuHqwzeGh9QlYWnICKY1KGIi/PTCPn0SL93rve10kRqHbnQXar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903847; c=relaxed/simple;
	bh=L4aBmkZscckHzJgdPCoO860adQzZJzD5ueN+5Mn4SDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOGDLRJWD6NGsXbzJn8QBbKKHiNJADLRtqE1JuGPSFDoDymSyqzgTxbkCBZFiUqtdP7/D2GQGp+392b04obPLX1sfc1zcYQs6jZbIn2uW20cfNSurKzzfJjlEhnIvwGrTu1CTR1MEuJEMjve4BVLAl0gl8DhUVzEQRELF3NV8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0jZs7YK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0jZs7YK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4654f9bb6so132266705ad.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903843; x=1780508643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXpVA1sbhGRZnbOHNVkVkLddfm7uEN4lJTAwg2kEFqs=;
        b=p0jZs7YK5iaAdyhVawF04ot3M/lf2ggSVdsONqbwSedNe7CdKQ89r4YZZf5xVUfaKS
         b2RDFh5aYjyZ8RnCEn3r9P+s5vENh2J6YEJTUK4L8e5MUMyCOn4GUeQBfHV0NF5vvT/K
         fR0mPaoSqZleYRphZWDATKt2IMl4wgLOrKWXaDp65Mre0+tENgoaOaiTC2s84UTvydg/
         8Y+h26lEZxdNBVK86Di6em88ZfeI2jqFlmBP84jAze5bPGV4I4IdtUBomO1tVZ1Y7znm
         x8j09Bzo9Opl751NHHERHRDORRg03r4P+adcFcwiGa1uOO9f6HA+f2N9Trmfu+inxvEg
         2LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903843; x=1780508643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXpVA1sbhGRZnbOHNVkVkLddfm7uEN4lJTAwg2kEFqs=;
        b=Rtx86ZnJMlzxGxaL7FD/Uojtk8ERuy1N/h2F0M6vbtPmgFrJEe1akHLR+RMd8KE4dX
         upV9LR7nuujEG3KL6hHC5dpUZ6xtDE1Wk3dSdjgaZzC2feolK2oqv/DG90X423+7lk0V
         vn3g7iwgOLtB4ugIfUARpy3wIu9B+nmYZNMgOrvZOjDnNOe4zE2aEog4RzWPVYkpT+lN
         NMd9Dl5pD4miAJr7CXuLDWenTYfJo0vAqX9Mv1kQeCzUFPz89xQluevSAalDpa4wiRtf
         ZZ+msloleixw7U0lsWEqBS9Nd+bSnDd8GkZOeZptVGgZ77GwqEVa8G8Kx/LhLSa8v8Mf
         VGcw==
X-Forwarded-Encrypted: i=1; AFNElJ8HILFDUDtI4z1tBopgWJCknFZtBKlfESLG4j7I1ot/Z/pskGjr2+auAvhNDs8/4F4Jkj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4o9z5bsGhCI3uzwqifiqdRcb+aOQAQA5Qvh8UMC/hGg1uzxOO
	s4i51tWwBOzCR2LQ0+S/neE6+9FFNrRzuPiEE8OS2nUo14U8TyrHmCy+qi9/x27QIByNMSM3viW
	3xl8Q2gN7A3ru1A==
X-Received: from pjuf23.prod.google.com ([2002:a17:90a:ce17:b0:36a:e4aa:ca7c])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:37cc:b0:36a:aa9:eea0 with SMTP id 98e67ed59e1d1-36a6749e856mr22442343a91.4.1779903843377;
 Wed, 27 May 2026 10:44:03 -0700 (PDT)
Date: Wed, 27 May 2026 10:43:44 -0700
In-Reply-To: <20260527174347.2356165-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527174347.2356165-3-jmattson@google.com>
Subject: [PATCH v4 2/5] KVM: x86: Prioritize CPUID faulting over CPUID
 VM-exits in nested VMX
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Cc: Jim Mattson <jmattson@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Per the Intel SDM, "Certain exceptions have priority over VM exits.  These
include invalid-opcode exceptions, faults based on privilege level, and
general-protection exceptions that are based on checking I/O permission
bits in the task-state segment (TSS)."

Ensure that when L2 executes CPUID at CPL > 0 while L1 has enabled CPUID
faulting, KVM intercepts the exit in L0 and queues #GP rather than
forwarding the CPUID VM-exit to L1.

Empirical testing confirms that this #GP has higher precedence than a CPUID
VM-exit on Granite Rapids (F/M/S 6/0xad/1).

Fixes: db2336a80489 ("KVM: x86: virtualize cpuid faulting")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513224608.1859737-1-jmattson%40google.com?part=3
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a78ce0080963..30dcabc899a2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6552,6 +6552,8 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 			nested_evmcs_l2_tlb_flush_enabled(vcpu) &&
 			kvm_hv_is_tlb_flush_hcall(vcpu);
 #endif
+	case EXIT_REASON_CPUID:
+		return !kvm_is_cpuid_allowed(vcpu);
 	default:
 		break;
 	}
-- 
2.54.0.794.g4f17f83d09-goog

