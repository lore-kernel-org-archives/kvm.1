Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935142F90E0;
	Mon, 11 May 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499050; cv=none; b=JxPFqdPEwSBX4jHkpErXBfh8L6hJrHhAhs+M+LRJd8Y+C0lxc+F/s5S8mVxd7jk1HMbNttTH8IR7dsPzFodHVW2/QQigX5GkDE3zCDolsT8Xt/dt5lpErztmzCvf7yFhtshia3mIAycoP2nrulmueUD6rHOuY0uhhVcJiKup1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499050; c=relaxed/simple;
	bh=/eIiF83OmmGsEd6dStuoDqbJgU0aSS0yXTohXkad2lc=;
	h=Message-Id:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ucZctQatotmcMJxfx+zZgNf5RKuQVBhgK/6M7HjRe8vU90SNBrw+2ynppLoCxnDPoxKj5nY8lFkYGnrj52YPBKrdZk767jjdJPzpDjDR0AOJP0mh+EgxTbOnN0VK+jE5O5t/rgb+WrDWX4zpQ6/BoXCfX96PG0n7bO0fk2UsBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gDcwm1B91z5BNRf;
	Mon, 11 May 2026 19:30:48 +0800 (CST)
Received: (from root@localhost)
	by mse-fl2.zte.com.cn id 64BBUjU6013213;
	Mon, 11 May 2026 19:30:45 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Message-Id: <202605111130.64BBUjU6013213@mse-fl2.zte.com.cn>
Received: from njy2app01.zte.com.cn ([10.40.12.136])
	by mse-fl2.zte.com.cn with SMTP id 64BBOdCA006778;
	Mon, 11 May 2026 19:24:39 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 11 May 2026 19:24:42 +0800 (CST)
X-Zmail-TransId: 2afb6a01bc7a786-9563d
X-Mailer: Zmail v1.0
In-Reply-To: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
References: 202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn
Date: Mon, 11 May 2026 19:24:42 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wu.fei9@sanechips.com.cn>
To: <linux-kselftest@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>
Cc: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <pbonzini@redhat.com>, <shuah@kernel.org>, <wu.fei9@sanechips.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDIvM10gUklTQy1WOiBLVk06IEZpeCBza2lwIG9mIHZhbGlkIHBhZ2VzIGluwqBrdm1fcmlzY3ZfZ3N0YWdlX3dwX3Jhbmdl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64BBUjU6013213
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: sanechips.com.cn
X-ENVELOPE-SENDER: wu.fei9@sanechips.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 11 May 2026 19:30:48 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A01BDE8.000/4gDcwm1B91z5BNRf

The current gstage range walker unconditionally advances by 'page_size'
when a leaf PTE is not found, e.g. when the range to wp is
[0xfffff01fc000, 0xfffff023c000) and page_size is 2MB, if found_leaf of
0xfffff01fc000 returns false, it skip the whole range, but it's possible
to have valid entries in [0xfffff0200000, 0xfffff023c000).

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 arch/riscv/kvm/gstage.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index d9fe8be2a151..2b141a78ecac 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -429,14 +429,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
                if (ret)
                        break;

-               if (!found_leaf)
-                       goto next;
-
-               addr = ALIGN_DOWN(addr, page_size);
-               kvm_riscv_gstage_op_pte(gstage, addr, ptep,
-                                       ptep_level, GSTAGE_OP_WP);
-next:
-               addr += page_size;
+               if (!found_leaf) {
+                       addr = ALIGN(addr + 1, page_size);
+               } else {
+                       addr = ALIGN_DOWN(addr, page_size);
+                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+                                               ptep_level, GSTAGE_OP_WP);
+                       addr += page_size;
+               }
        }
 }

--
2.43.0
