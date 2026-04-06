Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA33A0E95
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516046; cv=none; b=teUqgANIdy4hunLUKnXFYUyub2g5ZtInKCS7MrmMU0ubwr2n6RZnwK5PKecgcqMr9bI2k/F4aZYDWtsxoMLzQXzW9XO1DW1CXxd2MgKQ0bH+fztw2eozcp6TKU1wEutLKmcfvFnCSDUk9UMR4O3jBwoCxf4TvkYsaJagm2cNh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516046; c=relaxed/simple;
	bh=PrIzYzYDOqnyviPg7z9Bu0t4d4Y/A+WX2DYoDsRUdxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9Yr4eYgOSKYuGhor/kTcXQFJ+W2v7besUX+lKJ5MU6Ci9hUYAT1s7gsf+2OsMrz10S+t9SJm7xaFKCpcZDdj7yjx22vBjHJzRwWgDaOJX1F+WQEZABSOgLbJ78SmDsfZ5vh9Y228XExA6+QS01uDoIS2mh7tGxaejDX/NA5oik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gP4x6LPF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gP4x6LPF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c675116f1so6366513b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516044; x=1776120844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FMKpziGML7Zg5ERXIPN3K5TAiZoQQ1DW1+IhEDhwfcA=;
        b=gP4x6LPFVZyvYtzbCCBY/WWbLJvoD2GaZYEqcDM7LUjJdE6dQaKg08F0EsVA4BMLTc
         WZYCO0AkUIzMbJ6/EdE+YdiAidX6X11vvboAhxVas8vjKZOxiYdqyPoA71TsHfkkIiq9
         HvLGvNDQOZKUsNwca/SiTdVYljj4EpeZejqk+9pE4/X/3bOAly7qQOHhDVNfx38ESVqm
         pXKCMCObFSRdc/zjS851unIaciwnWGoSAvhsK7fX/gEESqFpAX9yBg/0+cezpRsgwPWc
         1usj90k6uWvV5+PZSTRepj8lGWQNcu7sDyrVmqxcxHfz70RuxiRDvg87voZDWOQ6mR5o
         O2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516044; x=1776120844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMKpziGML7Zg5ERXIPN3K5TAiZoQQ1DW1+IhEDhwfcA=;
        b=krWkjHKGKgk9Y1ID7RakXKTof3EIY5lu49K7wqGTeS7AAxsEo78nCjs0oiwFlM59zO
         rjEExsbgzBfOccohk09hifgvMNK27ZpjwoOX2GN8971WESVkrJv+dqLkAjVigzfEwncV
         3i8SDKJbE3/sXubfTjVY+47e9MBQHCO+HAmn65WaRCo/egPxsZmFnZzFJYlXYauWt9/Z
         OJxidKCnpfqEOnPcaA8Mvt39EW5m3YF6ivD/uNe3AHu7LwB5JqaEzGqwo9IzjgFlClG4
         gz/LAiIOjP5J6bvATxguXnF753BaGgI38gHP4Glldzhnaoaa99Gz3N5BQDxjLtbvzPaS
         ae4A==
X-Gm-Message-State: AOJu0YzDqRCJ60Tx35lrPcZZxHFhFwiAvbg1ku4ncMC70cU4PXGGV91T
	zSTSSQ02secQq+apLiLu43X2c5Nv/ET44OtoY6MX415WtvBboLnUjAgnadfohudqRpOIoC2Vlb0
	dknifHg==
X-Received: from pfiu21.prod.google.com ([2002:a05:6a00:1255:b0:82c:d8bd:7e5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3011:b0:82c:6f07:2dc4
 with SMTP id d2e1a72fcca58-82d0daa006bmr13673224b3a.21.1775516044435; Mon, 06
 Apr 2026 15:54:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  6 Apr 2026 15:53:57 -0700
In-Reply-To: <20260406225359.1245490-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406225359.1245490-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406225359.1245490-3-seanjc@google.com>
Subject: [PATCH v3 2/3] KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Drop kvm_vcpu_arch.delivery_as_pf_vmexit and instead use msr_en_val as the
source of truth to reduce the probability of operating on stale data.  This
fixes flaws where KVM fails to update delivery_as_pf_vmexit when APF is
explicitly disabled by the guest or implicitly disabled by KVM on INIT.
Absent other bugs, the flaws are benign as KVM *shouldn't* consume
delivery_as_pf_vmexit when PV APF support is disabled.

Simply delete the field, as there's zero benefit to maintaining a separate
"cache" of the state.

Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/x86.c              | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..fae1f4aeca5a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1039,7 +1039,6 @@ struct kvm_vcpu_arch {
 		u32 id;
 		u32 host_apf_flags;
 		bool send_always;
-		bool delivery_as_pf_vmexit;
 		bool pageready_pending;
 	} apf;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c35d359b56dd..4632222a5d1c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3666,7 +3666,6 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 	}
 
 	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
-	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 
 	kvm_async_pf_wakeup_all(vcpu);
 
@@ -14035,7 +14034,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 		 * L1 needs to opt into the special #PF vmexits that are
 		 * used to deliver async page faults.
 		 */
-		return vcpu->arch.apf.delivery_as_pf_vmexit;
+		return vcpu->arch.apf.msr_en_val & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 	} else {
 		/*
 		 * Play it safe in case the guest temporarily disables paging.
-- 
2.53.0.1213.gd9a14994de-goog

