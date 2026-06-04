Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D982DECA8;
	Thu,  4 Jun 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584431; cv=none; b=lFI58ohLIKgcLc/6uqimCGwIyQ32oqKS2LqGp6MbACrT0VV1nEDLmxLBN632Y2GT63kT0vJgym5zJNEW5INF3aJtez1zpHtSsHwiGkJ+wF0cbyegF/5weuNCIWTmn+9uAiFDWALPTeWIY4q+DzKrYCZqNTe4yHgL9a2DyHoGfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584431; c=relaxed/simple;
	bh=ihjr7JZE3Rc6QulXDrVgP78SebhupyaSgDGbP3vaUx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPOJuZDG6ibCY7uFaPoELrhUDamg8mw3MHiIiIz64XjHyybJu7Zqv1Vx6O59dgJZZjBL6BA0yyReOFAjNHOSbvce1o2vAHdsvVlOjQCxHZpR/+CUwe09zKCnF8u+XnQbriHTsPt+AHKt7YfIL3Lp8sr7hqptRYYZE/+Nzflg+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcKfsXnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcKfsXnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C06B1F00899;
	Thu,  4 Jun 2026 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584428;
	bh=zwAPdL28tRT20RU91rOpnxQutL6tmD2RH9JzhOdrOos=;
	h=From:To:Cc:Subject:Date;
	b=AcKfsXnX7LlEagQRAA01hHw/MCGNwx1bL20deXKUfu+6TSTz5FGB578WtJFx2gl9V
	 v89U01yTjtCv/7EgD2Zysg3zpMBQkX0zZeZIKojQucQbuvo53yk4HLoFgIExLZnwHL
	 pdb8Ed3D/jhK8TWJAvXjRc1Vm3bpQkEnh2crPvEDZnsSS73b8v7YxGoYDQ+Ze8y5fZ
	 fiY+OverPqEZFMlhLu2KZi7pxarzBOXXDQ6+wiyEkc6dHh0m7BheJxIei+TWYuc09p
	 t10hP6DaK0BGtQtbXVoSM6c0hFLGjq6W0cbeu6zcyRjh4A0vM/BfikIZ6QqR1h6RvR
	 hrSloSRajBF8w==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97A98F4006A;
	Thu,  4 Jun 2026 10:47:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 10:47:07 -0400
X-ME-Sender: <xms:648haqr4IMz011FZZDFwd0NDMobU0bNqKhw6wezy0qorXn9cZ_pZgA>
    <xme:648hapBQOfwqFffh5BS0zbsvd8I6V6GrBCVbBEIOiSOv334uQg1MLWLbt4PO4weYs
    O3ry_AZbRzYfpuI_wZ4Gj4h1oBHR7bZWk1o67R3TSjaAeKWyWrbeg>
X-ME-Received: <xmr:648hagW7QoZh_CbIg2dSxAjZdKhTI-CkMtMuEiQ1vLrdG700TjUOG1hpnLrvug>
X-ME-Proxy-Cause: dmFkZTGTTT0Z5b/U2b9Wd16I2SZxqlDnRu4pGpWLFn678Q4Ulhh2h2wXsczY84SDn6tAKF
    zZU7wb/zGLx51KkEBlfYc/1V21Tf4BqzGJ5U6cbpipd6YYOKc9qzKgNvRb3ScGeE47Hmrg
    NmOF7PDVhY0QcsGdVzB8l4Lmz3AXOeujMa2yAIAo/YMFiJGYVNNi7/4nn6L6Jq6QiqMgn9
    1r0VXI7mYBZ0MrbPX3WAPlts4/ulRRaHDIqU6Ym7EddGkKX9XiK1nZBdkugvMwfB3Vu3uo
    yicL+RBeWIDDvv9EVkHCNuVDXCWZe4S/yCTz9ZRz12ah7LxqSzGS5DHl64mxfLDK3NGFRH
    NLIYt1VLxxR1mOdnUdqlXLErhOnzBOnZ/5+vVIsmUPDSU4i3GD0rbvKVH3xvYVfcXamtEP
    Qce0EF4WpwFMd5GCc4vwY0PPYFiTV9/LDF9zsBqtcSTbKGDDW8be29/Z/Nd8pLAcnBK59E
    HC1J+mOeQ0Cy4wqJFoy6410D8VIEwHZOO2Zd0TxIjyycCm/UJj6fFKWN0JZHQaV9z7VJtQ
    oW+0duoz+acWsXTmdOi7VHHqGtJqGTPKvH35KUWuu3gM0RLqsa+AcL1DscKnga5a7aq7t0
    QTqi8QXZkDtX8VqU1MN1XuZ6pwAYcEiQDcjgnIb/+xEPs/gQjfEJPx+FyaMQ
