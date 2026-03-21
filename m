Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02833688F
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051842; cv=none; b=u6hdYuVSoiZcs4t/KwHJ/msd2chTzU1ALFaIeXsVMQJ/oJ74oaXMdT+iQnmQv+2N2aLbOGvAeXcwkavmtUBvXJJBpGeGd1Zhftd++cPQdPyylegTL4hRHxP2qG5ZwFI6dWkZXMr6BLmj4kkOkibkAniOhd8vEqxBQD+mSZyJ5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051842; c=relaxed/simple;
	bh=Loq38pc2FyCTTkUH2qMFtWu6mBPZyloNiwBME48/IOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daJhOt0ZW9oh3vG0+xtJGTxZwCASRhp9h4+7mV4JU/RCCg93X6bAIL9H1xXXNQRE4Znn23hQOij8jyKl2PdwJnHA14fzC6r2CwV/EDHmr5xTJYQS196oK1SLnNsXDPlyBCAonSdUCBaRogUL1Ma5ysKsYKumjn7URfzIiPtA9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8IQPcHQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsgFnK1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8IQPcHQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsgFnK1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oK7Mm/ibwQ8WVpy8saAqcL4LBF/TxI9WNZ7MQXytY1w=;
	b=D8IQPcHQtXnMdepQZ3sP4hNmqDzn4sRe8dDmJ4ZaAwis5f8yqK5jNNSkBDzwDE35MvIn9w
	bMkHuNqqvJLwDXTKZ3u679nlkPFwa8fYMhVAqwL0JwyZWnEiQSONJzGFAxiJvWZtVYLSe8
	uWVJ3333YmldD0S+/4VB32Cn3GJEi50=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-J3WmDoG6N2GHSL3R1Um5lg-1; Fri, 20 Mar 2026 20:10:38 -0400
X-MC-Unique: J3WmDoG6N2GHSL3R1Um5lg-1
X-Mimecast-MFC-AGG-ID: J3WmDoG6N2GHSL3R1Um5lg_1774051838
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fb29a8b8so23527135e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051837; x=1774656637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK7Mm/ibwQ8WVpy8saAqcL4LBF/TxI9WNZ7MQXytY1w=;
        b=MsgFnK1r3KKD6YSkgcT4oINtMalugaaeYLOwGCMjTGGKPoqihZjgHbJvnz6a+ju3C5
         zIz2V6pGhqlVkBLoiJi2Jcfrk2i1jKHTLD/NNBqJUSVqLw8QVGH7q1ZvhFeEc7efWZEQ
         V9WRc4vOfYO24JN9T40EtFrRUqiBVy7+PBPaIYwIGX3UGws4MW0dif/GopsYUzxWpI6s
         SXWQC/1zEor9JsNQAEqe7oCcdsFmuWJzoz4hpOa0POdpUbNwNx35hU89pa76fG59MaTK
         5pfZuaMiRBAlu9wZHv4crAWcQ2hZDek5QNODQUiDvdw6qwomx+KQ0Jc9wNmQ4Zpa+tpq
         0R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051837; x=1774656637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oK7Mm/ibwQ8WVpy8saAqcL4LBF/TxI9WNZ7MQXytY1w=;
        b=i1v1zMw4Tzpr7THfKssk2HQdJsz0E8POXX92ZCXNQtxob7UNIPoEj98RCwQuhCl3Ar
         wsBGusiR4Mr90t1MudwU7E3g0UVLv5aCWKxjDaNEliIFEXmbDZwEPBJIkmqP4+Buw9/m
         E9aJCzpqsoS3PQCOHnBo5z9eN4UvKK8s+Y1tMEqXOWIakU4FpWQnj4x0CIkaP4LHN5Px
         rfNEfFe1YAdck85JQqKkktKEKXbfZpriTTVIFovFRkzz4PuZBm9/ZPfbZrhxKJqDTEcs
         nLEnB51vgCO40D9XMyM+kQc99ycyv/1dnx54IKO7nET2YmqMO/oYBCqODp8kkZoBvfLu
         5UNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLXHAAtuddPRdJPG3F9fkDzLW+zmJGkPFFeAdYuoFgXpD1NeqACxW6wpmVXnFb94lTgv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUMmN4wcgOlkjkBJuXZ4qM665UlMpRbJETdVjBhiGb0IqVgE+
	L9bQeS7sRhGwY3oFtiRPBMxkYhHuxkPYzKXfn9Mb9AVQY+Bmb0thoosAvPmLCDa7H2qTkewymsJ
	rQW8L3bp3ohAup4vjOS+PzGCZykIhzBoXRIaX6FI5dhvwl5FbGVIJvEmdM2asoA==
X-Gm-Gg: ATEYQzwvSOC6g50qf7KLImqDNtNea22r2oBkLo1PhN8HLmqBXAsjUP3H6cDUGMaT9hW
	CgWskgzsW3jh07CvwIZS90Rrk866pPAA3rc1EFeYeKgV79Y4A5PU3bM3uaMCIksZ3hL2KgCY4oS
	/dZQVm/SzMPmIPilI1y+fO/yFdTlKQnf0iotWpBhA1mklmeVMxrzvohpoPmhPcqn7k/AXeTDnaf
	NkI22TewFo+/BkIAf6QXFCTH9IuLKkSRkqqm1+cZzasGuwCmuEsj/tzxQ7QN+Jv5BmA21Nk8SfP
	kLHAgEwUyHnJ6EMw+bEvVMt/81wPF425kxXuBGaKD8lZObMrZ+DmEXOzjRAky22+nn/UnxPPRKj
	Qqp1zxOI7mifQ+igoUO95A9n1/abcC94Iwi48/VXpZhMEzBAr7e3U1z0ixGAj8ECecPVOV1bXVT
	BhwYneONqBlMHER3ex255Kj3rS
X-Received: by 2002:a05:6000:609:b0:439:c14b:2100 with SMTP id ffacd0b85a97d-43b64243dc6mr8340196f8f.12.1774051837206;
        Fri, 20 Mar 2026 17:10:37 -0700 (PDT)
X-Received: by 2002:a05:6000:609:b0:439:c14b:2100 with SMTP id ffacd0b85a97d-43b64243dc6mr8340171f8f.12.1774051836821;
        Fri, 20 Mar 2026 17:10:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm12022594f8f.12.2026.03.20.17.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 22/22] KVM: nSVM: enable GMET for guests
Date: Sat, 21 Mar 2026 01:09:31 +0100
Message-ID: <20260321000931.1947084-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

All that needs to be done is moving the GMET bit from vmcs12 to
vmcs02.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 3 +++
 arch/x86/kvm/svm/svm.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d69bcf52f948..397e9afecb78 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -774,6 +774,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		vmcb02->control.bus_lock_counter = 0;
 
 	vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
+		vmcb02->control.nested_ctl |=
+			(svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);
 
 	/* Done at vmrun: asid.  */
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d3b69eb3242b..4a0d97e70dc2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5294,6 +5294,9 @@ static __init void svm_set_cpu_caps(void)
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (boot_cpu_has(X86_FEATURE_GMET))
+			kvm_cpu_cap_set(X86_FEATURE_GMET);
+
 		if (vgif)
 			kvm_cpu_cap_set(X86_FEATURE_VGIF);
 
-- 
2.52.0

