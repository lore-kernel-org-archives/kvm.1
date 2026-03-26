Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0C425CD1
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547417; cv=none; b=utHbk0Jaz6ezcxuOEMtnF9pBihF1XU48FM1N4tR0M2zz60TLMh0Xzh5JQVr00BS+PjNnLsSCOR/mwdtHuDqV3cFuGPBvqqln6PicI6As1ZFYl9Tyhnp8t43JU74O/SpT2HSgy4oOW48uKO2xLUNrW9Z3ntnA85rejhydT6SiJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547417; c=relaxed/simple;
	bh=XLgtzGzP42ljoyiyAMkJfrzmvotKaPs/WCkAxsvyobc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LD3L5rtIx6YfyaF2J1gc01wD6Dipj1XHWMquZ73pMbplLMq1Dd29qyzlM20YrwQudtWPqT0+Kb0+ulwnEuDbNq0zaKS5cTFfJxuBN4RgGozGAbKTRi8/TvoAhIPABbVY8cGhJskNj3+7NvL2+7qGjJb889adO0KOfvfMIQunwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRkXjFX2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRkXjFX2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c74217894d9so831787a12.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547413; x=1775152213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcHCPa7TDJvI9dVBUyhh6A4BV1v5Np3TWFrOmkOsocE=;
        b=JRkXjFX2hoeTOEyJK5roSUd3wwK6/vRXt0JMEHr1VR4bkXglnc9pWPQqJlFkSQnJzF
         ZIdU0iywN0cA1uKaYKJXBlD2SvqSwD/5vYzkEZPegalisv3gwCzYMp2WRCoOrRNBLTxm
         hlKnDB8uf/QQQjVDzzmwnJ5qUQdUcONRoqa/bFBYrMlaF80f3s9gFyoQKfQ+htVlwD3I
         bqXRbdJTEymqtppI6uReQ4baWBEaFp9J7WWs0FTUJk2pFfJ8pEeNUEMpGoikQtVcIZAp
         7ij41KJr67sOGLIYQXSa4MJPBPtSGSUqPQeMLAzwfM2LWEgl67W1ZegMGbK0xiSIJ2yC
         4zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547413; x=1775152213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcHCPa7TDJvI9dVBUyhh6A4BV1v5Np3TWFrOmkOsocE=;
        b=rCV5ONoYShJmgHcz2FNgDD/u2tatZwXvcwvcmRdtEbdMtmRs0P0EPsD6rS6S5uvm5u
         N5LRfV0yC23cS/J8Rm4/ZL7P7sGYrH20u9LKRMgINaQMz6DvmVsOI138obWdobU01Fxd
         Q6C9pUmIdZCXnTTb8JSy8LO8AiOzTTfqK7Cuss/kFyiUtgqBv381mlHtKhW0UCp+8Cxl
         zzyTKhpRO/7yInTDqJE+gxcmvXinlFl1icvQ/SjFCXYs/1W9ttDVSYijCqnDbMF31Z2l
         k+KcMOySdgAsngzhlY+p3Wxo+bAIFZDSJ7DGYmPZAq/9zQCYL4ED4BNN/++4k+kUsDEc
         Mhsw==
X-Forwarded-Encrypted: i=1; AJvYcCXYWnJVUw4VKc/iSzjq/0H8EYFgEJ6uLswCph+8E5Y+Z5oVpHAljq9l3Lw9Jiq20Z9TPnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsP9wmtmU383O39gwdVTC1qy3V+vB3GiU9j752uH7M6ijP2R/X
	72gCzBdghZphpl3qPDuneYIvwZrRY3vGHvnfnl9yuD/ryi7SN51QjH147No+7+K3wf50SGBKDlY
	J7uoUMXWsklDUTw==
X-Received: from pghg20.prod.google.com ([2002:a63:e614:0:b0:c76:3f60:53ff])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f9a:b0:39c:235:c5d7 with SMTP id adf61e73a8af0-39c4ad57b34mr8886863637.39.1774547412536;
 Thu, 26 Mar 2026 10:50:12 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:26 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-9-jmattson@google.com>
Subject: [PATCH v6 08/10] KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE
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

