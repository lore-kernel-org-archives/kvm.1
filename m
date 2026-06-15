Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8F3D6693
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513558; cv=none; b=Ot9oBxxrfHngl2aQPbGEfjHnFBS+Qgi8Pzq9plQ8obgIBSef4AZ9JwniPp4HxCE2KW8JXbzd3w8f11EeRvrUbW+4n9vPc4gD5kI5+dl71YYE3Mxv7ulcxW0bLJFQgA/e1ymIEXhyH7tdsZHR+Ewl893vCNdtOBMk0jRjyMs5ALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513558; c=relaxed/simple;
	bh=9THnuppqeYZPWn7EKtGJq9SzCdGC7ovGP3B2/CHfR08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKCdCtL3bYA0ML+m8B6CcsSXlQzH/OnS54Krx/BNtZSLn/Uocm6g7hkzpYHudq2bXQIhbVxuG0mefTE/HaGx06zzpjQfXbKCjEh1N+1bOhsQCesOmb91p87iIMLrZJ447+sG3zZNjpo6xSsGGYiZwBbyfefmLMmNi5X5QC+r5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t+3wz49X; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t+3wz49X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781513554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7JXHIDoJ4Z4EUEsj0Lp6DsW3Mflz5YG/zBTv4Z1pkrc=;
	b=t+3wz49XD5XXWvzxZgYVLwb2p6tXE+0CXsMekVY9iRzAYr9vRoQ8d8kMtUEnDVU5mqJTCp
	Y3tbu/gqtbfa2fRqylMQl7ZmiMdFWH73elKld8bR628RFBoz6JmwIEd72szuNRgmlcWkf4
	N3kjE5F/C2hdTu2hBAZprSIAE2cQTpg=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] target/loongarch: PV TLB flush advertisement
Date: Mon, 15 Jun 2026 16:52:12 +0800
Message-ID: <20260615085214.44526-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Advertise the LoongArch paravirtual TLB flush feature (KVM_FEATURE_PV_TLB_FLUSH)
to the guest when the host KVM supports it.  This pairs with the corresponding
KVM/guest-kernel PV TLB flush series posted to the kernel.

Patch 1 syncs the UAPI definitions into linux-headers.
Patch 2 adds the probe, the CPUCFG feature advertisement, and a
kvm-pv-tlb-flush CPU property (on/off/auto, default auto).

The feature is only advertised when the host actually supports it, so a
guest never observes KVM_FEATURE_PV_TLB_FLUSH on a host that cannot
service PV TLB flush requests.

Tao Cui (2):
  linux-headers: Add LoongArch PV TLB flush definitions
  target/loongarch: Enable PV TLB flush advertisement to the guest

 linux-headers/asm-loongarch/kvm.h      |  1 +
 linux-headers/asm-loongarch/kvm_para.h |  1 +
 target/loongarch/cpu.h                 |  2 ++
 target/loongarch/kvm/kvm.c             | 38 ++++++++++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c  |  4 +--
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.43.0

