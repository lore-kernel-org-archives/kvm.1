Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37336F905
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797006; cv=none; b=RkmiW7Ozj4aZukfP7KyOAj5vYjXJfGK+2laGHfq/7TaaUwSwAAMLM/kq5ZDfLPXud+mrdErViq7yHcNS8LY7ny6F1B5b2kUMpMEbjzqIOFzMVeZuWK3RSbTr+5UzmVLrGuLeXtFQCgL88hyX0ZYPZR96LFKyQ5a3mwT5uogS9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797006; c=relaxed/simple;
	bh=DulPg7/zXtQerdUkYnqcFrpUyi22iOm3y9XoyUHW5AM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R2kOUz5rPLzThuwXV3hXVeu5jqAWw4lD994IqMChLPO1yLCTC2/nsFDVnFwFEZd+jA161FPNppDTF+R3+B9fxSdplxDELu7znaV1/d6ex9oLgFOEa693dqU67CbqmQ5wrbcnAvc2G4oyuDnwYWwQ7fHUPRpgJkvffs6GBnJ1DRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNexnbiO; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNexnbiO"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df375fb9b2so60465065ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797004; x=1791401804; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sMCpehhuLNfrMqYXSXfBVNBLKe/opomj2fBIBH93FW8=;
        b=VNexnbiOcgH0SB98AVB6grBShNqxtEMs6fXIAcw+TX9he/juBHZXQ7p/IXc4xfxsLc
         w40u5ZmqbmLlVuTUD4k55SQTx/3SMFFOsb+fQgYOeqNnZr3wV/1IDA9C5+F3/HvqF1iZ
         lj2fbsIfrXjsFYr3ZtWlyfNTDQwXzWlHMY7pXCK+ZNvLndJxJq6DSMNKLJh/82d6dZeL
         AE3qi+379TbMVas+CUyUaHcRWaq6bVqr8MRU3fArOK7lQd5BcAXmDSsu2zrXhFK5WR95
         jCy7O6pWYmr4BbPvpsHxTFHEYNlM1nznHscCVDOQdiRmiX0hwdDEIrT/qQQhO1VqL7Au
         FvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797004; x=1791401804;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMCpehhuLNfrMqYXSXfBVNBLKe/opomj2fBIBH93FW8=;
        b=vtI0F0VZ4w9WjeUcjt8L/uvcCimrejVyXI6CXwS4A0Erq/WIY+ENBJ61TIOezh4Ln3
         ecNXnp3utuEYx+38PbpNVYhY+8CrE9ExEPFlgcwZmipEubWXHOSvtmrCOHucYpep62iV
         25GsGDsEWiitywnsPwRJufLNLrAXCidajuenQfpi9VAhQ0qAkE8xi87BYmNB7Q+Jcwn6
         +pkL5OZIoZm4s8wJ3YnXUKF9TIfEv0ISEsdN/4t+qmMyPyHoVWEa4k4wTL9GDant1Glx
         YalISN17qZFGfPeIAAFSyda89K8opEQZP0cNtZ2mWw32h4kjMkWRZ1NaXRRYEYmAfE7w
         VVOg==
X-Gm-Message-State: AFq9FYLnYJ+8SYLnQUwE1Ty/Uq937cP9SYfxpe6KJKCKy4WNNDJwBZJQ
	H4G8tj+KDc+yqO8CuA12PAPZQXWE5fJZtJCYPfwPkfmb06O+V5ynmfFZv11z1kIATL9XYmbRYp0
	LCgP2HQ==
X-Received: from plec2.prod.google.com ([2002:a17:902:f302:b0:2e2:cd01:aaca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d590:b0:2dd:ad73:c98c
 with SMTP id d9443c01a7336-2e2e4b4a5bdmr17303485ad.36.1790797003299; Wed, 30
 Sep 2026 12:36:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:27 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-6-seanjc@google.com>
Subject: [PATCH v6 05/12] KVM: x86: Set guest's fixed-1 DR6 bits when
 delivering #DB payload
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

When delivering a #DB payload, set all DR6 bits that are fixed-1 from the
guest's perspective, not just the host's perspective.  Don't WARN on a
"bad" payload (or existing DR6) even though KVM itself shouldn't set DR6
or synthesize a payload without the fixed-1 bits set, as userspace can
provide a completely arbitrary payload via KVM_SET_VCPU_EVENTS (and
"hardening" that flow is not worth the effort as there's no benefit in
practice).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 99518e3265b4..816c6df8dcea 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -440,7 +440,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
-		vcpu->arch.dr6 |= DR6_FIXED_1;
+		vcpu->arch.dr6 |= kvm_get_dr6_fixed_1(vcpu);
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

