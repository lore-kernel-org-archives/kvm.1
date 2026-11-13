Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584368;
	b=Acbc4zu5OsbFa8RxZMnxOHtuAyl1q0pOwGB0KpVuWwIm/A+WTLdNBxwNF15kMH/GlueL
	 XShStpYqFhgj2rCuMC8cL34DBhvrVmG0oZLQEDCQ+mdrDwz6MYPpOhMWzZVQsvA1Z9tFF
	 KUJ3x0vHCGw0NyBDV7Dm7ZxSeVC7s9oQ/Z18uFekDGxWWA6ARVBUDk5XZCdrypNXVYxbR
	 geqjciCoHKf23YYRnyZBD17b5sBc7bOCA0NUoAp1N3TRS4YUy1rd20guAptc0m2BHt/R0
	 xq2ScmwmpdUPnUJutOq0k3UUco4LvcVkzrmR/2kSNvGUfRaz5Eii0p9fyPj/VwPN9Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584368;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yAqgd2DmDVtgaLtAAzLbASIZIpgEG5EwxsbUUxN4qh8=;
	b=TJJASy4UM3YDQx7E05wrXXzhi+QN/wWEUXZ2w6QCL6F+IRCEhG3I4VhmRCHs2Dr8Dn6R
	 OuwQ7yJhxNGtpEBwGNecnTxnOtmGfunwsWcKJL314isJyN5EXyDY8GE69HBGxpRfa2/oZ
	 yhWmR0wC4V6RWs5AAZlmDNDxNw/F4YggnGlejmNna1Fjawqxps68jGLw4QLGXJsESy6mq
	 oURjgNWbM/R7X8+xaNEcLHMtLRTXu5pEGuoL4BfBRVAMluVBrR+2plwOJKGeHsewAlkcJ
	 fURtFw27c9mkXdIO3U8icR7JyhsWUyIbqOkIfopXjgWjjK2peDixbGh7+EJZahisoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SOReZjn4;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143C606A32E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 15:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F143C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SOReZjn4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538F6339;
	Fri, 13 Nov 2026 07:39:23 -0800 (PST)
Received: from gentoo-vm (kajpuc01-mac-mini.manchester.arm.com [10.33.9.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 718E33F85F;
	Fri, 13 Nov 2026 07:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794584366; bh=8nVoOAvDSYurW4p45koPq31BX2GIkyagHKY0KrKsJQY=;
	h=From:To:Cc:Subject:Date:From;
	b=SOReZjn4djklcugPwZmM+0b0Q9W6n0lMlvB5NxF6T7IqIhav5olbdcCnG23OHWeam
	 jqkuYUe4EDwI7rApBLdr+0zDV6ZQp7D5v0mA0F2hcQLSy4VwZZ8/OsPrdIFGnIVKtX
	 XcwYyy9aDiASb/XR1zzlcMnJkjZ49usd4ZfA9ERU=
From: Kajetan Puchalski <kajetan.puchalski@arm.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	kvmarm@lists.linux.dev,
	Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH kvmtool] include: linux/types.h: Add 128-bit integer types
Date: Fri, 13 Nov 2026 15:38:47 +0000
Message-ID: <20261113153847.60183-1-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.51.0
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

The tree no longer builds on new systems (e.g. latest Fedora images)
because the included types.h is missing 128-bit integer types.

Add typedefs analogous to Linux commit 10a47fb67340bca274276faf855d7 to
fix the build failures.

Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
---
 include/linux/types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/types.h b/include/linux/types.h
index 5e20f10..1b71001 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -5,6 +5,11 @@
 #define __SANE_USERSPACE_TYPES__	/* For PPC64, to get LL64 types */
 #include <asm/types.h>
 
+#ifdef __SIZEOF_INT128__
+typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
+typedef unsigned __int128 __u128 __attribute__((aligned(16)));
+#endif
+
 typedef __u64 u64;
 typedef __s64 s64;
 
-- 
2.51.0

