Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1653B38AE
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423447; cv=none; b=TKfGQvIA1XopdYPM4Ml76EcNqD1Xe/ZoaUnCunpaWXkRns0PquQhm3VC/FHB/LPvipX7Fs7tKvL5yB02eErebzZtc7xL7Z2Ym4cJv/Ay9tYA2+sIX59iPnUTOnBY9bPuXZKCpX4YN1Zezcn/tO6GCUE7fSXOlV172PGDqY2Hmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423447; c=relaxed/simple;
	bh=cIYLTjtgFewfb8VCd4Ljs/8A0sFXM7Y3Ms/8M4d/oy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhX6OicHJQHx0cVAfvSKdOuzmukYIpPACodEgVttSSpCjT6Ch1wGjvwOBXoNRLlJl32Z24C9oDw66yHU79idUPsbRMzN3EvVXGJZTzZRo/QoZLw7y0AJCDCaAsH4dbKmIrnuRkTYdWUs1MwE29NWW5R3e+CGsaz1hh0Bw8KzJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qirjhkdQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qirjhkdQ"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id B5E3620B712D;
	Fri, 17 Apr 2026 03:57:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5E3620B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423446;
	bh=JjZO2/X3lUM54v7gEfoxaHgi6BZofDR2FWQNRjmIZ3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qirjhkdQcMzjLk6HfksO0+ovH184o9WCffMpzPW296JKa5yVkHlaEy1qGtHCyh4aW
	 Uv5yG5+j6MvT6Ng6DxBADhs8pInRDfg29mMyFNJ2k5dDgG7sm2AMLw6GFJngvz/DIz
	 BAg5FK4FLfYF+d97VdoOh3SOf/OUINhwVSsrbIks=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 17/34] target/i386/mshv: move msr code to arch
Date: Fri, 17 Apr 2026 12:56:01 +0200
Message-Id: <20260417105618.3621-18-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
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

