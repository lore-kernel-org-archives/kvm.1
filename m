Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551737;
	b=ZjqLUT+nK834YWhGD6xfPMH+17pW+ImX/GYtFF2ezFGxkdQ55X8Rd5uxIQxqM8nns+Jm
	 NkK5NqOkh+KNxyKgrZ1sJ/JwI65JTj5D+yA/tlkYl8GdDyZXHVjuhm94hdlKQP84L3jLS
	 +Al9GfB2KF6SCwPtvg74gMdYB1mXpU7ff1v8tmVeUg0zLLBF4J3GHstgP2l6k0gVdOP4o
	 gNfeLDRIFnqMhrX8SxrOmdpXrdSBVgzhC895lmaMNXtnz8LPblP3NfEmtcQU2w3cE618N
	 YKLUmobO+2qr6CA5t2h6Ezxclpk2Tj3WimK9yktAz2m+elt9OZGfAAiccL3wBPmoN+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=F1guWKqhMIdnhcOOY/GSOXPqYFIOugPZ2YwxBRVxVK0=;
	b=st5nMQgeu0wm1LtH2RjXQU8dfi+kMgGyHI26epq4f+b+Rtjfq/V/vouTJq8UnAU2gnsY
	 ppx2730MDp+oMg+YRFfmjuR7tiz7JfAjqCX1IK+Xkqejuux6NYEYlve3vggIYJe4937h0
	 SQd6+J+quZ8VB8OqCmKZ/H710Befgyq9/cDsu5meRAFz+SIjULSVMCME54haY2uB4yI6N
	 nkp4nIqt1acL5qowWe77DMUNA9F61RgJBFWRKmq6i/TNaX7r0oJjWfm8ac0ILVK3SJ/Wa
	 EETKLSZGwOD5SZZpxecoxqFHr4xyG2V7EgiCTYLAi50QvGtkDuKx2pO9eBdud7njsxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NOnmOw+n;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF609606A323
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 20:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF609606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NOnmOw+n
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ea2c058e67so5530816b6e.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795551736; x=1796156536; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1guWKqhMIdnhcOOY/GSOXPqYFIOugPZ2YwxBRVxVK0=;
        b=NOnmOw+nVRIN9hiqE0Y5pZ7cCrhcN2J1I+E4P7h0lmgkex0uGCPx/5PkRpOYlB9F9X
         y5MJ/mDK63tgXQvAmngXTX6BzVkyI/6H3AyP0wpbgY4YGtxUBTldW1nWz+nCA+VO5GZD
         9mGZmVqstIxuGc8F6QI+ja3vAwmCHy8M67axodiKRB6yUtd/BrFZc4FVFQz02GXj1WnQ
         guG/DyQvJgrVVMMvodYvqnSvUGp45Hd0aKNp/Osn8BTEjuyISDrTcGPrbVc9+QLXDCw3
         wofxSkGBQCqWQkgVfJzlQWwE+kkbRl7Ajur2QOU8qLgG/4/PKm/MEbpX3mAFL0y3BlOn
         KVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551736; x=1796156536;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1guWKqhMIdnhcOOY/GSOXPqYFIOugPZ2YwxBRVxVK0=;
        b=M+usKwRKrSBDVNZp9IGY2SErBkXqFQMJF4sAigKNH+Zp2SctZ1of49bxo7gHXGGEyR
         aa/QRVSc71kxNx+3aylG8xyTvpWW+5LpvGUZ1p6PkQUizXwVayfCM5neHlvSz6yUOY3p
         ukPW1XpNO780w2+MRDiKs9ijDOi46h6a29LeZVqEXDTelEaouQeHwlXXXFsZySUcaoCG
         NDC6yBxvIJ/cAVop7MWqOfbcYcySWH4iMpPv0FhYSL4lr8Yta3Afw59/RLWbS3LqjFA5
         6IwdB3kHuThWUkb/ZsZPBjH2iIcmrd2b08LDQJmLV+1c8eljT5ZKS+QU0XnqIwwRfE9/
         69lw==
X-Forwarded-Encrypted: i=1; AL+hErF7Q8KCrs2OuV7+LxZgiXgL1LRRapSDeqtQAbvWvW2wWPPlN6SxTjuTgcv6QKo2o7esD20=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5U/JivLekZO7mtNcdgOqiNJd8WhNnPCQ9IODNAelf8y0foQ+c
	j682Po3rd1h59nNNVJowzoD06o7V7T14wIkI2oUh31pRAwFTrAYAcztmxyNLRW83vPbvlfByH3p
	gX9DfjAOq8Lo4cMyUJ9St4y4R6A==
X-Received: from ilmw6.prod.google.com ([2002:a92:d606:0:b0:53d:20f2:6884])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:e8c:b0:4f3:e98f:fa27 with SMTP id 5614622812f47-57a09c1107cmr18109738b6e.16.1795551735576;
 Tue, 24 Nov 2026 12:22:15 -0800 (PST)
Date: Tue, 24 Nov 2026 20:22:15 +0000
In-Reply-To: <867bi2z87n.wl-maz@kernel.org>
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
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124202215.3731849-1-coltonlewis@google.com>
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

On Tue, 24 Nov 2026 13:10:04 +0000, Marc Zyngier <maz@kernel.org> wrote:
> What's the advantage doing all this dance over the patch proposed at
> [1]?
>
> 	M.
>
> [1] https://lore.kernel.org/all/20261123182312.4842-1-maz@kernel.org/

[1] only catches TTL hints smaller than host PAGE_SIZE. It does not
catch a hint that is >= PAGE_SIZE but smaller than the mapped block,
such as a 4kB L3 hint on a 2MB block on a 4kB host.

I can rebase on top of [1] so it goes to stable on its own. Following
the same pattern, compute_tlb_inval_range() can check
mmu->guest_s2_mappings at addr for an entry larger than max_size and
clear it to 0 to use the maximum-extent fallback, dropping the extra
page-table walk and KVM_NV_GUEST_MAP_SZ check. Would that work for v3?
