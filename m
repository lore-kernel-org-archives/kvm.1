Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0237C0F2
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647265; cv=none; b=SeV46Bg0TGh0BS9cpmaUdxK8tLv73YcsIDrssNUvlITTY5qQcScJBaICxgB6JzVXtPU5r4go9BHGUWEq0p+gnxkN0CVjzY9EERYEtDhxeuoMH3U8FfJGTwlk7bAww2gACl2sMj/e9N8M4HGAUENE++6FZWbuQUpJIOnM3k4pkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647265; c=relaxed/simple;
	bh=ssoFD0Svsq3mcDAn43BH2AH7Gt9nmgW3KWmnj9RyYNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFj0hrTMRLeef7bID5OM5U6It06Qq4c4QOklZ0dwEnKSGLU7bgh+VB+1A8CqKn5hutNbdJpTNF8QKNRTdoMCzyX+QluFVi6abifcIs9morbWaeifO9a7Zf9wmrPg3fhDYv+efsfWhNyqkPBCpxf5BxqbWwPnHf4mC34VerUVWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSK2Nfzm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSK2Nfzm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b150559bso24605115e9.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775647263; x=1776252063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdtS7V5NfnlJHyyAgLZSovPCgalgrvuuXizG5J0NjSU=;
        b=PSK2Nfzm/1h1W3TC2nfFwLVvB70Yp13XWlv/VRBsT/iQ7NlTJQR3rJG3qmbkMB2pCf
         5kLeu0i7CnTFfpREH6LAS+y6eiveRYq085LM0AHgQHmvcRJ3GqSb5SBRmAdddJ1KI422
         WfWU9U5oFRYZqhUnjMiCHBpcNigR0g6stxrdOE2cq7BUgQFetpUGS2oqYutKSXclZPh0
         dDfL53lKOCp6eFiVVezAefkWn5z6MmcRUCssiHllMnIVRS/RBrh7m4JyvUEe1/NgcQoj
         PD4OUSXIsIAUxb2oKN2EhCPaYvIKOeEWR7FcM61pWjH3q5F+HEVt7Gq9L15xK3SRAOcd
         RwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775647263; x=1776252063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdtS7V5NfnlJHyyAgLZSovPCgalgrvuuXizG5J0NjSU=;
        b=YZbA/PPM9oH9afU9ixREHRNCxb8qesFwfhKTa6YOBLhlpLw4tdnoysw607cHi2RZiy
         yreq7i9rDSXK3hcq9NLBNcegeNIFxufnSxGxlnGe7E+JNLsVB23EFmQ16hxlB4bPkw2e
         CNz8+MHJCDfFGtaFTpqxbTb8BJ/yYIj+3viPVirzCxlpX5saDtFgX82J1l98svxGtXkt
         29x/Jx36tLndyggJttaQHDWEZ4XpBBBnNa4fw5U0aYM8zUJlfuQPpZY1wMpvAZ8ezhYO
         vWwUmBUSsDxgDCqCgea94WU29tBPo78g7xWKhslJrmtY1jUyOAQGItv27zRb8ls4Kwk/
         r+iA==
X-Gm-Message-State: AOJu0YzqWVswsa4FpKHhvIc3TENgPAQFXabw4n0wkEClaebVJedqZcoO
	Bhp5dMf240/PUukl3QwPG+gow1e8qmtyUzZp1GUUN1kmexBffHaAGhEb
X-Gm-Gg: AeBDieu7ZSM8jLwK2Aig8ffUO4LfR7TrWeZyxnFcnrb21PhvbpNvn54UGa55C5hJMLr
	gOxYOBHIL9waVjdcjwRnvZsLO/AJDcad3mdJlBQokm3LJsi+FW1WmMrj6VLBuzUSivKr/wD/KoV
	NqLcspOEpC1QHRjWfFGos3XWpcPyevR5K/eVdSdTg0LAsoZPXeXQfEno+NPO3Tkajh0gwAxntst
	ngGnbUyGq6w5BkrYn4eyxF28G3E5zBMwk97pfD7vaDIP6F3LgHv/f9dkuNRaH6HGoHSfpwFiZuj
	lzB7drNvagT9eIQsY2NQJwA+exbGIY/AUp7geKe95c5GzkrCO3EndLjRuOmZdSxKJJyA7A0E0H3
	yndknaZR6D0cad32DbCOyNK5xyiI0XQsiquLhZJc1eWyRmDKkFIfZ3sH8vbTVCD4ZLTDyixDnsH
	TLydN1GODbtQfmlDXrFg==
X-Received: by 2002:a05:600c:5251:b0:488:c257:a73b with SMTP id 5b1f17b1804b1-488c257a952mr62046045e9.9.1775647262545;
        Wed, 08 Apr 2026 04:21:02 -0700 (PDT)
Received: from nuna ([154.160.21.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889cb46adcsm397011625e9.4.2026.04.08.04.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:21:02 -0700 (PDT)
From: punixcorn <ohyunwoods663@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under memory pressure
Date: Wed,  8 Apr 2026 11:21:13 +0000
Message-ID: <20260408112113.183989-1-ohyunwoods663@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408102914.106838-1-ohyunwoods663@gmail.com>
References: <20260408102914.106838-1-ohyunwoods663@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up with additional analysis from gdb.

The crash is at spte.h:263 in to_shadow_page(), not at the
tdp_mmu_alloc_sp() path as initially suspected.

  (gdb) list *(kvm_tdp_mmu_map+0x471)
  0x79451 is in kvm_tdp_mmu_map (mmu/spte.h:263)
  return (struct kvm_mmu_page *)page_private(page);

The crash location suggests page_private() is returning 0 for the
parent shadow page in tdp_mmu_init_child_sp(). The exact cause is
unclear. Sharing for maintainer review.

My earlier speculative fix (checking sp == NULL) was incorrect.
I am not familiar enough with the KVM MMU internals to propose a
correct fix. Sharing this in case it helps maintainers narrow down
the root cause.
