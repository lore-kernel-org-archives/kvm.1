Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476411;
	b=NooR25sTUYU9DRiBlo/b0QP/Cl43mwkf1XLDGKU0eqvoofctGswaQylAZefpJnhMxmFA
	 RCfvWGo/ofn6sbklvvKXtKrGPWPWUamorRJG8P/ChQnndcYdiqa+EQ80nl/u7bvgTztv4
	 +U6RhTIr5Qc6RXuNwkEAuRUOFQDd7uXCInnli3WbctymDhC+qbb2Dij11UY1hLedD+Jz1
	 ZhmxGlQlkAGj8bj01a0oGnOFYpFxoF17T5ysVg/tHDN9rIX2aZUV2cDm0lqg8ldR4IZRU
	 ofvkEDq2SDOIap9fwkTd6h2h0HF4GZYesEhBJ46otHQNN8/mz7gUN6WTaRfYSuH3LhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WJVCNKr0SmGP9iVV1suMI71pk9j/vqJGLO6NxitJm1w=;
	b=uGN8RUyUYA4AkiFBUHujwTQ7f7aIkZMBcFOCZSwutvlEYzO//e7T4gC8aqQeSiVP9dY8
	 tdAx5vB6yiFcuNJHOWHNI3A0Aq7wpb3AL4WHDZ+p1vo04pespEi65ERtLrI411Wqnt3Kp
	 ytTyDt744nwAHokJcfO6UD0Qrd2rAYRHs4vRhLZOvnCJdxdNsbrU4sKvS9spjhRjRmIct
	 IVUGlH88+a6/jdOHQ2izQLPl6IFNgOyPsariVX44uh/yCLATBbN/Vw+BlszTMS3rSwZcU
	 A0UnM1oXTPph/e/n9r0EhapXracbSkyb3adk9k89IMXXk+oRFV9AnZrWgYej8yPpi8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mL7u1xxj;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91A606A32E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 23:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B91A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mL7u1xxj
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-86313f7f4faso4323124a34.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795476410; x=1796081210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJVCNKr0SmGP9iVV1suMI71pk9j/vqJGLO6NxitJm1w=;
        b=mL7u1xxjS/naCmzkGxkyCocm2ufAKG5Fnw9ZYCSwPP4xqxmzaDjuS993Tgmrstx4/Z
         KxoxFjiviw4QwAWLK2JL70pUKFAxhOmS97cUixyXiGaeFodr0kZmRvZ7QqJXVR178pl4
         zxC6JeMwpkgi/a3a3pUYvPJTxoJaJMGwMdoFD7psMdW1SH0M7UnGaIPj7BJg1phl1Yky
         c58ZJNVECUn4Wg5gEAX2+Exr0RCVX6gYe4Yb9zDU9k5IaMFwLdsqfCOX1K7Z5MTmfOej
         WCz89uxVm1w6eBD4X1zTyVNkpDOPv7a4ohBb1f9CJdeGMmIKyTC/74oPJ4DMxf5JhbrE
         XwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476410; x=1796081210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WJVCNKr0SmGP9iVV1suMI71pk9j/vqJGLO6NxitJm1w=;
        b=MBQkkkA69Rwk1wN8ufIcn5UOSgtWpR3maF241007fl6e//FXHpI6sYPlk8hqHSXfTm
         zwqh8bV336nI0VV+oo7Rq+HXeDK+qjTwli6xCxkVh5PwQT4uHTuSkQLyvdwYzeStwS+f
         NcnK/XwJezkeVnYj5pccSVDSOZHRB3msMesZIuf0CF/cmqEuqhl5DzGab60yEaigc+rA
         dTwjpHI/CGHFBffd9KGJrcG4ulMPKehinT2jrIGvhJlmsV8cfCPnqwUtvxO4psWKAxV2
         QHxQbScsVy6NsJHzC06pF4sAUQWf4yR7jThd/PJ37b/mQbKZnxVWlwqO/Mrk43GhMJcz
         LLtw==
