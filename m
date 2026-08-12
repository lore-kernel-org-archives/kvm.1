Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03394052D0
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570335; cv=none; b=aWxH3CLb/rl7wapT6PipUgra8OrGguWvNrMIfFsF/bszXzojK4vZfJxIlYF5V+4GjniJbER5A6rfcHfNdAssreK3G4jizv6GxnAMfuihgVNZvR0Ngjym8olb4nzXIzqKuDVj+wJGNPxVNywrmAgO1WUnTxJaj/qRybNk1CwJy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570335; c=relaxed/simple;
	bh=gbqNX5Vcm+23PVtL4LoCV4m6QUp9W+kJKSULPJUxtGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6Y8AjhcQK+fDLGorx3i9LLWVgcHBKFXzgZH+sibOUV3qMi4sulN0FVrc30kDIWi5O3j//7YTyKGKinGivFziKk91uMevyOo5m+nYf8Q4lA4C1ISPypDmHJwBuCUUQ0j5SWD7u6SwBuuvWdEvSw2bzr6ZJnwv5hihWHrNhdACEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFp5wAnd; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFp5wAnd"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848544a8496so1597899b3a.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570333; x=1787175133; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ckWI6BtaRIbrrJbimDwPi28hAKgKft3eRwUm1isRRjw=;
        b=QFp5wAndPjM0O+g90zO7utg/giWWpfTtuzzqv9z3BZRAT5rbaHFrG7aylGBCvvHq/l
         w1IsrbaVWUCfVsH7BMLe3rBclhnQdz8+mbz9Uc3S0GnPfbh3tbt3pTbsukLvJjAhrQau
         tgnydD6o3kuA//pDf4wjdOYbG9tc1HCG2XSu7dWBueK+jsqxHwlUQHoSpDwUAl9wm4Wl
         zTH0qngeUTypVas6r5cAgj34jSH0rfmBl2eq5UFzk5m+vMikuz3rRpH5aArk58bhYxOM
         pqMsvlhYtgHT4QZFDScYxJN87GBl5L6NvyS28M2yKuZz96tuLTBveELDPLzEu4gXXUOs
         47Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570333; x=1787175133;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckWI6BtaRIbrrJbimDwPi28hAKgKft3eRwUm1isRRjw=;
        b=PaySmpN8I+7T8Ct0PnHpBTO7z72/2qxOCPm1Umg/f9gImJ3J8zkusHfNBn7Ivj8PYc
         8I9CC3GNaD5BnRxOGWq+zApKppPp6ZTLlcjiDFSJJcPV24jdlBlyHGPsSIDrt13EHxrk
         WpaH0I07/GEMjnSbNJ0w1U79aSoP8BQcnqEWEY4LL59EX3zQiOioXk9Gdpkb/VMHED5z
         7kmW3IdOt2p4E+KJ1/4qg1vdU8c1z9LiKpUfxpkZG8cU/uK3j18ZUG6wXy01ZeX1hFdS
         MIByIYrvr/nVGP3T0T2yjnFCQQiE5boVhvzkvQj/u6kZfYlmiFDTAFTfQ3Fb+Y8gSRR2
         YFpQ==
X-Gm-Message-State: AOJu0Yzm1nUquJwnpD+X7n7EIbOHYtWZYWzDBgNUiSYNaVE19BdP8l9T
	U+yxKgeR5r9hOkDJKH7Ouc1j8wVMc7UUljjxePkSAJNKymPq/M8Lv/Xu0XT1qmKKgX6Es5TdLPz
	QtPo9Cw==
X-Received: from pfbgh3.prod.google.com ([2002:a05:6a00:6383:b0:84f:6f80:bd66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b04:b0:84e:4d6:78fe
 with SMTP id d2e1a72fcca58-84fc6cb152cmr896325b3a.3.1786570332701; Wed, 12
 Aug 2026 14:32:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:31:59 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-5-seanjc@google.com>
Subject: [GIT PULL] KVM: MAINTAINERS updates for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The MAINTAINERS updates that I assume you've already seen, given that you Acked
the last patch in the series.  I went with an "ask for forgiveness, not for
permission" approach, and no one yelled at me when I send b4 thanks, so here we
are. :-)

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-maintainers-7.3

for you to fetch changes up to 82bd660be36f345415e0744911df141b9c31a33d:

  MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry (2026-08-05 10:00:53 -0700)

----------------------------------------------------------------
KVM MAINTAINERS changes for 7.3

 - Add the kvm-x86 tree to KVM x86 entries so that humans and robots alike can
   more easily find in-flight x86 changes.

 - Add a dedicated entry for guest_memfd, with the usual suspects as
   Maintainers, and David Hildenbrand as a Reviewer.

 - Add Sean as a Reviewer for overall KVM.

----------------------------------------------------------------
Sean Christopherson (5):
      MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
      KVM: guest_memfd: Move gmem function declarations to dedicated guest_memfd.h
      MAINTAINERS: Add an entry for KVM's guest_memfd
      MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
      MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry

 MAINTAINERS            | 14 ++++++++++++++
 virt/kvm/guest_memfd.c |  1 +
 virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    |  1 +
 virt/kvm/kvm_mm.h      | 27 ---------------------------
 5 files changed, 50 insertions(+), 27 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h
