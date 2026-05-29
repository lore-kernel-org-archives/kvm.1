Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB06429825
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079777; cv=none; b=m4deE1R8dk4eFi/xAE7ZJy/VsbB6tWTevDA23c2H5jXs7+OYnWhSSqYqBCo+izsdbZF5FTwhxhv27btC2fA0uTdvxYyrdhCiunVf4yZVH/nFdWEIyq8/45gNM5g6z8/VI16WcMoqnlKH1b+rDAh0gx0jBQNmEy125bFMkFojZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079777; c=relaxed/simple;
	bh=tQ9+tE+DbULo1I89vDeIy9JMoLMUcQfgtStrqd9V650=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adpXf+4y5Qj6DsxsHNYHh+riVEEG5t1fIPpkflD4Una6HdbsYSphpZzIguSOLfJhYF9MG6e4nRXmQliw1+B4MrSjh9JwXAi2yFuMjlLnwb8s4M6bbrI67eJ5QG8/9MgLxQ1saYHRI34+dci7sAFLcsEjlzE5K29B8cNDG5sboRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Upz+3qUr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI3FInmS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upz+3qUr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI3FInmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0u/shZrwVj4PqbRgkkyXanK2+FAoAVtVPTTfQ581C8=;
	b=Upz+3qUru6L6HTlgRck3piMjRoIw1Kn97ZuA/DXiqVHvqYi25HarQlBQegJNL1OKH0031M
	pJWqmlGU/kXkGvRtJ+40Reb/yz/ZXnRigV9jfucPj62tFuKprh2Dof2B97nrs7Angi3/xR
	2h1TSwMEQtuE6PIWzVqet9J+Zxv8OY0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-_KTs_nNyOBCdCvgN0K0YAg-1; Fri, 29 May 2026 14:36:11 -0400
X-MC-Unique: _KTs_nNyOBCdCvgN0K0YAg-1
X-Mimecast-MFC-AGG-ID: _KTs_nNyOBCdCvgN0K0YAg_1780079771
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so287220f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079770; x=1780684570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0u/shZrwVj4PqbRgkkyXanK2+FAoAVtVPTTfQ581C8=;
        b=gI3FInmSyyh0mZ5QbmzJOwcWEdDuLaNUuOpCUGVsiL4xWLx11BctQ0sHc4aFEDu1s8
         KclzuBNatRgS/y3UnQOwGgWmjslMhI62eBrw0tl0XYQWOzCSGa8k9dsyvcYwN2yHN+GN
         uNE2xfmeX39T2glce1gMUELLs0DbrDkinzFtfRq0KhWELDaUA5caVmqNBcHh9NE8jf0l
         a+KfD0C8Ksxpfyf882jmXRH+7+cgdQyDud7XoMhnYgrRsRPjOd/nPWJALWIuykhBsfNh
         Tx38lru3CssFg6RCNmqaPXeZB/1awxBcQB93zmFMEo4ZP/yar9Z7sylOi/JfRt5IPLFt
         hg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079770; x=1780684570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R0u/shZrwVj4PqbRgkkyXanK2+FAoAVtVPTTfQ581C8=;
        b=T7eOGXoKimCxGRCxm5wedtBgPp52l7RnmHtnU/ps2ZDyjWZFFEclZvsu8n2rZ9DrlZ
         6maMgdXWbe1mSP9mdGJ7eAiw3gWo3Y1RVfAC8QeWtNMFJEfjEteSdR3k/N5Hh/ssYYpc
         cXflJXPUJSNFHZXJ1XekHxfE9iS9wMgvyVCCccv45AByhcOVoDjGwW1PuvnPJnCUwCGY
         QD4cROKIXKlXCtmungl6mNYO975yv5hEssPtnKsFANyXT9ifKfVqMUAd9UNun/WilTZM
         UdYPJP7TW+e7qzUoTUhqg/6dS15/h60EcvWv4HLf+bkdySXYTL7bF9m6BPyYdfIBjyYm
         nJNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IU14v384EjIQBjGashmch/dd9BimOj9KMYobD4mKaDkfA2zys8bRL1upAjY9ml5SUq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ovseY/hQprguIMFZbNv53wfXc0XN53pfkDup0AFmcuyBl8AX
	8kLWDbUHOEB7xAf4O/WKIK0iIV49cny2n5lFI8dS+xtx5R7g/93tXm0NKDXLnrRpJ7FbFHaecUw
	Tu2tSt4kZOgaxW0HmX8pO7XUOwvMqVaa3wfsGsu3ef0ttIhKExMOw5w==
X-Gm-Gg: Acq92OGhHJmE84RQH875cVwvwpePR+jMfYCMQTpEd65yldh/uMF97qt8Rf1V25A8M24
	dkZ4pv4wL/xi7dp9c/p3K/eAdl7mbzynT8SmRN81iS7D/ZVS409d6cUuuFHbvPW9K3664c0d2uy
	1Fx2H6JhEJIzvOhk/i/e6oy5YAE7J/CzUPH7/SqksQFEZNd4zE+Cls/02yD7DQDuAp/KTV0Iqqm
	T7d70Z5f5Z4wLcBm7xvLF/QtP6LHDwd0nClmQsv5WhOjnTsysxujLQ5BjDFK0qib384gIth56Ad
	WnUrWFlAIKIMbfO2AWGf6BAe5GrFU2rbxNEog7jngHyoYFzNtLKkRNwpupCm7oOvWsy7IPm6sfF
	L8pbx/wJgebmg099oVX/HSJw4ckf3ouhiP0Um6G2UAKadlfY8TrB9g7qgFeLIYBd3tSgMjEUucw
	QI5UugGFgXMeLmFp2gA4b43sFSSYyZWsAPx6eQzg==
X-Received: by 2002:a5d:698b:0:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-45ef6b3e21cmr1332775f8f.16.1780079770582;
        Fri, 29 May 2026 11:36:10 -0700 (PDT)
X-Received: by 2002:a5d:698b:0:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-45ef6b3e21cmr1332738f8f.16.1780079770148;
        Fri, 29 May 2026 11:36:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bcc30sm5367936f8f.12.2026.05.29.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 08/24] KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()
Date: Fri, 29 May 2026 20:35:33 +0200
Message-ID: <20260529183549.1104619-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Stop explicitly passing the PSC buffer to snp_begin_psc(): it *must*
be the scratch area.  This will allow fixing a variety of bugs without
further complicating the code.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-9-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a3e85348ace9..8577451b82b2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3841,7 +3841,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc);
+static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3883,7 +3883,6 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
 
 	if (vcpu->run->hypercall.ret) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
@@ -3893,11 +3892,13 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 	__snp_complete_one_psc(svm);
 
 	/* Handle the next range (if any). */
-	return snp_begin_psc(svm, psc);
+	return snp_begin_psc(svm);
 }
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
+static int snp_begin_psc(struct vcpu_svm *svm)
 {
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *psc = sev_es->ghcb_sa;
 	struct psc_entry *entries = psc->entries;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_hdr *hdr = &psc->hdr;
@@ -4567,7 +4568,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (ret)
 			break;
 
-		ret = snp_begin_psc(svm, svm->sev_es.ghcb_sa);
+		ret = snp_begin_psc(svm);
 		break;
 	case SVM_VMGEXIT_AP_CREATION:
 		ret = sev_snp_ap_creation(svm);
-- 
2.54.0

