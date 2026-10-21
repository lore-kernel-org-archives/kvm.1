Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556771;
	b=CQmZvNGGlY6wcqRYwKMba0EIICU4xfncdxhehlg2ywWAsu36ts73+fUvE22l6oNTdSh7
	 8qRnxxQD392gVd2kvqjCqhn0RtzzXnVap07yHaRr0//y6+I3WKneByvsr2MJ7Rvi9juW4
	 D2XETylosfHm3dtao20hxS5BLk8RabIbFbcXxtdGFfd842UYG2JWcnw3i9uh9y/Q0dHGG
	 o/GtgxRT8Eqlc/QVOGHSBDMsOvRwkUVacVYL0+iWWsfmdSk4FvwA2eB1HJE7LuSgzox7C
	 OW/9T6Uv+4Y6AdnWPrkyHzFu5z+d7vsAD9W8KgscRGVpT8juPwggDOb3g42EI9I1yIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=trCcIHaGJhYY0kngjCd9MduQGGuEpJETEp7g5qevHEU=;
	b=ri4PfG9/WgDZqtWAU03hBaztDaeqjF+Z0VMDyeSbZJB7ez567m1y1VY9KIFnCa8Un/tm
	 WTgZPqTC9eXfOcc/wq+p5lSLfFGGihdc1QO7u9I07fOBm9TTd1isdkz9xLPM4rP6vBa5p
	 K22cHe/SWYOdddSV+hO1GDwQaQQbsk00S8w6SdjqvHF3IYgULYV++JpjVANaElpbbwm55
	 6rpIabd1Vz0dmsGMPRD+AUVRhpKfjd0+TT6OXYKJfKiaf3c3eR4JAd2f4qeSxTyQctG6k
	 ZXxD+hdmHLqDafpOFJXU20FrvhBsR6UaHyi3EwlnGkBhwDXqWWV9hKKvsSFuZhEKLRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="iOfgR/iS";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D566606A326
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 04:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D566606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iOfgR/iS
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so253340a91.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792556770; x=1793161570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trCcIHaGJhYY0kngjCd9MduQGGuEpJETEp7g5qevHEU=;
        b=iOfgR/iSZDAAhqlXu0CirpwJTS9iEmx6hFp3LO/OXEaL9g1MMR7irBvyrk8nDrNA7W
         88+AkfQoKhDa+Kb50PacB9CpR11ACD/dxJ7NIFpqVY7PzGvkSOR0CH9DzhVrXAO7KQgp
         GG4g48zbMtRm7Qx5E/SuliRcQB8WKkPSn5q2REEb5tF8FUwNaU9qM+6roCzT7qqGX0+F
         J4KWNd7EFYQaTUDhv22805eis4FoXymMGWX2pfx8HjT2D9MDJGFkvoncluvHYEO/xQMW
         e0mIKMaBf1tXIzLkmpRVDy6TIMfvmQQqOu0ksYBdWzTijlR+akdvgjMliC7x/D19BIsM
         Ty0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792556770; x=1793161570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=trCcIHaGJhYY0kngjCd9MduQGGuEpJETEp7g5qevHEU=;
        b=UwXujyb9kxNAM3pnZ5vYNnRua3fFkyTdjtezosVBsQvDXlOmopkdTJiRVnOUClw0W4
         /f3DGT7waeRAdCsC8MMG/9hXKDZxEb+GY/ek+vuvIFLq7LDOThHVhkJBL5ZD5Zr240ej
         uHwIsRdisbdOlwhN1kBBT2sPficVN+B+nmG5JRTNRZc4OgGRWAu0GpKMBHup9lkyE1YR
         dSSb5dLXWHaQoPFByZCwBNoVntUd/pf2Hyw5OlkXZTpW2T0xuIaQuxtJqBoHRuHcf+DM
         VtvMkeIW7PPUfabGv3RlLdcTgvXSFdRjvKyIPzBkdfjkPii4Wug/7DDV+3yV5cFX1d9I
         rhJQ==
X-Gm-Message-State: AFq9FYI7XvQMg+/hjbXG6XrR1uJHaU7J0PqPOSzxCvDw3jVhDCiIqcPl
	e1Kwo3Eweo0Eu/MMvo0Eh6U4MISgurUDr7+OEAeAtxIrOTgT2yogXNNFCfLzGA==
X-Gm-Gg: AYBFou0Eb1ncYwG+qB3vYRiEMgpxm6zRLDT1V27M9CBtjmTqOEMbBCqwpbcfNMfG29S
	YGGEZEKjY85KEmhxhPHWif5mTLW651p9/3j+ToJ5UTBJpzVY2TFCQm1KesoAuSUBhfyysZelFs5
	bxVSJWWAzJxWmTZ3jT8AvfOEpMVA47rPpWwp5dY04ab3WNkEyg8dTC6T7ExHI5Zp82ZLHpd5aX8
	Kh3wsia4kqr5WGtbM6PGen8TIz1R/OCwBkONpEMn2brAaEP4eKejOaYu+OCzn6DhwUC0DX87384
	AN+NZivxD8iAwEZzBaWSyKQwgJ5qQJjYDnkXgJICiiQ6XwsFOVkk0Qqb8MANpcuC16HhdJZdTTD
	k5goalbvBXsCn4PYrdm9xUtIFB2nhBiDTLUVva8eXhDo953XLN6mItR/HMIJyjW4u74vpuRT+tt
	XTYu6rwQBhM75gR+uNw/ADO4mOXuOncoOtKXqOMFKNEmGoItdo234wvJLnzcr0Jh8H5+NTJ/LFM
	I8lVfuJ3wZ2h10DqfnqpjwUcugNrdTdfDpYFICfZW3kMyi+PeMojeA9B6vqN8Oov+74xJ905StC
	f1t2Nw6zu3TVG0zSnsZQ6VwKtOPMcvEldFed3jiampkQUvOdXlQ=
X-Received: by 2002:a17:90b:3b44:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3ad8709a59cmr981618a91.53.1792556770623;
        Tue, 20 Oct 2026 21:26:10 -0700 (PDT)
Received: from monk.. (border-p14.nat.sfu.ca. [192.75.244.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80219f83sm2355155a91.6.2026.10.20.21.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:26:10 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH 1/2] KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft INTn
Date: Tue, 20 Oct 2026 21:26:02 -0700
Message-ID: <20261021042603.608292-2-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021042603.608292-1-ma.mandourr@gmail.com>
References: <20261021042603.608292-1-ma.mandourr@gmail.com>
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

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

When a VM-Exit from L2 occurs while vectoring a software interrupt, write
the instruction length to vmcs12's VM-Exit instruction length field, as is
done for software exceptions, not to the VM-Entry instruction length field,
which belongs to L1.

Found with a differential testing harness for VMX isolation.

Fixes: 5f3d5799974b ("KVM: nVMX: Rework event injection and recovery")
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..302f5b5aa582 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4016,7 +4016,7 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 
 		if (vcpu->arch.interrupt.soft) {
 			idt_vectoring |= INTR_TYPE_SOFT_INTR;
-			vmcs12->vm_entry_instruction_len =
+			vmcs12->vm_exit_instruction_len =
 				vcpu->arch.event_exit_inst_len;
 		} else
 			idt_vectoring |= INTR_TYPE_EXT_INTR;
-- 
2.43.0

