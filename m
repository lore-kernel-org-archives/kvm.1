Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866858;
	b=TUPffHPtHkl0w/iPAHZu/6M9AmTf+7xsg2l/cismKA2nn3KYPrCprUjoBSetrh9WDZ21
	 MOwxNwXj0dlLSoeJRYzTpz/TiwhLngwvGh9G6LmqvwHgEiLKiFBZ3GLZgivFBBMbhnqke
	 EhG+DoBYG48Z2gEtmiC6CX+2yZ64fsltSlK+F+9aZtDsQyS4vfItPCSFPjQDbrJW+8HV4
	 lpaRZt3pXqtGR8dT8ubmDS4eGL5BYC+tRfFnVLaq9IV5qUzUUlxtTiAAdhDJco/CwvEyF
	 dIH/PM2ihXsBHc3S/GUVnq7u1pJQGbfAb0cP+tKkoM2YuxtrfjjWZzk5d5EPVeLWY3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866858;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=EUXbF0JkXKGQkuVAi7lHPlJZC0WyH93OL3Jr+hT03Z0=;
	b=mDhz688ecOaN6x4xwMjNNcuBg5tKNWMQAg/gnQ/WcYtQbTzEmVCc1DAczavF/hynA7tP
	 QzVW6an91rFPSLc6HCoHH4RR9G86FBhe3CphmvteNWmrbVodHUIe2qAXFi95jfaTJ/xCN
	 UnrJpEe9/Pv4F2zj4Zv3QjZrTAauZGshsKHiUYjAQ0OnPoQWP61YBYLXr6gOuCp3zQzuQ
	 XUIfzqBqGHegdirxaib+vYI7O3boyOUWTS98KgrLVo+ev7wvXvRxYTJ1lNokdIEn2lUIM
	 +sApRZkj3d0ncTdWBjXZb+IyMtV6T4jGLtuUaylVaSSUdWXR/cLEqFTLSvgvPeqmnRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED6606A32C
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40ED6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowAAHL_laPOxq5idRAA--.3347S2;
	Thu, 05 Nov 2026 16:20:42 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 6/8] riscv: efi: Allow ACPI boots
Date: Thu,  5 Nov 2026 16:20:33 +0800
Message-ID: <20261105082035.133680-7-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAAHL_laPOxq5idRAA--.3347S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1DtF18CrWxur1fGr1UGFg_yoWfArc_Cr
	Z7Aa97ZryYqFZrA3WDJrn5tF1rGws3Wr1DZF4UKF4jk34xWF1Yk3yqkr18A3WrAFyDGrn2
	kwsrJay7Gw4kGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU29a9UUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

riscv/efi/run rejected EFI_USE_ACPI=y because CPU, timer and ISA
discovery aborted without a DT. Those paths can now walk MADT and
RHCT, so drop the early exit.

The existing runner already omits -machine acpi=off when
EFI_USE_ACPI!=y. QEMU virt defaults to ACPI enabled, so no extra
acpi=on flag is required. DT boots are unchanged: they still pass
acpi=off.

Tested with:

  EFI_USE_ACPI=y EFI_UEFI=/path/to/RISCV_VIRT_CODE.fd \
    ./riscv/efi/run riscv/riscv-brs.efi

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 riscv/efi/run | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/riscv/efi/run b/riscv/efi/run
index b9b75440..a53b3a2c 100755
--- a/riscv/efi/run
+++ b/riscv/efi/run
@@ -39,11 +39,6 @@ if [ ! -f "$EFI_UEFI" ]; then
 	exit 2
 fi
 
-if [ "$EFI_USE_ACPI" = "y" ]; then
-	echo "ACPI not available"
-	exit 2
-fi
-
 # Remove the TEST_CASE from $@
 shift 1
 
-- 
2.47.3

