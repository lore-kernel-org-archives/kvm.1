Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949780;
	b=18ExHAyG3gLNCXPBRhfv9SDKxyk3M+5EgRWwyisdd6yM0BDALdLmyBbVoUUezWEutUXq
	 HW+NWIWEaaOmb8A5H8k6Vq/XEETh+J0xpqZUjJZl8Um7p0Mg7JkYU+06fn6pNcCj0AaG3
	 IDBb9E8KyXkJYDifGX+htl71vFp68aXav1lWBYznwcvVVV2BoDRAH7F9Ly98gchHO99RU
	 VSvGJtBLIP/WSVn4etP541IC0/Bm2s6/O9g+4U0mQm06kebAznZBF4RrEjlteLrSk4zKV
	 avcH3sM0hn4bodFWqWHqFsRZLwWo+4lLqlyVKe7v8bHr/HsOlTQHMTUDyJ4eKCUPFsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TSeocec32IBSh6fCdKd/4qfk40BLitMNmtwIN48RAJc=;
	b=OEC2lTyvjhmIQJU/9B2A5ZY5vexkk7Qac4C1AFOnk9mb/ZvU3GvsTI8lcGLCD9xlHc9w
	 XklcRxYv3cOL45XDKzwxXdvjKY8Mi4USRfBhjmWqC9DPv/SnJSjWBHZs1zmFU02+efW88
	 ZWMKBV/NF1nXkFlMCrFaCtiWXHR3E84FzNUDpsjg4tvlOEEw8yVDVuZUPE2p2lR38rEaK
	 RpssUG92M9aFT9AWDZbUuZqgeqejuYTzyV1bjYNHX4H/WJbM13c2WYP57a6izwwRzh8k5
	 dXAkyOfOBagYgBlFsuYWSGvS0AK11EWcs2YAP+3CH81WlLSyH4xB/1cHy8DAczylqxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ctbi+PIJ;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6D606A88F
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C6D606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ctbi+PIJ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2efdd509c6bso2642765ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794949779; x=1795554579; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TSeocec32IBSh6fCdKd/4qfk40BLitMNmtwIN48RAJc=;
        b=ctbi+PIJcRKB3cJKB6GcS/EwyffItQUhR3Y7U4AkBKM/mW+aO493iwZtg/VZs8Esnj
         WhNwiiYKUSm1iddyFOesEyMC/Eyi4Jb/CcN/rPcd3DPE/2JyYS7LMyWHQ0DMT1lbF964
         V4mj9q4hlwjShrcRKagwpfuPCYckLoNYXrj6TLU6K42DAaTDoJhKJKcl3BSZjQGg6IoF
         143EKL7UBfJpKijwjY22s2Rnyy1GrkQP3OxGPkHe7jDax2l5LPhSlQXba79wSO7EN+q4
         85lY5Y0MS4X4q6+YwLtG/PSQChvgXrULOh/SYhY4kpyq4r8w0E1ZVdQFJicSykJ3kUX4
         C/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949779; x=1795554579;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TSeocec32IBSh6fCdKd/4qfk40BLitMNmtwIN48RAJc=;
        b=SXC1xUnGSujUwM93zIZXPecZvKEzbO//skXESjhxeSJ+xMqEW0IwbVqi/Gna7rRVPr
         4lOKyLyebXegfyY2qAVvPvAcSgo/TBjIU6ydps1XAtpv0ADTlVDoBJx4dEBfhDf618bJ
         JVEfVytY0m3nhzWwaLncJ2Mvkko5V7b2dQTLaqV94vUsqVpls+ofniFMeXUZiCv04OJt
         zE+nIS4+tGolv1DULS5vHG7Tf1PIw4XqYX/hjp3xH3uX3FbHLBrsqNh9h1/qcQmUIsdN
         DatkHRpSnyWUaQl+YPtjmSTwM1RzgxzpzCBcfI8hKGwGFHgnAPwpxyuzKH7w/lbebGEA
         pTgw==
X-Gm-Message-State: APuU4Z/J2FIlDCk109bXAvziD7m6r8pCdyIaAGUMxlIjCPi1H50LGEpq
	7Q0Iij1fItArOEIdRMWhm3al0KQzsGlVFhBlgdYm3zzicNI0U3CRk+EVBS8motsesCzGHjw0RJl
	JaGWNfQ==
X-Received: from plbnb14.prod.google.com ([2002:a17:903:15ce:b0:2e9:5442:b91a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c949:b0:2e9:5507:b532
 with SMTP id d9443c01a7336-2eff7529710mr4540185ad.43.1794949779247; Tue, 17
 Nov 2026 13:09:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 17 Nov 2026 13:09:32 -0800
In-Reply-To: <20261117210934.7765-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117210934.7765-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: nSVM: Mark CR3 as dirty when loading CR3 on
 nested transitions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Mark CR3 as dirty when loading CR3 on nested VMRUN and nested #VMEXIT, even
though svm_load_mmu_pgd() unconditionally updates vmcb.save.CR3, i.e. never
consumes the dirty bit.  This will allow deduplicating nearly-identical
code between nVMX and nSVM with respect to loading CR3.

Note, VMX consumes the dirty flag in kvm_mmu_new_pgd(), i.e. having nVMX
mark CR3 after the fact isn't a viable option.  Marking CR3 dirty in nVMX
code before invoking the to-be-common helper also isn't safe in general, as
it's theoretically possible KVM could observe+consume the dirty flag before
vcpu->arch.cr3 is updated (even though that's extremely unlikely to ever be
the case).

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a743179b172a..32f95c9d72be 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -725,6 +725,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	}
 
 	vcpu->arch.cr3 = cr3;
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
 
 	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
 	kvm_init_mmu(vcpu);
-- 
2.56.1.703.gf848ed807c-goog

