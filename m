Received: from out-189.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2F3AE704
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842446; cv=none; b=g889KfsWA2dgpx4ub/OdlesYaxXyDZ+kiYAVuvsLuTJlq6/VaQXmEZAgWEwHq+UgFp/hIxvFUIiBEq+dQeE2aXzD0HU6cf+C6vXAEEqV9KRp8DyPdkoJ0rKr05MOk7JO6RlrQ7OS8qKch1jIQ6fiQbMc55EFZ+bWOil+iecXD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842446; c=relaxed/simple;
	bh=y5BJJcHpdGJ2jUlaYs5zc4Wk57IOsDrfFAaXU3EEzsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HN6biXTDxf5OEeWeKdVNR0tUNnsV26W1frz2y5ubGE+8IVLXjttbqlYhQDzKQEGolokbRaE4el4LfxLcIKl8NHumbVyhtmmoZw0B5yVAr7YMZa3wno2KqvtlOhhsNPJvJuHDSMag1lyAgqd7ug9gFSYA/idd1QYMkswffA6GhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HGSSt+s+; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HGSSt+s+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785842439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyi/I57k9vKvTrRMB8ca/XIbTpha6N+hD+lKVj3Jk2k=;
	b=HGSSt+s+rdpWkQUmuWt3oV0AdN3kGLD9rkLH1cD8GlxDhgWx2WVW9fhQFfPhP5gvjJsEk3
	kjIC5McjAhizf3TES2CRJt40aOHqERjTLfRTibIuyTqosAFsGjljOmTLxkziXWSk3P2z+u
	5gr2DFoCHm4nFgAoV/iMiJNVYIJ3fAM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: booke: Use min() in watchdog_next_timeout()
Date: Tue,  4 Aug 2026 13:20:12 +0200
Message-ID: <20260804112011.59416-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=thorsten.blum@linux.dev; h=from:subject; bh=y5BJJcHpdGJ2jUlaYs5zc4Wk57IOsDrfFAaXU3EEzsE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmFp15HJP0qqjfVsb569gvj1MuGazm2Nq9etbpp1wNp3 fNzV8zO7ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJBB5mZFjvf/2G4o7EQ48v veKP+HPPN27t/4CVuzbJv9dgfhR25GE3I8PahsQHjs9Ud3DfkzjGP+HgWpc9uZY2/ItzzM6b/ZK sUeAHAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace min_t() with the simpler min() macro since the values are
unsigned and compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kvm/booke.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f3ddb24ece74..543479fc9630 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -598,7 +598,7 @@ static unsigned long watchdog_next_timeout(struct kvm_vcpu *vcpu)
 	if (do_div(nr_jiffies, tb_ticks_per_jiffy))
 		nr_jiffies++;
 
-	return min_t(unsigned long long, nr_jiffies, TIMER_NEXT_MAX_DELTA);
+	return min(nr_jiffies, TIMER_NEXT_MAX_DELTA);
 }
 
 static void arm_next_watchdog(struct kvm_vcpu *vcpu)
