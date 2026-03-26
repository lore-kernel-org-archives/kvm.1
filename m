Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE53A5454
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549112; cv=none; b=OrbXfowyyobrpHhvg1FMBuH8oHo1jYIwBwds+GjTT+vXp2RUfRNmyLAEAGxX9ugvDicLjSBoin9R9hVUx63P6G6ZRDbe1rrM6I5jC+9CA/IatFm5DR4x94R3MryPVNynHoRYCrijgEcCDyPJRuuvkLNeAzsL0j5rkbDjIq5xGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549112; c=relaxed/simple;
	bh=bCeunf4aD6VnWOdwN1AXGMHgrohJ0mEw507F8rqPwnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQ2arFEnQrc2yRzb7YC3mNYfqgaPiOGNGFgLNdLC1j8/LUlsLy7wEI82ID3GzfT1ijDI3P4l7skw8ygdDM/dxsDeMtUbRUgzw/hafYddVbRjIJ9yArxgsH/wwMDTGjsKnknxbka2jOtyNNQGyIxh2nET4cqhH+WUlqQ2PRNsgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAIRIMbj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNLlGdq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAIRIMbj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNLlGdq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHVbX3hFS+vC3v0LRpnVDXrZsOhD+5Tu40Fbv1jZAKo=;
	b=TAIRIMbj/KyBOlOhCHY/XIKwcNtVVaRpgwDY6yBaDnSWKL1sQ9QefM1XVK/JQagY+omtR8
	uDebeoEqTWc2lvEIUJ0zPjUi7BtIdxJUDEHZgk2rtWFR/rRJst/EEX69n9cIQN6IqeYe+D
	2M9sjmTaYAUgO7DDF9XtG5quqK9dhrc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-qK8NAuB6MEm6q5-RNKbaGw-1; Thu, 26 Mar 2026 14:18:29 -0400
X-MC-Unique: qK8NAuB6MEm6q5-RNKbaGw-1
X-Mimecast-MFC-AGG-ID: qK8NAuB6MEm6q5-RNKbaGw_1774549108
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853466655dso930225e9.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549107; x=1775153907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHVbX3hFS+vC3v0LRpnVDXrZsOhD+5Tu40Fbv1jZAKo=;
        b=gNLlGdq14vkHCZDf0OQc3n2ai2oBwqTF/2hXUMIkPrXnS7m9Uih1UGFp5ftC1QJqHK
         mT98vbmsYbMD55IHqTjpZNk+6IBN363FtxPZ1rmiqv1xJYdbELD6cbngGFm70qynVR+/
         mO37MCbQMOf91zXp9s62CXidiP/V7Wwl31cMrCMt+0gHycsRUJRquyqdfGdsxU7zA1Dh
         o3HzillrCwYXRYjkerDK1nxVcfQFYkaXVQ3wNACnacalHVLmRDxyVOp0nGxLoOMNXuR6
         +yG9fgJ9wZhiVCUcXA3U5MaVayCpPzp0sxxC/hylZXHEPSImnj5mu++q3+Wh1BHXDrXX
         ojkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549107; x=1775153907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHVbX3hFS+vC3v0LRpnVDXrZsOhD+5Tu40Fbv1jZAKo=;
        b=N6tX9qc0+JKOIPLbf/OzqlMhpot3h4h0XhmzyTvmO2o3LUhn01DgtcIOCkqp059Y/y
         ElO3Ih7DznvjcNC1zM1zQOljQDTosWV0kdKxNcOd0ik0GtPja+rTN9gErGWAmFZ1g+6E
         PxKYYGtBo3ujKa9TCr95v8uQaPaHV/J0RrigNH/DFziyZNYb/2b76bIBmpeQ/wwfpqxV
         wxTt0Rnh6aW1g/PoBLeyUnJoaDZnq9ZyAP878FysFno+huIBd/rvf7J6qTZ+C9PUTiRW
         kcimiffFtaOyp+YC2Gqyvfu3YghiDGjmuJRgd3AWmEgP8oxkljF6WyiWc6jWYmpIrN77
         vmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCOkJ36kU/eWkEem4nqJ1AjRAmFshFdl8bRngOVKVH3SmTgURDUUBTxfE6vVm13v3f/yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IYV9F2ePttjj9SldgMqmrzOcAdCKnm+oGe9QvMy25eotboBS
	71+EptBwKr1CelP+ZFF9rSZHyWkBCLSLa5vf4DI6tJhSN4HyWRN6UnFryO8XFdhBbVs1eSG7raN
	KWu5bR50K4JI6g7ixEePMA2mAX75IinKC4xY8fc18dC17mxYR2xNrxHPbEDjZIA==
X-Gm-Gg: ATEYQzySKNBv35NYwU1sGRHvdNRg2/YOig+/nHlFzPtgcfGTGw03nV/t8znFLgPYCht
	fRmZ1wK8WmjRb3sGv4GAI16lrLqyksvRU3SD6uBIm5WY7VdFM+PUMWEwowRHTOk34IOJjZZpMRG
	vxKao0VxxIM9MjAmO3bzdW2Lzi3y/QwsG2sF4+vR6xz3YHRWFx3VIJxwGgVp074af5HI1xW1YmC
	sP2zrCYweVS3rsqxFohOg87XUMyprRgBL3sLAILX0rwrCnsyzhtQ2taFbOl1t5VV+8AY7lW0nnk
	EDzGX8C27vBl1+M35EWOpzT9WO8rEysE74mBhkzVOlUEfoluKnOpe1NPm5Pp9uIo1+LptV7ht86
	xkZUeVYgmRQ/VrnvXygUPSLx1BHjZuwQX2D+e/8sCOMgLOnAY1Ww/T1EhjoT7JlX+ZjdJqt2S8a
	IJIzd4Klg9rcu6zjuynBrYDJVW
X-Received: by 2002:a05:600c:a010:b0:487:4cb:2fe4 with SMTP id 5b1f17b1804b1-487160bccf1mr136108995e9.33.1774549107320;
        Thu, 26 Mar 2026 11:18:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a010:b0:487:4cb:2fe4 with SMTP id 5b1f17b1804b1-487160bccf1mr136108355e9.33.1774549106779;
        Thu, 26 Mar 2026 11:18:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b105sm87552805e9.1.2026.03.26.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 23/24] KVM: SVM: work around errata 1218
Date: Thu, 26 Mar 2026 19:17:21 +0100
Message-ID: <20260326181723.218115-24-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1705e3cafcb0..700090c3408c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1957,6 +1957,17 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	if ((svm->vmcb->control.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE) &&
+	    (error_code & PFERR_FETCH_MASK)) {
+		/*
+		 * Work around errata 1218: EXITINFO1[2] May Be Incorrectly Set
+		 * When GMET (Guest Mode Execute Trap extension) is Enabled
+		 */
+		error_code |= PFERR_USER_MASK;
+		if (svm_get_cpl(vcpu) == 0)
+			error_code &= ~PFERR_USER_MASK;
+	}
+
 	if (sev_snp_guest(vcpu->kvm) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
-- 
2.53.0

