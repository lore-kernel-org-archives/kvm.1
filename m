Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705935;
	b=LhKNinh4O8q3Efkta1oMpAPUiQHF8ApIODwLO5ZlTcAOs/wgmrvfTzFuvcX3/FwBvNcc
	 bpPbkiVfzP7nG+UtmjPXdKATa4+iOg44eVrBTuG7/xYhMRuFx2JbPwN0vrwBSg2okRA6m
	 gEV0uSN6Ew9VrmnCzlxQjH6GNkVBT/QFRAkUTQx2cF7pAatwg5LwN0eA1DmOiuhOwwTyd
	 ZbwDcBZVgVP2KoQRhpEC3/ueAl6lKniVjPyutLJJv+LzeXCCX2FKOTN7gNAnPfWJDn4NP
	 G1lQKJ8nkNqKYUMMqZDwcHy1RMTWzmhsLTAeQIxLGS+x1H7Y8Dz2WsmM6zcpgurFuxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705935;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=0GolvQVqdEEqnzyheGfPOvixdie2/ryMNmfsTHhC1Xc=;
	b=Jb8EJkwBFd2YBxfPjxtSmWJpatmipGOkGJG11lLD/OScBwcS+X7qRGMoqWvF/meIJJb7
	 bMIfztCRJeO3VM6bYtoGQtGO3OXWmmU0JaHaJAUCwXR9aId1t3E7XFfUoAu5iph3smCdL
	 j/FXGo5bSt3onMUPpHqMj3CTALrD/a4barLnSIcLel1kZ7GZqIM6wCoVDw6Ipyc3VZ4MI
	 6ZcYlDUZJA4znCmi1jMVsQhl5saJZUa5TFUangF8xqH6bAZEccDkNfJmNUCpUkVIBlToG
	 SW2a5IWVnehi6jVAtcpsZoeeOjfQQAryDpctGwXs3j9AHPuovJsrnFfCBYGq/BewSzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=DTHbhz5L;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2EB606A31A;
	Thu, 22 Oct 2026 21:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C2EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=DTHbhz5L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0GolvQVqdEEqnzyheGfPOvixdie2/ryMNmfsTHhC1Xc=; b=DTHbhz5LY1amyntVt2iQQcphts
	FmBKucu7JErg6kv91mY6R8wqGHLHEstKIdI3xte8I4qQI7BIMIUpL9E6hoXprRMPGTormE6EyW+5w
	93ImZWYkZM5ISfXrRj1wIOcAOjywkc5XiFFIDq/F0YFUOUgAsOwE0vrD8YAnOWDx/HgHZ6g9lvWzg
	f0hAtBPpBqAVyC78nyY4Vd8XlzW+onDIdDBAUTTwXdiUnDPWrUxKNcQqGkkWw+g87qHy26vmEfCRk
	rCXH4xgvXGn3sGNA5NTWHWZOPfqhjMRyAqmKis1wza+QNpjlpRcbBxOFdGDoaWxGpeStRpBMJcrca
	ZNRwdaYw==;
Received: from mailer.gwdg.de ([134.76.10.26]:47712)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0hp-00EBqV-1E;
	Thu, 22 Oct 2026 23:52:13 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0hn-0001oA-1g;
	Thu, 22 Oct 2026 23:52:11 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 22 Oct
 2026 23:52:11 +0200
From: <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammadeftekhar@gmail.com>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH v3 2/2] KVM: nVMX: Reject nested VM-entry in wait-for-SIPI with a pending event injection
Date: Thu, 22 Oct 2026 23:51:46 +0200
Message-ID: <20261022215146.233479-3-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atqDVkHjdJ2iF9Uv@google.com>
References: <atqDVkHjdJ2iF9Uv@google.com>
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
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-04.um.gwdg.de (10.108.142.63) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

The SDM allows no interruptions in the wait-for-SIPI activity state, but
nested_check_guest_non_reg_state() accepts a vmcs12 with WAIT_SIPI and a valid
VM-entry interruption-information field.  Hardware does not catch it: KVM
emulates wait-for-SIPI in software only after a successful entry (the mp_state
= INIT_RECEIVED arm) while the injection is copied into vmcs02, so the physical
VMLAUNCH sees {active, valid injection} -- a legal pair -- and succeeds.  From
L1's point of view a VMLAUNCH that bare metal rejects with a VM-entry failure
instead succeeds, with L2 parked in wait-for-SIPI holding a stale
VM_ENTRY_INTR_INFO.  Reject the combination.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/nested.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6e2ec1912f12..d98d33234e9f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3316,6 +3316,10 @@ static int nested_check_guest_non_reg_state(struct vmcs12 *vmcs12)
 		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS))))
 		return -EINVAL;
 
+	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_WAIT_SIPI &&
+	    CC(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.34.1

