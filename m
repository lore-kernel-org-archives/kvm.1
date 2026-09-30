Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB041A502
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797002; cv=none; b=c4HV+iECrVo7ao+7j0e7qp2FHLR1Mrrk5arQGt/guwoGlYnAfywxb75N0IEABiE4Qp5PYJKWBfgz4Y5/KV7h40trfw7e0AP0UmBSUrRg/ztMY6WewB6GXM7eWRA9rKNTBENSSpPioMkr5a5uVmT4nsK5QlFzbKXOeZQfLQwvtrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797002; c=relaxed/simple;
	bh=wqr+SMrt7dxBNk54DLAnLV4dP8Pt5nYHC5LIfJSQCT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fefyGJVDbKyeudB1K3M6Yrd0l501Xzm90gOQeHrl/wcL5+jUTP66K2kyuHuc+3XEeb9Tbjta8VugcY6G5kAQTuxhF8kw9mRTRm/EP5frQL+jAitJ5osMZj4erz+RCNf5TTf+hSURiK2oPwRLiuCnESMX5lFbC8fMaRv5oxD35uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZvuV7Qr; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZvuV7Qr"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2e0bc619fso10215305ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797000; x=1791401800; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=APU6Hsi/UB4LmSAjtjOtU74/6EleNQVrcW2jpeijhhA=;
        b=hZvuV7QrFdx5c67bWd4iQoIgSavrp8Dw+9adPylsDquqD9XKsL2/tJ7MFu+vEkbUTn
         xE/WfaQgL/EfzFtv/sX4fFfg2BvvyrtOZlqjnO3I44OHwR2bPVCB8Gby1hhr6It4c3Ug
         LKYw8rXev17e+k062Srd5ggyYowgDCWiFKOVBYv36QkO1x5aKfTGyTp/Lpwg5Y7O/73R
         pxg4eM08O4JI+mpeiRddVWehNQejjqMElxonAqBzzV/9LLNjKdHgmCoXgr6cGNbGQqVn
         G2x1g1rKBEer7SUv9rk5IPlGfjtezahifgYF5frQLRQPdC7SW+hZn4KDs0VFHOixfmo/
         U3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797000; x=1791401800;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=APU6Hsi/UB4LmSAjtjOtU74/6EleNQVrcW2jpeijhhA=;
        b=ZFPWeS1yNXGruSbtt0K+16KimKHyPoWQ+CybAPsVylAqu+sYfXc03+bq/n3uuU+r4A
         6sOTpKfLA1Gzb5jXD5cq+2nzx2zm9VqAIXgpv5TYfQdicA+AgHZsYvtSTyEWQ/lXJfoN
         2ygD6PTcdiFR5FOEOZaG5jZMvllvi+z6eJZKVrCB3rgNHUPXvwYKUR2a9KkE8KyY2FZ2
         49KX9n8tjvqUGqQ/QrQ8z91hZojf2UnFUQeC3es0GoUpZ9GbG+YPAMKPXvZkOURzTSsZ
         herCeesnf59fwIYoZipUIrVsbZ5xD4/oJImg1eyfukDl4opZJ4Fa1QNEDcl2ydTXq1ab
         1ZQA==
X-Gm-Message-State: AFq9FYJ+kmXQmLNM7+6vzBGE2qFZeCpylurs2OukPjkoT34g6ztsLqAE
	TWL/B8k6SZbW1GW/DLRTw1Z2dflL/tlr6RpMzG3Bfi5/pGZEFNlM5VP9pQj70BUKv5xwq7zlB82
	d5SzINg==
X-Received: from ploc14.prod.google.com ([2002:a17:902:848e:b0:2e0:895a:d3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c8b:b0:2df:8b09:93c2
 with SMTP id d9443c01a7336-2e2e4b7cd7amr18282055ad.43.1790796999428; Wed, 30
 Sep 2026 12:36:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:24 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-3-seanjc@google.com>
Subject: [PATCH v6 02/12] KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_dr6_fixed() to kvm_get_dr6_fixed_1() to make it more clear that
the helper retrieves the fixed-1 DR6 bits for a given vCPU.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index fad31b59c622..62075443f6b9 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -772,7 +772,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
+static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
 	u64 fixed = DR6_FIXED_1;
 
@@ -798,7 +798,7 @@ int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 	case 6:
 		if (!kvm_dr6_valid(val))
 			return 1; /* #GP */
-		vcpu->arch.dr6 = (val & DR6_VOLATILE) | kvm_dr6_fixed(vcpu);
+		vcpu->arch.dr6 = (val & DR6_VOLATILE) | kvm_get_dr6_fixed_1(vcpu);
 		break;
 	case 5:
 	default: /* 7 */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

