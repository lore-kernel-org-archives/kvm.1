Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB832EEE8C
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854090; cv=none; b=ZOXprvRctvZ//Qcud3uvp2FNId3cjZuMlMph2QdIIwzdV3AZ/pQomiYjDLps416UNFTDjpU0PMUoVr75v5u4OTpmlln4sf53hjw28jopB+I7VG+ZrAlH1bIeRPOdo7/i5BRF8xLcw7bZ/jiOWile0Sjs3m7BRso01Hmg66jGjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854090; c=relaxed/simple;
	bh=Ax8Tp1KrZPx5xlSkcBsdWogHprGxL+uJksJ1bVSVzas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fIk2lKexgq99gzX8fjxsFkguyXlurOUKhdSHrWWP4oFnMWcfDrZBBIcHrD6LEEdWjb9UDiNJsfFNLv1GlfFg795B2NGWh/VmX8nDbxK03JMC2ckMxPWF5pPOW0YpT8RMllbZKbvizWoH6Ade4VF3h1F+bdWseZnT1owTQRJqf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ory6sm0k; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ory6sm0k"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cae455cf6dso19763145ad.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854089; x=1785458889; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iizTcAPrS3gcyVAqe3yTm9VHs8JAlHzgO7yvRefWb4w=;
        b=ory6sm0kvkUIlO3JoXGwEe1osEkqVF6PulzMo+lDhWQdKoSKEvuryz9va0ksth9Y+/
         LzYm9Q55o26TG4RIqaaUUpvmFi8L6dZCgA1OdVr+Kt5UKoHSbydeAM7QeVz63s6fwF64
         cpBo6DqSWcSoOAsuFtcGx/S6e40QC8uD/zFAdE9vqA7IqrlHhxXORS/v6W0QDgU8+94V
         +sw/LRetlgvOvnEZZZjMWC5yqQlzNcB4W23zC7G6GLxS+dMT+TG1C/IIjRGpdYWrTywR
         +tJS+a2ZL8+2oRDHGoEchD7eiGSI2lpG8kA3E2rFiuBNNAe7my7DJc3zzvFdJhC65nc4
         3ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854089; x=1785458889;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iizTcAPrS3gcyVAqe3yTm9VHs8JAlHzgO7yvRefWb4w=;
        b=LFatC9rVYWiokHZMab7a7D2ojfOh6MkYLmESFm3syFYGxyZep0jXMxrrXVDJQq8fzF
         6E7d4VBn60MMgr5/q3r9hh9iq6SWksokzDDieXwMbKsb4VdLkTjEXKgX+0PDy3rqI9Su
         JLlJ/ERRPqx87gOMz7sJBsx/LLRK2TSTQv9Hbq92PIM0WHVWyQuqCNx1Tbo2Wkl2N9vm
         VbBqRk5osgoeJVd70HUTbM9he29Oy8VSz8fof5B4wZLfZ7aASXODkVtXk1JlmzbZwdEx
         jqmlgU6VbHpmZhj7rlmgSoYi/ULyFQuK6wEyEO7MfGWiHwAjkxV0HhenyV1vt1YhteKx
         qJCg==
X-Forwarded-Encrypted: i=1; AHgh+Rrlyr7X48KL4QPzhn25zOiW5e0/kVkzTRUmX5zxlnmpAWHEt08N6hEYxAx1Wk3bjvchPAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJga0XRo2K9xJbbENQu02KRKVDQOkBlr6OOiCJE6dFlWwr9vq
	E9pLrbwTI1wx2G3Vx2Y87YGNtaTbEDuxMkr6dtzEQkAN5bgTMHTu8gvWlGcLmwDboBIFtRryw1I
	f26QVmA==
X-Received: from plblm14.prod.google.com ([2002:a17:903:298e:b0:2bc:838b:f23e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f681:b0:2c9:cf5d:d9bc
 with SMTP id d9443c01a7336-2cfa74b13famr65141725ad.35.1784854088680; Thu, 23
 Jul 2026 17:48:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:57 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-7-seanjc@google.com>
Subject: [PATCH 6/6] KVM: Harden kvm_vcpu_map() against double-mapping and
 thus leaking references
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that all on-stack maps use CLASS(kvm_vcpu_map_local), i.e. now that all
maps are zero-allocated, explicitly put any existing mappings/references
when establishing a new mapping to harden against KVM bugs leaking memory,
but yell loudly as the owner of the map is still ultimately responsible for
the lifecycle of the mapping.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2df8ee9ecf6c..e9e32686e41b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3118,6 +3118,9 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		.pin = true,
 	};
 
+	if (WARN_ON_ONCE(map->hva))
+		kvm_vcpu_unmap(vcpu, map);
+
 	map->pinned_page = NULL;
 	map->page = NULL;
 	map->hva = NULL;
-- 
2.55.0.229.g6434b31f56-goog

