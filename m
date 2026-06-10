Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CBB3AFAF9
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095711; cv=none; b=VrCgL+sAVyK/YoICJMhLBF0sRJ5pgbIM6w0GCEaF7SnfLjSCSjJTgDgYyRZCUP1z27H4VZSschXGDVVz3iHOfOw9sh5EvPfnUA2Ew6z8aMP+9RS4V4UOSQpt4QnhxSHkwCFIQvyBjLFhKp9yEqZyRoqhc63uSpfEX57JFA1wKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095711; c=relaxed/simple;
	bh=riZ81IAqEmf6Hwmy1+ya0WYzgWuzgKxeYzPxWx62+KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRAQdhLDrzJXZBqIGEIVVkamNgEjpwctL303WIDttH1XmZKt6Kt5fgJoW4nMQ09aZBRvfn0QVPS4P+3vHe8AKkaXudKMeiApdztXpaQMLOi1BPj9M8Fzfuy0vfOTMp5aErnnsjdLSxP6xEeZVizNPJ/q8THPY9KKQ/AljbFbpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctn1JOao; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctn1JOao"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7248622a91.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095710; x=1781700510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wu2cAS+swkyn63SBvPObMrfOQMzmMC7OlLgl4oESrE=;
        b=Ctn1JOaoS4R7XHseBv0AT36nY9ApqcHUzhz8qB5s7cj2MTXjB67ueReRuBvdPARv6K
         J7jzl/J7GZUQrh4tSjBAqUDIjzjDlbMKzmyZk8noUaEdjJZB3fuEAyll/mBW8Od9BBRv
         axFr9OS9o7Znc0nqzfPwbVjYtbzBbxdt//DDIcE3X1c+/2BcD5KM7Q0KNpUnM8bJhFsR
         Ak89Yw1j936BZy/MGyEO/7sP8/rcPJMjlrF9Lppfstm42tM2DlyfqJIq5QW8dgPkh8MR
         1tmsJAXDo7/bdN+S6kwGX9X9Y9lehdD/NmIbRZg/99UJSELsX6i+uGhuZeQRhqOV0aAC
         vMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095710; x=1781700510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Wu2cAS+swkyn63SBvPObMrfOQMzmMC7OlLgl4oESrE=;
        b=eooEIyzQKxEhm8AFsl+N27f7TVQ3o3ET5QNeqJ5kMku8/C7oznbrVv4RYWPy3t/ZyC
         0ZAvrEAEGFRtius6b7HjIG9DKBaj49R6vF8SU4qJq1HbE6zlFESLFxe/R6K4hbCxEnbI
         EeSUXHp9i1rOoGUupduKl9m4I5+JqN2Jw+597kOV5eTYP5nxE13+JdF1LJ4y4M8M/Qy3
         IluzAWovMtD1EYeLFlyaPgp0Apn5DBM9gWzqmWEA+68Y6+6iSq9bhOciRpNYqyUkHeXg
         HPMY37pF/4u5u+mMaGkDq7eoUWNCcqEiZ4nJbCvdjLWWQC3PPr8vLzp+rw/dgFBtb3Vm
         SS9Q==
X-Gm-Message-State: AOJu0YwJeHuRklZwtalIllTu+usez33iLnfv6lyQ4rsj91llNkyZDTjE
	7j2GR44KD1FqQGGGYUcXtIcLQMoKCv+ClnlziCJr5rxYqS7IRM9/axFI6Sq/zw==
X-Gm-Gg: Acq92OGpsuXbG3HVOApEZdiurOdh6mcjsRKjua5johhriBYc753bfWRfZZiaBWizxUy
	Pldird1gZg5orfp7J3HHc3AFu+gSLha/gqxGR9eMCPOzfMX9M84ohBvBxAWWBEtaOIAeLthqAH2
	etMCZUzyESrC4K5gIL/LiKJ6BAP+QQV0lt84IcnrL+tG29r1S1QqskZeta93NTm02LbRRHTpXJF
	aHNhJherqDNRcSR06V6axzevq0M6F+9HrX3YZPXMVuMJLyxLwom2dc01H2KivOxvSel/aQC5XA+
	vwuUEZNB2fkBrco9DWLK4MovrLXCYqDrKHksff57x7zPs37FAtIZ0kUGzclLb+WVcnVkhXSnzcs
	zX0k/4FmtlU+sLT/q5Tt6Ay7OO7RS65sr43KSwvq43xG0qJDIc/ylcSCudDwN5RGuXetJloMtia
	KGEXqkjAFRdGSLj2jpViu364rg1NsFA4UoNoUX1diMRb0rBDANOHm11MKxfz79uQ==
X-Received: by 2002:a17:90b:554c:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-370eed0b682mr27885509a91.11.1781095710200;
        Wed, 10 Jun 2026 05:48:30 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:29 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 09/10] KVM: PPC: selftests: Use u8 instead of uint8_t
Date: Wed, 10 Jun 2026 18:17:25 +0530
Message-ID: <9bbb88d55320ca04608787e05222a865c141d713.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6ec982b5a2c7c ("KVM: selftests: Use u8 instead of uint8_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
      git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint8_t/u8/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/powerpc/processor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 0a65fc3a8d9a..2c1e95c8aa9c 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -256,7 +256,7 @@ gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
 }
 
 static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
-			 gva_t va, int level, uint8_t indent)
+			 gva_t va, int level, u8 indent)
 {
 	int size, idx;
 
@@ -283,7 +283,7 @@ static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
 
 }
 
-void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, u8 indent)
 {
 	gpa_t pt = vm->mmu.pgd;
 
@@ -380,7 +380,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	va_end(ap);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
 {
 	struct kvm_regs regs;
 
-- 
2.50.1 (Apple Git-155)

