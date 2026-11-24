Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558579;
	b=FrSvHKjVEV+MtSAcBXOSCsHiwxJc9S4844Hstz1XQuiYaX1hh1ShG23LpxmX/zbXYSfW
	 cyrshfCYx9XSrtbS7WDs0GogbR8iJkeS5b2VQyAtMibntN84mDKmtsIda+Q3iDDBkaelI
	 fsGuEHCu1jjNz44Ner0uUA7gNqWfA2hjL06cmgo8BOKydd0uVEwblrrIiz94mg3pNRVWM
	 SVuxCHu3hJVqI9RGd2kVT4jUlstQMmnpBiytxgC1oUD9KbY/WCqCZbDN3ZjLpy7qtfsl9
	 NWj+fznrmmeISVBGGdybcDKQ6VoKiK73lXm4tP2bVxnlYmFA0yMQ0kmNXTGxIWcyQ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oIkNeebV3bBNTky3/G9aQsRRQo/i+uLeVgZIMqhznFQ=;
	b=Spzcv5ipUpt/2tP3d3AUNyeyw3xOQurnrOLYRKCbkEAnWajFkZR6VkkSVelrUymDrT8S
	 xV/0AYRdtRbmNBDsAjXWFcEI2dDGnfMi2qA9zQQo13bqLenwcEC9md5wXI78Cx8diAtcW
	 kDfPyzTiCM68OREjYzErBZVK8sXP0NR/2cxtfi0AP2LdtMLKDO7IKvLS/kbeBoBDV4RIT
	 7A8hQDnKq9R4NOqatrUdozwWEwR2MvkfUcw03bcxcanFRGXlEwtvpngmem0g41Oc8I259
	 UYY6Q3AWTF7/eEYNyguMzh4PvtuoA5xenWT8GlYrae+Zw8wYUxF0+57KtV8zgmuOcjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F+B4GdzA;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC03606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDC03606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F+B4GdzA
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab8b4887d4so3588596b6e.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 14:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795558578; x=1796163378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIkNeebV3bBNTky3/G9aQsRRQo/i+uLeVgZIMqhznFQ=;
        b=F+B4GdzAmM66lBpyh+fvByyg37qQYV9YEVLkPzVoqCbR+PKh1/Rt2lLToih8WyVjXV
         zafUeLcRBIyxkfYx3/G8LaIjl0Qx5i9ChPmFsyMKAKa9hfABmZqg4UksjPQuSLvWBCJ5
         VFXOmw+GY1LrJaX4XaBm88b0Hau0/efT9T/Rwp34AMszlRGsDntTIi4dol5aLw3+GWwI
         oEU0h81PrDuMhe6MepyfZ1Lf2nUBiChf++ruFdDUPknGEvj4FXmdpNUipkUuViO3cCjq
         MpBhZFZqwRz7nrFVJYEjATPW2su9TDlNXnGc5KZgY1YDJDPF9r5DYQRKFRva33Wdyq5I
         BzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795558578; x=1796163378;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIkNeebV3bBNTky3/G9aQsRRQo/i+uLeVgZIMqhznFQ=;
        b=0QxbJ8jR1YQXoRLqJ20eO3pcnOG+Xnr0Hq0/QMeTY6At0werz+ei5UzmkJHm2yxmvx
         R9kPx104dMTA2P6gHyYKn64iWW+f3XaHlEaOxLEd/GfqXUH0jSg3QiiXmxSSP/yrwLZR
         4Y0UnQzbv9xGN5K8ucrUFoWyMlsGocADo5MFxh9EpD52jEFfDS/SFaHFi8IMctHjzhLr
         1SgL2KDj0eEKtITb+wIPKgJvlFgC4qFBIaSz9Ucx9Yx8qYoezw+QL5UNnEN5+4E/RvOx
         cXlULAXXU/upNFBO82vMbJvG3iw8zw5Ji2nDz3MFeEqhCBdE1fEh2Iou6EDc1NW/gB59
         8Q1A==
