Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885837;
	b=W2vmurowHSrIKi1NPjiT/TOwVFHOC7C9NeNP+yFa00GiT1PCm8jw1bUvOcL7Elb+ifEn
	 U5H9u8kD0Ax0Ipy4xVpIwWiU7+NE5OJlUJToFhgFYSblwFLacixFb9Q638RdhwmJTDkrQ
	 WOz/YYVf7sB/4DEz1azz3MKxS0BV53iMKzhNZLS3+u4/KqCZGY426Aiq/geo7wD3+0wdi
	 KbLBeWslLNKx83wUl6xHLmBPWvZZCLVhhHu4IBKZbjacT1uKYgmkEpSfvuPnOHkBeSugq
	 V2DhylEhQ5dSEDhSOCZ1ecMNhKhcHRJU6o8VOOuZ1LSTwicxsHmK8zZ4XukGG08cv5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885837;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=f+RUblqoorE+DmrbdAwb+wwbOFEmVzV1Vh23cpuMpTA=;
	b=ESOSffcoxChn5pDjFtDg0WMivANRKsSS11XqJZlkVA0Z8oHq5Q+KT99G0LPL22WoHom0
	 j4PdULskw4mlb9vE8aSC+g5eL1EnyLcwOAGRDAOWQzz7foJoZt1/l0heNup9zU892YVmo
	 3NNAJK9aozUaljD2oSysTfGZmyngXtyoOcClftyeMgx6RvhZZrOt74jBgOKdiUEbNuVGD
	 au2y+UU1GcDk3A/npSDL3hFBf6SLsMIOEemBs/zYH+J91ZmPiZix3I7+GUvimk7XFsdw6
	 KavMV1kk3Tvr1eaNm4Vv5vFIzTjMuMAevtR481uW1eDEzEfyKI9Pf6SGBh3Ib0x03fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hzdkVEcg;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFED606A31C;
	Tue, 17 Nov 2026 03:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hzdkVEcg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=f+
	RUblqoorE+DmrbdAwb+wwbOFEmVzV1Vh23cpuMpTA=; b=hzdkVEcgWpdUFB7arC
	/n8ZIiQTOLSKL2Hdfp7b1+vyB/3rpLJljkMw4WPZCIr3JO4mttIabTHEORyoFWe5
	d0b8p+tc32BLIcNnzproxsc2rmJbpmZXWhaUo50Dq2bBZTy3xP6w6CpTVXeSiDvs
	BISfNpCfE28TR6MLi2is1tAWs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDX_0CIyPtq1HcFIQ--.40278S2;
	Tue, 17 Nov 2026 11:22:50 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	bharata@linux.ibm.com,
	paulus@ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] fix: KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
Date: Tue, 17 Nov 2026 11:22:47 +0800
Message-Id: <20261117032247.1053075-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_0CIyPtq1HcFIQ--.40278S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17tFyxGrWfKrWxJF4UXFb_yoWfJFcE9w
	40qanrZw4rAr4j93Z5Za9IgFs8Jr48GrWFk34Yq3srArZI9w4DKrZ2yrnxuFy8W3yqyrZx
	CFWvyF9Iyr1FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKSdyUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QrtXGr7yIqVuQAA3p

When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
directly, bypassing the existing error path. Jump to the existing
error path to clean up before returning the error.

Fixes: ca9f4942670c ("KVM: PPC: Book3S HV: Support for running secure guests")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..620097f292b8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
 	r = kvmppc_uvmem_init();
 	if (r < 0) {
 		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
-		return r;
+		goto err;
 	}
 
 #if defined(CONFIG_KVM_XICS)
-- 
2.25.1

