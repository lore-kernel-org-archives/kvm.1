Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571077;
	b=5TXodgO9PH//8D1dBzUahivze7mfgNY3uayYaQY8+P5TzBQyVTgxZjFzNJTN4TYif9TO
	 0r+afsL/UtYpN6IocXUckP+dRU16NRsLEM8I3mWAmWAZtQKayvu/ce7mO3SvR2Ho18CAw
	 HTcaMj11dg2CKWABgZ0+4X4rHLMXBVueu2REBn2lYt1Vt6R19KNpozkOczZygJVQ3KRO3
	 cS9iRQMR//9ChNpuSB+qDMwKtwCiEjw7F2lWa0ijoJRLmIPffYJ1PfstPXQ2gB9axgEhS
	 cl+Z60/vnzGoKY8pXVASobgmn0UIXBqtm7bI1r/n7G4771S94X4kkA1vY9YGkvU6QHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571077;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=MTlN2wDTHhbHrfDAoD21SnK4TCVW9Yr3QAXsVk+1Cwo=;
	b=0DopV78H8FWoGgWPVVIMpIg/+//wRb60bHaASWVkXxAZ1bbQOTzVVqhXk0VY2xH5WoCA
	 Z6yBQOhevtsrS2dxZxa6Dp3/LOYzDrE8djRHkjdU3P4V5Ff/9KPRmuyma7UKlFLGqPaYt
	 yDLnuFdD7gkMUHSEtNBW/Gp/BOOcgkc0/U3qm6ARCcMXQhfChzfPtOfIoDDrlyj7aCXDv
	 mwuvJpwscuvoTCTpj2ubpDhNLPAVECrlOnVDaHxahcaEgfDIINqcKZU5yVjXv9aAKAK/X
	 VJHeZY2SEaNNZ1FpBQVctxtqPOmG+QNfzfXOmLJdTJX5qzebbe3mJ/yBGr4my/P+NEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59B606A32D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F59B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowAAnMpN8PQZrytm8AQ--.24977S2;
	Wed, 25 Nov 2026 09:44:28 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 6/9] riscv: efi: Allow ACPI boots
Date: Wed, 25 Nov 2026 09:44:06 +0800
Message-ID: <20261125014409.79852-7-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125014409.79852-1-wangxiang@iscas.ac.cn>
References: <20261125014409.79852-1-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnMpN8PQZrytm8AQ--.24977S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1DtF18CrWxur1fAr4xJFb_yoWfArb_Cr
	Z7Aa97ZryYqFZrA3WDJrn5tF1rGws3Wr1DZF4UKF4jk34xWF1Yk3yqkr18A3Z5AFyDGrn2
	kwsrJay7Gw4kGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUhmiiUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

riscv/efi/run rejected EFI_USE_ACPI=y because CPU, timer and ISA
discovery aborted without a DT. Those paths can now walk MADT and
RHCT, so drop the early exit.

The existing runner already adds -machine acpi=off when
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

