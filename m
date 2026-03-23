Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2E3BA248
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274411; cv=none; b=q3R3QAAOTZJxzuGuRayKRs6+iKva4WN1gRBPL8Lkk8BebGqLbEuFEPRkVg/5F26YcVJP7+tLbhx2xYHcWUAluE1Gwv3Nr/HBaG3nFeexw41bSWalXZEQnTst4fV4rZ5llnSFMkdedmurG3tba/ye5Z+Luyh3Jk4vSEuZuXhGiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274411; c=relaxed/simple;
	bh=BjWgCMOaiyNqotzKpoIcqevGunQXmxWTHvw2TFXp0MY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYQAdzCMi+duoCP/YZ97TuuwAR5nqQq8ivAV8o9TVVtrqgIW+w3O/KpARB+xmtx4plhdZjl7yDuPagLPSCQccBKK85JJrlbDEgFzbhI1/Ouw5xf/eaNBhAydZVjOPwquenwHH1MuFI2Sa7js0ClnlAuHJgPX8mwitV6ReHESC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NnAdnNO0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NnAdnNO0"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id AD06220B6F15;
	Mon, 23 Mar 2026 07:00:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD06220B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274410;
	bh=i1SaRdeL8nyaeXZZpzUNqErLAZluVvPxmogP/V/TiJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnAdnNO0JkPCxghel2ozc28fvTtEn1BuZVgT0SHgDCMhWsoWNoHNtGTFtjkFC2tyG
	 ma1lXudtzN9B1ql+G9K7y15vCNc7QMxg0+MVosPeW4zHaUWi/Lws7GbKsZ590ashrG
	 IG4E2VAgl1qE9rljl1yM5La1Gt2cHJkzNGng4NN0=
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
Subject: [RFC 30/32] target/i386/mshv: reconstruct hflags after load
Date: Mon, 23 Mar 2026 14:58:10 +0100
Message-Id: <20260323135812.383509-31-magnuskulke@linux.microsoft.com>
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

hflags is a cached bitmap derived from standard and special regs. We
want to reconstruct this state after regs and sregs have been read from
the hypervisor, similar to how it's one in other accelerators.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index dacc33674c..80e5dd5a4b 100644
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

