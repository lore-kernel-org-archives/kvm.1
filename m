Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB553D332E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010771; cv=none; b=W+6FSmFEajfTf4/z9RWES3k24fxlQ+00PtUGFd7E9w+qYBfzMLFXXHvJpbjl7kWrn+QIQNeaty0zC7uCszsQwHtBSULFeSix6MVVu2f3kdUwCr4lI9pUmha3Nb6c37IK6iV/e/BBay6UrYzD0FoOiiB+MDGOnXXF/0xub4DF4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010771; c=relaxed/simple;
	bh=VT7zfiiVRapsXV419bLXWnYe/GDkcopj88qVydXofgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ9gblGpJtvAB8EKxYcpJ3oY+xmH9NZNP0KiXFUdAvGLGLyk4M+X5pKOvIhXJ6GR8j+mQ/0qN7k7BkLpghpLi71o7EGg2GNguzwEArpeR/cSZ+rqeVNL/wBdfQeUkL1BAccTTVQBjr2sVi11WVtKxc6Hy32RuQXkMF9ZxSrMDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chUTYCF3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/cPSxuO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chUTYCF3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/cPSxuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmTlPbplzaPUyaXoZZq4ubiOPxj9lSeMSfGVlOAgc48=;
	b=chUTYCF3ZQYJctA8Mie/Ss0wXueyS73iefUe1tZfTVNRXcnwna7XUwgsHSm63g7Ixay0BX
	mtfoOH7euJt9AwbLaUqLwr8dL4RbSydtP2CfoNPhhbn1Tv6H2XiHSGvWIrSI5gwf4xVybP
	zn1/T8K3jdn8fsqpRSSre1jHcm15cwI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-8ByhKh4IOGWx4IaHv92WJg-1; Tue, 05 May 2026 15:52:42 -0400
X-MC-Unique: 8ByhKh4IOGWx4IaHv92WJg-1
X-Mimecast-MFC-AGG-ID: 8ByhKh4IOGWx4IaHv92WJg_1778010762
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e51dc35a3so1315955e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010761; x=1778615561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmTlPbplzaPUyaXoZZq4ubiOPxj9lSeMSfGVlOAgc48=;
        b=A/cPSxuOlMM3uVIS6HUMaiOuzAkkpSa0V8Iggonfl4FOgxOCXtdlE13dSzXu+su/OM
         JHyAFQrRHwgGA/+6utWLpxg0QncEG7zsCRLTlsZiaRCbzhu77T9eqMyyEnj6a/0/JNWb
         y6LTnVuEq4w4BDRUee6EuCbh78hTkHSaLG/GZ0Sr1D5KNq2/5eHvk4vzqNlV5TDtZ12u
         m+NSH1/oc8zS0XijnyB3M6hsbMdhLSQOwMhNxkAqU8bTDet7/yxT+bKdDbvh38Md+CTu
         gADBnCDtVNVn14CgOXVkom16EDuzDrmaFK3k6zEckTWjozDX0I65BAQKJoidpOYrEk12
         QZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010761; x=1778615561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmTlPbplzaPUyaXoZZq4ubiOPxj9lSeMSfGVlOAgc48=;
        b=ZZodi2EwEjscv9W7+CZ5v6dUUWDMWIgqnU/wX23A9hORN6qEsgZ1Ef000Y4WN2QIST
         +7qViPDi7PUVoyTFp9ZaHkgbQzykXeoHfx2RqMHTnrUnS/zDU5+9XC12sXz7pSWe8RRr
         +upTp5ZBbICvojwCYKENW/VA0S2dnmn5AxMPtqes5hHKmszz9PU6ftq67Ve6UJipF3M9
         w/8JUGgQLuUfGTth3t1r1C5xDnTCAfSmnaUG+wkD6ifyiYXxf0onylLq8dBUFAQp9Mxp
         pO7ws4uW/8uANTNlU9IXVGHI1PNHtdHfsZZjOBTMSuujIkwsUKDcqHMIg5v6EPSnURLe
         y6QA==
X-Forwarded-Encrypted: i=1; AFNElJ8sw2Eo6096rDWb+5FwpC6/l196s8s/vy5mrUuN1a1/a4wPNcbs+ArnEx+H47IEoFVGX3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQom+FaY5JBwYI/tFsphugCNWDk9xb/eCRV4KbSW6i8a20p/D
	aBDfamtVcmZwXBvN34V8qSmd7JU/0CZEr4hj6AW0l5kH6iTaLMdCcAa3fITGdB6cRj3YFpepBti
	cmzffwPcXnut6hB/5Sid5GA8X8TA+qS2WkYFOgA4W8AY6CkV7qqdE3Idv8zpL6g==
X-Gm-Gg: AeBDiesDIRGpIgb0f0JeCZdS99O/mS+40V1bkTNoCaPVCjTchFe2nvvyq8Th02R11Yf
	9VllUuROmJcnkYM55D1acBH6hJOaf3hDg765UZXuzXqkN2VGFUJ6V2zoYYlKJpcJNWvtw3it7Xj
	LiD9WBqZTJydaCUHARLnCQ15E+iZQXqIU73Mz0i0HYDqMc2JN/vv932qGRAqkShWv1u3tPrAjSd
	CmUr8OjYHu0fXp/Ig71mPbFZJ5Q3ONunAN3Lui//i2Tnkwk+wRNp6bdCKhqa3pK8wcKW1Q8esO2
	7WaYfV2VHPqyufxzfC7rS81Mz3hp2fr7q5/CdWiWERomgNFcECC0XdNF6uxxrBsowNBjsWAgpaS
	f7K7479wxx2pym2ZRY48g1BoWAfYqQoMHEcegif1iyR+ILxgz9oPtt/37VcToxyaq9Vn3Nc4Jwx
	AXnGJobHxi2ED19G2+3qRJddRI43xGXnXZSjlrK/c=
X-Received: by 2002:a05:600c:811a:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48e51f35d0emr11587335e9.20.1778010761209;
        Tue, 05 May 2026 12:52:41 -0700 (PDT)
X-Received: by 2002:a05:600c:811a:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48e51f35d0emr11586915e9.20.1778010760852;
        Tue, 05 May 2026 12:52:40 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6fffcsm398234745e9.4.2026.05.05.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 05/28] KVM: x86/mmu: remove SPTE_EPT_*
Date: Tue,  5 May 2026 21:52:03 +0200
Message-ID: <20260505195226.563317-6-pbonzini@redhat.com>
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

spte.h is already including vmx.h, use the constants it defines.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 317b9cd1537c..bc02a2e89a31 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -57,10 +57,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define ACC_USER_MASK    PT_USER_MASK
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
 
-/* The mask for the R/X bits in EPT PTEs */
-#define SPTE_EPT_READABLE_MASK			0x1ull
-#define SPTE_EPT_EXECUTABLE_MASK		0x4ull
-
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
 #define SPTE_INDEX(address, level)	__PT_INDEX(address, level, SPTE_LEVEL_BITS)
@@ -73,8 +69,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  * restored only when a write is attempted to the page.  This mask obviously
  * must not overlap the A/D type mask.
  */
-#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
-					  SPTE_EPT_EXECUTABLE_MASK)
+#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
+					  VMX_EPT_EXECUTABLE_MASK)
 #define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
-- 
2.54.0

