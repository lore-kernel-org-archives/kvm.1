Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF9285066
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210501; cv=none; b=RGpnVbD+W8wl9cIJ8NUxpKZFYUnEPux9EAbLdJ8+1EcuWS42jpionPqO+6b5K1xeFZFFc8mfNIDtsUVrLL9YueZvC3a0jIdAApsdu/4ADDSIPPCfdr95/Fjrq+UlEWt5IJeupLXoIbMo5SWCw72lqSnsgXOBb7O9/oLId37wUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210501; c=relaxed/simple;
	bh=udt8odhjX6TBaalkLtBPvxUn7Sj70KctvZIGZq8z188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzTdsMtBdXMTLzjXqGGdz5Y8iwYm9DJ1zsE7j9brtolBNSxWfhnQq0uq9XD2AVWm6XK41X22WwVrdHjaxJM3XDaSb0macJXPCQ+/PVtiaeRDpIHxGwnxQYp6W1u/8KSa3KTNvPkCOAC48LTo52r8qsqp2t/TKPWl3+7CYGn4V8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZdMVYxo; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZdMVYxo"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b35f3e489so30234341cf.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210492; x=1775815292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puoXS1QB+flhx5qquPUku4RQL097ct8QKVc2HkG8hr0=;
        b=sZdMVYxoVb5sl41dIr/Vgq2tQqM1aL4O48l2q89EltbifggbySVdoZoJkfjtDMeRIA
         4HsnKyYHmTTttRTBquvPvWH8HJHvAoBUWpDoG2mjvaH9U47dxt6RuEvdPznv156ei7Np
         CTE7jgTb+9Jtft8RYxBHWSm8qxpGfEj39JCtjGmMcRKHjnx2tsqCzWV85nVmsZqdl0G+
         y++finls02Bvk5cF+bhmBtlf1X1TqJGuBI9Ci/cagxmOr3mIUdJGiMNwOY8mKZpQG+Oa
         wnHmMA3p6kJpSYlRw9wA5JQ3U2Al4bbeTutMsWOW/lyQP4dM7sicMw/xhDzR6pbMYww6
         /elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210492; x=1775815292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puoXS1QB+flhx5qquPUku4RQL097ct8QKVc2HkG8hr0=;
        b=YeYPnNXLjEymfkHj0Ovj1JhW4kaOgpVgRC02nHbPTB+I6W6iQfZEmLfEC96mhAaRxs
         IBGaF0eNehYSCTwHWFK/SxthDd3ZN5SM0iL42OsSYyY59Do5SvhsMMQ59hZZAsuOVmiX
         AK5jt35hxhRt/6XKyIZrFWOLQg4Xdvwbzcnk3QLGRI0KKcqI9XmwmMAaH4C7XBgECegr
         zxubkJNVdEA0McE6K80n+lZnV1NbTMQu+46f6Tkwp1Fkr3f9PtSrwOCNltiZTbPlt6VQ
         P84L5xEDZT7BTgYlVf4H5QAOEXVdoaXR3DeMHVrGmx/TNAwCWJC2JZyHMKuWcpR4W6NO
         8wEw==
X-Gm-Message-State: AOJu0YyLp8XpkEaFQT0MzmdsUSDbewbFyfFemlv0JkTn1bhJIvGVxoZS
	vCrRgXtmagR6m25xe3wmwVOKyTQblOK92ULw1/JGeC1jz15kVnTEnMg22eIalIECxjxmg0irj4U
	=
