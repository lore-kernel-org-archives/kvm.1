Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64AF3A1696
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516048; cv=none; b=txGsV0tQUhLuNPS+IVGHpkPW0wn5lxL+zPEXM/HAU2cOJAWwg+qre9l0n4X6rAmhlJh/T5/wYq8zKmeE3wUQJAbHT7f1iGOnqeLBdofpfSBnPlavLcQ55m2f4tCCoV6sMxKJOpfkeNiuhFihvolgQ8wTQPqpPLO58V6uWkc6zJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516048; c=relaxed/simple;
	bh=5b1zoQkTrywag9Fu8KBCDjMniqqTU/MpRTa9InqvHqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0dUn5LnsRE9cqSCWblYy5/E3MgozSx/P1ApL6GJTivREsvsgNdDJ1j4SRlSEIjF7KJ0tfpVuPccX2Ur9DrCpEH/bxjUsDkPplC4i79xlphJFfIYto10WycHInz6ruLoew8NXVk78KaHtSJKjfMMWx5+t8sfHqrYCqXajVDXz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihet1KFv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihet1KFv"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce50e6e28so3058048b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516046; x=1776120846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=INkMGDZELjucmQY1ANEZHw2bsMlDcFYJi3YasM1Pot4=;
        b=ihet1KFvFBiq/cpAqivm8cy24CH5Zid/GsX2JyfFIM+3t4JWiIYci8ODTYhgmqtuFD
         cH1S6bSi1rNLoiVd86aT8onWhB/Qwqw5El+DfVSQ99Sd+o6OsS6HwvZ+M6E49tRSyU3S
         lBD7nGCLZrVG2ZGTk5EocloWaJZFiUNbu7DQwsYSUVPmQGSly3gfe3YMeXEf0T5YHEgL
         58+pgmnoBZ5NmMvFlkDFAk6/xMJu641WrdSP1LVDQ65Jc3sG0/RU1n5Rke48dYWyh8Ns
         XG02MZQBXqD0qhXPmWNfWVf98on4MwPqNw6tu43ptDfllYpq5D4FU1Ot48cJUKK+O7Wh
         qCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516046; x=1776120846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INkMGDZELjucmQY1ANEZHw2bsMlDcFYJi3YasM1Pot4=;
        b=XuxQCLiK+M0sm4IDRRRk/2l+RVw4454T4Bu44Xtncbcwgrf7Y7ovroWTeHN0GWqlGf
         Lss2XRIJ5518QAznQCNTS0MuC3kgoft9YuoNVz6JH1kCImnIYv5vpk8Aq8euu+a3/aGj
         Ssacw/I5fAsyPsDCW0JHu9PsakBmN+XNwjjFffRVL/Tuh27BtHSrWlq+yE7slAQVPH9w
         hbk36ppKAYeHs554EPvkyP5aReucZBY2JttI+4XEeB3RbTldR1Gg8/4yx9zihMfInbp6
         WApkfOMoYuFMuE6xexuyamddr2sPdthEoOt3suSq3r+2x8QcbmtrfRcueH27WNefNU1O
         4qZQ==
X-Gm-Message-State: AOJu0Yy/zOd4jmNdryXFA5cqdDzWHV46qhfO+OYZd2DQB1DFveD4AKBy
	boK4Ni/5ayETZ1im14ray/QF7CQKMyhzml2PIe3jaRfpjrhsFYI+Z7fOUA2sYfaOPn+jn58RsSU
	dZ4bsfg==
X-Received: from pfbhc13.prod.google.com ([2002:a05:6a00:650d:b0:829:7c7b:2c75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:420e:b0:82c:e556:2146
 with SMTP id d2e1a72fcca58-82d0db518dbmr12622083b3a.37.1775516046236; Mon, 06
 Apr 2026 15:54:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  6 Apr 2026 15:53:58 -0700
In-Reply-To: <20260406225359.1245490-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406225359.1245490-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406225359.1245490-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_SEND_ALWAYS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Drop kvm_vcpu_arch.send_always and instead use msr_en_val as the source of
truth to reduce the probability of operating on stale data.  This fixes
flaws where KVM fails to update send_always when APF is explicitly
disabled by the guest or implicitly disabled by KVM on INIT.  Absent other
bugs, the flaws are benign as KVM *shouldn't* consume send_always when PV
APF support is disabled.

Simply delete the field, as there's zero benefit to maintaining a separate
"cache" of the state.

Opportunistically turn the enabled vs. disabled logic at the end of
kvm_pv_enable_async_pf() into an if-else instead of using an early return,
e.g. so that it's more obvious that both paths are "success" paths.

Fixes: 6adba5274206 ("KVM: Let host know whether the guest can handle async PF in non-userspace context.")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 12 ++++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fae1f4aeca5a..2a6906597637 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1038,7 +1038,6 @@ struct kvm_vcpu_arch {
 		u16 vec;
 		u32 id;
 		u32 host_apf_flags;
-		bool send_always;
 		bool pageready_pending;
 	} apf;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4632222a5d1c..e24877353f17 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3659,16 +3659,12 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 
 	vcpu->arch.apf.msr_en_val = data;
 
-	if (!__kvm_pv_async_pf_enabled(data)) {
+	if (__kvm_pv_async_pf_enabled(data)) {
+		kvm_async_pf_wakeup_all(vcpu);
+	} else {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
-		return 0;
 	}
-
-	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
-
-	kvm_async_pf_wakeup_all(vcpu);
-
 	return 0;
 }
 
@@ -14025,7 +14021,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 	if (!kvm_pv_async_pf_enabled(vcpu))
 		return false;
 
-	if (!vcpu->arch.apf.send_always &&
+	if (!(vcpu->arch.apf.msr_en_val & KVM_ASYNC_PF_SEND_ALWAYS) &&
 	    (vcpu->arch.guest_state_protected || !kvm_x86_call(get_cpl)(vcpu)))
 		return false;
 
-- 
2.53.0.1213.gd9a14994de-goog

