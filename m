Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832650B407
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746356; cv=none; b=HmnfzregsIeJxLH6W+GxgSKFvcXaVKvQZNduPbqSnuQsTvkv6wq1FuIyrU07Bgv9RKLH25nlpoHfReXRwdXbw//vle0d4SBpG0qPqmZ7E8oqcW4yLgFBHfGwU90/HfYPwsOF/O5UZOimWkzI2G653MVFZIz2jEbti40qqINNiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746356; c=relaxed/simple;
	bh=YBhMRCjXhrl0x9ETkgVjR+gi41jvBCooiZhKb3nRmV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kv0+50rS+BIZFXE1wJqtpRQi926nAdvtChnq0RPy5ojbFCaOgrt+S8YKBb8xEn6EpnJSExzhiH98c/hV4SE+36KJuxjE8eq50KbDoUW5suk1sAPtd7DeBR0w8xaE6AuFtMu0HryXrGs+ElEecyt3akl1ap4d6Y8wWzMhBw+QCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK+rpOZX; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK+rpOZX"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso1753201a91.2
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789746354; x=1790351154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R++qxNNJJnPJa7wkOafzLmSyQyGcVXcxVtQxZqs7iqM=;
        b=QK+rpOZXHn6iLNjK6l/itjf2+N4qNveYAKl6TD/uTlapuDiBkRODcihFZQaFEcOIez
         IzMl6V9keua8y7IM+S2AE7cx8RpS/493tXGr3UAMFOyZS4R0nmuiVqCbrNJm36k+PUPa
         2xmobsvk93CMDNOum3Dh9Av+Ml7mLpbZNs+g6750JZXDladxBINK/gBsTgMgj+i3sEck
         QYKcnJmdvdoyaDsvAASLEV5JVK2Ib7qx6zRtNOV2yrZFFFvpCOoU/D4zrEimADcRlis1
         DBvXUERIU8s38pFEjpChbQiTQvSdMQc6q0LisZ6zqg2BNy4A/Rblc4zVlgUhKfv6XafR
         whnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746354; x=1790351154;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R++qxNNJJnPJa7wkOafzLmSyQyGcVXcxVtQxZqs7iqM=;
        b=PCmHlZS8srQf/94n1YngHxUDl2YGHnFbxgS7bnu6chXJYUPmB6BCv2G1YZVpqVO6pX
         VUi/nFeaEnaep8/0v2ZoDmFslAfyeQjGYbAZXjQ9q7P4ij1cGhxsXGbgtIcrD5MtBs3w
         JFf9i//qOn/AN1OJPvwvNPWnNnHhA+CVC/Q5o8NV32jMSiyqC99XSXj4YfSWB2DSaCJy
         hHTTD7n0dPKLJbBughYV9YLF8Kn72TU4trAuJm1UXSRRlio9kV/uWjXyrmTmjjv9wJbz
         RzOtMnRjDy46dQDWaxrKxEBzI2sYtY2nU/odfFtuLF6HdcAwZ9AMnOTHSORAIOi2lCvJ
         aBpg==
X-Gm-Message-State: AFuF++nIU70g4WeUAODtHF1yQbEcGtzXF0WauPUJ3zmZE1J8gH6Cjb4V
	vDHK0g2ePtyrJxr0PuLEXl/q4UI6NoZOOGov8VPGJUHNoAaSaO7Uj0VLxhmN4+kJk7yXfrq6bSF
	jpVUXtafV7tMieQ==
X-Received: from pjbiw4.prod.google.com ([2002:a17:90b:4204:b0:39d:a2e8:6890])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57e8:b0:39e:4c7f:8b19 with SMTP id 98e67ed59e1d1-39e54d458b7mr6747764a91.30.1789746353963;
 Fri, 18 Sep 2026 08:45:53 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:45:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918154530.4129698-1-jmattson@google.com>
Subject: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported is
 set in guest CPUID
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikunj A Dadhania <nikunj@amd.com>, Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Reject guest writes to EFER (and nested VMRUN with VMCB12 EFER) that set
EFER.LMSLE when CPUID.80000008H:EBX.EferLmsleUnsupported[bit 20] is set
in the guest's CPUID.

Commit c53c632592a4 ("KVM: SVM: Disallow EFER.LMSLE when not supported by
hardware") prevented EFER.LMSLE from being enabled in supported_efer_bits
on hosts that set EferLmsleUnsupported, but missed checking the guest
CPUID capability in __kvm_valid_efer(). As a result, on a host that
supports EFER.LMSLE (e.g. Rome), a guest whose userspace VMM sets
EferLmsleUnsupported in guest CPUID (e.g. for migration compatibility
with Milan, Genoa, or Turin) can still set EFER.LMSLE without triggering
a #GP.

Fixes: c53c632592a4 ("KVM: SVM: Disallow EFER.LMSLE when not supported by hardware")
Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/msrs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..6dbaf063cc8d 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -598,8 +598,11 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
 		return false;
 
-	return true;
+	if (efer & EFER_LMSLE &&
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
+		return false;
 
+	return true;
 }
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-- 
2.55.0.1082.g2b9226bbc0-goog

