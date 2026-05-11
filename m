Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0796364038;
	Mon, 11 May 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497721; cv=none; b=bcPHZ5gaBYZQghXB8j6aNAY0zORIhSguduyOxMnATmpPdHWSCv1r0pplI4X9AMyPjpoMd2zx+eVZRTeum0JehONlAhiVcRPDX9Dk0HHkhZ5rnZgCe62fYUT6J2hzAGLvqjmCH0VExPBUs8r0snCVlVn1VS1ggRYAUX5DaqjadkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497721; c=relaxed/simple;
	bh=z2vdOAR+S49TzDEEuz2MzwzlQFyPcOH0ZoAjnCVSaQ0=;
	h=Message-Id:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=YEhC0RTu2F33GHTxtbCFZ8h1OHwsOwqQmxgrh3aKM1B/8pJ3HaWgOYcxZuFLjZGT9dZDRrAPqDGEqoHQrWXwgsK+wk1d70sQVIAwkVSzvLF5B+Vq8e/p9xqze9gWANs2DKkPHEwjEL0J9bTJOx1Ihbrc4LqYf+lh3KmHK6mYg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-db.zte.com.cn (unknown [10.5.228.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gDcR26Szgz5BNRf;
	Mon, 11 May 2026 19:08:30 +0800 (CST)
Received: (from root@localhost)
	by mse-db.zte.com.cn id 64BB8RFR010522;
	Mon, 11 May 2026 19:08:27 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Message-Id: <202605111108.64BB8RFR010522@mse-db.zte.com.cn>
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 64BAnfWM045156;
	Mon, 11 May 2026 18:49:41 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 11 May 2026 18:49:44 +0800 (CST)
X-Zmail-TransId: 2af96a01b448f8b-74e63
X-Mailer: Zmail v1.0
Date: Mon, 11 May 2026 18:49:44 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wu.fei9@sanechips.com.cn>
To: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <pbonzini@redhat.com>, <shuah@kernel.org>, <wu.fei9@sanechips.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDAvM10gUklTQy1WOiBLVk06IEZpeCBza2lwIG9mIHZhbGlkIHBhZ2VzIGluIGdzdGFnZSBvcHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-db.zte.com.cn 64BB8RFR010522
X-MSS: AUDITRELEASE@mse-db.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: sanechips.com.cn
X-ENVELOPE-SENDER: wu.fei9@sanechips.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.131 unknown Mon, 11 May 2026 19:08:30 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A01B8AE.000/4gDcR26Szgz5BNRf

The current gstage range walker unconditionally advances by 'page_size'
when a leaf PTE is not found, e.g. when the range to wp is
[0xfffff01fc000, 0xfffff023c000) , if found_leaf of 0xfffff01fc000
returns false and page_size is 2MB, it skips the whole range, but it's
possible to have valid entries in [0xfffff0200000, 0xfffff023c000), so
only [0xfffff01fc000, 0xfffff0200000) can be skipped safely. Both
wp/unamp have the same pattern.

dirty_log_test intentionally sets up the unaligned guest physical
address, after riscv kvm enabling KVM_DIRTY_LOG_INITIALLY_SET, it's easy
to trigger this bug if there is a larger window for guest to write more
pages before first collect_dirty_pages.

Wu Fei (3):
  KVM: selftests: Add unit to dirty_log_test
  RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range
  RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range

 arch/riscv/kvm/gstage.c                      | 39 +++++++++++---------
 tools/testing/selftests/kvm/dirty_log_test.c | 24 ++++++++----
 2 files changed, 39 insertions(+), 24 deletions(-)

--
2.43.0
