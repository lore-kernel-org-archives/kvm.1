Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0644682C
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117045; cv=none; b=EXfxGMemXN3+1OdMDE5RiX7XoKnj1aVvCvqwLIGEbmND98KI+lkjrTmrEGXCp9ZsZCmScjS/V7sEcHjIoFKxk2wi6j/NS946Lz9z/smttQTcle+86q+jX4Eii3FWiyZfEUvf1VUb0oM2729Ilo6nX2/5F6e+2HHbdKLhSHuz+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117045; c=relaxed/simple;
	bh=b+FnOB6h8RtzA1+8kQxAsJvoJ4NjZWv6DaYELjThKD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HA0HdkEw3GldBjyEZ91Wme63fRfJIFcmV4zC1qIyJ7qzc8/RZtQvZ582tH6owwhAK01yxCCT/t6NSYeyaCh0sxXVDzR7VtvebR2NwFP2M8ZdeTynj+OGLREHYNtKwQKxSP5lDc3ZtoYGwukdhqmC1OcJ6wdlw4+/pPB7nIUiwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGAiBnEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGAiBnEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784117039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IqO2k5XGw/aA+6grnr++LS47pzPhKuzAye/Jeb/j4fo=;
	b=EGAiBnECxwncOI0AVnT7/JsPfyGyMl/VmrAXOWrLquUC5j5UWn1FpiVMrDdctP0s5hIVmc
	v1uYN7TNuf2b5EVVelW+35llf1GR9WlzUw9w5Kd8NH2oXKPR5dtRw/akH1bWUWL1nkfaKK
	8M28E8RPhRO3ym1uKRBxXZoHQ//6GLE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-V8hXv9cCOQ-gkvyL6KcAyA-1; Wed,
 15 Jul 2026 08:03:55 -0400
X-MC-Unique: V8hXv9cCOQ-gkvyL6KcAyA-1
X-Mimecast-MFC-AGG-ID: V8hXv9cCOQ-gkvyL6KcAyA_1784117034
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DB3B1956062;
	Wed, 15 Jul 2026 12:03:53 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C10911956089;
	Wed, 15 Jul 2026 12:03:49 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH] KVM: x86: Replace delivery mode TODO with WARN_ON_ONCE
Date: Wed, 15 Jul 2026 14:03:40 +0200
Message-ID: <20260715120341.2661873-1-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The default case in __apic_accept_irq() has carried a printk("TODO:
unsupported delivery mode") since the original LAPIC emulation was
introduced in commit 97222cc83163 ("KVM: Emulate local APIC in
kernel").

The switch now handles all eight delivery modes defined by the x86
architecture and is always constrained to the three-bit field
defined by the architecture: Either by masking with APIC_MODE_MASK,
by three-bit bitfield widths in the IOAPIC and MSI structs, or by
using APIC_DM_* constants directly.

Replace the unreachable printk with WARN_ON_ONCE(1) to match the
existing pattern for impossible defaults elsewhere in the same file.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 arch/x86/kvm/lapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..c775789dbdb3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1485,8 +1485,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 		break;
 
 	default:
-		printk(KERN_ERR "TODO: unsupported delivery mode %x\n",
-		       delivery_mode);
+		WARN_ON_ONCE(1);
 		break;
 	}
 	return result;
-- 
2.52.0

