Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812903;
	b=Ig3G8hZBUHaVgfGF0gpbnrykzHhHxewsIsp1GvULFxPUcrdOc25rw8RFUtEbBkgUDmz5
	 Wf+XQJ7k8WUPWGZlo1Q6BtizcWr4nqfeBJaw3Qu3xuwb+QRGnXvbeCRa9zrcvkv9WJDNt
	 fV7XW3W6PU1GXuDMFPjfmBz1GL4ra3oxGzx27qi5UvAOz0PUzmV5JIDJFQI2PmMx8QzjL
	 3GZ71GCLg+YH8p5Giihap8/3ps1MScw5fNvSO9vVYfiLGf1SUn8FFrbPcLGT1lWZOWMLB
	 d8Sf6jm8wKUJjGHXwEHokwKAo3bF1dy2vsehbkTnHkLl6Dp8oBww0BY/yViGeimSniA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812903;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=4DRzpZUpuRm0hUM4odvz6rVRD3RRQoYbSMr/AYotmDg=;
	b=lz0zrrRh0rAWvKdhleNgnAQSKbrgh57CgRDdl4AwmttH68q9YgP3VNIF/BI05wtM6K/a
	 l7mfr1Oag4fxnL6cZd3rYFNzw2ZT9RAdN+F56LjMqFcVFxOwGmmnu64PszabbRj15PbzH
	 RrMkgRvX88w94CUY3HXGFULA6uqadn8ge0CQTYMFdDWAIaDYjTEkG3vlCTUvzOH5KBu4z
	 7PeU4dBeHz5be5HABmyL2bOONv0peWEOz2HUUwPXvb9UiDlS/TU7EJabqxL1XcMFrD9cW
	 yQMTWcOiiZMErvN9JegD7BlnWgVmih6oe0amnzuNaZ5GlU4OBdTwM7ysovlDnti2Adg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAFB606A334;
	Mon, 16 Nov 2026 07:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAFB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jSf8g6LZ4z562g;
	Mon, 16 Nov 2026 15:08:19 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] KVM: VMX: Disallow 16-bit busy TSS (type 3) for TR in IA-32e mode
Date: Mon, 16 Nov 2026 15:08:19 +0800
X-Mailer: git-send-email 2.48.1
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 16 Nov 2026 15:08:20 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AFAABE3.003 by FangMail milter!
X-FangMail-Envelope: 1794812900/4jSf8g6LZ4z562g/6AFAABE3.003/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794812900.6AFAABE3.003
X-FangMail-Outinfo: 1794812900/6AFAABE3.003/4jSf8g6LZ4z562g/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794812900.6AFAABE3.003.4jSf8g6LZ4z562g@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFAABE3.003/4jSf8g6LZ4z562g

According to Intel SDM Vol. 3C, "Checks on Guest Segment Registers", the
TR segment type must be 11 (64-bit busy TSS) when the "IA-32e mode guest"
VM-entry control is 1, and may be 3 (16-bit busy TSS) or 11 (32-bit busy
TSS) only when "IA-32e mode guest" is 0.

Currently, tr_valid() unconditionally allows type 3 even when the guest is
in IA-32e mode (long mode). When emulate_invalid_guest_state is enabled,
this causes __vmx_guest_state_valid() to falsely report a valid guest state
for a 64-bit guest with a 16-bit busy TSS, resulting in a hardware VM-Entry
failure (EXIT_REASON_INVALID_STATE / KVM_EXIT_FAIL_ENTRY) instead of
emulating the invalid guest state.

Check is_long_mode(vcpu) in tr_valid() and reject type 3 when the vCPU is
in IA-32e mode.

Fixes: 648dfaa7df2d ("KVM: VMX: Add Guest State Validity Checks")
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..2a5db87fae0e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3898,7 +3898,7 @@ static bool tr_valid(struct kvm_vcpu *vcpu)
 		return false;
 	if (tr.selector & SEGMENT_TI_MASK)	/* TI = 1 */
 		return false;
-	if (tr.type != 3 && tr.type != 11) /* TODO: Check if guest is in IA32e mode */
+	if (tr.type != 11 && (is_long_mode(vcpu) || tr.type != 3))
 		return false;
 	if (!tr.present)
 		return false;
-- 
2.48.1

