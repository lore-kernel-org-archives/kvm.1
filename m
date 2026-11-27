Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798969;
	b=rAbUShdCpN0BQrXMs5Oxx37bg7b/vugAjOsnxyjyDhB8HB/OJFWec/QUDGlTjbzGaJZr
	 ism4Sbg00kOamhJQyTbYFUL9CX89CotB9KmppNeHOKCNani8K3A2PK62ArPmO7KBZrizn
	 2k6DbdCO/YxMjzdPogSLo7Y5K03Jz0v/85SJIgjDjXFjObECmxzTIzG/7F6R/ekAFrum+
	 n7oL23FNWzMigjgU5Sm7xzUuGZ+/xh5WKdvFEAjulsrh+prCihg+kru0QCQxAufN7c35y
	 PjuZt9Cm9/haQP0J3ot20JfsJ1TgLfNRCL6JS3kDpwZ4mMlyf2hpRTvD6DlW/vIvRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798969;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Vh6qjgrB4qBHSHWwGeEBUR8LutRinekpz7r78CiFis=;
	b=IukbbkoyOrCFxAOGHDRQ7d0g3+McR22HjIfeRUQIoH2250QgN7qcIJ1XblbQiykEDLxr
	 JB1zmDuN/xNbCIiZCTwMmgUdqCcT24cWd4rBKFjz4CBDtWB9bTs559hlRbMXPvJw///Sw
	 q0n+9ICyVagEGsE407iZOG0V2JU7VB2VmbQrLOUxlwl6TBTQvRvam15jrT0ag6f8fPWXm
	 Ju/mci6FWodlm+JUlD3y4pQdOsbO2tHmDXC83ck4IlFXCgGkkPmx1wN84BmO5wcU3f3go
	 Wo/vj03FzS586FgoeQqDlGnVAdZMce2ajnMPbddrWppXD1oIHlhri9xvE5aUO01wkzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ol1wqFlX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFDF606A686
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFDF606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ol1wqFlX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860E21758;
	Fri, 27 Nov 2026 09:02:45 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B983F632;
	Fri, 27 Nov 2026 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798968; bh=Xmglt/Yg6C5I/Cs+laJXteXwqEDtO4aitLEy1M2ooSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ol1wqFlXZ+RszrcB0UZEkD5pbXB7y98CkjHzMFc6g0mE9sSFhnJImy25NIY9c7y/A
	 +CxceIA0BrjHqggnBYs2qkIcj3GgL02olnXPwpQNDz5rkUo5bGLoIw8IyZlfKfWKqo
	 iefA81Qu89NxRlVHGcjxR+0MmWJEqjX4LC72scvo=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 14/23] arm64: Describe the GICv5 CPU interface in the DT
Date: Fri, 27 Nov 2026 17:01:36 +0000
Message-Id: <20261127170145.4138182-15-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127170145.4138182-1-sascha.bischoff@arm.com>
References: <20261127170145.4138182-1-sascha.bischoff@arm.com>
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

Emit an interrupt-controller node for the GICv5 CPU interface. This
provides the interrupt parent and allows guests to use PPIs.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index 83b034e3..9a8f9916 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -519,6 +519,8 @@ static int gic__init_gic(struct kvm *kvm)
 }
 late_init(gic__init_gic)
 
+static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm);
+
 void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	const char *compatible, *msi_compatible = NULL;
@@ -549,6 +551,8 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 		reg_prop[2] = cpu_to_fdt64(gic_redists_base);
 		reg_prop[3] = cpu_to_fdt64(gic_redists_size);
 		break;
+	case IRQCHIP_GICV5:
+		return gic__generate_gicv5_fdt_nodes(fdt, kvm);
 	default:
 		return;
 	}
@@ -582,6 +586,22 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 	_FDT(fdt_end_node(fdt));
 }
 
+static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
+{
+	_FDT(fdt_begin_node(fdt, "gicv5-cpuif"));
+	_FDT(fdt_property_string(fdt, "compatible", "arm,gic-v5"));
+	_FDT(fdt_property_cell(fdt, "#interrupt-cells", GIC_FDT_IRQ_NUM_CELLS));
+	_FDT(fdt_property(fdt, "interrupt-controller", NULL, 0));
+	_FDT(fdt_property_cell(fdt, "#address-cells", 2));
+	_FDT(fdt_property_cell(fdt, "#size-cells", 2));
+	_FDT(fdt_property(fdt, "ranges", NULL, 0));
+
+	/* Use a hard-coded phandle for the GIC to help wire things up */
+	_FDT(fdt_property_cell(fdt, "phandle", PHANDLE_GIC));
+
+	_FDT(fdt_end_node(fdt));
+}
+
 u32 gic__get_fdt_irq_cpumask(struct kvm *kvm)
 {
 	/* Only for GICv2 */
-- 
2.34.1

