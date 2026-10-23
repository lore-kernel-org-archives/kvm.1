Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775620;
	b=mlllPMBbglt4LvVg0KgdQgW/JhUyWUncrjiVRESF/YnFNRf+dw66Qkc2ntf3FKRYrINi
	 g5nJwZw9xC/i/kP9nMj/j9bChye5OSln/LuPpUoODaKnUK6BwswKUNe9HkvhbmtZxp29a
	 RPM+5MITptBx6PPF+/2VEQMAEiQyG9RZiIDU0589vLOSZ892RGO0BT2q5SjUsbchxjr9R
	 yKfJ5+Y6vwhu3N+iOXXGbv9wt0f4fjgMGMoTLsHoJDR7t8nNpMm89QLyGo6vyyEcQCgi8
	 JPxPGNnPOK+FoBPObktNaHBpF2QEYw7jJ6PaHzkd5ybzzR4e5HFA1oYdaLMHmMyeByA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775620;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=FXg/Y+nwtuIQUW3oJQNhc7HyHpgrGJ820g/vqLqV7fw=;
	b=NuOUbDQlSF9yhXhT9QaapGlyl9tAyBWOcb0bKGmQ0iys0CcD5ShtH63+kfSc+D4loVQz
	 C5TyGIWD5Amkn2I+n/D636QvpjQAYz83xhnsYoyNDFYCgC01wTKELRceWfveoTeTRE+fE
	 0HsYKxpkdfiAda7sfK4Qkb1V7V5TNXuG6Qs1CyP/gvCocC9TTMKtDuSd9Cy8TwSeeIlnc
	 VyatoBNL+slxc/utfhfb0ZtktD2Q+WayrLJbNdiOUTFwUB0gFsenX5Q55V1UgJXi21dmJ
	 QMqfNH6j7GZ8qpZ/GGwzlbJF7++xC4IjbaeYyNlMjy3sgvMzb7s/zk9cxKdWeNNKuow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=Ef565Tkt;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CE606A337;
	Fri, 23 Oct 2026 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 349CE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=Ef565Tkt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FXg/Y+nwtuIQUW3oJQNhc7HyHpgrGJ820g/vqLqV7fw=; b=Ef565TktpANAjOmWErbQiG+P+L
	1Te1HdKW3qqv0cf79wSofpTF2KUOBMSXb1fb+v2c52lH2wH17tXTFHR8Az23HyOaxSdSlLpd1honP
	UFCqFNdjWmDYYdk2f8cI2B+rBagcSlfD/R7LqQVGHm3ciK4db1HSZrTshPQQptvbqJ8uVFZ2Erd1A
	3F6/17oW+ZDVOsn1ZuqGcC8XYE0a4yF771mEN5wy7hscNUZf2clf8vxj2qlYLVPz1N4BM8ZTLw2w6
	8zNVNbAlsgWcFzxf1rwyxiNGHA64wT19/0wMHbdy93ZoesiCAbcqdI3M3dWBTOSy6g2YcNVyLgljo
	cUbirnEQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:44206)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIpf-00Emvs-2a;
	Fri, 23 Oct 2026 19:13:31 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIpf-000M7R-1C;
	Fri, 23 Oct 2026 19:13:31 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 19:13:24 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amirmohammad.eftekhar@cispa.de>
Subject: [PATCH] KVM: VMX: Add array_index_nospec() to evmcs_field_offset()
Date: Fri, 23 Oct 2026 19:13:07 +0200
Message-ID: <20261023171307.636760-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
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

evmcs_field_offset() bounds-checks the guest-supplied field index against
nr_evmcs_1_fields and then indexes vmcs_field_to_evmcs_1[] with it, but,
unlike its vmcs12 counterpart get_vmcs12_field_offset(), it does not clamp
the index with array_index_nospec() after the check.  The field index is
derived from a guest-supplied VMCS field encoding on the enlightened
VMREAD/VMWRITE path, so the array access can be performed speculatively
past the bounds check (Spectre v1), disclosing memory adjacent to
vmcs_field_to_evmcs_1[].

Clamp the index with array_index_nospec() immediately after the bounds
check, mirroring get_vmcs12_field_offset().

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/hyperv_evmcs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
index bc08fe40590e..052b62b8ed8e 100644
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
2.43.0