X-Gm-Gg: ATEYQzxlri2VmcN3pNVluB0oBqr2CJwmKdLnnLw4MxbRmnretZM80lmEZLZDxrs2yIL
	ApVfenWA0ElI+Ze+rcx2Jd2hDlEQVHflH6kfgdK9OT2OjCJQTmUtvm2Fyy94Y1qTkY3uhNSpsNh
	K2OP9h7wZ4H/AA1fEqNvP698SnvlNilVbwo+RNmOmE3JosiSVBFBNt37y0bDjONmLLRGyon2RSG
	uolCpmSnCw6fzZHCKYm8xWU+bWSxNZwt8Qny7D5KnkYm4aD4e7tOTWglK7SakW49/cOh/0F/4MM
	2hOYXjY7w+3ypJId5FLbB/JCj462RM6ml0zfF+Xe5Y0LMa4ndnQFq9XkweUBbhhXqj46tDPXhLT
	W913UT0Dp1OJ4GNsBzZjkZXE6R4YhnuGJ9k2LQYYXRzode1pBANepPl319UOBVv465FkNtLvLX5
	bHTLxgrzXdamkY2kEV8PXonhynqsfTYA==
X-Received: by 2002:ac8:7c55:0:b0:50b:3249:828f with SMTP id d75a77b69052e-50d632c8a04mr26848601cf.28.1775210480761;
        Fri, 03 Apr 2026 03:01:20 -0700 (PDT)
Received: from gmail.com ([20.109.36.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a3fc7sm53639241cf.5.2026.04.03.03.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:01:20 -0700 (PDT)
From: Ethan Yang <ethan.yang.kernel@gmail.com>
To: kvm@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	x86@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	glider@google.com
Subject: [PATCH v2] KVM: x86: Don't leave APF half-enabled on bad APF data GPA
Date: Fri,  3 Apr 2026 10:01:19 +0000
Message-ID: <20260403100119.3311-1-ethan.yang.kernel@gmail.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260403031111.3171-1-ethan.yang.kernel@gmail.com>
References: <20260403031111.3171-1-ethan.yang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_pv_enable_async_pf() updates vcpu->arch.apf.msr_en_val before
initializing the APF data gfn_to_hva cache. If userspace provides an
invalid GPA, kvm_gfn_to_hva_cache_init() fails, but msr_en_val stays
enabled and leaves APF state half-initialized.

Later APF paths can then try to use the empty cache and trigger
WARN_ON() in kvm_read_guest_offset_cached().

Determine the new APF enabled state from the incoming MSR value, do cache
initialization first on the enable path, and commit msr_en_val only after
successful initialization. Keep the disable path behavior unchanged.

Reported-by: syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4
Link: https://lore.kernel.org/r/aHfD3MczrDpzDX9O@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Ethan Yang <ethan.yang.kernel@gmail.com>
---
v2:
- Rename helper to __kvm_pv_async_pf_enabled()
- Rename new_enabled to enable
- Align wrapped line in kvm_gfn_to_hva_cache_init() call
---
 arch/x86/kvm/x86.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63afdb6bb07..93b7ad9b52b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1035,11 +1035,16 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
 
-static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+static bool __kvm_pv_async_pf_enabled(u64 data)
 {
 	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
 
-	return (vcpu->arch.apf.msr_en_val & mask) == mask;
+	return (data & mask) == mask;
+}
+
+static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+	return __kvm_pv_async_pf_enabled(vcpu->arch.apf.msr_en_val);
 }
 
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
@@ -3616,6 +3621,7 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 {
 	gpa_t gpa = data & ~0x3f;
+	bool enable;
 
 	/* Bits 4:5 are reserved, Should be zero */
 	if (data & 0x30)
@@ -3632,18 +3638,20 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 	if (!lapic_in_kernel(vcpu))
 		return data ? 1 : 0;
 
+	enable = __kvm_pv_async_pf_enabled(data);
+
+	if (enable &&
+	    kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
+				      sizeof(u64)))
+		return 1;
 	vcpu->arch.apf.msr_en_val = data;
 
-	if (!kvm_pv_async_pf_enabled(vcpu)) {
+	if (!enable) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
 		return 0;
 	}
 
-	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
-					sizeof(u64)))
-		return 1;
-
 	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
 	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 
-- 
2.47.3

