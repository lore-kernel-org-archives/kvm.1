Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5C48C414
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629720; cv=none; b=qU5jVU9pvMQWtcwVZlwr2K9QuorXsGF98WcFYnyS9qn1lV7zzEjuHTo63AgsOhIZ2AIK2xpjSueWohmep3pqbbaZM8f34OprrPonXVA0JmueRWKbGhiRxXosnPyfi+zrtEL1jF7hVru7GVJ80qnYkuoU45nKJh83kn7lEcl2vbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629720; c=relaxed/simple;
	bh=v7YppRBZlGAJpIdIQV5FNYXC7rtuz72lO24ydw3Loag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7xDkvFYwzEN/vX+MMlxOwZkQDCtnfE5DRh4OWTpa/Fta/ePpIl7YkODfaqdKJTTyQBRnEU4urmrWhODfOR5Qd49UWp1hWiedSPw8dHyWdl3BqAEkrAMklkOtJGNwUs3xFe4aWZyHrq8DoHF/BnRCsHxx3Tiqpk6Iaw2JsQByr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMLxmIpa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrSbwPZp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMLxmIpa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrSbwPZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784629717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lnu/ToNg0B6VIRET8BeNBNFoOV6QZeNGEUV3LW0xL8Y=;
	b=gMLxmIpac/v8P/cW4vikGOoRnxnQXxrH9zxQhVgLbeL9KDUci3m/+BDqemAF4uaQf7qRRo
	yU6vRZuqiVFMTPLMbuv87Z8keXZWF+I3u44CqLiDd4oSyDKle70/oAW00z/lyheWivTcKm
	HD0fHOP/4/Po6srk8mnnps+9M3pVBbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-3LXagUVWMfiZSHVM4Sj2Gg-1; Tue, 21 Jul 2026 06:28:36 -0400
X-MC-Unique: 3LXagUVWMfiZSHVM4Sj2Gg-1
X-Mimecast-MFC-AGG-ID: 3LXagUVWMfiZSHVM4Sj2Gg_1784629715
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso10329703f8f.3
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784629715; x=1785234515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lnu/ToNg0B6VIRET8BeNBNFoOV6QZeNGEUV3LW0xL8Y=;
        b=QrSbwPZp/Bmg0NTGC48G+NoIRAYC7ZTlmZZr0QQvdEjJHyOXmmieZMDB8laLc79HTv
         eOFkPBSXl90+vPVixW4rDJA0hbJmp5/eUkZFlyJwkOegVWEj/XQNuu6mIfU62yL+5f5M
         ka/b9b/gBOABVP/9e8eeK6EjqhS1dVRZ2DcOs2FZhSQm9ETeMhlfeQj6G2SvngH9gMtf
         46AJCDx+5FbzORBDOJiGiRIf4bVazgU5/PFU3Kc7qQWupT7FeFrmHvy9jfNl3Bpsppu1
         zcnb+PVrJ8jCMs68YBsJzV/gW2VKhj3BAV5EpmLVSFPb6DjTlpmHOVXH8JlcZ4AEwCPP
         H42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629715; x=1785234515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lnu/ToNg0B6VIRET8BeNBNFoOV6QZeNGEUV3LW0xL8Y=;
        b=HVGH8xVCiZW0FWofU+4HmyHo0MPcrTUOE6MecrYfZiQVdHf6VvgmAODLViVxClLGXE
         8S6Lq4j31lEMlXUnYxyQCXbuskMmysMDj6zwQJ+YfKGuvSl63QwSNW5VsYHyBG5Yal4r
         5WW+70bBSDIrCWEWNuZDWNFqWSzsHZ9Ww4eH+iaISRJNFBrXpHTQ5cxgjZFMwkFDGQUB
         /enupe9J6T0hc/fZ1/CAlIbw/WyutVIpqAKuab7K4KBAK3rgGVNACVw2IPgRL6aIZIDV
         YzKG7RsGWUHg8+A84g79OGYcUeiX1N4xj+7cAgIAQkSiYj0KBVLE1u0dnMHOoVsw171a
         UV2Q==
X-Forwarded-Encrypted: i=1; AHgh+RroGdESPBFBO8isYypknHhLW7pVJDakkROEj4qyxIzWj4i5FVyIBdxg3E2L3sAL3FGD8xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqwCBG963903dMMQv2xLHPqzjM+VqS7mOGUrS4nDu1JfGk1K3
	OY8ErkJX5WmwIJSrjYfiUTrOKc/Pc7v0vA4iYR/a89mjnmu8UCIgzuKh0IhW16wJ/OmGNwPtDdf
	WkaPMVNT7lIwOWhUwJ1NuMIzCPBDUyxomSrAllzfaQMvY+Mn9E6Lvcw==
X-Gm-Gg: AR+sD136MoolXBKpr+qYW1JfWv9bLyRintJy7Na50cVNIRwXB8iOcht3VkzgDaPJ00R
	UuzFbJyRTlzbLWwFN24H6odCw0CYwGm2kA135dPsZhBEqvFu+49PAk5Eqy+iqXksGBtbBalWbjU
	NXrPES6Bkv9DkfwuD3rzTlom8B8t/uywRZPYw50xOi8auX6A2DqSiepPieAy9ZcIy7HJsTimRtG
	9I6kM/HFgUEYtlRhmrsDvm8rAWtcvOEyx/7tbEKp8DLERIYS9zLQfLdYGiWNEcKqeVmYm4cd4G0
	Nli2GD2ag1traspGTuCrBw7MpETz6S4wfut/kH3p+182DTRguAv6ZLYFbSwfm2qj0Ta4Mux1rMm
	3V76YuPVRazpT7HGJzoYKYGJ2S5K1LCpwqQ22oF8apQsZ8XxEFgXurYJDYdO5Mv4jy+OfVTp5Nk
	D+zFC+
X-Received: by 2002:a05:6000:40c5:b0:47d:ebab:7bb2 with SMTP id ffacd0b85a97d-47f6232580emr21253566f8f.31.1784629715219;
        Tue, 21 Jul 2026 03:28:35 -0700 (PDT)
X-Received: by 2002:a05:6000:40c5:b0:47d:ebab:7bb2 with SMTP id ffacd0b85a97d-47f6232580emr21253527f8f.31.1784629714816;
        Tue, 21 Jul 2026 03:28:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm40549446f8f.22.2026.07.21.03.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:28:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH] KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
Date: Tue, 21 Jul 2026 12:28:33 +0200
Message-ID: <20260721102833.313246-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunwoo Kim <imv4bel@gmail.com>

kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
is non-zero from top-level reclaim, because such a page cannot be
freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
nested TDP child has no such check. As a result, a shadow page can
be zapped even if the page itself can't be freed; as the comment in
kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
to rebuild the page.

As in top-level reclaim, do not recursively prepare zapping of a
nested TDP child whose root_count is non-zero.

Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 41f92ed1ca37..7e80abba7313 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2642,6 +2642,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 */
 			if (tdp_enabled && invalid_list &&
 			    child->role.guest_mode &&
+			    !child->root_count &&
 			    !atomic_long_read(&child->parent_ptes.val))
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
-- 
2.55.0

