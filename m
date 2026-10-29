Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317846;
	b=O/zNQSyVZgsMF0gmjs4LmV2YDM0sCjOb50IgOkyXCQq2WA7I64/JnS5FVP6CcavRzeih
	 /4MDJ8bPBzyYTrGAimsni6igd3eOWBNWGMRHDBnHdxykpEJq3HCm/y1bVCFMw4I/QmTC7
	 Ygk9p++QW7ybdYxMsFrHahMYCCvWiT+1azQb9x/PXR1R4QtFylGVMOlwEngzC2PD3htTj
	 6lSus9KA1kM0yMf5w6gbLFe2wyx5oovLNPsNwsg+WvPmq6DHV5mT3sKUgNs+IpBae5mid
	 19oYEH1vN4Y9yZS64GFigrH3IVLDvoNaK/HNzKvkVuXIPlb0zo8HhYh8C78Xilx5UKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nieVyMQBbnIomw7dtt1FLb8V7O5cp/p1dlZFIxt1aL4=;
	b=S1QpuAJFPWhGVhrtMD9FDnGzF3Aq1Ka5DV9WAf4A604J+8tuBd6fgtXmCEH5x8FpnQ76
	 OJEL6MwWe5wV3EgVCcZqnjvNw9nxz59Ysppr+PdSNfZObiiR+tWyr2iVwUILunKymg++x
	 Dkp0s9CBeQ9UiiB2jQKAWgeGaKbs77jEfCUed1ebZAaMX95K46VONEUQnJX9DqIo4eZSh
	 fyltOItpP8hynbgctVfBC0m4oOd4C470JXOyaHqy8urNZxtjdvKdsMWqRuguDi9YAiJEy
	 oAqOCYwCti0eRd6ZxD5oK7wnciMsm/cjXthqR6WZ+tzlY4jxBOmZ5Ow3loh+qzSjNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZBVSVaU;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE275606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE275606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZBVSVaU
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso944125ad.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793317845; x=1793922645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nieVyMQBbnIomw7dtt1FLb8V7O5cp/p1dlZFIxt1aL4=;
        b=XZBVSVaUz1t5sGtctyI/6VHDRknPdWzzLoI3t0lEwp5JhaHcb35a9Nwmsm65lI12Nl
         hioDT1PQBE5cLmv23JrzOpZpQg0jfYIge2tG7itstG0M+HF6lREyMgtX78VahrxkIPv1
         7+9Io2ZaA6PxOu5nXUjAU2ye5fkgkvpDJ67fRPz1C5y55rbw79vycy9UDGgO1zPAxWo5
         MVM3xvgwvXX/75ShD5UjZey3OS++RKWmVd3AD5QTRiK9/xDRr9fYIgw/2vnHSi2Nc5oY
         F2SIMxuJr3SGWv1p/Fxmbur65iTQ+2Uv8kqz/Qn2lzQZ5ZWdi7rMV1yAQfilSOL7BDYw
         JIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793317845; x=1793922645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nieVyMQBbnIomw7dtt1FLb8V7O5cp/p1dlZFIxt1aL4=;
        b=lz9l/BeFKEnwPKlAME6ZfekbZ5RZdbU3zXnwqIUDVcuFbWXuiPLZCn8Uij6AaDGaC/
         Q8s/HDRIrdUc50xpG9WIYODH1WfF133dZ+oGcb3gqDhQOBCyoEkrT8BlSzslqBF0dMUc
         fdrFfiLlYyXjIhSeqjPtSpyWaYjP0YC/cEtW7+5nCFJQsr0mT/XMqhok4dowidxTdwC7
         VGdavzeoStlhQSxtYZbx/IEPwMazjbL0TPn+vZ838k1c7N0e9HPkonoX65E5GEUoVjPn
         guqMhFsLo5xmYxTCaYFGiicK2Ex2q0IMGxYLcwvELIG27GmiJQOWpDEYxEeowDKCGlu/
         RnNg==
X-Gm-Message-State: AFq9FYIAJ8RSgQ1Aq1inJo+WYhyChWLlz85aG+PnHEFjNdzme/gCJp3l
	0+72UaRDi/7OMmCarPK8P+IBAZnlFlPZPXMbXtm9LTP00cxRNBZlRM7Y
X-Gm-Gg: AYBFou2VAeqPSoI04x7I3BEekitPmP3q3dsoK7/o6m9ZyXl6eBC/iJz/5wRCFWTMXp1
	Xu3PaHj6gkfK4IZUXZcri4CDEDLVa5svVsy8hXZhFGJQWgFcDEaZwU+2lh7eCzKpGKRVhTZicDF
	Fbo2dpztWIDioCRZBzC7TybbPcDTVnrvTHsqk+kC/ezOf84wliOcycy8DMH02BoLkqUf3LHOZz+
	mcqSgr67/J1ffZ4Toy2PbeZuT202/iL3tano51Ep5er+8grof4ScIi32E4EXZNfeDI5+Wm0nq+H
	xAdaIXItexcXafr7+YMcQk5NX8qXzBTryMLppBUPbRYifXytiLljE4vP0s0G/ISSU4hzfC/LrL/
	Czia0bLthgPeAzR8HcjSw980LiLbZn7mu/lWnN2KPKSgJ/6ZPWKKIdmG0X/9hy2UI2rmPjJsh7h
	YTQfz0FnQSZNDGVsjXMKd/wD7RcRDmMAHH/BjStEN08R2Esm8I3+SJPNCXwVH8sYg54Gw6uy+hd
	/ZgYPN7xAA+1lUZYOGSwWnuickw0Wnz5nX9gDnqQDfJ9wC7X+tmzJE1QxSHoVCJU7Uqw5dzxKZF
	hkdPVqc626A12C/Gs9r0+8GYQSTk0aw5uriZnFGq/ODL5Ha0un61s8XN6dRS+iZzwNDd5uSmJSs
	VCLcHEUKRfQ==
X-Received: by 2002:a17:902:f545:b0:2e9:3f41:4212 with SMTP id d9443c01a7336-2eb3648a050mr7704565ad.13.1793317845197;
        Thu, 29 Oct 2026 16:50:45 -0700 (PDT)
Received: from monk.. ([2604:3d08:8e80:f800:3c86:745c:97f1:5486])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm384225ad.40.2026.10.29.16.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:50:44 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits owned by L1
Date: Thu, 29 Oct 2026 16:50:38 -0700
Message-ID: <20261029235040.12013-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

When L2's LMSW exits to L0 but not to L1, KVM emulates it with
kvm_lmsw(), which ignores vmcs12's CR0 guest/host mask, so L2 can change
CR0 bits that L1 owns.

Mahmoud Abumandour (2):
  KVM: nVMX: Don't let L2's LMSW modify CR0 bits owned by L1
  KVM: selftests: Verify that L2's LMSW leaves L1-owned CR0 bits alone

 arch/x86/kvm/vmx/vmx.c                        | 15 ++++++++
 .../kvm/x86/nested_exceptions_test.c          | 36 +++++++++++++++++++
 2 files changed, 51 insertions(+)


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.25.1

