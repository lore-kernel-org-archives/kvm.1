Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C837702E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186519; cv=none; b=niTZjeTsbvVwVXBlVQoESQsR1EebeFEVd1Ctr/RruOcgjFN/NfjzA2iQSSfeYrzM226FrqA5fChSIdGg+XTEyqkxJcwuiasGzAhydsGoB5b2MZVQWNHE6jJe3IrMhd3ydBEb5S8FcloFTY+pASnhtmtTRNbup7A3hkM3qPoDXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186519; c=relaxed/simple;
	bh=xCDwucmupayRYkTSNgAJKJM1Jpc03ttRTH1AoKY5ATs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qMppao+EZvjS23528ShEYQl7bvwpntQfb5BsfCCtZMB1XHbxYtRgUDT+KiBt2BX8ICS5936HthRUGsYI2yynd9mRPB9r4kKcEehURlSRy6RwIW0T2VBj7fwJjXPfd6ukVeHjakFvZt+Wi6mWP6sYvsmonsYiSSYas8eLLS10iUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIypkxYU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIypkxYU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4a6bb316so101126375ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186517; x=1773791317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6fM2QIGctUiFaljLqwWiYors6lECqRI6f/jy34iJVpo=;
        b=SIypkxYUT/LnFS94uwAxYXKpjKCDz0sRFY6e/0kXAji03f1dszoLTe/c2hr3+dkKpl
         7AbiA1cBgQedGRUHQ2ie+u9aKNIvfuGI78umnSokwitcqf36Bw6ixJbaDf4hvevviYX6
         ABYd9QHU3VST/I/luDT+6uhwQNzUfzqrN5vhB1hWfqwWXbhZ5VhluI/yzG58v5MfgkOH
         V6ltpH+uokGlP+NccWTM1GQSHxf8rwYih7Q0FWK8+GAuF1nldLHLX3scq48RNClfHMYh
         ByHGDbsrr4ubB/frI5xX+cZgxzCHOym4J4GQYseKMBRfQO4yTbVxq8Wa+nhD4JuXGXTx
         Gxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186517; x=1773791317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fM2QIGctUiFaljLqwWiYors6lECqRI6f/jy34iJVpo=;
        b=JMbwKTYLG2QkziN1h+LXMDVcN1jLVzIV5cW0s2IFWU5s6qy6YJZOZ+A8y7Owrj+tXK
         zqutbmR5s05XtvJyuHn4AACi+xFDASv59mrxJIer4WmSpgexZDIOWhYsSz0mzof8b9gU
         bVw4kd/tButy2Di+OMtOLEdpMI0M2tk77NY9ZYA0swi4WAwO+lvSPx0CA0XyHeCHETU8
         WHqHRHFvR8KCpFfIaj/svFFRkq76l8n3cLngC7K1ch39JEwF0bAt0Mb1Dt1IgBnws1Mp
         sgev66nilYcala9jbFuCTSN1WzAPPng50RGEbTXT9+7NQ44opRZ7EkO2hVHCTHkzMf81
         B8jg==
X-Gm-Message-State: AOJu0YyIIaPVhb7bKplzzceICOidDYH/QUpUVqnbMPh8ChkCfzrkf4Fh
	JboBJ5s4QvdGLsCeodh/IIK/gGfTpshM16Sk/VkuQkZgM3M0BA9zFsCrttHplsxAadIPejNXS9S
	qSx7eiQ==
X-Received: from pgeh17.prod.google.com ([2002:a05:6a02:53d1:b0:c73:9c66:99b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d89:b0:398:9fc9:e077
 with SMTP id adf61e73a8af0-398c5f427fdmr359732637.29.1773186517386; Tue, 10
 Mar 2026 16:48:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:09 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-2-seanjc@google.com>
Subject: [PATCH 01/21] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA
 call in SEV-ES migrate test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Drop the explicit KVM_SEV_LAUNCH_UPDATE_VMSA call when creating an SEV-ES
VM in the SEV migration test, as sev_vm_create() automatically updates the
VMSA pages for SEV-ES guests.  The only reason the duplicate call doesn't
cause visible problems is because the test doesn't actually try to run the
vCPUs.  That will change when KVM adds a check to prevent userspace from
re-launching a VMSA (which corrupts the VMSA page due to KVM writing
encrypted private memory).

Fixes: 69f8e15ab61f ("KVM: selftests: Use the SEV library APIs in the intra-host migration test")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/sev_migrate_tests.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
index 0a6dfba3905b..6b0928e69051 100644
--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
 
 	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
 
-	if (es)
-		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

