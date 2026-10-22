Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705936;
	b=Cyu3gNrjgiewYfvpfItGK9KcfeINEYK75R4CUY+m+izcaPVuqxShCOsu9H1ReeDWEFFg
	 De6uo7JUFERGcHF8c013L57GlVO0tQICf8I0xN6DwcFkWKqdHPwCy2e15IOLapui4raWt
	 Hl6956N9tAQ2/uPDnRX1zBRqr4sziLh37HtWZ9TzpLA+h/bfqW07DAPEax3lwpJENuyR4
	 iiXPcIJMMIJ6Lll7yHbvrO7Qo7xre2CUWJ8Out/j+ojJXxzVWcnecnJ3soqolUh3PvoJR
	 2WP4BRZl7qGegfSHXeLDMQ46n4ydAkNl6zI4TgjYHI9QSC/hSa8qkb06RMqL0AV9rDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705936;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=FA8yLTjvIlvk5v6wvcwdI9lasBto10X4JgXX+a4dJO0=;
	b=a/cgyCw6Iz7pVNHLB9FL5D5jSPD1bVMZHxUIHhADq4T2zeAbRsc4F4G5QthFy880AVgU
	 sG0185kClwRCISeLXtatNX0xRWDdlXuGSlgHbqyzV5Bca2Jtk+XWN2qt8WTWHw+89SZWf
	 DghBQ6XyHPL11z0flqDOaI5pZzoS8crq4drdVwAlRcmAfO/Mw3k2udECYInf7QvRyBQae
	 eEFO2FHcSYXFrCTzUvmTOw1mPj2wNIO1xC3hEe5h6Zy/8hr7RX0/McWaQDLPbeTbl7VqE
	 0Rs6ZuFCWXSlEzmAWDMzk6nxsskj3tYN7MN57d15Gke05Ay2my5qcvuo81xT6buV8CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=apW+X5om;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DE606A319;
	Thu, 22 Oct 2026 21:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C2DE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=apW+X5om
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FA8yLTjvIlvk5v6wvcwdI9lasBto10X4JgXX+a4dJO0=; b=apW+X5omtFmVzmuL6Qc76xWpVI
	uTwY1F/FoouNVs8iVMlwN9U4ksB/uR4BbmCXUmQawVDH+JF7Io5iXswbvadWdGFupbejhGcJCSEYs
	dEpg8JSmNPVxMQZe0yKMyMIgS2LOovPuZoi6FHDEzfF//7EGR0bCZGMk9OdaSlBRMMAAdA7niOsMw
	0xJS2oackP1/ESWFAPEYif3xwDsqlOxoZQZtJDjOUdGaxI9Apprf/oZFV91Y9jrv27oXBShtljaRQ
	XTkKFHfVGvlz0DpO5pE+GazH9sP4VrIC997GlgK4O2sgR8Ac2aYAFe/6HJeQvdJIGjN/+Y75HJcnW
	YQojtJ3w==;
Received: from mailer.gwdg.de ([134.76.10.26]:42479)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0hp-00EBqU-1E;
	Thu, 22 Oct 2026 23:52:13 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0hn-0001o4-0g;
	Thu, 22 Oct 2026 23:52:11 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 22 Oct
 2026 23:52:10 +0200
From: <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammadeftekhar@gmail.com>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH v3 1/2] KVM: nVMX: Reject nested VM-entry in a non-active state blocked by STI/MOV-SS
Date: Thu, 22 Oct 2026 23:51:45 +0200
Message-ID: <20261022215146.233479-2-amirmohammad.eftekhar@cispa.de>
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

nested_check_guest_non_reg_state() only checks that guest_activity_state is
one of ACTIVE/HLT/WAIT_SIPI; it does not enforce the SDM's requirement that
the activity state indicate the active state when the interruptibility-state
field blocks by STI or MOV SS.  KVM cannot rely on hardware to catch the
miss: prepare_vmcs02() never writes GUEST_ACTIVITY_STATE, so vmcs02 always
carries the active state and the physical VMLAUNCH cannot reject the illegal
combination.  Add the cross-check.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/nested.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b25216862740..6e2ec1912f12 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3311,6 +3311,11 @@ static int nested_check_guest_non_reg_state(struct vmcs12 *vmcs12)
 	       vmcs12->guest_activity_state != GUEST_ACTIVITY_WAIT_SIPI))
 		return -EINVAL;
 
+	if (CC(vmcs12->guest_activity_state != GUEST_ACTIVITY_ACTIVE &&
+	       (vmcs12->guest_interruptibility_info &
+		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS))))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.34.1

