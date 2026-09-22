Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E949C4BA
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104241; cv=none; b=uQlWTrfc0lp1V2ft4OSdr2puXVQJGoTNj1CFkWJHKiqbg2MTE9J2rpamku2rIpBDyxdBsBKvYSzIyMKMWdh5ptdHi4DnYzKy+YICJ7nXwNfxyUE0Tm/Z2qMESFmg08Us2n1mbqKlWtDXZoatSHNosgsv+Qge9dGOEZFrd/ifGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104241; c=relaxed/simple;
	bh=P6YpYcVjqzlTWqaL1DsSX7/44zZqy2lF9hUcMNRArnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBoB1Vp07Cv5Pl8BvgfaVK5b2EuNLueZ/WeBpA5T5WCG490aYOFKBLweWK+IwtIV5hByL2KsOcvRt2WKDB/E/aO98/R7nAM8Oq4M/8tbNzy383Ml81l93Hb4stUCKoK4EpTD9DOz+FZPWD+chYAg5JpAIk9Y+zZGFHr7zJzEa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=JW7b647z; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="JW7b647z"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id AB782834406
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 21:10:29 +0200 (CEST)
Received: from home.juju.sh (unknown [IPv6:2a01:e0a:1065:2100:52d9:65fe:2df3:c492])
	(Authenticated sender: ju.o@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id B9B0C60129;
	Tue, 22 Sep 2026 21:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790104221;
	bh=P6YpYcVjqzlTWqaL1DsSX7/44zZqy2lF9hUcMNRArnE=;
	h=From:To:Cc:Subject:Date:From;
	b=JW7b647zhS2DL1suERC29X4g8v6ZnFMlmwRdXKGyDvvAmbLo9xMmKrl8ErAuSPyNz
	 vvAoqMZ2h5EmiF7sgIVuvgRkxhq2Oj8ALEg4nBN7kBkoYcHtC7JhBG7whXYeBlGCL7
	 EJ4K6gezT5ryDGut28vsgtG17rlPkowWmCsFKWSl3EwJ1rbA6JnCdu2mdDuVpQ4ak4
	 93KLijhlDWEH3McNDiDkflbwut849HYn8jrTv950NUT1IIKsDm+R+8LalcE9jASjlJ
	 p1obQkJrm+xoLbEhhiTKxFypHI+Z9kdMRWx+6k5yKv+XWvYFLamDhpBPeX51EkbyvI
	 mDtFTZyLjYe/w==
From: Julien Olivain <ju.o@free.fr>
To: kvm@vger.kernel.org
Cc: Julien Olivain <ju.o@free.fr>
Subject: [PATCH kvmtool 1/1] tests/boot/init: fix build with gcc >= 14
Date: Tue, 22 Sep 2026 21:09:51 +0200
Message-ID: <20260922190951.1700996-1-ju.o@free.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running tests with "make check" on a host with gcc >= 14,
tests/boot/init.c is failing to build with error:

    init.c:6:9: error: implicit declaration of function 'puts' [-Wimplicit-function-declaration]
        6 |         puts("hello, KVM guest!\r");

    init.c:8:9: error: implicit declaration of function 'reboot' [-Wimplicit-function-declaration]
        8 |         reboot(LINUX_REBOOT_CMD_RESTART);

This is due to gcc 14 starting to treat implicit function
declarations as error, by default. See [1].

This commit fixes the issue by including the appropriate headers
(<stdio.h> for puts() and <sys/reboot.h> for reboot()). While at
it, <unistd.h> is also removed since it is not needed.

[1] https://gcc.gnu.org/gcc-14/porting_to.html#implicit-function-declaration

Signed-off-by: Julien Olivain <ju.o@free.fr>
---
 tests/boot/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/boot/init.c b/tests/boot/init.c
index 094f8ba..ea0d57f 100644
--- a/tests/boot/init.c
+++ b/tests/boot/init.c
@@ -1,5 +1,6 @@
 #include <linux/reboot.h>
-#include <unistd.h>
+#include <sys/reboot.h>
+#include <stdio.h>
 
 int main(int argc, char *argv[])
 {
-- 
2.55.0

