Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79847F2CA;
	Thu, 10 Sep 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041270; cv=none; b=YQlZH8Ynos7VkpeEUA2ARZ7UROg5cmT9atBwKlMWhGFqOPHkbnsiKRieHrsuetvSPUZQKRGTgHKtffKl1U9eaGTulj+aGNKJtUV33D775sHQgRvv1IRe+5iuvSjNINiFH2tLh4ZTvP4GiRZaezXdrpoHlxN9SomhEWegUT9OGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041270; c=relaxed/simple;
	bh=tocnf8CTwAWGZ2XA3c7AjDvg5yobaOOcv2htQLsGZC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSKO9uJwc1/fkk+pic7HclvMZgY39fuafVyJXhM4uEYZOpZ78yRlhPEqhHzLiw7btBZqFUrGCtBRTTy7X1uUNAV6Z76Li7VV0TZ174/TpbNxicwM+W9S/tj1T8bFYNFpXHcreTCTT+bskFHYlt8wektcDGYF4Oy9XPADZayuI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgj0ZBwzbKSsy;
	Thu, 10 Sep 2026 19:54:25 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgg5sxlzb0tj9;
	Thu, 10 Sep 2026 19:54:23 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP92d2bbcfff25a0d599b8a407667b50e2
	Thu, 10 Sep 2026 19:54:23 +0800
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
	linux-kernel@vger.kernel.org,
	ewanhai@zhaoxin.com,
	cobechen@zhaoxin.com
Subject: [PATCH v2 8/9] KVM: selftests: nested_exceptions_test: Add Zhaoxin CPU support
Date: Thu, 10 Sep 2026 19:54:13 +0800
Message-Id: <20260910115414.3015260-9-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

When vectoring an injected #SS through the empty L2 IDT, Zhaoxin CPUs
report the resulting #GP with the IDT bit set and EXT clear. Zhaoxin
sets EXT only for interrupt delivery and selected guest-mode events; #SS
delivery is not one of those cases.

Expect error code 0x62 when running the test on Zhaoxin CPUs.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/nested_exceptions_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index aeec3121c..78c27fa7c 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -38,6 +38,7 @@
  */
 #define GP_ERROR_CODE_AMD ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
 #define GP_ERROR_CODE_INTEL ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG | ERROR_CODE_EXT_FLAG)
+#define GP_ERROR_CODE_ZHAOXIN ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
 
 /*
  * Intel and AMD both shove '0' into the error code on #DF, regardless of what
@@ -139,7 +140,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	 */
 	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF), 0);
 	vmx_run_l2(l2_ss_pending_test, SS_VECTOR, (u16)SS_ERROR_CODE);
-	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR, GP_ERROR_CODE_INTEL);
+	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR,
+		   host_cpu_is_zhaoxin ? GP_ERROR_CODE_ZHAOXIN : GP_ERROR_CODE_INTEL);
 
 	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF), 0);
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
-- 
2.34.1


