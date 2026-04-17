Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C23B8BC5
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423503; cv=none; b=m7oviHncUNr42hUwHMnKJu/h10XGXrxYfXeNcAevhAP9faz170Csj9pLc0rhY6T7i2nbppW8IN6CIeIsQH3VIi6OIMD3rlZGKKnORf/Tq8ECSBED66drNVboPSSz8ATF8yf8Hx4M6Z9YhTvP6ruNxOgDiWYJnhiCJMKXKEMSrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423503; c=relaxed/simple;
	bh=fB9ZTInSYkFLI+3MMP9QMBnEY33X00wg1kYW1YMcz+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPn3P9jt45NG9wGmAUO7exkwPuzh929C6j4ATUgty9FaZMcc4SEkM6j4kZym6vjbKszevMpnwKfsuOvagyCCF6XljuVWAKxzzULsS5APcd1Xmjbfz2Z20nmUTM9ndX1jJ03aPegwvtvkPeyR6yd1KebBwM01xz8C5wlpMjNGsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=No5AIdA1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="No5AIdA1"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D26B20B6F01;
	Fri, 17 Apr 2026 03:58:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D26B20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423502;
	bh=V9VhK8lNuWgkT8PAFGiJyPXqshNdYzIlAfLrYorq9+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=No5AIdA1m4jNMrDjaMfxmZ7+z3OcMWjLsmW/zzj7MD4LHUH/eXsc2wDlMEKSWq5Qi
	 WfNekrNgnwYExVWenIMR5taRplwP75wBGGIAIs0E2DA0CTeeCzNkj1m/adG4AxSQkU
	 m0aVUpo0rtSG3GoOepzeRzpUaUK4gBEap/ZgMOAA=
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
Subject: [PATCH 32/34] target/i386/mshv: reconstruct hflags after load
Date: Fri, 17 Apr 2026 12:56:16 +0200
Message-Id: <20260417105618.3621-33-magnuskulke@linux.microsoft.com>
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

hflags is a cached bitmap derived from standard and special regs. We
want to reconstruct this state after regs and sregs have been read from
the hypervisor, similar to how it's one in other accelerators.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 5b0b8bda16..463bf7efa0 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -814,6 +814,16 @@ static int set_vcpu_events(const CPUState *cpu)
     return 0;
 }
 
+static int update_hflags(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
+    x86_update_hflags(env);
+
+    return 0;
+}
+
 int mshv_arch_load_vcpu_state(CPUState *cpu)
 {
     int ret;
@@ -828,6 +838,9 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    /* INVARIANT: hflags are derived from regs+sregs, need to get both first */
+    update_hflags(cpu);
+
     ret = get_xc_reg(cpu);
     if (ret < 0) {
         return ret;
-- 
2.34.1

