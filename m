Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFC390C90
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976008; cv=none; b=nvyi54J77ACUK7quXewtKE+zWKTNt8xR3N9Qfi0nI6cyXuAUAowQamV5RsIJzQ/OfPbin+BHBMxbBj/h/KVipvfYGnqNfw/8pMQYIZr3k/6TX9FZ/2ZmBIFMJiLglnr1frQYgReQs8LNlWNIuL0LxpV/1O9Ww5arj6Y+PtTlHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976008; c=relaxed/simple;
	bh=PyxgTJ45o/OPhvyiuVtFcEE6uXES7YjovVkN1SKLHcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/jyipyb/IT5xNaT/iBsP7OELwrrAfBx1XwtcVtt+9Fi+MX7EVePd/amC8mLxqOV6K7xbkbt6OMyvHYNUo3gnOZDIDfOj0lUFERHiY8Tv0s2v12zD21HwpKYz7qQXNhBivUECSSKwFItcF/1R9WgAc1s9vxHLDo08JPmSFEoAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hAUNSA8X; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hAUNSA8X"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVd3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVd3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975048;
	bh=1hUPDQ4jsrz+82nB1hZ8AnzJPzwucRrSFCTUhh4HVXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAUNSA8XHEmQPxLkjv3TmwBR9dGZNjfF+Vg9a0/NjRobBMpwuLo67aRO2S2icEN3U
	 geQ58uFM216JGuhtCcuwqIVp98nqlZXumh47g67VxQ+u0BjzVcmovuGpTZVQKhk+Ec
	 Y0f1SaXMzxhZrgaH8HzfoLaMdYwNLVubM+cKn4xdiMAa50g17kygC952f0mWrUPuyC
	 tLQcWm8kEN9JpVA7RjyFeYeBhrFgYOL7LpgUt2bYCLCW/M+eZNl17jqaDbUTccSCs5
	 4wRSNFtZF5yjoklDCrtCFKTFlhz6vFlt0jJJx0JjIf8v6/V3h/xvrXErIt5Dgf0V1L
	 r3NWQHUVkKHkw==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 04/11] x86/vmx: Fix a typo
Date: Wed,  1 Jul 2026 23:50:32 -0700
Message-ID: <20260702065039.3434909-5-xin@zytor.com>
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

This should be GUEST_EFER rather than GUEST_PAT.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index da925baf..a1f52749 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -537,7 +537,7 @@ static int test_ctrl_efer_exit_handler(union exit_reason exit_reason)
 			report(rdmsr(MSR_EFER) == (ia32_efer ^ EFER_NX),
 			       "Exit load EFER");
 		}
-		vmcs_write(GUEST_PAT, ia32_efer);
+		vmcs_write(GUEST_EFER, ia32_efer);
 		vmcs_write(GUEST_RIP, guest_rip + 3);
 		return VMX_TEST_RESUME;
 	default:
-- 
2.54.0

