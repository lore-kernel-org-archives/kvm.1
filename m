Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524907;
	b=TAQHf/efBXri8l6FKwAdm0Pog6k13xsZCj7EYslUj1j7WcVo1kFVp5zeU4H2ATWYAZKA
	 v6HOWqgB6axYOGm35gAANVWIKTWqYTw9ZEB3CqYgLUXs/Xs3tj/zKi9iowh79EGE/T9Ot
	 p0PL6uDGpa0V/xqz39HN4KMS24ioBzFzJia7p0AlS0YkVp/JgEk2v964cIc6/K/o7CAf/
	 0bzOSXaMXWdQObMcvk9rBOjBMOu4r/CEtUXoRtU2IooAeQOaFhMfZb7HlNydK3vJ/4mV1
	 vlR5I0nxLVDAxUwzu6Rf3rOzDeJ8QhlOhI9bQZmEirPNSdL9pvjgKIDjDqVNwWQhzEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:From:Subject:
	 Autocrypt:Content-Type:Content-Transfer-Encoding;
	bh=5CRmZTmobDtZDxGYLCwgxmYfUE/ktGoI/PFXfjRrjXI=;
	b=lBe2v1W9cW+KLFHUyel00ioCdfPhmvewU6D618QMKep+Z/hzQu3xDU2MozEm/a/oZ2B/
	 578qcwHRztJ0ay5VOmXFCqeGyM0C9mRjrYy+TWNBrNpoeU8OBuHmYXv4mSHY6ychmolEB
	 4biIe72Q2opus6fL9jikvtX1ybudxBYOvd6wdnHzTkdC0+UVSdoXpzcn1mI+fM0FWcVoP
	 0B7dEL69pDR+wyT/pIuE8ukIBYw+XYkAyjEIg0XFXltZ2jzs6lSM05/+HXpbHUaJdwLJY
	 v0w3hr61jHpPs8x2EMu4u3qZrKL5ZRlABLRErYFpn1V0Sb63udT2sYECwF2cdwrwFVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b="GuRm/1iQ";
	arc=none smtp.remote-ip=129.187.255.138
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CB606A31A;
	Tue, 20 Oct 2026 19:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=GuRm/1iQ
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4j8N0Y5VPvzyXd;
	Tue, 20 Oct 2026 21:34:53 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=tu-postout21; t=
	1792524893; bh=5CRmZTmobDtZDxGYLCwgxmYfUE/ktGoI/PFXfjRrjXI=; b=G
	uRm/1iQrhpznNIwQwcPOEeLY/wIQVVza2Ge3p+Wp9LKeDuwe5goJFCZrn7X9JWJo
	d+yUjRbSHXQJOa15C87JtzGjAzioUVHaE7S2efo0ffCsqOtMDTNzGqsdYSDzqm5u
	4YrlG318KXzSeWKjQJeCtZdiNy90jWXvqZWRrcqGTym5es8MzbXYjdVlpECWn5g4
	pWR86tllSKqLeKKOXBApxnlAiJmSZuMj/Y3k2jX6eDVR1r/EBLyNZPNeg3q9b97p
	nYz1Ucgm2N14Uo6agB9Iij/Mt9vbau2z7sGdNJFWGiorEQRiKfT10CJE04h6LDAG
	zKmTjlWouuUq0QRQBs4FA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.871
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id jOV_orH8BHxa; Tue, 20 Oct 2026 21:34:53 +0200 (CEST)
Received: from [IPV6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614] (unknown [IPv6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4j8N0Y1QYfzyXy;
	Tue, 20 Oct 2026 21:34:53 +0200 (CEST)
Message-ID: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de>
Date: Tue, 20 Oct 2026 21:34:51 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
From: Manuel Andreas <manuel.andreas@tum.de>
Subject: [PATCH] x86/hyper-v: Don't WARN on VM-Enter if eVMCS sees
 VMFUNC[63:32] != 0
Autocrypt: addr=manuel.andreas@tum.de; keydata=
 xjMEY9Zx/RYJKwYBBAHaRw8BAQdALWzRzW9a74DX4l6i8VzXGvv72Vz0qfvj9s7bjBD905nN
 Jk1hbnVlbCBBbmRyZWFzIDxtYW51ZWwuYW5kcmVhc0B0dW0uZGU+wokEExYIADEWIQQuSfNX
 11QV6exAUmOqZGwY4LuingUCY9Zx/QIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEKpkbBjgu6Ke
 McQBAPyP530S365I50I5rM2XjH5Hr9YcUQATD5dusZJMDgejAP9T/wUurwQSuRfm1rK8cNcf
 w4wP3+PLvL+J+kuVku93CM44BGPWcf0SCisGAQQBl1UBBQEBB0AmCAf31tLBD5tvtdZ0XX1B
 yGLUAxhgmFskGyPhY8wOKQMBCAfCeAQYFggAIBYhBC5J81fXVBXp7EBSY6pkbBjgu6KeBQJj
 1nH9AhsMAAoJEKpkbBjgu6Kej6YA/RvJdXMjsD5csifolLw53KX0/ElM22SvaGym1+KiiVND
 AQDy+y+bCXI+J713/AwLBsDxTEXmP7Cp49ZqbAu83NnpBQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

With the necessary Hyper-V extensions for eVMCS enabled, an L1 guest can
trivially fire a WARN_ON_ONCE in nested_evmcs_check_controls.
While vmcs12->vm_function_control is technically already sanity checked in
nested.c, that check is only performed if VMFUNC functionality is at all enabled
in the secondary processor controls of vmcs12.

vmcs12->vm_function_control seems to only be utilized in the handling
of a VMFUNC initiated from L2, but here a function other than 0 will
just end up in a failure case either way, regardless of whether or not
it is permissive in vmcs12->vm_function_control.
Therefore, the check has no reason to trigger a warning at all.

This patch simply removes the WARN_ON_ONCE and keeps the check.

Fixes: 3ff8a13d41b2 ("KVM: nVMX: WARN once and fail VM-Enter if eVMCS sees VMFUNC[63:32] != 0")
Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
---
 arch/x86/kvm/vmx/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fa41d036acd4..008a06924eb4 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -186,7 +186,7 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 	 * controls in bits 63:32, i.e. dropping those bits on the consistency
 	 * check is intentional.
 	 */
-	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))
+	if (vmcs12->vm_function_control >> 32)
 		return -EINVAL;
 
 	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
-- 
2.56.0

