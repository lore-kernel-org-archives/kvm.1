Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE743CB8E6
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523767; cv=none; b=Do5o0fstgogfIMAGLcXKb2Yyv6/R9Kat1nrOHLibV/TsQbn0hKTPE1I3eig7Km/P6zgF+23hrqhLY7H/cbwKW3ZAqP36YnNM7BWlCoirPIhYVnIHyofvI5wUqKE6Dwu5c17++5u0hB+PVgrZtAViLvFUVHATcuRnq1JCQppiwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523767; c=relaxed/simple;
	bh=zJ678JC2snIIRA4maFvCpXJiU+UVtktJqMGmQDCHqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DdOke0w6c1iuMB30fPXxLqrz2xCAmQ7Z4u5TzAZar0BenzEVyH8mXZHQMCDJJhVmKuaBk6EvDr1xugAWEDAzTe3nf4F9YST5hIKKn71BfrR5PQkW/q5b2ih6A9stB5uCOMaG0V/hocIZBDAOY4KV0HBvtT+RQ0lwRxiDaD19ZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U7prxdwq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U7prxdwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=vUI+cSCe2Cwg0B25ndo+e7WqPBukTiWy0lWi0ZiDeQs=;
	b=U7prxdwqwcTUkTRPDdAlMXx5QZqaUnY8HSxxqhBEgaTLFVV/pWaBrv27laoaAt
	EtWJDZlXI602GKUZb5cTRIbKXWnilfv4Y4tq8+G8FbftfzQE8MAkgIWhSpigj4wc
	+folxGjgXa7BVqBlWdb6jH6moRCPaDl8X859Wt2SV85o0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnY6FZMHxqUhgTPQ--.65426S2;
	Wed, 12 Aug 2026 16:35:37 +0800 (CST)
Date: Wed, 12 Aug 2026 16:35:35 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Message-ID: <anwwV80QWHxemrWS@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anwugm-oU0v1VM-t@192.168.1.215>
X-CM-TRANSID:_____wAnY6FZMHxqUhgTPQ--.65426S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW3Zr4xAFW3XrW7Aw1DWrg_yoWkAFc_Ww
	4xtws3XayrAr48Za1jkrW5Z34fJw4rGrWIqwn2gr4UtrWDtan8CayDWw4YqryfWFWUGrWD
	ZrWFgry5Xw47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUPEf3UUUUU==
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3Rrbzmp8MFpFAwAA3o

From: Hao Zhang <zhanghao1@kylinos.cn>

For edge-triggered interrupts, ioapic_set_irq() clears irr_delivered
before checking whether the new edge is a duplicate.  A duplicate edge
is then coalesced without being serviced, leaving the interrupt visible
in KVM_GET_IRQCHIP state even though the original interrupt was already
delivered.

Move the state update after the duplicate-edge check so duplicate edges
do not make a delivered interrupt appear pending during VM migration.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 24a7cc3b8b7e..676effd674f9 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -230,11 +230,11 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
 	old_irr = ioapic->irr;
 	ioapic->irr |= mask;
 	if (edge) {
-		ioapic->irr_delivered &= ~mask;
 		if (old_irr == ioapic->irr) {
 			ret = 0;
 			goto out;
 		}
+		ioapic->irr_delivered &= ~mask;
 	}
 
 	ret = ioapic_service(ioapic, irq, line_status);
-- 
2.15.0

