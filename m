Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEC42EEB7
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549115; cv=none; b=g/t66J+ScApYFj+EUgZ0eF5MJ+WohmANds2oNIp1IvP9HkY5478tqV9VV/gZ+AHTVUxjiXdTfQvjli7n2g0SJMpUgu6H24SaAn8tkE0g3mYyfzaliK1MKo6O61dy4SrDx5ZnkkwdR2qFEu5tqYpbV48Uk1Xmo/lOADkaFYVhLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549115; c=relaxed/simple;
	bh=KyJghWuDVBsbgkhZkBaY+oSIj/LbtZ/LGaEKZV/V7ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t88G8ntQCW+MU1dSzKLyj/5NY/WElFisrReqAUee+WhtXYwJWdAH4/EqVezUq1xkg8PAYsRc+vS5jn5E80V1TDj4yBrSRHXmVYnlFyozCq7dLdw8ex/o9qigIrhomYYzLCAZSHJoU6Kh2S7dRn/1bKFRenN5BHgIjQEi3t4N1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7x7R6Np; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ltb3BX/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7x7R6Np";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ltb3BX/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJv4bFxkGZXT+fQXF05wmQFYDvr/WaoBBgiyg84ew/A=;
	b=E7x7R6NpyY7GFdXGD/uUUSKZ1zgCn4QK7MJOTv1gcyLxkKNlp1By8qXieP95ZuloAMKm+B
	Us1DRaK2TZuruV3qrIqpyRokiHPR3gomD70ZqdcUXFJ0zZtaHZGaA238AnnFmD0ZXMu0eM
	CZl0J4LjQlD4+dMIx1nNCfRnp2aE9ys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-45Yz7KAjM-CJ2KeqRcfnSw-1; Thu, 26 Mar 2026 14:18:31 -0400
X-MC-Unique: 45Yz7KAjM-CJ2KeqRcfnSw-1
X-Mimecast-MFC-AGG-ID: 45Yz7KAjM-CJ2KeqRcfnSw_1774549110
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b8f23bdc7so94440f8f.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549110; x=1775153910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJv4bFxkGZXT+fQXF05wmQFYDvr/WaoBBgiyg84ew/A=;
        b=Ltb3BX/xa0mGZtjv0sXsj56ix2jvd4VAM1ItB4z8W7g9/YDIXLrIl/8Iub+s0jtk7d
         VdldVAJVuRphPc236uu+f+BdjgOf5psgTTS0tuOD34vlDG3xiRZMkeKv/qVHIwmx2jQH
         LVj0xpYnFj+2Sv1PqUufHP23vbDzytTAsb5zWivWbMyCv09OJGR9XEHjseB9A3wWWc7M
         lilnhNwNwPKcqVjhR5nDDunuene2byBjVqwfKl12lBizxzGpRkJRrZv+sV91J2tuCIPD
         jhd14u6vM5Kc54gWczdokeM7pkWp+6Ad/UFHYgR7Kzo5F0ruMJqo/JkNDDWr1SNaPagi
         sLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549110; x=1775153910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJv4bFxkGZXT+fQXF05wmQFYDvr/WaoBBgiyg84ew/A=;
        b=Ntc7bpNQZ6ugMButXQJVlW2P0ftgBdV9fHTIxEKDCIjaY5LXBBnuCGunVA1j29RbKa
         M+y0cjHoZAe+xDT+LHJI7uXh2Sgdt5ttFnzkIy0Qgariub46W0gw0bzfbby7A6WA49Lq
         2Z9r1MBCimppJa9lLnw1uVwSosIOPGrSgIyoWJRejLMs/YoX/g4ffnSI0jA0EPuXh/KE
         9ZPe4+7zpNmZt5oxvBe6U4UPOPMT5nX8KIBeaDg85/hTfMXZCiJUDRWiDtzl606sBIPM
         pFpF+F3SC6dt6WQw7WVPM25MM3llU4yXP6TfcFf2ICbK6nCa5tQ0P00sU9lVt7dpQWcE
         02qA==
X-Forwarded-Encrypted: i=1; AJvYcCXlkNXoUuqHY3ns41odkd5k2vWBTSNGLK9v8Z1i/KzkgKlcBHqpdFnpufHzCFGtTM1Ek84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVgNxOMQFlTMBlYe4VJqrgFSJHl5kIAv4ZXoMYbEZ8JbOIy/lX
	EZa3gEwgUk0enVpFRQ2fQv/oD3Yo7kgn1lriNCREfeV8zjvsM+iJGHFcPYiYrhQESLzckxgPx0v
	5ASqZSwEt9SFG2p/QhFYK5IRq+lUG/RsSh4xTtN8GvGMQQSDnyVidDA==
X-Gm-Gg: ATEYQzzPsOth+qrYB6FHKVjvqouFuf55f+D3/Z5SlZmbr1A24o4oJr8+xXtb8EFSsf1
	8T37ia0XwulGoKxCAuRFKZ8TSRJStS75ZxcvWVXCxMPqSPsATp48Zr/ieI1SYEbxzmFMfHE033V
	JbigJoieUwVKAog0VuS92kZ+/t59zuapHABrkgaWvV7RhZyeTkv7CDV2+fvyJHriMPPAGXHS5wL
	Fn2RlxD0d4MHHIoPNOOU7IJLMDvJPEYIm4GH6Ji+uNRvvzezY2RgwJKTnDyM54exU+6oiUwaplj
	Ft9zBgQ2WEJ9f8QOhF7zClqnFl4LLcEKxxE3Irhbi07IjJR4OT9pbP7QP0bq4OcCdw8HsnsFVum
	tGTGcpG+JEDmhbb+EdKxE8EXm4iBziFljzZPm8htocUJzTdGQRcaOQVh/CfPeqYXWMaMmCBrq15
	TshveNld9ctsuSiS7ecBNZtllO
X-Received: by 2002:a05:600c:4685:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-48715fc3994mr129405685e9.5.1774549109900;
        Thu, 26 Mar 2026 11:18:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-48715fc3994mr129405095e9.5.1774549109381;
        Thu, 26 Mar 2026 11:18:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm102069845e9.2.2026.03.26.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 24/24] KVM: nSVM: enable GMET for guests
Date: Thu, 26 Mar 2026 19:17:22 +0100
Message-ID: <20260326181723.218115-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All that needs to be done is moving the GMET bit from vmcs12 to
vmcs02.  The only new thing is that __nested_svm_check_controls
now ensures that ignored-if-unavailable bits are zero in
svm->nested.ctl.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 6 ++++++
 arch/x86/kvm/svm/svm.c    | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4c7bc0e7f908..235477bac7e7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -343,6 +343,8 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 					 struct vmcb_ctrl_area_cached *control)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	if (CC(!vmcb12_is_intercept(control, INTERCEPT_VMRUN)))
 		return false;
 
@@ -364,6 +366,9 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 		return false;
 	}
 
+	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
+		svm->nested.ctl.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+
 	return true;
 }
 
@@ -832,6 +837,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+		vmcb02->control.nested_ctl |= (svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);
 
 		nested_svm_init_mmu_context(vcpu);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 700090c3408c..430e4f4ef55b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5372,6 +5372,9 @@ static __init void svm_set_cpu_caps(void)
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (boot_cpu_has(X86_FEATURE_GMET))
+			kvm_cpu_cap_set(X86_FEATURE_GMET);
+
 		if (vgif)
 			kvm_cpu_cap_set(X86_FEATURE_VGIF);
 
-- 
2.53.0