X-Forwarded-Encrypted: i=1; AL+hErGTLUYGKLsULuHXvNBQgO+c3ZQ9MScCJCziMDPP8ifcYw98QpL6hAFgW22gTHPMxEFMm1U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ou9FkNLWMuwzZ4GEb4GR0RpNrooCHDEeN8bqO15i/y7gqJz9k
	0LY+SkYcZauhpT9wkbntsH2k11Gae8Wx7qDphLSDtL9gJgCty/3plN7GsnbhOk1bZjEoyKs++co
	jOO43pwKgZa5bJ8a62NKVnSKsIw==
X-Received: from iohk21-n1.prod.google.com ([2002:a05:6602:a615:10b0:9e8:de6c:a5a3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1645:b0:567:c9d6:b2b2 with SMTP id 5614622812f47-57a0c3aa32emr13284763b6e.47.1795476409974;
 Mon, 23 Nov 2026 15:26:49 -0800 (PST)
Date: Mon, 23 Nov 2026 23:26:47 +0000
In-Reply-To: <20261123232647.3733149-1-coltonlewis@google.com>
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
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261123232647.3733149-3-coltonlewis@google.com>
Subject: [PATCH v2 2/2] KVM: arm64: nv: Avoid duplicate guest stage-2 mapping entries
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Dan Carpenter <dan@pereq.eu>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kvm_record_guest_s2_mapping() unconditionally inserts a new entry into
both guest_s2_mappings interval trees. Parallel stage-2 faults on the
same IPA or retries after -EAGAIN can therefore insert identical
entries for the same nested and canonical IPA range.

Check mmu->guest_s2_mappings under guest_s2_tracking_lock before
inserting, and free the new entry if an identical one is already
present.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/nested.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index d3a19b1db2144..18868e0d701c0 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -930,6 +930,30 @@ static unsigned long s2_mapping_to_nested_start(struct kvm_guest_s2_mapping *map
 	return mapping->nested.start & ~S2_MMU_IDX_MASK;
 }
 
+static bool guest_s2_mapping_exists(struct kvm_s2_mmu *mmu,
+				    struct kvm_guest_s2_mapping *mapping)
+{
+	struct interval_tree_node *node;
+
+	for (node = interval_tree_iter_first(&mmu->guest_s2_mappings,
+					     mapping->nested.start,
+					     mapping->nested.last);
+	     node;
+	     node = interval_tree_iter_next(node, mapping->nested.start,
+					    mapping->nested.last)) {
+		struct kvm_guest_s2_mapping *curr;
+
+		curr = container_of(node, struct kvm_guest_s2_mapping, nested);
+		if (curr->nested.start == mapping->nested.start &&
+		    curr->nested.last == mapping->nested.last &&
+		    curr->canonical.start == mapping->canonical.start &&
+		    curr->canonical.last == mapping->canonical.last)
+			return true;
+	}
+
+	return false;
+}
+
 void kvm_record_guest_s2_mapping(struct kvm_s2_mmu *mmu, gpa_t canonical_ipa,
 				 gpa_t nested_ipa, size_t map_size,
 				 struct kvm_guest_s2_mapping *mapping)
@@ -950,6 +974,11 @@ void kvm_record_guest_s2_mapping(struct kvm_s2_mmu *mmu, gpa_t canonical_ipa,
 	tag_s2_mapping_mmu(mapping, mmu);
 
 	guard(spinlock)(&kvm->arch.guest_s2_tracking_lock);
+	if (guest_s2_mapping_exists(mmu, mapping)) {
+		kfree(mapping);
+		return;
+	}
+
 	interval_tree_insert(&mapping->nested, &mmu->guest_s2_mappings);
 	interval_tree_insert(&mapping->canonical, &kvm->arch.mmu.guest_s2_mappings);
 }
-- 
2.56.1.839.g22a8290db9-goog

