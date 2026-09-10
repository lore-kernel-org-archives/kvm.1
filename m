Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE04BFE91;
	Thu, 10 Sep 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041268; cv=none; b=e3voI/5vdHeW/41qIS5lhUY5qmz8zr7WGl3TD+8dePxy/o/ZepU1hox8mCJ4yELCpK2Vw8XeO6I2aDzGilgitoySnlj9R5wddvns0KlNZYQdJ1EQJZGQ88zPJ4KCnDz7ixVpVhqlmRnBtdOqBDtqIMErqRSjIndOUS6ishKcxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041268; c=relaxed/simple;
	bh=JL+3joFHPxgYeoVZXrOjXNbhKKHvBdYhlRhoPrFlHhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Won4OunP8S4Bq+lpl1ppE/0jFobO1JnvAy6/5UhDATrH/ksTkMBWLMMB69dAy/xQgCzrTqTg6lodrSHEyWNrRPsRoPopEdwenACdgpVDnpHUR96QV0SNpkuH/mrZng1ghPRZccFKdEDnYR5aMtOFrCIKJ5ukoxB1OOI7luR0OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf1BHczbKSst;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgd68GZzb0tj9;
	Thu, 10 Sep 2026 19:54:21 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP290e8292dce8b0d7e4fdbe0a94d750e2
	Thu, 10 Sep 2026 19:54:21 +0800
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
Subject: [PATCH v2 4/9] KVM: selftests: vmx_exception_with_invalid_guest_state: Support Zhaoxin CPUs
Date: Thu, 10 Sep 2026 19:54:09 +0800
Message-Id: <20260910115414.3015260-5-ewanhai-oc@zhaoxin.com>
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

The vmx_exception_with_invalid_guest_state test currently requires an
Intel CPU. However, Zhaoxin CPUs also support VMX and the relevant
invalid guest state handling under KVM.

Update the test requirement to allow execution on Zhaoxin platforms in
addition to Intel, enabling broader coverage of VMX-related error paths.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 .../selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c
index 2cae86d9d..08a0caa9c 100644
--- a/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_exception_with_invalid_guest_state.c
@@ -109,7 +109,7 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	TEST_REQUIRE(host_cpu_is_intel);
+	TEST_REQUIRE(host_cpu_is_intel_compatible);
 	TEST_REQUIRE(!kvm_is_unrestricted_guest_enabled());
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.34.1


