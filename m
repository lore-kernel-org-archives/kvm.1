Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC33290C5;
	Sat, 17 Oct 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229434; cv=none; b=GsJgnwXvrFAyqUBiRM3ZqituCEUPdtWAhzpWuDYUUT1mbs1r+tCPm47mFaFwi8FHa/wApTKBNQtsl33YGEqi8NKoFyPjyM0B93670CNOc21tgG084RTu/jg08T+nvc/7E/JNbhPBvHTEfL5aejgniatGvxMpLMXuN38DnuZN6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229434; c=relaxed/simple;
	bh=u+yPXwKrMHV/Bhid6PUX7jowrohzauhaMEBJ0JWy2rg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fobv2kRyl7Mn7YWD/3CvkpuwasX1/XSEYGMBDiKdPdy87qy0rLzltXzdRR1UzZKRXE6MCKeM2kdhQCHahnfD9ea8vc6hTuu/nD9SXMkhlHv7vYFGjbMtlXLO/QFV+Nmxna168UY3zRIX8cMvxAqBwZq6wEtn86vHtp76ouWrPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=cHkAsZZI; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="cHkAsZZI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VFWszuUfKGg3JS6JsiQtIoOgHGO6FonucMo+NaSpcr8=; b=cHkAsZZINJEctaQL117orinM8B
	t0g9LPeF6c+7Fq2nBZAzdy7k5kxGOMtNNCMIy+WOjD2E36yxrSztvsd8lGKsmfOobQLig0LGrXSuq
	VDhY/Z4tSDK9RXi04YlO/eNKKG32+O6k69pSYgVSbZTyCS29cC27n6Au7VOGesw87wgXiwESISrm8
	DiIgcUpQRektA9k8QMbhO53FcQd948D863I24gL4nRt56jwLPQYavfhdRoaXWMa1di19/b8uyDXkm
	q66mD6eAAbfxEay+tpxl6dOul9Xhq45KzDOiyWr1+PyK0mHcZAD4uOYjDFygiUsdmyTfA+91yXyQd
	FqTaCodA==;
Received: from mailer.gwdg.de ([134.76.10.26]:45954)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kJ-00BAXU-2l;
	Sat, 17 Oct 2026 11:30:31 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kJ-000VXr-1R;
	Sat, 17 Oct 2026 11:30:31 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:30 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: x86: Ratelimit guest-triggerable IOAPIC/LAPIC log messages
Date: Sat, 17 Oct 2026 11:30:13 +0200
Message-ID: <20261017093016.32348-4-amirmohammad.eftekhar@cispa.de>
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

A guest can drive these kernel log writes at will -- the IOAPIC MMIO
read/write handlers log every access with an unsupported length, and the
LAPIC IRQ-delivery path logs each physical-broadcast lowest-priority IPI --
so a guest can flood the host dmesg/journal.  Use the _ratelimited()
variants, matching the ratelimited logging already used elsewhere in the
LAPIC.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/ioapic.c | 4 ++--
 arch/x86/kvm/lapic.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 0d59b9c75..df15d9401 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -647,7 +647,7 @@ static int ioapic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 		memcpy(val, (char *)&result, len);
 		break;
 	default:
-		printk(KERN_WARNING "ioapic: wrong length %d\n", len);
+		pr_warn_ratelimited("ioapic: wrong length %d\n", len);
 	}
 	return 0;
 }
@@ -672,7 +672,7 @@ static int ioapic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 		data = *(u8  *) val;
 		break;
 	default:
-		printk(KERN_WARNING "ioapic: Unsupported size %d\n", len);
+		pr_warn_ratelimited("ioapic: Unsupported size %d\n", len);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ecf611845..7d85a56b6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1359,7 +1359,7 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 
 	if (irq->dest_mode == APIC_DEST_PHYSICAL &&
 	    irq->dest_id == 0xff && kvm_lowest_prio_delivery(irq)) {
-		pr_info("apic: phys broadcast and lowest prio\n");
+		pr_info_ratelimited("apic: phys broadcast and lowest prio\n");
 		irq->delivery_mode = APIC_DM_FIXED;
 	}
 
-- 
2.54.0 (Apple Git-157)

