Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A748035A;
	Thu,  4 Jun 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583314; cv=none; b=pT/OEIx2PyTghNmAjBJraaVkEjamEV9EDSvMRMhga8DzIOYYtOD+YCsUS2NzjB73SfZwRfHqmcMZ9gB3weR7FF16u063VhwVTYsZSpzqoxhaaEn30025AKlGMNpQyPDyXeTClgp8S3e3X+CXlD49hLJ4/tV+JUZAADf9W1WGRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583314; c=relaxed/simple;
	bh=wnqj3BP/TN9yJaXK/VDXGt94LIWrOqp0l6cgXEDihHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abtHvsLJIOtq6Jh+Pf9jbDvkhTGaXUBb+R1lFOr3bDP8yPdPvkwP4oMXTpgW0v/1s8CgsS55157w7B9+k9HbMPXeS+v9MdR1TdMzpqycp2yF67yZQsL/RovAJHpsksGV1i4hmp/ydkDtnwDh3RfcbZuo7LkQvD7kiVkCYa4dwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TKWypmGB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TKWypmGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tj
	689IlmEzgN/OwsjvCidFFMdtb8D4N+RLJ0uDAjcqk=; b=TKWypmGBD5s4RSehnT
	1spSusSAa/MrK7xTnz14o44WoJsTovUPhk7Ke+sU3Wc1fASw+u3VWV+F/3ZXY+nq
	AV4KqsghDik3ht6EVBUCr183HzrhclsBDCdb7bAv96mD6d2P7akVxE8KoaCYvvgp
	tHTH5925AFYN3k+PenYk9jFoQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3VJAIiyFqSKmLAQ--.50067S2;
	Thu, 04 Jun 2026 22:26:18 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v2 0/2] KVM: riscv: Fix hugetlb G-stage block mapping eligibility
Date: Thu,  4 Jun 2026 22:26:00 +0800
Message-ID: <20260604142602.3582602-1-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3VJAIiyFqSKmLAQ--.50067S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43Zr1Dtw15Cr48JF1fZwb_yoW8XF1xpa
	93Jw1Ygr95JFyaq3yxXw1ktr1fZw4rCa4UtryxGFZ8ArZxta4xKFsF9a47W3ykCrs3ZFZx
	ZFWYvrs8G3WUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5ku7UUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8grHQGohiwpQvgAA3b

RISC-V KVM checks memslot alignment and head/tail coverage before
installing THP-backed PMD G-stage block mappings, but the hugetlb path
has used the hugetlb VMA size directly. That can be wrong for memslots
whose HVA and GPA have different offsets within the target block, or for
partial head/tail blocks.

Generalize the existing block eligibility helper so it can check a
caller-provided target size, use it to select hugetlb mappings with a
PUD -> PMD -> PAGE_SIZE fallback, and add a selftest mode that creates a
hugetlb memslot with a deliberate HVA/GPA offset mismatch.

Tested on a QEMU RISC-V host with 8 pre-allocated 2MB hugepages:

  # ./kvm_page_table_test -m 19 -s anonymous -b 4M -v 1
  # ./kvm_page_table_test -m 19 -s anonymous_hugetlb_2mb -b 4M -v 1
  # timeout 30s ./kvm_page_table_test \
        -m 19 -s anonymous_hugetlb_2mb -b 4M -v 1 -u

  base + selftest:
    anonymous:                 PASS
    aligned hugetlb:           PASS
    misaligned hugetlb:        timeout

  patched:
    anonymous:                 PASS
    aligned hugetlb:           PASS
    misaligned hugetlb:        PASS

v1 -> v2:
  - Squash the helper parameterization into the hugetlb fix
  - Use the ALIGN()/ALIGN_DOWN() form suggested by Nutty Liu and Anup
    for the memslot boundary check.

Jinyu Tang (2):
  KVM: riscv: Check hugetlb block mappings against memslot bounds
  KVM: selftests: Add a hugetlb memslot alignment test mode

 arch/riscv/kvm/mmu.c                          | 54 +++++++++++++++----
 .../selftests/kvm/kvm_page_table_test.c       | 28 +++++++---
 2 files changed, 66 insertions(+), 16 deletions(-)

-- 
2.43.0

