Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140246;
	b=3itFTfxLfM+/X7GLd/vvdp33jUGEaF+bEJDVC9ISAk8rOZrX2AyBYdvM0mDftI4bVv87
	 Yf4O7F+aSv2jfnS0O2sGroyxI7L7YVJ6MPQNXA60+WCLMSLOPs1X5g/aLGlzNKq/hVHrS
	 z92UpkgcCbyCljJ/iHLH3817iRRGPZPuWW2Bb+Of63rovCiL3izeSEY5DGBxHC0kpv5OX
	 b0h5bXMUlkANvN/GnGb2EMOD9qrKDC/GOr4RQRcqj5SyI4Ny0+tBLayIVYZNg5zzYZLmZ
	 4hCRyFxcOqTuHPEJmjfzdSdL5TR/8LrueoiyOPSc8JbxCgCWbqaq4UFz6hhnnql0isQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=lXjWY4taTu4hJv4bATl5d396acZLb9e/6END/2fvrmk=;
	b=pdI+m9z3TYPVLvUXgw9Wtrl2HHETMz/fiOZpTcl8p8cS0yV/vPV45DfgkfDTJbck+IwT
	 PISKddWdBaPErUCJpBIqKSFCAp9EP28DLTWEZCALE1bqVmgy7vqZVnfv+aoCW71pdsgxL
	 TdQ9tmEkEPDdpdw9Ph6KD6Dz9WXeGEtfJ5erkbxBf8c2P/BrnF6v/xL8vzkr/A58BvT8+
	 v/Cv9t5BSknvQ1y/T3pH3S6ZDDoc+qK+aJuNX/oq+4msyC8rUUsyGh67xZwW9Gh/6PIh5
	 e+GAbjg/PwYtWonPIOq32Q1ZaSGdDVAiZKSNAQB6mXmIYIX41KLBL6mjJSGWvnNL1mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Im/yoa3O";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A50606A333
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54A50606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Im/yoa3O
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so292783a91.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140246; x=1793745046; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lXjWY4taTu4hJv4bATl5d396acZLb9e/6END/2fvrmk=;
        b=Im/yoa3OlRfL/DkC21L/U7lpLIbVNakCyVQ1NEUJ6dNMP9Dd73MRwFb7JpRqUrMWXR
         okemdh72fE0WSiT47MG60utj6t3wyGsLxPlGXgaawTLsx7eO+uBb0Mif6MKOmVtlhzjk
         OdOgnKK6wZGcyKxHAAhEZmFmq8F7iqNTzBq6s7JEtRYgACU50ZR/vgOfV1ru1La/WWBv
         1aB4Q2b7noa/VJ4J+cyD6l84xs8JE8su/5Ao2rEUK75cKDyeJuveG1K/I7/Zp96uo0sS
         YXbEUfXwERMKJ09aPS2vnmj/tucv+T/JcEzodw6ZH5gSHotr5W9g6AkpFR+8/RhFIC0w
         wasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140246; x=1793745046;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXjWY4taTu4hJv4bATl5d396acZLb9e/6END/2fvrmk=;
        b=in1I9gOELmw73c7k98wUYiVk65aB8vYFDOayy1KL1Z9BHPgj9YsuAfL5G7JX7SpiuV
         r6s+q5qVxomtuk22bWcs+r1msmfw9DkENckJb7qLD/EbTwz0TTcjp39jX9y4rL/FlssI
         hbeZOIUCzyTbgBxNDzvwi4ckKkHWfl0F5OX7+U9I7YNtFxriP/XDYUc4++9CoLxBAORf
         RwA634+I6rxexiou14tvvm3SCaK0bq7IOjboWW92RsieqU8h3o9OiiefKZJx+aLFAMyc
         5l3GWBJ90qgi/qAHjwV/NaXpCTbKXMDYhFhDdcts5Z8MEMXQSQZyQwv/FVkdMhNXgnzq
         Q3FA==
X-Gm-Message-State: AFq9FYJSN6QxEnJNkNHz3DplmEZ47NpQVCghNsLBpz6Mgikgx4q0cV/v
	DJTpYLRcwJJZw5JPLvbT4RbCp2Doy5d1tJtRvWqHXyi3IZ/5deLb1v48Ek97fAU4r29H/LKwQIi
	IY+6NJQ==
X-Received: from pjbkb13.prod.google.com ([2002:a17:90a:e7cd:b0:3ab:d5d:f278])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:a09:b0:3ad:a270:a623
 with SMTP id 98e67ed59e1d1-3ae57e35220mr239679a91.4.1793140245550; Tue, 27
 Oct 2026 15:30:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:30:38 -0700
In-Reply-To: <20261027223038.1566931-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223038.1566931-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027223038.1566931-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: x86: Consolidate invocations of kvm_x86_ops.load_eoi_exitmap()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

Rework KVM's handling of EOI exit bitmap updates to consolidate the calls
to vendor code so that it's easier to see that the Hyper-V path is doing
the exact same thing, just with extra input to account for the SynIC
vectors.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0028d57e964a..483dac323c8e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8047,6 +8047,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inc_or_dec_irq_window_inhibit);
 
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
+	unsigned long *eoi_exit_bitmap = vcpu->arch.ioapic_handled_vectors;
+	DECLARE_BITMAP(__eoi_exit_bitmap, 256) __maybe_unused;
+
 	if (!kvm_apic_present(vcpu))
 		return;
 
@@ -8064,17 +8067,14 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_KVM_HYPERV
 	if (to_hv_vcpu(vcpu)) {
-		u64 eoi_exit_bitmap[4];
-
-		bitmap_or((ulong *)eoi_exit_bitmap,
+		bitmap_or(__eoi_exit_bitmap,
 			  vcpu->arch.ioapic_handled_vectors,
 			  to_hv_synic(vcpu)->vec_bitmap, 256);
-		kvm_x86_call(load_eoi_exitmap)(vcpu, eoi_exit_bitmap);
-		return;
+
+		eoi_exit_bitmap = __eoi_exit_bitmap;
 	}
 #endif
-	kvm_x86_call(load_eoi_exitmap)(
-		vcpu, (u64 *)vcpu->arch.ioapic_handled_vectors);
+	kvm_x86_call(load_eoi_exitmap)(vcpu, (u64 *)eoi_exit_bitmap);
 }
 
 void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
-- 
2.56.0.307.g5fe7bd680c-goog

