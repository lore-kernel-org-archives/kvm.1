Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214141;
	b=21WeRxfauNrAjk8qyK7CdCTjkSaLcuDwqej8P5xOD64h3rVqtP0uLfZFcYSdHcpwuCGo
	 8Xmi0TZ1VvpSDnXc80PCJ0r9IOKL4RomCZLf2JCYzCp13q7gGfSPW4PdiJ2U9SniJ+IKt
	 4AR+Gqpl1gvPiEBT9PS76r2MLY7HWE5HM+lgUznvwmdWdNNMPqYfLZkotYIrPapr8OwIK
	 XR2t5Fx9UaAks3xY8I2Z9mV5sD9I9L4BQ94s1tx1G+AKKxZ6q3jTJj3O3QTXG6Q+ar1s2
	 P4QKDUNo+5di/DR6taESTi88zmjntzumaB3MHmp74oppaPYyqHqawnMLl8N/KfcqCtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214141;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wgtb9kfhJDQT6OIlDEFANW5PARd8orgbcoPjl6TcZEI=;
	b=aHmhWevwtYnkNoZaFbt+1cmTXg4YJS/+0xSFGD6GqrYT4Q68sN7ijKv4QkZ6FCWnregN
	 kyFqtq1oTlO/eV0XycDGAmPet4T2EZCfaN6Bk7286pQCK2JLpHjr1gIuGK+xFMPkydUgE
	 BCCR0Q5sx+Yo4pi0tALhxRxlRFqOObD9OGY4qUR/qDaCAC/bi8b2dHGvcUkFSNGMA7b9Y
	 Fk8LQX+iet8Q2kVdU6QJX6+F4CYMfYAqIWcv/2B3uJ0ueG7/NF4ums/DJEcaIqIYduCFn
	 LqJmY4cIcSSL5iibSMNhBGcmLF9lmL2qxpGRdyIZYstuu83xnAhHsKrBkzij8QyN9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xUE2XDbC;
	arc=none smtp.remote-ip=95.215.58.124
Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF66606D828
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF66606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xUE2XDbC
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zy9OoZoEVLZKrHt/PA6PNvYObGqJuDPk1PHvlEStbBI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214138; v=1; x=1794818938;
 b=xUE2XDbCaqBbVKskeiKy2ftjBsKJBTjKsKOUk3+AlUEt800GCDkt+XLsEzrDPP4++oLUe/Sc
 kltUsxIjUnyLZX/zbQFnEsrGZZLrBklow/92IZhTy3ulWM/mwL0qmesvCjtoWfPhMe/g48rfIYK
 YB9fG3I5Rk2G+j5CGS1UfY6I=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d8a3008bccb79f4a;
	Mon, 09 Nov 2026 08:48:57 +0000
X-Mizu-Trace-ID: d8a3008bccb79f4a
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] tools: arm-smccc: Add the pKVM memory sharing function IDs
Date: Mon,  9 Nov 2026 08:48:39 +0000
Message-ID: <20261109084854.840576-5-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
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

The tools copy of arm-smccc.h lacks the pKVM guest hypercalls that the
protected-VM selftests make.

The kernel's arm-smccc.h defines the vendor-hyp UID with UUID_INIT(),
which requires linux/uuid.h, and tools doesn't have one. So rather than
sync the whole header, copy the function numbers and IDs of HYP_MEMINFO,
MEM_SHARE and MEM_UNSHARE from include/linux/arm-smccc.h.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/include/linux/arm-smccc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/include/linux/arm-smccc.h b/tools/include/linux/arm-smccc.h
index 63ce9bebccd32..8c8f4ad639018 100644
--- a/tools/include/linux/arm-smccc.h
+++ b/tools/include/linux/arm-smccc.h
@@ -111,6 +111,10 @@
 /* KVM "vendor specific" services */
 #define ARM_SMCCC_KVM_FUNC_FEATURES		0
 #define ARM_SMCCC_KVM_FUNC_PTP			1
+/* Start of pKVM hypercall range */
+#define ARM_SMCCC_KVM_FUNC_HYP_MEMINFO		2
+#define ARM_SMCCC_KVM_FUNC_MEM_SHARE		3
+#define ARM_SMCCC_KVM_FUNC_MEM_UNSHARE		4
 #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
 #define ARM_SMCCC_KVM_NUM_FUNCS			128
 
@@ -133,6 +137,24 @@
 			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
 			   ARM_SMCCC_KVM_FUNC_PTP)
 
+#define ARM_SMCCC_VENDOR_HYP_KVM_HYP_MEMINFO_FUNC_ID			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_64,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_HYP_MEMINFO)
+
+#define ARM_SMCCC_VENDOR_HYP_KVM_MEM_SHARE_FUNC_ID			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_64,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_MEM_SHARE)
+
+#define ARM_SMCCC_VENDOR_HYP_KVM_MEM_UNSHARE_FUNC_ID			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_64,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_MEM_UNSHARE)
+
 /* ptp_kvm counter type ID */
 #define KVM_PTP_VIRT_COUNTER			0
 #define KVM_PTP_PHYS_COUNTER			1
-- 
2.47.3

