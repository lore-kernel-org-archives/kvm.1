Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CE3F20E3
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374322; cv=none; b=KrfvQzr1odeAjA3xEZSugq2HvB/oq9kSgW2ubBQKdn0pQek+sZfPCKcXWJPwlqlhflZpAKBV5NiENB61MtrJXmEmvITXo6HF340vmJOsiHBieWEW4EgbMBRQyn9iQpWTqptKd8mr1LmT819zDqIrbUIKYYqAdTliZ1Yan7s2gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374322; c=relaxed/simple;
	bh=wOxgwsGcM6yALGqi2DIbw5uLad7lQI31kkgbWrcCcsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNLz+/ZJpOzKS6j3nrTHExhwqxYKVDCggDLaRLYlsSXYkRBcQgwb2EPVMXOxqrnWkKKLoKYr29624VmMHSgz/aW6m38mWz8kDabLxrSzXk2NPOAniLVgBm8upQEIDK5JFEoIwfGqWLytKfjA4XFuScGh3Oy4Y1l/OnMt1H+DwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMj8vXL0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMj8vXL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na9NIgRBc1v+C2rQ8Vz2B7eHy+7VwDVJw14Y1qRv1Sk=;
	b=RMj8vXL00sEJ2JY5I9CtSuNZA3AtcE52D+LhDhTcgtjmtBgl49q6IC4EPZ+IO4Mz8UqMZ7
	uyS03uiG6jv/7QXucfkMH/jgx/vtsW9CnOLE/xJhfZcfkKTbKzKgBKXzVTO1IGZoIC4UqW
	wCmhleVFBhD83HfhUcHJJJYmc+JwNf0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-r9qpgNORMhOaPkaoN41jHw-1; Tue,
 28 Apr 2026 07:05:17 -0400
X-MC-Unique: r9qpgNORMhOaPkaoN41jHw-1
X-Mimecast-MFC-AGG-ID: r9qpgNORMhOaPkaoN41jHw_1777374315
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A483618005A8;
	Tue, 28 Apr 2026 11:05:15 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E74DC1800370;
	Tue, 28 Apr 2026 11:05:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 7/8] KVM: VMX: switch to RESTORE_GUEST_SPEC_CTRL_BODY
Date: Tue, 28 Apr 2026 07:05:06 -0400
Message-ID: <20260428110507.11248-8-pbonzini@redhat.com>
In-Reply-To: <20260428110507.11248-1-pbonzini@redhat.com>
References: <20260428110507.11248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This has exactly the same expansion, so there is no change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmenter.S | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 38915ca16b05..7dd9bac0e454 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -101,35 +101,12 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
 	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
 
-	ALTERNATIVE "jmp .Lspec_ctrl_done", "", X86_FEATURE_MSR_SPEC_CTRL
-
 	/*
-	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
-	 * host's, write the MSR.
-	 *
-	 * IMPORTANT: To avoid RSB underflow attacks and any other nastiness,
-	 * there must not be any returns or indirect branches between this code
-	 * and vmentry.
+	 * Unlike AMD there's no V_SPEC_CTRL here, so do not leave the body
+	 * out of line.  Clobbers RAX, RCX, RDX, RSI.
 	 */
-#ifdef CONFIG_X86_64
-	mov VMX_spec_ctrl(%rdi), %rdx
-	cmp PER_CPU_VAR(x86_spec_ctrl_current), %rdx
-	je .Lspec_ctrl_done
-	movl %edx, %eax
-	shr $32, %rdx
-#else
-	mov VMX_spec_ctrl(%edi), %eax
-	mov PER_CPU_VAR(x86_spec_ctrl_current), %ecx
-	xor %eax, %ecx
-	mov VMX_spec_ctrl + 4(%edi), %edx
-	mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %esi
-	xor %edx, %esi
-	or %esi, %ecx
-	je .Lspec_ctrl_done
-#endif
-	mov $MSR_IA32_SPEC_CTRL, %ecx
-	wrmsr
-
+	ALTERNATIVE "jmp .Lspec_ctrl_done", "", X86_FEATURE_MSR_SPEC_CTRL
+	RESTORE_GUEST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), .Lspec_ctrl_done
 .Lspec_ctrl_done:
 
 	/*
-- 
2.52.0


