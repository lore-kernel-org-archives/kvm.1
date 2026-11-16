Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817885;
	b=AVIwqWMzE1cMbSqowtSCBhNhLPo055dGsSx9K7FRksrQ2Nf0N7U5muA1rl77rlJvKYfR
	 Lc6eG7viPSm6dU0/VUg6bfNPboRIAOHWsHJEU2dSND12MQRwD8D0JaGQ32X+x9vVmTGVq
	 MGvJi8llAVs467QXncVwNEHs65MpsiXmvyOhHCIHMpo6bQiFWkkdLesbOCR6qlhWGVyYw
	 Buw9aZT6vQBsYoYVtNC6ICJneLuYdzMyeJxj+t9beU8tqeOOKDHdpX7EpEekt9yfuBcLT
	 pIR0AnjQ6jSoYjQMCVmNf6jqWp6wHKTfZHtE5wQIrKD1nbYIwnOC65g3jHEjjQluz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mBe+OOXlN/TrXD2qx+SWukptcl/vZf+ofpkIONI0ZU8=;
	b=PlMzAW9HsOlHa7aw+o8rzacpCRGtZbBbIvM1VEqHuhGX06T6b/bFjkeGTgVOxvkGnvSt
	 PlG9S4UfOAmubx8lQN/eGnBLHXdjg+HqsbYgLHbbliCasQvhkb8giwLlfmQ5gDqFqEXlT
	 EU5Ga5JGbKV0jPgVqGYlU1mIh2EO/H8CnXqvaUjiMmMgOLK1JXq9SvXm6JxrGdu/Y61CS
	 WsTYqNiamgH4AfPfB18pxy7MXmzrCpcISikX6DqppMh223L7i6TItAVmUFBGyKeHaPKPW
	 xdshzlUlneF+MGgUjwhKwnp/FXBNIzLT73h+i00P/EzPlJ+AWK+ApQ77jUTMN1eo5tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d1nvYdoa;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE7606A331
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBE7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d1nvYdoa
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89d6bd67045so1416592b3a.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794817885; x=1795422685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBe+OOXlN/TrXD2qx+SWukptcl/vZf+ofpkIONI0ZU8=;
        b=d1nvYdoaEMB0i8+dwvAJ8+O2Eiqb7VJYnPpH1J9KRaA52FYiKo8HXNlO4UN2ZQF8mq
         YxgeD1CMhvsvVEK69dR++0IQ/jKG7c4r9yEitTQAHnXuBT4JRmggmR9lg/GR3wGke+JM
         QvLmv3hZlbH5jOrBTR62HxGOdueZbHXCr/c53DwydPnovGvYFcabST4H9noioroe2EYY
         19EDtLvupGiF51IGbDUECiQYvVuBaIjc+hvBalEdpA0uiGupJ9Q0wF8EykTruVsJcx+x
         vbBkyiR2VKvh3nGUhQmmMMWj45owY3JOj7UFHqOCYmSex79yYeBkgLWNGcwlgnlhzpCG
         P5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817885; x=1795422685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBe+OOXlN/TrXD2qx+SWukptcl/vZf+ofpkIONI0ZU8=;
        b=n9fhZOh9xb8d+rdMmNvRFDikCLpoR0aHLQaG/LqjBfBoGFJjujhpOnOxHQd2cXk3bX
         8/tIGO6YSMzhw/96pXrs5S1kttK0IKD96V718Z4JL5Na6EOjHX0+K6+rCtun5VY9noPv
         V9G5z+qDGRo4xuJm4cPIK44LH1HegwDRFU13M/evw7ngdYsiKlof8WJRphZiUK9EpKDP
         2K1QAtQ3LdIZ0Q8iRUk5nnACIIRaNR/2OJxRv7tk54rB/kRnXSowRYCu+o4b+LfNCpvK
         1v7qRrUrXHo3xvTOtJj8Chi2htliECxy3c3ry9CUGjy4eudidLup8m1TaotfhkTq5++H
         r/4A==
