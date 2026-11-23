Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476409;
	b=o3YsWxkwwVhb+BeTjiR7zWYQ6+EU3ZK2Q7v3YE5DtTy8/tPnmdTwyheir4zOP8F9VnUP
	 VmCrk7hErGBSTvxMBz5sQJjRrIAec0ACq06UpLAtLRGs3hn9afG1348opyvR9Lda3A8LR
	 08eoTR6DNjUp6dyWw0ynBhjOuGXbBO3xWD0nmAa0x/xkzIeGrsWhSPNQLYSNkPPTdWp6b
	 kqZ6Mh4aaK1UXmjFvFVwQssK0727YIhAgdO9fMhk/HeT1heqEO+Y7PsSrJt2OgfD/QeBk
	 NLJA+krVUPHlTNAOQj7KIEgepzrpD9TAO4WvpzVzCTs4eA0cgwPeRrXMIP71bw5C67A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HseEX6n05FD1veyeX/WRfonp9sQvS52+uztmoZnoKtw=;
	b=zNoA9lAnWKxCDSJLrWdikasszMcQrVHyIdj36XBKFvr7ejACDdYDBj9g8ptnxwV3TJIE
	 q+o5t97KwwM5wolh6LXLBDcx2eQPzN71Nr+l0CdcenkTAjQol9cl/LyDVFK/2P3TyfY4q
	 MYicFavfnIJ4IQ1pAMV6mI6SmipyoUo8UcH+gnQE5U/4sUUJIweJvwilKv3pJxbb+7Wla
	 J6j9L+fAzOhG6W8H34E1iTu1SSaQIp34228x+xWOY9hym12utDk04+37q2ga1eIopBOc+
	 67scRryu4/nj2T4WoEhkYZ07dDq2HHl3Y3cO2jg38S7+Y2yQj5mVTpGKcbyJli0dD9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ca3pZyjL;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE2606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 23:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66BE2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ca3pZyjL
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-47d75bcf3ebso3141125fac.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795476408; x=1796081208; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HseEX6n05FD1veyeX/WRfonp9sQvS52+uztmoZnoKtw=;
        b=Ca3pZyjL0FOqCWQfm0o8D7LRJ+MD4P5v5fG5rIcPY3SGR5OZ8m+0zYUliN0gROgM6a
         Mrzbb+JUEquiLsCqGa05ey1cGd0U9BvpJuTr1c3Sif4mSglvlam7yv8dWMOkCtiSoTJ8
         dG8yqP4YN6zf45PlO4DasxdR+iGCjBOGi8/aF3xxLqZ8cGIAaQIeuJMAiS5wAnL+rUHk
         SNoFdLnkEJWkN8wv6ox+6/mI9ppPIwD3mFDwofj60+WWxRaRhdqR0ElHwyvkywcCfcgQ
         9a0P6dutcybkm71O28Z5ouHeV8j+e7jSO2Hrtfo7BY4m+6ARF+kHpZKGKl/Kgt09Pdva
         0iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476408; x=1796081208;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HseEX6n05FD1veyeX/WRfonp9sQvS52+uztmoZnoKtw=;
        b=W3Xwef+Bx6Vm99lobWMb6SP2+zFwlnf2a5UnOBpWrg3927+H5MmlGQanFTt+fyhffp
         oZO0k/SL2Hh80JOxho9+UzKT12SMgNAI8Ylo/nzzVdNOf0AWZ2vzOq57Tdl631ztw0j1
         1Uze7PR1pSQuI4fRVo33Zz6Bg2PP/NSzIRfJC3LDq4Vo0o6FBHqfaaBr3A5qmbvP4ykZ
         qrlrirsj5m6yowG2BwAk0gTQ4EdUQYzuBI7cHqUkJuYOSoPxFGbgprNILknlMlWnEcRJ
         eIGR1c1TWNdA+6gEPHZJBJ5HJVwGYSALpmlQ5zLFAUfIZx36XvZJL26+goKtCgG0tgWN
         4gRw==
X-Forwarded-Encrypted: i=1; AL+hErH6VluPmWcze9TrHZ2HYTkHBv3Qd5rcur6uZTBC4IC4Yf9RaDQQoCJ2S1/wxvUOHnrKLvM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EdAOE5JkKzkb/JxiTCA8J90xeq4UB4CfMntxjhGm+OKoLoYSP
	X408sfBj0sZuBg4w3ABWw9+xEez12VlUroVEO7XqlSzHe0zdPfTAhb2JP1Ew/qpdqordjFh6kzP
	YgmrJQnMhgkiRyahy9EDMKnMSrw==
X-Received: from ilbej20-n1.prod.google.com ([2002:a05:6e02:4e14:10b0:53c:d564:3a52])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c123:b0:4f5:e12:b47c with SMTP id 5614622812f47-57a0be9dc7amr11961032b6e.48.1795476408097;
 Mon, 23 Nov 2026 15:26:48 -0800 (PST)
Date: Mon, 23 Nov 2026 23:26:45 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261123232647.3733149-1-coltonlewis@google.com>
Subject: [PATCH v2 0/2] KVM: arm64: nv: Fix stale and duplicate guest S2
 tracking entries
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

When an L1 guest issues TLBI IPAS2E1 with a TTL hint smaller than the
actual mapping, KVM clears the entire block from the shadow stage-2
page table while leaving the stale tracking entry in guest_s2_mappings.
Patch 1 drops undersized TTL hints in compute_tlb_inval_range() and
falls through to the unhinted path so the unmap and tracking removal
cover the same range. This follows Marc's suggestion [2] on Dan
Carpenter's sub-page TTL patch [1] (which Patch 1 overlaps with and
subsumes), fixing WARN_ON(size & ~PAGE_MASK) on 16kB/64kB hosts as well.

Patch 2 avoids inserting identical duplicate entries in
kvm_record_guest_s2_mapping().

Tool-generated content:
- Initial bug discovery: automated LLM-assisted audit of the arm64
  nested stage-2 tracking code.
- Patch and text drafting: interactive Gemini session (patches, commit
  messages, and cover letter).

Changes since v1:
- Drop the kvm_remove_guest_s2_mappings() change; discard undersized TTL
  hints in compute_tlb_inval_range() and fall through to the unhinted
  path (Marc Zyngier).
- Split duplicate suppression in kvm_record_guest_s2_mapping() into a
  separate patch, call kfree() under guard(spinlock), and drop the Fixes
  tag (Wei-Lin Chang).
- Rewrite the commit messages and cover letter.

Link to v1: https://lore.kernel.org/r/20261119185105.626343-1-coltonlewis@google.com
[1] https://lore.kernel.org/r/20261123-inval_range-v1-1-815e15797089@pereq.eu
[2] https://lore.kernel.org/r/86h5h7zn5a.wl-maz@kernel.org

Colton Lewis (2):
  KVM: arm64: nv: Discard undersized TTL hints in
    compute_tlb_inval_range()
  KVM: arm64: nv: Avoid duplicate guest stage-2 mapping entries

 arch/arm64/kvm/nested.c | 105 ++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 21 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.839.g22a8290db9-goog

