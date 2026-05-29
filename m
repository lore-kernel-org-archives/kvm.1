Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470146AF12
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079818; cv=none; b=qelR5OstJWFzathcKlfJBfvC7ytw0ijHDvV1VbtvOgEJQFibkX3sIAaZAF6SFGPkpTHKKlzYufCb6VHVewJDeCMtaI/JjxfSYKq/93vEZMqGF0Q3wiaYnmz2c3QXwS81yOsMPnzADkoPO5ykngHZqBvtHpg3gNUqPeF0bqLUXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079818; c=relaxed/simple;
	bh=cLlmujmrIgemvQsPSTY1GTNh15IlTa3nEz3RTFfzlBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bviZL5pov5y0PvkSjDVk+tc9hF3+mi2LBurbDKx1/1Q2oNStGSkAkZuarMpZL1hCpxk5DjurPQt/h8nEbvwZ7lV/fiOdkj5dPH9mbkBhAOKzBbyksKRANSDbzVnwARA+pz0oWqG7C0/K6V8TFy5ES5qbe3QIV0bC8QusEfrWBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gc325PU6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkJwmpoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc325PU6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkJwmpoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP7hMfcyuwDfmzm6MvxteCiSc9hEWi4a0ARiKg8JNrs=;
	b=Gc325PU6yKtIlIepJvzlx6k1aKwIhwJLfg/XB2okXQfQqvxmJ6s8o32TXWVnbmAGOEhbq5
	mpxui+bviGiRma71KfxHhoiNsvN95emgp0j9IwzYF0bD4rqrvIPmiuAUeDNQDwb6Ky5mkz
	xaD3JVVo5d8wNnaBnlK93QWd66CCqfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-orCx8FVnONGUBCEV9sADFw-1; Fri, 29 May 2026 14:36:52 -0400
X-MC-Unique: orCx8FVnONGUBCEV9sADFw-1
X-Mimecast-MFC-AGG-ID: orCx8FVnONGUBCEV9sADFw_1780079811
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49058295985so43199975e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079811; x=1780684611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP7hMfcyuwDfmzm6MvxteCiSc9hEWi4a0ARiKg8JNrs=;
        b=AkJwmpoOPc357MHSF49AtL95SF0S0jLsrcFBHnyP/WmNW6INEvKQ78PlIu6NdCDq6l
         U1ClyiJZuY8Dhzy9T95VyfceWwPwqusUZPvSwNQUjAYHwgdcxFGGkxqxdK/13mSyy7Lv
         e7kkIiosnlzDDuCELvODCsOZvPP/c4GwKtJbFywpWbHUGabwnta6VXhAsqBIfiMZvSDk
         yPFzv8Pmg6SaDK70+tLXDKxzwcLw4H8n7cB0hl7vS+09pWPKoI+6HsUeiLe6e6ki+A1p
         l1BufiTKoCnmZHvdcsLJtMPqTWvEfn3JTeIQwC2+8eNpouULAg3z4V/u4O5KgbXhBAX0
         pWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079811; x=1780684611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aP7hMfcyuwDfmzm6MvxteCiSc9hEWi4a0ARiKg8JNrs=;
        b=CwtX8MdY7fpSw0SE+HfStoKog3105GT9ioEbS+sVCQtmpRPRavQ5N3xU9IjRYSo9i+
         OHOW63BzARx5bpNILF5wIGEvUYsd6DM+k0PCKX/ho4ViWJFUyqtl8yXhnRt4a0XvxugW
         sZCbRD/WXfG/BwxqP4cP0lRfgUTHCvefnEW7iY8lzg06FzE+4ar63rInFsg1YdJuUQjy
         y4Nt0IEHmuhLgfOWBnFBZYNfvhTUXgl/L7rjqhlZn88q+cHEX+aMJBE8wcpEKeT6TNFf
         52VldqlMglM+OXAtNOjKEo8xezj/CxRDhgK/0L5l/oUQGjFunH7gBezTAAlK4dZiDbkL
         aoWg==
