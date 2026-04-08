Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2643D9DD2
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672548; cv=none; b=AP5QKTRpMcjKOzckza/H0fwX95FCvHCXRpSsMUz7UGcRW3b1bV1+Us91BdpdunD6RMjJv35Y4nPDAyCuPn+DFZaaeE/+SGFuHeO24Iz7ZvGv80VtwDmXTo6iUdljYzju41PzveaLCVtJK+Ph93u5wSspNMAIdcxOC8QHAl2UCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672548; c=relaxed/simple;
	bh=sxVvvF7VVW9sDO+Z1b5JFHKhHYt0RWjuEL+Xbt386Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnk3E1GsV912WIIWC7PLD5eJmujO0fVx4dra9BCN4B7HO4bKl4WtzgJ3lz8YjRwwwSJKZcQd+WRo1WW+YzinbwpSahqSxEUWto6X4rdz6jhh/WQQK9FZ5soczyONQwU20U1XCCxn5O92wDY8VpkSFV2eR/PnX4qEhszNRDSaXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7UIX0Iw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7UIX0Iw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775672546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNO0/3n9B+Qzk4y+UjdgKHduanoKZMiB6XbuLsFUjGE=;
	b=X7UIX0IwhgaQ0KT5ZvA7+2ISeEIXHIwzoWw4gioZPTuPiPUINmYyl2LWOmu5erGG9Y2ud0
	1QLvbBl9gGYJkPi616SEgUGV4IxlrwuGyGHL3hQTcpwkiKxAOu1cSb/Ah+TCTem3yh/vUd
	MuC1No71EbPjarbh+9vor7oX2uC6dYk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-c1w--ndnNoKa66J4vo2v3w-1; Wed,
 08 Apr 2026 14:22:23 -0400
X-MC-Unique: c1w--ndnNoKa66J4vo2v3w-1
X-Mimecast-MFC-AGG-ID: c1w--ndnNoKa66J4vo2v3w_1775672539
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B497319560B0;
	Wed,  8 Apr 2026 18:22:19 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 234F819560A6;
	Wed,  8 Apr 2026 18:22:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 6/7] KVM: VMX: switch to RESTORE_GUEST_SPEC_CTRL_BODY
Date: Wed,  8 Apr 2026 14:22:12 -0400
Message-ID: <20260408182213.522713-7-pbonzini@redhat.com>
In-Reply-To: <20260408182213.522713-1-pbonzini@redhat.com>
References: <20260408182213.522713-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This has exactly the same expansion, so there is no change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmenter.S | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index bed5a753166b..f3240a3ff8f5 100644
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


