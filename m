Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8C353A67
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730819; cv=none; b=ieOU7pr8pCjRxr/wpBpyQ930/ZJT+CRQc3ixgayxVnebTJjDZU7wCXXTx5Yh3L+9te7RW60Uo4sOUxDXduUT+iG8tMbPLgiwPBshP9rXxSaZWLSf4vJAAyk2UoKYUNWbQg+iSxMxZC92AfU1/9rFCqC9a+aWQybZAvOxO9PUeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730819; c=relaxed/simple;
	bh=6Aco7EOhkiIqZeH5bR7d9zgidb7xSicYOKVcT78vcZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3Tx7Vd8cYG8YnjIqsn98Lrqmlq13aATszc2d/v+skovcWHWC+B3/VnXJTCpbdzmNn5kl2YAkKdei8WO+RAfIegDGrLIl/a1wQ6hMxDlP9y5bpJf+yw8+BA8r5kXofp6ta8Tj80hjP87BnnFbVMksBCwHeGIgzCz0QRL/aqjyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gH837w8N; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH837w8N"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d02df2bf09so33914315ad.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730807; x=1791335607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8l2LQZ/K3M62HHlaD3N2qkeE9h03hcQIsVix5OsuQN4=;
        b=gH837w8NqKwJRPRoMiBLnTaoe1JLDwPeVP0RRez+fme2H2/KtfaDkknO1wc+QB6ylu
         3BH8u4OSPfl8Dm8P80PfI/RvfNn5rz2kIZHL17l3m2zlksoAGOSqbHDZYxfyc4Ck4sxh
         CntQgg/TZCOVGorkq1wR5p1LOOEB+Wsa+LbND5zxSQpKq+wgajvJdKVcMTt4fR0wVh+V
         uXReM50s8+5VmgeBFoCLst99gTLo2G5SbpOQF42vN0LnylNRMtcPezllXdqmLodI7V1y
         GyLZfG3xybTnTb/QAQsgPciOvCxyhoRk77UWhf6qiTNWLgT65ovMajvyr6ud2yicfzax
         I0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730807; x=1791335607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8l2LQZ/K3M62HHlaD3N2qkeE9h03hcQIsVix5OsuQN4=;
        b=Pvz/qinJp73howLMVosKBEwBArSpOL+voyPbd8evKuANw+A9K44DfwGH8zsnIGhgVC
         1iNlfeiF0G8JK2hnfIr4HxrSqRXEw8X1XuCp6uO0suolkxLO14ivB/mZwZUINIfVnQN9
         QM7HYYO2FumpraOk4MbsBY5yCzHt9v0ut3rq/qjdrU8UnBicYc4j/6jBGue134kIkRAL
         gt8FX3cWafog8+reNU9R01LXQWBD3lW8hclCljj7TYDf80UsIf96xl0+AndFqxo0IEfC
         tkzBR0eF7MYCzrQpMUtWsHTFk29GGdx030gOqI9q6/9vHxb+BGlDDafd3t6MGNVtchTA
         78eg==
X-Gm-Message-State: AFq9FYJhph/bnhxlt5W+W2HxJaO6YwYkThFOdVPfHbk8IA/RyqW5xBR+
	p77pFiVwcdhVI+KgdE1g8QSeU5FYayvjeY9BXqV/Rw0zQuv6abhdXPzVgp5NYOXG5QRkCButXWo
	qJUTtPA==
X-Received: from plqs20.prod.google.com ([2002:a17:902:a514:b0:2df:a554:8274])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccd:b0:2e2:b00f:564f
 with SMTP id d9443c01a7336-2e2de52a888mr6581745ad.18.1790730807329; Tue, 29
 Sep 2026 18:13:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:11 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-11-seanjc@google.com>
Subject: [PATCH v5 10/12] KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

When preparing vmcb02 for nested VMRUN, force only the actual fixed-1 bits
instead of setting all active-low bits.  The flaw is currently benign, as
the only active-low bits supported by KVM are RTM (Restricted Transactional
Memory) and BLD (Bus Lock Detect), neither of which is currently supported
on SVM, but that's about to change.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c       | 1 +
 arch/x86/kvm/svm/nested.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 0c76cf17e884..3621f1a47d37 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -784,6 +784,7 @@ unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 
 	return fixed;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_dr6_fixed_1);
 
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d3f249cd0f2d..c7a69e309a36 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -808,7 +808,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
 		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
-		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
+		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | kvm_get_dr6_fixed_1(vcpu);
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