X-Forwarded-Encrypted: i=1; AFNElJ/V0OMlOO9UrMhSRPqEMCucHQY0P06H589VVdBcyv+GKKbKJCBFMmsMSJegZykQawD1jes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPKT8Uko9bMVAi9dzHZnSe2XgXvsxY1wzCYVr22nhfv9WDw18
	yvA9lyxSGrNm5WuAEoDuMdSdeOfcmJU0uD2kOxpZ6XDiM9ParlnBlZDdeXmSnPQXUAujE8kNTwV
	QRJo3pPvOStwWFi47Fy4MHxohQtUvh6hHvTXM2DEYKuNQszqvtRVWpg==
X-Gm-Gg: Acq92OGnQEEWwdiGhcS3TCSAaqxC2snwC0gXWtwxz6jUPCV/TzlBibScugavZhpiveB
	hXYHxxf0P4O0bQRubglu7HmYkn547yJt2TG7SI1luuVk36vX2lGLaL3LPPCSiji+THfjhxt97g6
	hIW/GLWnpjNoI6w+lxer8LJhjlS48RijYhGBktGh8M/rkedDLadVHDZQRduNrwh7fFbRLljXUuh
	Efu0pKrNw/ziVXwaSEBxXvH4sVDvGh95CrAVhcyztU1lcrJ/t6cka8Eo8qUqV414IHfwaPzgVHJ
	0qP1Bb6viGioqpxNwe+K/iq+xSHoz3BuDQzMW9vYEP/jsZumrXZsDalx3t016uxRUO59V/tzt8C
	zWkAtdHGYELnjojbNUUoU8fz0AJurR8vi/+/lzvwlvBkhO4xnQe5weJr0Z0nD5zpwcn7hMsdb8+
	4qFsYSxy55Z8XVaWuMNlyV57rqjZIJsk8tuHYNdg==
X-Received: by 2002:a05:600c:a00c:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-490a2904aa4mr15849755e9.2.1780079811041;
        Fri, 29 May 2026 11:36:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a00c:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-490a2904aa4mr15849275e9.2.1780079810665;
        Fri, 29 May 2026 11:36:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f3027sm51965255e9.14.2026.05.29.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 21/24] KVM: SEV: Return INVALID_INPUT, not MISSING_INPUT, for bad GUEST_REQUEST input(s)
Date: Fri, 29 May 2026 20:35:46 +0200
Message-ID: <20260529183549.1104619-22-pbonzini@redhat.com>
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

Return INVALID_INPUT, not MISSING_INPUT, if the guest provides an unaligned
address for a GUEST_REQUEST, and/or attempts to use the same page for the
source and destination.  The inputs are obviously invalid, not missing.

Opportunistically move the checks out of sev_es_validate_vmgexit(), to
continue the march towards reducing the scope of the helper, and to help
guide future changes into correctly handling bad input.

Fixes: 88caf544c930 ("KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event")
Fixes: 74458e4859d8 ("KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST NAE event")
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-22-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b59adddfdbcc..84421d9a116b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3508,10 +3508,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		break;
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
-		if (!PAGE_ALIGNED(control->exit_info_1) ||
-		    !PAGE_ALIGNED(control->exit_info_2) ||
-		    control->exit_info_1 == control->exit_info_2)
-			goto vmgexit_err;
 		break;
 	default:
 		reason = GHCB_ERR_INVALID_EVENT;
@@ -4631,10 +4627,20 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		ret = 1;
 		break;
 	case SVM_VMGEXIT_GUEST_REQUEST:
-		ret = snp_handle_guest_req(svm, control->exit_info_1, control->exit_info_2);
-		break;
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
-		ret = snp_handle_ext_guest_req(svm, control->exit_info_1, control->exit_info_2);
+		if (!PAGE_ALIGNED(control->exit_info_1) ||
+		    !PAGE_ALIGNED(control->exit_info_2) ||
+		    control->exit_info_1 == control->exit_info_2) {
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
+		if (control->exit_code == SVM_VMGEXIT_GUEST_REQUEST)
+			ret = snp_handle_guest_req(svm, control->exit_info_1,
+						   control->exit_info_2);
+		else
+			ret = snp_handle_ext_guest_req(svm, control->exit_info_1,
+						       control->exit_info_2);
 		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
-- 
2.54.0

