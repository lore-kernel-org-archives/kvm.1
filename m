Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985073A3E97
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654843; cv=none; b=Qv1hlLfmOQaZxV9N6+qTlbNgiDIGqAf8QXagXFyQEs4uG19rVq/DSVJq/Yfp+iiiXDTz/F4ntxudHCueANIipquIUfdeGrahAzxIQOCOmkw/QTGHqZDot6h8BN4hiR3emyYP+Ie+22kL7jqIxKN1nqqirmLIe53UdoXz4Ha2e8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654843; c=relaxed/simple;
	bh=XLgtzGzP42ljoyiyAMkJfrzmvotKaPs/WCkAxsvyobc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdP37IKzeJoNDjSyzoQ1tUeOf4jsRl+4WOBT4iK/vAgrivLvuIjQl0e16O+YM+ocTysvGLtMGh8aIqRxexsDfKGZrlcOz5AgC2+kk3nOReG8v38rXJr7+jm9c46LZqog4slUX0Ga4OLkFqOtYRuPmJi8V7w+j1GzxonNIrGBvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bvnuhllz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bvnuhllz"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35c1874336aso7518900a91.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654841; x=1775259641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcHCPa7TDJvI9dVBUyhh6A4BV1v5Np3TWFrOmkOsocE=;
        b=Bvnuhllz2ehGQX+RdVTSoGv3BpfjRGsZ/xyAPrtu3k1GTlmhStDM6+WIHOJmHlaafu
         FJcohwPpcezZpzs/2alKmnJM0N06pQ2flMoUoGCBlJSy880uE7wh1sIC9sw0gXhGkm6V
         g4Q9wqdPJbfStpyKz5YbUuMl6Q+sSrD7jDkJZ3Eq86yZE7Xje6O0d1qsl5RJHVPfi+xn
         g80IwGVuCNe5g181E42ys+3J8NqgrZx+uvPcOkfruYEKyUjY2O7w2u6evvF7bie35gmY
         4nzxdZYafHwaIzSrS9ivVSCZDY23LqsE9T+6EbGHZ34xXw4HIgnwkkU4TWh3lSlE3Q/u
         gBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654841; x=1775259641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcHCPa7TDJvI9dVBUyhh6A4BV1v5Np3TWFrOmkOsocE=;
        b=gYW7Ye+PCtGV37b4WqW+nxm3JsHcmUVlclb+5BL8mtPhbitJdOtUNDgbwKgSAvSU2X
         UfW/v8GcaukcbP3ik2m8IPbICUUPk/lQ+yMvRFqIXIs4sSLfS3U6mK5b0j6SVWevUrEP
         +8mFs3lUEOoeAzHF6VH1WrcrfgRxxyD7eMXULeouP1FF250Y1buOHSfVVEhRnE6Zyo1J
         FmJduBMC6pb7PBFRE+wIuBLVn/I35FUP7hPOyaeb4GMQrf3C+d+VhECfGaPZQ+789utc
         mmVXJDfPm+Pef5T2akn4uQOmxCT7uBW8pZI+7JDM/OOjyPO6K2Ak4KCk6cdOG/xVo+Bs
         i2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXXVy2AsuMO6TeBQTLQLtrZrL+uMSU7+SARktaDmEz0WqKh813DqCC6MazT5ptqJzTUzLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcscmteQrNIZ0AyAaJThW1iN1hA56YQc645OqY083WZ4u96fhI
	0vpoQNPwq6UGcpuhG2+eJykxWYeg95T5UsNpvABlBCJhIdhqQz23IS3RBm/k0NjQz8C3zwbUh91
	V2Pp+57sLChNjgQ==
X-Received: from pjub23.prod.google.com ([2002:a17:90a:cc17:b0:35d:94b3:bd6b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:164a:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-35c2ffb5174mr4008593a91.15.1774654840484;
 Fri, 27 Mar 2026 16:40:40 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:14 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-8-jmattson@google.com>
Subject: [PATCH v7 7/9] KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE
 for SVM
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Document the nested state constants and structures for SVM that were
added by commit cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE
and KVM_SET_NESTED_STATE").

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
2.53.0.1018.g2bb0e51243-goog

