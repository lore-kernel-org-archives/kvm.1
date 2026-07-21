Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8462D7393;
	Tue, 21 Jul 2026 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601785; cv=none; b=Yu5rPVwmJQsFaI7bTq0g9II5yC2Gis/YVpooiHdibsb0+7nlYb1Awgw5XliaqpdcMlAvUCZNvwSW4BbNd7pDYVWtVAgg4Gd4/4yz6nHotTHst9cse9W+SmEQoWjSyoEKM1ubFH/zhdCtx5od3GAd2ZDRY1eM5QvZWOK7xvp+KOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601785; c=relaxed/simple;
	bh=m7jHSw4SqwyF7lMCiErlAMUOJBlU7JCFx/9Ps9obcSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwhZYgdJ6dQ6g6SZcA18js6LHVVwbFroUgUsKHjyX6upnlasbNAq9pkDiyV4klknk51j1zr6cqOzHFbK1Nql442tbfD37Z2OV8aQpaIKJqsViyK87DgjNszGVJ63PvCuAD/SlLTVN13j+H4ewSYD/iYM/w1QHr2bQN6UmrY50v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Peg+rs5Q; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Peg+rs5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=m+8JTRBvx7
	CawRlsSGYTxEAZAMVDmdikPetKF3KHcLA=; b=Peg+rs5QDQmMYlZ1v/lrV+5nKU
	vuDPvGQps8AOAm3RSHgRzR7cM6fToQNI6Vb6FG67DllnG8v9fuVPyfKtM/K4XnTZ
	4dtyakybTkrol/BuYAoSx+qiC851L9WRpYlTco4TtRIiMhaZ/bwLUKiq5sabwPkU
	3H9dwpN4bcE6BAKmU=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUK53F5qgV8UAA--.17631S2;
	Tue, 21 Jul 2026 10:43:06 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>
Subject: [PATCH] RISC-V: KVM: Add SBI DBTR extension forwarding
Date: Tue, 21 Jul 2026 10:42:36 +0800
Message-ID: <20260721024236.14761-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3cUK53F5qgV8UAA--.17631S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry5Jry3Cw47KrWfWryrCrg_yoW5ZrW3pF
	4DCF1qgrWrCr40g3s7Jrs8uw1Utw15Kwn5tryDWryFqr12vry5Jr4vkry2krn8XFWrXFyS
	kr40gFn5uFs5J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAOB2pdm1EAHAABso

The SBI headers define the Debug Triggers extension and its function IDs,
but KVM does not currently allow a VMM to expose DBTR to a guest.

Add DBTR to the KVM SBI extension list and forward its calls to userspace
through the existing KVM_EXIT_RISCV_SBI path. Keep the extension disabled
by default so that userspace must explicitly enable it through the SBI
extension ONE_REG interface before running the VCPU.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 1 +
 arch/riscv/include/uapi/asm/kvm.h     | 1 +
 arch/riscv/kvm/vcpu_sbi.c             | 4 ++++
 arch/riscv/kvm/vcpu_sbi_forward.c     | 7 +++++++
 4 files changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index c1a7e3b40..53406b02f 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -104,6 +104,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbtr;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 504e73305..047d82f05 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -221,6 +221,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_SUSP,
 	KVM_RISCV_SBI_EXT_FWFT,
 	KVM_RISCV_SBI_EXT_MPXY,
+	KVM_RISCV_SBI_EXT_DBTR,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 46ab7b989..ed21239c5 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -70,6 +70,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
 		.ext_idx = KVM_RISCV_SBI_EXT_DBCN,
 		.ext_ptr = &vcpu_sbi_ext_dbcn,
 	},
+	{
+		.ext_idx = KVM_RISCV_SBI_EXT_DBTR,
+		.ext_ptr = &vcpu_sbi_ext_dbtr,
+	},
 	{
 		.ext_idx = KVM_RISCV_SBI_EXT_SUSP,
 		.ext_ptr = &vcpu_sbi_ext_susp,
diff --git a/arch/riscv/kvm/vcpu_sbi_forward.c b/arch/riscv/kvm/vcpu_sbi_forward.c
index 5a3c75eb2..8ac31b53f 100644
--- a/arch/riscv/kvm/vcpu_sbi_forward.c
+++ b/arch/riscv/kvm/vcpu_sbi_forward.c
@@ -26,6 +26,13 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
 	.handler = kvm_riscv_vcpu_sbi_forward_handler,
 };
 
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbtr = {
+	.extid_start = SBI_EXT_DBTR,
+	.extid_end = SBI_EXT_DBTR,
+	.default_disabled = true,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
+
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy = {
 	.extid_start = SBI_EXT_MPXY,
 	.extid_end = SBI_EXT_MPXY,

base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
-- 
2.54.0

