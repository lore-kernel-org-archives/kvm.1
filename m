Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754C4CA27C
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010821; cv=none; b=Sze1EMDnkJhkJahcSwDidrExMH0hH647vksdlhm/H32CL2s6UvGCfWeayn2iLmOd04Gf2zeC6wLP5bTQOWWrQwlkdRbOH+oqtOvaQkAfOkSgcsbnP7wyba9TzHtrtJuzG6O05pLP46H8RIpaoGxGlF+VEdhqcYKg12y3DIQ5pYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010821; c=relaxed/simple;
	bh=3AddREP+PjzVhR5hdP8L2HZju6wfpL/hFsaIQBUjFRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E56BE3jaFhR0zR26X1lx+QAYy3MtmGSgh5AOLPo2GlX63v9IwWLf77QPY2kL/KMMSAgt2mRPKfiWeUY9XcjuqajE7sTBaaGzMPnXxcbPYCRn6VoaCG/Bc5G/w/7T8Q/LumDv3YQKIFXlTMAAkmxORDlTyK7NjRZj0YeRLaF2vYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWslmkO7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mVaGyAIW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWslmkO7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mVaGyAIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LwnkmTecZdqjTIP8zSR3v8jKVuAlnagwhGxO6m9tBA=;
	b=GWslmkO7c7GsUwC0TVcOXYhp5pvjJjNzfU1tq2h7p0tdEln8b0bCL3ecXstwm6gHFn5UxO
	CB2O/+C/JIdFydCvjW9vJDTz6T0vqB2ujytdICEYtD3KMnv5EKmr5Ca2RrkmZbWQaw/XHR
	VV58UBeToABsrfSvNdLTcuxP3jvWu/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-AncfhVoqO5uEF17HthMHlQ-1; Tue, 05 May 2026 15:53:36 -0400
X-MC-Unique: AncfhVoqO5uEF17HthMHlQ-1
X-Mimecast-MFC-AGG-ID: AncfhVoqO5uEF17HthMHlQ_1778010816
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a9592f666so25626335e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010815; x=1778615615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LwnkmTecZdqjTIP8zSR3v8jKVuAlnagwhGxO6m9tBA=;
        b=mVaGyAIWDnxD+zfOeLEoGzxek3V3G4F//4rSD0zkL/ulSU+o39mlwKHzzataIBR69g
         4zR3s/ve+croNcAoIc7ZQSh6uCSwMNKzAQoCMjrSWcaIIAHfrtb0cv2f7EIYX98mHEnc
         FNzkbhMNsmGxr3behoS9jOWGWZ7+E+0XecYjToqzqQPuL9kRPq9t+ATwyFlxTuEcIUr0
         GVHzDmcdK24OsWv4YgFy+cO2U+m4D9BLa3kzLzWbOHvO1JcfwHF3d0yURvJV1ujZzQpZ
         Wu8fTSzLGkXDg4W2gOTZbj+pbIhJICMPd5rbPcOL3bdQyN1irDIzuYp1o4BwfhI8awaJ
         HXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010815; x=1778615615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LwnkmTecZdqjTIP8zSR3v8jKVuAlnagwhGxO6m9tBA=;
        b=NyiEZhkRsjFnZoJsykH5EX9ZKnNE1MqPeZi4yQzaMsIIwTA35uQMAaWCfKlmhbDzbE
         qoqbrkI8TBNalHglnl65L9sd36TPAv5FFF61z+pk8bL6mV9SsstmxJk5+Ep+Wy+3Rc7i
         NX57OP5+OgRQL236sVj5Lrb7WW1quKrw87GZ9x/ERUO2oUP8XyY5OAPIYdAHr4aolKw5
         AYVYREkQJ3Lj+7oBH1/TjJwFz/HWAsaZOh425BDRQLhGoAi/O89UCYzzRkn2eg30WEC3
         4fag1ostl8nqG72QQHpmoKX+hESymxvtbwO1tcuNVT+7j9yJx6Pqlfjm2u+doDYtqlww
         wO/g==
X-Forwarded-Encrypted: i=1; AFNElJ+VANTY6QDKC/wszgCrj5llMVujl1NN++b89+bwpic6z93RLcdLqDt0SHPCG9ZWMuQ4RDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxfgVUPZKKgxSNu2r6k4OZEuTpRWlQhRcWfFr2ek0MtYBKm3e
	cslwN5eNxZFaZOR4sSIl+MJtJTZS63VozA3bmK4DaugwV8IYQ42XS7KV1LJHU55UNikKVrSagw+
	SD1vmq/xBXDRQdKByZ5Xvwj20FLpFawPReQyfcBLAql0D55o1AJlH9w==
X-Gm-Gg: AeBDieu/YkUVj2DmlU9TvhVPhEoDDdTzT4VGK2ldvy4H5GwpWqq3dOB7vzTZcg1e6VH
	2xaYTJbVfZVhm+yppXYFoX4DoXPPgV0PkJCffh3B1FeSwFQ9HOAmJR/SHW+rM7l/hd8Z6YdV/Y5
	awOT4QLXEaUbNXrOeFzEXk0D+cNVbPg7j2S00KOUe2n5XVw630fLeJZIG/6rWhPBm1rTexDRgUs
	uFIx6+xPkBrkjOMQT2++vmkAiKAw4hHVzxMqFdP5rBd7dWq0Pi4S6KI1Ehqie+b2bOOfQh3vdLQ
	YsOqb+UgElTG92F5bT+336TIK15759H6LbgiEKIfaBWGVOaFew7VS8ut6sB8czAX4kI9bcPCJGv
	lVYC/0jQ4RFrNQnc9H/Hd5jIyeIO9byOYu+UVASdQcX59An3Hk5/p+e8QNhWIdDPiDsMwd1A/Vh
	Jls3nBX03jWp9iNZfiWd4Q/CpOuKWwtJRO2/sCB4M=
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr10466915e9.17.1778010815630;
        Tue, 05 May 2026 12:53:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48e51f32811mr10466565e9.17.1778010815242;
        Tue, 05 May 2026 12:53:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm382396205e9.7.2026.05.05.12.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 28/28] KVM: nSVM: enable GMET for guests
Date: Tue,  5 May 2026 21:52:26 +0200
Message-ID: <20260505195226.563317-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All that needs to be done is moving the GMET bit from vmcb12 to vmcb02.
The only new thing is that __nested_copy_vmcb_control_to_cache now
ensures that ignored-if-unavailable bits are zero in svm->nested.ctl.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 6 +++++-
 arch/x86/kvm/svm/svm.c    | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 74a1df1cb84f..3d1fd1776e19 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -489,11 +489,14 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	nested_svm_sanitize_intercept(vcpu, to, SKINIT);
 	nested_svm_sanitize_intercept(vcpu, to, RDPRU);
 
-	/* Always clear SVM_MISC_ENABLE_NP if the guest cannot use NPTs */
+	/* Always clear misc_ctl bits that the guest cannot use */
 	to->misc_ctl = from->misc_ctl;
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
 
+	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
+		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+
 	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
 	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
@@ -898,6 +901,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+		vmcb02->control.misc_ctl |= (svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET);
 
 		nested_svm_init_mmu_context(vcpu);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fd79874c5f4b..a82471a6d3ea 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5504,6 +5504,9 @@ static __init void svm_set_cpu_caps(void)
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (gmet_enabled)
+			kvm_cpu_cap_set(X86_FEATURE_GMET);
+
 		if (vgif)
 			kvm_cpu_cap_set(X86_FEATURE_VGIF);
 
-- 
2.54.0

