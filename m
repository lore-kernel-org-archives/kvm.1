Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7234E405C3F;
	Thu, 30 Jul 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409548; cv=none; b=CCQYhw1DFuJy2pTsaCurGzf7ZqU4NVsysasVcoiUgtH1PZRf6GSncAj8t1sNxL9CToCB0AdQwuiFAA9gcRG2F6AZt9W+rukNeYVsSU8tYD+uRYd2kqx5FRgak6RTM71RIhOsZfkLBcVaQL6vri0pD+oq11juh3iLCys/T7Vwszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409548; c=relaxed/simple;
	bh=CGlCpB5EiTcsb2Ij1XVPz5HMTj1FXa6u21w3kjLKq3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEAyrDKEjYqRV3seOp5VImKqk+CyKjyLZMcgu+FsaMk2Wkq7eDUpbOHiOtE+VBmKptD0yHURZ3ljd/mrpYTHT4QbUyXUR7g50cYnKFMwebHZdCGAyyPxrfUgls5LFwjpEEBOZ6krrp0nIWRSIVtQILfjl7URJAdXqhB9AxZeu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZn14PVzYq2h2;
	Thu, 30 Jul 2026 19:05:37 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZk3mSVzYq2gt;
	Thu, 30 Jul 2026 19:05:34 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP96f7cd9a74beef927aa5d963abc750b8
	Thu, 30 Jul 2026 19:05:33 +0800
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
Subject: [PATCH 3/8] KVM: selftests: vmx_exception_with_invalid_guest_state: Support Zhaoxin CPUs
Date: Thu, 30 Jul 2026 19:05:19 +0800
Message-Id: <20260730110524.2539316-4-ewanhai-oc@zhaoxin.com>
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

The vmx_exception_with_invalid_guest_state test currently requires an
Intel CPU. However, Zhaoxin CPUs also support VMX and the relevant
invalid guest state handling under KVM.

Update the test requirement to allow execution on Zhaoxin platforms in
addition to Intel, enabling broader coverage of VMX-related error paths.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 .../selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c
index 2cae86d9d5e2..e95dc4cd8adb 100644
--- a/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c
@@ -109,7 +109,7 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	TEST_REQUIRE(host_cpu_is_intel);
+	TEST_REQUIRE(host_cpu_is_intel || host_cpu_is_zx);
 	TEST_REQUIRE(!kvm_is_unrestricted_guest_enabled());
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.34.1


