Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437540;
	b=E6tCmG172K7aVC8+J6obelvOWTV8TYF7Qf1htlSG/qgnPqQUtJZgFS8VdnQ9K8PZyYmL
	 7KVBQXNAD5JfktMDfgGOJaBZVY1TfANWGYNL+OsHpfDu1agOWYWvPHhMPZp8Vtsot2B/5
	 6pTVL0r+b8X3XqKiYYgjaTfuVldXFk9A7hQq8JZcD1o41C+541eiGOMAW7CnqKsXVCQIz
	 HDKO3WRBH4AjdQwJRkHPJMPJtXAHzpmcWzsYq8AMx2S5HzfxUrTu3MiOML+dc2300yXc8
	 mXvdhXRor9UhsGGY2Ll/thPYjWb7im/asv3Il6T5ZTwnxSRju5RziLW9jkaeg2vv5fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437540;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=Mghl+ozZsXUkWImos7sqBzlUuhVkwEuBCgl18BvqRlc=;
	b=qM18orrjYU+8keb+Q+cKTL3VFfhc2C4njN+VZibICfRhOMgFazFaW95Fe/ilmjSMAHpK
	 lWyOwj1kWjcY7tWDPHVCbWV1rb26EoWPHCzKl7cwqnfAQD6uI0Cp7cetC5SfB5Dr1W8Cx
	 hHvJMobuStk9CmFskc6B/9ONEBKKuzaWOSXOGAsh6yFJock5Mvb/m9ScuLcOMDYUCYaWB
	 yUzYCTtp+tuH5VbiVOwIBMKr22qBQZI/ErnGk9wyTpN4Yoo4xmdaw2EdZ6n2Jbl61tqdv
	 8WXKdgVYG8bGmJblaZymyg/pwcsm1VU6kxW5paX+rJQbSSXkSFjZyv52Eo2XMpKsurQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=p3dpftEX;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF2606A31E;
	Sat, 31 Oct 2026 09:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EBF2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=p3dpftEX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Mghl+ozZsXUkWImos7sqBzlUuhVkwEuBCgl18BvqRlc=; b=p3dpftEXkMFrVYhLomByjMkgDa
	xvKnXZXLH+0AAiXLyS0TuRIipQDh8Maa4otEAlqW1UkLyQ1y7S4Cn8KSVMLerFi3Yq+P+p8vtmt/w
	8zqPkAMkeNkXqC3awizQi/c1ty8059lb9wpfBwLF5brYQtul07vZG7vRCtW96/+jUvfjIjF2DGkcH
	oFqOnIcg7t0Ecp/du2bHIk22jw7i7rap16o2hqTxvtvOlxhUNcRR32AeezmqubTyk8DDJhz7zWR3f
	TzwZk0ikvqBALw0U98XLvmfUTSQayt+xynqeG5T4RCQxwjMMZlNnCoYTrtolabtQG9HniHgHN3bZI
	emx7njXA==;
Received: from mailer.gwdg.de ([134.76.10.26]:60318)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN51u-001WsN-1A;
	Sat, 31 Oct 2026 10:05:37 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN51t-000J69-32;
	Sat, 31 Oct 2026 10:05:37 +0100
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 31 Oct
 2026 10:05:37 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <vkuznets@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amirmohammad.eftekhar@cispa.de>,
	<amirmohammadeftekhar@gmail.com>
Subject: [PATCH v2] KVM: VMX: Add array_index_nospec() to evmcs_field_offset()
Date: Sat, 31 Oct 2026 10:05:29 +0100
Message-ID: <20261031090529.65240-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <kuph5i8x2d0.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
References: <kuph5i8x2d0.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
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
X-ClientProxiedBy: MBX19-FMZ-08.um.gwdg.de (10.108.142.67) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

evmcs_field_offset() bounds-checks the guest-supplied field index against
nr_evmcs_1_fields and then indexes vmcs_field_to_evmcs_1[] without an
array_index_nospec() clamp, unlike its vmcs12 counterpart
get_vmcs12_field_offset().

A regular VMREAD instruction is allowed while an enlightened VMCS is active
since 6cbbaab60ff3 ("KVM: nVMX: Allow VMREAD when Enlightened VMCS is in
use"), and it reaches evmcs_field_offset() with a guest-supplied field
encoding. Because the index is not clamped, the guest may be able to
speculatively access past the bound check and read out of bounds of
vmcs_field_to_evmcs_1[] (Spectre v1). The leaked value is only the u16
'offset', so the exposure is limited.

The other callers of evmcs_field_offset() are not under direct guest
control, but the array_index_nospec() clamp does not hurt them.

Clamp the index with array_index_nospec(), mirroring
get_vmcs12_field_offset().

Fixes: 6cbbaab60ff3 ("KVM: nVMX: Allow VMREAD when Enlightened VMCS is in use")
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
v2:
 - Reword the changelog per Vitaly Kuznetsov: the reachable path is a
   regular VMREAD (allowed since 6cbbaab60ff3), not an "enlightened
   VMREAD/VMWRITE"; note the limited exposure and the other callers.
 - Add the Fixes: tag.

v1: https://lore.kernel.org/all/20261017093016.32348-3-amirmohammad.eftekhar@cispa.de/

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
