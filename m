Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8A45DF7A
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391237; cv=none; b=ivy7Gyjng2DaxZ45+fmOjjR2WkIZid/i0kRb1LMIZNRyclTc3jxvuBuPwLIPY4HlUOf3bAAI2FkPaaVQG99XmJYogfpBXu8gH/hxMJTn9Gm2a+UCTicSWZj7yZE0SNEQmLkdzCSaa/ns1chrxp4P1hu//mdOkWxwYhoNYlp8ajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391237; c=relaxed/simple;
	bh=Yn7iZwfRL+iBGbAsuRhs7RQpTQvIvY4V0qX2H0NjNCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e39l0PRXa98yV1o9ujjAuJ/yeWXcGCjicG2K0zNJrttPZR6UJycjgaD8eDBquy4+NlvOb7KFRySxh++8/ZhDqm/bhDoni47FI2pvNR88/A0muOLOUIkFODBqkxKBc9w7G4yBGeACr5F9TTPWPxW1rByGdcaLDyw1bubNX1O0HSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3k+AhfZ; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3k+AhfZ"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfe48ca1efso20822385ad.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788391234; x=1788996034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o8QpYFg7hPmqiVoT4t2j3x9pF7hOUnJyzFfssLlOpVU=;
        b=U3k+AhfZ9OUsxBw0/VmiToPIoCWwwkyNZgX7/4NISk0OpCjfYLXby7cZcd5txFyuue
         OhZTiLPTnS6zaJX0AER4BLzOS5/c2qBKIYULjb5Vtozs0ncBJUJwwvsRfKObSPxewpKN
         kgQF+5IfqPx5/Dh6M0nNw51qcCPUgVcPiTLzg3Tc3dXfiqCNoUEvxatz26faO890Y8zO
         SJdB9QHY3+NNTqHTHEvuOJ5Uvuh8B5GQiqbiNlJDz5LZ0Oyft172CDerHTDDTaXdIWOB
         UA8cXVOP9lUNqlST9YodGteV+9XfHoquRX/MCCD4FNZhGNeagglRqB99XjFHvN5Vf3Zw
         tD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788391234; x=1788996034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o8QpYFg7hPmqiVoT4t2j3x9pF7hOUnJyzFfssLlOpVU=;
        b=fTsUFDBjetdg9wiXzMVpw+goW/C+OgWI/IplKS5skyD5iyP6FNZT1qXPUifn1NKynf
         GuShl5iffsGN4BsTkBUIkJTTQIRz8W2qWnWJ6ohBnwkDFeLEjUD+Yq7N1iTmjRylO5fh
         m9khrdAKmdqVUQc1aRyXdr1+gYl+f9zw+u6IY7a2TMAgXW02f4FypI6qyWld2CZIzU2L
         Puz5tJhD4djFcm0KWQmSruAJtig0NJ6McJoAIFT7N79g00nJdG488B/QNeSzm8lcdy/1
         s+pv0H2Yz5w50ZVfXZu7qDcP9mGYgdMQ8fT570dsNske/WTzkxj0JYy+ZoACwUFVR97d
         il3w==
X-Gm-Message-State: AFuF++nH+hZEFWrCoOMKg4SkEt47Aqdh5eYyG/rS/VNJUZC9UFJxEStP
	MGQokbpLMhegy2f2bVT+WhNlKAWbtsXkn7GhZ+965LRslYL5lcA/1Vy1OILbKrLf9GeUmUgsl5f
	M1PRrZw==
X-Received: from plje8.prod.google.com ([2002:a17:902:ed88:b0:2d9:a2:2c28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e804:b0:2d1:134:b86e
 with SMTP id d9443c01a7336-2daec5ad579mr105653085ad.2.1788391234310; Wed, 02
 Sep 2026 16:20:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 16:20:27 -0700
In-Reply-To: <20260902232028.2767071-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902232028.2767071-5-seanjc@google.com>
Subject: [PATCH v2 4/5] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Bug the VM if KVM attempts to construct a CPU role with the should-be-
impossible combination of long mode being active without PAE paging being
enabled.  KVM's MMU construction assumes that EFER.LMA can be set if and
only CR4.PAE is set, and will create a completely invalid MMU if that
assumption fails.  FNAME(walk_addr_generic) already has sanity checks to
try and mitigate the fallout, but attempt to catch such bugs earlier, as
this is (at least) the second time KVM has had bugs that escaped into
FNAME(walk_addr_generic), and it's entirely possible the bad state could
cause problems elsewhere.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..81c30e2c74f3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 		return role;
 	}
 
+	if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kvm))
+		*(u64 *)&regs->efer &= ~EFER_LMA;
+
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
 	role.base.cr4_smep = ____is_cr4_smep(regs);
-- 
2.55.0.970.g62bdec98f9-goog

