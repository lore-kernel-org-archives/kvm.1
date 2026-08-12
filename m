Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2423C1083
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523585; cv=none; b=rE4WGszE605qhi38Kg126UvSgv/dldKcgucXbaEV956ZRBzMEDOJx/ErIfNKAYTEZp2qIWD8kdhgSQ5VQw671TR95FWxXhw2mfxp6XEWvq/MavxZga5855Kn1F5zt93xex/5xCFTPv4Ktp/frBcAr0lcB2S4AMPK1Z3x0r+m/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523585; c=relaxed/simple;
	bh=jcbf4Q/ZCiHLtPboKt7yWBli351/l4gj9y58h7XFN2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Scuvaw0uqn/pBjn9Zm9A5IWlDue4spDtTQZbYjyvbkngUgn+OMa1c8EhUMcHaQx9H1V4tC8L0j2kVn5sIzDD3QPTM74cioW0W5L5+/+NXH3gBgT8RlQe2nkE3uPIHLbBjkpFQNEiz9Wuy54rF6rTmdpOLCar3UoHETLTrhhSnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QtcHJp5n; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QtcHJp5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZAuocx5o9n++Xk2ruFvdsesTtJNxAkYKQ9L7LRJC/7Y=;
	b=QtcHJp5nogv6UwxSdk27XkJfcOGNQgQH1gzP6KOl0hKn1wdH1BMc8FybylyDF1
	jEc9FyUy0Bo6G9VdyQpCOXO3EFgaviINm69mCPCf9EZWekElQ9pyCNvdwWXpRJHy
	Uk437NgvcDtpccq/tK0xy6wOszKMFIQWBjuEl2i9hqXf8=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXrcaeL3xquIjELw--.51318S2;
	Wed, 12 Aug 2026 16:32:30 +0800 (CST)
Date: Wed, 12 Aug 2026 16:32:28 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v5 1/6] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Message-ID: <anwvnBuFNqKBthtZ@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anwugm-oU0v1VM-t@192.168.1.215>
X-CM-TRANSID:PygvCgBXrcaeL3xquIjELw--.51318S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxKw1xtF4UJFyUKr15Arb_yoW8AFW5pF
	Z5CFsFgr4kGr1rGFWkJF4xAF98ur93ZrWfCr1Du39rAan09r9rXr1Iy340v34UWrWrAay5
	tF4Yvw1rWFWUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UonQUUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3h6sn2p8L54-KwAA3A

From: Hao Zhang <zhanghao1@kylinos.cn>

The I/O APIC sets remote_irr for level-triggered interrupts that have
been accepted by a local APIC and are waiting for an EOI.

ioapic_service() currently treats any non-zero return from
kvm_irq_delivery_to_apic() as successful delivery.  But negative return
values are failures, not successful delivery.  Setting remote_irr after
such a failed delivery leaves the pin blocked forever waiting for an EOI
that will never be generated.

The bug dates back to commit 4925663a079c ("KVM: Report IRQ injection
status to userspace."), which made ioapic_service() preserve and return
the delivery result, initialized the result to -1, but kept using
"ret != 0" as the condition for setting remote_irr.  As a result, any
negative delivery failure that reaches this path is incorrectly treated
as a delivered level-triggered interrupt.

Update remote_irr only when the delivery result is positive, i.e. when
at least one local APIC accepted the interrupt.

Fixes: 4925663a079c ("KVM: Report IRQ injection status to userspace.")
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 757667fb2bfa..24a7cc3b8b7e 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -491,7 +491,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
 	} else
 		ret = kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
 
-	if (ret && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
+	if (ret > 0 && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
 		entry->fields.remote_irr = 1;
 
 	return ret;
-- 
2.15.0

