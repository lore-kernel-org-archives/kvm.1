Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641299;
	b=XVKNGfmnltvV1q62SLHfRKGwLVfisv7cerGyK++gL8O8DhN1kVe13BFLlcTpjEWCdGon
	 UiO+ZrBqCnYa1+MnKGNp/UxPHPq4u8AYeM5UumozDRSEIU6bee6oolr2djGDuSXIlsHC7
	 ZXEQWbHcKjkduXTHsHeBg/M9GTxBw5Qy2lnY275oe4qCgNPQ2uC3UvB6GyJ96PvMv8VqN
	 1krWJ/BJYPucS6B+a4KNZI3urP4FlsGTAhUxoXxp7yAevI/mwKnP5u5Z3f+fFLwguECI8
	 Kjn1ICYUlza4PA7YZN4xhcyIMpVjB5HTyNT9QGi0DbfK7itSsrU1hsDGqiDhGzeCTVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641299;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=yjlodj22paafrwb7WY52rop1lvjYQiJHjF2oPdN/UKI=;
	b=0Xahuxao+cUvc/wZAeehhw4oTGzh+Z/Y5J5UXDCU4baiVlBTiyuaKyeJU5jmNMqolO3w
	 XZhkMPHVlRk2Y4//NopKFkS57JsgpUTUjjq6tsDZVcWTN5C/3DaoB3Xhopz1Q0wMAgbS9
	 LgiL/qv4T8LkTWoaFFlUXI2bmo6iIIgqyUw+XjCincaLJJwHYc5fngyDhuQXt6P4AeMJ2
	 667ZJlpj6cMyTcWmB2suovWJdySUux2ABy2xMzVvadSwR80gPcG3b7dsSzZlA1M4NLAw+
	 tOJ2ql+R5morlM9K+xGhkLe6FpGVRM05cS3BXu8+0tcPq97D3PWxFPlVacIiAGN4YBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Id2E1/j+";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653960716CB
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3653960716CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Id2E1/j+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjlodj22paafrwb7WY52rop1lvjYQiJHjF2oPdN/UKI=;
	b=Id2E1/j+4KAn8Jecw0rciSlOD3dpmWDsVc5rRTwWW3t019t7opzthsDsAtHMgZJxfV9snN
	RntKWEQtkdrqLngmIeG/sUG2369Hlx6EcdYtfThQ0XX5pJ/wSQ5fe0gENsEycrK6AGpKb1
	N9Dh0gioRAM27duULyEkKdtQ2cGHJqo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-ULtI3wEMO8WLCDF3ko9dxg-1; Mon,
 02 Nov 2026 12:41:36 -0500
X-MC-Unique: ULtI3wEMO8WLCDF3ko9dxg-1
X-Mimecast-MFC-AGG-ID: ULtI3wEMO8WLCDF3ko9dxg_1793641295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C524E18011D7;
	Mon,  2 Nov 2026 17:41:35 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6703B30000E3;
	Mon,  2 Nov 2026 17:41:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 08/45] selftests: kvm: drop TEST_ASSERT_SUPPORTED_ATTRIBUTES
Date: Mon,  2 Nov 2026 12:40:52 -0500
Message-ID: <20261102174130.8779-9-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

TEST_ASSERT_SUPPORTED_ATTRIBUTES() is supposedly reminding tha
__vm_set_memory_attributes() does not support multiple attributes, but
that is not really a problem; the tests need to know that multiple
attributes can be overwritten, but that is not a problem for a simple
wrapper around KVM_SET_MEMORY_ATTRIBUTES.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index e2618877619e..7e480c034a87 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -473,14 +473,6 @@ static inline void vm_enable_cap(struct kvm_vm *vm, u32 cap, u64 arg0)
 int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
 			   size_t *nr_bytes);
 
-/*
- * KVM_SET_MEMORY_ATTRIBUTES{,2} overwrites _all_ attributes.  These
- * flows need significant enhancements to support multiple attributes.
- */
-#define TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes)				\
-	TEST_ASSERT(!(attributes) || (attributes) == KVM_MEMORY_ATTRIBUTE_PRIVATE,	\
-		    "Update me to support multiple attributes!")
-
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
 					    size_t size, u64 attributes)
 {
@@ -491,8 +483,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
 		.flags = 0,
 	};
 
-	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
-
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
 }
 
@@ -543,8 +533,6 @@ static inline void gmem_set_memory_attributes(int fd, u64 offset,
 		.flags = 0,
 	};
 
-	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
-
 	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0,
 		       "No valid attributes for guest_memfd ioctl!");
 
-- 
2.52.0


