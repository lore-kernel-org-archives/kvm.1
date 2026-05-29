Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDD421A09
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079765; cv=none; b=hpZzuPFT7pGOSGZb36cbhprBKlyxQ5yRs4LGsaJxuhYV1aqLzTGzpnpPJbFqO1OUPZZQ+QUBy2xq1zAt29dxJSj6qeYldQ+quzzaemYSnlZ3lHL8U5yzk0j0GywdZUBmlTe9VLIXIvECShL7DVDjCN9cW7eAlcZsEJmbr+GhJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079765; c=relaxed/simple;
	bh=6zMHgUTz910HkRMjPhK2mmo0fhUkyV7gKB3rHBzUOyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZS3+K05xczhsIsNMSl93/1s6zwfMHGl4XsAHrtRjsIModu4MofLVCgLbXiBVe7ngbTJAL3Gq7drr4v84Z7hSj4JcpZYLXMr9u0ldqvIAFntoyMcGTdwGwH5Z2MlwIp8r793m4Zo9y+AOldnmjvruts8Ya6B94iv+XwxWG6x5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKhe30fD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Odrs88SN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKhe30fD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Odrs88SN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLsVryKtB+qjzmc5R5Imnpvup6JXosbAAkLD7ck1kGs=;
	b=KKhe30fDkcLH43ypUdQEMdph1D8OzXkjZ821+Zz7EBeRS1fJmxbXL2bQxai2LPrIXZXFLU
	m01OkeXZY9SnrB1WGE/llaZU7a/WUmQbeBCro2uuo76wwczwnpzXhTzzd3Vs8S1R31AcRt
	/LYBMXG9g/LAkpm2JOW+l17R8bUWRF8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-bIH5yH3TPkmbzAzjhwltRw-1; Fri, 29 May 2026 14:35:58 -0400
X-MC-Unique: bIH5yH3TPkmbzAzjhwltRw-1
X-Mimecast-MFC-AGG-ID: bIH5yH3TPkmbzAzjhwltRw_1780079757
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eec2ba533so1446216f8f.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079757; x=1780684557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLsVryKtB+qjzmc5R5Imnpvup6JXosbAAkLD7ck1kGs=;
        b=Odrs88SNfevg2mv2ZMTP9n9aCtXvxx8mnFL/YAU/q6DwX3A8bf88LwDAgfWEtQwIlv
         /Tu3QzO4eelmRw8nIf5NdE7CYOposgPLmI3UctrLiGylsI/BG9MMAc6ynLIikYuG+Zk/
         e9P+2aWpWJq4fITpeaOEE0NAyI750CgbOitfJOGPvfoA0iph8CrVuZDyBJ0Ttbg/ozTJ
         6nF9RcdBS90EyKyVsriaoN9vpa2K3wNQJdDrCN4P5PuE5N0cHN4TQTGiOendv7AdzjLX
         5stkpe6vWIuvT0dRwh4X+Km87e2Tysi+PXcePPxtGVlItS1j+0i9wG32F6Il2UKvQoG9
         nn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079757; x=1780684557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLsVryKtB+qjzmc5R5Imnpvup6JXosbAAkLD7ck1kGs=;
        b=lfosmN8RpiZyHBvmJMyyGg1FlpJ4RHR/H/eUZcocKnpBkVRG7/K6bZLZ+9Mr/ruPTN
         rfeu65xXG/bCs6jeH7g/SsSgZqrInYf/XuZzjwwSZtQiRcIJGBUDirgT7a/rD6JcbZaN
         C0ua3hcdUz7z7O6FHTeAjUe/HvnOSWWVyyCOnKR+QGHVf/LenMOmI+ZRk0jD15S9bk/7
         bITvUhS6DlAnKErEvaBXFDhTzaVGB6ipr7zKIJhXo/tnp7YboicMQi19L2ldGXpYht3X
         4rSM/wlAN/+Cn6c7TLUlEuqAHWt0CLEpevNp9xI9EnBeUDi8sstzczziq0sUdZEwQjFe
         pHcA==
X-Forwarded-Encrypted: i=1; AFNElJ8R16xSmwpL5N4B5ktFXUaZwKl3VteVZDD6ITHMFAVbhLV9TmSnapJPR1kh3VlZckHp+p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXOizukBQHvgv3Errn8gppoCK6vRJg+9OIDxGd2+7tit1uF4f
	4wXUMuIwxNGOfcc404kdVysqwv6Lu6rb4vDlDXtjN+Z1RNRnbBymC5pfpCXhEQtkOkpFAsv6pL7
	CnLR/b/mYrJBwBQTTGv6FEimZ5pHJIJiuWRLnSguvCZ7UiBrEbWkA1A==
X-Gm-Gg: Acq92OHPq4Cc98Lcur3AYrJpM5w5DBfREjoIWwugRzCh30+nW2IJ5Uw7MFZSWR5hy0v
	JuRd+AcQJvpMkOfTRc/pB8fsxpXWGqKXXK0fzPmERLuNZ1FJC52r/AM/UTELfKYEwVP/q16unLR
	Cla66Jpzb4U07MTYpZBmlD67k6seAY9kwPvxuXCEqS2WbQtqwpjcQ2hLKPMWaW8aEPrmdn82LjN
	j4wXJHivnzNtj3tG/uZyF+dYEAKWhIC79gZ65LHibNSUJrR8QTSkW+O+AdQr35GzwEsjptRNtVS
	s1KQ6Kjfa4A7umMM8NhEYSSE3lkgnU4mWMJG/G6fDw5EWhdGyyJnXn8GeajgU8NzVWPfAJFIqJh
	86GNVd1AryhWc/NMGEIzIzNp2WXZ5TW49DoDhRpfH8vxko/dhKr/RXQY/YeMhniu+77ZSSsOCNY
	EwVAyKthyByeoSQ5mN4ocIFp1ZQB5WTEM/dm/2OQ==
X-Received: by 2002:adf:fe90:0:b0:45e:ee20:b897 with SMTP id ffacd0b85a97d-45ef6aeccb9mr1198546f8f.6.1780079757109;
        Fri, 29 May 2026 11:35:57 -0700 (PDT)
X-Received: by 2002:adf:fe90:0:b0:45e:ee20:b897 with SMTP id ffacd0b85a97d-45ef6aeccb9mr1198515f8f.6.1780079756760;
        Fri, 29 May 2026 11:35:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b7edsm5206450f8f.22.2026.05.29.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/24] KVM: SEV: Ignore MMIO requests of length '0'
Date: Fri, 29 May 2026 20:35:27 +0200
Message-ID: <20260529183549.1104619-3-pbonzini@redhat.com>
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

Explicitly ignore MMIO requests of length '0', so that setting up the
software scratch area (and other code) doesn't have to worry about
underflowing the length, and to allow for special casing '0' in the
future.

Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 23170b64f4a3..fb2174b6d1ba 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4497,13 +4497,17 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE: {
 		bool is_write = control->exit_code == SVM_VMGEXIT_MMIO_WRITE;
+		u64 len = control->exit_info_2;
 
-		ret = setup_vmgexit_scratch(svm, !is_write, control->exit_info_2);
+		if (!len)
+			return 1;
+
+		ret = setup_vmgexit_scratch(svm, !is_write, len);
 		if (ret)
 			break;
 
-		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1,
-				      control->exit_info_2, svm->sev_es.ghcb_sa);
+		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1, len,
+				      svm->sev_es.ghcb_sa);
 		break;
 	}
 	case SVM_VMGEXIT_NMI_COMPLETE:
-- 
2.54.0

