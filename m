Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 20FC73E833F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972079; cv=none; b=MzqFQ+Wn9BuFR8CJ4cLVxdbs1eL69usNL4z5QqQ1t3k7IJOWZobrnK15oU8kpkeCYD01fSUKxadEnfhovaykC+eNfj/yGd1pXMV0TbpOL5AaARBhVrLgxWG5H5Cjl5MHXZIIcRgXOvKscsJXLxwnxPDwT5fho1veOc7uacdG5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972079; c=relaxed/simple;
	bh=tMc8u4sX85lCd4s6MPCtQmIEXTMJV4s8FHkY8VHfITs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MuDo1rnbOdIOgWZvok73+pO8iSzkTjKV59GOHRNiIrqtQXBnnh54apOZ9B7af+iJicKAge0kn0oHqxefEz4erKyij7OJjwBAh3vEEdD0BqrEeIYQcXUxT3ip1w364IACv+2dOhTdLNIZmzE40Wpzzv2KRPMaqUC5GuEaz7EeIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=S0jnWKO/; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="S0jnWKO/"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <x86@kernel.org>, Peter Xu <peterx@redhat.com>,
	<kvm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: x86: Use fls() instead of ffs() for rmaps histogram bucketing
Date: Thu, 28 May 2026 08:40:43 -0400
Message-ID: <20260528124043.2153-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1779972063;
	bh=Z+0XIJmt3NUpvQvJaRtCh3HkM4hReWbts33V/3BaA1U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=S0jnWKO/4XdZLYCA9FfV6kLYNdMekk92RwSsobWThzK4nzH5Mfcab/KuYzgQUbL1e
	 3Q4UZPMJNpyXgi5gQS25sE4hT/pgJxeAr/dBBdNZWrT8+cNMuB7LjP6xGfHDr4Zs/0
	 iIbAb3vNbyNajBUY7vQQMSRFywc5EdnfYMSo0VMhrFzvD9pbiV9Gnm/G7hcNZMg22h
	 iyicWFcSkhVqv+c5G/EovXa/GA85VxZbA0C6PrfbGSrFVMPHp181G2VV/lDoH0GX3u
	 QlWMONJDWUlMD2Rdwx1T582YwbjW3z1eG007wwnWsNAUdgJ56XKPv3cAgEkIb0NChN
	 cf2cLn2zEeTMA==

From: Li RongQing <lirongqing@baidu.com>

The kvm_mmu_rmaps_stat_show() function implements a logarithmic histogram
to collect statistics on the distribution of pte_list_count sizes. However,
it currently uses ffs() (Find First Set), which looks for the least
significant set bit.

Using ffs() leads to severe statistical distortion for any count that is
not a power of two. For example, if a rmap has a pte_list_count of 6
(binary 0110), ffs(6) returns 2, forcing this entry to be erroneously
counted towards the bucket representing a count of 2. In contrast, it
conceptually belongs to the bucket spanning the 4 to 7 range.

Replace ffs() with fls() (Find Last Set) to correctly identify the most
significant set bit (effectively computing floor(log2(count)) + 1). This Ensure
that intermediate counts are correctly categorized into their appropriate
power-of-two order-of-magnitude buckets rather than being severely
under-reported.

Fixes: 3bcd0662d66f ("KVM: X86: Introduce mmu_rmaps_stat per-vm debugfs file")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kvm/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 999227f..0074a56 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -121,7 +121,7 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file *m, void *v)
 				lpage_size = kvm_mmu_slot_lpages(slot, k + 1);
 				cur = log[k];
 				for (l = 0; l < lpage_size; l++) {
-					index = ffs(pte_list_count(&rmap[l]));
+					index = fls(pte_list_count(&rmap[l]));
 					if (WARN_ON_ONCE(index >= RMAP_LOG_SIZE))
 						index = RMAP_LOG_SIZE - 1;
 					cur[index]++;
-- 
2.9.4

