Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263487;
	b=UoRW7wLh9ET2WoFRD8LPOj8ueNf3kO4WzJ627WToOGdoF0EltxfT1fpLJWEZJZtgadTu
	 Vz2fCut+VfxUdlZNHAdUL9fqxNcOwrqxOUkbQrWPDnonM02mYWRcDykQGDwjgqUvnFdga
	 6vFfmKQDPCFDL76cLK8evTN/WbQSMeV/ZZPIG58G2hq4/RQxVMCXUa3WSm7umODEziUgn
	 gWc/J5awMisdZt85Rwqy1Dd/V3siYa8FdiSaBpuLnEal819vUM3L7L9C9g0yNv/DJ5vQR
	 S1s1dRiYPySROZnA+NwQsHHJFoo1BwBwuJXlHRwIXDiJfSQoWe9z+jIf4ayOZV9cotQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e6cGpCW9ua2cMf+lJeF3kZN84gK1Yf677YZr+Kh5B/8=;
	b=l63isqJjT3TfXWni5RDQiYXTkoadQyTDtlReV/ygDChdkTqul6eCFQaTveFYsEe2zgi0
	 PS9WAkLwKefhFIOe11etdG9vpJpU48iN1Tln2Zi7qGGDu86eso2Ec2/ThnIpxKAwPVN14
	 dEhZiRQc0THNo5h4RE7S+M5pfE3ZTO2XmuxjXWhULa9cFEmxwXlyBDHiRtT7CZZr8Dohw
	 mFw+JsWoz6DARQtDwjVrvMostw8NTEQEOYgQRbgVKpW03cU3+KLCzIM1XBR7uCd9IFutP
	 sGBHlR5ne/13xPsCq67ajhnFaVUGqj+1SX2DehapemNzLRTaMz7XT4CBuzrcnwgoU7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ydydYa49;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74347606A335
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74347606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ydydYa49
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so629267b3a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263487; x=1794868287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6cGpCW9ua2cMf+lJeF3kZN84gK1Yf677YZr+Kh5B/8=;
        b=ydydYa49Sg3kFTE4nNaNw9SLcL+mB3Yc0SgSW+wW7/YRYSOXVTpJOwos7hSaILoHXq
         llhoWZRmYdzRSLo2Njt62blIMRNGTs0KvUdaOVDulXS4oi0fNjf7HgFhZ/lzAjnkXmP8
         C9C/CpHHbD8nKZ3jGlGpMgdSyE2bPNLWo5ndw1PbvM5fwrKPTOleUwEcsL3c0ap79so2
         Yn+cfUvlLleprQHzoN++Em02hoCgkai/uKpFQTkrjPH5Ojg1T5Fb6E3y3cMvrSLjUNGs
         Ys/AjYMQ7OHi1O9Nvh6SWW4pqap4vLB/sTP9rq9znSvhrYArjoQq1xZkrBkFTeVTs1F9
         dYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263487; x=1794868287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6cGpCW9ua2cMf+lJeF3kZN84gK1Yf677YZr+Kh5B/8=;
        b=kqD7XQT20NqFTgXP2gCyJnlrJHcgPikRoRbIjBTDo2vMHyHNrFy9/sKaKDlzPfWIkI
         RnI48mecSjE4FhhKIdz3/euMX5cZwGkUkDJcM09J/oO6FxNcrodn6X/6xGU2Ivu9REkv
         K8WFafQca7IGKzJvG+/taC4QbYMsVmFFNfaU8U6x7BMKXulor9t9hXbafQ5MBX8ljuVH
         Q6InX7ht9hAg7hIgUgOFFazg4XFQwKFhOtKg2TPcHYXOdVPia9VMFsF+CDSfi/dHFBKT
         zoTt27QcGtHdneS9LEkc+0brCNWILrwymjueEjWWhgiNftJ3gYWBEzp4Ow+2w+yICgeI
         pQZA==
X-Forwarded-Encrypted: i=1; AL+hErHu+LJvEexi9Zybcg5NurTp2P4g/CYP/EnF39V85jiUxGjplhd0NH9C20X1dtVdeEzMTAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hiuS0SIWZ8oLUpgtak4yPPaOZXqbnwGq5mXAzxsKMmSSo3BMr
	zbPZmLUcZaHuoc2v6g6YQY8yrq5PV+/T6vqkUE4YfjnEnpiCAvAET5cXvTejiSNIwxo=
X-Gm-Gg: AYBFou1iq16k0RZzJ8ORHB5C42wPM7ij5OtBabfiyJ4EhT3Fi9d92GoIQcVDz8kyDNZ
	YtuLhtdGFTEO8SDeDcM4SmQCqWkAubAbje5vOLmiVONDI8JJ+Xjp0vtLe+vZZJp1CSFdSicf+HL
	/t27uq85UtXEJ6PRAgTwAIisOEhl1HSAknqScrO8Uk4NI/vpiePT4klpJuUslVgEyOSldFkC39w
	1/j2KDqvLtoNn/wKZI1CbrgkBYzCu8Ib/ZssVUhPFQhrrKFbyByrbc/1rny5An+JQnPsLJOQf8H
	NhwpLSLPmJiP1wEhT+QuH41dIWLYEjLY/DA9HLJw2BAZglaxGhQm1vE21BXMuBWIY2Maqvi/as4
	ZHO7jUYuL7DDhtSRJFeThyupa1RnC3hAzjXUP8qiT2CB8RRahJ/0HQLAwI8kRdSmvUdKyWavlda
	m2fIFekZr0ydlXmKNhZR55PnSrq0BoX/2g1EYcqKiawg1ObWtVLlp0mB5giq2IS8Xj75aHylTVf
	ze4OwBPRgLPTDh2FGkpaXjPyXprrEyXbd/ApsSl9d/HXW7UUuIjfm4LqJqeoiXmEUKPTVn2olyT
	k4zRdqSWtOh1k/8LLFNSsKcxJuE3u82SVZomRsUpu7uohb4naAJBiXyQUijZmHwZIIgd6Mmq7s8
	=
X-Received: by 2002:a05:6a00:a226:b0:89c:d875:603c with SMTP id d2e1a72fcca58-8ba882e23b8mr929126b3a.53.1794263486735;
        Mon, 09 Nov 2026 14:31:26 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:25 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 06/23] target/arm/kvm: Create scratch Realm VM when requested
Date: Mon,  9 Nov 2026 16:30:53 -0600
Message-ID: <20261109223110.1619504-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 30
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 941951a9bc05..63a3e78efd53 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -110,6 +110,8 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init, Error **errp)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
     int max_vm_pa_size;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
@@ -122,7 +124,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
         max_vm_pa_size = 0;
     }
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         error_setg_errno(errp, errno, "Failed to create the scratch VM");
-- 
2.53.0

