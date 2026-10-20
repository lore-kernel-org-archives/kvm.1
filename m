Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525042;
	b=I8+aPAXNB5zFr70OKyN47jSh8MwpJLr34QUd3yvkyDcpe47QzwVttSapGsuxNQlrVHXt
	 1w9tSVAszQsADurADkbmPQXAdKD2iqZqm40gY+uDRXc20BRHcehdbbdqBbsTjOoKgA4Ao
	 pphIcc6kf8JkDLg6R5odBRGXTrV2efX7Ctiz+zV3s/Cw+tkqb0taS9jgvwFaWNFQE+BiC
	 Wz95s6AEmNa+6VfcNX8FeMSg8fOF4MiCQklHbuNSockFvAmna615QBj7SjR+x1aK5100N
	 +pL5PI/hALsgjURX8qVjBp9VLVVwd/mGr8DdxIDo5A7/ZsqWm3b06jL7/AL50MvXaVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:References:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lJfXbLmJewhecVeBaxKsQ38eoUdCjcsDiyUhNMvljqs=;
	b=xzkXqYenzp8iJPfg/T2H322snyTiXBGgHtsFBm6ysDvzWi6ma3/kydOwB8dR/GPXFIyL
	 CobWzsXK0+Oge57Ww4IPDGQRfNewSmXZ6VFJTLcjOb5mvg0toq9ghtxFbthST8P9onZH/
	 +HbtoCGERqAK9/V1nweNnG/bI+/gSjbX8NyD9X4EUM7m2RWJtY0t3SifJwtv8NlE1jqGa
	 YC0iJIYowLwZok/midFqeM5poXBQRD9O+fpSebS5x0U49oZZ+3TTcUeoevH2a231H7Ifg
	 6Jox0ap3S/9XauDR2o9hAedZqRjTwxhZiF8Q6sRDNQkuayLYPq+1vc2TJkjWxYlnzrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=bffp17dl;
	arc=none smtp.remote-ip=129.187.255.137
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B2606A31B;
	Tue, 20 Oct 2026 19:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD6B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=bffp17dl
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4j8N3D0Rx9zycl;
	Tue, 20 Oct 2026 21:37:12 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=tu-postout21; t=1792525031; bh=lJfXbLmJewhecVeBaxKsQ38eoUdCjc
	sDiyUhNMvljqs=; b=bffp17dlgBBUHlP5IIdCZfXL9AUYWHp0x/GQ79DSv+EUup
	iL2V1wP5BasrH1STONeGZbLRFDdDsI3Aewl5QWt1qkMkcC2H3zeJ0vQqNjckUCN6
	g+WejfC62sOn7iHO28SMUsZN7CcCpaa6oqdPyKFcrZpmDbTiYfnatl/f3VzgjAfs
	uRFub2PGReVGftWYF7V98fXTY0bC44s5i6wARJn3Hz/oG3+7axgRlPuyonx4988Y
	7UX34ibh0dEmUqB8hHIC0913D0MY7n+TzvNr5WPNQWpBqVXqXdNRqBbZspGGaOm8
	AXNo9aI7chWaUKnf4g011/p+0Gl64+m/KUcY4X5g==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.869
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id yPs51_LIfFd2; Tue, 20 Oct 2026 21:37:11 +0200 (CEST)
Received: from [IPV6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614] (unknown [IPv6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4j8N2b234pzyfl;
	Tue, 20 Oct 2026 21:36:39 +0200 (CEST)
Message-ID: <9f68d7e4-7182-443c-80e5-457194c800b2@tum.de>
Date: Tue, 20 Oct 2026 21:36:37 +0200
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
Subject: Re: [PATCH] x86/hyper-v: Don't WARN on VM-Enter if eVMCS sees
 VMFUNC[63:32] != 0
From: Manuel Andreas <manuel.andreas@tum.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
References: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de>
Content-Language: en-US
Autocrypt: addr=manuel.andreas@tum.de; keydata=
 xjMEY9Zx/RYJKwYBBAHaRw8BAQdALWzRzW9a74DX4l6i8VzXGvv72Vz0qfvj9s7bjBD905nN
 Jk1hbnVlbCBBbmRyZWFzIDxtYW51ZWwuYW5kcmVhc0B0dW0uZGU+wokEExYIADEWIQQuSfNX
 11QV6exAUmOqZGwY4LuingUCY9Zx/QIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEKpkbBjgu6Ke
 McQBAPyP530S365I50I5rM2XjH5Hr9YcUQATD5dusZJMDgejAP9T/wUurwQSuRfm1rK8cNcf
 w4wP3+PLvL+J+kuVku93CM44BGPWcf0SCisGAQQBl1UBBQEBB0AmCAf31tLBD5tvtdZ0XX1B
 yGLUAxhgmFskGyPhY8wOKQMBCAfCeAQYFggAIBYhBC5J81fXVBXp7EBSY6pkbBjgu6KeBQJj
 1nH9AhsMAAoJEKpkbBjgu6Kej6YA/RvJdXMjsD5csifolLw53KX0/ElM22SvaGym1+KiiVND
 AQDy+y+bCXI+J713/AwLBsDxTEXmP7Cp49ZqbAu83NnpBQ==
In-Reply-To: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If relevant I utilized the following KVM unit test to trigger the WARN_ON_ONCE:

---
 x86/unittests.cfg |  6 ++++++
 x86/vmx.h         |  1 +
 x86/vmx_tests.c   | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index ae731a93..e46ecad1 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -482,6 +482,12 @@ arch = x86_64
 groups = vmx nested_exception
 check = /sys/module/kvm_intel/parameters/allow_smaller_maxphyaddr=Y

+[vmx_hyperv_vm_func_ctrls_warn]
+file = vmx.flat
+extra_params = -cpu max,+vmx,hv-vapic,hv-evmcs -append vmx_hyperv_vm_func_ctrls_warn
+arch = x86_64
+groups = vmx
+
 [debug]
 file = debug.flat
 arch = x86_64
diff --git a/x86/vmx.h b/x86/vmx.h
index f27ecd72..8d26b1a5 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -207,6 +207,7 @@ enum Encoding {
 	APIC_VIRT_ADDR		= 0x2012ul,
 	APIC_ACCS_ADDR		= 0x2014ul,
 	POSTED_INTR_DESC_ADDR	= 0x2016ul,
+	VM_FUNCTION_CONTROL     = 0x2018ul,
 	EPTP			= 0x201aul,
 	EPTP_HI			= 0x201bul,
 	VMREAD_BITMAP           = 0x2026ul,
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 2c0feca0..287336be 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12084,6 +12084,22 @@ static void vmx_cet_test(void)
 	test_set_guest_finished();
 }

+static void vmx_hyperv_vm_func_ctrls_warn_guest(void) {
+	vmcall();
+}
+
+static void vmx_hyperv_vm_func_ctrls_warn(void)
+{
+	/* Set the unsupported bit */
+	vmcs_write(VM_FUNCTION_CONTROL, 1UL << 32UL);
+
+	test_set_guest(vmx_hyperv_vm_func_ctrls_warn_guest);
+	enter_guest();
+
+	test_set_guest_finished();
+	report(true, "hyperv warn on should have triggered!");
+}
+
 #define TEST(name) { #name, .v2 = name }

 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12202,5 +12218,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
+	TEST(vmx_hyperv_vm_func_ctrls_warn),
 	{ NULL, NULL, NULL, NULL },
 };
--
2.47.3
