Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63054CA26B
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010818; cv=none; b=E1FZ1Vd0c+h4Wk5jcc4hNZqw1LmMOTS/qXSVD7wgkPw8wkv3Hc0pXUWydsUVOx9EGakUH3tD9b7KRfMOY8uj9hBy9OgvIO7jpM0cio2yEDVAy1X1278g1KqqrzxkrGgMVSF+9uc6MASD9iWuZaO0+mvY1ykdXrHcdvYKwgQryHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010818; c=relaxed/simple;
	bh=Q+YPNG/7sdpVJDJgCVNqBe0D6tPJ4BMvbXkiotrkCcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcChYL20R0DMC6L+qdZnIj+9kMlpSZL20jIQ0SaGgA353wVgffRVJIvmB6+JqcOakmE12+15w8RCSLd0xUkRlVAwZ3d5fY2fOn6dUFnYRXBBfq19PK0Dnrt7E3DRlK4HAx4V+m7gY7z+XcgfigF6Gvg4XzO+4YyrSUqooCA9M6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+jvv5LN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qR2YuLIi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+jvv5LN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qR2YuLIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5tZwhDdjNOAy0xQTnJEw6cdiPs4hsYkEWF7NFBse4o=;
	b=D+jvv5LNIViv1kKAMY0AWe1s8VdnXYWAOCMfZtjhqo684aq57FYIcjaXCz3D6K1iqEhyge
	nogk/sJTtNwCAY5f9gh0s5x5Zt4617Sf9AxkRzK/Y4lRAhJPXG66/TsxkFDt7rZnhy2UNE
	JmCBN/3+3RoIZcp9JB1Mjz9+o9VGluA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-bfyeestpP2md9pFbh0GyIQ-1; Tue, 05 May 2026 15:53:34 -0400
X-MC-Unique: bfyeestpP2md9pFbh0GyIQ-1
X-Mimecast-MFC-AGG-ID: bfyeestpP2md9pFbh0GyIQ_1778010813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d121738feso16405795e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010813; x=1778615613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5tZwhDdjNOAy0xQTnJEw6cdiPs4hsYkEWF7NFBse4o=;
        b=qR2YuLIiNplbuM5+UOmfSnV6/rj22p1Yi60H5hXPEXuFwybQWGLtHlslnqrnrwC8VY
         Zh75SNEw7lzjwctogT0jCJ9gIbvaKXri6caWQqPYrkfrqZAJuX7xXrjszLVtokqgUDKG
         LCEvOQpkZsiXvt3e+OtMuCTbMlDOPeDcPSUE5fBH6/oQRvCj6OEk8eQluf7llQbh2qYj
         22j+PK5N5N93FiQtrSIw1dSwa0k57nj9zCkiuMhTafkLnTvHmliRCWd9MB4ZSMzT/lOu
         GvW9YnOaq6jxYIc6wIVDEPxzQTMdRMRHSim1nKTA7zhtbS3HeXWdtMPFJzguY01u5EYV
         dIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010813; x=1778615613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5tZwhDdjNOAy0xQTnJEw6cdiPs4hsYkEWF7NFBse4o=;
        b=rSjvUp6nB9OUPmbC1Zrl0vNbGMENnHwA4MVmvUMXFQkBrwkRPAb2/V+cQCLVomwa5v
         750QYdGgMmjIQCv8329ZDn6Ns7es8HjKG5uwwIdYcjlxHUYBaRaNj+xlbo2J0L9pW1yK
         zsN/o3AeAuCQfkbCJdNMh9bzCJKm8qGNnE1pMqiZ0yF++aY9fV54AVcgBKPt38WfbClt
         ncN/E6I/dMwP5w0ZFT7qSdNpASqjMh96+7R9i51Y4OpyTTI50W+ENnHgNLmmLiduIpC3
         j24/3VYtYO9kZBxYbmCONFSmtmxYUgXr/fJPLWuBVmO6VMqh1rJvyns71dGrD7LEbnkk
         mo2g==
X-Forwarded-Encrypted: i=1; AFNElJ8O3+kI6WhEMmYMhQGBvbjf59oLt7RyhGlABfhAFNyYsZy3Pho6f7L1J2zYgA5hY8O54X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6dtIfhmGNx+4GAm7pPMbgc4fv+KGQFWFtonP6YhECfAeH7dr
	T7o+hDInqm+qXsn5nyP00LLeMd2qfP4Nc1jUihMNSauD+R2k9diZ4ZJdN7Rx5u3VPrvxjWWV8Ch
	MRYrqvi7eCMJROxg/GxdTYC7q8TKuSnom+fN3qKhtFSCZTWi4PxJRXA==
X-Gm-Gg: AeBDies7xBofRfUkN0WBXZeG1UxRbsKEJdxOwNDORelCDd1foWI47gS3mzYfsuaJ9/P
	8exd75hbts+tLTgeiPCakqEg38prABt9IXvjah1eeOdQfG4TuV1Hpbp6wSTcO1TOHywO5G6bvw2
	0BTtoFyh0BfxiSFHzB21ReLxUQTJuaTKQnui/mcw0Kr3Wxcy4lnIyH4QMCH0zHq+4JVCbYsW5mS
	o6R772q8UhEei1xCOUsuaZXYesuKh3zJkt2VLDNSGtmly8ydz7UmUNw2Y7UsikOQy+Ir++U9ckN
	thwihil0AfDLBtR64oU270nK2FDaYDJlsV8swSp3r1Bp+ON9VIQaC8E8Kezn4OySsDIu1jduVdo
	k5H9qGM9Z8reBlXvsjST9rLUG6rZMEtcy+t9L6w5OHEGmD/LQvqqHgCtUD6vW5UWNAF0bs2NHiR
	8iHjIAxBZWNT74o5RPAHuMi57UO7T/udsXG8g2m1g=
X-Received: by 2002:a05:600c:1d18:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48e51f45c84mr10681925e9.27.1778010813470;
        Tue, 05 May 2026 12:53:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1d18:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48e51f45c84mr10681745e9.27.1778010813186;
        Tue, 05 May 2026 12:53:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822bf3ffsm457713335e9.7.2026.05.05.12.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 27/28] KVM: SVM: work around errata 1218
Date: Tue,  5 May 2026 21:52:25 +0200
Message-ID: <20260505195226.563317-28-pbonzini@redhat.com>
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

According to AMD, the hypervisor may not be able to determine whether a
fault was a GMET fault or an NX fault based on EXITINFO1, and software
"must read the relevant VMCB to determine whether a fault was a GMET
fault or an NX fault".  The APM further details that they meant the
CPL field.

KVM uses the page fault error code to distinguish the causes of a
nested page fault, so recalculate the PFERR_USER_MASK bit of the
vmexit information.  Only do it for fetches and only if GMET is in
use, because KVM does not differentiate based on PFERR_USER_MASK
for other nested NPT page faults.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3895d8794366..fd79874c5f4b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1993,6 +1993,18 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	if (!is_sev_es_guest(vcpu) &&
+	    (svm->vmcb->control.misc_ctl & SVM_MISC_ENABLE_GMET) &&
+	    (error_code & PFERR_FETCH_MASK)) {
+		/*
+		 * Work around errata 1218: EXITINFO1[2] May Be Incorrectly Set
+		 * When GMET (Guest Mode Execute Trap extension) is Enabled
+		 */
+		error_code |= PFERR_USER_MASK;
+		if (svm_get_cpl(vcpu) != 3)
+			error_code &= ~PFERR_USER_MASK;
+	}
+
 	if (is_sev_snp_guest(vcpu) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
-- 
2.54.0

