Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F238F947
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645029; cv=none; b=LxHD95iWVROtC0Xicavif1TVQyOjGaIeVuMVWPnVgcTRMm30WocJoAy/UaxchrKo6PmKvrHqDihGhWMQfGs1BEgISVUVszDze/EzpM4jJ3R1AsQGqFJTBXlVsP9wq8DFEpB/lWKkgw4A/ltp/ZIDc8t5wRH2JCDw647Dd5Bz6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645029; c=relaxed/simple;
	bh=KpiwAfDqoXgPPNhc0GLmT1ulP4yIL9Z4yHIdZg6NdEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlcUK3mqN0I+Jw8nQI5EZkQTpJ2keO1igtClUHf/iX4+FapXyebSJZUrfZPQPBo1cdZhkRxCEK2sOO47FGPUWUADLeufQR5fv40xNrbM06onqa2oaZ2JLq2ZUW/7P3/eikBx124WMXXz79aBseVPXyE+Ay8hkQpXuruL1BuZx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKXJ/dGI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YcfDv9rp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKXJ/dGI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YcfDv9rp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTn6O3050465
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ii+NakEKXLwaKt59HrJUbtrSCVrxMYJtk4E5DyQdSG8=; b=cKXJ/dGITmTYU76g
	QK6H2QsSx0tIKzWS+1UbfDX6ErVmzta/AHyXVk2GTefp6qPAKcukvlXoAaFIGXfz
	56W6fpGRKhgWlpm9QXQD//3F6BagJWRX/5fqg30tQNR874qolvR6X4eV3ow0+RZw
	TG6dj0PEnIZZv3JYew8/2laMYaNPI9bU7Xbsag2+XwzEC088taqtc41ouFFZ0PPU
	u8N7Ut1KzEnlMgasU/Q+dptng8KYLSFGkTxbdyq9+jWt0ib2oI/lsrmGiwo1VHK6
	ryRSHnPeNx9x3jPbB+oHg2amgacWrfD0jvfhfvTO8YTnQoAao3J4YrJMD9eUDeu0
	6BJpLw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1fg3s6md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52769fc3f2eso2907841cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645026; x=1787249826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ii+NakEKXLwaKt59HrJUbtrSCVrxMYJtk4E5DyQdSG8=;
        b=YcfDv9rp3KpPnjb1diUH2vGZl7cEk3TF4gRkfivi9Rfo05XmPP6C/jX++JQa5ccm9h
         jrG2M9ahV6XR4jtGaLWbsUyuL9G/a820mPexO5qJSqpD5QV2lfLMWRDFGNm+flhyimFx
         4iMpmzoyCGDG/FaNKi/EepfP9daerzNHT4kG4GyceBFXnHgqcIFibtDR/fVSCdmd+LIJ
         B63dw5+biqYTMFGkJ1L5sP34mTOfedrZCgEMYIj9n4PgjBbfSdTBXCQHXrwkZqwuvKoz
         XwYtQQ7JhyWqFYvOH2c1QU2ppQNsiWV5brMWagR/qVnG14ZwRiqqcP2BJdVO3EOIfuhi
         gGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645026; x=1787249826;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ii+NakEKXLwaKt59HrJUbtrSCVrxMYJtk4E5DyQdSG8=;
        b=k3TOESIXqMCJQJZbuf/bM4bT6VMG3Ds1nlIPPcLYprxdydu5CW6KjZBpoD1BBrGfA2
         iNb81ITDn3MmayUQtAduZ1f03Q8uJ3m/LHF1owVzN0+kuzdG79VMFWeRIy3SiQ0jgGH2
         NyaRChy1kbMhsstFkP5kYllx/c3cQhHtihC5EADYUA6okiP311xrLaDheblg3aq8awE9
         BfFKdwOYdxHIs/VqyI3ERCt8Rhom8aamvKerdi4yAoaRuwVocI33TN5iWXU6AJ3YEgBL
         9TtBkMYg1bnMWjHI/luEZ7HimwO6CZNXi2TC5GAWCGA8B1t3BqJNwmKRGI88VyVkS/M9
         QUsg==
X-Forwarded-Encrypted: i=1; AHgh+RqvXMa7Wz2vKNeC1vtirZ9PjjAccDvyUWZodEzWD8FBXdqGrOz70K3SJ8E4k/XgsdQgMrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfhi8OPCrtny27NIJaghoegYh2QYfQU6IhdDOWTN8xpOs9Ocig
	yz7B7AelBB8ItG1YEHzfwirPfK30Phux8URfIznCxYqcdzsMFsHyFja8aN1dWa2NXV+iH17bnBv
	aibAAq1tZoe3UV3x4J/+h3JFomArfBg0KpH5BqbycAyGhIVKE+j15t6A=
X-Gm-Gg: AR+sD12KZZ7vNUjH6VUWLTjXfsNTEh8P7NWeCMCFw8T3J1gs+VksGwa2SAXtuM+/idv
	XbeF7xMaRDkZuOsBQH0M2U4cpkpHohv/TOpgaR0sI8/66zws6eARlvmJdtg+1V3DqFbkcCyUDVr
	1743PY9fkIQjhY08JPn13EfzyKev/H/9iGEdJnjG96PuGvAJzxKE53qzb6xU8DC8xiNwuW0Fanu
	xZqFA7MFotGMIgOGOJ7J2ECZPjRKBcuana7aBt0lpCqz8+R59IxMuPyN/pG64e4RL3rvrQegS8O
	HT1EjzxdTb+MgCMwxEawr3OkM40YYqTK2do0YEtrnellLInNybW/cEOXgiPwDECqHYc+1W0ZH/+
	3X/Fy1AHRCYGVf7hs7DK30hKr4ppHxIqJ05hj4F4dpw==
