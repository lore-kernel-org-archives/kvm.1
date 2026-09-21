Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95A46A5FE
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985439; cv=none; b=roK1dHD1eBn1IXBma4Zk2zQ014Q2R741TRkhbVWDYI22dPlcwRk24eMJShUqRvH7hbjx2NUw8oJ/hvIhB8kjF/zWaamImiEdfzcFb6IOj3gcOUbX2/t6L3rk2uDVlYlvFyz8RmjFxknvtX0ITZsFQsLh/nqYE/4wNfcXE4xLxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985439; c=relaxed/simple;
	bh=Yuf6CVS5HHsFju/bVLT2UkgQQk/AjuyAU2D19bqRojI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NbEhpsC41zyHkWC6IpgtZIjUbH2Ue0uzN3co9c2GHlKj2wix7eOuFQlrldeESWuhVQWMB5HzY+yIXQLx+UUyk4zQilPYNw/tPKFPjYZE4NuFW8FoPLxHMfXPG/ZwLxZI5NsNINDFpks+Z6aKr7UrzGdhRE6/mEeqV0++nEwj7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dyh42vJl; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dyh42vJl"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yuf6CVS5HHsFju/bVLT2UkgQQk/AjuyAU2D19bqRojI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789985435; v=1; x=1790590235;
 b=Dyh42vJlY20BNiB1peouSmWJzMaHH5EuTE1D3HavSkiCPbEeaeb0zQCBhxINxHMOYs5l5jMp
 nOvKBVIS77Q31d31EZu1hx8KZYaXREU0iydi0FRUxC3AadNQTX//EMziJGL2MiWUoqOTagRCPjo
 sVp/MBI2OUYY/5WSHt+d4kfY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26de98a1c1e4e5d7;
	Mon, 21 Sep 2026 10:10:35 +0000
X-Mizu-Trace-ID: 26de98a1c1e4e5d7
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 0/2] KVM: arm64: Fix a vSError staying pending after delivery under pKVM
Date: Mon, 21 Sep 2026 11:10:28 +0100
Message-Id: <20260921101030.1231605-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Changes since v1 [1]:
  - Added a cover letter. (Marc)
  - Rebased on 7.3-rc4.

Under pKVM a vSError the guest has already taken stays pending in the
host's copy of HCR_EL2, since the lazy state sync for non-protected
guests stopped copying VSE back on exit. That's a 7.3-rc regression.
Patch 1 reflects VSE back on every exit. Patch 2 makes the
external_aborts selftest check that the SError is no longer pending
once delivered: it fails on the unpatched base and passes with the fix,
and also passes under nVHE and VHE.

The "Confine protected VM vCPU state to EL2" series [2] carries patch 1
as its own patch 1, since its later patches change the same exit path in
hyp-main.c and don't apply on a tree without the fix. It isn't part of
that series: the fix lands from here, and so does the selftest, which
that series doesn't carry.

Based on Linux 7.3-rc4 (93f51579e7df2).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260829071120.2522788-1-fuad.tabba@linux.dev/
[2] https://lore.kernel.org/all/20260914113338.159227-1-fuad.tabba@linux.dev/

Fuad Tabba (2):
  KVM: arm64: Sync HCR_EL2.VSE back to the host vCPU under pKVM
  KVM: arm64: selftests: Check SError is not pending after delivery

 arch/arm64/kvm/hyp/nvhe/hyp-main.c                  | 4 ++++
 tools/testing/selftests/kvm/arm64/external_aborts.c | 6 ++++++
 2 files changed, 10 insertions(+)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.39.5

