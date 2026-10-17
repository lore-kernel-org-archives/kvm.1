Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6A1EF39E;
	Sat, 17 Oct 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229433; cv=none; b=hPw4lCaOz1x5Vx5HxI4RFwN19rPmvzb4i9TOWm7P8gKxheFuJ4N7mDa5FTxIHQPaAzEJjVfVhNMfaJsC3eL0uzyd49E5vZIdPe0Ml3lxA1NLwsHMTmK/0Oh+iC2O5KCCpuBaX8k4ZJXPvfaTjZF2rCG/caB4kmkaHwoy+FOvw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229433; c=relaxed/simple;
	bh=XIwXQiOFGaKHlPABngBsoYHJTOl5p6GmPby5z5C+jjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBgYkmsEtl6kvLq+miYhy87tRCWYuUSTxlFUpkX+JcThhSQkGM8YsysmThYHAPeCQw7nyw9axodZGQdnoR4EJQPpgk7ZOe37C4YlWlNhEx0+xGZEF5kroXYweucw1Ih7bVS0W0C0xPDMWAjKZlwy9ermrbC0elk492/95ikluAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=HLlA/7am; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="HLlA/7am"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZG8fo7tedQcmeqL9gFAFYyf9p1WCdQX7I/IW6qk2V4E=; b=HLlA/7amtk55/0tj22QAPx/XMN
	M1tUfOwiHec5xEU/yYbpN+1u2lSS3EoxyGAZW7cccLTcKyHfqiE7eDTQNHzb9d3Ze9eP26bOoUuRQ
	8XBaazD96D/rlDXSO17r5Kc8ARUKgSyMdBTdl1leDAH3DWRuO33T0PG/LxqkUsCmW1oo4DuYnseEX
	TCE6FXZfMxsDrisfrYZzeY7kgkxKTXwGEKurX4hsuIZF+/0VL1zrdK5dtO7ii0hPMum0AuTwsJndP
	1kokFWIu1TsASELMiw/C20OaGsp9B4ruiaIvBoeshW1Fjgg5y51Fenafp+PUppqvetVcZRE//vJBa
	prPPdFpA==;
Received: from mailer.gwdg.de ([134.76.10.26]:44957)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kJ-00BAXP-0g;
	Sat, 17 Oct 2026 11:30:30 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kI-000VXg-2a;
	Sat, 17 Oct 2026 11:30:30 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:30 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: VMX: Add array_index_nospec() to evmcs_field_offset()
Date: Sat, 17 Oct 2026 11:30:12 +0200
Message-ID: <20261017093016.32348-3-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-07.um.gwdg.de (10.108.142.66) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

evmcs_field_offset() bounds-checks the guest-supplied field index against
nr_evmcs_1_fields and then indexes vmcs_field_to_evmcs_1[] without an
array_index_nospec() clamp, unlike its vmcs12 counterpart
get_vmcs12_field_offset().  An enlightened VMREAD/VMWRITE from the guest
can therefore speculatively read out of bounds of vmcs_field_to_evmcs_1[]
past the bound check (Spectre v1).

Clamp the index with array_index_nospec(), mirroring
get_vmcs12_field_offset().

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/hyperv_evmcs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
index bc08fe405..052b62b8e 100644
--- a/arch/x86/kvm/vmx/hyperv_evmcs.h
+++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
@@ -136,6 +136,8 @@ static __always_inline int evmcs_field_offset(unsigned long field,
 	if (unlikely(index >= nr_evmcs_1_fields))
 		return -ENOENT;
 
+	index = array_index_nospec(index, nr_evmcs_1_fields);
+
 	evmcs_field = &vmcs_field_to_evmcs_1[index];
 
 	/*
-- 
2.54.0 (Apple Git-157)

