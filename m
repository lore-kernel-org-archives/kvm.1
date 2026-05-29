Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F942428464
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079780; cv=none; b=IHdMNJFQ3UwJ7c4SKg8BQq1B7pwPNoOYX1gYuhFqdKs+l63YAKpsIdK0sGqqTDKIovVXGJAqKuTdbx2SB9sJqBaRGdBYCtjtCV9mxb356Yb/0XfHb3ogele8mrStsQgKCHpJU4MaOZi35LwLUPs4Xlgsg/Oty1rI+5ttk0XqYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079780; c=relaxed/simple;
	bh=JLl8YjbHuCGzOk/HWi0SHb1/V1UT/hbE1I30zoZy6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QspBqCohL9cNZWV1a2qNZWtyNx1dTCjk3O7GkAj0WSYW8zBFsMDHzVSA/EP4O/H34oBJR3cIF0plqwVD4vrWeDzofGJllgv2sL2CEYKxEKjfPS1PC6URYSEzaq34mU42ERod653yzKPp/757Ke7i8uUM/CTVyt5rAEenZE7vIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbUhqruY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1JckBS2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbUhqruY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1JckBS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyh3yBei2dvCuDBWuVl4/7h8CqM5bAYkcfDKwxMNYFY=;
	b=NbUhqruYtpGvrNetuNQXdHfkL/pn4db9SPWe2Nix+Amgg4P56494TfaYkZyoXNR+Q0ZQw3
	REBbXSpAD7lZQh+7rb3GfnSwNWttxfuNojyHNGMBAY2AEXz7EFBhwp+wF2b8ofwOxpeyhC
	HhX21cDLLlJps6e2DuShzLKj2SFm3wE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-9oAcKWV_M82X0NOAd__hCg-1; Fri, 29 May 2026 14:36:04 -0400
X-MC-Unique: 9oAcKWV_M82X0NOAd__hCg-1
X-Mimecast-MFC-AGG-ID: 9oAcKWV_M82X0NOAd__hCg_1780079763
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fe44ce385so106619385e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079763; x=1780684563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyh3yBei2dvCuDBWuVl4/7h8CqM5bAYkcfDKwxMNYFY=;
        b=D1JckBS2XzRV+n15PHnq310NJ2gag4jWWhD9JkmsOOjMLSSt63lHDytzyBCH93LBCY
         ol8oeq5CsraepLtFoKUV8fFGSSzkaleJUDCQJ+7jiLDE7+7KTyOmLSn9yrEC8n1dzK6+
         G8yYC1YeemsL4RqkQdSfzsNarpFJUC8cTNM8tO6rKj8Qxkd1jXy+8wtadnIbCqq8K/SU
         MqdBDg5oYdMAhFKgzPsEYSEVY30O4SDyB26vNQba4N+MAUDBZKLHslkA2L1mMVGINgbK
         sjyPYVfWaUefePg30OeKADeJEut15bpu1to7dk0YHcZ40UNNvYLb0498/VCWtTUEz1tu
         FLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079763; x=1780684563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyh3yBei2dvCuDBWuVl4/7h8CqM5bAYkcfDKwxMNYFY=;
        b=QHP+IF/ufcBa3np9JZkQ8skHv1NG5kVILbFcx9N0kC+Twxnu7LvE5dwIFCP+rwwQ6D
         w1PRGw8acAagYWHS3AcHTVnxuKSMuQ2E+NbHTfqJtKZ3GLSatlgaWq4lT7zdmFNoJhOQ
         aMqAFB0vjz7YChqmBj3RWG/GLgg8jKV6y+xU4+iSFBOhYhglaHJ5zjKk9UzuscnXiQds
         Jy2U4BWRFZFwp/Ssyj4FbPzPnKdmsH6q3oMTCNrPz+hWujkGUuCcJXPCuQ69Hz6U2Jad
         2M2gkm+Sv1l6u9Vh5PlYMrrx/hKa1kGduW0dsYTr6m9trWWlhWF52Kvwrsn8hjPUJrZB
         NyoA==
X-Forwarded-Encrypted: i=1; AFNElJ/0NtP9rD8rl7CBKCwcUpWZBB6kk8vZ7pJui22qhg6d1O0GMjhuxEbSvF4fhovdEyWbVUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqLl82T2WXlYPBpzxUp2wHbxUIyRZRQHPFOI3Xkmn0JIAO20Y
	dP2Cjg36p5aJHzdQjPNEs9zOpbChshNLoG5biRZSw0ZG9DeHRpmXZfLykWdYw01WVWWXBq8UOAG
	jd9+P+TrMxj/ymDyPArZIS8GOE4y6SB+5j8eaHsf/5AtncO4IyM/mZA==
X-Gm-Gg: Acq92OFSokgGXU1mpDLZ+mxkV9jmztJD6FZ/cdhgkxLoazN5QNFTlKyyFcxcf0J/s3n
	NkP60laNypz6rHleCA/7AUkl7i+ddd4AcyurMAIXpeBTsHTqcdbcil+r4dKsk1epZpHKeO9Ae2U
	UGGefgicW0eq0eOMIsqEsVRoKY0Ra9mVTcIjR6VK9u3o57vZ2Uq9DQaA/51m+uT0beZhhj4sZCe
	wcqqlYNl+bZMnPDIGQgt5Ahf+7S4tRi66YgyGQ43jU6McPjXByxUMpUFG8GUlsvTQzMGM7yQv+P
	yn2Bj0eWAPXaGH3TNFxQKBj+egM3nTTqO9+8gLSi8QZRuSNvtvvqTxSrUQRqtyAZ8NuOfMiWp6k
	71VhHKhh0w7bupWGQBj/wOdIaKN3JVRTlVyg4Crg5SwlSDC8oxq5GkIm2SDM39VyyAg9Jstr1Je
	l0diCautgUzk/2QR9tWuOan4WJhqxvi5/pbJ8AoA==
X-Received: by 2002:a05:600c:314e:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490a2968857mr11860015e9.32.1780079763477;
        Fri, 29 May 2026 11:36:03 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490a2968857mr11859665e9.32.1780079763049;
        Fri, 29 May 2026 11:36:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm49675745e9.13.2026.05.29.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/24] KVM: SEV: Use the size of the PSC header as the minimum size for PSC requests
Date: Fri, 29 May 2026 20:35:30 +0200
Message-ID: <20260529183549.1104619-6-pbonzini@redhat.com>
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

When handling a Page State Change (PSC) #VMGEXIT use the size of the PSC
header as the minimum size for the scratch area.  Per the GHCB spec, PSC
requests do NOT provide the length, i.e. using control->exit_info_2 for the
length is completely made up behavior.  The existing code "works", e.g.
even though Linux-as-a-guest always passes '0', because KVM doesn't do
anything with the length when the request is in the GHCB's shared buffer.

Use the header as the min length.  Once the header is retrieved, KVM can
use the specified indices to compute the full size of the request.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 52703c954856..cbb3040e0778 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4559,7 +4559,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		vcpu->run->system_event.data[0] = control->ghcb_gpa;
 		break;
 	case SVM_VMGEXIT_PSC:
-		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
+		ret = setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));
 		if (ret)
 			break;
 
-- 
2.54.0

