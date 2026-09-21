Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F9F4DAF90
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012689; cv=none; b=pRmuoEhEIpTMCbBDNQ/wwCdrrF167n/IH7jzWoWt63qzbn+Mtg7q4LA+ewj9i+ZmnufXTeWpsN6FfTQmaFeN04aUYD8MG6y3uzULlflG51rP0IgffoHpU8a+lZ3GVFXbQLoiEdlEBaZNe5KOrNInFxvsO9v8qViX6oXWoFKUs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012689; c=relaxed/simple;
	bh=q6sKknVxjsNpsOX3dGkf1KErMXo5zCoLn9mk28KTqNg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LokyAGQFa9flQkyhZw+/7lPzbM6ud9R+yTwnEj6lMRhxliPNZRzl8gh1jq9UXFB/l7XNwHrVbF6Mnwf6SgOzguepy8EdHlROAjMk20OsEQs3dcz3cOuTErE9V60NgGAn407z/KsfdJJf9EMpqgvTyCnnQhZo7z5TAYBaQoolUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLPkNLD5; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLPkNLD5"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8538a72b430so3494957b3a.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012687; x=1790617487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpZEGIou0oqWtJedTRzj6hNhUCCuK0pge9AESQcyXk4=;
        b=LLPkNLD5aBKgcdKDQjuV/lRYO5V4tfGAu4ftEBZcDk9xk1QIlxvsT53SA0VZ+C1Tns
         uDWqSN9ses49+gzu2UgL14dBG886qqnCbzO09YH1RZ1hdBemCNBkFOq5BsvURnpR4FPm
         uFYqqlBbOyuRRrcjdWCH+Q+Pu6Rpq5tvy1oOa6tBtQbG7X5xmOstoYyMq+0kBtAT/5Bt
         jvsBKyR2tsT3tV8Hz5PKWC3d+upLCtR7vRuw6Vh/1YO6/caIxKQtfeSkZ842kePYowLu
         Og3dFE6ezsVHOpze0wVhOy5ydCf6WkQa3AUPYsVlovhb3uMVNFDi9GJ50zzSA9xpf8aB
         r6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012687; x=1790617487;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vpZEGIou0oqWtJedTRzj6hNhUCCuK0pge9AESQcyXk4=;
        b=cY2DEe+E/H0eBcK0WDBAjMQ9wii2HfO99v3RQI0Z4UXj3Z0QjKqTK6xHJmw3adCoYA
         S3TV6mrUg5PpZfv1CTOj0Ipc/Cph8S6sW6c08efhjKLVK518DKZg3EsAQz4b4VdCxMWl
         zIgpAuiq5eR9n5gL0A7IJS5t2YTDVTS75xwTmNWAr9DQQ5JlKpAWxzUbEfY+wXEhYfsE
         wrKJ0sHCFP5sh/4jmEKGJIXkrO03DHD1lGMS01qo5pDtrjaob1ry0JBgO6/RqhVGwefb
         aDJnfDks9T2s51KCQQUBmQdkk1IV9ZTje0hzES0df9uKabcXm2HKiF2OMKzKw7x+V4sz
         9Y2A==
X-Forwarded-Encrypted: i=1; AKwUvByYirz0QdiF2mHpRx54rnT6IuqplGc5Jb9pDD7SlkEYy42IYqoA3ogjIxSyPpM2m5n5ZEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++khNgf2C/1QcGg05a0xtwzrDGdoI+gL3H6CBOwzpT45I8As3nG/
	dH/6DhU0L6cGwZ2DNwPY8r+b4Jj9lKvbiFvlDrp2yc8c4zpwdjtXHguELnnuIfmv493gpF0NVvo
	RV6PmDg==
X-Received: from pfbgs18.prod.google.com ([2002:a05:6a00:4d92:b0:87a:49f8:6a76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9487:b0:878:3507:8d6b
 with SMTP id d2e1a72fcca58-8783508a7bemr7870003b3a.50.1790012686945; Mon, 21
 Sep 2026 10:44:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-1-seanjc@google.com>
Subject: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids tracking
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

Serialize vCPU creation by holding kvm->lock for the entirety of
kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
possible").  I botched the math when justifying the vcpu_ids tracking; it's not
an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
"struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
something we want to do in general.

The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
does parallel vCPU creation.  As with so many things, KVM's current behavior is
the result of decades-old cruft, not intentional, deliberate design.

Patches 1-3 are a tangentially related cleanups and bug fixes; I included them
here because holding kvm->lock for all of vCPU creation allows WARNing if KVM
attempts to lock all vCPUs if vCPU creation is in-progress (the caller must
hold kvm->lock).

v2:
 - Tweak patch 1's changelog to clarify that that only x86's manual checks are
   dropped. [Sashiko]
 - Add patches to convert additional arm64 and RISC-V usage to 
   kvm_is_vcpu_creation_in_progress(). [Sashiko]
 - Remove acquisition of kvm->lock from s390 and PPC vCPU creation flows.
   [Christian, Sashiko]
 - Add Jean-Christophe's Tested-by to the revert.

v1: https://lore.kernel.org/all/20260914181223.289061-1-seanjc@google.com

Sean Christopherson (7):
  KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
  KVM: arm64: vgic: Rely on vCPU creation check in "trylock all vCPUs"
  KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress() instead of
    open-coded equivalent
  KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
  KVM: Move check for existing vCPU ID to the top of vCPU creation
  Revert "KVM: Check for duplicate vcpu_id as early as possible"
  KVM: WARN if vCPU creation is in-progress when locking all vCPUs

 arch/arm64/kvm/vgic/vgic-init.c | 12 ++++-------
 arch/powerpc/kvm/book3s_hv.c    |  2 --
 arch/riscv/kvm/aia_device.c     |  2 +-
 arch/s390/kvm/s390/s390.c       |  5 +----
 arch/x86/kvm/svm/sev.c          | 10 ----------
 arch/x86/kvm/vmx/tdx.c          |  5 -----
 include/linux/kvm_host.h        |  1 -
 virt/kvm/kvm_main.c             | 35 +++++++++++----------------------
 8 files changed, 17 insertions(+), 55 deletions(-)


base-commit: d599822bdb66aeec5ec76297b0fc6efaaeefe07c
-- 
2.55.0.1082.g2b9226bbc0-goog

