Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE9478E36;
	Thu, 22 Jan 2026 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769060209; cv=none; b=BLAhj5EeHPy3PfwRpyOfR/9WALnZet/iQCdFNkTgC1j7+IjZZUVn1WK3mx0q5+bRwuqARLgGu+f5G36L531wuvYU6uYzuVlH03wlOAeBCcF+ZwuLasLkq3A1T+vy8hC53TaYZh+SC/dnI9HbEzb62Xuj0Hb3xU/NK8Slan5C/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769060209; c=relaxed/simple;
	bh=eEwJV8YazZUdwv7DfWvKvd+LSY4BrGefFegKGNRWiQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGhxRvFEs/lEbShBwiY2aNhBbp3v8alxvM2mOizV5+hDVBXt9dZaRsifgqRaYUyguUCYNSIYC/DYEe63xHspCZli/PTjR7u58MpHof688ifJs3MXborRzEo/TF/CJAuENTYjTDAxke6/B686wiHFtXRpvUmuYDAzYtgOo8DOPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ESFU0IOl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ESFU0IOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Of
	BViCI6bSCq5ylXHSi+/Op6adamb5VZmTYcL24GsVI=; b=ESFU0IOlKAKice9kAg
	e1gFPKdiQwP0KPEfEZ0Gl+1VfrNfyoBnQ0Zac+gA+WFDz0zGiSGhVQbxIJ5RKYFC
	Upj3hPltx1xOyq/F0WZJf9cP+Xi/rVm9EJd9eafNtOG+RFohNbJf20LgvygcRDR+
	dXU49qxhMalQysK0M/12zZFls=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA3p6FGt3FpNNsdHg--.52102S2;
	Thu, 22 Jan 2026 13:36:06 +0800 (CST)
From: Zhiquan Li <zhiquan_li@163.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan_li@163.com
Subject: [PATCH] KVM: selftests: Add -U_FORTIFY_SOURCE to avoid some unpredictable test failures
Date: Thu, 22 Jan 2026 13:35:50 +0800
Message-ID: <20260122053551.548229-1-zhiquan_li@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3p6FGt3FpNNsdHg--.52102S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryxGFyDArW3Gw4kKr45KFg_yoW8CFyfp3
	95KFWDKr4vgFWIy348WrsYvr4qgr4vvw48Crn8Xry8ZF13ZrZ2qFWftF1UK3W3CrWUA3yS
	9a4xGF13uF18J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_WlydUUUUU=
X-CM-SenderInfo: 52kl13xdqbzxi6rwjhhfrp/xtbC6ga1nmlxt0bItQAA3T

Some distributions (such as Ubuntu) configure GCC so that
_FORTIFY_SOURCE is automatically enabled at -O1 or above.  This results
in some fortified version of definitions of standard library functions
are included.  While linker resolves the symbols, the fortified versions
might override the definitions in lib/string_override.c and reference to
those PLT entries in GLIBC.  This is not a problem for the code in host,
but it is a disaster for the guest code.  E.g., if build and run
x86/nested_emulation_test on Ubuntu 24.04 will encounter a L1 #PF due to
memset() reference to __memset_chk@plt.

The option -fno-builtin-memset is not helpful here, because those
fortified versions are not built-in but some definitions which are
included by header, they are for different intentions.

In order to eliminate the unpredictable behaviors may vary depending on
the linker and platform, add the "-U_FORTIFY_SOURCE" into CFLAGS to
prevent from introducing the fortified definitions.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ba5c2b643efa..d45bf4ccb3bf 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -251,6 +251,7 @@ LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
+	-U_FORTIFY_SOURCE \
 	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
-- 
2.43.0

