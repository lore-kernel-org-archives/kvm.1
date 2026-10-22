Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697892;
	b=GQkNsRv8X/356RlgIZk/Du9KDb5ARrI8vAUx+4gGtB+KQJWl+sSb9hrwHorrt7QLEHNS
	 bk79m5ErwCDQzPTq07PssxSTOxbuoBlQiJh2uRkykf9v7G77RoIdARo/xRf4DLyid1d+f
	 OntOLmFWOcvM6Jbmy+bcL1EeZovXiK5jXr57R14Fmzhj75bIHAWcRCt79jChQQE1QTElz
	 OMRx88QQNSnPNmkEmKgMjfCjapf3SxEN2akCJlp4OhSm9kDX31GNLEhFm1aTedG5s1pb0
	 16Iif/BW/qnKy571+efkVfgV8jJJUxIQUg3ZRnXMxHDjKmbgSPbH+rgu4uWcT0j53gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s+ssO7Yar1aCyDvBOVmuASAPwfzLrxD3Zbwb3zv4toA=;
	b=EVgJHe6q5I48lZIZiUGm03/jqCDecTE9z1SlsF+7igugZwZz607PcmRsU9H5MbxhUp1o
	 lBlz7LYWCtNFqGhelklQX3Bb89An/NETa12Tj30O75+OKMqQkviLdwy3J2OaJN/xZq9OL
	 tj7VdQCF0ePImqTv2RColgAtQKDPPCi/mf19292JBcVEPFcJkbkuEFjdHXwY+Tk7bgqmw
	 3fZruS5vZu8MatausOsq9X4DN9uwh8fsUXatn7v5nRranrdRY362/lg35rXeGSETEbxHt
	 5XWcs9SGYURPSouVM7iFUhbzLQCcT5BaSShV+OFN1+iiyPIVANhPUzdVdrJU/svQsCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Hvl9dGkG;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B460A2605
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B67B460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Hvl9dGkG
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac76132001so129869a91.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792697891; x=1793302691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+ssO7Yar1aCyDvBOVmuASAPwfzLrxD3Zbwb3zv4toA=;
        b=Hvl9dGkG/2/MbNqQqxsjecqdesrlzRt2BqCgag5GrcJrJdup45TesvJtpCfvZyr+Hv
         Pgtrs2PQeEu1MlGa54tLudDHH2sTvleozIY7hpwxkaVkGIJhCHAPDOE4xbmdD6NM/5FO
         fXiAutLAvrRnJ2B6eykGjdFni86N95p3aYBpbF9sYlKIjxB5Dom66JP4ANf67ryIZp7B
         iDv4EA47D4syfBiYggz3HWsh1Q7ZXe7PyJwLs6UrJweJMUXdv40aeU43hVMI5KbnnitV
         QSCslMMASLXgNPqdHcVDPW+VcWUxWWCUtQxmF45x2qpF1zSGip0hYoby2rhYOAzGO8l+
         QYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697891; x=1793302691;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s+ssO7Yar1aCyDvBOVmuASAPwfzLrxD3Zbwb3zv4toA=;
        b=gQ5y2p+pFox16i8JyGvDE1xZZX3HG4N0AM+QwVlX1NQc4xNoRkbf9UNggCVg/sAiv8
         yY78mDczpkuPM9DSNQ3jkF/VC10ZJxKW1hLXOjQFieEWgmI3QLmX15o3To/xJvaJNeSX
         S4V82b1bbr4Bp5Ezyj/p+yXfhFerdVmG3TiVwBiLKjNkbkOgBph/8vaZzJfwpg8LTDKZ
         lDuuzVFNmvPIBDBNJbI3UpbAnkiyiX0lIuCqvs2IbWYNXAdF9pbSFY9Rpibt8gfbICez
         NWA7dQ4Gx5Tk6usk9+Ht3Thv8ikzPRG9xSsP8omI2NSD9AK9m+OO312ALD0ykE+pwa+/
         2afQ==
X-Gm-Message-State: AFq9FYLDRB9gbCAUpSXF32xEmg1eyCozMob53sjuUtGzVXa9GFKoW1DC
	I223BwEoi6wEvZ2sRmXn5qU8YCykvDCQrlIK2cBoVSQLH5wz0ptC4nEMjxzdrUVMP+Lr7V5p2fp
	0QobC/Q==
X-Received: from pjbst3.prod.google.com ([2002:a17:90b:1fc3:b0:3ac:63e0:9609])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e4b:b0:3ab:2ad1:f10a
 with SMTP id 98e67ed59e1d1-3adcd7f6cacmr2249a91.0.1792697890904; Thu, 22 Oct
 2026 12:38:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 12:38:08 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022193808.557206-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Ratelimit all I/O APIC and local APIC kernel log messages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

Ratelimit all of the kernel messages in the APIC code, as every single one
can be triggered at will by the guest.

Opportunistically use the more modern APIs so that the messages are run
through pr_fmt(), i.e. get prefixed with KVM's name and info.

Fixes: 1fd4f2a5ed8f ("KVM: In-kernel I/O APIC model")
Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
Cc: Chris Mason <mason@kernel.org>
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Co-developed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[sean: smush everything into one patch]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/ioapic.c | 4 ++--
 arch/x86/kvm/lapic.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 0d59b9c758c2..df15d940181c 100644
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
index ecf611845fb1..a49bb38b4f70 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1123,7 +1123,7 @@ static void kvm_apic_disabled_lapic_found(struct kvm *kvm)
 {
 	if (!kvm->arch.disabled_lapic_found) {
 		kvm->arch.disabled_lapic_found = true;
-		pr_info("Disabled LAPIC found during irq injection\n");
+		pr_info_ratelimited("Disabled LAPIC found during irq injection\n");
 	}
 }
 
@@ -1359,7 +1359,7 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 
 	if (irq->dest_mode == APIC_DEST_PHYSICAL &&
 	    irq->dest_id == 0xff && kvm_lowest_prio_delivery(irq)) {
-		pr_info("apic: phys broadcast and lowest prio\n");
+		pr_info_ratelimited("apic: phys broadcast and lowest prio\n");
 		irq->delivery_mode = APIC_DM_FIXED;
 	}
 
@@ -1826,8 +1826,8 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 		memcpy(data, (char *)&result + alignment, len);
 		break;
 	default:
-		printk(KERN_ERR "Local APIC read with len = %x, "
-		       "should be 1,2, or 4 instead\n", len);
+		pr_err_ratelimited("Local APIC read with len = %x, should be 1,2, or 4 instead\n",
+				   len);
 		break;
 	}
 	return 0;

base-commit: 164405e8e9a0378c7e1aff2254625a6553a291f1
-- 
2.56.0.257.gf7497c7d27-goog

