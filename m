Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60C4EDCDF
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012692; cv=none; b=RmJ+hhNNsMpDi3U3JhZ9HdCP4dnOP29KJTyRj3UkC5+oe6+ggHyAO6WfYMMVNYKqJ04RySb5tB/7AoXC55Srid6GFcRYsbj8H13tKIFLCEZdnvyzfe+88TQnB0N3NxInysR7+1vZ/7H4dWGLuU4BzWYy7AC/RZt9VUIVaszvmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012692; c=relaxed/simple;
	bh=j8ssnULdPPzVZi4sm7QHZinEQxPvi5qB+JfHrPlZuss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gs+f/lViiJv2UznFv/dkeBAy/yHZqWbAISooFnyZWMqgfvsPndUT+b/NhjsdCPuyEiUDO9a9EXAdy+w0PHjR2oqCvKCUD7nt8/7vOGTG+Nl1hd6lrhcHsKPQ8a8U3k0gXlhmu2latpLUB7XGAzMj/4j74SE8JczN3UOg7xtOo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcYsIzqN; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcYsIzqN"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db87f759c5so62960915ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012690; x=1790617490; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hyb3zhkpLvcha2XPZl3y4VqrXuYFCx4NQzeWMijbr/g=;
        b=AcYsIzqNXuEWViGRHn5SQxdAdfLhJzMsFwrOWZTfw4AKks74XEiA7eaVf8yDY0AU4t
         FjvvBgOe7FvowqNv7fzKEuo+5gNV6Iff9va3tYFLEDV5flVyIFlYj0GNwTHolr2soTx/
         FmfV0mKurMPEN9aNE5WL/u5j9TsTlay05n/9OCCS+sOiM+ud9e1YyjhGtX4+WnhxovWg
         MJhS16lekyzIRgWSC9HghAXHbYKBqUu6ZdvX4+2i9PHX7SsPOEz1PfVlDa2hT2DysIbU
         pgZZ+ocxsg6Z8r9ZrIb5s2HwN5NHk7Kp4B88WFvX33bxiKwnCezGE4AK+nogrlVbyZ+A
         LjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012690; x=1790617490;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hyb3zhkpLvcha2XPZl3y4VqrXuYFCx4NQzeWMijbr/g=;
        b=esLTtqHFVsqndT+B5Kd7auDorTbzzqUM+90If7NCRP85OJN8leUd6rPZ6r56ZtBBTv
         AHMNYMyxR1jnq88QxkiEuf4jyWiEMkg0DKwYKc8k7zYSj+F/GN2ULD8FnL+zL9uL6x41
         ng7Z8O5Wd9Se1Qg7zLXkr8tW5dW1JwfZ0uQoEe95zYNP70RHojeUijPoLfVnk3Cj9YOe
         PH9amGxFd2T5P/7K1QIAU8QdjeOnZnCZsjcHIA0/NGx3LKIeax/JcblIo3a/KUCPRro/
         X4PstqU3zqcnO/VxYdpnGCdYnmeI1W8g8oKAAn6Vq/M/SCmdpcidvtjuEIBX2sIvEWGA
         nbjg==
X-Forwarded-Encrypted: i=1; AKwUvBxVeqbllkobRb8QaIcJph1/BwGzLMdfn5LNQ5EcZirlR7bN+sAkNEdcd4XwQasMfd3f47Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nXU5j5yWbnl5J4ZyhSxSIZHN3MrAEmkm2kxY0uJoeTsbouq6Nf
	YlJ1CZOjER288viUgOP0bOY9UEZvilc55C6jM9Ovc78nFIwBAhTcxilC4/v2S78NjaIjQL+xn27
	z0PPy1A==
X-Received: from plaq21.prod.google.com ([2002:a17:903:2055:b0:2dd:1daa:a60c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:2dd:c053:c207
 with SMTP id d9443c01a7336-2df560d81a4mr14415165ad.35.1790012689572; Mon, 21
 Sep 2026 10:44:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:40 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-3-seanjc@google.com>
Subject: [PATCH v2 2/7] KVM: arm64: vgic: Rely on vCPU creation check in
 "trylock all vCPUs"
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

Now that KVM's APIs for locking all vCPUs return -EBUSY if vCPU creation is
in-progress, drop the manual check for the same from vGIC creation, and
update the comments accordingly.

Note, while KVM arm64 guards many vGIC operations with its arch-specific
config_lock, holding kvm->lock is sufficient to guarantee a stable result
for "is vCPU creation in-progress".  So, no functional change intended.

Note #2, the open coded check in vgic_init() is racy when called without
kvm->lock held, e.g. via vgic_lazy_init().  I.e. that check needs to stay
open coded to avoid triggering a lockdep assert.  Whether or not the race
is "fine" is a problem for a different day.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/vgic/vgic-init.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 4012df6002ea..a58575df36e9 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -97,6 +97,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	/*
 	 *  - Acquiring the vCPU mutex for every *online* vCPU to prevent
 	 *    concurrent vCPU ioctls for vCPUs already visible to userspace.
+	 *    This also ensures KVM isn't in the middle of creating a vCPU,
+	 *    i.e. that there are no vCPUs that have been created but aren't
+	 *    yet fully online.
 	 */
 	ret = -EBUSY;
 	if (kvm_trylock_all_vcpus(kvm))
@@ -105,18 +108,11 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	/*
 	 *  - Taking the config_lock which protects VGIC data structures such
 	 *    as the per-vCPU arrays of private IRQs (SGIs, PPIs).
-	 */
-	mutex_lock(&kvm->arch.config_lock);
-
-	/*
-	 * - Bailing on the entire thing if a vCPU is in the middle of creation,
-	 *   dropped the kvm->lock, but hasn't reached kvm_arch_vcpu_create().
 	 *
 	 * The whole combination of this guarantees that no vCPU can get into
 	 * KVM with a VGIC configuration inconsistent with the VM's VGIC.
 	 */
-	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus))
-		goto out_unlock;
+	mutex_lock(&kvm->arch.config_lock);
 
 	if (irqchip_in_kernel(kvm)) {
 		ret = -EEXIST;
-- 
2.55.0.1082.g2b9226bbc0-goog