X-Gm-Message-State: APuU4Z+svU6I7xiB1A2UkzKmTtMhICHl7RKPCSspDLR/BAEKGbGxLzgj
	slPnNbo8XZpElcaspsEa6NntmYDYlx8HLrEmtOajCR8PM38NnjAW1pMO
X-Gm-Gg: AYBFou12498GCDgk6FgBq4xRWt1vu2h8VNFYrqwTSd400eIJxoPE/3P7nBaQNoIInDQ
	HIikSgJ1g2m6DuI5O8L7n/8fqYR504GBpriwrkuLk76ivhtqrMyCvBDPtaOyBVVW9FyMr1XCbcZ
	bZnlYtd6jxDU1rhSPXeqgqZu6Uj+U+nNntmGaeI8qXoFER9tN407GTecIemQDKl9kpAmb6uwKLK
	asegzNKUjPNaQzMKouZGoc+JTiZcFwdswveIDeY84KkuyacOz2mDnSYMiDzlEk5VNKGTyNEaJ1q
	UrzZ5CE9wtGlYr+3bUvbAvd24J+jS4PMz7+2S9fGs2Lnu2vMVI6yhhiciA3lrJD3xweQUD+Jgfx
	1frwQgbw039+9o1BW6J/i9Erg9GX/BRoZTovF9Mdv51bknPbbBbSDpSi7Q2Sv8TgXNZYVr4r5em
	4SKcrW6ONpGP8c2yBzVgu0IxqTp48WH4boJG29NHybuFtpLlwofPAEmXvsQDXK6Xnwb1DkYeKe4
	UDFzqfxkzK+P8w8yczQWQpgUqtgD9O1nuQ+cuq7zG7e0YL+DmbaD6Z+ezToONhAGTWiODSoAB5+
	sUxxFfmBhsvsOomJPjU9q5Ox6UU5ght9BXwDwWXzKdvN/R70F52H3qnbhYsufKbeAe79744dm64
	9zdSI8hSo+LZk1WPhRA==
X-Received: by 2002:a05:6a00:a21b:b0:8a0:adf:cc11 with SMTP id d2e1a72fcca58-8bd62fdc598mr8465610b3a.41.1794817884628;
        Mon, 16 Nov 2026 00:31:24 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2055031sm3572830b3a.39.2026.11.16.00.31.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:31:24 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 2/4] KVM: arm64: nv: Skip nested stage-2 ptdump files without a debugfs dir
Date: Mon, 16 Nov 2026 16:31:14 +0800
Message-ID: <20261116083116.5893-3-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261116083116.5893-1-flyingpeng@tencent.com>
References: <20261116083116.5893-1-flyingpeng@tencent.com>
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

kvm->arch.debugfs_nv_dentry is only set if the VM's debugfs directory was
created, but kvm_nested_s2_ptdump_create_debugfs() uses it unconditionally.
If it is NULL, e.g. because the VM's debugfs directory name was a duplicate,
the nested_mmu* files are created in the root of debugfs and are never
removed, leaving dangling pointers to the nested MMUs after the VM is
destroyed.

Skip creating the files if there is no "nested" directory.

Fixes: 19e15dc73f0f ("KVM: arm64: nv: Expose shadow page tables in debugfs")
Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/arm64/kvm/ptdump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 9f0aebacea5b..c7a1d2f1e0aa 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -312,6 +312,10 @@ void kvm_nested_s2_ptdump_create_debugfs(struct kvm_s2_mmu *mmu, int idx)
 {
 	char file_name[S2FNAMESZ];
 
+	/* The "nested" directory doesn't exist without a VM debugfs directory. */
+	if (IS_ERR_OR_NULL(mmu->arch->debugfs_nv_dentry))
+		return;
+
 	snprintf(file_name, sizeof(file_name), "nested_mmu%d", idx);
 
 	debugfs_create_file(file_name, 0400,
-- 
2.43.7

