Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409097;
	b=IE/rjn4BpsUxuKLDB+aJZ91vDMTOBxSgbqvgx280Ehp48nPTXUVbQD6w2mz2VUPAA504
	 9WyTa5i8Rv2lEGiHksTcune7M5UJmwE8u13arM9jalX5IEF2J8V795qGXQopV12ofaMD/
	 pxe70kLref29l/2boAfhltt/VueIADxZH0UOd26Ek9+p6zZtjAJS895+Up6lUI24+qDDD
	 OF5VxxJ7S32F6aGboQb21Ff2/6IRRCa+onYbAiIbx9dJrbrXiVOmojCSRyrW5n2bdn8ps
	 Vv7BuFTfwA6TmMJ3h2l3ohJi7l2kjO9GFIco4IhdufsMluBmh0T31HE1M1jitsT5B3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409097;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hBoCvN90n2kNl5TqLdsKoeXkUjH0fLvT8u+lK5yYPXU=;
	b=cu1dhuRXnCjKs6Gmp9NIsJP+ubhNp4cmmuYzlzT9T6V46ny1f5OhnGV8eTO/epTYiUQJ
	 ylNTZZmBBKzU66Z5iPoYhlb8zEHiCRUvCOWJyaEVOhexHeoHI5vLXityYdxS4hwhRIDMA
	 wr0bvoxbxpYLnjdc6XTOrEFKaPqsuU1xDgXRlQpQrjlpgPEwnijz4DsusPdsrqyMi8n0f
	 tBj2FeQ1qYJG74XZUE9IcAH3OYp82XMqnP0qNy/fQ8sVkWQGOkO3CM4UMQu4VtTv6t4YG
	 fX4Uhq62mfs5ULnAtOOEbGI+q0ubXNJy7JAg7WTRwf4ckODXbV1aLsowZkWKKFDr6sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vCD5faBV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AB60A380D;
	Wed, 11 Nov 2026 14:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2AB60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vCD5faBV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC2B1682;
	Wed, 11 Nov 2026 06:58:12 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EFA83F632;
	Wed, 11 Nov 2026 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794409095; bh=KoW+YqMwa9yLUI3NuylseR2UJKKrqQYGRZ3rfuc+be0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCD5faBVxOIGqS7zM/P/uLODjhlfhhQbsFUtbFmskhhIGTcprcoBRyJrA8ukaD13k
	 6/GAUz+inn/h4nmR+jwIESOChtZ6K7W5JA8Dqdq73JrDpEL/bsGbvtruBaE3qOGoLz
	 B7x673PVAnpaAWq5SpsQakjk82s91MXW+MYavL/o=
From: Steven Price <steven.price@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>,
	linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>,
	WeiLin.Chang@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>
Subject: [PATCH v2 01/12] KVM: arm64: CCA: Reserve the RMM mode
Date: Wed, 11 Nov 2026 14:57:45 +0000
Message-ID: <20261111145758.217946-2-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111145758.217946-1-steven.price@arm.com>
References: <20261111145758.217946-1-steven.price@arm.com>
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

Reserve KVM_MODE_RMM for CCA realm support. The kernel parameter that
selects this mode will be added when the Linux CCA implementation is
ready.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 97332ffcb130..ccd2dc8f73c3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -120,6 +120,7 @@ enum kvm_mode {
 	KVM_MODE_DEFAULT,
 	KVM_MODE_PROTECTED,
 	KVM_MODE_NV,
+	KVM_MODE_RMM,
 	KVM_MODE_NONE,
 };
 #ifdef CONFIG_KVM
-- 
2.43.0

