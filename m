Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F3397E68
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774575; cv=none; b=AZ64ccLnMqtTtTkUFFihido9tvoo/2R8ccaIIpqM1Ov3SlMzY9NdUi51JIsDknkVt6mkeEwjYjYVBmh5V+0uQRGZRnnFQR3rKkn/J10U3OcnU9KSaC3BQD9+5dVmBRMr8iYj7+dOexIs4+TZiL/LjbFwVjsT5YYTQNdpMYVFz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774575; c=relaxed/simple;
	bh=Cfxa2UAE6j7eG3LqQr4Mhci8tHPj0OKBsNtcqmiHvgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MsNlqcv/6qLl3Xvv1bqOFJPafJWvYs5LmRZhP2FEB6ggZkqx1una3n4MPMYPMilWSfjwti292IFEcf5QKj/MBfIo+O/1enhSDJ5H6VG02GrDVX5TCGo/CfV7gnag7rrkAWBWZhI75BvTKiMNw/fWSa8geNdDJVXxJDrrGNlVdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAJ5+wST; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAJ5+wST"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so689358a12.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775774573; x=1776379373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dy1xR7/tBUVQ93pwLppnnl1roCB8CkMUcZoZrxWj4Ak=;
        b=cAJ5+wSTxAeEQw2sYFDuWOOjkztukurVzKIvbQQ0gaZVMVf0qSiTpusnxUUwn5b/zj
         JJTg6ZMSnhZElHat62CxdxGr7QJPQGs68+99uY5UVd+JHSc7XYvTk+6F0J7GIFfNxyTw
         lkpZLbHZpCIwxiNwdV6FKYmgr26WNd7CKrgo+LJH+G8X1ZqW4lvjk9/XhqmNniIb5I6E
         qHt/LxRGTJ+XB2V47powtHFuLuHA7USBTfNrEpQZkh8Yknx6WadN3jeIPWR18wjMf+Gb
         /nDxz+rF9TLjJJ+4PydJh1QlXnkftpLCH76EnibUxlk7bEQqMykugV0NZghchGcCsiu/
         xtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774573; x=1776379373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dy1xR7/tBUVQ93pwLppnnl1roCB8CkMUcZoZrxWj4Ak=;
        b=lvlIUzh1PM0yQSfSEJ08zXwA4zSo51rD21ytlOrUS9AF66ZKyxYE9edsoQyD/Ztzgj
         D1g+mI8xxr2YOlwSSviuy7xqQ3wQFcurUIjxrxZRzKQ0PeYoKyUXZdbtCaQRVhx4EVR7
         xV6Zeb391GM/YhaP0zuMdHS4U2htOYjPDua/Z1aWak2TPjjriZTtD3fgnlBgqkZgoMEn
         A7st7bfAYsV3kNwxHXe5bnUWnwsCobwhSz3WVEBslYt/Zy8X0HTeGBOojTDK5DBpehMi
         jUkE0DsaqH0BHBPfhPTfee34hRrDiyqJS8QNFj8Y/vFgPDsOYFoCGU9/GL8ZQrvamZ5W
         n9cA==
X-Gm-Message-State: AOJu0YxrRksO6/qHPe30C0dq96/b1Zybt7o0v+5kdhckjTCizsa7Ay24
	hXNobEFRR0v01vg3UKOSBCqWUCOqaKHWGQ/sRxOYFRHVs0eHSttxYM7eS03HElkocx2MyG0SsqM
	cSrgjhA==
X-Received: from pghv6.prod.google.com ([2002:a63:f206:0:b0:c73:7970:8223])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9981:b0:39f:43c3:b8b9
 with SMTP id adf61e73a8af0-39fe40d7f36mr740699637.57.1775774572752; Thu, 09
 Apr 2026 15:42:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:42:32 -0700
In-Reply-To: <20260409224236.2021562-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409224236.2021562-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: nVMX: Do a bitwise-AND of regs_avail when
 switching active VMCS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

When switching between vmcs01 and vmcs02, do a bitwise-AND of regs_avail
to effectively reset the mask for the new VMCS, purely to be consistent
with all other "full" writes of regs_avail.  In practice, a straight write
versus a bitwise-AND will yield the same result, as kvm_arch_vcpu_create()
marks *all* registers available (and dirty), and KVM never marks registers
unavailable unless they're lazily loaded.

This will allow adding wrapper APIs to set regs_{avail,dirty} without
having to add special handling for a nVMX use case that doesn't exist in
practice.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 22b1f06a9d40..63c4ca8c97d5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -310,7 +310,7 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vmx_sync_vmcs_host_state(vmx, prev);
 	put_cpu();
 
-	vcpu->arch.regs_avail = ~VMX_REGS_LAZY_LOAD_SET;
+	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
 
 	/*
 	 * All lazily updated registers will be reloaded from VMCS12 on both
-- 
2.53.0.1213.gd9a14994de-goog

