Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E06379EF6
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588640; cv=none; b=oBgiSPqx2arAZiCdVfNA56yVI83oJPi/xfsuE9EwAJPZ3rLu6FUq9coM2Idv1vMtHRQXEG9OfGD6POV4AD/uxjiBbEAN5lW6EcNrMdErU9c8cqEt3WkXN+N/oL3MT0EfesAh8QO5YJkGz/KWx8//N0Imj/j0JlCOxXeYo5mgLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588640; c=relaxed/simple;
	bh=PZR+SizrlOgJ1L0IeKgPGj8oQs4ZXYjZFTHQee54iYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P+uX4IJLaaBjRlUBDtgf4z1TyuOK1W+n8HdUXieOmsh67BmrYdx/mc0eQrzr7XCQnyQMGafdZV1wU84354xofFkocBX6Hgr4jH5/y8Ux7sVOaKttEJgBsfbj6htJki9hiatL1zfyUuhAL9DyDKMXcZlVXJiq9dU2UusT9PxqNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkKbVPOx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkKbVPOx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3595485abbbso6355312a91.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588639; x=1776193439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NydMzT72BWpNLXYUYCtPVtyCG9QnLXc1NxEAbEX7NMc=;
        b=nkKbVPOxKMGmOlMxrw7P+dSJa32RJvSvFuSZIWZSAE1KRZZAHtDEM5iuLCaI+aa5iV
         GtAmeaIPEDTMLYjGqlADzJW/mtKxg3QdDAyrnuGRCcqD3fgUlibMYh/vB3OiUFkGhrai
         6NV95yxQtdGY+t8wjcRAaZx432N5yCVOym6wm0KgHgzCaJCPVWj8+l4JhM/5WHF9c2dy
         eo32UBIhA1OkfdMPSex/Iys0UZehE4oYK9rkuCRv18qdyeP5aR1o9MyPIOQs/lYOi5RX
         Ac0oDCoVgZI5zf9MdSGrc4xgH/EjpXZxjHOezlHiv+IpGDiarhhtfiq3K/hxWtTB7IFT
         516Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588639; x=1776193439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NydMzT72BWpNLXYUYCtPVtyCG9QnLXc1NxEAbEX7NMc=;
        b=Df9yJk+DWrFae/UgolNhcXSdEyQnLDxfi3DNOzAJrUYouSK7gAofwWaVhsB5VSukNQ
         kDveoHrwsFd3SbEB17wnGeT396/pVuHIaV8wujyOiAszA2bg7qNKpVPCKpJlHUI57WC+
         NGBTsLMcOFx7AJ+nuyy5bxE+tDOQeL8oybQCHJselFDoMsXubkbh0WZejStjhXt2Hh5s
         P1sVO8dJLmldxs6beS9B5N9IBx44ziw1Tu3MgZStGAnfFknxsaJ5sjn2RNiuKRoKc0Mp
         9tGrLjTLUcnCFrxKfNbFzLtJ4osQ9bjNHjyWQxbs3M+FavjRQVV2BAxiJsokqUzd5icQ
         vyqg==
X-Forwarded-Encrypted: i=1; AJvYcCXPCs+W30fjAZLvsd0OwvPd4QtEF83DNOs4koiny/V5Vvx6/iIjjhZ9SdKMxl4BR8z+w5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcXPXVtyKjfsBd4TbuDVCbmazmoR9dXSLP/xbdvyB4a5ESg5y
	HjK0F3bC8XC9CfyG/F7K5/m/97WNMaxT72aJTwgLb0cd/e8kEcLd1hrG5AhsG9zK8WiyhBt/mEB
	g2xWoMjZ+Cp7Iog==
X-Received: from pjbsc11.prod.google.com ([2002:a17:90b:510b:b0:35c:d80:c2a7])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fc3:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-35de6977523mr16658460a91.17.1775588638444;
 Tue, 07 Apr 2026 12:03:58 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:30 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-8-jmattson@google.com>
Subject: [PATCH v8 7/8] KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE
 for SVM
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Document the nested state constants and structures for SVM that were added
by commit cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and
KVM_SET_NESTED_STATE").

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 2d56f17e3760..0a2d873ca5a3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4942,10 +4942,13 @@ Errors:
   #define KVM_STATE_NESTED_FORMAT_SVM		1
 
   #define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
+  #define KVM_STATE_NESTED_SVM_VMCB_SIZE	0x1000
 
   #define KVM_STATE_NESTED_VMX_SMM_GUEST_MODE	0x00000001
   #define KVM_STATE_NESTED_VMX_SMM_VMXON	0x00000002
 
+  #define KVM_STATE_NESTED_GIF_SET		0x00000100
+
   #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE 0x00000001
 
   struct kvm_vmx_nested_state_hdr {
@@ -4960,11 +4963,19 @@ Errors:
 	__u64 preemption_timer_deadline;
   };
 
+  struct kvm_svm_nested_state_hdr {
+	__u64 vmcb_pa;
+  };
+
   struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
 	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
   };
 
+  struct kvm_svm_nested_state_data {
+	__u8 vmcb12[KVM_STATE_NESTED_SVM_VMCB_SIZE];
+  };
+
 This ioctl copies the vcpu's nested virtualization state from the kernel to
 userspace.
 
-- 
2.53.0.1213.gd9a14994de-goog

