Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576792;
	b=JTXaJiIIgPEZygKm4sLRUzJ2MUHJ2DCaapg16C+QIzyytt4vh+8Rqn/wNDdHvWWTgVau
	 mX+B3xWxLA98CiXJLkGP2TkogiJbzj2M+2jFs7EJEHKSRg6OywaXY9it76J9lgXYdWDRG
	 2qOY5iq0kR+wEW+JHf/uPnB2m+PM6ZwOZTSZ1ArkAjr/VqZe04ClXr3Pscu32bdCYTo5X
	 Cve22+dRkeII7phTWJ2Xd1Cdyx5OaDFmzhFT8+6SFeDyl6LaMMUonCeQ8fDMRfWLpWo1P
	 GE83bd5XtpoX0W6calfHvTwcmK0nsdbDb6baECZ2FawnyTPcrlBEX7YYidw8AB5hopg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:From:Subject:
	 Autocrypt:Content-Type:Content-Transfer-Encoding;
	bh=sjthr6lL03BtfNRNFM5Cu+KNtDVFOfHz0SS8ijp8QRQ=;
	b=dTm3XTkwUfuCRA6ckYC4AAoSjjH1MrJCNVOjxA9qnV0cypMcTBAadrOlaZs4/3wCzocZ
	 RMKYbLR/M3dK1w4TTXyz2kCb2YrWboFYy1az+JzldSBVY+IowpNq7tieRQNokiTC/tds/
	 FJRATOYHL4s6V+MLWyWpDO9HEpSJLz2CJ8jawgHx8puCCdgnH1GNZpp5DXf3uJZsyfQF6
	 QoIJRbQChhzwlw9bITFRusJfFS2D03moX+/k5G2wnDMLd+zCOJv3mBra3pPmbzw7YQV1w
	 /IrBnB/wMtHuoJgcPbt7hQJRvR2VnUmXOBHgcFS1Nd9IfxPzw8BOKntfUAO1CLwVsmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=bJSAlkXT;
	arc=none smtp.remote-ip=129.187.255.137
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4486606A32D;
	Fri, 13 Nov 2026 13:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4486606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=bJSAlkXT
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4jQyqv6bl5zySL;
	Fri, 13 Nov 2026 14:32:59 +0100 (CET)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:to:to:content-language:user-agent
	:mime-version:date:date:message-id:received:received; s=
	tu-postout21; t=1794576779; bh=sjthr6lL03BtfNRNFM5Cu+KNtDVFOfHz0
	SS8ijp8QRQ=; b=bJSAlkXT9DqydhKuLYfONt2l0GbeXIWYozqaMibhUf2x0BERm
	dSHgDwoqAqTDYGqe7r3/4smFdmO3/enebhHuVIt8RT0HmwfkI4iZyU6AzEpRXVvl
	eNPWslTg7RMrJ141QNLh0+hEwYWofvnQTlX3LZUAlZLNvEyw1rwqO4XW+q0R3Cyr
	y5+P0VXuqVvxkb//pSTZHO01WZb4TP4p+s7TZOpkqmI5tas31xyomUcKZifhUIhk
	tKvqY/X7chb1zHKNDJEADx37t2ymYsNaCaIBwcEu6ziaAsbgtvJYXW6x0x1kjLYu
	f1ZotAcJcxGBLXsOzv94adg5u7yDKDkpX4EKg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.872
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id KPhA-nGjwbmO; Fri, 13 Nov 2026 14:32:59 +0100 (CET)
Received: from [IPV6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614] (unknown [IPv6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4jQyqv0nnZzyWW;
	Fri, 13 Nov 2026 14:32:59 +0100 (CET)
Message-ID: <f4a86ec3-2155-4289-ac7a-1f9eb998e173@tum.de>
Date: Fri, 13 Nov 2026 14:32:06 +0100
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
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com
From: Manuel Andreas <manuel.andreas@tum.de>
Subject: nVMX: Policy on VM-entry checks KVM intends to support
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

Hi all,

I've built a tool that allows me to scrutinize the VMLAUNCH emulation of KVM.
With this, I am able to find a variety of VMCS12 configurations that will pass
KVM's own implemented VM-entry checks and eventually create an architecturally 
invalid VMCS02 that will fail its hardware VM-entry.

A brief overview of some of these cases:
- Missing checks on GUEST_RFLAGS
- Missing checks on GUEST_RIP
- Missing check on GUEST_CR4.PCIDE for 32 bit guests
- Missing checks related to guest segments
- Missing checks for event injection related fields
- Missing canonical checks on GUEST_SYSENTER_EIP/ESP

I am aware that a failed hardware VM-entry on VMCS02 is not directly an issue on its own, as it is
caught in L0 and forwarded to L1 for handling.

However, many of these cases would still bring forth incorrect emulation behavior.
For instance, lets assume an L1 guest has configured its VMCS12 such that both the GUEST_SYSENTER_ESP
and the VM-entry MSR load address are invalid. Then, a real hardware VM-entry on such a VMCS would result in EXIT_REASON_INVALID_STATE.
In contrast, since KVM does not check the GUEST_SYSENTER_ESP to be canonical, it would pass the guest-state checks and
move on to the MSR loading, which would eventually fail and forward the VM-exit EXIT_REASON_MSR_LOAD_FAIL to L1. Therefore, KVM does not
correctly emulate hardware.

Further, I can think of other cases (and believe have found at least one such case) that lead to incorrect emulation behavior due to missing/incorrect VM-entry checks:
- L1 launches an architecturally valid VMCS12, but the merging creates an invalid VMCS02 and KVM forwards a failed VM-entry to L1
- L1 launches an architecturally _in_valid VMCS12, but the merging creates a valid VMCS02 and the VM-entry succeeds. 

These cases would seem to contradict (or make one of such exceptions?) this statement from the maintainer docs:
"With few exceptions, KVM *must* honor architectural behavior, therefore it's implied that KVM behavior is emulating SDM and/or APM behavior."
Therefore, indicating that these cases are all to be treated as bugs in KVM.

Now, what's confusing me is that in `nested_vmx_run` I see the following comment:

/*
 * The nested entry process starts with enforcing various prerequisites
 * on vmcs12 as required by the Intel SDM, and act appropriately when
 * they fail: As the SDM explains, some conditions should cause the
 * instruction to fail, while others will cause the instruction to seem
 * to succeed, but return an EXIT_REASON_INVALID_STATE.
 * To speed up the normal (success) code path, we should avoid checking
 * for misconfigurations which will anyway be caught by the processor
 * when using the merged vmcs02.
 */

which one could interpret as KVM intentionally attempting to validate as little of the VMCS12 as possible?
This entirely makes sense to me if KVM simply prioritizes performance rather than 100% emulation correctness.

However, I am then once more confused by some other source code comments.
For instance, `__vmx_guest_state_valid` hosts the following comment:

/* TODO:
 * - Add checks on RIP
 * - Add checks on RFLAGS
 */

which indicates to me that one would ideally have those VM-entry checks for completeness sake,
just nobody got around to implementing those yet?

So in the end I would simply like to know what VM-entry checks KVM actually cares about, such that I don't
need to waste your (or my) time on submitting useless patches.

Thanks and best,
Manuel
