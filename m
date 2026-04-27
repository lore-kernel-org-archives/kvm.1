Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF6125AA
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319078; cv=none; b=GACD5ay8P4gk5MA+ThxWjjrcUT4FU9mQRfSuX+KfVgaYM3YAEnWPB35pCpTuHJVUURxy/Q6Y5pPSYjq/H8alWTodz0l3BgK5TgA0Dlr5duVZZab4mfMaqOSq5a59l4PobPC0a1r6l+cHdMnId8xR5whXpb0isDqfaFBKFaoSjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319078; c=relaxed/simple;
	bh=HEXbom8w6BaN+wnuMFqRD/qko2iqRyMwfut0S8bMS2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqEhiAjtvKdmraFzHCfF2iqMo81pxS5uF8TRJCOANhxSqzSmU3Q4cF4ufZ9+fsIxe8vmzo7jY4OJkU3au9grdnaHC1ATssLQNWQeTuWfuef+BJ9PPNKK0rUbse1Rh5y3VHepP9xI9q0v/Hm9nxG8FP1fK10f+FwdZQWI/RIUZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvuswENn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvuswENn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMnEmi3v8/QqeA6DDuFhvLERp1GfLcHeEYC6X5UXDMs=;
	b=bvuswENnzRnZuS6gqJs5Ddfzi9XcLOPEaLC32Di+34aTlCxOO8yK682qOYYdEEVDtYbaNs
	wmysGM+tuRTNIyKQsupNZ+B+TlBJ6/OEXM2yZp7QMOP1lK2TZoxJOsgBbubmanmQOn61gP
	sZEQEJN5+ZxyuWGYXb/MWpw64sIE/e0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-9-KmE8VJMyim9euSymLtBw-1; Mon,
 27 Apr 2026 15:44:32 -0400
X-MC-Unique: 9-KmE8VJMyim9euSymLtBw-1
X-Mimecast-MFC-AGG-ID: 9-KmE8VJMyim9euSymLtBw_1777319071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6F6E1955E9A;
	Mon, 27 Apr 2026 19:44:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69E9F180047F;
	Mon, 27 Apr 2026 19:44:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:20 +0400
Subject: [PATCH 21/41] target/i386/kvm/tdx: free strings in
 tdx_guest_finalize
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-21-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HEXbom8w6BaN+wnuMFqRD/qko2iqRyMwfut0S8bMS2A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVvhksEAaDilerpCh7L2D/LJtSDHrTV/YOI
 JtQDppNNjKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5SblD/9F6GLRocqj6HK3EDhpWsm763/GmQ+d+FKaaP9TgBgpqpbtshl7JDgKzNKw3mYjol7asfD
 8irw2eHDICvJiaSjPwofwI6H/qs5EadLeuc6mtU3CopHJbmgwSZXEVwohbCHTVb5nx0NmpVko81
 yOKK/hpHOX5fNL0vaiC/yJrMSftf5pb3iCUy+8bXCTfuyqF0mQp0btrlCC9Ium4sW7ZY49+Ab6t
 uFJd/eTkw1y5hqbxnFu+z8OqxuQVw8O/8nlK8q4/BjOASkcwkbyJiNKova7lqnjI5HnMZvUdtzj
 viBdWlip/6NSp6Hs60SQNP7Jfh9hxI6ITSJI2f558WvPQFESrmFC9my7RJowzFumnfZHXd3agN5
 rq4wWl0yYSKs51CVMBa+evChZm7eNRadiAllxF/RTxToJfxzFKrugyf3aiI3vFzhxs8naTl/q24
 MaDg4HQjPAHKLrMdt50+d65t/88ECnJPYJIHPj+rPf/g8JMESz1CaC/5Ii9RbHA91kE3WvNHqH+
 q0JRiwncISmZYlblCWD9BOgR49eW/TQoDR689LrAU4wqjcXQQgCZx0XcoHRcS8QwGGlGRdRK4j8
 4AocIXyOH3+s6PmZA6Gu4diPHMzq6cocvxA9hvuVgPqzgtFIniCMszr+50t2GuMcSMuBDlnF1I1
 mpjlBDZu/NQYM1w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

tdx_guest_finalize was empty, so mrconfigid, mrowner, and
mrownerconfig set by property setters were never freed.

Fixes: d05a0858cf87 ("i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/kvm/tdx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..df46fce7693 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1585,6 +1585,11 @@ static void tdx_guest_init(Object *obj)
 
 static void tdx_guest_finalize(Object *obj)
 {
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrconfigid);
+    g_free(tdx->mrowner);
+    g_free(tdx->mrownerconfig);
 }
 
 static ResettableState *tdx_reset_state(Object *obj)

-- 
2.53.0

