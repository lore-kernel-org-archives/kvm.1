Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F740A938
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108892; cv=none; b=PyH3KjY7lP2LsyXIyrV6NkmxxP0ThZEIWLacpG+DUlckb6Qq5NPEgj1ywecdm0b94aQLUiP0bIMLwvdTIOGtW+s2voEbBzkzzkaqFWp0Uze0gf5l5kcK11PSbykLyAQXYu88eZ8hVBq0T8U2TyIvCh3xBLBkiEMXivwXNHYhWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108892; c=relaxed/simple;
	bh=PkE3WSX9JtIhEhlJzhCajN7UPABJAQghn++d/wKeH58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIDCfaIRl5KM0yCXLSi8C9X0MLmoAtljykDUURNzuB/P3ARcEAUXEwzT50BqZhCknN5NMsaXRPAH5JheWSasFHV86mhYohlDXxtcujJ3Nh7Th9ICavW7PWQ/VSBJRGjtrAw1CwNxG6ldXlVll/jLF04hspwUjsMunrOlJP4wWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNiKebdl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNiKebdl"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso535818a91.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789108881; x=1789713681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wCIfihLLndYAlu2pLx3p5U79c1+e8tApd2WKF9yFlbI=;
        b=JNiKebdl6Ng5ZOmPVVrx1bvFbrFQR/gtrU6R/R1T/zhKL0eoBLHqRv90B0F2dazj+v
         fgmyYGSt6+NSWRobOBoehl6JEkrOc+0zhN5kn/s4AiP/cAKxEXzcA8L8n4sAda6CtSRQ
         DHpbqmEUE8Fo/Y0sCBuVN3XsxttXXKu4OQXfMJBllV0PuI+LO8vkUWPmI9HDF+exrjmi
         mE06vnBIhQHNqvRZKqTP8JLRTsJzvogk9TGmr98tHDHlcTXDE6GZ0S3sivMVpqmNWCkk
         vje5Bng5ziVBm61h6i6k8TUPOdW8rBcjym+omsMcBp7xlsRqvPcTvrEZMW3l4jHYvnpN
         EzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789108881; x=1789713681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wCIfihLLndYAlu2pLx3p5U79c1+e8tApd2WKF9yFlbI=;
        b=KFydTx1xp0nc/lKwlmStDSorwyd+2xPr4zvUkNrf3UM5CriHKb2Ubm0M6WJjp/eVgt
         NzrLWsT/MVV0QpRy7GETar3pgPP2Ea6l1D6DLm+U689391ejNOKvHNy6netBxfVkCBiL
         66K45kzoXmjpY/EwHfDzpYbgdWUVclZMyb0+DF+Ygkbf1IENLNzXfUzlhnhcptA+64GP
         1whV9LoD4r05jC8ut9x5bBjLodTccZ2vPcA7Ff4JhsYav2iFni+DcgDTmGCN4/6Tc5iZ
         7crZNgR3GI8hgIv31VE/zjqu4NT1IZqOsanEgmIbYYINMJmyxBowc9Kld4ynLQCRY0q6
         uOzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9YAbzOh0wEQzP/3Ym6G73aF8nzDVO1T3KEk7RXN+uQKC0cJRp2Cq2l7Rv73ABifTHF1I=@vger.kernel.org
X-Gm-Message-State: AFuF++mRi/BHg2OspKEJ4YqQoBAcFv5Z/MvWSFCjIl0FgtC/DbLbl4ui
	MmyroRrhBH59Bct7pkDkr+uWsvImpRDC5v3aLQpLm1U5v9S74cNtIJeL
X-Gm-Gg: AYBFou3KXKvi8lzkXe/iqRiUW0u4cDZyJ4/qgl5dZpYwMLWCHBijRDVhIKCLIV6giXh
	u/FnoepQ9MQ+CfZ3L5h+HhPGn6Gg2WJcu4n5oJS/whcgY+o10bqsfJVFzvUOlDcUZjhg66rsgrJ
	mwq5ocUmpdYqXapE9Y78n/Ku17o6px5wWJXXsnaK7SEvTF04wYS33pn50F9PSzx9/TFkXjKHFn4
	L2GfIZeGkSAT6mzRWhgwqt+1Dd+mOijqIqmj890mLWbIQZkvRJapFqLvgR8ryLksHSpv5D/nSrt
	dqoj5IS9azbuMI9UtVf0mOEdnOk2bTi5GRpE6SyL9Pw6vS43JCu/OCjU7Bm2pOU9cfmTBajxro0
	pu41WphaVpwktHH0OFw5DqJfs1+F1dMSZEchY3HK7xNkgphCzIfdgD7ekWdtLb6NvQlnsQW69tq
	Cb+X1YJHGR+zKkHOF9nOeVVjp1LJdV1xY9zUIB4fSJS0T2+9EE4zO9hnl+W1DJPHZwNDjcs15eA
	A==
X-Received: by 2002:a17:90b:440c:b0:39b:57c6:e280 with SMTP id 98e67ed59e1d1-39d9bd65a3bmr4250586a91.7.1789108880711;
        Thu, 10 Sep 2026 23:41:20 -0700 (PDT)
Received: from localhost.localdomain ([162.128.207.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602e7sm3286683a91.5.2026.09.10.23.41.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 23:41:20 -0700 (PDT)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: fuqiang wang <fuqiang.wng@gmail.com>,
	yaowenchao1 <yaowenchao@jd.com>,
	dongxu zhang <xu910121@sina.com>
Subject: [PATCH] KVM: x86/mmu: Respect user goal_nr_mmu_pages after zapping oldest pages
Date: Fri, 11 Sep 2026 14:41:12 +0800
Message-ID: <20260911064112.10766-1-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kvm_mmu_change_mmu_pages() shrinks the shadow page limit and the
current number of shadow pages exceeds the requested goal, it zaps the
oldest MMU pages and then updates n_max_mmu_pages.

Previously the new limit was set unconditionally to the current
mmu_shadow_pages value observed after zapping. However, zapping can
reduce mmu_shadow_pages below the user-requested goal_nr_mmu_pages,
since a single __kvm_mmu_prepare_zap_page() may reclaim more than one
MMU page (it also zaps unsync/child pages). This could then clamp the
limit below the user's intent.

Use max(mmu_shadow_pages, goal_nr_mmu_pages) so the user-requested goal
is honored even if zapping overshoots.

Signed-off-by: fuqiang wang <fuqiang.wng@gmail.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..efeba58936a6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2913,7 +2913,7 @@ void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long goal_nr_mmu_pages)
 		kvm_mmu_zap_oldest_mmu_pages(kvm, kvm->stat.mmu_shadow_pages -
 						  goal_nr_mmu_pages);
 
-		goal_nr_mmu_pages = kvm->stat.mmu_shadow_pages;
+		goal_nr_mmu_pages = max(kvm->stat.mmu_shadow_pages, goal_nr_mmu_pages);
 	}
 
 	kvm->arch.n_max_mmu_pages = goal_nr_mmu_pages;
-- 
2.47.0

