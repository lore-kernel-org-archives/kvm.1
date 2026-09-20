Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C953FCB10;
	Sun, 20 Sep 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903346; cv=none; b=oq1dJRcQAiwinGvN99s+x37QvRCFhS+5roenxb9/92Z5cFMC6TpTCrwvhZWOHdvLVK20uV7FI33rMJ8QEeEyI42np6rLrzJh9cNimjzZgP/HirhFcfEvMcB4HK9KNmndfIVXnx+3GAsSwW8DL/vSz6PptaOL8UNxmO8AHASGbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903346; c=relaxed/simple;
	bh=3wHsuhm1EOsX6FnaaZCz7S9AObKXD0J2nrSu7LVseb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgaXsPtGT389DS+HkabdQb8x/fwRe0FV7kjXBrstGv8+JMFAAckQb5dzXg0b6V1UKwUeA5ivpNUnsCQdg0Iak5UVEdcbCeeswA8951+LPLBkUhJw/WZV6GQrHFFsykYhj7zHDSYzCIxAGtbVcC37w74tblU2H2L1nDf5dMSu+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=mInm2XTu; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="mInm2XTu"
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68KBG36b088236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 20 Sep 2026 20:16:14 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xY3f7CW2k+sxURpCWyIEkta47r/Ail7h0q2vhhuON5Y=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1789902975; v=1;
        b=mInm2XTuQIO9C+YXeqfebcOFmmo0frr1Zm8g8p5z6Jq7UKBcwKjgVAAMFAfVJiUd
         xBenMftkF3iNMlA9lfJY3+/fWwDb25KsqHMCkpJxfIgzhWjYEBbHTAvPC4LvdadC
         HvvXchwGjR19oAIws8ZLHbg0Oi6lIWRSVuFi7nXBPkFJ3LuA9Ug+B8Rup7Sia7o+
         D0wcK8iqvjULQE2aTFv9oRsuQT/wCajOsPxekCfr6Hz6kwxXBQIM1SXQNu/1Abt3
         Mty7ERJ9aLaBleu2qmxKWuIyf/Lc0dLr8W57cIzhjjc5Eq71ClnHRD4nzz5BCieM
         xBbespM5NLD2jRJLBXhs9g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 20 Sep 2026 20:15:55 +0900
Subject: [PATCH v11 14/21] arm64: errata: Require Apple IMPDEF PMUv3 traps
 on all CPUs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-hybrid-v11-14-03618771b0e1@rsg.ci.i.u-tokyo.ac.jp>
References: <20260920-hybrid-v11-0-03618771b0e1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260920-hybrid-v11-0-03618771b0e1@rsg.ci.i.u-tokyo.ac.jp>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fuad Tabba <fuad.tabba@linux.dev>, Mark Rutland <mark.rutland@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fuad Tabba <fuad.tabba@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=3wHsuhm1EOsX6FnaaZCz7S9AObKXD0J2nrSu7LVseb8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b6A7lnUxVOBxxlDNxw5oBdoJXrzRyT78vT9ioa8B0NP
 PU2+VpCRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwEQ+xDP896rZWnpzyrw5Iu9n
 6q4y753/ZV/N7VDRi8oTLF7G1P8xfMXwT50rRNB9npSOKMParUeWf9G515Jh7jF7GafQ9MRvXSd
 3cAAA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

KVM relies on ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS as a system-wide
precondition for PMUv3 emulation on affected Apple CPUs. A local CPU
erratum is too weak for that: once the workaround is enabled, a late CPU
that misses it may still be onlined.

Make the workaround an all-early-CPU capability instead. The matcher is
still local because it depends on MIDR_EL1, but the capability is only
advertised if all early CPUs match. A late CPU that misses an advertised
capability is therefore rejected.

Although kept in the errata capability table, this capability describes
optional trap support, not a workaround required for safe CPU operation.
Therefore, a late CPU can safely match the capability even when the
system does not advertise it.

On these CPUs, ID_AA64DFR0_EL1.PMUVer == 0xf means the
Arm-architected PMUv3 is not implemented. Without the system
capability, KVM does not advertise PMUv3, and direct accesses to
architected PMUv3 registers remain UNDEFINED. HACR_EL2[56] only makes
those accesses trap to EL2 so KVM can emulate PMUv3; leaving it clear
does not make them access Apple's native PMU.

The native Apple PMU uses separate implementation-defined system
register encodings, which KVM independently traps with
HCR_EL2.TIDCP. Allowing a late CPU with extra HACR_EL2 trap support
therefore does not expose host PMU state to a guest.

Fixes: bed9b8ec8c71 ("KVM: arm64: Advertise PMUv3 if IMPDEF traps are present")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kernel/cpu_errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b33dccfafaf8..3dc598a9fdd2 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1020,7 +1020,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Apple IMPDEF PMUv3 Traps",
 		.capability = ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS,
-		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.type = ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
 		.matches = has_impdef_pmuv3,
 		.cpu_enable = cpu_enable_impdef_pmuv3_traps,
 	},

-- 
2.55.0

