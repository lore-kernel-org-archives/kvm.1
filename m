Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E23B19B3
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274359; cv=none; b=SzWKfzu6bbgC11wFZdCkE00kwu6BqSNYqfSkgKifIu3xU6UsM3IdDgmhko2Cf07NhkPM/EajCJwFoGjvBX3qiF/PWqIgC9tSBjW9gPz+H9bN+26nrDbzZSQAkGlJRepDHWHATAJv1Z8uh1PWZSKh7ORQsvAw4Sqxln7CS00rXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274359; c=relaxed/simple;
	bh=cIYLTjtgFewfb8VCd4Ljs/8A0sFXM7Y3Ms/8M4d/oy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjWT+RnhqUXl1VkIENtOg4B9KBpvfPGoClSKepbDLic0tfXwE7PtiyLwHgju9o1WEHVVEA16fMIClW2H58ApMujNYXN/anDNUvBfWjWLjAFoZf52466VQYJH/NsRbtji7zxDiD7AGzbOU04An4T1/aFx2sW/tLcbPZW5x9sKhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EdTpaeje; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EdTpaeje"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 01C4720B6F12;
	Mon, 23 Mar 2026 06:59:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01C4720B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274357;
	bh=JjZO2/X3lUM54v7gEfoxaHgi6BZofDR2FWQNRjmIZ3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdTpaejezyNCqSnBHdwFIFM4AsUnJFV6TB9ExJskiAIaH2I/xiWhRE4gcvppAbvkD
	 OvbDelpoc+sNVyggAWiHp3Vpj5sm6fb+J+iD6MuaLub0HMX3QBgcxqlDRkven0BVrn
	 FjGit/rrNlDterxKu/jRGDcqzhWk91DeO1Po6G9c=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 16/32] target/i386/mshv: move msr code to arch
Date: Mon, 23 Mar 2026 14:57:56 +0100
Message-Id: <20260323135812.383509-17-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSR code is x86 specific, hence it's better suited in the arch
tree.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/meson.build            | 1 -
 target/i386/mshv/meson.build      | 1 +
 {accel => target/i386}/mshv/msr.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {accel => target/i386}/mshv/msr.c (100%)

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index c1b1787c5e..e433187cde 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
-  'msr.c',
   'mshv-all.c'
 ))
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 5eb6e833a6..f44e84688d 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -3,6 +3,7 @@ i386_mshv_ss = ss.source_set()
 i386_mshv_ss.add(files(
   'mshv-apic.c',
   'mshv-cpu.c',
+  'msr.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
diff --git a/accel/mshv/msr.c b/target/i386/mshv/msr.c
similarity index 100%
rename from accel/mshv/msr.c
rename to target/i386/mshv/msr.c
-- 
2.34.1

