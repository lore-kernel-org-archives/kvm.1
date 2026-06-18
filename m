Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB053282F23;
	Thu, 18 Jun 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772850; cv=none; b=QIcslrA19oWvZKqx3cCRpV3NaIK/Tzs1ZXwZD4l4wxYdebEtcJcGGX5xDBXyJAp3NYdFmKK46kboscipGdQ5AMrLJ0Qa4Ajrj3JgpSVeit8h3ymeVT4aQzm/wP67uHaxZoWNcjRAzypaMBpSjQCQ9OE5qi7Xw147TGlaOxtcqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772850; c=relaxed/simple;
	bh=rk0aIF5Ron7w+owSukZR6/W7oQFcN+1/l5yfD810usw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q0iYevX0LRBlFiL1wlAUKSJ14cJv6UcROY7zOpUqjK7xCMTajyvmLJqZ6rz+XwX3xtT+t9lb+a0kpjTQfZafYMN/KB3HYV5ioJxY+GDYc2285GZgpDIsLTPqZWvTtlZEQnAY2uBSvmrm0DLwir+BYmpEwOT23LDLr16byCRTAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FEZrH0HS; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FEZrH0HS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781772770;
	bh=PzhLwK6RuWPnC87JsKHc1sC616VALBbLjuNP0gZ24uY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FEZrH0HStY1KmVL+zSnuOovN1h6QMsSt/QuJl0XizptZ6uXIJExjqydK7vmZ2hiSq
	 NQZVq4Rlt8AkScQwcGeirnGXWka2aUxzbaXTdkirXOl/4Q2hrJUb+lYYgM1lGiI9rr
	 jL/aRigxuVvDzwID17CLQr0eWpvdA0DFn+K9ABHQ=
X-QQ-mid: esmtpgz11t1781772750tf676236f
X-QQ-Originating-IP: Pn0fbzxLZR/48puj++EDd0aIiqvx8jhCUCWa3kgyfM4=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 16:52:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4558432873951225769
EX-QQ-RecipientCnt: 10
From: Qiang Ma <maqianga@uniontech.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] KVM: SVM: Remove redundant ret = 0 in svm_set_nested_state
Date: Thu, 18 Jun 2026 16:52:17 +0800
Message-Id: <20260618085217.3934985-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nui917t5cXLH/p6JLAuQjfmPFkhNT5p0P/+pfL+1p+wGvz+ucNZ2YrCl
	3aUs2m4slZSf2HUXX/e9nljgu7XHaNdCwpK4hLEg+lic2DnbiLmbxkIXK7n+TcHH3Dvps5A
	XMVXx/6BQCzHt68rP3l8kB3RFTvk6ILYvp+sMASL/+rvVrplUIXIABT9dtrRH+jJbsdv/nX
	kVxM0zDRVl4hK2gxoAVGvHUlKuD4sxiWmCfezVC6Qn1ydTPUXWZrcADGxrr/Mr5DqhHhMtp
	ioHYFoWKfFXhYWeUnsfOn8zPiIIDYqKZeFcm/75+SbA9Xb9mamje4+LA2lc/4E7EShikJV1
	yhx0DX0DK7UW63StbAP3kngTlegHdE2pTfGhAyIRc4G/pMfA2rsU2NxAEZFYHy4POoZzjsG
	fdOGvSPfeznKjNqwg1JG198QUGmIi67ABdkNpb8BjJYyDlZz1eg6ADuH+Y1VdksObogA6ek
	BByBPs9ziydzXWqCMc8Hwc6AjPRzDw6JWq4R7MbcVOnOsPYwDXqzL3yMuBKL1TRPI95+6LG
	INa1kEonCSpZB5NyKvipjCZFYpikrRl0z7vHTSNu8wVuf/4Rohy5O7RvxrfaGDVRHE6IdE5
	HHU0uYShjkbmaO5D+r+7HRFHSzc1LAfAWebAS2Cd0KbXjbmgNGUC7w/K/zmIxvD9S530YZk
	fsGrTl5E/vtC95rRf5maVNSKRwiUxsnsvWSEsa5tgRMfRMFZXRut/U+8h6+vNPTtJPBMcso
	3wbfHiLrwMNsJyTbqvVu/C4kq6h4BnR11kXulnJi6/+EhO86/uvF2B0fSZ+JxR3pNfKovmC
	JEhlBngTv+bJiJ0T9DI/3K+xef7eUJkelk8AKL8qiGbyrLu1Y3OxYN54gX4EYIfQsX7nspu
	ImUe15V96kRH6ddhSQ8OqG8LdV3VQpRnU6m8soQuTDaN0gl4QnXr0K5I4yeee2Il539IPLD
	V2UTyWT4yCPFXrcDFa0iBib6/omhSv5lKg8GtHwlpCKsoOddkG/+1H5UAAsXf0CGH3dUXdj
	EofM8ej8UT4PyPKQmPqnCaD1XgTfoMa5DDiyLiWw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

In svm_set_nested_state(), the success path reaches out_free with
ret already set to 0 from nested_svm_load_cr3(). The explicit
'ret = 0' assignment before out_free is therefore redundant.
Remove it.

No functional change.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/x86/kvm/svm/nested.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b340dc9991adb..b95e7283bc888 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2019,7 +2019,6 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 
 	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
-	ret = 0;
 out_free:
 	kfree(save);
 	kfree(ctl);
-- 
2.20.1

