Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5A3B5318
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787564; cv=none; b=i1sKxmXdQh+Mnt0goSLNpYfgiV0DrwEVnyeG8sSY4uM2TSt8hhHK2ZNpVGCErnt6lER/kwNkz8XzeoI5dBzBOjzWoEt8yB4smI2XjHQGmr68eVRCXpkpjFlW/eVY4TzKr+NkvBK6qK//MVVRDddZiR20a73/VzCpFb8KPFuLP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787564; c=relaxed/simple;
	bh=8Kw3Nj7xOGrbmUBSV/kVU/ochnXj0oWLrOcYJzQlq9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=coyDhG5H4SoWyIed85o1m22+WEe1C8Sruka89l137PFZWdOw+XC/qDOtNoHKtx6rR6GDvPBzdRH8s4l3D0gwppvpaz1oJYKm/7d9BMhOUDmFtfEI3eeIOQpbyc9w50qU9tyuYNKfW9z9E/HwTg1b75qlSteB7NHq6TqRghfbl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGbRjvei; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGbRjvei"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088202so114413a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787562; x=1788392362; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6KDDUNP2gAbt/e9olovJkhStLhLbdjWDJkc7h/s+5jY=;
        b=GGbRjveikoNGetF7QrLF+NAAKA3sL6KQFZCt7BQs5Kp61lUGryzyV9iOcfrwBDkFB1
         RUOoT0Vz6a0ayrzVbqjkzoHQUaOWHhuZJqBM4jtOpUP4fLdvkTafictHuxZTplsG8PHw
         la4utzs0JucFNq4THvGkXzRDta7alFqF6Dk5sN8eb/NbZdurNvZdGhZRKaEH+BHUlEjs
         OWbn3E4WRvPt5R1qL3pmrMemu0EXUp6TmC6UF1O9qQc+vIIeEs/H7tRSM8YtcPGqRXB1
         zV12F4AMqSOkfpCsAlDf904l9xoTItWZXAesYtPLaxeAJyWflDYSQlzudvqUOv4r9Dk3
         s9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787562; x=1788392362;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6KDDUNP2gAbt/e9olovJkhStLhLbdjWDJkc7h/s+5jY=;
        b=DbpSc3tp4BSUSDiXntLjZB/V6aElMyhTgDONryHh+rukbTq4LA6A9MycffZy+8I6R+
         O6DrR4KPgEdYv8jQe2cNSu9AmqE3o4WgllNYeJW9kWoNui6AKF5qO8ZGvq6t372PbYJX
         v2BQbbxBXeCtMJ8ZbhGjKDdfIVtj+Rle7fQQz3ezdcL7R8y7MMVWSLFaqxfgyscFH2ND
         JYVR69xtHS+cb0KSBg4UQN1ngFxVYD29xpJDHQItkJ6gw6ZxJ73wLO1MCoz4SK04ShTn
         QIsHerOeGw3VO241I9d3fKTxnY64wvTWeb/fs3awXGxn/ll7Et2Rfu7d0rWqRWXS5uYI
         lZqA==
X-Gm-Message-State: AFuF++khIOXtr45iC3eKjeOGEkcAxeQdg2b52CasYLiXT4rjThGhVdpz
	/0VBWY2WIB0wu3kHHVsUizcrMlT/AnpLyWcaS/mO/2thRAqBRv1yTW44zI1omsRIpvviKUug8j/
	G4XD80w==
X-Received: from pga9.prod.google.com ([2002:a05:6a02:4f89:b0:cc1:be9e:35ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8986:b0:3d0:868d:8ccb
 with SMTP id adf61e73a8af0-3d0868d974amr10614945637.13.1787787561472; Wed, 26
 Aug 2026 16:39:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:07 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-2-seanjc@google.com>
Subject: [PATCH v3 01/13] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Vitaly Kuznetsov <vkuznets@redhat.com>

VMPTRLD with active eVMCS is already forbidden, however, returning 1
without skipping the instruction or queuing an exception will likely
result in L1 getting stuck. Genuine Hyper-V seems to inject #UD under
similar circumstances, mimic the behavior in KVM.

Reported-by: f734222792@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221841
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..ad3726fd4fda 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5897,6 +5897,12 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
+	/* Forbid normal VMPTRLD if Enlightened version was used */
+	if (nested_vmx_is_evmptr12_valid(vmx)) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	}
+
 	if (nested_vmx_get_vmptr(vcpu, &vmptr, &r))
 		return r;
 
@@ -5906,10 +5912,6 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	if (vmptr == vmx->nested.vmxon_ptr)
 		return nested_vmx_fail(vcpu, VMXERR_VMPTRLD_VMXON_POINTER);
 
-	/* Forbid normal VMPTRLD if Enlightened version was used */
-	if (nested_vmx_is_evmptr12_valid(vmx))
-		return 1;
-
 	if (vmx->nested.current_vmptr != vmptr) {
 		struct gfn_to_hva_cache *ghc = &vmx->nested.vmcs12_cache;
 		struct vmcs_hdr hdr;
-- 
2.55.0.887.g758fc8c411-goog

