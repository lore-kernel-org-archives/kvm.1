Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2B39060C
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976007; cv=none; b=HX1YO0OFLYQvo4AJp+HBCYnG/RKYBX/QomCpX58DuvSvivc94ROumJVKHZ3qzCuhZsDmDMBv9avj1BAshBgIBWxpC6f5DVANmblSDQ2TyQytungswEPo+hbuOyZupzi5XH83emD4PHzL5oBkoJOVX1lr4gCc1wpPAo64a2uACaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976007; c=relaxed/simple;
	bh=0ANPac1FlqN3Bb2HY13+N+nGSAE+zOob4mATalVjfb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQ7J11XEkZnEIoHfINDymGCr1gviaZ0yHVTp7EWZ9Z+UgQawDW9tosZW7Gst/2kZFI9bEiEcfFVl4ZRT0wHpXP8pJ+R7pxpOLgCBGUKlzDWMfoHnauiWDXryfBLCwAQWtMhTmacbityyPYnifw4aussDUvGf/idy3arIUZfDMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fBcGcqdJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fBcGcqdJ"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVZ3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVZ3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975046;
	bh=LQm8YzT/R+eSYLfSwdF6NQOxm2XQdbRQm3WLubj7nWE=;
	h=From:To:Cc:Subject:Date:From;
	b=fBcGcqdJhF1YzEJIjAS0TW98fKx+3wHTa1YevtKoefJTZz/UMvBZ964FVffF0lMr2
	 0nccFUzpQshd6MKVwrgdcrMl6qQJZ0fI2iKZ9Ri95hvB+FflYWKLlpCcDdzGNDXH6q
	 U7vmV1yOHxy04zCebZj+7sD6fwkqhodehFqwRKe1bLNzC+xoSPHrb/1PhIj4G4I8xE
	 8sY2Hpx8GguHKBBBIkjZCddw2eBAdQ1ohr5PR7bxWaMzRK3ChdLOK+x03A2oqvU38y
	 abcunsUiBDAHmYe7p0bG/eZMdNVMfkprm6ZVeGAYuZvl+o3TK86zc2CTJ8EhkaXS8m
	 3X07iAZ72rSjg==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 00/11] x86/vmx: Add some FRED tests
Date: Wed,  1 Jul 2026 23:50:28 -0700
Message-ID: <20260702065039.3434909-1-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add tests to:

1) verify that FRED MSRs are correctly handled during VM-Exit.

2) verify that attempting a VM entry with a reserved bit set in the
   host FRED_CONFIG MSR correctly triggers a VM-entry failure.

3) validate #GP injection for EFER.LME clear with FRED enabled.

While adding tests to verify FRED MSR behaviors controlled by VM-Exit
FRED controls, add similar tests to verify EFER/PAT/RTIT/CET MSRs
are correctly handled by their corresponding VM-Exit controls to improve
test coverage (especially the nested code coverage).


Xin Li (11):
  x86/vmx: Support the nested exception bit in VMX_BASIC MSR
  x86/vmx: Allow bit 13 of VM-entry injection info to be set
  x86/vmx: Simplify msr_bmp_init()
  x86/vmx: Fix a typo
  x86/vmx: Validate FRED MSR handling during VM-Exit
  x86/vmx: Validate the EFER MSR handling during VM-Exit
  x86/vmx: Validate the PAT MSR handling during VM-Exit
  x86/vmx: Validate the RTIT control MSR handling during VM-Exit
  x86/vmx: Validate CET MSR handling during VM-Exit
  x86/vmx: Validate FRED state checking during VM-Entry
  x86/vmx: Validate #GP injection for EFER.LME clear with FRED enabled

 lib/x86/msr.h       |  13 +
 lib/x86/processor.h |   2 +
 x86/vmx.c           |  95 ++++++-
 x86/vmx.h           | 118 ++++++++-
 x86/vmx_tests.c     | 631 +++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 845 insertions(+), 14 deletions(-)


base-commit: 1da1819e49fc4938985edca67df669099b4c87a7
-- 
2.54.0

