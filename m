Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09039409270;
	Sun, 20 Sep 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903080; cv=none; b=eWbjP6RIIq1kTOUnXsEOB2kgc43K5Dy2S5iuvgUGa1trCiVAWQdMB3TPv+2RpX4UCr3e5bUOmwZ/dKl1d7g1U5BbstXjdoo0eajtng+IDb5knvWiXmPeSfMGmiyTJ5p2GCCuNSSzI9lizt7GuQeugZCDNEUc1dRIcHc4ggX/t0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903080; c=relaxed/simple;
	bh=qrWSZiXd3NGTtjPsYculaMGwRl4ZEKcQtXcXafdCzEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtiimAYE1kUwAXGQCRbzKSzuMYEKlaxJ0fiz+nf6OPtWMa15s6ejpIrsCeHkr0EzccoZvetkbW4/bn4j9UQvdJHRk9FY1Essxgli+12yEB6Qna1TqVvy/9YyRWZWpp8EpVF+jU4VGG9+3fgqe4USAwsqT1S+PSVgqcVQrPZp0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=dh6UycQS; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="dh6UycQS"
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68KBG36S088236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 20 Sep 2026 20:16:10 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=y5pufUz8KL5hcXE3IG0sGufufg11jZLTck/NL8QaP+Q=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1789902970; v=1;
        b=dh6UycQSH3jQEGeCBbIxmEuSSseuoMtHkMcrYs8WZ9Uit1a4JeDZLqzUn2x2hhLg
         jVsxL53QR/x6CPuanzmV2Z2IU6rSFnTQKG7g3+quKEnX9RBhtNz8koXDUR1JSVp5
         lwt8PRpBLXOYv5TRLRHpVk/7l1oAoKx/h8jo4enMOsTaOg9I92CyzFGidQBP5Efe
         XB2VcmUYtUltw1Nnonu/2JcJkH6l6isVj21i1GV/DCGtj9bgq0bqoaBDMVwkdGmv
         PmA8OF0c022gWLlcabb703SRLQUtlvq+WDAT+DcNQgzCYEBrh3oPuWOAhijuE4Ax
         RKDCSyO20c87Dvmgt+OO/Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 20 Sep 2026 20:15:46 +0900
Subject: [PATCH v11 05/21] KVM: arm64: PMU: Mask EL2-reserved bits on guest
 bitmap reads
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-hybrid-v11-5-03618771b0e1@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=qrWSZiXd3NGTtjPsYculaMGwRl4ZEKcQtXcXafdCzEE=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b6A2mzvy3l7FFbOK3uPIvZ5NgboX8TJF+0xXw6bfBi5
 bUG0y6RjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIloVzD8T0kvrXlxb/ESN/1V
 6kbsy0umtcrf/Mv7Q+ez+arnrJ0pUxn+uxSz7Fm/62ta4SHWexOD/ovXNdfeZfWtqVhqlVuunPi
 bBQA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

MDCR_EL2.HPMN reserves event counters for EL2. Their bits in the PMU
counter-enable, interrupt-enable, and overflow-status registers must
read as zero at lower exception levels. The guest access handlers
already mask writes, but return the raw bitmap on reads, exposing
EL2-reserved state to the nested guest.

Apply the accessible counter mask to reads in all three handlers,
covering both SET and CLR aliases. Leave the stored state and userspace
migration accesses unchanged so EL2-reserved bits remain preserved.

Fixes: 9a1c58cfefb0 ("KVM: arm64: nv: Adjust range of accessible PMCs according to HPMN")
Closes: https://sashiko.dev/#/patchset/20260914-hybrid-v10-0-92788053a691@rsg.ci.i.u-tokyo.ac.jp?part=6
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 arch/arm64/kvm/sys_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 40927a4d4409..68339eb8a2bb 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1362,7 +1362,7 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 		kvm_pmu_reprogram_counter_mask(vcpu, val);
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+		p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
 	}
 
 	return true;
@@ -1386,7 +1386,7 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			/* accessing PMINTENCLR_EL1 */
 			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~val);
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+		p->regval = __vcpu_sys_reg(vcpu, PMINTENSET_EL1) & mask;
 	}
 
 	return true;
@@ -1466,7 +1466,7 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			/* accessing PMOVSCLR_EL0 */
 			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~(p->regval & mask));
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0) & mask;
 	}
 
 	return true;

-- 
2.55.0

