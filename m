Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4D3B27F5
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975346; cv=none; b=S8s1y36v7mCSMqGFt68KueMPjLHA0cMd+Ch5KHBXQBSrB1b6aG8J1AZQH7pw6eSUucLOudZXgiL0W7AwhlaxII2fLnDZ+htLBK+nNLyPD5cxVDeSgfZ0NFalHN5uUlbsJU8ccQw7ZhnHDnE5zXgRWyq0/pE0rzoDqATnWmpp6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975346; c=relaxed/simple;
	bh=gHfKiYTtT/v5kxFFXa+Lgrug1MCLcmb6/+mlODOy62w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L3cwwhE5pV2CVY0TSDAb3an9cMqfE3DnuQbe8q6zxGX20tIymBNXpSXiWGuLKJ2yHhWs2VroA9l+lxdoL7cJOpPE8TDl82FyqtbkAa0wFMavBA3kqKsnrVlNc0kRlY76FhiBFkVIENrL2YxHgfYHvcr2zB038LjIRU8wLipindU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUEWhT+7; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUEWhT+7"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e2e7425601so23016335ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975344; x=1791580144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0eJMRy6qOdNwpWsXDh5oL9sd7rvMCZHOPdz8rHjoIVs=;
        b=iUEWhT+7TsqC4240TZbJztTtSAQCJe8RDki27m+2oTVf8RxBcOlPl+oqrpO6YlMbeC
         l1Cgv8zKVZ5cp1TnSJCZpMaVJibFxuCyxMzr+T+K3FwriPIaeH4bUDtlqIRFy2gMs0F4
         wKJ4rBC+QWvvW0CG8mponwWMkzWvhs1YLpMI8GGDw9REFsGN4+lEzhy7iWVepG/NwtMw
         fZVac+u5i5WOFc5htNwcQBubFPXBOC7qQkP3Nm36JXk8Gr+coMZrMxwqGhqXqescw234
         OKhRw22t5iwuEZuZukGafFIO30fu5GlOKvn024Li8fM6GcLAc8YA/rhSkShx6zsEiQ7K
         LmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975344; x=1791580144;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eJMRy6qOdNwpWsXDh5oL9sd7rvMCZHOPdz8rHjoIVs=;
        b=GF73bV5oKTXS9Y2/zrZvSogBqnSyA+D/4dCBlNhMAYviYuT4bv/j8l377ZJtBn/rIe
         iok5aVeq5uxR7A5UTa54Lz9dXgijpWqZgZ95BpM+nFddxvoVuK7tIidtxrdPKTGcIff5
         z/cWziGCuU5phwU8owEOUjLnRxJ9GtJ42evLK118SPcjJ86C3PBrY+aCTUxDtQp3mOS+
         gMO9dYcI6qk95ETHFMFhPeAJv0b+MfeYtKkj6nUiaTzPzPkKg8idWBPHVpWb5UTL6J5E
         M2gYTSmb296kV3DfEvboCwpaR1VyfTxLka4Cc+V7vu56xj0jhUpFG0L0+aRSz3D8JzyJ
         J5ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcldOnCUHra7/ojaqMncwRacg9P8wXtUq/fDivpIh4vbeA4kkO3h8zklaFxa3X3VyQLqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYeykUisboksQcI0zYBAY+Z1jR+f6I56rjy9N/o/RUOpHIt7t7
	zWyftFid/K9wkl1wUjJvHNkGOJ1xuQsEm3Jj4r4aoLjVBWD4AiQSDUq8SVHL/CPoVRhT30YEFPt
	NlMMu7w==
X-Received: from plco20.prod.google.com ([2002:a17:902:e294:b0:2e2:bc36:1c7b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cece:b0:2e2:c94f:25f7
 with SMTP id d9443c01a7336-2e2ff90ba99mr44028515ad.5.1790975343900; Fri, 02
 Oct 2026 14:09:03 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:10 -0700
In-Reply-To: <20260916143310.1909993-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916143310.1909993-2-clopez@suse.de>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097470556.4068242.12181782174052908076.b4-ty@b4>
Subject: Re: [PATCH v3] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vipin Sharma <vipinsh@google.com>, 
	James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Sep 2026 16:33:11 +0200, Carlos L=C3=B3pez wrote:
> unaccount_nx_huge_page() unconditionally passes KVM_SHADOW_MMU to
> untrack_possible_nx_huge_page(), which is incorrect, particularly on
> the path from kvm_recover_nx_huge_pages(), which handles pages from
> both MMUs.
>=20
> Fix this by passing down the MMU type from the callers. Note that
> __kvm_mmu_prepare_zap_page() is only used for shadow MMU pages.
>=20
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages
      https://github.com/kvm-x86/linux/commit/31adfe155db6

--
https://github.com/kvm-x86/linux/tree/next
