Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2341A92F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054491; cv=none; b=oedsYkOLZ58tCmJBwTXTcZoXi0vlP1DBF0jL9vCc+Evy28pU6o1reFsLRFwl1w50iYvO/ux8Il+4dq6RqL7x/WhwX5fc76zmRRyTZiym1/UBenvuLH4CWRlqx9OiMTEYGEiUD0wkSaAJ/xLiJ3h2kr3CIiZ4U7joEH1ddfOGTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054491; c=relaxed/simple;
	bh=BkczJ2fUOIbtHXKSSnHvtqyxQ+/SxTC+TtwH8mBN+aY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=heopFjQr+6raY1OtnB1RycOglevg56RCrWYjA2NoY9GXxSp+nFz+pjO5GWUVVRO4B/1FnT1/NXYWhATslVwjz184Z/ZVOghd6y0daGqJwKS3E59IG7k+byhqx0T/Y+2i/54qf7WYDs4B0IfXzSDEp5XmYl4FDouS+imOACwXJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOFzus0R; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOFzus0R"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84a651759a2so59082b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054487; x=1784659287; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJ72AC02cMXEHNEYjRW7LHdYJI9uCNssUi5iCa6X4a4=;
        b=eOFzus0R93WuvmaXWPci9NW4QIxHp+qwXVI0lAom9wBfb30eEEioFtu2hvajaSRf2u
         CdZjqYJkjH5I9vFe6is71hTyhjG5a9EFg9IBX97cm17jv4bQsGmcMpCUqDrRUD9F2Zfi
         QYTlkiRrEjAhL0xW0cJiHqQWZjDKYX6zBRMt9MyAPp55+sHizux0IsiY7OM+mGQqbEtM
         qYRXQ7vpzc3yYWLrQkWzwK1KdqCGhMkAq53Iuq+SV+pRr6VrVXHmMEA5L2hTehMEKH/Q
         xNSl19rKhHXliUS2mAMSbQfjDJMsPPxWjrA4HPI8PsJMSK5KR+AAA2r7AjA6FBRNmOUD
         7uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054487; x=1784659287;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJ72AC02cMXEHNEYjRW7LHdYJI9uCNssUi5iCa6X4a4=;
        b=XmV6xwUC1EaY2Vusi/cbQn0v5ssE2RjjAD7HPYo5Pr7a6vlsFLJ8UapXRy2xKJ+8Tc
         vkl8yMjcczZlgeJIDGG42p0BNSnfaZLZgyHNISSnBWEs7CUTbtfGlQZe3POdpHg+3Jki
         zlkhnmOjcmuGi1mFrH/i28+oA4e1MA8QHmusFhSAZq6Og5sDG1SQnXA67WqxGtJQqvdM
         NL/VqOMtJH6gept78HlSbiV08PfZ2JabQsZUhcLy9PocmxicJd/Ay5/Mhs0rv07utuBj
         R7izHpSS1wgoZ4t9lieuKupJj7HWOkUvncFQjzClqCRo+Vn2pwoIhrJ1e59fuoZTgZRr
         wSAQ==
X-Gm-Message-State: AOJu0YxIdzUWRLo8SpqENXB8fGZkMR9yBpLFcfPet6vxocpZspDROIu8
	zHlsGrl6GlcpHSXFhOLdMfY6HP+EkpJG0JvueoN9d5HN04UjmNnczjujKrrtxarkwz+Nl3YCanO
	5sLaddw==
X-Received: from pfrh4.prod.google.com ([2002:aa7:9f44:0:b0:845:bd02:c4cd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21d2:b0:848:48e9:2ecb
 with SMTP id d2e1a72fcca58-84889600e32mr12853818b3a.10.1784054487068; Tue, 14
 Jul 2026 11:41:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:40:59 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405223763.3107547.15149893629683113824.b4-ty@google.com>
Subject: Re: [PATCH v4 00/18] KVM: SEV: Fix RMP #PF due to freeing in-use VMSA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 09 Jul 2026 13:49:30 -0700, Sean Christopherson wrote:
> Rework KVM's handling of guest-provided (and always guest_memfd-backed) VMSAs
> to forcefully reclaim VMSA pages when the pages are being freed from their
> backing gmem instance, e.g. in response to PUNCH_HOLE.  In the worst case
> scenario, marking the page SHARED in the RMP will fail due to the page being
> IN_USE, ultimately leading to RMP #PF violations due to guest_memfd freeing
> the memory back to the kernel while it's still assigned to a VM.
> 
> [...]

Applied 1-12 to kvm-x86 coco.  I'll send a v5 for the remaining changes.

[01/18] KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests
        https://github.com/kvm-x86/linux/commit/42a39ad5d592
[02/18] KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
        https://github.com/kvm-x86/linux/commit/0060569e4f18
[03/18] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
        https://github.com/kvm-x86/linux/commit/98ade8c48c28
[04/18] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y
        https://github.com/kvm-x86/linux/commit/01a96ff30dde
[05/18] KVM: x86: Serialize writes to disabled_quirks using kvm->lock
        https://github.com/kvm-x86/linux/commit/ba76b23ed36a
[06/18] KVM: x86: Ensure runtime reads of disabled_quirks are resolved once
        https://github.com/kvm-x86/linux/commit/ed15cb219992
[07/18] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
        https://github.com/kvm-x86/linux/commit/06d38eaa78fd
[08/18] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
        https://github.com/kvm-x86/linux/commit/b27622c4eeb1
[09/18] KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
        https://github.com/kvm-x86/linux/commit/db095727ff57
[10/18] KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped
        https://github.com/kvm-x86/linux/commit/d1a3c2162334
[11/18] KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid
        https://github.com/kvm-x86/linux/commit/98fb11aed12b
[12/18] KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
        https://github.com/kvm-x86/linux/commit/bfbf5fa51145

--
https://github.com/kvm-x86/linux/tree/next
