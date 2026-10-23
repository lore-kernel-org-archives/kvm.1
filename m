Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738876;
	b=puc8zrjorKVk8wZ5GHqO3a4fvUBHsBTgiGNSfkwyDaT/VtpU3d40/ude3FOz/hUG5BHY
	 XnOSJDROdzGaUALb5+7NJbgmErVw/uBY7HZTq6i9Vr+PGYjaFT0DLhpyb/UU6uICCN8r4
	 Qt4/IPEaW+5tlK+Fc1+zebpaOiaeKu5X9govVI9pA6NVkH4fZszFrEykQH0BjeOyw5Ws5
	 t0w6EGPocpKeoBZ3XJzslbOglwjHa6KIhi0szZiqTF/IiZJJ8bEB0ahHSIDwEPUglg1dC
	 0C9C03xCO902RP4wV711s0FyswSLZ3P2qRTGNSOs/hTYTIQqHIX/Jr7cy9nXfpv6YHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738876;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZaMLjnp9n8JarfzU5Qv1z7FhWJG54NnnFsIG7nhnlMk=;
	b=bLTFPzhr7RzVvi2G/I/HvuLyiQPR/w4c1HZNfHe0gX049ruAGsK39NAKJKd8RA1gIcHd
	 0dWAk4irVN/XYpDxS8q0b/Xbh6elY+YRYmnCsLbhNpybxjvu+qzauq04OXU0FjveVR9YY
	 OMxlwcaBtxbW/8kLJYsKSyVtB16hVU10EgHZZq6VJ0w4gC95XleeWvRbEfoknFLuEvJpG
	 99jc90tqxtbQSKtuKxt+h0QJ1yzC1SLLDlDV3ofxGr3jch20RrnVNpNBlytH+0aq04CE8
	 /yvTrKC615yI5aSmZKI7y143go89jvDzehRrOVAw4xrKXuCFb4SWBgvAvFYGwH5M38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ml0t4fx0;
	arc=none smtp.remote-ip=95.215.58.55
Received: from mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A1606A31E
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A21A1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ml0t4fx0
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gXiFoqCU+mSVzPqh7WXxvdn726uaIR10TpfwEXtrPEk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792738872; v=1; x=1793343672;
 b=Ml0t4fx0EOmjEyn747M6bRSiKuepLQMvLWPd33LA1eO1ftU0oJGhd5nREZfpobsl6DEH/qZj
 lKec6wcJzax1hBxC83N43vCnHwpFkSYeWQrd7on8GJGXCbdRVsdV8nwgXxKTx7gEgP9sLxDXeMt
 71ChShlbKbZ1exksSkOs1xug=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 399763199c770a61;
	Fri, 23 Oct 2026 07:01:12 +0000
X-Mizu-Trace-ID: 399763199c770a61
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: arm64: Stop advertising FEAT_LS64_ACCDATA to guests
Date: Fri, 23 Oct 2026 08:01:08 +0100
Message-ID: <20261023070110.1833446-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

On a host with FEAT_LS64_ACCDATA, KVM advertises ST64BV0 and ACCDATA_EL1
to guests but supports neither. The first patch caps
ID_AA64ISAR1_EL1.LS64 at LS64_V. A VM saved on an older kernel can carry
any level up to the host's, so the patch still accepts those levels from
the VMM, capped at LS64_V, and the VM restores. The second patch moves
LS64 out of set_id_regs' generic table into a test of its own, since the
table's invalid value is now one of those levels. It carries Cc: stable
as well, because a stable tree that takes the first patch alone fails
the set_id_regs selftest on an LS64_ACCDATA host.

Tested on the FVP AEM with arm_v8_7_accelerator_support_level set to 3
(LS64_ACCDATA) and 4 (LS64WB). Unpatched, on a VHE host, a guest's
ST64BV0 hits the WARN in handle_other(). A second VM also reads the
ACCDATA_EL1 value the first one wrote, once cpuidle.off=1 stops the
FVP's idle states from powering the CPU down. Patched, on VHE, nVHE and
protected-mode hosts, ST64BV0 and the ACCDATA_EL1 accesses UNDEF, and
set_id_regs passes.

The cap alone would fix the bug, but a VM saved on an older kernel
would then fail to restore on a patched kernel. 6685f5d572c2 ("KVM:
arm64: Disable MPAM visibility by default and ignore VMM writes")
solved the same problem for MPAM: it hid the field from guests, but
kept accepting the value older kernels exposed.

Based on Linux 7.3-rc3 (fd73f4a665989). Patch 2 conflicts with
00e309933879c, now in kvmarm/fixes and kvmarm/next, on the test count.
The resolution is:

  -	test_cnt = 4 + MPAM_IDREG_TEST + MTE_IDREG_TEST;
  +	test_cnt = 4 + MPAM_IDREG_TEST + MTE_IDREG_TEST + LS64_IDREG_TEST;

Cheers,
/fuad

Fuad Tabba (2):
  KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
  KVM: arm64: selftests: Test ID_AA64ISAR1_EL1.LS64 on its own

 arch/arm64/kvm/sys_regs.c                     | 28 +++++++++--
 .../testing/selftests/kvm/arm64/set_id_regs.c | 49 ++++++++++++++++++-
 2 files changed, 71 insertions(+), 6 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.47.3

