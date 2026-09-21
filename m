Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D14EF133
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012693; cv=none; b=SP4njvx1+vpEfkK+XjKCwUdV8AlFf1dlK3MmoSC2TaIhZgwat+dB9V4IQOyctLO0d9eitHWKZ5KRTwbYwKGnLBmKy85tWyeVszacmqCQr94SFulP+D6oBsuiym+PwBeS4Ndkw30AFyJdudGWF31uRnKvyLZBnK+0sn2SaK9FLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012693; c=relaxed/simple;
	bh=CNhibckm2761zC3hAPFvim0N4m7lGBRenE1P2zWSHJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FWzW30eFTzLzoULfWSPY144IyoNCznaZB81Jxx6mmJCcwX9McNcA+1tHFoa3PRoTcUUSH0/LHhljBxLmjzFijQD7VDoCB8p02GErLhidLJvSTKJDFA36/MxrNmTicq+7M7VJ5XP2Mbs8TJRTa1RDJDOqlg0scpKqU/gQmyhtNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb3voCAv; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb3voCAv"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso2938902a12.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012691; x=1790617491; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y4bAp3nBUO90ZQn1u2Z0gOxXpoxTWghtyWO5GBrBpXE=;
        b=Bb3voCAvMKzhwNJByrAcASRMJyiOXpR93gIZxKodAPUtwCo0aIyHa70Q35Ucc0nE4i
         iNmDPAiOtNcOav8gJOUfTfkrRTBn+/66Xg5JfZl9SqI0aPElHPQ5ok/mEjlqosh1CJo+
         GLdI8aa2D4w6eBXvLcFFUZ1aSDUk0ra42I+qlvnBWAD+3qMK+EFmK5C4D7ao6CmTTl3z
         S8Q4bjzQE9M86aRsJow9qkOs7VW91RldTmMUkt03cJWn0IY4R2Do/heZ7l3eftXsBnZe
         PU3FnPar7xV9cUpbbAlph3EldG6iVaCpd8BrOL6Rc9MM/kG5TdGG4MeL7ZY66u1ikqJB
         4VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012691; x=1790617491;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4bAp3nBUO90ZQn1u2Z0gOxXpoxTWghtyWO5GBrBpXE=;
        b=KN91Gw04KksSsgeuv+oVCa4XH3JgIA7jYCJagqkv0oRCNXBK+9SlV2vOQmCOvY0tAt
         iiUaVN55hJwer+WycLOO2Yg7AhKDa/wEx4mWSiJs/ZI+HVcIpPbf42pBJ7ypyxLFYGCs
         zJA9orL7c2sQiRf8KZFpc3Qf4z0907TlV8rabIeyX1hzL9dPrOHa6PTZXOekPDck3BDN
         OH4hpnC8ehNH5MEy4/DjeSp/etudxVBrn93hMqkskafftjOJ9jtq+6FhXEfDvpgBm5pL
         qIJTB2EBCbZ24Gh6Rt9uYkWuwIEGrhHnV+hp44Yt7f5/dvzyVYQaWeCteDxplOstx2Sr
         aVag==
X-Forwarded-Encrypted: i=1; AKwUvBz+zdw1F9n/7MOv/0mfJITcIeSV5QEXRI5riH+NS2LOE1oRFBn6PZqiS14VmAOl3ZrRCb4=@vger.kernel.org
X-Gm-Message-State: AFuF++kHQ4RdF/sceyAmB96No/rHwkI8wEzpexGbHXOFUFdSc5tVRza7
	N7lfzFOU49bLn7PH8BkG7BMK+79/yoCL77lFQx6OigWz/X67joo+0KBdSmo5OuOwvzUXA7UhrJU
	xzXsceA==
X-Received: from pgvn10.prod.google.com ([2002:a65:63ca:0:b0:cc4:5907:21e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b81:b0:3cd:8bba:824f
 with SMTP id adf61e73a8af0-3dd8c3d3acfmr19085095637.4.1790012690700; Mon, 21
 Sep 2026 10:44:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:41 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-4-seanjc@google.com>
Subject: [PATCH v2 3/7] KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress()
 instead of open-coded equivalent
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use kvm_is_vcpu_creation_in_progress() instead of an open-coded equivalent
during AIA initialization.  Unlike similar vGIC code in arm64, the relevant
RISC-V code runs under kvm->lock, i.e. can use the standard API without
hitting lockdep false positive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/riscv/kvm/aia_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index efc7c0bcfba9..97833a04268a 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -237,7 +237,7 @@ static int aia_init(struct kvm *kvm)
 		return -EBUSY;
 
 	/* We might be in the middle of creating a VCPU? */
-	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus))
+	if (kvm_is_vcpu_creation_in_progress(kvm))
 		return -EBUSY;
 
 	/* Number of sources should be less than or equals number of IDs */
-- 
2.55.0.1082.g2b9226bbc0-goog

