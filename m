Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393D2765D4;
	Thu, 19 Feb 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531975; cv=none; b=RRbdxz22NQWG6sOR8+DDpKa8DeLwEBxdCgRDuBvsv2mNurxLxhKpOMRvnxe7j2LPg4obAbmoyEz1AWseqaVdllv2mpgMY7E5F8PXz9oLwEpl3KFQiWcA+Gu2vK3I9wLbcB4HHxusBGTvFzjQLQr796jwdHWtHER1aW3ws3Tm6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531975; c=relaxed/simple;
	bh=1lV74iSAjfwqBJCG9wKSZ2Zg3lWvazMSPgcGC3dGmSE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=BZAt7w0YKog7cJtFTf5bCZtquRm0Y2xw9Ku1RGdNq2GiXHsuYLNWtQS4tNWMeLY4rjeKInprlYk4smKGpGzKsZ8U7DpnwMlkut3snJBEPxms+ZgcsxJho0ckmGu4HPfhaGWEKNdiVHtA6DmBT5AvQBEvcGXeVuoD51wB4KtTyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=bTLEhRXP; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="bTLEhRXP"
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4fH4BR3HDFzyTX;
	Thu, 19 Feb 2026 21:05:51 +0100 (CET)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=tu-postout21; t=
	1771531549; bh=FA+/QHh3sVCaifq1i2u9Uwnfe6kSBmkSjJUoH/ck2zs=; b=b
	TLEhRXPZihhcyQazVdfbjAWeqHx0lImwA9YXpUZgG0PdogHxgO2SkYa18IzYrDAr
	Gai0gYBqCE4iaLWqBDnGoHqgKS+cmFLUAefQu53CsyLFLGYocUsAX4wXdk4QCRpT
	e9Tss8HtdWgbz5Gg4IiCWMBuyejdG83Ron/ge4prtEWUEBycTiO6hwdN8DRSTCuz
	Mc7DylCzaT9Adb3m5yvXXvTWV/LKQk02/DXAJ1dX7djmy7viVD5odUNeEncYKRVw
	eBy0ywX9d+0/unUBkoqL4GdsBfG9Ynpuz2JRBr2vb7uPefD7EbHJRZ868igKJ0qY
	jL2xuE8jQTSYoNSWgEgeA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.872
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id k55UVsGa6ptm; Thu, 19 Feb 2026 21:05:49 +0100 (CET)
Received: from [IPV6:2a02:2455:1b1f:7600:4ef1:1d22:7642:b2a6] (unknown [IPv6:2a02:2455:1b1f:7600:4ef1:1d22:7642:b2a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4fH4BP5D60zyW8;
	Thu, 19 Feb 2026 21:05:49 +0100 (CET)
Message-ID: <00a7a31b-573b-4d92-91f8-7d7e2f88ea48@tum.de>
Date: Thu, 19 Feb 2026 21:05:49 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Manuel Andreas <manuel.andreas@tum.de>
Subject: [PATCH] x86/hyper-v: Validate entire GVA range for non-canonical
 addresses during PV TLB flush
Autocrypt: addr=manuel.andreas@tum.de; keydata=
 xjMEY9Zx/RYJKwYBBAHaRw8BAQdALWzRzW9a74DX4l6i8VzXGvv72Vz0qfvj9s7bjBD905nN
 Jk1hbnVlbCBBbmRyZWFzIDxtYW51ZWwuYW5kcmVhc0B0dW0uZGU+wokEExYIADEWIQQuSfNX
 11QV6exAUmOqZGwY4LuingUCY9Zx/QIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEKpkbBjgu6Ke
 McQBAPyP530S365I50I5rM2XjH5Hr9YcUQATD5dusZJMDgejAP9T/wUurwQSuRfm1rK8cNcf
 w4wP3+PLvL+J+kuVku93CM44BGPWcf0SCisGAQQBl1UBBQEBB0AmCAf31tLBD5tvtdZ0XX1B
 yGLUAxhgmFskGyPhY8wOKQMBCAfCeAQYFggAIBYhBC5J81fXVBXp7EBSY6pkbBjgu6KeBQJj
 1nH9AhsMAAoJEKpkbBjgu6Kej6YA/RvJdXMjsD5csifolLw53KX0/ElM22SvaGym1+KiiVND
 AQDy+y+bCXI+J713/AwLBsDxTEXmP7Cp49ZqbAu83NnpBQ==
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In KVM guests with Hyper-V hypercalls enabled, the hypercalls
HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST and HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX
allow a guest to request invalidation of portions of a virtual TLB.
For this, the hypercall parameter includes a list of GVAs that are supposed
to be invalidated.

Currently, only the base GVA is checked to be canonical. In reality,
this check needs to be performed for the entire range of GVAs.
This still enables guests running on Intel hardware to trigger a
WARN_ONCE in the host (see prior commit below).

This patch simply moves the check for non-canonical addresses to be
performed for every single GVA of the supplied range. This should also
be more in line with the Hyper-V specification, since, although
unlikely, a range starting with an invalid GVA may still contain
GVAs that are valid.

Fixes: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
---
 arch/x86/kvm/hyperv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index de92292eb1f5..f4f6accf1a33 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1981,16 +1981,17 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
 			goto out_flush_all;
 
-		if (is_noncanonical_invlpg_address(entries[i], vcpu))
-			continue;
-
 		/*
 		 * Lower 12 bits of 'address' encode the number of additional
 		 * pages to flush.
 		 */
 		gva = entries[i] & PAGE_MASK;
-		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1; j++)
+		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1; j++) {
+			if (is_noncanonical_invlpg_address(gva + j * PAGE_SIZE, vcpu))
+				continue;
+
 			kvm_x86_call(flush_tlb_gva)(vcpu, gva + j * PAGE_SIZE);
+		}
 
 		++vcpu->stat.tlb_flush;
 	}
-- 
2.50.1


