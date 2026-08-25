Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6E17A314;
	Tue, 25 Aug 2026 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692797; cv=none; b=SQYVajDXwIP108Uy1Po7+Dyc0NetUKlESoyIR8LXA0YZT8GUVa0ddRBm0/581UISNPSqxzfQyUMVUZqNxoG9wJFFr1AUpH9C5nO++inZRDo/o/ELqUAOSLs0Y5TULxndKifeFK0mTN2zOyw3uw5R01DMQgFo/aORyooClxZCHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692797; c=relaxed/simple;
	bh=DCkh7zwFwuSOe5fTMEye2Oh1ZEjE4In2M9Rjx+1yMUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V/N+5TVW/TDJBN+VFpdK+ccSEDCZreZyg6X7KsyNeLB+febdWXSEm13n4HSN7GzweOgLDYjR8ncj4pTE0MI+f/fOm0iOotjyVgNu6MkOUlPZrYPOXkBr6F2B16lAb8WUSe7g1LcEyJzsHt2xAKLQGC1DvVOPsQj0bwrxPtSesRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=g0OK3kcr; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="g0OK3kcr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1787692795; x=1819228795;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DCkh7zwFwuSOe5fTMEye2Oh1ZEjE4In2M9Rjx+1yMUE=;
  b=g0OK3kcr8tsnVbQn6ugdJSCNWBy8giHLO9S259p9J9FN0PC1pUwom983
   9unZPpKj3xqviAFnZG7JI338bKf4n+ouMt7VzvEgm1cEhVAP43KQcM5Um
   BFfNm/rJaPAE/MKp9l9Iz5WrannPOxDKxbW0BphYEwdQ2RFNvrl1gkZ2q
   DAJP4XqQ6of50yn27eVSd508IjhZZNi0EntW69OOJFwjeuSozvWXuUTsv
   7eK06wImHgTjlfadH6YrBPnxE5CA52sAN01zWX9UGuvtuXSxob2xYhUN9
   HnrAlxt0bfZh5A9QVRTgxyn1+/CU9uWyj9tBrMtv01z8bhCKKLBQ4VMZo
   g==;
X-CSE-ConnectionGUID: 9nxJjbodQOmNVnEORTjmxg==
X-CSE-MsgGUID: 2tdLVwoiTca3g2vYexeKgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="250769428"
X-IronPort-AV: E=Sophos;i="6.25,243,1779116400"; 
   d="scan'208";a="250769428"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:18:44 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 611C9820C04;
	Tue, 25 Aug 2026 21:18:44 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (unknown [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 19D0FC02F31;
	Tue, 25 Aug 2026 21:18:44 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTP id 459B81801C01;
	Tue, 25 Aug 2026 21:18:39 +0000 (UTC)
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: [PATCH 0/2] 52-bit VA guest mode ID support
Date: Wed, 26 Aug 2026 06:18:33 +0900
Message-Id: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkGjmoC/yXMQQqEMAxA0atI1gZqtCJzlcFFbVONMDq0KoJ4d
 6su3+L/AyIH4Qif7IDAm0SZp4Qiz8AOZuoZxSUDKapVQxpN+NUVaupkwc1gSb7wlXVKKwcp+gf
 2sj/Db/s6rt3IdrkvcJ4X9NTgIXIAAAA=
X-Change-ID: 20260825-arm64-52bit-va-32f1f4cd050d
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
 Takayuki Okamoto <tokamoto@fujitsu.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787692718; l=1855;
 i=itaru.kitayama@fujitsu.com; s=20260825; h=from:subject:message-id;
 bh=DCkh7zwFwuSOe5fTMEye2Oh1ZEjE4In2M9Rjx+1yMUE=;
 b=7XNu/jkIySZnSwyMNQ95NlahI1x9xVp4JU7Z8qoAENLXI9Bg2Mlv4Us0xIz4cTk1mLd3wberh
 apmDZOfqdp8Ag/eP9I4BBkHtOVzEu9B1BccGPvdg0H+ylcLNTr/ecuV
X-Developer-Key: i=itaru.kitayama@fujitsu.com; a=ed25519;
 pk=g9bTnr9giRP7JwNSZHy+OMLQZBEUtSE9tUnXso0hH1Y=

This patch series extends the arm64 KVM selftest framework
to support 52-bit guest virtual address (VA) modes in addition to
the existing 52-bit physical address (PA) configurations.
The motivation is to enable validation of LPA2 guest memory-management
behaviour in configurations that use a 52-bit VA space.
While the selftest framework already supports testing 52-bit PA
configurations, it lacks the ability to exercise guests running with
52-bit virtual addresses, leaving part of the LPA2 functionality untested.
To address this, the series introduces new guest modes for 52-bit VA
operation, adds five-level page table support where required, and
performs runtime detection of host 52-bit VA capability so that
LPA2-enabled guest VA tests are executed only on supported systems.

Testing:

Built and tested on arm64.
Verified on QEMU with a V52-capable guest configuration.
Confirmed correct operation of high virtual address mappings by
exercising guest memory accesses in the 52-bit VA range.

Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Reviewed-by: Takayuki Okamoto <tokamoto@fujitsu.com>
---
Itaru Kitayama (2):
      KVM: selftest: arm64: Support 5-level paging in stage 1 translation table
      KVM: selftests: arm64: Add 52-bit VA guest modes

 .../selftests/kvm/include/arm64/processor.h        |  2 +
 tools/testing/selftests/kvm/include/kvm_util.h     |  3 +
 tools/testing/selftests/kvm/lib/arm64/processor.c  | 87 ++++++++++++++++++++--
 tools/testing/selftests/kvm/lib/guest_modes.c      |  5 ++
 tools/testing/selftests/kvm/lib/kvm_util.c         | 11 +++
 5 files changed, 103 insertions(+), 5 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260825-arm64-52bit-va-32f1f4cd050d

Best regards,
--  
Itaru Kitayama <itaru.kitayama@fujitsu.com>

