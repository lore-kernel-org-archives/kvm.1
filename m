Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE2450909
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079805; cv=none; b=EtRytEZrX+C2S52eAmV8xEWf1aIn4c9E2T32wPBsMV4m3Xscx7SMDBUGKHLst5CZ/itmcUKot8BIz3DU3soEqtV3Y3Y/fT33BCCImzhellWO1hC+sDWM/nDE19E/6k0kiOCQQGC83fF+XwFIawYsbc8/sKha14ciuOfWbCpEAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079805; c=relaxed/simple;
	bh=DW2PUzvZkPeDxrXgPu51jPm/Jji/jDPOTkA5AbO8VMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBKdpE/kPQJdQFkCmlQWBjEzg2DTv0CYQGCFOkMerdrSh5HhdJUXKzlz5qvArz9n7D2fGQ97slsYsoDlBjcEX0moZVdU+YOk6E+gmYRJZ8w3cyw332Lmrb9wBzaVQryv4gnrdhIy3CNSHm+Fx+zBiBrZ1gh7hrxdMNEBdvEfxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1FP7LZe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=axP4LoCi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1FP7LZe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="axP4LoCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYkh8jiq7SEyEfVyi04hmQY3u+cvHZraHKSEMFmK1TQ=;
	b=F1FP7LZeflTjDd/iWLtpPfdxWut26Mgh5asz0oSXaI7CchJKdpXeK+tVul3f5XszTnPPnN
	17jJWiNim0hekzV913jaySmJ1dBMqjHJBJjz0MuUgw1S3lUrKP1pJNzvIlNpWcDZeqf0IR
	AbiXF7FbIo9aq0PJbFAziEVN6VvRo0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-TIqLCmGHMaaPLflN8WYPZg-1; Fri, 29 May 2026 14:36:39 -0400
X-MC-Unique: TIqLCmGHMaaPLflN8WYPZg-1
X-Mimecast-MFC-AGG-ID: TIqLCmGHMaaPLflN8WYPZg_1780079798
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so62197255e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079798; x=1780684598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYkh8jiq7SEyEfVyi04hmQY3u+cvHZraHKSEMFmK1TQ=;
        b=axP4LoCifqBoHeS36wfwxevGyK0R4eL6iHCZRh9F0iyeibQBAE6F09u4Go0/NviPfT
         x55aAtwKMOlh5A5HXGXzqMrUw4tArfu3JaO9aVdWKtou13vADQvDhN3tKjOhChLZnXGZ
         I0WexmIA4cS7U10n3X2Q0XIYZZk5qNdHRXlAjJj3FDL+ztjc0uuRh1gI2Izh2Q2g29SH
         yiz5PbDZdOpJZ28su7DLiWlRWe+QsBM9igfdlE0W4vV3kQfpKpuuVedu3kkbyGDHssrE
         k+33yQvpSo1Q/6za2NkjG4kBXnmAzbjagUSA4Vn5DOPA0pdKkAt4YBXQKyy4tg4M+20J
         0djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079798; x=1780684598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYkh8jiq7SEyEfVyi04hmQY3u+cvHZraHKSEMFmK1TQ=;
        b=mYuFxA2PNlE9xurzwW8dFCjQM//xcxLLjID5m4f2Q3/tqLi40kR0cpW/GyWCfAfPyc
         CISL34TY52CtkpefsUM3nmwgfzXnBnbQZv/a9tiFc5rKNuVfVHlnWUwHvuga6EnnaSrl
         dUFACWcI2RNbPEvNX+eZsEz4WGUGVRSXoRbv/ZnrZMmWAqvtS725lbFAOdtEGzK5eyZc
         HQ6gqZGWXXNTNLXTgQUfEDSQbbZfLZn1LuR80ct8pOr6Jmj1uZ3TQVYFjHnIv3++zQ5L
         mkxlGCh6PEu8MWSmp7E9V0SPdrToL85ONqz9JAwqWZWMp/S2KyL+TuKxil14BSHXdRne
         irKw==
X-Forwarded-Encrypted: i=1; AFNElJ8o5CGMe5EH3amuFaRyRYdOasfGuFvOB5AhGCs2JsbsV6sVIh3vz18M+HRfLK6RrHBph9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2a4X0WOAVOYWiJm5j/NWfXchROYrk3A4Gv7fpYX49iwxEnnwT
	nDWtgMBENPtR4fTw3DBLeA6lOnf7QvK6WFxt1b2dREnNOGWYv9V+nEpr1teKIzFh9TLB1+8HBWt
	ynHFbgzJmtEZ+kReIfAk93Duqzxl7/TKXV9v/xIsE584nOSspVOqNnw==
X-Gm-Gg: Acq92OENScCmIvvkV098U2DQ/1k9XDFG9Z3x10DiNwtSq1GrW4NIa4I2hjCwBaInO4q
	6Oa4mwtE8Sb7QMqkZtqadYw9TiGZ5fEBUqt52VIQPWbXI5CwPegVqV+OozYQ6gRVz9p7BYITtLi
	M7zf9jRy2G8Jo2Kh/qBFBAhMoSbliKnXfjoOmY1yiAtPuzuYpWmga56NfhHIGaH54uFpB6vw5lt
	JXPqXvI3VkYVT8X/TTK+VgqqhwbYVMOqTpCvlDv0BZf0j/gY0tl3xYcwPRfkWC68eMU1Bw2S4F1
	GIfDc+Ajs6VEuMvVNDkbDKqClxANRcY/KVPj47r24FWYMtY0++gGdbHdL/7MIta1ewJ8tukF4et
	yGq/9nwH669227BG3b/8MTWxGdZnoMcSHEt2QNgxAMIZzKNLsaeaswz77RILcMuDgTVe+Hzauen
	l5GGfP9yn/ToxkvaVtjxX2mfCR1or72C/D9rb5kQ==
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr12285205e9.26.1780079798397;
        Fri, 29 May 2026 11:36:38 -0700 (PDT)
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr12284925e9.26.1780079797965;
        Fri, 29 May 2026 11:36:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm5633245f8f.34.2026.05.29.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 17/24] KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
Date: Fri, 29 May 2026 20:35:42 +0200
Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
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

Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Tested-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-18-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 11d46600cbdc..6c6a6d663e29 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3552,6 +3552,20 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	return 1;
 }
 
+static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
+{
+	if (svm->sev_es.ghcb_sa_free) {
+		kvfree(svm->sev_es.ghcb_sa);
+		svm->sev_es.ghcb_sa = NULL;
+		svm->sev_es.ghcb_sa_free = false;
+	}
+
+	if (svm->sev_es.ghcb) {
+		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);
+		svm->sev_es.ghcb = NULL;
+	}
+}
+
 void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 {
 	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
@@ -3570,18 +3584,11 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 		svm->sev_es.ghcb_sa_sync = false;
 	}
 
-	if (svm->sev_es.ghcb_sa_free) {
-		kvfree(svm->sev_es.ghcb_sa);
-		svm->sev_es.ghcb_sa = NULL;
-		svm->sev_es.ghcb_sa_free = false;
-	}
-
 	trace_kvm_vmgexit_exit(svm->vcpu.vcpu_id, svm->sev_es.ghcb);
 
 	sev_es_sync_to_ghcb(svm);
 
-	kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);
-	svm->sev_es.ghcb = NULL;
+	__sev_es_unmap_ghcb(svm);
 }
 
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
@@ -3611,8 +3618,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__free_page(virt_to_page(svm->sev_es.vmsa));
 
 skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
+	__sev_es_unmap_ghcb(svm);
 }
 
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
-- 
2.54.0

