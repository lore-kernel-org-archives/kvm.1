Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905659;
	b=JwPWo/nVBVwS5RTcnPozU5yftB5WuZyZ3HbBA6kT9wm8NC37PQAUHuuXuGFp4mDo3FRV
	 65ZaJtDseWtp/1LvxQqiHJ276X349mc3XwYcHFOL3eb0vqcs40Zc8M4gOYQ59u5qDJTBz
	 pxv/4BaXMliKDyrz6LuCRfUNQCA1D4zFnYz5RkRZwD4o5ZMGlOFXOPPNhkAZRa4r2ejdU
	 yNxCYvW40ZhdmdkpLIjdCcpWdwEIx67Ia+FpP0BmA2cC10J9NYHiT6wbMoCkCg8Nrbot8
	 tR/vGN9CDB4mtJMxp86Sqpo/LrjBvjnNgvIzAaQo3vuGrMNbcCRtPfKF/uwyMBJizGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZAjaa18wdRgEqxid2YInH5sQS/VPsmf9qKFCXI+pZhg=;
	b=H7uqjBvXD9W/p3IdtTrFdastFTq4h/qPtDbJkqmOJpfCcAiD5v8M48lOqViJBPSGayte
	 uY5Ec28PlLBQ7ekK6ZVkG9U6NiWU7bxqPzR/yP7I+TUES9e0J/hRlARcxCb4htIbYteHK
	 Wf49/cr3f1Js86XVOPsErxQYys30fieaZ6Ruk5rPv0wyqwLCbscTMgUnMbMJqAtWwqPCZ
	 LA1zpkazkInqYO8FkEz0UkUzxxpChDn8tmiFqKB532muRcih5kKz7b1q6ceRzAhPnqyyD
	 c4z39M9o6EDuL+J12DsyD8f8rlWdO5HxKohbWYPgwDZki9VouV04+08raSUTzu3FD0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=STCQWHSR;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC2606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 19:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90EC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=STCQWHSR
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e8e16d22d8so29847905ad.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793905658; x=1794510458; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZAjaa18wdRgEqxid2YInH5sQS/VPsmf9qKFCXI+pZhg=;
        b=STCQWHSRTeOQ2A1SrWC9puX1CNsDmwC7hZCDU+SD27RZU7kdDJH7eu7lzmXjN0ZetQ
         E6oukNaqUymbYvtOiywcG0X5S6YEkji8jIaTuoJUwTmHECEVwV0o/0scPMsrYMfSqqxc
         2N0pZ1kax3FHmcy/B/GujC67kOe6Bkeg/GjTho4azqiPuqwngQ5ULVY/sjoT6SRvblwE
         vYNxWsk7AtFH/z8OiK4xE+hBjr6PvpageNfoAPkLLgzkzneiZ71F0/GN5oDpR1XBFJ/m
         5PmxmRj7Z+ZGVirz8l9oOBQBFhtOgdBTjLaJCKF5Qul/PcNdmim390Bp7GP2zratNA5P
         6s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905658; x=1794510458;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZAjaa18wdRgEqxid2YInH5sQS/VPsmf9qKFCXI+pZhg=;
        b=EZ/wkbSBgl5od4sytJCeIRewhWQTW9BWkwfgMftozk3SdYdjqsyYq1uZ+UtOo377jr
         u7sCWEgxtDSt38TAjlHArQ575S+RkAMzyOXWei5wLWvRKqU/P4BYdRSseGQV4+r21ufj
         eb50pNZXF1j7zPjdeO8da1fXdhXTeelsKlS8t5avRbnGEVLoDnlOP6Gxm6rT9WzZj/Ky
         UbPj1JRcpwxsSvoN0wGA3wmSVFXMUanCaSimUFCCpGX6fN5yI29iwNYldFNKXyhPlTnn
         oRuSxvJtkdV6e7jd+qgpUUtwPVKn6vjwXV9KByeaYseWoc3JVCAZKkafTPcI0AGkwW1z
         8xMQ==
X-Gm-Message-State: APuU4Z9mpy/3NSF7F0gJrlINkhwm0vok39AHNvfCIVkliZ9xlrkvx/Mq
	wkXjElUex9i709JjoKSqhk/+Zjw+WQYnwcvEvl4bcZ81ziVawCVCMABoVTORl7yxtZYxdcQ5YLC
	JxlCp+w==
X-Received: from plch18.prod.google.com ([2002:a17:902:f2d2:b0:2ec:f3ae:b625])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:2ed:3be3:c63d
 with SMTP id d9443c01a7336-2ed40c14d28mr5879335ad.23.1793905657669; Thu, 05
 Nov 2026 11:07:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Nov 2026 11:07:33 -0800
In-Reply-To: <20261105190733.3741959-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105190733.3741959-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261105190733.3741959-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: nVMX: Do eVMCS consistency check on VMFUNC
 controls iff they're enable
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manuel Andreas <manuel.andreas@tum.de>
Content-Type: text/plain; charset="UTF-8"

Check that the VM-function controls are actually enabled before performing
eVMCS-specific consistency checks, as the VMFUNC controls are supposed to
be completely ignored if they're not enabled.  Per the SDM:

  If the "enable VM functions" processor-based VM-execution control is 0,
  no checks are performed on the VM-function controls.

Fixes: 3ff8a13d41b2 ("KVM: nVMX: WARN once and fail VM-Enter if eVMCS sees VMFUNC[63:32] != 0")
Fixes: a83502314ce3 ("x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for nested guests")
Cc: stable@vger.kernel.org
Reported-by: Manuel Andreas <manuel.andreas@tum.de>
Closes: https://lore.kernel.org/all/f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/hyperv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index 2b40ac32ff06..a1daf8f2ec5a 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -187,11 +187,10 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 	 * controls in bits 63:32, i.e. dropping those bits on the consistency
 	 * check is intentional.
 	 */
-	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))
-		return -EINVAL;
-
-	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
-					       vmcs12->vm_function_control)))
+	if (nested_cpu_has_vmfunc(vmcs12) &&
+	    (WARN_ON_ONCE(vmcs12->vm_function_control >> 32) ||
+	     CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
+						vmcs12->vm_function_control))))
 		return -EINVAL;
 
 	return 0;
-- 
2.56.0.567.gdb80ae8cd5-goog

