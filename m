Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37983426D11
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079769; cv=none; b=PtDd91rUnnS9STYlECPUSInlBjR6bdaNfI/+OTbtXRKaoEYBl7saXuoUz8MTeSJ8izBJjh8N1vVeWXdbYZUHSfF+8XywPbFng3PGWH+qQnByFoRKk8VfjYJWPX261BMH9xQyyBQMq7ucUHBbnjqnb89E6pBYEDdyl5pMFcEL7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079769; c=relaxed/simple;
	bh=f+nkgUwG6A0jJd/pAJCpY6wq36Ry3jzJBqYji69OyE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkN3n1x/tI7ekOGUxiRiTkS3p9roM+HRiBHax4mcJ0YX++stSapOr7gmbzvlimFqNv80RcpM2buP3aWuM1jfXHqoiqfkx60lQ2ktLgPfgl8SvIV16hFH2E6o8M6RQiU9FgZslna6ODfZXmHr58kvd11WWuvVbZicm2BPMPVVjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQeX6A5H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t9V0BPG8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQeX6A5H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t9V0BPG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XndtQXgYoKhYp0VgWVa9fVm5ME+RcvJYRIMg+5FuNQc=;
	b=HQeX6A5HZ8vdEtVvhAmI5JwDzz1Eou9QglL4ugObkrTYRKVVBgrk2qawUXKW5N+XkKekio
	9pFGPNh28KzNa8Saiq4UUu7C9oaXvWnKNNtBA1CfQjgSwEfg2hbtIEVQ/wfZwz5h0G6H55
	bEqY3WTmYZKBoFuAHkd+rG6q/tiZIu0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-0NaeOZGqP0eGi7dbsg_VRA-1; Fri, 29 May 2026 14:36:03 -0400
X-MC-Unique: 0NaeOZGqP0eGi7dbsg_VRA-1
X-Mimecast-MFC-AGG-ID: 0NaeOZGqP0eGi7dbsg_VRA_1780079762
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4905428aad6so56258315e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079762; x=1780684562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XndtQXgYoKhYp0VgWVa9fVm5ME+RcvJYRIMg+5FuNQc=;
        b=t9V0BPG8z0yZJ0ofqSQ5ekHVrS4blBDJPDjq1ihIhDlxc9OyT/1UZoUctnB9g4xsT6
         JsnySDSL1lRIhzQyPGDx9D0ZCPe0eb6FTr05Dt41WoUd+MXx2PRpDYOqf+QLbvIrTynA
         JmBnYA9Jz+C6+4j5/kooQt5c9gIzISiMHttZZNIqHU/9ZCZ0hdzwTkHfwSKj+dgL2x7s
         xlj9TKDWUKSNk1/6Jrhi9hSwCCmvcET4XjwvD5W3FWKfw6LDw0oJlwZB1uKFH6vVTWAY
         SfEUYd5BAbxuQlO12YKKmy8lIITU0MRmhsfhDyK5fq1WDOEZa0Vk14c9ot9GSOLFmASv
         rIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079762; x=1780684562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XndtQXgYoKhYp0VgWVa9fVm5ME+RcvJYRIMg+5FuNQc=;
        b=EcinGDz6GUQtdsKB3q1En9xcnC8QD2av3hDHTs6FW8LDwsCgt0xZ0jeyn1mJWj4vzi
         462yV66JgbDt/loO2zECuDwgV27ObOKr1u7dfgRvTyP1Sx9B7O6FUVm5vjNLOrS+Wqls
         DpmyVN0mbK5w0vzz+3i+boKpxNguAVihUH735s3SUh2l3j4l2Vyr1ZF9GZpl78rWwhSv
         wMe61abG2jXmEsDC4IDfUsFB014h1TzLteKEPDevSSOrEcBS2/AgoJ6Bg2LzWC4fEiYF
         lzeDiwUZfcLxuCSFUXLcs8zx+jAMGtmNQo/KXOzLgHT+lz3Ez+1mWoieguFcN9PKNDaL
         UcvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BduLZMjWtg4YGfC3j9yF5a/t8yu1PIJwirX50regbvG7zxouB6s1vpS2Wmg0IH1o7Ub4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBIiQNQKiKHM99kvBB1iUOTNfp5wwD9pFTozijgJD+WCUEowX
	/8EE/MVuqHVYfXtRREli3FIaVS/N9FhdZYHk6SFB0SVawwZY96K4AHfdnUd5Ir/QjKWse+mxSsX
	9TvXo3UlrsQxWnMWcE9Lw6yCuHpxPAkk3WPXhOgECdsYwXK33u80sMC5NJCdO8A==
X-Gm-Gg: Acq92OG17smtx7HYQPHyQeBnVeu+KIM0mrRuBqMximz1LKtp5kkEy6wMfrJthVXCQj1
	1vsJ16aZuEI/9GJ4/2yA8aniDm2IQf3wzS585ZwF1Ge27T0dMbZ36NZvRD432IOv5xBaElKkLiq
	vE1XyLLScPZdws/SkNs5O/cnfGfwYTapJn/VbXA58UbUsomnpFUKIwsYRKp5QOwQ5e5SZC9yEnW
	qINamBjW/IA/n6OWzOOtXJu+iddbv8xPHr93s80fdPy1iefa7XqXJAAs3fELBAe1dyjSJBBeQWO
	Y3nRm2TJNCSgicsD1XyZertJTStPz1NLvdj1smk6yi46E+IXjWVusMnFkXZTbBRyiFBodUKxGHG
	pRrIorVn4PYM9wNFe2swYHro30FQeQYLreD0/wouGB6YUV9+DJFvp7abVEb1v2iU0pvozG0hGII
	F/nTEMnbYP+mBC88mdX1j4Lnc+jW1vQf0rshYJug==
X-Received: by 2002:a05:600c:a305:b0:490:7227:100 with SMTP id 5b1f17b1804b1-490a2933b22mr9949065e9.18.1780079761525;
        Fri, 29 May 2026 11:36:01 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:490:7227:100 with SMTP id 5b1f17b1804b1-490a2933b22mr9948755e9.18.1780079761169;
        Fri, 29 May 2026 11:36:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm73788825e9.7.2026.05.29.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/24] KVM: SEV: Ignore Port I/O requests of length '0'
Date: Fri, 29 May 2026 20:35:29 +0200
Message-ID: <20260529183549.1104619-5-pbonzini@redhat.com>
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

Explicitly ignore Port I/O requests of length '0' (or count '0'), so that
setting up the software scratch area (and other code) doesn't have to
worry about underflowing the length, and to allow for WARNing on trying
to configure the scratch area with len==0.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e6579ca9f364..52703c954856 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4585,6 +4585,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
 	default:
 		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
 	}
@@ -4605,6 +4610,9 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
 	if (unlikely(check_mul_overflow(count, size, &bytes)))
 		return -EINVAL;
 
+	if (!bytes)
+		return 1;
+
 	r = setup_vmgexit_scratch(svm, in, bytes);
 	if (r)
 		return r;
-- 
2.54.0