X-ME-Proxy: <xmx:648hal7Q3XqoqkudtzRRHHLQA5xPanpIi_JQVcyppIJY4K56WMWx5Q>
    <xmx:648hapAwfc9iOinmIgUAVFgVwECyD37eEoO6b4Y90FsLzylpkUEMMQ>
    <xmx:648haiC1aiFLq7NdCzObtJSbzIFFZuK25hldWyrl-pJqaZGM70JXiQ>
    <xmx:648hahh8zxge2ErRF9tcVrP2h8gkNuUvKrd9--mN_Bcl_4Jn8kOPjQ>
    <xmx:648hamctYkvVOkTwJmQD7y5K0K0zEZ5WPuW_--g_k7-JfCZhXSvrPh7C>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 10:47:06 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kai.huang@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	rick.p.edgecombe@intel.com,
	david.laight.linux@gmail.com,
	ak@linux.intel.com,
	djbw@kernel.org,
	tsyrulnikov.borys@gmail.com,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v4 0/3] x86/tdx: Fix port I/O handling bugs
Date: Thu,  4 Jun 2026 15:46:58 +0100
Message-ID: <cover.1780584300.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs in the TDX guest port I/O #VE emulation, plus a small helper
extracted from KVM to avoid open-coding partial-register-write logic
in the second fix.

Patch 1 is an off-by-one in the mask used to clip the I/O value:
GENMASK(BITS_PER_BYTE * size, 0) is one bit too wide. Unchanged from
v3 1/2.

Patch 2 lifts KVM's instruction-emulator helper assign_register() out
of arch/x86/kvm/emulate.c into <asm/insn-eval.h>, renamed to
insn_assign_reg(). Dave suggested consolidating rather than adding a
third copy of the same partial-register switch; the body is rewritten
using plain arithmetic (suggested by David Laight) so the helper does
not rely on -fno-strict-aliasing or little-endian byte order. KVM
behaviour is unchanged.

Patch 3 fixes the architectural zero-extension of 32-bit IN: the old
mask-based handle_in() preserves RAX[63:32] after inl, which is wrong.
Now done by calling the helper.

Changes since v3:
  - Patch 1/2 carried over unchanged as 1/3.
  - Helper extracted from KVM (new patch 2/3) and used from
    handle_in() (Dave, David Laight).
  - Reviewed-by tags from v3 2/2 dropped on patch 3/3 because the
    implementation changed substantially. v3 1/2 -> v4 1/3 Rb tags
    preserved (patch unchanged).

v3: https://lore.kernel.org/all/20260527120544.2903923-1-kas@kernel.org/

Kiryl Shutsemau (Meta) (3):
  x86/tdx: Fix off-by-one in port I/O handling
  x86/insn-eval: Add insn_assign_reg() helper
  x86/tdx: Fix zero-extension for 32-bit port I/O

 arch/x86/coco/tdx/tdx.c          | 10 ++++------
 arch/x86/include/asm/insn-eval.h | 25 +++++++++++++++++++++++++
 arch/x86/kvm/emulate.c           | 26 ++++----------------------
 3 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.54.0

