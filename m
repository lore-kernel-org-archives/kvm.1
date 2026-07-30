Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224C403E88;
	Thu, 30 Jul 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409549; cv=none; b=CfxMbZUWnCduxZushf2+Qet4FGk7lS1MtyKkXMp6f/0E1NfZKOJ2Cb1bm6zpT8+Wrt2kcdmQybt8Cj/ztbrE8Kh3XV+KONSrP3up4V6bbzLEWHbAv+UwMj507PT2RMXMuG/Ow74t4VTbdd60t0x9oRXOAPA6HxKrgnN6G10vhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409549; c=relaxed/simple;
	bh=84xT1aYCe3jjrUAO/6d8VI6JPFcF0vXEMVWZcwwItiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEFltJqTwERDXZ2SSZFvGO+7Dv3d2aGBRHSUa6GGdn0KQs2UTIpin6mZyDvYg8e6VZl7kfnDrl6WlhTuM7/Lw8bUVoIHBJvWnvFWBbqdBTKon3zz+J9y0BafjfTNoekThZ5KBrXCkmf7m33XFYt5QDWS82y+hJDA1HhyrQBN2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZn1lF3zYq2h6;
	Thu, 30 Jul 2026 19:05:37 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZl3R1tzYq2gx;
	Thu, 30 Jul 2026 19:05:35 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP6b7e43b3429133be812d33c58b8f50b8
	Thu, 30 Jul 2026 19:05:34 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Frank Zhu <frankzhu@zhaoxin.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] KVM: selftests: nested_exceptions_test: Add Zhaoxin CPU support
Date: Thu, 30 Jul 2026 19:05:23 +0800
Message-Id: <20260730110524.2539316-8-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

In the test, the ERROR_CODE_EXT_FLAG bit should not be set in the #GP
error code on Zhaoxin CPUs. Add GP_ERROR_CODE_ZX and use it when
running on Zhaoxin hardware.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/nested_exceptions_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index aeec3121c8e8..bacbbdc5dc69 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -38,6 +38,7 @@
  */
 #define GP_ERROR_CODE_AMD ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
 #define GP_ERROR_CODE_INTEL ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG | ERROR_CODE_EXT_FLAG)
+#define GP_ERROR_CODE_ZX ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
 
 /*
  * Intel and AMD both shove '0' into the error code on #DF, regardless of what
@@ -139,7 +140,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	 */
 	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF), 0);
 	vmx_run_l2(l2_ss_pending_test, SS_VECTOR, (u16)SS_ERROR_CODE);
-	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR, GP_ERROR_CODE_INTEL);
+	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR,
+		   host_cpu_is_zx ? GP_ERROR_CODE_ZX : GP_ERROR_CODE_INTEL);
 
 	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF), 0);
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
-- 
2.34.1


