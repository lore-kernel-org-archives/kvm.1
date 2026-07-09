Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F313E2AB7
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630198; cv=none; b=IMMoz/vqXK7q4jGil2STM19QrkaUlZO0FX5rYmOll/ERM0mkHO9CfRG6JgePUOK+wyd6WNuIT0w4bhNWPEwqTOOWEpM/xlE/csBCz8yIDhUZnQRIjINxSEkDTLAq4X835CJyKjybBtToXIc2uk7rAfgIV2QFH5oEmUOGw9n2kpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630198; c=relaxed/simple;
	bh=p2C2myNclAnCkdNxxGMPC/IAWyTxuYnNNaDW8Jc4LB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YUfjVHVDS3lQ6twSS0nvF+jcpOI0Mjz9cMDuLRnj73gccmrMO9zvL+zXsCXZ0YPiYkDW+BA1AWVA9Ya5fkfxiXDOqG9d8tA+66UFcuRiHbQiavCZMlsKWN3yCQCcJDAUVXMuGV4WOCFkOZvqGRUMXo0TUA+fJWps9xh31DUvk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5ZZlGFB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5ZZlGFB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c354050c34so2564725ad.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630196; x=1784234996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dg5PWIk+xBZVNHWepnr9z90JNF1w4XrYnESjPtGEmak=;
        b=f5ZZlGFB5aqL2pMdOzh8up1tNLvGmv+mKbPr2ep99oIYvZa6a8RmjoGid5Bx0DNzmf
         rR0wdxZ6jaQ6H/JI2dDCDoC+9Ixsb+0f94s4iOmgaguCkaDkx47Qy1CoIv0wPZtsmOds
         YbZvalqZ0dzhjFZCT199jn5Hw2vN9WZMxyb/qQYUnSwaZd7nRNm75t/A66QUq8hijD1o
         xajE+pQhDdiHefNgBgtF6V7315Aswk5DU0VEdJb4IdfIt80y0CBLrG4dgzoUtuuYmrc5
         Pt6misTErfOZx05+UB6gsTsh/TCu2D0usEmNzX/br6xayrjotVBO35sSCotYVl6h28nu
         j5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630196; x=1784234996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dg5PWIk+xBZVNHWepnr9z90JNF1w4XrYnESjPtGEmak=;
        b=q6xViKZctbxei7hpBGx4S1KT0YSTQCcukQRkR1HF3He30AdD0/DY+bvYaA2kc4oFpM
         +6sL0BDHbKbpmU3QRrLnb1ZaESS221r8GTw3LeE9OEshs1QrTpZVLyszOYVFKmqX+DzP
         Nn2V9aOf1qlt5FfvThg+87Gw151OgEfshMeQm4ou28H4TqCntz/8OC211uLeFTaq6DUY
         BTSEI4bv10J99QHe2cCmINmuKyTQz7bJ8IOvQRaoP065YacnPAzMxFGwRKX2ZslsBrUu
         GEKfFoD+qc6laMLVyX8FPAXhGUe3R32zmN6QTRn/cvAncQIP4ayBYMa4LR2nrlAeRRJU
         Ax6A==
X-Gm-Message-State: AOJu0YxoaD+vfqNmLRGuAo7czGuhg17yqPhnk6Qa7FuybVGQbp0rl7if
	ZE12if7/1H7WvI4QbKSX2NsKmI/b3QE5FAQCy7w4xBxzqNaqIkUUPWYRSXpfea1mIUh5qLguyRH
	8lOR2cA==
X-Received: from plbjw12.prod.google.com ([2002:a17:903:278c:b0:2cc:77e3:3ef0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2f:b0:2c9:d8c6:1dc3
 with SMTP id d9443c01a7336-2ccea287d5amr82275195ad.0.1783630196281; Thu, 09
 Jul 2026 13:49:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:35 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-6-seanjc@google.com>
Subject: [PATCH v4 05/18] KVM: x86: Serialize writes to disabled_quirks using kvm->lock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Protect writes to disabled_quirks with kvm->lock to ensure KVM doesn't
clobber state in the unlikely scenario that userspace disables disparate
quirks from multiple tasks.  More importantly, this will allow wrapping
accesses with {READ,WRITE}_ONCE without "needing" to also guard the writer
with a useless and confusing READ_ONCE (since the RMW wouldn't be atomic
anyways).

Ideally, KVM would disallow disabling quirks once quirks are "live", but
that would be a potentially breaking userspace ABI change, and while all
existing quirks are fully live only after vCPUs have been created, several
MMU-related quirks, IGNORE_GUEST_PAT and SLOT_ZAP_ALL, are partially live
at all times.  Because populating MMUs requires a vCPU, the guest-visible
behavior of IGNORE_GUEST_PAT and SLOT_ZAP_ALL requires a vCPU, but for KVM
itself, processing the quirk (or not) has functional impact, i.e. for all
intents and purposes, KVM can't prevent those quirks from being disabled
after they've been consumed.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..226c6cfe8062 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3939,7 +3939,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
+		mutex_lock(&kvm->lock);
 		kvm->arch.disabled_quirks |= cap->args[0] & kvm_caps.supported_quirks;
+		mutex_unlock(&kvm->lock);
 		r = 0;
 		break;
 	case KVM_CAP_SPLIT_IRQCHIP: {
-- 
2.55.0.795.g602f6c329a-goog

