Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2163905E3
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976007; cv=none; b=rdw6dS4f+fjEEjWF3AswQTpeR52wlMwm5ThsY2BmaM/h3RLlMfqWl2JY1nSYM8FacWigFiZ3hCnFHMW5owvLVUDzdcR7bBuXozN7D656FAq41fDH7n63UWzilnVgQgH+9a4N7+eVNCwUFBhSwb+wuPm6cB4Mc7aZwacwxiKXN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976007; c=relaxed/simple;
	bh=heHKNmPW5AceHuyibWXA3BgKz56FyFPxmqg71dmkAKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6601MeXlo1NGaNcgndWYGEVE9h0QM4xLGjfORfdCupKsVxuzUbRu57w8yqfz2UpnsEnONVVtgllb3/1yRPNzsftjyheGTloDXkgjLP2mzYOS8UD8YBMfOiUwFY0+/Zu+K8vYxCjQ805lt5DU8tshP8xhAZBHdDg1EjYbadjG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=xK98rsYB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xK98rsYB"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVa3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVa3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975046;
	bh=EuqKok5sj09sPFeU2h1xhChaDN4XC03vkD7aqCZQewY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xK98rsYBAHv562zphY0KOeAgf1jVkBWXS1LlSdDaceAdI5tt1rozSc2e5spITk13X
	 M2VqUrcD9orX2ATM4Y9h3nZX9W1IY3rPcvtuk212l4OwSezdXTVC2cIm4yXGD8WNYu
	 HIC8BjeVfj4xC3aCeoow2i+takC9BeZgJIg1FLcqJZXV8Q2jxH2KoI2V8gbn2dDVyl
	 OPniOnoXI6c2p/2CxAJrACnM7ovbbyJNOjtsHphq2c9M3DGFFGhHPsynA+SwS96VLJ
	 4nxMhurRf2hRsAvBga/jqlm1SDXP25A+b2IAxEMZCoK3KQwP98UqvZtK7USFBft952
	 4padeedcn4aWA==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 01/11] x86/vmx: Support the nested exception bit in VMX_BASIC MSR
Date: Wed,  1 Jul 2026 23:50:29 -0700
Message-ID: <20260702065039.3434909-2-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065039.3434909-1-xin@zytor.com>
References: <20260702065039.3434909-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bit 58 in the VMX_BASIC MSR is used to enumerate VMX nested-exception
support, thus it's no longer a reserved bit, and can be read as 1.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx.c | 3 ++-
 x86/vmx.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index 99fc99e5..df212e19 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -1573,7 +1573,8 @@ static void test_vmx_caps(void)
 	report((basic_msr.revision & (1ul << 31)) == 0 &&
 	       basic_msr.size > 0 && basic_msr.size <= 4096 &&
 	       (basic_msr.type == 0 || basic_msr.type == 6) &&
-	       basic_msr.reserved1 == 0 && basic_msr.reserved2 == 0,
+	       basic_msr.reserved1 == 0 && basic_msr.reserved2 == 0 &&
+	       basic_msr.reserved3 == 0,
 	       "MSR_IA32_VMX_BASIC");
 
 	val = rdmsr(MSR_IA32_VMX_MISC);
diff --git a/x86/vmx.h b/x86/vmx.h
index f27ecd72..d9b500f6 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -114,14 +114,16 @@ union vmx_basic_msr {
 	struct {
 		u32 revision;
 		u32	size:13,
-			reserved1: 3,
+			reserved1:3,
 			width:1,
 			dual:1,
 			type:4,
 			insouts:1,
 			ctrl:1,
 			no_hw_errcode_cc:1,
-			reserved2:7;
+			reserved2:1,
+			nested_exception:1,
+			reserved3:5;
 	};
 };
 
-- 
2.54.0