X-Received: by 2002:ac8:574a:0:b0:516:d699:a99b with SMTP id d75a77b69052e-52d73da2a13mr76548011cf.40.1786645026291;
        Thu, 13 Aug 2026 11:17:06 -0700 (PDT)
X-Received: by 2002:ac8:574a:0:b0:516:d699:a99b with SMTP id d75a77b69052e-52d73da2a13mr76547071cf.40.1786645025661;
        Thu, 13 Aug 2026 11:17:05 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm1270516f8f.32.2026.08.13.11.17.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
        qemu-riscv@nongnu.org, kvm@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
        Magnus Kulke <magnuskulke@linux.microsoft.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 03/16] cpus: Rename cpu_stop_current() -> qemu_cpu_stop_self()
Date: Thu, 13 Aug 2026 20:16:26 +0200
Message-ID: <20260813181640.6537-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NsfhtcdJ c=1 sm=1 tr=0 ts=6a7e0a22 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ao8Q1kDP7eBHT8PKhbAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX7ZeFToQ/aEA5
 HvNvdG7D9S0HfWD6Bzgbe2hWGd3ikxr3vDPNJhHDOKrm2CgXfQs66Asz2ZU7OB7jjIRhnhQzeyJ
 DONNOOgraG+q6PodOTXAhqdugzR2ABlaO5LjIn7Ii/Md0QEV4yGzSgwMgb1M8LKUGunJTNfPHC1
 QR+DUCXDUUBz3G+hzzRcJY0NqqbRhKgYjRL0v3t3LUOwBExlaCJHL6SFyT16YjB5d87rT0JQLHe
 6DtSVn7jwvP2Onw58QPYfKrbNOTppuEMnc5bbl3Ium3pUWT5ilAHhOyenviyV/KpaF/+SjCOP2K
 2vKmieTHXIwOveMqZugdmQTANZ64HIpo2wl3WA91eFlJXXhEcSB5o2waYVxHv5JWlLdl3Rh9BWY
 R2bgQN03I7ORFxV8BnOe9ViiWBRiAvGFq4TUQbQ9/jsoV2FjCdxUdiayNl0OOYU0tgW8SSCvzJu
 /n6WvtwnbcT0Ic9bnUA==
X-Proofpoint-ORIG-GUID: hPboZ5CGqVXwhtWYY1EekFuTZcqg52jq
X-Proofpoint-GUID: hPboZ5CGqVXwhtWYY1EekFuTZcqg52jq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9+O+Ok5liR+9
 BCglYRRoH3CmDt5YuShY1cq1ZQAasz7LaFuBNnh69DUGfWGQt/t8AUtsuBITlBvr+/wp5iYbFOI
 dDY4nqqPZ9Yhxqbogu+/Ej7GQzjTegs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130132

There is a single method with ending with _current() suffix.
Align with qemu_cpu_kick_self() and pthread conventions by
renaming cpu_stop_current() -> qemu_cpu_stop_self() for
consistency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/cpus.h | 8 +++++++-
 hw/ppc/spapr_rtas.c   | 2 +-
 system/cpus.c         | 2 +-
 system/runstate.c     | 6 +++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/system/cpus.h b/include/system/cpus.h
index ade13e068eb..2365c7c4597 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -28,7 +28,13 @@ bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
 void pause_all_vcpus(void);
-void cpu_stop_current(void);
+
+/**
+ * qemu_cpu_stop_self - Stop execution of the current vCPU
+ *
+ * Note: No effect if not executing within a vCPU thread.
+ */
+void qemu_cpu_stop_self(void);
 
 /**
  * qemu_cpu_kick_self - Force vCPU to re-enter to its inner main loop
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 328fc27c400..80cd4246af8 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -93,7 +93,7 @@ static void rtas_power_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return;
     }
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    cpu_stop_current();
+    qemu_cpu_stop_self();
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index f37e215c586..1a6fd286a81 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -674,7 +674,7 @@ void qemu_init_vcpu(CPUState *cpu)
     }
 }
 
-void cpu_stop_current(void)
+void qemu_cpu_stop_self(void)
 {
     if (current_cpu) {
         current_cpu->stop = true;
diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b625..1302fea9ccd 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -472,7 +472,7 @@ int vm_stop(RunState state)
          * FIXME: should not return to device code in case
          * vm_stop() has been requested.
          */
-        cpu_stop_current();
+        qemu_cpu_stop_self();
         return 0;
     }
 
@@ -900,7 +900,7 @@ void qemu_system_reset_request(ShutdownCause reason)
     } else {
         reset_requested = reason;
     }
-    cpu_stop_current();
+    qemu_cpu_stop_self();
     qemu_notify_event();
 }
 
@@ -918,7 +918,7 @@ void qemu_system_suspend_request(void)
         return;
     }
     suspend_requested = 1;
-    cpu_stop_current();
+    qemu_cpu_stop_self();
     qemu_notify_event();
 }
 
-- 
2.53.0