X-Forwarded-Encrypted: i=1; AL+hErF9xNFxm/zIk6tyXD05U6MB+fZYK5JhpP4sj8nr9q/dDnNKsQeWdcsugCM/olFyyrMCssc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9w2uL0WmSeeGG0thx9faFPC9eye1FgYQMU1jjf2UXJ6NRxjOvy
	ehQbZlehZgagtkqMSZUP04zz3iyo303SaIgzHGDaFJiymh05Dx8bXZhN0nDwPyiNMjOO5SC/oUX
	OZ7qkDFpM8X+Lj6CLjVeqZyXaMw==
X-Received: from jaaq28.prod.google.com ([2002:a05:6638:c01c:b0:61d:1a3b:cb30])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:180e:b0:572:61c7:bee2 with SMTP id 5614622812f47-57a06a1a79bmr18783520b6e.1.1795558577535;
 Tue, 24 Nov 2026 14:16:17 -0800 (PST)
Date: Tue, 24 Nov 2026 22:16:16 +0000
In-Reply-To: <87a4my7yhg.wl-maz@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123232647.3733149-1-coltonlewis@google.com>
 <20261123232647.3733149-2-coltonlewis@google.com> <867bi2z87n.wl-maz@kernel.org>
 <20261124202215.3731849-1-coltonlewis@google.com> <87a4my7yhg.wl-maz@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124221616.4155034-1-coltonlewis@google.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Discard undersized TTL hints in compute_tlb_inval_range()
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Steffen Eiden <seiden@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Dan Carpenter <dan@pereq.eu>, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 20:42:19 +0000, Marc Zyngier <maz@kernel.org> wrote:
> On Tue, 24 Nov 2026 20:22:15 +0000,
> Colton Lewis <coltonlewis@google.com> wrote:
> > [1] only catches TTL hints smaller than host PAGE_SIZE. It does not
> > catch a hint that is >= PAGE_SIZE but smaller than the mapped block,
> > such as a 4kB L3 hint on a 2MB block on a 4kB host.
>
> Why do you think this makes *any* difference? The hint passed by the
> guest is utter bollocks, and the best thing would be to not invalidate
> anything. It's just too invasive to do elegantly.

Architecturally [1] is fine for the TLB, and before guest_s2_mappings
landed in v7.4-rc1 clearing the block was harmless. The problem with [1]
is a host memory leak in kvm_pgtable_stage2_unmap_tracked():

1. L2 faults in a 2MB block. kvm_s2_fault_map() installs a 2MB block PTE
   and kvm_record_guest_s2_mapping() inserts a 2MB
   struct kvm_guest_s2_mapping into both interval trees.
2. L1 runs TLBI IPAS2E1IS with a 4kB L3 TTL hint (4kB == PAGE_SIZE, so
   [1] returns 4kB).
3. kvm_pgtable_stage2_unmap(..., SZ_4K) clears the entire 2MB block PTE.
4. kvm_remove_guest_s2_mappings(..., SZ_4K) skips removing the 2MB entry
   because a 4kB range does not enclose it.
5. L2 touches the address again, faults because the PTE was cleared, and
   allocates another 2MB tracking entry.

Looping steps 2-5 lets an L1 guest leak one struct kvm_guest_s2_mapping
per iteration until a larger unmap or VM teardown (I measured 832kB of
slab_unreclaimable growth over 8192 iterations) and turns later TLBIs on
that range into linear walks under write_lock(&kvm->mmu_lock). Patch 2
avoids exact duplicates for the same (nested, canonical) pair, but
remapping the nested IPA to different canonical IPAs still leaves each
stale entry behind.

If you prefer not to touch compute_tlb_inval_range() beyond [1], another
option is keeping [1] as-is and dropping the cleared tracking entry in
kvm_remove_guest_s2_mappings() when a partial overlap leaves no valid
mapping beneath it (zero cost on valid hints).
